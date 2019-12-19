Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 507CDC2D0C0
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 11:40:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD40624672
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 11:40:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="YBZATOMc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD40624672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39608 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihuAr-0003M7-IY
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 06:40:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41489)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1ihu9y-0002lS-PY
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 06:40:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1ihu9w-0001gW-Nv
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 06:40:01 -0500
Received: from mail-eopbgr150113.outbound.protection.outlook.com
 ([40.107.15.113]:23950 helo=EUR01-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1ihu9v-0001TM-UW; Thu, 19 Dec 2019 06:40:00 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q7JSvhuNSeFdz9FyjVprlC4syToiNpaGZDg2ZqJznqklKWJlJZNx600GZQa04yLSQI+hnm1tiiqKNppV9kH4zjmSdujFAtFY+Pw4CX9M+r5cLzJQ5R5Zr4QWAWaCxFOdKjBOTtSpA027cGnI6yfZG+Vy0ZMH+S+RbIyDeLnZlycAUDwoUzIeeWiKP8cmVpOfXNDEALqQpChIui2Z+179EiYj663cL5BtqS6fViMQ4X1Vv7zo+TolwwK3FMoCmA7996MghGbb/6vhwjo0iuEuyBCKGi4gxDdiJWSn9zqv88PyAEGU9KFQBTZ+/lJVT3ESGu75jMOtEN5WhVgJmFGUQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8uos4dCmZrxAL1csNPFKccI644bjrWrqD3IR+3RIQPw=;
 b=gWhp//A1JTIrrnvQHlDFSVJQSeCXiSwl0+zPmUC3eXK8tenBioEoYH08sYrRrduob4xhECQcCqTaSzn5ha+BQfGAJfXcwnRVjwQcJD6H/ZxnWpTh3QzG0ctbE5SkpQnkNbjqMmSAx0XVCh//V0SGuiytWoAPcZYC5gByPHc2ZV5UPv6w4NhX7cd5CtilBSTajNff7on4YEkjriRfKFeXKaD0fkaN2bAQuF75DZJtqG8IeZpMUZP22PmEzVtKlhRne+EZzhWhBLeXTeEtLE61XxyMXq1K9RBAAIkRrvwU1P8xhae4NCvW9SQkMNkYM0GjQsWrh3xut4TWf1wfv1W7wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8uos4dCmZrxAL1csNPFKccI644bjrWrqD3IR+3RIQPw=;
 b=YBZATOMcdRTTukKKmwQvNaUd5neld4iN10p1uP1yIE3CloFW0IXI2OFUNL+2Tw4NiGHwePZDsNICHy5yGIGIJumy8n/6oOibQJ8g2CrWGqsVvVmlLqv0PPHl3dhG1t1WRxTX7MJHy3zZc0OWiTqATo5L4XibMhYV2BmdO9M3CAA=
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB4439.eurprd08.prod.outlook.com (20.179.7.78) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.14; Thu, 19 Dec 2019 11:39:57 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030%7]) with mapi id 15.20.2559.012; Thu, 19 Dec 2019
 11:39:57 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Peter Krempa <pkrempa@redhat.com>
Subject: Re: [PATCH v2 0/5] fix migration with bitmaps and mirror
Thread-Topic: [PATCH v2 0/5] fix migration with bitmaps and mirror
Thread-Index: AQHVtkmClxBjAFsANkahPv5xTkXxQqfBQ88AgAARrgA=
Date: Thu, 19 Dec 2019 11:39:57 +0000
Message-ID: <a3a53642-200a-c70c-9b05-24d0697329bb@virtuozzo.com>
References: <20191219085106.22309-1-vsementsov@virtuozzo.com>
 <20191219103638.GJ4914@andariel.pipo.sk>
