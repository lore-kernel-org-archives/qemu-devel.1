Return-Path: <SRS0=wgY8=XI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86347C49ED7
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 10:58:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51FA42084F
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 10:58:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="vTTAirup"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51FA42084F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42370 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8jH5-0001AN-Ch
	for qemu-devel@archiver.kernel.org; Fri, 13 Sep 2019 06:57:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39840)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1i8jCW-0004gj-28
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 06:53:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1i8jCU-0007AA-9Z
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 06:53:15 -0400
Received: from mail-eopbgr10130.outbound.protection.outlook.com
 ([40.107.1.130]:42633 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1i8jCT-00078S-Dt; Fri, 13 Sep 2019 06:53:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PLfJqCwqrO1vMUqsN/2j8FwWo6oMcsCYH6GZbxt2CtJElPX2Wydq31wLvUWoFMF+igh20X6th+hBmVoBzESO6FHtoEC87koRWFecxEa9msaHe64STIP06B8v8Kmy5rL+cdaPvnisDGE6XAmwFYSqZh/RQ/sO2S8BqMaEn8TX8Bc48TvwAyF38OFTPK4nWCWMijuk/2KKFV5ygbsc+75pDiyrEms1gYocnBg5bWNH/OGF3iomw/rCgwAkhTyJPaPkg6J9i0gMVm0+TB53JyvFAG5AMYNcLZWiZwFKuAkC/T9doT0OMm16/+aHjza/wJDVYQWy6sVctt3+FYpSGdbfGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T+wxKNH56+X+hMO4dn6YERwcWeP/eulnPBFUopn49oc=;
 b=hyf1TSs3lEu89CQzST+jstcXu0yDe8CCXpWx5RWAbvLLI9+P90brBON89ZIJED7XyM9ST5IJtMpLRNSs9XWNhQOQqB3Bb/InA6EmFYhncoko5J1BRYM8VyFBCMYJw0ovR0ukpc+COFbDttJRdm0nvaTKCZnj+DcI4pq9o5/gboZdiB0oA8u8MIAFE1QUgy6frMNsfBrbUh43fTwmDrk38kKGcI+vlj7fNFMarUVzN8oCLtg/dRunDOwHjbB3Xp3xJ5IO1hOxOC8wnE7LsjvjQPqtHXva9X2UBK2L3wi+LuXFyTFnDHcI1fl4ZOpCyt4Rwk05jouw7j9uFJy3bQe8iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T+wxKNH56+X+hMO4dn6YERwcWeP/eulnPBFUopn49oc=;
 b=vTTAirupIcWiEgm3cMLWNUxUFEqZVA20kUUnrGLIprZdAq9XB4uwPqrJd0/zSEr+Uaymj0TQ0iLLSRPZP4DBmKhFZVVqe5DayDJx9IjPGe31194k5pzGC/SnLK3dRt2wCYUTu+QsS/PxAkXfJ1fVGhf7MiksnR2qBFNUy7JCvJA=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB5017.eurprd08.prod.outlook.com (10.255.19.206) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.17; Fri, 13 Sep 2019 10:53:10 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed%2]) with mapi id 15.20.2263.016; Fri, 13 Sep 2019
 10:53:10 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Kevin Wolf <kwolf@redhat.com>
Thread-Topic: [PATCH v4 3/5] block/qcow2: refactor qcow2_co_preadv_part
Thread-Index: AQHVVEeENkgGbXJQbU+MoHnD+dmQPacpi/EAgAAOVgA=
Date: Fri, 13 Sep 2019 10:53:10 +0000
Message-ID: <d6ca4ea6-2939-4d0f-c6f6-ff32a337de01@virtuozzo.com>
References: <20190816153015.447957-1-vsementsov@virtuozzo.com>
 <20190816153015.447957-4-vsementsov@virtuozzo.com>
 <20190913100146.GC8312@dhcp-200-226.str.redhat.com>
In-Reply-To: <20190913100146.GC8312@dhcp-200-226.str.redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0193.eurprd05.prod.outlook.com
 (2603:10a6:3:f9::17) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190913135304062
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 14d94da4-e7b9-4b26-fed6-08d738389136
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600166)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);
 SRVR:DB8PR08MB5017; 
