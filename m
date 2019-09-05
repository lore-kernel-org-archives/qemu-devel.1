Return-Path: <SRS0=/Jg5=XA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9562C3A5A5
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2019 07:45:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6299D2082E
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2019 07:45:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="KGuoNyz+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6299D2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42910 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5mRv-0003n7-Jd
	for qemu-devel@archiver.kernel.org; Thu, 05 Sep 2019 03:44:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51148)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1i5mRC-0003Hl-1J
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 03:44:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1i5mRA-0002a2-17
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 03:44:13 -0400
Received: from mail-eopbgr40098.outbound.protection.outlook.com
 ([40.107.4.98]:55716 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dplotnikov@virtuozzo.com>)
 id 1i5mR9-0002YJ-As; Thu, 05 Sep 2019 03:44:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ObAbpWlMEG8lebZNyMF7Ysrpz3zTY3LrShzJC4MULNFU7iHRYve3fk8eerlGgqmzvaybLY1ZeC5XTHbSx32qm2spbENNIvjTXeOumZk+R0Znt229q61vvM26J0kyZ6McWsz1oEXV+HG2hTWBOPmPZpz/45ycM+hQk7xvp2TK0IXvkpSLpcAFVdu+A3OyFV4WeVip+gldf5ltnQmcQF0FOP27BXfRz0pnwyN6tpCw7Hr8hGNTd+1LfX+JXSjVEvuy5JeiBbStqI3mO0+dE2/gUkK40ETx3KqeHp4+xoBVWoC+RnyN0MjbBnGAxSeu6NGYP78vZVb+p5VvgeqF20qdAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+YFDJ1cuEYVRtvPkQnvBRA/ZogGiBH3Y0GjnMrGSZ+E=;
 b=mGEfeo+UwJAigSkl7ag+5feCW388MWGCnPkCCV9voUpJsSS+WEuaUvmbIb5rzGqq0TmwFHwNvPG7916JgTILmC1WzJ1LXZOsXN6AK2iCYcx9zlgrNEWVIKuPR5FuQMX922BaNUhZi0xYCH72XV1Zcodxx9prCROdgafLbl9wzc6hz5kriE2SftiarWaScdPnoeBY+kvPeYMaCvn1/tL97+usrSy4DGs4h9an9WKx1UqAUGl8soFXKBoE0VSYyn1OL579hNs8Y6lfBWP3ycgURHbjnUkDmJVjM+xKE79xaDeucfuUF2bUHOv6TK2wuyUxqNFuXGHfdw7etAzdonoxag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+YFDJ1cuEYVRtvPkQnvBRA/ZogGiBH3Y0GjnMrGSZ+E=;
 b=KGuoNyz+Vi9wNUbJdPnOgN/DCHC3osh/GzqCNQE2koJiOyfapk/aCYp/xDaSFq120hUd+pKN4Vx9yGtLh9c0c1TKkG0JPC5lHduelZBrkuELTuxFOr4KIfD2jKDedzU6U6XgpHR8nMdchqlGxqam3vFkuHFc3eveZG3C9SLxseY=
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com (20.178.22.27) by
 AM0PR08MB3940.eurprd08.prod.outlook.com (20.178.117.83) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2220.20; Thu, 5 Sep 2019 07:44:07 +0000
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com
 ([fe80::302b:b479:1322:9d31]) by AM0PR08MB3745.eurprd08.prod.outlook.com
 ([fe80::302b:b479:1322:9d31%5]) with mapi id 15.20.2241.014; Thu, 5 Sep 2019
 07:44:07 +0000
From: Denis Plotnikov <dplotnikov@virtuozzo.com>
To: Eric Blake <eblake@redhat.com>, "armbru@redhat.com" <armbru@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Thread-Topic: [PATCH v5 3/3] qcow2: add zstd cluster compression
Thread-Index: AQHVYzruEZDsZDoirUyQ0IuQtSHLpKcctO0A
Date: Thu, 5 Sep 2019 07:44:07 +0000
Message-ID: <1feb49e1-bab1-ac10-3232-95d696995b96@virtuozzo.com>
References: <20190904152915.30755-1-dplotnikov@virtuozzo.com>
 <20190904152915.30755-4-dplotnikov@virtuozzo.com>
 <2ff3dc82-ea8c-10a8-fb4c-8081abc3775e@redhat.com>
