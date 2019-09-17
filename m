Return-Path: <SRS0=ES4k=XM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37A81C4CECD
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 13:41:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03F57206C2
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 13:41:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="spKgCqR+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03F57206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46238 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iADjr-0003Tj-5v
	for qemu-devel@archiver.kernel.org; Tue, 17 Sep 2019 09:41:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46419)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1iADiz-0002uj-LZ
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 09:40:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1iADix-0007pZ-38
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 09:40:56 -0400
Received: from mail-eopbgr70107.outbound.protection.outlook.com
 ([40.107.7.107]:2879 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1iADiw-0007oy-He; Tue, 17 Sep 2019 09:40:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P+8wVcNr2b9Il2uMQEkUjQsTfRd5NvuM64yx3OadJ77u56vRkxZmehOY0EU1wE3NVViLTQo5+1OwcMl29EadsCYtsXFYpCJ20B1r/QtA7OfafzQXj3hbtFE74aQwpWEVKNN7vyx3xBaFAQKTmSkxlVffgTntBSOaLUB4ngsToqW5AYNCTUzRrfjKuDx0/TyJCOaBDOts3c94Mw0YJSJGvGtE6J8A2rnmsfaEBIOg6e8ba/sflKDOCMoQwjMFtUb0JyMbzRlPpw6wAxtww2W6svgeTkaGJI++ITd/UA2NCHexN81B7Oaspdot+6paLE23sno5qnj363PdsBZqWGE9pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=40MSxZEK5se1lB5VRfxFrDp0g9rjs+MM3P5fxQiRQQA=;
 b=FBQhTai4z5vzHWek29CJLL4VNkRf6UKmoqN9q0EeIqIYr1c2S5NRdqcENZI8z9+JkRQwv10Vz9+btgqkaxVcr0+tH4667wgnSzwlSDfEociy+mMBgZVMre8clwv4bVdG6Sv9o7z1ap0GmesoVkQby9nT0rn2cRqDr6a3bONlQmc3nixWPp1w/JaLo7ygw6uIP8nqW3ntkyjTRIHXH7ztGHY27SAVmj3NHXgF1yZzh0w/DTp4FW7go5QbfnznZIesQzs2sznqVJFBNUgzaVC1PDaMeXq1QfeNlpwGmrVv2Mct7a131mAbd7bZS6u7vwABRgYdXg7ZCvg3HuPFujTLPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=40MSxZEK5se1lB5VRfxFrDp0g9rjs+MM3P5fxQiRQQA=;
 b=spKgCqR+0OX+6dwYkgQ5SfoiJCSQ4cKOohws82Zv+Hy5R+DkyLvWgiVurRBc+sg02kP93Np6tYNNGbnw/ymK51B9X+2d9PTQQ0UCIkELkr3yp67zNz8zq0Larrb7NmPxuyoEj7SGv3s01Ou8/gqR9Idof2LodSMgyOK0fBkjWsI=
Received: from HE1PR0802MB2460.eurprd08.prod.outlook.com (10.175.33.138) by
 HE1PR0802MB2506.eurprd08.prod.outlook.com (10.175.30.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.26; Tue, 17 Sep 2019 13:40:51 +0000
Received: from HE1PR0802MB2460.eurprd08.prod.outlook.com
 ([fe80::4d31:70d0:5b10:7a10]) by HE1PR0802MB2460.eurprd08.prod.outlook.com
 ([fe80::4d31:70d0:5b10:7a10%6]) with mapi id 15.20.2263.023; Tue, 17 Sep 2019
 13:40:51 +0000
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Thread-Topic: [PATCH v4 4/7] iotests: Let skip_if_unsupported accept a function
Thread-Index: AQHVbTkoLqCiXkk/GUuvCFlY5O79Kqcv4JWA
Date: Tue, 17 Sep 2019 13:40:50 +0000
Message-ID: <4df4e799-fdef-6572-354b-c5a8d75668da@virtuozzo.com>
References: <20190917092004.999-1-mreitz@redhat.com>
 <20190917092004.999-5-mreitz@redhat.com>
In-Reply-To: <20190917092004.999-5-mreitz@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0377.eurprd05.prod.outlook.com
 (2603:10a6:7:94::36) To HE1PR0802MB2460.eurprd08.prod.outlook.com
 (2603:10a6:3:dd::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=andrey.shinkevich@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5f0e29c5-d2ca-4742-d450-08d73b74a770
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:HE1PR0802MB2506; 
x-ms-traffictypediagnostic: HE1PR0802MB2506:
x-microsoft-antispam-prvs: <HE1PR0802MB25060A126CE216709EA6B4DDF48F0@HE1PR0802MB2506.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1107;
x-forefront-prvs: 01630974C0
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(376002)(366004)(346002)(39840400004)(136003)(396003)(199004)(189003)(229853002)(52116002)(3846002)(14454004)(6116002)(54906003)(71200400001)(486006)(11346002)(446003)(71190400001)(44832011)(110136005)(4326008)(2616005)(316002)(305945005)(7736002)(256004)(8676002)(476003)(8936002)(478600001)(25786009)(81156014)(81166006)(6506007)(76176011)(186003)(102836004)(86362001)(99286004)(386003)(66066001)(53546011)(36756003)(31696002)(66556008)(26005)(6486002)(5660300002)(64756008)(66476007)(66946007)(2501003)(31686004)(6246003)(2906002)(66446008)(6512007)(6436002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:HE1PR0802MB2506;
 H:HE1PR0802MB2460.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: xQyJj9Zs7C8swjSSbDd2+XrNHmzUlK031kXxhc6qYvT2vNeXaY5YBEZoyREBTStejLKhlawCwMAYFEx4uHbVT13HCaKFYI/xMgpx8kLRVsed93N71SEEOM2ufQBv03R6N2iGqIZqudzf6TJigfcnxgwTMR1CyDWdj7rPKiMAxsAnYwi7YPzkJKG3Pszr/aw8+45aHay1lOVQwkCI+yURuSVw7iH5hhzXl72So6SHg1QkDKn3J7yTLuYUVlfK8fYcicyP31VVu0ung86IrApm3laP0hzThL3JGk4EfwyDWscBilOylOHJxmTRO8p9eYAjto8ETdHe47mlC/+6iq2jECBOwsaB95C9oyTXm6hVaz1ILwaZOkajMDUYjfakq4y3uUW8ScWYjxcd6WEdCjqYamNrF91c34kYt73Pp1DzM+E=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <DD128D30D1FDDA488C3A2B1568863235@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f0e29c5-d2ca-4742-d450-08d73b74a770
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2019 13:40:50.9318 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FEiVeyU7FOGgSMe6G8sGJrgbeasTNJ+wkwqiFt6ogps9fG0ShcXujPL3GAIWeMPizL6HUP5IDxTGVizSUEWoAS97z7x37S5XzFxH4MjseIA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0802MB2506
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.7.107
Subject: Re: [Qemu-devel] [PATCH v4 4/7] iotests: Let skip_if_unsupported
 accept a function
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Kevin Wolf <kwolf@redhat.com>, Thomas Huth <thuth@redhat.com>,
 John Snow <jsnow@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQoNCk9uIDE3LzA5LzIwMTkgMTI6MjAsIE1heCBSZWl0eiB3cm90ZToNCj4gVGhpcyBsZXRzIHRl
c3RzIHVzZSBza2lwX2lmX3Vuc3VwcG9ydGVkKCkgd2l0aCBhIHBvdGVudGlhbGx5IHZhcmlhYmxl
DQo+IGxpc3Qgb2YgcmVxdWlyZWQgZm9ybWF0cy4NCj4gDQo+IFN1Z2dlc3RlZC1ieTogS2V2aW4g
V29sZiA8a3dvbGZAcmVkaGF0LmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogTWF4IFJlaXR6IDxtcmVp
dHpAcmVkaGF0LmNvbT4NCj4gLS0tDQo+ICAgdGVzdHMvcWVtdS1pb3Rlc3RzL2lvdGVzdHMucHkg
fCA4ICsrKysrKy0tDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKSwgMiBkZWxl
dGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS90ZXN0cy9xZW11LWlvdGVzdHMvaW90ZXN0cy5w
eSBiL3Rlc3RzL3FlbXUtaW90ZXN0cy9pb3Rlc3RzLnB5DQo+IGluZGV4IDQyN2MzNDY5N2EuLmE0
MjcwMmI2YjkgMTAwNjQ0DQo+IC0tLSBhL3Rlc3RzL3FlbXUtaW90ZXN0cy9pb3Rlc3RzLnB5DQo+
ICsrKyBiL3Rlc3RzL3FlbXUtaW90ZXN0cy9pb3Rlc3RzLnB5DQo+IEBAIC04OTQsOCArODk0LDEy
IEBAIGRlZiBza2lwX2lmX3Vuc3VwcG9ydGVkKHJlcXVpcmVkX2Zvcm1hdHM9W10sIHJlYWRfb25s
eT1GYWxzZSk6DQo+ICAgICAgICAgIFJ1bnMgdGhlIHRlc3QgaWYgYWxsIHRoZSByZXF1aXJlZCBm
b3JtYXRzIGFyZSB3aGl0ZWxpc3RlZCcnJw0KPiAgICAgICBkZWYgc2tpcF90ZXN0X2RlY29yYXRv
cihmdW5jKToNCj4gICAgICAgICAgIGRlZiBmdW5jX3dyYXBwZXIodGVzdF9jYXNlOiBRTVBUZXN0
Q2FzZSwgKmFyZ3MsICoqa3dhcmdzKToNCj4gLSAgICAgICAgICAgIHVzZl9saXN0ID0gbGlzdChz
ZXQocmVxdWlyZWRfZm9ybWF0cykgLQ0KPiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgIHNl
dChzdXBwb3J0ZWRfZm9ybWF0cyhyZWFkX29ubHkpKSkNCj4gKyAgICAgICAgICAgIGlmIGNhbGxh
YmxlKHJlcXVpcmVkX2Zvcm1hdHMpOg0KPiArICAgICAgICAgICAgICAgIGZtdHMgPSByZXF1aXJl
ZF9mb3JtYXRzKHRlc3RfY2FzZSkNCj4gKyAgICAgICAgICAgIGVsc2U6DQo+ICsgICAgICAgICAg
ICAgICAgZm10cyA9IHJlcXVpcmVkX2Zvcm1hdHMNCj4gKw0KPiArICAgICAgICAgICAgdXNmX2xp
c3QgPSBsaXN0KHNldChmbXRzKSAtIHNldChzdXBwb3J0ZWRfZm9ybWF0cyhyZWFkX29ubHkpKSkN
Cj4gICAgICAgICAgICAgICBpZiB1c2ZfbGlzdDoNCj4gICAgICAgICAgICAgICAgICAgdGVzdF9j
YXNlLmNhc2Vfc2tpcCgne306IGZvcm1hdHMge30gYXJlIG5vdCB3aGl0ZWxpc3RlZCcuZm9ybWF0
KA0KPiAgICAgICAgICAgICAgICAgICAgICAgdGVzdF9jYXNlLCB1c2ZfbGlzdCkpDQo+IA0KDQpS
ZXZpZXdlZC1ieTogQW5kcmV5IFNoaW5rZXZpY2ggPGFuZHJleS5zaGlua2V2aWNoQHZpcnR1b3p6
by5jb20+DQotLSANCldpdGggdGhlIGJlc3QgcmVnYXJkcywNCkFuZHJleSBTaGlua2V2aWNoDQo=