x-ms-traffictypediagnostic: DB8PR08MB5017:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR08MB5017E3472BDAEBBC361BEFBEC1B30@DB8PR08MB5017.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0159AC2B97
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(136003)(346002)(376002)(396003)(366004)(39840400004)(189003)(199004)(52314003)(5660300002)(86362001)(6506007)(76176011)(386003)(4326008)(186003)(14454004)(6116002)(3846002)(52116002)(31696002)(305945005)(36756003)(7736002)(25786009)(6916009)(102836004)(26005)(2906002)(6436002)(6486002)(31686004)(54906003)(66476007)(478600001)(316002)(64756008)(66556008)(66446008)(99286004)(8936002)(229853002)(81156014)(53936002)(8676002)(66946007)(66066001)(6512007)(486006)(256004)(6246003)(71190400001)(71200400001)(2616005)(446003)(11346002)(476003)(81166006);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB5017;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: zTsL4wZ1Ig2niiyiCz0icY1xhLcx+ejDJt0EI/QS8L/T0VPVlCOxeWTdOyzG1dcetM+y9lP8jyY7BwAGtLgNLCcN9XVh+6P7RWowHAuRRJXso7sEngyvcqlW1aM6h/piH22esMF2YNJOkY3qLo0SKjJvHds359/TxS17XHDT0G6OG+LwSbA9hp6we13wyFOznnOP0P3fTCnzi8dwsx6RtnhMOOg6byOrg0cAznh5AURNy6UpVtSYSmZdsKVDRP6g00Tj98sRiKn67XN1WN63IaphjFIYtQpVfapREWX5dBjpnbDBH22Dd3+gEzKBa1E8NwLtASFbCAempbDSi2JzKKdz/EE6ucy+TxfE2QleNLJFut8tB/b/5E/mpK2H+oFx2VTgreEECeo1N3Sb2KUDwQeFJ7Sgl/Ec1Y1ppmVZFj8=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1C557B8A18D82F429FE7F2F53C92BC05@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14d94da4-e7b9-4b26-fed6-08d738389136
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Sep 2019 10:53:10.3390 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tA2CkeJO5ay88dRN51J6sgfkfNk3llA34I2fwo3R6lXscYKpjLKE1HEKMw/xwL5l+PqtORKNfRyJIm/mcOvGl5zlVORV5LND6VN+StK8wr4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5017
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.1.130
Subject: Re: [Qemu-devel] [PATCH v4 3/5] block/qcow2: refactor
 qcow2_co_preadv_part
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
Cc: Denis Lunev <den@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MTMuMDkuMjAxOSAxMzowMSwgS2V2aW4gV29sZiB3cm90ZToNCj4gQW0gMTYuMDguMjAxOSB1bSAx
NzozMCBoYXQgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSBnZXNjaHJpZWJlbjoNCj4+IEZ1
cnRoZXIgcGF0Y2ggd2lsbCBydW4gcGFydGlhbCByZXF1ZXN0cyBvZiBpdGVyYXRpb25zIG9mDQo+
PiBxY293Ml9jb19wcmVhZHYgaW4gcGFyYWxsZWwgZm9yIHBlcmZvcm1hbmNlIHJlYXNvbnMuIFRv
IHByZXBhcmUgZm9yDQo+PiB0aGlzLCBzZXBhcmF0ZSBwYXJ0IHdoaWNoIG1heSBiZSBwYXJhbGxl
bGl6ZWQgaW50byBzZXBhcmF0ZSBmdW5jdGlvbg0KPj4gKHFjb3cyX2NvX3ByZWFkdl90YXNrKS4N
Cj4+DQo+PiBXaGlsZSBiZWluZyBoZXJlLCBhbHNvIHNlcGFyYXRlIGVuY3J5cHRlZCBjbHVzdGVy
cyByZWFkaW5nIHRvIG93bg0KPj4gZnVuY3Rpb24sIGxpa2UgaXQgaXMgZG9uZSBmb3IgY29tcHJl
c3NlZCByZWFkaW5nLg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IFZsYWRpbWlyIFNlbWVudHNvdi1P
Z2lldnNraXkgPHZzZW1lbnRzb3ZAdmlydHVvenpvLmNvbT4NCj4+IFJldmlld2VkLWJ5OiBNYXgg
UmVpdHogPG1yZWl0ekByZWRoYXQuY29tPg0KPj4gLS0tDQo+PiAgIHFhcGkvYmxvY2stY29yZS5q
c29uIHwgICAyICstDQo+PiAgIGJsb2NrL3Fjb3cyLmMgICAgICAgIHwgMjA1ICsrKysrKysrKysr
KysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4+ICAgMiBmaWxlcyBjaGFuZ2VkLCAx
MTEgaW5zZXJ0aW9ucygrKSwgOTYgZGVsZXRpb25zKC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL3Fh
cGkvYmxvY2stY29yZS5qc29uIGIvcWFwaS9ibG9jay1jb3JlLmpzb24NCj4+IGluZGV4IDBkNDNk
NGYzN2MuLmRkODBhYTExZGIgMTAwNjQ0DQo+PiAtLS0gYS9xYXBpL2Jsb2NrLWNvcmUuanNvbg0K
Pj4gKysrIGIvcWFwaS9ibG9jay1jb3JlLmpzb24NCj4+IEBAIC0zMjY2LDcgKzMyNjYsNyBAQA0K
Pj4gICAgICAgICAgICAgICAncHdyaXRldl9ybXdfdGFpbCcsICdwd3JpdGV2X3Jtd19hZnRlcl90
YWlsJywgJ3B3cml0ZXYnLA0KPj4gICAgICAgICAgICAgICAncHdyaXRldl96ZXJvJywgJ3B3cml0
ZXZfZG9uZScsICdlbXB0eV9pbWFnZV9wcmVwYXJlJywNCj4+ICAgICAgICAgICAgICAgJ2wxX3No
cmlua193cml0ZV90YWJsZScsICdsMV9zaHJpbmtfZnJlZV9sMl9jbHVzdGVycycsDQo+PiAtICAg
ICAgICAgICAgJ2Nvcl93cml0ZScsICdjbHVzdGVyX2FsbG9jX3NwYWNlJywgJ25vbmUnXSB9DQo+
PiArICAgICAgICAgICAgJ2Nvcl93cml0ZScsICdjbHVzdGVyX2FsbG9jX3NwYWNlJywgJ25vbmUn
LCAncmVhZF9lbmNyeXB0ZWQnXSB9DQo+IA0KPiBXaGF0J3MgdGhlIHBvaW50IG9mIHRoaXMgbmV3
IGJsa2RlYnVnIGV2ZW50Pw0KPiANCj4gT2J2aW91c2x5LCByZWFkX2FpbyBmb3IgYW4gZW5jcnlw
dGVkIGltYWdlIG11c3QgbWVhbiBhIHJlYWQgb2YgZW5jcnlwdGVkDQo+IGRhdGEuIFRoZSBzYW1l
IGltYWdlIGNhbiBuZXZlciB0cmlnZ2VyIGJvdGggcmVhZF9haW8gYW5kDQo+IHJlYWRfZW5jcnlw
dGVkLCBzbyB3aHkgZG8gd2UgbmVlZCB0byBkaXN0aW5ndWlzaCB0aGVtIGFzIHR3byBkaWZmZXJl
bnQNCj4gZXZlbnRzPw0KPiANCg0KU2VlbXMgSSBqdXN0IGRvbmUgaXQgbG9va2luZyBhdCBxY293
Ml9jb19wcmVhZHZfY29tcHJlc3NlZC4uDQoNCkFueXdheSwgSSB0aGluayB5b3UgYXJlIHJpZ2h0
LCBzbywgSSBkb24ndCBtaW5kIGlmIE1heCBkcm9wcyB0aGlzIG5ldyBldmVudA0KYW5kIHVzZSBy
ZWFkX2FpbyBpbiBoaXMgYnJhbmNoLCBvciBJIGNhbiByZXNlbmQgdGhlIHNlcmllcyBvciBzZW5k
IGEgZm9sbG93LXVwLA0Kd2hpY2hldmVyIHlvdSBwcmVmZXIuDQoNCg0KLS0gDQpCZXN0IHJlZ2Fy
ZHMsDQpWbGFkaW1pcg0K

