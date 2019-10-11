Return-Path: <SRS0=T2pn=YE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2C22ECE58C
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 09:11:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB2D52084C
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 09:11:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="CfoFGByn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB2D52084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47632 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIqxD-0003KM-T8
	for qemu-devel@archiver.kernel.org; Fri, 11 Oct 2019 05:11:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49872)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iIqvB-0000Xl-QZ
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 05:09:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iIqvA-000597-CK
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 05:09:13 -0400
Received: from mail-eopbgr10139.outbound.protection.outlook.com
 ([40.107.1.139]:2787 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iIqv9-00055i-IK; Fri, 11 Oct 2019 05:09:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S7HDahZV+nyfinRfDQeGo14Dlwg5rluVOc5BQOscomyo4mQ550uzdQRx9LN0sSaJUny+HhG9C/ZY4z2y1MhApWX2tUzfQuI4n9rQp1/+8cdjrPamdD+y40z5m8HX033oyVv27mcZ3LW+9zZ+jDEmQuUARF2/Gf/DlJaM48mcc/L2m6sTeJoq+DJfXWla84YJSjxBNPgeZmJW9CCHZkXiHHapyC2+p2Q0JFmI2h6rMB9R3e+g7XgVHsS7MqQ2uXHCGqVHfXS3CTHENmptMUmSowRY/Dv+LRK+V2YAnw8Qnd+7kAQp1B+umEk0O2EQ0AMXXdx/+M7sc3rT6d2JMyQpKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mweBekoHhMMqAo8atEOin3U08Vjjd7+e5zdXZkWkL3c=;
 b=jYqThi9SZm4CAKhQUpLG5Lmzjx2NTYWojfvTj2K6Dbn8zmErBfeAYGGrbWS1ihO17aYzRGsHwEN098KcUYE37JjlJpm/c9hjH9EuWNLQLkWlNyc/Igg5AdWiHPKR5UheEDLqit6d8jDws/2tD+K+QnTmFDlhp9dDapFRTmHXmWaENw2RiInhqEl4FbgD5McixhJcIQp6OmmrBiTHR+t5wxn5V2bmUb65j2oCJ9G+gUeh/qsWxT7dQ0lisbtFUR8Eyce6UDGKO2NlLH0o64nvIfBTEPw+pIyGxXAdw5S2Xj7PFUc/M2JAXd7no2PPdlYl0l59dIccvJbvBmEl+HCgVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mweBekoHhMMqAo8atEOin3U08Vjjd7+e5zdXZkWkL3c=;
 b=CfoFGByn/1VyP75NN4HPTtXBeSDk5adilHiR/21wI+UvsVwz2B0sfdxh1SHsiT3i31mX0bawjNeWk93OOjkomTvwyXtJoDnIUpRySTGsOHrvgFyNNjTDv2Pm15/xwrVieOXtKnJtjM4AT1AQktlvOKAtbM7eh6z8qA2AVh2E9sw=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB4139.eurprd08.prod.outlook.com (20.179.11.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.21; Fri, 11 Oct 2019 09:09:07 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::2856:990a:197a:288f]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::2856:990a:197a:288f%2]) with mapi id 15.20.2347.021; Fri, 11 Oct 2019
 09:09:07 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Subject: Re: [PATCH 3/4] block/mirror: support unaligned write in active mirror
Thread-Topic: [PATCH 3/4] block/mirror: support unaligned write in active
 mirror
Thread-Index: AQHVaXyqGWMlukZLJkOXoRVirVbRLqdKz3mAgAp6joCAAAccAIAAAvOA
Date: Fri, 11 Oct 2019 09:09:07 +0000
Message-ID: <097108a0-f646-6bbc-a181-6e01a2449870@virtuozzo.com>
References: <20190912151338.21225-1-vsementsov@virtuozzo.com>
 <20190912151338.21225-4-vsementsov@virtuozzo.com>
 <6fd6a449-0443-ecfa-0eec-23e3b515b303@redhat.com>
 <eb11dfe2-fe3b-54bf-a23f-b9d208690680@virtuozzo.com>
 <0cc82b6a-9a1c-4f5b-f133-153ab739c0a3@redhat.com>
