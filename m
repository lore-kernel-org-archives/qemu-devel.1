Return-Path: <SRS0=TBk9=V5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDBE5C433FF
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 15:41:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 871C12087E
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 15:41:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="SCPd91pW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 871C12087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56928 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htDD6-0004iE-Nt
	for qemu-devel@archiver.kernel.org; Thu, 01 Aug 2019 11:41:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40257)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1htD9N-00038p-72
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 11:37:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1htD9K-0004Y8-25
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 11:37:51 -0400
Received: from mail-eopbgr00129.outbound.protection.outlook.com
 ([40.107.0.129]:9860 helo=EUR02-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1htD9I-0004Wm-2O; Thu, 01 Aug 2019 11:37:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lqvyUCs0ZubWu5i3jZq+ElVfW6C96/OEvBPAQYGzuhPOv0Wm0PTWQVhEyuvtPTNHponxIEdXZ5ojP2CDlf6aykgkrbM0xxtW7sXGbvqpG1b6dh+8QpLHSrLtLRCiw5+xxfDOQEyLv0R0Tpu/KdhjTf3hOig96wfytjv/G2ENi+hdaRaY576gAACNQuDjq81oQH5aqtHcj70CfQGyA4KECYoDwpag0HE4xThUi6DKGhV9aIXsHbTOmBs3+DilmanWJ1hsusx5extd5melMsIK4anIsGDEytT4jPaoSUsT7Slov9b2yqTtJz2osQRKstNGWLUG+2th8BTadzP1z9L+SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iKuYEMIFtOo2D78NZc61iuSwcRfTCiyXICR12SRaxC0=;
 b=fV8b0CEm0Neaa+afcW9RXJxnfL0ohnjCUqnjMM9xGTkLtIcUrj/eM47znyZHxu5DqZE3wMeirAkxzEeVccVq/dpxmhNniNU36x/06jpXaUsaCZr5cqH3+E1PZUYFzLVCuxKtPhcSoJdpD7eWoWQ5VKP4z/RF+7LO/s/izksDhhd7zT7zDv+tJGIdSztcJgKVDeIGZcjh/ONM8ISGafb+teGet/DDtuHjGOmoVmsU3OTRS+TmpQLWjzyIK0664vAvvjXEZbvq+SfiWbqhwNQ6hwB7vRqfnLVhS8jFj4doOjIY1m1xWDZsCe8ImUtUll/iQuRp6ni+VWMChrOVB41a/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=virtuozzo.com;dmarc=pass action=none
 header.from=virtuozzo.com;dkim=pass header.d=virtuozzo.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iKuYEMIFtOo2D78NZc61iuSwcRfTCiyXICR12SRaxC0=;
 b=SCPd91pWUKQqQgkAlpfsPxFrejLTlfTB4G+x+yvrME6pDKVbv9IhXgHYs3jOippcGbXfe+bdVI4oQ5qH1bqmfR5X/IbfTWVEb8amSP+e36miOMqtsctu/HuW95ygPBbcKyWdxo3nTGbfvt05s1sbjSCWfVYM0xbSX+YzQU/wx+Y=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB4092.eurprd08.prod.outlook.com (20.179.9.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.14; Thu, 1 Aug 2019 15:37:45 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604%3]) with mapi id 15.20.2136.010; Thu, 1 Aug 2019
 15:37:45 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Thread-Topic: [PATCH for-4.1 1/2] backup: Copy only dirty areas
Thread-Index: AQHVSHuRvvN3o1T8TkaPwx8c10b+2abmbSYA
Date: Thu, 1 Aug 2019 15:37:44 +0000
Message-ID: <49631353-3451-7f49-a5df-a986d7c8d26c@virtuozzo.com>
References: <20190801151235.8434-1-mreitz@redhat.com>
 <20190801151235.8434-2-mreitz@redhat.com>
