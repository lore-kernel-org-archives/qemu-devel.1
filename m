Return-Path: <SRS0=vzij=WB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AB8FC0650F
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 09:27:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54A3520880
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 09:27:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="NgVwRnQF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54A3520880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52040 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1huZGz-0001Gh-Jj
	for qemu-devel@archiver.kernel.org; Mon, 05 Aug 2019 05:27:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59536)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1huZGY-0000nq-R0
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 05:26:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1huZGX-0005lB-KN
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 05:26:54 -0400
Received: from mail-eopbgr140127.outbound.protection.outlook.com
 ([40.107.14.127]:13956 helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1huZGW-0005je-Vu; Mon, 05 Aug 2019 05:26:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mm1ibgSHcIBIUlOvZF76KYLpXi85SfeVEGNIYhrrf/aym8xoa3jL+cxU7ulJqSk9Y3FN0/YnfBhrDG48wVHUsEiBpWv29xcS5ZRMumeaqbfERmol/kJ55Ou2z4VMeS4+ZlVCu58qwnQX/Zp5iiz6Nzr8jMnm/6M4jPWnvMidZNjzuG7DhfeYdqp4NJ2sBqeimfwIDu1mN21SJ2n/7/2O3352DtYjAUF54FG2SPTqRWA6HYRaKAR3MvZBHm3Kqzw5sfX5DYfRlcPOfZImpZZnt2rKnKW7cgQrDk6qprN9i2k1IiHLvyjwioDzomCU/rJVEUplqYLYnK/FgNlTMHIP3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j9HzbdSLf8T6Em4+K4OJXJSScodkVb6MwVdXfOcXf40=;
 b=kZoAwCSU/+WnL4qH38DlfNmUB+VT9BPIGzbnjzuO7CXRAaRIWG2AAukQRnk29y8t5jkzhPCakwuBNcrb2gfhwvhFtgQSHLXzglUJxBqjwwOnTuFifKD6UjXxDauCSXkRL0GojH+3yrawxQKq/0f8lolTx8Y5z8NYTm1h9ZcU+VoIIbPEh1z46Wn8qdqNthd1rERq1fsG3ZwHMOHvgoNjD9QYqkaHLazH52nwdYgqHkV6BxNoNaM2DB3PFCo6zE/wGyuiHM4sH0Uj4kWYGhUR5rBB5SVjbWucx09ukNxxieIi9lEz1bRnjBqiKQ80Z8VcksHguR9RxesiZjrO56hFjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=virtuozzo.com;dmarc=pass action=none
 header.from=virtuozzo.com;dkim=pass header.d=virtuozzo.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j9HzbdSLf8T6Em4+K4OJXJSScodkVb6MwVdXfOcXf40=;
 b=NgVwRnQFVlJ9IDYUgK8/KMIgaiesvZp89dPLjyPtEPlPGJGIELctv2CiQWUtp1JBUnHhYKi2HLLGXRI16G5voww2jfGtJcF+Pfm8L8DTHadyxn1mT98Ol4/une4WhPJuySBtrRG9ZQ/T46RaWT2hAwdB0OSQ39wuABkyJfoBmTA=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB4140.eurprd08.prod.outlook.com (20.179.10.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.14; Mon, 5 Aug 2019 09:26:48 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604%3]) with mapi id 15.20.2136.018; Mon, 5 Aug 2019
 09:26:48 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: John Snow <jsnow@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Thread-Topic: [PATCH] util/hbitmap: fix unaligned reset
Thread-Index: AQHVSWRPRHRMrQjqvUmj+ogxvT3PoaboPFCAgAQQs4A=
Date: Mon, 5 Aug 2019 09:26:47 +0000
Message-ID: <83854e0f-31a1-0e08-8935-b0f95af94dfc@virtuozzo.com>
References: <20190802185830.74648-1-vsementsov@virtuozzo.com>
 <c784af61-663d-a633-657e-9f7541c9e97b@redhat.com>
