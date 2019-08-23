Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2809C3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 15:40:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF75221019
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 15:40:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="j0bKzGSj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF75221019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58408 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i1Bfe-00017g-Vf
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 11:40:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60382)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1i1BT7-0004kK-H5
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 11:27:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1i1BT6-00019e-Gm
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 11:27:13 -0400
Received: from mail-he1eur04on0726.outbound.protection.outlook.com
 ([2a01:111:f400:fe0d::726]:32482
 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1i1BT2-00016T-8y; Fri, 23 Aug 2019 11:27:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LyZHploWwE21wtYhVeN++BIlo9dWW3iiD4awhX1v3pUj5W7seDBAJe33s4NhVgU0xkpXoma6zBnmfrsDXUdF3A9OYzEO1DuNVG1d7DKNbFWeuLsQtajPJAimVopDlKmq6npo+OzTxokdXaGVTHyI0Mv7HzaITbn11RFhZmCCa9oiP1AAFE5FhLukgeYhA2wvWrnzKLeJS0ov450L4v9uaLum4r5tLX0/VS/cTyRZI5pl99lGw+/wBNf+34/eQGvyhiHX7TWa9UVyAhR+lILw4UFzfZmUZg+s2YyDl0w1qjoNsgVOydxeDIwaiF92h+uRc5b189iG5JvGXOlGJjKuAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tYkY68lqyR/r1XGJEoNtHR8eTUErUTiXKOH9pl2B+xo=;
 b=WoPN0dJpHRQAbgYzt8w1TDRDE+TFdcRgWmyJPGmepWOD/F5c1rQwtaytmMIH62aphkPOmCFA/EQXvfuYu/AISEC6MLPMpPL9s3w5P6UUq7N6V2qYT+3Y2t96+qhjMDOrp9jCfAI+pq1rVS5nvL7KS7U5ewro/nS/HWS+hRE9wSmY4ts5zMducHcF7+soiZfB+FqUdjs1rdXzz4mQYY8LsHpE6Z9bcIx9T40m4ub+JKEIoOQElyneGn8sT/4a/7dJjXUbMdqbelrdmvoHvAjN5Hd9h8uJdETF1gl+lS5KEv5iBlgVkLhHajm9rnuLjrWtpzk78hc0NqZT3fERwqXgWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tYkY68lqyR/r1XGJEoNtHR8eTUErUTiXKOH9pl2B+xo=;
 b=j0bKzGSjGoztVrw0X9iJbpliq3OdHEpLsAgBKfBYpXXMPFy6jY8VGwUjiHyMEp2lHflkOPbiZEbUcqtXKBl2bvijKIcxFbL7qZBOR8hxxgN6H9lz9dSdh84D/sVuovnbFmR0CM95Funda6ak/+WBpi7q/g0VfDFCLQXrRZaBbB4=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB5292.eurprd08.prod.outlook.com (20.179.9.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.19; Fri, 23 Aug 2019 15:27:03 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604%3]) with mapi id 15.20.2178.020; Fri, 23 Aug 2019
 15:27:03 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: John Snow <jsnow@redhat.com>, Andrey Shinkevich
 <andrey.shinkevich@virtuozzo.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Thread-Topic: [Qemu-block] [PATCH v5 6/6] iotests: extend sleeping time under
 Valgrind
Thread-Index: AQHVPk9LveScVc/Z7EmDHfo0Qv+KgKb9H8GAgAvyC4A=
Date: Fri, 23 Aug 2019 15:27:03 +0000
Message-ID: <350a5dee-7bc7-cfa0-e5b4-0c0f2202d119@virtuozzo.com>
References: <1563553816-148827-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1563553816-148827-7-git-send-email-andrey.shinkevich@virtuozzo.com>
 <083ece64-0178-fe4a-45df-331257a115fb@redhat.com>
In-Reply-To: <083ece64-0178-fe4a-45df-331257a115fb@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR1001CA0014.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:3:f7::24) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190823182701093
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3092b88a-181f-409e-bfd4-08d727de5973
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600166)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);
 SRVR:DB8PR08MB5292; 
x-ms-traffictypediagnostic: DB8PR08MB5292:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR08MB52926B6C823E94A781D95A31C1A40@DB8PR08MB5292.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:139;
x-forefront-prvs: 0138CD935C
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(136003)(39850400004)(376002)(346002)(366004)(199004)(189003)(25786009)(81156014)(2906002)(107886003)(31696002)(6512007)(6486002)(478600001)(14454004)(316002)(53936002)(86362001)(6436002)(2501003)(71190400001)(110136005)(6246003)(54906003)(2201001)(71200400001)(66066001)(26005)(6506007)(386003)(53546011)(8936002)(102836004)(186003)(476003)(31686004)(6116002)(5660300002)(2616005)(3846002)(66556008)(64756008)(11346002)(446003)(66446008)(305945005)(7736002)(256004)(4326008)(36756003)(14444005)(99286004)(8676002)(486006)(229853002)(52116002)(66476007)(81166006)(76176011)(66946007);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB5292;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: cnjy3agJ1z8ZiqrOj0bMdFBhs1WOkhyEtSbAFGoeAcVNSITZbt3D6Q2WfV++Z5SxsnDGikbRGXA1XYD/6G2WroKrrFDCSwm/vAsNOPIwIetan40dmYpLcWejDvXJqmDq00Is31PIY8VnzurW0CSjP6KqMeg3g1RoPsoXMRNU61XXsoUXHCKI0wFPPW0tVKsSmUXuKx4agH02VYQvp7y2DmqLyV33RUXanforPLH1bDezgscTiatqJbtwAEUWeOrB+X7ZQCKmQKu+C52CkGSOOKDuNy/39q8B5VNONGiWyM6aaWFDCqK34dfHZWB1UwEGivk5gjw4eQ4Bc4qHnyhWQnHxVbZnUwfPtCBDJ7AKyqCGlf/AtaOc81fGURzYLEqBzonR83nXmSJtjLwtNrTxUUdzP5i/TkJCdz5HQ7i4tz8=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D9A986C58E362847988A094029D4E767@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3092b88a-181f-409e-bfd4-08d727de5973
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2019 15:27:03.4946 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pgxkMnDSi928IMcufn3Imt3xOUdlJYf1AY5EGbsi9b1WLyx81u9UkQ85zVm7IwNoViGBFK6gcR2V3RlAdWOkXEuUjln3LhoD8hzKqQIrCuU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5292
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:fe0d::726
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v5 6/6] iotests: extend
 sleeping time under Valgrind
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>, Denis Lunev <den@virtuozzo.com>,
 "mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MTYuMDguMjAxOSA0OjAxLCBKb2huIFNub3cgd3JvdGU6DQo+IA0KPiANCj4gT24gNy8xOS8xOSAx