In-Reply-To: <20191219103638.GJ4914@andariel.pipo.sk>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0259.eurprd05.prod.outlook.com
 (2603:10a6:3:fc::11) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191219143954710
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 11bbed5f-9ce2-4292-a3d6-08d784782c5e
x-ms-traffictypediagnostic: AM6PR08MB4439:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR08MB4439F0F239D42A1ECA4A972DC1520@AM6PR08MB4439.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0256C18696
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(366004)(376002)(136003)(39850400004)(396003)(346002)(53754006)(189003)(199004)(966005)(6512007)(478600001)(31686004)(2906002)(86362001)(31696002)(54906003)(71200400001)(316002)(6916009)(52116002)(81156014)(66446008)(8676002)(6486002)(66946007)(186003)(5660300002)(64756008)(6506007)(66476007)(2616005)(53546011)(8936002)(4326008)(26005)(81166006)(36756003)(66556008);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB4439;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: j87SLt0RXemIlGGVrE4k7PkXU3p8u34dr0fE6s2ttaJRwmcinRPqE2aBJmMcxtWFB95EXjrZfsBVBOKOQsXN75NJemR8lu4SVFFhK/53qh1/mxCLXxCMTdiI6gBnz6cJNeSb56LqP2wWvKF4cQBnkjftcZwuDQC7XBccbye4pLrFes2z96hTZ7EapElbKkbOxB6oauuxQoAzdpdzd6CAztz1b6IBdDSPqgHzfcfMSSHCo3s1fJrEw/HE6vJVfboEX63Bxwg7laQV2wGRiaLYnOfQAS/1NyMRfpmjkm9JLSRSLY1o3BpEY3OP0l9OP+F6CLpF/PdcUkDb9+F+AQ8zmf7art49O/laeN3dS+IKDTHLDaDGhatD+Jmh5H8mW8+ykWPw8LzTFSW+Iwn+3sVQQFBzSh8W1sk0PEPgemRVbjm5pcUVXmOXOE0mIgCCKxQ2Zbumhv1xirU4Xu6bCtfRyeS80RVL2NvOsJKkFKo9XT7H807HwZtQ0AfUr4z3JRfQijmdTAceZhsdkVoCDm5XE5u9jhdSE5vade41GdfvMIk=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EB6BF8B7EA28714B887124AE4BCFD0ED@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11bbed5f-9ce2-4292-a3d6-08d784782c5e
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2019 11:39:57.3065 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JN7HUJQkF4Au8k8YPAMBdONuT1s/AQCMo3wPcQS0lKx5ZpkiazaEUQgW3gY486ZfYxs/W3hhyLooLuS9K47iOmjzIaMAjcr/Ri01zaNXI2k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4439
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.15.113
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
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "quintela@redhat.com" <quintela@redhat.com>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MTkuMTIuMjAxOSAxMzozNiwgUGV0ZXIgS3JlbXBhIHdyb3RlOg0KPiBPbiBUaHUsIERlYyAxOSwg
MjAxOSBhdCAxMTo1MTowMSArMDMwMCwgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90
ZToNCj4+IEhpIGFsbCENCj4+DQo+PiBJdCdzIGEgY29udGludWF0aW9uIGZvcg0KPj4gImJpdG1h
cCBtaWdyYXRpb24gYnVnIHdpdGggLWRyaXZlIHdoaWxlIGJsb2NrIG1pcnJvciBydW5zIg0KPj4g
PDMxNWNmZjc4LWRjZGItYTNjZS0yNzQyLWRhM2NjOWYwY2E5N0ByZWRoYXQuY29tPg0KPj4gaHR0
cHM6Ly9saXN0cy5nbnUub3JnL2FyY2hpdmUvaHRtbC9xZW11LWRldmVsLzIwMTktMDkvbXNnMDcy
NDEuaHRtbA0KPj4NCj4+IFRoZSBwcm9ibGVtIGlzIHRoYXQgYml0bWFwcyBtaWdyYXRlZCB0byBu
b2RlIHdpdGggc2FtZSBub2RlLW5hbWUgb3INCj4+IGJsay1wYXJlbnQgbmFtZS4gQW5kIGN1cnJl
bnRseSBvbmx5IHRoZSBsYXR0ZXIgYWN0dWFsbHkgd29yayBpbiBsaWJ2aXJ0Lg0KPj4gQW5kIHdp
dGggbWlycm9yLXRvcCBmaWx0ZXIgaXQgZG9lc24ndCB3b3JrLCBiZWNhdXNlDQo+PiBiZHJ2X2dl
dF9kZXZpY2Vfb3Jfbm9kZV9uYW1lIGRvbid0IGdvIHRocm91Z2ggZmlsdGVycy4NCj4gDQo+IEkg
d2FudCB0byBwb2ludCBvdXQgdGhhdCBzaW5jZSBsaWJ2aXJ0LTUuMTAgd2UgdXNlIC1ibG9ja2Rl
diB0bw0KPiBjb25maWd1cmUgdGhlIGJhY2tlbmQgb2Ygc3RvcmFnZSBkZXZpY2VzIHdpdGggcWVt
dS00LjIgYW5kIGxhdGVyLiBUaGlzDQo+IG1lYW5zIHVuZm9ydHVuYXRlbHkgdGhhdCB0aGUgQmxv
Y2tCYWNrZW5kIG9mIHRoZSBkcml2ZSBkb2VzIG5vdCBoYXZlIGENCj4gbmFtZSBhbnkgbW9yZSBh
bmQgdGh1cyB0aGUgYWJvdmUgd2lsbCBub3Qgd29yayBldmVuIGlmIHlvdSBtYWtlIHRoZQ0KPiBs
b29rdXAgY29kZSB0byBzZWUgdGhyb3VnaCBmaWx0ZXJzLg0KDQpTaG91bGQgd2Ugc3VwcG9ydCBx
ZW11LTQuMiBhbmQgbGF0ZXIgZm9yIGVhcmxpZXIgdmVyc2lvbnMgb2YgbGlidmlydD8NCg0KPiAN
Cj4gQXMgSSd2ZSBwb2ludGVkIG91dCBzZXBhcmF0ZWx5IG5vZGUtbmFtZXMgYXJlIG5vdCBnb29k
IGlkZWEgdG8gdXNlIGZvcg0KPiBtYXRjaGluZyBlaXRoZXIgYXMgdGhleSBjYW4gYmUgZGlzdGlu
Y3Qgb24gdGhlIGRlc3RpbmF0aW9uIG9mIG1pZ3JhdGlvbi4NCj4gDQo+IEhhdmluZyBzYW1lIG5v
ZGUgbmFtZXMgZm9yIGltYWdlcyBkdXJpbmcgbWlncmF0aW9uIHdhcyBub3QgZG9jdW1lbnRlZCBh
cw0KPiBhIHJlcXVpcmVtZW5kIGFuZCBldmVuIGlmIGl0IHdhcyB0aGUgY2FzZSB3aGVuIHRoZSBt
aXJyb3Igam9iIGlzIHVzZWQNCj4gdGhlIGRlc3RpbmF0aW9uIGlzIGEgZGlmZmVyZW50IGltYWdl
IGFuZCB0aHVzIGhhdmluZyBhIGRpZmZlcmVudCBub2RlDQo+IG5hbWUgaXMgZXhwZWN0ZWQuDQo+
IA0KPiBTaW5jZSBpdCdzIG5vdCBkb2N1bWVudGVkLCBleHBlY3QgdGhlIHNhbWUgc2l0dWF0aW9u
IGFzIHdpdGgNCj4gYXV0b2dlbmVyYXRlZCBub2RlbmFtZXMsIHRoZSBkZXN0aW5hdGlvbiBtYXkg
aGF2ZSBkaWZmZXJlbnQgbm9kZS1uYW1lcw0KPiBhbmQgdGhlIHNhbWUgbm9kZS1uYW1lIG1heSBy
ZWZlciB0byBhIGRpZmZlcmVudCBpbWFnZS4gSW1wbGljaXQgbWF0Y2hpbmcNCj4gYmFzZWQgb24g
bm9kZS1uYW1lcyBpcyB0aHVzIGltcG9zc2libGUuDQo+IA0KDQpTbywgaXQncyB0aW1lIHRvIGlt
cGxlbWVudCBleHBsaWNpdCBtYXRjaGluZy4uDQoNCkkgcmVtZW1iZXIgd2UgZGlzY3Vzc2VkIGEg
Y29tbWFuZCB0byBzZXQgdGhpcyBtYXRjaGluZyBvbiBzb3VyY2UuIFNvIHdlIGNhbGwNCnFtcCBj
b21tYW5kIG9uIHNvdXJjZSwgd2hpY2ggc3BlY2lmaWVzIHdoZXJlIGJpdG1hcHMgZ28gb24gdGFy
Z2V0Li4NCg0KSXMgaXQgT0s/DQoNCk9yLCBpcyBpdCBiZXR0ZXIgdG8gZG8gaXQgc3ltbWV0cmlj
YWxseSwgY2FsbGluZyBvbiBzb3VyY2UgY29tbWFuZCwgd2hpY2gNCmp1c3QgYmluZHMgc29tZSBt
aWdyYXRpb24taWRzIHRvIHRoZSBiaXRtYXBzLiBBbmQgc2FtZSBjb21tYW5kIG9uIHRhcmdldCwg
dG8NCmJpbmQgdGhlc2UgaWRzIHRvIGJpdG1hcHMgb24gdGFyZ2V0Li4NCg0KSG1tbS4NCg0KSSB0
aGluayBiZXR0ZXIsIHRvIHN0aWxsIHNldCBtYXRjaGluZyBub3QgdG8gaWRzIGJ1dCB0byB7bm9k
ZV9uYW1lLCBiaXRtYXBfbmFtZX0NCnBhaXIsIGJ1dCBhbGxvdyBkbyBpdCBlaXRoZXIgb24gc291
cmNlIG9yIG9uIHRhcmdldCAob3IgYm90aCksIHdoaWNoIHdpbGwgYWxsb3cNCnRvIG1pZ3JhdGUg
ZnJvbSBvbGQgcWVtdSB2ZXJzaW9uIHdpdGhvdXQgc3VjaCBjb21tYW5kIHRvIG5ldyBxZW11IHZl
cnNpb24gd2hpY2gNCnN1cHBvcnRzIGl0Lg0KDQoNCi0tIA0KQmVzdCByZWdhcmRzLA0KVmxhZGlt
aXINCg==