In-Reply-To: <20190801151235.8434-2-mreitz@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1P18901CA0009.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:3:8b::19) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190801183742610
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7dc1b561-b494-49c8-11b3-08d7169632be
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DB8PR08MB4092; 
x-ms-traffictypediagnostic: DB8PR08MB4092:
x-microsoft-antispam-prvs: <DB8PR08MB4092BBCC707F3DCCCBD44720C1DE0@DB8PR08MB4092.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 01165471DB
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(376002)(366004)(136003)(346002)(39850400004)(396003)(199004)(189003)(52314003)(6512007)(81156014)(8936002)(4326008)(71200400001)(81166006)(446003)(71190400001)(8676002)(66066001)(66556008)(386003)(186003)(110136005)(316002)(229853002)(6506007)(2616005)(486006)(52116002)(102836004)(476003)(11346002)(25786009)(76176011)(305945005)(7736002)(36756003)(2906002)(54906003)(14444005)(256004)(66946007)(66476007)(99286004)(26005)(478600001)(6486002)(64756008)(66446008)(31696002)(86362001)(6436002)(6116002)(3846002)(5660300002)(6246003)(31686004)(14454004)(2501003)(53936002)(68736007)(14143004);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB4092;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: VOHHINWwR+oPyyXsGpAy+Q7RSFAfM3M0O7vJyuPWSgVvLd2Tbdj8KXfPClfgun8exAmphWWLxcLY4XmlWC2ZJdtjiQQbgQfTrt8uybLEa6V1QPK+H5ugVN60aL4WCic51XaVGNCeyqzLKhQuWvQiNTzTqaEDbcp3D3C4OcNZ+9SAwXH4AYf3UPylR5tCNYUKLeu21ViAo4LZSQ5f/GENBCpE4SUvNYaT459gzzSusxZU2093siqqNK6RMptL/MXcjAkWtjW7b5INFog6t2lydSgBCtYTLYfOCltmXU1wwKxTilBOPJvC0fkAwQoHsGo193vyWyBq3OM+ZsRZqeEkhejLeXzA793mS4G1dhF6LDXP1K0ATRYIyCk88j9zkT6svGmjpYSYVD/TFOQD1K/UPb/BLjVbTDgKPG2ERgOX5p0=
Content-Type: text/plain; charset="utf-8"
Content-ID: <548F455D1EB32B49A2024384D181AA6A@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dc1b561-b494-49c8-11b3-08d7169632be
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2019 15:37:44.9207 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vsementsov@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB4092
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.0.129
Subject: Re: [Qemu-devel] [PATCH for-4.1 1/2] backup: Copy only dirty areas
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
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MDEuMDguMjAxOSAxODoxMiwgTWF4IFJlaXR6IHdyb3RlOg0KPiBUaGUgYmFja3VwIGpvYiBtdXN0
IG9ubHkgY29weSBhcmVhcyB0aGF0IHRoZSBjb3B5X2JpdG1hcCByZXBvcnRzIGFzDQo+IGRpcnR5
LiAgVGhpcyBpcyBhbHdheXMgdGhlIGNhc2Ugd2hlbiB1c2luZyB0cmFkaXRpb25hbCBub24tb2Zm
bG9hZGluZw0KPiBiYWNrdXAsIGJlY2F1c2UgaXQgY29waWVzIGVhY2ggY2x1c3RlciBzZXBhcmF0
ZWx5LiAgV2hlbiBvZmZsb2FkaW5nIHRoZQ0KPiBjb3B5IG9wZXJhdGlvbiwgd2Ugc29tZXRpbWVz
IGNvcHkgbW9yZSB0aGFuIG9uZSBjbHVzdGVyIGF0IGEgdGltZSwgYnV0DQo+IHdlIG9ubHkgY2hl
Y2sgd2hldGhlciB0aGUgZmlyc3Qgb25lIGlzIGRpcnR5Lg0KPiANCj4gVGhlcmVmb3JlLCB3aGVu
ZXZlciBjb3B5IG9mZmxvYWRpbmcgaXMgcG9zc2libGUsIHRoZSBiYWNrdXAgam9iDQo+IGN1cnJl
bnRseSBwcm9kdWNlcyB3cm9uZyBvdXRwdXQgd2hlbiB0aGUgZ3Vlc3Qgd3JpdGVzIHRvIGFuIGFy
ZWEgb2YNCj4gd2hpY2ggYW4gaW5uZXIgcGFydCBoYXMgYWxyZWFkeSBiZWVuIGJhY2tlZCB1cCwg
YmVjYXVzZSB0aGF0IGlubmVyIHBhcnQNCj4gd2lsbCBiZSByZS1jb3BpZWQuDQo+IA0KPiBGaXhl
czogOWRlZDRhMDExNDk2OGU5OGI0MTQ5NGZjMDM1YmExNGY4NGNkZjcwMA0KPiBTaWduZWQtb2Zm
LWJ5OiBNYXggUmVpdHogPG1yZWl0ekByZWRoYXQuY29tPg0KPiAtLS0NCj4gICBibG9jay9iYWNr
dXAuYyB8IDEzICsrKysrKysrKysrLS0NCj4gICAxIGZpbGUgY2hhbmdlZCwgMTEgaW5zZXJ0aW9u
cygrKSwgMiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9ibG9jay9iYWNrdXAuYyBi
L2Jsb2NrL2JhY2t1cC5jDQo+IGluZGV4IDcxNWUxZDNiZTguLjFlZTI3MWY5ZjEgMTAwNjQ0DQo+
IC0tLSBhL2Jsb2NrL2JhY2t1cC5jDQo+ICsrKyBiL2Jsb2NrL2JhY2t1cC5jDQo+IEBAIC0yMDIs
MjIgKzIwMiwzMSBAQCBzdGF0aWMgaW50IGNvcm91dGluZV9mbiBiYWNrdXBfZG9fY293KEJhY2t1
cEJsb2NrSm9iICpqb2IsDQo+ICAgICAgIGNvd19yZXF1ZXN0X2JlZ2luKCZjb3dfcmVxdWVzdCwg
am9iLCBzdGFydCwgZW5kKTsNCj4gICANCj4gICAgICAgd2hpbGUgKHN0YXJ0IDwgZW5kKSB7DQo+
ICsgICAgICAgIGludDY0X3QgZGlydHlfZW5kOw0KPiArDQo+ICAgICAgICAgICBpZiAoIWhiaXRt
YXBfZ2V0KGpvYi0+Y29weV9iaXRtYXAsIHN0YXJ0KSkgew0KPiAgICAgICAgICAgICAgIHRyYWNl
X2JhY2t1cF9kb19jb3dfc2tpcChqb2IsIHN0YXJ0KTsNCj4gICAgICAgICAgICAgICBzdGFydCAr
PSBqb2ItPmNsdXN0ZXJfc2l6ZTsNCj4gICAgICAgICAgICAgICBjb250aW51ZTsgLyogYWxyZWFk
eSBjb3BpZWQgKi8NCj4gICAgICAgICAgIH0NCj4gICANCj4gKyAgICAgICAgZGlydHlfZW5kID0g
aGJpdG1hcF9uZXh0X3plcm8oam9iLT5jb3B5X2JpdG1hcCwgc3RhcnQsIChlbmQgLSBzdGFydCkp
Ow0KPiArICAgICAgICBpZiAoZGlydHlfZW5kIDwgMCkgew0KPiArICAgICAgICAgICAgZGlydHlf
ZW5kID0gZW5kOw0KPiArICAgICAgICB9DQoNCjEuIGhiaXRtYXBfbmV4dF9kaXJ0eV9hcmVhIGlz
IGJldHRlciBJIHRoaW5rDQoyLiB3ZSBjYW4gZG8gaXQgb25seSBpbiB1c2VfY29weV9yYW5nZSBj
YXNlLCBhcyBiYWNrdXBfY293X3dpdGhfYm91bmNlX2J1ZmZlciBjb3BpZXMNCiAgICBvbmx5IG9u
ZSBjbHVzdGVyIGFueXdheQ0KDQpCdXQgdGhpcyBhbGwgc2hvdWxkIGJlIHJlZmFjdG9yZWQgYW55
d2F5LCBzbzoNClJldmlld2VkLWJ5OiBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IDx2c2Vt
ZW50c292QHZpcnR1b3p6by5jb20+DQoNCj4gKw0KPiAgICAgICAgICAgdHJhY2VfYmFja3VwX2Rv
X2Nvd19wcm9jZXNzKGpvYiwgc3RhcnQpOw0KPiAgIA0KPiAgICAgICAgICAgaWYgKGpvYi0+dXNl
X2NvcHlfcmFuZ2UpIHsNCj4gLSAgICAgICAgICAgIHJldCA9IGJhY2t1cF9jb3dfd2l0aF9vZmZs
b2FkKGpvYiwgc3RhcnQsIGVuZCwgaXNfd3JpdGVfbm90aWZpZXIpOw0KPiArICAgICAgICAgICAg
cmV0ID0gYmFja3VwX2Nvd193aXRoX29mZmxvYWQoam9iLCBzdGFydCwgZGlydHlfZW5kLA0KPiAr
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaXNfd3JpdGVfbm90aWZp
ZXIpOw0KPiAgICAgICAgICAgICAgIGlmIChyZXQgPCAwKSB7DQo+ICAgICAgICAgICAgICAgICAg
IGpvYi0+dXNlX2NvcHlfcmFuZ2UgPSBmYWxzZTsNCj4gICAgICAgICAgICAgICB9DQo+ICAgICAg
ICAgICB9DQo+ICAgICAgICAgICBpZiAoIWpvYi0+dXNlX2NvcHlfcmFuZ2UpIHsNCj4gLSAgICAg
ICAgICAgIHJldCA9IGJhY2t1cF9jb3dfd2l0aF9ib3VuY2VfYnVmZmVyKGpvYiwgc3RhcnQsIGVu
ZCwgaXNfd3JpdGVfbm90aWZpZXIsDQo+ICsgICAgICAgICAgICByZXQgPSBiYWNrdXBfY293X3dp
dGhfYm91bmNlX2J1ZmZlcihqb2IsIHN0YXJ0LCBkaXJ0eV9lbmQsDQo+ICsgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBpc193cml0ZV9ub3RpZmllciwNCj4g
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBlcnJvcl9p
c19yZWFkLCAmYm91bmNlX2J1ZmZlcik7DQo+ICAgICAgICAgICB9DQo+ICAgICAgICAgICBpZiAo
cmV0IDwgMCkgew0KPiANCg0KDQotLSANCkJlc3QgcmVnYXJkcywNClZsYWRpbWlyDQo=