In-Reply-To: <2ff3dc82-ea8c-10a8-fb4c-8081abc3775e@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dplotnikov@virtuozzo.com; 
x-originating-ip: [31.180.210.224]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fa8ccd56-ef49-4319-0345-08d731d4d547
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:AM0PR08MB3940; 
x-ms-traffictypediagnostic: AM0PR08MB3940:
x-ms-exchange-purlcount: 3
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR08MB39401E09F19DFB3097FBEE54CFBB0@AM0PR08MB3940.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3513;
x-forefront-prvs: 015114592F
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(366004)(376002)(346002)(136003)(39850400004)(396003)(189003)(199004)(478600001)(26005)(2501003)(66556008)(66476007)(11346002)(2616005)(476003)(186003)(316002)(64756008)(2906002)(102836004)(76116006)(14444005)(7736002)(66446008)(99286004)(6506007)(25786009)(53546011)(4326008)(229853002)(71190400001)(71200400001)(76176011)(256004)(6486002)(6246003)(53376002)(3846002)(31696002)(6512007)(486006)(66066001)(14454004)(305945005)(19273905006)(86362001)(81156014)(81166006)(6436002)(8676002)(6116002)(36756003)(5660300002)(2201001)(446003)(53936002)(54906003)(110136005)(66946007)(8936002)(31686004)(6306002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB3940;
 H:AM0PR08MB3745.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: yiqEonXmYf8vXUbAD4/1pYHAQQ42oEBo4Vhgi3857h1DjooqhtOsyrw/doPhf/6SliNTb/KlGOAjeBmG866EZydMsfGC3I/PAOruxz8sYQFbPOr5hpZMbI261EO6kXf6BBlu+ERoQcsOgOky8D98eRTeoF6sUhSQSdADdz8WpaTyyRtaeRoeoSOhAnytoai038NSPip9R4KB8XVww1KC9PNm8Kbu80tXvsTB2N33cohdcNZtqcMtVCZ31uJn3NjiamYMaySYfL3q9olZuNmzkgX0MrPzhEKajfBh3hAJgSgj8ElNSwXcKp09/OLPCe0d8xuN/88S22U7PfYg7chT9dvu8tPRiap/Nvu4caOM9VHPEF4dIO1h8iVWFkFWFDT/M88V8RsDMGZ15SDp0zaERtavPl5hhRlxoMyXYSl83wQ=
Content-Type: text/plain; charset="utf-8"
Content-ID: <92CD2212A0707240AA1AE704615FC32F@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa8ccd56-ef49-4319-0345-08d731d4d547
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2019 07:44:07.5164 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AQOPHnSad5WcBT5pq7TiYJhn15+cbfZSByIw7pxf10/wtuWq7lVojsHwzkBo//HOdHpLdKUE5W25GesG8J48WHISmi/7hW2lOeRCcuVN/GI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3940
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.4.98
Subject: Re: [Qemu-devel] [PATCH v5 3/3] qcow2: add zstd cluster compression
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
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Denis Lunev <den@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

T24gMDQuMDkuMjAxOSAxOTowNywgRXJpYyBCbGFrZSB3cm90ZToNCj4gT24gOS80LzE5IDEwOjI5
IEFNLCBEZW5pcyBQbG90bmlrb3Ygd3JvdGU6DQo+PiB6c3RkIHNpZ25pZmljYW50bHkgcmVkdWNl
cyBjbHVzdGVyIGNvbXByZXNzaW9uIHRpbWUuDQo+PiBJdCBwcm92aWRlcyBiZXR0ZXIgY29tcHJl
c3Npb24gcGVyZm9ybWFuY2UgbWFpbnRhaW5pbmcNCj4+IHRoZSBzYW1lIGxldmVsIG9mIGNvbXBy
ZXNzaW9uIHJhdGlvIGluIGNvbXBhcmlzb24gd2l0aA0KPj4gemxpYiwgd2hpY2gsIGF0IHRoZSBt
b21lbnQsIGhhcyBiZWVuIHRoZSBvbmx5IGNvbXByZXNzaW9uDQo+PiBtZXRob2QgYXZhaWxhYmxl
Lg0KPj4NCj4+IFRoZSBwZXJmb3JtYW5jZSB0ZXN0IHJlc3VsdHM6DQo+PiBUZXN0IGNvbXByZXNz
ZXMgYW5kIGRlY29tcHJlc3NlcyBxZW11IHFjb3cyIGltYWdlIHdpdGgganVzdA0KPj4gaW5zdGFs
bGVkIHJoZWwtNy42IGd1ZXN0Lg0KPj4gSW1hZ2UgY2x1c3RlciBzaXplOiA2NEsuIEltYWdlIG9u
IGRpc2sgc2l6ZTogMi4yRw0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IERlbmlzIFBsb3RuaWtvdiA8
ZHBsb3RuaWtvdkB2aXJ0dW96em8uY29tPg0KPj4gLS0tDQo+PiArc3RhdGljIHNzaXplX3QgcWNv
dzJfenN0ZF9jb21wcmVzcyh2b2lkICpkZXN0LCBzaXplX3QgZGVzdF9zaXplLA0KPj4gKyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgY29uc3Qgdm9pZCAqc3JjLCBzaXplX3Qgc3Jj
X3NpemUpDQo+PiArew0KPj4gKyAgICBzc2l6ZV90IHJldDsNCj4+ICsgICAgdWludDMyX3QgKmNf
c2l6ZSA9IGRlc3Q7DQo+IFBvdGVudGlhbGx5IHVuYWxpZ25lZCBwb2ludGVyLi4uDQo+DQo+PiAr
ICAgIC8qIHN0ZWFsIHNvbWUgYnl0ZXMgdG8gc3RvcmUgY29tcHJlc3NlZCBjaHVuayBzaXplICov
DQo+PiArICAgIGNoYXIgKmRfYnVmID0gKChjaGFyICopIGRlc3QpICsgc2l6ZW9mKCpjX3NpemUp
Ow0KPj4gKw0KPj4gKyAgICAvKiBzYW5pdHkgY2hlY2sgdGhhdCB3ZSBjYW4gc3RvcmUgdGhlIGNv
bXByZXNzZWQgZGF0YSBsZW5ndGggKi8NCj4+ICsgICAgaWYgKGRlc3Rfc2l6ZSA8IHNpemVvZigq
Y19zaXplKSkgew0KPj4gKyAgICAgICAgcmV0dXJuIC1FTk9NRU07DQo+PiArICAgIH0NCj4+ICsN
Cj4+ICsgICAgZGVzdF9zaXplIC09IHNpemVvZigqY19zaXplKTsNCj4+ICsNCj4+ICsgICAgcmV0
ID0gWlNURF9jb21wcmVzcyhkX2J1ZiwgZGVzdF9zaXplLCBzcmMsIHNyY19zaXplLCA1KTsNCj4+
ICsNCj4+ICsgICAgaWYgKFpTVERfaXNFcnJvcihyZXQpKSB7DQo+PiArICAgICAgICBpZiAoWlNU
RF9nZXRFcnJvckNvZGUocmV0KSA9PSBaU1REX2Vycm9yX2RzdFNpemVfdG9vU21hbGwpIHsNCj4+
ICsgICAgICAgICAgICByZXR1cm4gLUVOT01FTTsNCj4+ICsgICAgICAgIH0gZWxzZSB7DQo+PiAr
ICAgICAgICAgICAgcmV0dXJuIC1FSU87DQo+PiArICAgICAgICB9DQo+PiArICAgIH0NCj4+ICsN
Cj4+ICsgICAgLyogc3RvcmUgdGhlIGNvbXByZXNzZWQgY2h1bmsgc2l6ZSBpbiB0aGUgdmVyeSBi
ZWdpbm5pbmcgb2YgdGhlIGJ1ZmZlciAqLw0KPj4gKyAgICAqY19zaXplID0gY3B1X3RvX2JlMzIo
cmV0KTsNCj4gLi4uYW5kIHlvdSBhcmUgc3RvcmluZyBpbnRvIGl0LiAgWW91IGFyZSB1c2luZyB0
aGUgd3JvbmcgY29udmVyc2lvbg0KPiBmdW5jdGlvbjsgeW91IHdhbnQgc3RsX2JlX3AoZGVzdCwg
cmV0KSBvciBzaW1pbGFyLg0KPg0KPj4gK3N0YXRpYyBzc2l6ZV90IHFjb3cyX3pzdGRfZGVjb21w
cmVzcyh2b2lkICpkZXN0LCBzaXplX3QgZGVzdF9zaXplLA0KPj4gKyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBjb25zdCB2b2lkICpzcmMsIHNpemVfdCBzcmNfc2l6ZSkNCj4+
ICt7DQo+PiArICAgIHNzaXplX3QgcmV0Ow0KPj4gKyAgICAvKg0KPj4gKyAgICAgKiB6c3RkIGRl
Y29tcHJlc3Mgd2FudHMgdG8ga25vdyB0aGUgZXhhY3QgbGVuZ3RoIG9mIHRoZSBkYXRhDQo+PiAr
ICAgICAqIGZvciB0aGF0IHB1cnBvc2UsIG9uIHRoZSBjb21wcmVzc2lvbiB0aGUgbGVuZ3RoIGlz
IHN0b3JlZCBpbg0KPiBzL2RhdGEgZm9yL2RhdGEuIEZvci8NCj4gcy9vbiB0aGUgY29tcHJlc3Np
b24vb24gY29tcHJlc3Npb24sLw0KPg0KPj4gKyAgICAgKiB0aGUgdmVyeSBiZWdpbm5pbmcgb2Yg
dGhlIGNvbXByZXNzZWQgYnVmZmVyDQo+PiArICAgICAqLw0KPj4gKyAgICB1aW50MzJfdCBzX3Np
emU7DQo+PiArICAgIGNvbnN0IGNoYXIgKnNfYnVmID0gKChjb25zdCBjaGFyICopIHNyYykgKyBz
aXplb2Yoc19zaXplKTsNCj4+ICsNCj4+ICsgICAgLyogc2FuaXR5IGNoZWNrIHRoYXQgd2UgY2Fu
IHJlYWQgdGhlIGNvbnRlbnQgbGVuZ3RoICovDQo+PiArICAgIGlmIChzcmNfc2l6ZSA8IHNpemVv
ZihzX3NpemUpKSB7DQo+IFNob3VsZCB0aGlzIHVzZSA8PT8gIEFmdGVyIGFsbCwgSSBzZXJpb3Vz
bHkgZG91YnQgeW91IGNhbiBnZXQgYSAwLWJ5dGUNCj4gY29tcHJlc3Npb24gc3RyZWFtLg0KPg0K
Pj4gKyAgICAgICAgcmV0dXJuIC1FSU87DQo+PiArICAgIH0NCj4+ICsNCj4+ICsgICAgc19zaXpl
ID0gYmUzMl90b19jcHUoKihjb25zdCB1aW50MzJfdCAqKSBzcmMpOw0KPiBBcyB3cml0dGVuLCB0
aGlzIGxvb2tzIGxpa2UgeW91IG1heSBiZSBkZXJlZmVyZW5jaW5nIGFuIHVuYWxpZ25lZA0KPiBw
b2ludGVyLiAgSXQgc28gaGFwcGVucyB0aGF0IGJlMzJfdG9fY3B1KCkgYXBwbGllcyAmIHRvIHlv
dXIgKiB0byBnZXQNCj4gYmFjayBhdCB0aGUgcmF3IHBvaW50ZXIsIGFuZCB0aGVuIGlzIGNhcmVm
dWwgdG8gaGFuZGxlIHVuYWxpZ25lZA0KPiBwb2ludGVycywgc28gaXQgd29ya3M7IGJ1dCBpdCB3
b3VsZCBsb29rIGEgbG90IG5pY2VyIGFzIG1lcmVseToNCj4NCj4gc19zaXplID0gYmUzMl90b19j
cHUoc3JjKTsNCg0KeWVzLCBidXQgSSBjYW4ndCB1c2UgYmUzMl90b19jcHUoKnNyYykgc2luY2Ug
c3JjIGlzIGEgdm9pZCBwb2ludGVyDQoNCkRlbmlzDQoNCj4NCj4+ICsNCj4+ICsgICAgLyogc2Fu
aXR5IGNoZWNrIHRoYXQgdGhlIGJ1ZmZlciBpcyBiaWcgZW5vdWdoIHRvIHJlYWQgdGhlIGNvbnRl
bnQgKi8NCj4+ICsgICAgaWYgKHNyY19zaXplIC0gc2l6ZW9mKHNfc2l6ZSkgPCBzX3NpemUpIHsN
Cj4gV2h5IDwgYW5kIG5vdCAhPT8gIEFzIHdyaXR0ZW4sIHlvdSBhcmUgc2lsZW50bHkgaWdub3Jp
bmcgdHJhaWxpbmcNCj4gZ2FyYmFnZSwgaW5zdGVhZCBvZiB0cmVhdGluZyBpdCBhcyBhIGNsaWVu
dCB0aGF0IGRpZCBub3Qgd3JpdGUgdGhlIGRhdGENCj4gY29ycmVjdGx5Lg0KPg0KPj4gKysrIGIv
ZG9jcy9pbnRlcm9wL3Fjb3cyLnR4dA0KPj4gQEAgLTE4MSw2ICsxODEsNyBAQCBpbiB0aGUgZGVz
Y3JpcHRpb24gb2YgYSBmaWVsZC4NCj4+ICAgICAgICAgICAgICAgICAgICAgICBtdXN0IGJlIHNl
dC4NCj4+ICAgICAgICAgICAgICAgICAgICAgICBBdmFpbGFibGUgY29tcHJlc3Npb24gdHlwZSB2
YWx1ZXM6DQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgIDA6IHpsaWIgPGh0dHBzOi8vd3d3
LnpsaWIubmV0Lz4gKGRlZmF1bHQpDQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgMTogenN0
ZCA8aHR0cDovL2dpdGh1Yi5jb20vZmFjZWJvb2svenN0ZD4NCj4gQXQgdGhpcyBwb2ludCwgdGhp
cyBsaXN0aW5nIGlzIGFsbW9zdCByZWR1bmRhbnQgd2l0aCB0aGUgbW9yZS1kZXRhaWxlZA0KPiBo
ZWFkZXIgYmVsb3cuICBNYXliZSBpdCBpcyB3b3J0aCBqdXN0IGZvcndhcmQgcmVmZXJlbmNpbmcg
dGhhdCBzZWN0aW9uDQo+IGZvciBhIGxpc3Rpbmcgb2YgdmFsaWQgdmFsdWVzLCBhbmQgdGhlbiBt
ZW50aW9uaW5nIHRoZSB2YWx1ZXMgMCBhbmQgMSBpbg0KPiB0aGF0IHNlY3Rpb24/DQo+DQo+PiAg
IA0KPj4gICBEaXJlY3RseSBhZnRlciB0aGUgaW1hZ2UgaGVhZGVyLCBvcHRpb25hbCBzZWN0aW9u
cyBjYWxsZWQgaGVhZGVyIGV4dGVuc2lvbnMgY2FuDQo+PiAgIGJlIHN0b3JlZC4gRWFjaCBleHRl
bnNpb24gaGFzIGEgc3RydWN0dXJlIGxpa2UgdGhlIGZvbGxvd2luZzoNCj4+IEBAIC01MzYsNiAr
NTM3LDkgQEAgQ29tcHJlc3NlZCBDbHVzdGVycyBEZXNjcmlwdG9yICh4ID0gNjIgLSAoY2x1c3Rl
cl9iaXRzIC0gOCkpOg0KPj4gICAgICAgICAgICAgICAgICAgICAgIEFub3RoZXIgY29tcHJlc3Nl
ZCBjbHVzdGVyIG1heSBtYXAgdG8gdGhlIHRhaWwgb2YgdGhlIGZpbmFsDQo+PiAgICAgICAgICAg
ICAgICAgICAgICAgc2VjdG9yIHVzZWQgYnkgdGhpcyBjb21wcmVzc2VkIGNsdXN0ZXIuDQo+PiAg
IA0KPj4gKyAgICAgICAgICAgICAgICAgICAgVGhlIGxheW91dCBvZiB0aGUgY29tcHJlc3NlZCBk
YXRhIGRlcGVuZHMgb24gdGhlIGNvbXByZXNzaW9uDQo+PiArICAgICAgICAgICAgICAgICAgICB0
eXBlIHVzZWQgZm9yIHRoZSBpbWFnZSAoc2VlIGNvbXByZXNzZWQgY2x1c3RlciBsYXlvdXQpLg0K
Pj4gKw0KPj4gICBJZiBhIGNsdXN0ZXIgaXMgdW5hbGxvY2F0ZWQsIHJlYWQgcmVxdWVzdHMgc2hh
bGwgcmVhZCB0aGUgZGF0YSBmcm9tIHRoZSBiYWNraW5nDQo+PiAgIGZpbGUgKGV4Y2VwdCBpZiBi
aXQgMCBpbiB0aGUgU3RhbmRhcmQgQ2x1c3RlciBEZXNjcmlwdG9yIGlzIHNldCkuIElmIHRoZXJl
IGlzDQo+PiAgIG5vIGJhY2tpbmcgZmlsZSBvciB0aGUgYmFja2luZyBmaWxlIGlzIHNtYWxsZXIg
dGhhbiB0aGUgaW1hZ2UsIHRoZXkgc2hhbGwgcmVhZA0KPj4gQEAgLTc4OCwzICs3OTIsMTkgQEAg
SW4gdGhlIGltYWdlIGZpbGUgdGhlICdlbmFibGVkJyBzdGF0ZSBpcyByZWZsZWN0ZWQgYnkgdGhl
ICdhdXRvJyBmbGFnLiBJZiB0aGlzDQo+PiAgIGZsYWcgaXMgc2V0LCB0aGUgc29mdHdhcmUgbXVz
dCBjb25zaWRlciB0aGUgYml0bWFwIGFzICdlbmFibGVkJyBhbmQgc3RhcnQNCj4+ICAgdHJhY2tp
bmcgdmlydHVhbCBkaXNrIGNoYW5nZXMgdG8gdGhpcyBiaXRtYXAgZnJvbSB0aGUgZmlyc3Qgd3Jp
dGUgdG8gdGhlDQo+PiAgIHZpcnR1YWwgZGlzay4gSWYgdGhpcyBmbGFnIGlzIG5vdCBzZXQgdGhl
biB0aGUgYml0bWFwIGlzIGRpc2FibGVkLg0KPj4gKw0KPj4gKz09PSBDb21wcmVzc2VkIGNsdXN0
ZXIgbGF5b3V0ID09PQ0KPiBBcyB3cml0dGVuLCB5b3UgaGF2ZSBtYWRlIHRoaXMgYSBjaGlsZCB0
byAnPT0gQml0bWFwcyA9PScgKGFuZCBzaWJsaW5nDQo+IHRvICc9PT0gRGlydHkgdHJhY2tpbmcg
Yml0bWFwcyA9PT0nKTsgdGhhdCBmZWVscyB3cm9uZy4gIEkgd291bGQgcGxhY2UNCj4gdGhpcyBz
dWJzZWN0aW9uIGJlbG9uZyB1bmRlciAnPT0gQ2x1c3RlciBtYXBwaW5nID09JyByaWdodCBhZnRl
ciB0aGUNCj4gJ0NvbXByZXNzZWQgQ2x1c3RlcnMgRGVzY3JpcHRvcicuDQo+DQo+PiArDQo+PiAr
VGhlIGNvbXByZXNzZWQgY2x1c3RlciBkYXRhIG1heSBoYXZlIGEgZGlmZmVyZW50IGxheW91dCBk
ZXBlbmRpbmcgb24gdGhlDQo+PiArY29tcHJlc3Npb24gdHlwZSB1c2VkIGZvciB0aGUgaW1hZ2Us
IGFuZCBzdG9yZSBzcGVjaWZpYyBkYXRhIGZvciB0aGUgcGFydGljdWxhcg0KPj4gK2NvbXByZXNz
aW9uIHR5cGUuDQo+PiArDQo+PiArQ29tcHJlc3NlZCBkYXRhIGxheW91dCBmb3IgdGhlIGF2YWls
YWJsZSBjb21wcmVzc2lvbiB0eXBlczoNCj4gV29yZHk7IG1heWJlOg0KPg0KPiBUaGUgY29tcHJl
c3NlZCBjbHVzdGVyIGRhdGEgaGFzIGEgbGF5b3V0IGRlcGVuZGluZyBvbiB0aGUgY29tcHJlc3Np
b24NCj4gdHlwZSB1c2VkIGZvciB0aGUgaW1hZ2UsIGFzIGZvbGxvd3M6DQo+DQo+PiArKHggPSBk
YXRhX3NwYWNlX2xlbmd0aCAtIDEpDQo+PiArDQo+PiArICAgIHpsaWIgPGh0dHA6Ly96bGliLm5l
dC8+Og0KPj4gKyAgICAgICAgQnl0ZSAgMCAtICB4OiAgICAgdGhlIGNvbXByZXNzZWQgZGF0YSBj
b250ZW50DQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICBhbGwgdGhlIHNwYWNlIHByb3Zp
ZGVkIHVzZWQgZm9yIGNvbXByZXNzZWQgZGF0YQ0KPiBXb3J0aCBhIG1lbnRpb24gdGhhdCB0aGlz
IGlzIGNvbXByZXNzaW9uIHR5cGUgMD8NCj4NCj4+ICsgICAgenN0ZCA8aHR0cDovL2dpdGh1Yi5j
b20vZmFjZWJvb2svenN0ZD46DQo+PiArICAgICAgICBCeXRlICAwIC0gIDM6ICAgICB0aGUgbGVu
Z3RoIG9mIGNvbXByZXNzZWQgZGF0YSBpbiBieXRlcw0KPj4gKyAgICAgICAgICAgICAgNCAtICB4
OiAgICAgdGhlIGNvbXByZXNzZWQgZGF0YSBjb250ZW50DQo+IFdvcnRoIGEgbWVudGlvbiB0aGF0
IHRoaXMgaXMgY29tcHJlc3Npb24gdHlwZSAxPw0KPg0KPj4gZGlmZiAtLWdpdCBhL3FhcGkvYmxv
Y2stY29yZS5qc29uIGIvcWFwaS9ibG9jay1jb3JlLmpzb24NCj4+IGluZGV4IDJjMDAyY2E2YTku
LjllNDU4ZDViNDAgMTAwNjQ0DQo+PiAtLS0gYS9xYXBpL2Jsb2NrLWNvcmUuanNvbg0KPj4gKysr
IGIvcWFwaS9ibG9jay1jb3JlLmpzb24NCj4+IEBAIC00MjgzLDExICs0MjgzLDEyIEBADQo+PiAg
ICMgQ29tcHJlc3Npb24gdHlwZSB1c2VkIGluIHFjb3cyIGltYWdlIGZpbGUNCj4+ICAgIw0KPj4g
ICAjIEB6bGliOiAgemxpYiBjb21wcmVzc2lvbiwgc2VlIDxodHRwOi8vemxpYi5uZXQvPg0KPj4g
KyMgQHpzdGQ6ICB6c3RkIGNvbXByZXNzaW9uLCBzZWUgPGh0dHA6Ly9naXRodWIuY29tL2ZhY2Vi
b29rL3pzdGQ+DQo+PiAgICMNCj4+ICAgIyBTaW5jZTogNC4yDQo+PiAgICMjDQo+PiAgIHsgJ2Vu
dW0nOiAnUWNvdzJDb21wcmVzc2lvblR5cGUnLA0KPj4gLSAgJ2RhdGEnOiBbICd6bGliJyBdIH0N
Cj4+ICsgICdkYXRhJzogWyAnemxpYicsIHsgJ25hbWUnOiAnenN0ZCcsICdpZic6ICdkZWZpbmVk
KENPTkZJR19aU1REKScgfSBdIH0NCj4+ICAgDQo+PiAgICMjDQo+PiAgICMgQEJsb2NrZGV2Q3Jl
YXRlT3B0aW9uc1Fjb3cyOg0KPj4NCg0K