MjozMCBQTSwgQW5kcmV5IFNoaW5rZXZpY2ggd3JvdGU6DQo+PiBUbyBzeW5jaHJvbml6ZSB0aGUg
dGltZSB3aGVuIFFFTVUgaXMgcnVubmluZyBsb25nZXIgdW5kZXIgdGhlIFZhbGdyaW5kLA0KPj4g
aW5jcmVhc2UgdGhlIHNsZWVwaW5nIHRpbWUgaW4gdGhlIHRlc3QgMjQ3Lg0KPj4NCj4+IFNpZ25l
ZC1vZmYtYnk6IEFuZHJleSBTaGlua2V2aWNoIDxhbmRyZXkuc2hpbmtldmljaEB2aXJ0dW96em8u
Y29tPg0KPj4gUmV2aWV3ZWQtYnk6IFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkgPHZzZW1l
bnRzb3ZAdmlydHVvenpvLmNvbT4NCj4+IC0tLQ0KPj4gICB0ZXN0cy9xZW11LWlvdGVzdHMvMjQ3
IHwgNiArKysrKy0NCj4+ICAgMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgMSBkZWxl
dGlvbigtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS90ZXN0cy9xZW11LWlvdGVzdHMvMjQ3IGIvdGVz
dHMvcWVtdS1pb3Rlc3RzLzI0Nw0KPj4gaW5kZXggNTQ2YTc5NC4uYzg1M2I3MyAxMDA3NTUNCj4+
IC0tLSBhL3Rlc3RzL3FlbXUtaW90ZXN0cy8yNDcNCj4+ICsrKyBiL3Rlc3RzL3FlbXUtaW90ZXN0
cy8yNDcNCj4+IEBAIC01Nyw3ICs1NywxMSBAQCBURVNUX0lNRz0iJFRFU1RfSU1HLjQiIF9tYWtl
X3Rlc3RfaW1nICRzaXplDQo+PiAgIHsiZXhlY3V0ZSI6ImJsb2NrLWNvbW1pdCIsDQo+PiAgICAi
YXJndW1lbnRzIjp7ImRldmljZSI6ImZvcm1hdC00IiwgInRvcC1ub2RlIjogImZvcm1hdC0yIiwg
ImJhc2Utbm9kZSI6ImZvcm1hdC0wIiwgImpvYi1pZCI6ImpvYjAifX0NCj4+ICAgRU9GDQo+PiAt
c2xlZXAgMQ0KPj4gK2lmIFsgIiR7VkFMR1JJTkRfUUVNVX0iID09ICJ5IiBdOyB0aGVuDQo+PiAr
ICAgIHNsZWVwIDEwDQo+PiArZWxzZQ0KPj4gKyAgICBzbGVlcCAxDQo+PiArZmkNCj4+ICAgZWNo
byAneyJleGVjdXRlIjoicXVpdCJ9Jw0KPj4gICApIHwgJFFFTVUgLXFtcCBzdGRpbyAtbm9ncmFw
aGljIC1ub2RlZmF1bHRzIFwNCj4+ICAgICAgIC1ibG9ja2RldiBmaWxlLG5vZGUtbmFtZT1maWxl
LTAsZmlsZW5hbWU9JFRFU1RfSU1HLjAsYXV0by1yZWFkLW9ubHk9b24gXA0KPj4NCj4gDQo+IFRo
aXMgbWFrZXMgbWUgbmVydm91cywgdGhvdWdoLiBXb24ndCB0aGlzIHJhY2UgdGVycmlibHk/IChX
YWl0LCB3aHkNCj4gZG9lc24ndCBpdCByYWNlIGFscmVhZHk/KQ0KPiANCg0KSG1tLCBob3dldmVy
IGl0IHdvcmtzIHNvbWVob3cuIEknbSBhZnJhaWQgdGhhdCBldmVyeXRoaW5nIHdpdGggInNsZWVw
IiBpcyBkZWZpbml0ZWx5IHJhY3kuLg0KT3Igd2hhdCBkbyB5b3UgbWVhbj8NCg0KLS0gDQpCZXN0
IHJlZ2FyZHMsDQpWbGFkaW1pcg0K