In-Reply-To: <0cc82b6a-9a1c-4f5b-f133-153ab739c0a3@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0701CA0089.eurprd07.prod.outlook.com
 (2603:10a6:3:64::33) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191011120904933
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f299fd4d-1098-432a-6249-08d74e2aab82
x-ms-traffictypediagnostic: DB8PR08MB4139:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR08MB413904A076ABA2A95380B559C1970@DB8PR08MB4139.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:489;
x-forefront-prvs: 0187F3EA14
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(136003)(39830400003)(396003)(366004)(346002)(376002)(189003)(51444003)(199004)(52116002)(186003)(386003)(6506007)(53546011)(99286004)(66476007)(66556008)(64756008)(66446008)(66946007)(6512007)(26005)(102836004)(76176011)(31696002)(8676002)(36756003)(25786009)(71200400001)(14444005)(71190400001)(256004)(229853002)(316002)(6486002)(7736002)(305945005)(81166006)(6436002)(107886003)(6116002)(54906003)(8936002)(110136005)(31686004)(86362001)(5660300002)(81156014)(6246003)(66066001)(476003)(486006)(3846002)(2616005)(11346002)(2906002)(446003)(4326008)(14454004)(478600001)(2501003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB4139;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7sgnywkEHQYX4KALTIc7rpUfa6t8FqdF9tHxAq/05WayvEIV7jc/gP9xhUTF9utv50D5BVltyiXWKMcJsL3RjonVuGTJl/jVHrP2S9wvSLZHPSqfE69fjzFHUowhhhVZ3EwQ9UQPhxUC+h3nUT5gT+Yqop1p2mJ/XwlYQDvY0itJGKdLAF8Ca0jri6pBpX3oWYN/tahcCInrtLH24aYptg7dsgK4ZokBImy/DnecKux2XGVCtGjoXtAbTjXl4luEx6TkkoRsDgkqqauRNVdm3QTdPHtwFkkT3D0FQOR9HvNw3Xkr7pjIWQkm8iHCbiucZHIJBlgME1Bkeq6yWsemOTnasEKxhtC3diyWRzM4imJw4wEGqpyS7qs+6HxU8RmQzULlcKU/AlQOmSE6VwWlRu9J7USrpwU03+7X1P/MJQA=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1EFB4603DD40F2418A6DCE569E27DAC4@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f299fd4d-1098-432a-6249-08d74e2aab82
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2019 09:09:07.0707 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6dGK+0Hecpew+CWzp/6vkP7E4XNShSh+/OJP3p8kZRfrKXu3H0WW32k+ppiHNr7CcdDGtcgawnDEEMtnf/D8so7N1LP0Y61rgAaHsWJcAsU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB4139
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.1.139
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>,
 "jsnow@redhat.com" <jsnow@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Denis Lunev <den@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MTEuMTAuMjAxOSAxMTo1OCwgTWF4IFJlaXR6IHdyb3RlOg0KPiBPbiAxMS4xMC4xOSAxMDozMywg
VmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4+IDA0LjEwLjIwMTkgMTk6MzEs
IE1heCBSZWl0eiB3cm90ZToNCj4+PiBPbiAxMi4wOS4xOSAxNzoxMywgVmxhZGltaXIgU2VtZW50
c292LU9naWV2c2tpeSB3cm90ZToNCj4+Pj4gUHJpb3IgOWFkYzFjYjQ5YWY4ZCBkb19zeW5jX3Rh
cmdldF93cml0ZSBoYWQgYSBidWc6IGl0IHJlc2V0IGFsaWduZWQtdXANCj4+Pj4gcmVnaW9uIGlu
IHRoZSBkaXJ0eSBiaXRtYXAsIHdoaWNoIG1lYW5zIHRoYXQgd2UgbWF5IG5vdCBjb3B5IHNvbWUg
Ynl0ZXMNCj4+Pj4gYW5kIGFzc3VtZSB0aGVtIGNvcGllZCwgd2hpY2ggYWN0dWFsbHkgbGVhZHMg
dG8gcHJvZHVjaW5nIGNvcnJ1cHRlZA0KPj4+PiB0YXJnZXQuDQo+Pj4+DQo+Pj4+IFNvIDlhZGMx
Y2I0OWFmOGQgZm9yY2VkIGRpcnR5IGJpdG1hcCBncmFudWxhcml0eSB0byBiZQ0KPj4+PiByZXF1
ZXN0X2FsaWdubWVudCBmb3IgbWlycm9yLXRvcCBmaWx0ZXIsIHNvIHdlIGFyZSBub3Qgd29ya2lu
ZyB3aXRoDQo+Pj4+IHVuYWxpZ25lZCByZXF1ZXN0cy4gSG93ZXZlciBmb3JjaW5nIGxhcmdlIGFs
aWdubWVudCBvYnZpb3VzbHkgZGVjcmVhc2VzDQo+Pj4+IHBlcmZvcm1hbmNlIG9mIHVuYWxpZ25l
ZCByZXF1ZXN0cy4NCj4+Pj4NCj4+Pj4gVGhpcyBjb21taXQgcHJvdmlkZXMgYW5vdGhlciBzb2x1
dGlvbiBmb3IgdGhlIHByb2JsZW06IGlmIHVuYWxpZ25lZA0KPj4+PiBwYWRkaW5nIGlzIGFscmVh
ZHkgZGlydHksIHdlIGNhbiBzYWZlbHkgaWdub3JlIGl0LCBhcw0KPj4+PiAxLiBJdCdzIGRpcnR5
LCBpdCB3aWxsIGJlIGNvcGllZCBieSBtaXJyb3JfaXRlcmF0aW9uIGFueXdheQ0KPj4+PiAyLiBJ
dCdzIGRpcnR5LCBzbyBza2lwcGluZyBpdCBub3cgd2UgZG9uJ3QgaW5jcmVhc2UgZGlydGluZXNz
IG9mIHRoZQ0KPj4+PiAgICAgIGJpdG1hcCBhbmQgdGhlcmVmb3JlIGRvbid0IGRhbWFnZSAic3lu
Y2hyb25pY2l0eSIgb2YgdGhlDQo+Pj4+ICAgICAgd3JpdGUtYmxvY2tpbmcgbWlycm9yLg0KPj4+
Pg0KPj4+PiBJZiB1bmFsaWduZWQgcGFkZGluZyBpcyBub3QgZGlydHksIHdlIGp1c3Qgd3JpdGUg
aXQsIG5vIHJlYXNvbiB0byB0b3VjaA0KPj4+PiBkaXJ0eSBiaXRtYXAgaWYgd2Ugc3VjY2VlZCAo
b24gZmFpbHVyZSB3ZSdsbCBzZXQgdGhlIHdob2xlIHJlZ2lvbg0KPj4+PiBvZmNvdXJzZSwgYnV0
IHdlIGxvc3MgInN5bmNocm9uaWNpdHkiIG9uIGZhaWx1cmUgYW55d2F5KS4NCj4+Pj4NCj4+Pj4g
Tm90ZTogd2UgbmVlZCB0byBkaXNhYmxlIGRpcnR5X2JpdG1hcCwgb3RoZXJ3aXNlIHdlIHdpbGwg
bm90IGJlIGFibGUgdG8NCj4+Pj4gc2VlIGluIGRvX3N5bmNfdGFyZ2V0X3dyaXRlIGJpdG1hcCBz
dGF0ZSBiZWZvcmUgY3VycmVudCBvcGVyYXRpb24uIFdlDQo+Pj4+IG1heSBvZiBjb3Vyc2UgY2hl
Y2sgZGlydHkgYml0bWFwIGJlZm9yZSB0aGUgb3BlcmF0aW9uIGluDQo+Pj4+IGJkcnZfbWlycm9y
X3RvcF9kb193cml0ZSBhbmQgcmVtZW1iZXIgaXQsIGJ1dCB3ZSBkb24ndCBuZWVkIGFjdGl2ZQ0K
Pj4+PiBkaXJ0eSBiaXRtYXAgZm9yIHdyaXRlLWJsb2NraW5nIG1pcnJvciBhbnl3YXkuDQo+Pj4+
DQo+Pj4+IE5ldyBjb2RlLXBhdGggaXMgdW51c2VkIHVudGlsIHRoZSBmb2xsb3dpbmcgY29tbWl0
IHJldmVydHMNCj4+Pj4gOWFkYzFjYjQ5YWY4ZC4NCj4+Pj4NCj4+Pj4gU3VnZ2VzdGVkLWJ5OiBE
ZW5pcyBWLiBMdW5ldiA8ZGVuQG9wZW52ei5vcmc+DQo+Pj4+IFNpZ25lZC1vZmYtYnk6IFZsYWRp
bWlyIFNlbWVudHNvdi1PZ2lldnNraXkgPHZzZW1lbnRzb3ZAdmlydHVvenpvLmNvbT4NCj4+Pj4g
LS0tDQo+Pj4+ICAgIGJsb2NrL21pcnJvci5jIHwgMzkgKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKystDQo+Pj4+ICAgIDEgZmlsZSBjaGFuZ2VkLCAzOCBpbnNlcnRpb25zKCsp
LCAxIGRlbGV0aW9uKC0pDQo+Pj4+DQo+Pj4+IGRpZmYgLS1naXQgYS9ibG9jay9taXJyb3IuYyBi
L2Jsb2NrL21pcnJvci5jDQo+Pj4+IGluZGV4IGQxNzZiZjU5MjAuLmQxOTJmNmE5NmIgMTAwNjQ0
DQo+Pj4+IC0tLSBhL2Jsb2NrL21pcnJvci5jDQo+Pj4+ICsrKyBiL2Jsb2NrL21pcnJvci5jDQo+
Pj4+IEBAIC0xMjA0LDYgKzEyMDQsMzkgQEAgZG9fc3luY190YXJnZXRfd3JpdGUoTWlycm9yQmxv
Y2tKb2IgKmpvYiwgTWlycm9yTWV0aG9kIG1ldGhvZCwNCj4+Pj4gICAgICAgICAgICAgICAgICAg
ICAgICAgUUVNVUlPVmVjdG9yICpxaW92LCBpbnQgZmxhZ3MpDQo+Pj4+ICAgIHsNCj4+Pj4gICAg
ICAgIGludCByZXQ7DQo+Pj4+ICsgICAgc2l6ZV90IHFpb3Zfb2Zmc2V0ID0gMDsNCj4+Pj4gKw0K
Pj4+PiArICAgIGlmICghUUVNVV9JU19BTElHTkVEKG9mZnNldCwgam9iLT5ncmFudWxhcml0eSkg
JiYNCj4+Pj4gKyAgICAgICAgYmRydl9kaXJ0eV9iaXRtYXBfZ2V0KGpvYi0+ZGlydHlfYml0bWFw
LCBvZmZzZXQpKSB7DQo+Pj4+ICsgICAgICAgICAgICAvKg0KPj4+PiArICAgICAgICAgICAgICog
RGlydHkgdW5hbGlnbmVkIHBhZGRpbmcNCj4+Pj4gKyAgICAgICAgICAgICAqIDEuIEl0J3MgYWxy
ZWFkeSBkaXJ0eSwgbm8gZGFtYWdlIHRvICJhY3RpdmVseV9zeW5jZWQiIGlmIHdlIGp1c3QNCj4+
Pj4gKyAgICAgICAgICAgICAqICAgIHNraXAgdW5hbGlnbmVkIHBhcnQuDQo+Pj4+ICsgICAgICAg
ICAgICAgKiAyLiBJZiB3ZSBjb3B5IGl0LCB3ZSBjYW4ndCByZXNldCBjb3JyZXNwb25kaW5nIGJp
dCBpbg0KPj4+PiArICAgICAgICAgICAgICogICAgZGlydHlfYml0bWFwIGFzIHRoZXJlIG1heSBi
ZSBzb21lICJkaXJ0eSIgYnl0ZXMgc3RpbGwgbm90DQo+Pj4+ICsgICAgICAgICAgICAgKiAgICBj
b3BpZWQuDQo+Pj4+ICsgICAgICAgICAgICAgKiBTbywganVzdCBpZ25vcmUgaXQuDQo+Pj4+ICsg
ICAgICAgICAgICAgKi8NCj4+Pj4gKyAgICAgICAgICAgIHFpb3Zfb2Zmc2V0ID0gUUVNVV9BTElH
Tl9VUChvZmZzZXQsIGpvYi0+Z3JhbnVsYXJpdHkpIC0gb2Zmc2V0Ow0KPj4+PiArICAgICAgICAg
ICAgaWYgKGJ5dGVzIDw9IHFpb3Zfb2Zmc2V0KSB7DQo+Pj4+ICsgICAgICAgICAgICAgICAgLyog
bm90aGluZyB0byBkbyBhZnRlciBzaHJpbmsgKi8NCj4+Pj4gKyAgICAgICAgICAgICAgICByZXR1
cm47DQo+Pj4+ICsgICAgICAgICAgICB9DQo+Pj4+ICsgICAgICAgICAgICBvZmZzZXQgKz0gcWlv
dl9vZmZzZXQ7DQo+Pj4+ICsgICAgICAgICAgICBieXRlcyAtPSBxaW92X29mZnNldDsNCj4+Pj4g
KyAgICB9DQo+Pj4+ICsNCj4+Pj4gKyAgICBpZiAoIVFFTVVfSVNfQUxJR05FRChvZmZzZXQgKyBi
eXRlcywgam9iLT5ncmFudWxhcml0eSkgJiYNCj4+Pj4gKyAgICAgICAgYmRydl9kaXJ0eV9iaXRt
YXBfZ2V0KGpvYi0+ZGlydHlfYml0bWFwLCBvZmZzZXQgKyBieXRlcyAtIDEpKQ0KPj4+PiArICAg
IHsNCj4+Pj4gKyAgICAgICAgdWludDY0X3QgdGFpbCA9IChvZmZzZXQgKyBieXRlcykgJSBqb2It
PmdyYW51bGFyaXR5Ow0KPj4+PiArDQo+Pj4+ICsgICAgICAgIGlmIChieXRlcyA8PSB0YWlsKSB7
DQo+Pj4+ICsgICAgICAgICAgICAvKiBub3RoaW5nIHRvIGRvIGFmdGVyIHNocmluayAqLw0KPj4+
PiArICAgICAgICAgICAgcmV0dXJuOw0KPj4+PiArICAgICAgICB9DQo+Pj4+ICsgICAgICAgIGJ5
dGVzIC09IHRhaWw7DQo+Pj4+ICsgICAgfQ0KPj4+PiAgICANCj4+Pj4gICAgICAgIGJkcnZfcmVz
ZXRfZGlydHlfYml0bWFwKGpvYi0+ZGlydHlfYml0bWFwLCBvZmZzZXQsIGJ5dGVzKTsNCj4+Pj4g
ICAgDQo+Pj4NCj4+PiBUaGUgYmRydl9zZXRfZGlydHlfYml0bWFwKCkgaW4gdGhlIGVycm9yIGNh
c2UgYmVsb3cgbmVlZHMgdG8gdXNlIHRoZQ0KPj4+IG9yaWdpbmFsIG9mZnNldC9ieXRlcywgSSBz
dXBwb3NlLg0KPj4NCj4+IE5vLCBiZWNhdXNlIHdlIHNocmluayB0YWlsIG9ubHkgaWYgaXQgaXMg
YWxyZWFkeSBkaXJ0eS4gQW5kIHdlJ3ZlIGxvY2tlZCB0aGUNCj4+IHJlZ2lvbiBmb3IgaW4tZmxp
Z2h0IG9wZXJhdGlvbiwgc28gbm9ib2R5IGNhbiBjbGVhciB0aGUgYml0bWFwIGluIGEgbWVhbnRp
bWUuDQo+IA0KPiBUcnVlLiAgQnV0IHdvdWxkbuKAmXQgaXQgYmUgc2ltcGxlciB0byB1bmRlcnN0
YW5kIHRvIGp1c3QgdXNlIHRoZSBvcmlnaW5hbA0KPiBvZmZzZXRzPw0KPiANCj4+IEJ1dCBzdGls
bCwgaGVyZSBpcyBzb21ldGhpbmcgdG8gZG86DQo+Pg0KPj4gZm9yIG5vdC1zaHJpbmtlZCB0YWls
cywgaWYgYW55LCB3ZSBzaG91bGQ6DQo+PiAxLiBhbGlnbiBkb3duIGZvciByZXNldA0KPj4gMi4g
YWxpZ24gdXAgZm9yIHNldCBvbiBmYWlsdXJlDQo+IA0KPiBXZWxsLCB0aGUgYWxpZ24gdXAgaXMg
ZG9uZSBhdXRvbWF0aWNhbGx5LCBhbmQgSSB0aGluayB0aGF04oCZcyBwcmV0dHkNCj4gc2VsZi1l
eHBsYW5hdG9yeS4NCg0KUGF0Y2ggdG8gbWFrZSBoYml0bWFwX3Jlc2V0IHZlcnkgc3RyaWN0IChh
c3NlcnQgb24gYW5hbGlnbmVkIGV4Y2VwdCBmb3IgdGhlDQp2ZXJ5IGVuZCBvZiB0aGUgYml0bWFw
LCBpZiBvcmlnX3NpemUgaXMgdW5hbGlnbmVkKSBpcyBxdWV1ZWQgYnkgSm9obi4NClNvLCBJJ3Zl
IG1hZGUgZXhwbGljaXQgYWxpZ25tZW50IGluIHYyLg0KDQo+IA0KPj4+DQo+Pj4gQXBhcnQgZnJv
bSB0aGF0LCBsb29rcyBnb29kIHRvIG1lLg0KPj4+DQo+Pj4gTWF4DQo+Pj4NCj4+DQo+Pg0KPiAN
Cj4gDQoNCg0KLS0gDQpCZXN0IHJlZ2FyZHMsDQpWbGFkaW1pcg0K