In-Reply-To: <c784af61-663d-a633-657e-9f7541c9e97b@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR09CA0045.eurprd09.prod.outlook.com
 (2603:10a6:7:3c::13) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190805122645584
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d007e569-e74e-48d2-dda2-08d719870a18
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DB8PR08MB4140; 
x-ms-traffictypediagnostic: DB8PR08MB4140:
x-microsoft-antispam-prvs: <DB8PR08MB4140AE6A6EC4B3861BF81839C1DA0@DB8PR08MB4140.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 01208B1E18
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(366004)(346002)(396003)(376002)(136003)(39840400004)(51444003)(53754006)(189003)(199004)(66946007)(66476007)(66556008)(64756008)(66446008)(99286004)(71190400001)(71200400001)(110136005)(6116002)(446003)(478600001)(81166006)(26005)(6506007)(66066001)(81156014)(305945005)(2501003)(256004)(54906003)(3846002)(6512007)(14444005)(186003)(4326008)(316002)(386003)(486006)(8676002)(8936002)(53546011)(68736007)(2906002)(2616005)(6246003)(36756003)(31696002)(102836004)(6436002)(53936002)(86362001)(476003)(107886003)(25786009)(11346002)(52116002)(14454004)(31686004)(76176011)(229853002)(7736002)(5660300002)(6486002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB4140;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: RU5PQ0FoiVprOKNUrEeSFJX9EefiU2gx/z5RmeDgWY+z3um1n71jPyzBbX49g176K1ZZ78BCCUr2LRSU7lnFi1p3sqS3ivnWwjJmfkQ1yuug6qA+dgXxMtck2h8e/q8mhMB2fS2vrcOBj4f6qUc6amk9g2RvnIpxSs4ZGWJFLx2/A5YqZCs5cUmF7wLKqY1Flq9tKdrpDCSbhLaYOYQO1IWNFH/d2CXhwbgVeuq+d/4riDwmY1SaV5iN0q2xGTwONdVLrGCqQ6JSpspT2reglazGdnSrQJk1syzetRf2j/RKBuP7WlMKChXL4RuFKhjJHcB1vfO6gVLsCHUsU9kAYekC5zMCUjDiuDpsdxfdV5OAiaAsK0UixTcAGc4jyuS0xjC2PfY6xK7w9zamxUpxoti+4lb9TdrqlyUyhBrPChA=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EE4EB9631BEC814297EAD227263D7447@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d007e569-e74e-48d2-dda2-08d719870a18
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2019 09:26:47.9497 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vsementsov@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB4140
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.14.127
Subject: Re: [Qemu-devel] [PATCH] util/hbitmap: fix unaligned reset
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
Cc: "fam@euphon.net" <fam@euphon.net>, "kwolf@redhat.com" <kwolf@redhat.com>,
 Denis Lunev <den@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MDIuMDguMjAxOSAyMjoyMSwgSm9obiBTbm93IHdyb3RlOg0KPiANCj4gDQo+IE9uIDgvMi8xOSAy
OjU4IFBNLCBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IHdyb3RlOg0KPj4gaGJpdG1hcF9y
ZXNldCBpcyBicm9rZW46IGl0IHJvdW5kcyB1cCB0aGUgcmVxdWVzdGVkIHJlZ2lvbi4gSXQgbGVh
ZHMgdG8NCj4+IHRoZSBmb2xsb3dpbmcgYnVnLCB3aGljaCBpcyBzaG93biBieSBmaXhlZCB0ZXN0
Og0KPj4NCj4+IGFzc3VtZSBncmFudWxhcml0eSA9IDINCj4+IHNldCgwLCAzKSAjIGNvdW50IGJl
Y29tZXMgNA0KPj4gcmVzZXQoMCwgMSkgIyBjb3VudCBiZWNvbWVzIDINCj4+DQo+PiBCdXQgdXNl
ciBvZiB0aGUgaW50ZXJmYWNlIGFzc3VtZSB0aGF0IHZpcnR1YWwgYml0IDEgc2hvdWxkIGJlIHN0
aWxsDQo+PiBkaXJ0eSwgc28gaGJpdG1hcCBzaG91bGQgcmVwb3J0IGNvdW50IHRvIGJlIDQhDQo+
Pg0KPj4gSW4gb3RoZXIgd29yZHMsIGJlY2F1c2Ugb2YgZ3JhbnVsYXJpdHksIHdoZW4gd2Ugc2V0
IG9uZSAidmlydHVhbCIgYml0LA0KPj4geWVzLCB3ZSBtYWtlIGFsbCAidmlydHVhbCIgYml0cyBp
biBzYW1lIGNodW5rIHRvIGJlIGRpcnR5LiBCdXQgdGhpcw0KPj4gc2hvdWxkIG5vdCBiZSBzbyBm
b3IgcmVzZXQuDQo+Pg0KPj4gRml4IHRoaXMsIGFsaWduaW5nIGJvdW5kIGNvcnJlY3RseS4NCj4+
DQo+PiBTaWduZWQtb2ZmLWJ5OiBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IDx2c2VtZW50
c292QHZpcnR1b3p6by5jb20+DQo+PiAtLS0NCj4+DQo+PiBIaSBhbGwhDQo+Pg0KPj4gSG1tLCBp
cyBpdCBhIGJ1ZyBvciBmZWF0dXJlPyA6KQ0KPiANCj4gVmVyeSwgdmVyeSBnb29kIHF1ZXN0aW9u
Lg0KPiANCj4+IEkgZG9uJ3QgaGF2ZSBhIHRlc3QgZm9yIG1pcnJvciB5ZXQsIGJ1dCBJIHRoaW5r
IHRoYXQgc3luYyBtaXJyb3IgbWF5IGJlIGJyb2tlbg0KPj4gYmVjYXVzZSBvZiB0aGlzLCBhcyBk
b19zeW5jX3RhcmdldF93cml0ZSgpIHNlZW1zIHRvIGJlIHVzaW5nIHVuYWxpZ25lZCByZXNldC4N
Cj4+DQo+IA0KPiBIb25lc3RseSBJIHdhcyB3b3JyaWVkIGFib3V0IHRoaXMgLS0gaWYgeW91IHRh
a2UgYSBsb29rIGF0IG15IHBhdGNoZXMNCj4gd2hlcmUgSSBhZGQgbmV3IGJpdG1hcCBzeW5jIG1v
ZGVzLCBJIGJlbnQgb3ZlciBiYWNrd2FyZHMgdG8gYWxpZ24NCj4gcmVxdWVzdHMgZm9yIHRoZSBz
eW5jPXRvcCBiaXRtYXAgaW5pdGlhbGl6YXRpb24gbWV0aG9kcyBiZWNhdXNlIEkgd2FzDQo+IHdv
cnJpZWQgYWJvdXQgdGhpcyBwb3NzaWJseSBiZWluZyB0aGUgY2FzZS4NCj4gDQo+IA0KPiBJJ20g
bm90IHN1cmUgd2hhdCB0aGUgInJpZ2h0IiBiZWhhdmlvciBvdWdodCB0byBiZS4NCj4gDQo+IExl
dCdzIHNheSB5b3UgaGF2ZSBhIGdyYW51bGFyaXR5IG9mIDggYnl0ZXM6DQo+IA0KPiBpZiB5b3Ug
cmVzZXQgMC0zIGluIG9uZSBjYWxsLCBhbmQgdGhlbiA0LTcgaW4gdGhlIG5leHQsIHdoYXQgaGFw
cGVucz8gSWYNCj4gdGhlIGNhbGxlciBuYWl2ZWx5IHRoaW5rcyB0aGVyZSdzIGEgMToxIHJlbGF0
aW9uc2hpcCwgaXQgbWlnaHQgYWN0dWFsbHkNCj4gZXhwZWN0IHRoYXQgdG8gcmVmbGVjdCBhIGNs
ZWFyZWQgYml0LiBXaXRoIGFsaWdubWVudCBwcm90ZWN0aW9uLCB3ZSdsbA0KPiBqdXN0IGZhaWwg
dG8gY2xlYXIgaXQgYm90aCB0aW1lcyBhbmQgaXQgcmVtYWlucyBzZXQuDQo+IA0KPiBPbiB0aGUg
b3RoZXIgaGFuZCwgaWYgeW91IGRvIGFsbG93IHBhcnRpYWwgY2xlYXJzLCB0aGUgZmlyc3QgcmVz
ZXQgZm9yDQo+IDAtMyB3aWxsIHRvZ2dsZSBvZmYgNC03IHRvbywgd2hlcmUgd2UgbWlnaHQgcmVs
eSBvbiB0aGUgZmFjdCB0aGF0IGl0J3MNCj4gYWN0dWFsbHkgc3RpbGwgZGlydHkuDQo+IA0KPiBX
aGV0aGVyIG9yIG5vdCB0aGF0J3MgZGFuZ2Vyb3VzIGRlcGVuZHMgb24gdGhlIGNvbnRleHQsIGFu
ZCBvbmx5IHRoZQ0KPiBjYWxsZXIga25vd3MgdGhlIGNvbnRleHQuIEkgdGhpbmsgd2UgbmVlZCB0
byBtYWtlIHRoZSBzZW1hbnRpYyBlZmZlY3Qgb2YNCj4gdGhlIHJlc2V0ICJvYnZpb3VzIiB0byB0
aGUgY2FsbGVyLg0KPiANCj4gDQo+IEkgZW52aXNpb24gdGhpczoNCj4gDQo+IC0gaGJpdG1hcF9y
ZXNldChiaXRtYXAsIHN0YXJ0LCBsZW5ndGgpDQo+ICAgIHJldHVybnMgLUVJTlZBTCBpZiB0aGUg
cmFuZ2UgaXMgbm90IHByb3Blcmx5IGFsaWduZWQNCg0KaGJpdG1hcF9yZXNldCBkb24ndCByZXR1
cm4sIEkgdGhpbmtzIGl0IHNob3VsZCBiZSBhbiBhc3NlcnRpb24NCg0KPiANCj4gLSBoYml0bWFw
X3Jlc2V0X2ZsYWdzKGJpdG1hcCwgZmxhZ3MsIHN0YXJ0LCBsZW5ndGgpDQo+ICAgIGlmIChmbGFn
cyAmIEhCSVRNQVBfQUxJR05fRE9XTikgYWxpZ24gcmVxdWVzdCB0byBvbmx5IGZ1bGwgYml0cw0K
PiAgICBpZiAoZmxhZ3MgJiBIQklUTUFQX0FMSUdOX1VQKSBhbGlnbiByZXF1ZXN0IHRvIGNvdmVy
IGFueSBiaXQgZXZlbg0KPiBwYXJ0aWFsbHkgdG91Y2hlZCBieSB0aGUgc3BlY2lmaWVkIHJhbmdl
DQo+ICAgIG90aGVyd2lzZSwgcGFzcyByYW5nZSB0aHJvdWdoIGFzLWlzIHRvIGhiaXRtYXBfcmVz
ZXQgKGFuZCBwb3NzaWJseSBnZXQNCj4gLUVJTlZBTCBpZiBjYWxsZXIgZGlkIG5vdCBhbGlnbiB0
aGUgcmVxdWVzdC4pDQo+IA0KPiANCj4gVGhhdCB3YXkgdGhlIHNlbWFudGljcyBhcmUgYWx3YXlz
IGNsZWFyIHRvIHRoZSBjYWxsZXIuDQoNCkhtbSwgSSBkb3VidCwgaXMgdGhlcmUgYW55IHVzZSBv
ZiBBTElHTl9VUD8gSW4gbW9zdCBjYXNlcyBpdCdzIHNhZmUgdG8gdGhpbmcgdGhhdA0Kc29tZXRo
aW5nIGNsZWFyIGlzIGRpcnR5IChhbmQgdGhpcyBpcyBob3cgaGJpdG1hcCBhY3R1YWxseSB3b3Jr
cyBvbiBzZXQvZ2V0KSwgYnV0DQppdCBzZWVtcyBhbHdheXMgdW5zYWZlIHRvIEFMSUdOX1VQIHJl
c2V0Li4NCg0KU28sIEkgdGhpbmsgdGhhdCBpdCBzaG91bGQgYmUgZGVmYXVsdCB0byBBTElHTl9E
T1dOLCBvciBqdXN0IGFuIGFzc2VydGlvbiB0aGF0IHJlcXVlc3QNCmlzIGFsaWduZWQgKHdoaWNo
IGFueXdheSBsZWFkcyB0byBpbXBsZW1lbnRpbmcgYSBoZWxwZXIgaGJpdG1hcF9yZXNldF9hbGln
bl91cCkuLg0KDQo+IA0KPiAtLWpzDQo+IA0KPj4gICB0ZXN0cy90ZXN0LWhiaXRtYXAuYyB8ICAy
ICstDQo+PiAgIHV0aWwvaGJpdG1hcC5jICAgICAgIHwgMjQgKysrKysrKysrKysrKysrKysrKy0t
LS0tDQo+PiAgIDIgZmlsZXMgY2hhbmdlZCwgMjAgaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMo
LSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvdGVzdHMvdGVzdC1oYml0bWFwLmMgYi90ZXN0cy90ZXN0
LWhiaXRtYXAuYw0KPj4gaW5kZXggNTkyZDgyMTlkYi4uMDAwODAyNWE5ZiAxMDA2NDQNCj4+IC0t
LSBhL3Rlc3RzL3Rlc3QtaGJpdG1hcC5jDQo+PiArKysgYi90ZXN0cy90ZXN0LWhiaXRtYXAuYw0K
Pj4gQEAgLTQyNCw3ICs0MjQsNyBAQCBzdGF0aWMgdm9pZCB0ZXN0X2hiaXRtYXBfZ3JhbnVsYXJp
dHkoVGVzdEhCaXRtYXBEYXRhICpkYXRhLA0KPj4gICAgICAgaGJpdG1hcF90ZXN0X3NldChkYXRh
LCAwLCAzKTsNCj4+ICAgICAgIGdfYXNzZXJ0X2NtcGludChoYml0bWFwX2NvdW50KGRhdGEtPmhi
KSwgPT0sIDQpOw0KPj4gICAgICAgaGJpdG1hcF90ZXN0X3Jlc2V0KGRhdGEsIDAsIDEpOw0KPj4g
LSAgICBnX2Fzc2VydF9jbXBpbnQoaGJpdG1hcF9jb3VudChkYXRhLT5oYiksID09LCAyKTsNCj4+
ICsgICAgZ19hc3NlcnRfY21waW50KGhiaXRtYXBfY291bnQoZGF0YS0+aGIpLCA9PSwgNCk7DQo+
PiAgIH0NCj4+ICAgDQo+PiAgIHN0YXRpYyB2b2lkIHRlc3RfaGJpdG1hcF9pdGVyX2dyYW51bGFy
aXR5KFRlc3RIQml0bWFwRGF0YSAqZGF0YSwNCj4+IGRpZmYgLS1naXQgYS91dGlsL2hiaXRtYXAu
YyBiL3V0aWwvaGJpdG1hcC5jDQo+PiBpbmRleCA3OTA1MjEyYThiLi42MWE4MTM5OTRhIDEwMDY0
NA0KPj4gLS0tIGEvdXRpbC9oYml0bWFwLmMNCj4+ICsrKyBiL3V0aWwvaGJpdG1hcC5jDQo+PiBA
QCAtNDczLDE1ICs0NzMsMjkgQEAgdm9pZCBoYml0bWFwX3Jlc2V0KEhCaXRtYXAgKmhiLCB1aW50
NjRfdCBzdGFydCwgdWludDY0X3QgY291bnQpDQo+PiAgIHsNCj4+ICAgICAgIC8qIENvbXB1dGUg
cmFuZ2UgaW4gdGhlIGxhc3QgbGF5ZXIuICAqLw0KPj4gICAgICAgdWludDY0X3QgZmlyc3Q7DQo+
PiAtICAgIHVpbnQ2NF90IGxhc3QgPSBzdGFydCArIGNvdW50IC0gMTsNCj4+ICsgICAgdWludDY0
X3QgbGFzdDsNCj4+ICsgICAgdWludDY0X3QgZW5kID0gc3RhcnQgKyBjb3VudDsNCj4+ICsgICAg
dWludDY0X3QgZ3JhbiA9IFVJTlQ2NF9DKDEpIDw8IGhiLT5ncmFudWxhcml0eTsNCj4+ICAgDQo+
PiAtICAgIHRyYWNlX2hiaXRtYXBfcmVzZXQoaGIsIHN0YXJ0LCBjb3VudCwNCj4+IC0gICAgICAg
ICAgICAgICAgICAgICAgICBzdGFydCA+PiBoYi0+Z3JhbnVsYXJpdHksIGxhc3QgPj4gaGItPmdy
YW51bGFyaXR5KTsNCj4+ICsgICAgLyoNCj4+ICsgICAgICogV2Ugc2hvdWxkIGNsZWFyIG9ubHkg
Yml0cywgZnVsbHkgY292ZXJlZCBieSByZXF1ZXN0ZWQgcmVnaW9uLiBPdGhlcndpc2UNCj4+ICsg
ICAgICogd2UgbWF5IGNsZWFyIHNvbWV0aGluZyB0aGF0IGlzIGFjdHVhbGx5IHN0aWxsIGRpcnR5
Lg0KPj4gKyAgICAgKi8NCj4+ICsgICAgZmlyc3QgPSBESVZfUk9VTkRfVVAoc3RhcnQsIGdyYW4p
Ow0KPj4gICANCj4+IC0gICAgZmlyc3QgPSBzdGFydCA+PiBoYi0+Z3JhbnVsYXJpdHk7DQo+PiAt
ICAgIGxhc3QgPj49IGhiLT5ncmFudWxhcml0eTsNCj4+ICsgICAgaWYgKGVuZCA9PSBoYi0+b3Jp
Z19zaXplKSB7DQo+PiArICAgICAgICBlbmQgPSBESVZfUk9VTkRfVVAoZW5kLCBncmFuKTsNCj4+
ICsgICAgfSBlbHNlIHsNCj4+ICsgICAgICAgIGVuZCA9IGVuZCA+PiBoYi0+Z3JhbnVsYXJpdHk7
DQo+PiArICAgIH0NCj4+ICsgICAgaWYgKGVuZCA8PSBmaXJzdCkgew0KPj4gKyAgICAgICAgcmV0
dXJuOw0KPj4gKyAgICB9DQo+PiArICAgIGxhc3QgPSBlbmQgLSAxOw0KPj4gICAgICAgYXNzZXJ0
KGxhc3QgPCBoYi0+c2l6ZSk7DQo+PiAgIA0KPj4gKyAgICB0cmFjZV9oYml0bWFwX3Jlc2V0KGhi
LCBzdGFydCwgY291bnQsIGZpcnN0LCBsYXN0KTsNCj4+ICsNCj4+ICAgICAgIGhiLT5jb3VudCAt
PSBoYl9jb3VudF9iZXR3ZWVuKGhiLCBmaXJzdCwgbGFzdCk7DQo+PiAgICAgICBpZiAoaGJfcmVz
ZXRfYmV0d2VlbihoYiwgSEJJVE1BUF9MRVZFTFMgLSAxLCBmaXJzdCwgbGFzdCkgJiYNCj4+ICAg
ICAgICAgICBoYi0+bWV0YSkgew0KPj4NCg0KDQotLSANCkJlc3QgcmVnYXJkcywNClZsYWRpbWly
DQo=

