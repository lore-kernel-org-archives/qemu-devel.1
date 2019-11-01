Return-Path: <SRS0=V8KP=YZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 129E0CA9ECF
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2019 11:18:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C100820656
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2019 11:18:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="ncu1MhG0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C100820656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37798 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iQUxB-0007gf-M7
	for qemu-devel@archiver.kernel.org; Fri, 01 Nov 2019 07:18:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53206)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iQUvI-0006CN-8Z
 for qemu-devel@nongnu.org; Fri, 01 Nov 2019 07:16:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iQUvG-0001II-In
 for qemu-devel@nongnu.org; Fri, 01 Nov 2019 07:16:55 -0400
Received: from mail-eopbgr10117.outbound.protection.outlook.com
 ([40.107.1.117]:52726 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iQUvF-0001Go-Rp; Fri, 01 Nov 2019 07:16:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iJwXploQ/kNI41As5WSdztgkHpwBxh7XfCJhdYvemFyR2vG3gpuIfy7lHKxJ4uq0YV/qHCC8Q8Vu3V9nxdxojCtmjjqK2XVb88e+LV8ajAf+vR97kC99WFTX8VTYX0CGlyc1/BgG7WYTJrSZvi+Bx+30SoV2zZB/LEPf5eYEGK5DSYmWgzq91hKfRtmmUdN9K04x5uFkW/WkIckEguhbrMPYXADvl4BK3CzmzmvrcOvGVN8VwIOjv8Er2hkkYrFq5ytCFuNMJHly4ekk2QHZxBvuWyzPum977e6VMaVT85920KY4YmWDF2vEz8RiqjMxxnGFm7jSsgHs3k4I0AToPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZiIGHPaCqwIpljJ3LUrVSp5iqUxm/tqw0m/4vQ2pZzY=;
 b=NjG0Fg4AaBrlj9oPaIw/PuhSGpXQjSOSwsHkA7oanpFFo5J9Hb+Syo0n5kUTAIm/jHqW4XJa8TBWUIJ0ihDRzFMZnwzVzgkWfqNgzjHKup+vz0NIYoevgl8Ja4jJ1C25eY7hsL7ccjo8R1Jm3ZhDgzu2AIXNLhHioUKrxMLfplQxw7lRECzn4v294Ko5jlt3O33EOX1AcRyWN1v+rjknF50sqyVbCgsJG9uBvbykmOAimcDYI01j6rUTpsk7Dbjh0cDT3DjzOKGgI65sUFnZVOsX/cwWT4IGhYJdwj8KhuhMbY0bKOrA+31oVEyLC97hQKBUMKTKvPeMT8ocvr9gLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZiIGHPaCqwIpljJ3LUrVSp5iqUxm/tqw0m/4vQ2pZzY=;
 b=ncu1MhG0dKcovddURjbrx9HF4ujpDXNcIIBw1Or7yHpXyftbb2/UaDTOAMoJ6M+4uIFJg41isxXcqYU9OX2l8gW9rarm6xm6GL89s8WCsla5r86sSrxfZ93KXLt+P2BVrdWrPB9sJpVINhJ+ZI26iTwjSLTrPb7qfq87oXf+B0Y=
Received: from AM0PR08MB4097.eurprd08.prod.outlook.com (20.178.202.217) by
 AM0PR08MB5057.eurprd08.prod.outlook.com (10.255.31.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Fri, 1 Nov 2019 11:16:49 +0000
Received: from AM0PR08MB4097.eurprd08.prod.outlook.com
 ([fe80::6844:bb8c:7d2c:b119]) by AM0PR08MB4097.eurprd08.prod.outlook.com
 ([fe80::6844:bb8c:7d2c:b119%6]) with mapi id 15.20.2408.019; Fri, 1 Nov 2019
 11:16:49 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Subject: Re: [PATCH for-4.2 0/4] qcow2: Fix data corruption on XFS
Thread-Topic: [PATCH for-4.2 0/4] qcow2: Fix data corruption on XFS
Thread-Index: AQHVkJs1nNWugfYf7EOzXc04zyxgzKd2Gq6AgAA0uAD//9oFAIAAARGA
Date: Fri, 1 Nov 2019 11:16:48 +0000
Message-ID: <fb5ae941-622f-c82d-9eb8-be3fe66e3fb6@virtuozzo.com>
References: <20191101100019.9512-1-mreitz@redhat.com>
 <fbf32283-2ec5-28ae-f4c9-5bd7d4af7b3f@redhat.com>
 <783a805a-3a3a-e8c5-41ac-f6476378975e@virtuozzo.com>
 <908ffc42-8328-969d-641b-4596ec0b6b45@redhat.com>
In-Reply-To: <908ffc42-8328-969d-641b-4596ec0b6b45@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR06CA0152.eurprd06.prod.outlook.com
 (2603:10a6:7:16::39) To AM0PR08MB4097.eurprd08.prod.outlook.com
 (2603:10a6:208:132::25)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191101141646996
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8c0a59e7-0f87-4cc7-43d9-08d75ebcfcf5
x-ms-traffictypediagnostic: AM0PR08MB5057:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR08MB5057308352BAF0B0344ED890C1620@AM0PR08MB5057.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:972;
x-forefront-prvs: 020877E0CB
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(346002)(376002)(136003)(366004)(39840400004)(189003)(199004)(52314003)(6486002)(316002)(25786009)(99286004)(66946007)(66476007)(66556008)(64756008)(66446008)(5660300002)(71200400001)(71190400001)(6512007)(110136005)(54906003)(76176011)(52116002)(31696002)(3846002)(6116002)(6506007)(6306002)(386003)(53546011)(102836004)(36756003)(31686004)(478600001)(7736002)(305945005)(107886003)(486006)(186003)(14454004)(256004)(26005)(86362001)(2906002)(6246003)(229853002)(8936002)(14444005)(4326008)(2501003)(66066001)(8676002)(81156014)(81166006)(446003)(2616005)(11346002)(6436002)(476003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB5057;
 H:AM0PR08MB4097.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: X00zrd99DZoxvcs2trcwndt/tml4TWsu5qfmRaYhVZ3lM4GLJDETSApPAGL7rFRiWwrAwUlJd+LhndBA9xE+WEfZekOkzqoh5E/TLEnZGiYOwXHvyD9AwVbpsXJZeCkeiA9afOmZUaEXdDmIeJDAcA6lrEwD4+8pZWBNopRwdstLgd4o5cDatYnRDvCNMaLvEWDbho0qk6BLoohmO+SetrOqF6QtZUhAbpCb+vdkgaoQtCVP6anXUqjQ0MOaKxLZU7XZBDsXlBFaduKeoAUtRXL9iQDnsnorW6g8HN/BmDzP0nfNN5xe4B+rFMC8jsyu3ZtQIr7AUtAGmAhtAfRbxJV/lfqcki73rmozduyj+igHnt5LsdEUMsSogPPe4BqiudEdpD/D+i9mEUDkzOKmdkBS3Q0gl6LKfNPQ19ZG6BRArLe9a/k4jAE+HDYU+8UlG2GzPNR51nC1jmDWs5Q1RRr6lxZcdBPwSC2wan8n+po=
Content-Type: text/plain; charset="utf-8"
Content-ID: <99C40A46B2B699449D956E4F511554B9@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c0a59e7-0f87-4cc7-43d9-08d75ebcfcf5
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Nov 2019 11:16:49.0487 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zmb1i28wu9b/y5D6ynJG4rDdlMnzSQcxQFqQ8zdn+m7/QCZFDrpc+4pkY96wwqZyXunF17vTrbTUk0H/EPz6CTDTkHhYguSD1n4j5efUlnI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB5057
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.1.117
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
Cc: Kevin Wolf <kwolf@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MDEuMTEuMjAxOSAxNDoxMiwgTWF4IFJlaXR6IHdyb3RlOg0KPiBPbiAwMS4xMS4xOSAxMToyOCwg
VmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4+IDAxLjExLjIwMTkgMTM6MjAs
IE1heCBSZWl0eiB3cm90ZToNCj4+PiBPbiAwMS4xMS4xOSAxMTowMCwgTWF4IFJlaXR6IHdyb3Rl
Og0KPj4+PiBIaSwNCj4+Pj4NCj4+Pj4gVGhpcyBzZXJpZXMgYnVpbGRzIG9uIHRoZSBwcmV2aW91
cyBSRkMuICBUaGUgd29ya2Fyb3VuZCBpcyBub3cgYXBwbGllZA0KPj4+PiB1bmNvbmRpdGlvbmFs
bHkgb2YgQUlPIG1vZGUgYW5kIGZpbGVzeXN0ZW0gYmVjYXVzZSB3ZSBkb27igJl0IGtub3cgdGhv
c2UNCj4+Pj4gdGhpbmdzIGZvciByZW1vdGUgZmlsZXN5c3RlbXMuICBGdXJ0aGVybW9yZSwgYmRy
dl9jb19nZXRfc2VsZl9yZXF1ZXN0KCkNCj4+Pj4gaGFzIGJlZW4gbW92ZWQgdG8gYmxvY2svaW8u
Yy4NCj4+Pj4NCj4+Pj4gQXBwbHlpbmcgdGhlIHdvcmthcm91bmQgdW5jb25kaXRpb25hbGx5IGlz
IGZpbmUgZnJvbSBhIHBlcmZvcm1hbmNlDQo+Pj4+IHN0YW5kcG9pbnQsIGJlY2F1c2UgaXQgc2hv
dWxkIGFjdHVhbGx5IGJlIGRlYWQgY29kZSwgdGhhbmtzIHRvIHBhdGNoIDENCj4+Pj4gKHRoZSBl
bGVwaGFudCBpbiB0aGUgcm9vbSkuICBBcyBmYXIgYXMgSSBrbm93LCB0aGVyZSBpcyBubyBvdGhl
ciBibG9jaw0KPj4+PiBkcml2ZXIgYnV0IHFjb3cyIGluIGhhbmRsZV9hbGxvY19zcGFjZSgpIHRo
YXQgd291bGQgc3VibWl0IHplcm8gd3JpdGVzDQo+Pj4+IGFzIHBhcnQgb2Ygbm9ybWFsIEkvTyBz
byBpdCBjYW4gb2NjdXIgY29uY3VycmVudGx5IHRvIG90aGVyIHdyaXRlDQo+Pj4+IHJlcXVlc3Rz
LiAgSXQgc3RpbGwgbWFrZXMgc2Vuc2UgdG8gdGFrZSB0aGUgd29ya2Fyb3VuZCBmb3IgZmlsZS1w
b3NpeA0KPj4+PiBiZWNhdXNlIHdlIGNhbuKAmXQgcmVhbGx5IHByZXZlbnQgdGhhdCBhbnkgb3Ro
ZXIgYmxvY2sgZHJpdmVyIHdpbGwgc3VibWl0DQo+Pj4+IHplcm8gd3JpdGVzIGFzIHBhcnQgb2Yg
bm9ybWFsIEkvTyBpbiB0aGUgZnV0dXJlLg0KPj4+Pg0KPj4+PiBBbnl3YXksIGxldOKAmXMgZ2V0
IHRvIHRoZSBlbGVwaGFudC4NCj4+Pj4NCj4+Pj4gICBGcm9tIGlucHV0IGJ5IFhGUyBkZXZlbG9w
ZXJzDQo+Pj4+IChodHRwczovL2J1Z3ppbGxhLnJlZGhhdC5jb20vc2hvd19idWcuY2dpP2lkPTE3
NjU1NDcjYzcpIGl0IHNlZW1zIGNsZWFyDQo+Pj4+IHRoYXQgYzhiYjIzY2JkYmUgY2F1c2VzIGZ1
bmRhbWVudGFsIHBlcmZvcm1hbmNlIHByb2JsZW1zIG9uIFhGUyB3aXRoDQo+Pj4+IGFpbz1uYXRp
dmUgdGhhdCBjYW5ub3QgYmUgZml4ZWQuICBJbiBvdGhlciBjYXNlcywgYzhiYjIzY2JkYmUgaW1w
cm92ZXMNCj4+Pj4gcGVyZm9ybWFuY2Ugb3Igd2Ugd291bGRu4oCZdCBoYXZlIGl0Lg0KPj4+Pg0K
Pj4+PiBJbiBnZW5lcmFsLCBhdm9pZGluZyBwZXJmb3JtYW5jZSByZWdyZXNzaW9ucyBpcyBtb3Jl
IGltcG9ydGFudCB0aGFuDQo+Pj4+IGltcHJvdmluZyBwZXJmb3JtYW5jZSwgdW5sZXNzIHRoZSBy
ZWdyZXNzaW9ucyBhcmUganVzdCBhIG1pbm9yIGNvcm5lcg0KPj4+PiBjYXNlIG9yIGluc2lnbmlm
aWNhbnQgd2hlbiBjb21wYXJlZCB0byB0aGUgaW1wcm92ZW1lbnQuICBUaGUgWEZTDQo+Pj4+IHJl
Z3Jlc3Npb24gaXMgbm8gbWlub3IgY29ybmVyIGNhc2UsIGFuZCBpdCBpc27igJl0IGluc2lnbmlm
aWNhbnQuICBMYXVyZW50DQo+Pj4+IFZpdmllciBoYXMgZm91bmQgcGVyZm9ybWFuY2UgdG8gZGVj
cmVhc2UgYnkgYXMgbXVjaCBhcyA4OCAlIChvbiBwcGM2NGxlLA0KPj4+PiBmaW8gaW4gYSBndWVz
dCB3aXRoIDRrIGJsb2NrcywgaW9kZXB0aD04OiAxNjYyIGtCL3MgZnJvbSAxMy45IE1CL3MpLg0K
Pj4+DQo+Pj4gQWgsIGNyYXAuDQo+Pj4NCj4+PiBJIHdhbnRlZCB0byBzZW5kIHRoaXMgc2VyaWVz
IGFzIGVhcmx5IHRvZGF5IGFzIHBvc3NpYmxlIHRvIGdldCBhcyBtdWNoDQo+Pj4gZmVlZGJhY2sg
YXMgcG9zc2libGUsIHNvIEnigJl2ZSBvbmx5IHN0YXJ0ZWQgZG9pbmcgYmVuY2htYXJrcyBub3cu
DQo+Pj4NCj4+PiBUaGUgb2J2aW91cw0KPj4+DQo+Pj4gJCBxZW11LWltZyBiZW5jaCAtdCBub25l
IC1uIC13IC1TIDY1NTM2IHRlc3QucWNvdzINCj4+Pg0KPj4+IG9uIFhGUyB0YWtlcyBsaWtlIDYg
c2Vjb25kcyBvbiBtYXN0ZXIsIGFuZCBsaWtlIDUwIHRvIDgwIHNlY29uZHMgd2l0aA0KPj4+IGM4
YmIyM2NiZGJlIHJldmVydGVkLiAgU28gbm93IG9uIHRvIGd1ZXN0IHRlc3RzLi4uDQo+Pg0KPj4g
QWhhLCB0aGF0J3MgdmVyeSBpbnRlcmVzdGluZykgV2hhdCBhYm91dCBhaW8tbmF0aXZlIHdoaWNo
IHNob3VsZCBiZSBzbG93ZWQgZG93bj8NCj4+IENvdWxkIGl0IGJlIHRlc3RlZCBsaWtlIHRoaXM/
DQo+IA0KPiBUaGF0IGlzIGFpbz1uYXRpdmUgKC1uKS4NCj4gDQo+IEJ1dCBzbyBmYXIgSSBkb27i
gJl0IHNlZSBhbnkgc2lnbmlmaWNhbnQgZGlmZmVyZW5jZSBpbiBndWVzdCB0ZXN0cyAoaS5lLiwN
Cj4gZmlvIC0tcnc9d3JpdGUgLS1icz00ayAtLWlvZGVwdGg9OCAtLXJ1bnRpbWU9MW0gLS1kaXJl
Y3Q9MQ0KPiAtLWlvZW5naW5lPWxpYmFpbyAtLXRocmVhZCAtLW51bWpvYnM9MTYgLS1zaXplPTJH
IC0tdGltZV9iYXNlZCksIG5laXRoZXINCj4gd2l0aCA2NCBrQiBub3Igd2l0aCAyIE1CIGNsdXN0
ZXJzLiAgKEJ1dCBvbmx5IG9uIFhGUywgSeKAmWxsIGhhdmUgdG8gc2VlDQo+IGFib3V0IGV4dDQg
c3RpbGwuKQ0KDQpobW0sIHRoaXMgcG9zc2libHkgbW9zdGx5IHRlc3RzIHdyaXRlcyB0byBhbHJl
YWR5IGFsbG9jYXRlZCBjbHVzdGVycy4gSGFzIGZpbw0KYW4gb3B0aW9uIHRvIGJlaGF2ZSBsaWtl
IHFlbXUtaW1nIGJlbmNoIHdpdGggLVMgNjU1MzYsIGkuZS4gd3JpdGUgb25jZSBpbnRvDQplYWNo
IGNsdXN0ZXI/DQoNCj4gDQo+IChSZXZlcnRpbmcgYzhiYjIzY2JkYmUgbWFrZXMgaXQgbGlrZSAx
IHRvIDIgJSBmYXN0ZXIuKQ0KPiANCj4gTWF4DQo+IA0KDQoNCi0tIA0KQmVzdCByZWdhcmRzLA0K
VmxhZGltaXINCg==

