Return-Path: <SRS0=mi2X=WI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CFF9C31E40
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2019 16:10:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C034120665
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2019 16:10:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Ay3P++WV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C034120665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47114 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxCts-0003SM-Us
	for qemu-devel@archiver.kernel.org; Mon, 12 Aug 2019 12:10:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51528)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hxCtL-0002wy-UM
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 12:09:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hxCtK-0003VO-Sy
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 12:09:51 -0400
Received: from mail-am5eur03on071c.outbound.protection.outlook.com
 ([2a01:111:f400:fe08::71c]:35679
 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1hxCtK-0003Uw-CX; Mon, 12 Aug 2019 12:09:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MhUpNkV0FipxszHYsbMHGFuFG6JblHG3Dg62LEetcWvlpDbTC66JjX9MgNsWvZ41Qa8vXqJccd9AuSgcU3QttpIW+G+0kgDw0F5vhbge2qOkuvF+RA4mO6hQcThxUx5A2yPWLxN4HbtvU1hKCJX/R579SfyRkh18DJK3SEdUBcNlL4se1R0ShrRpYTrhJZtX9F0V0rtw4NfMIypBWr643FnfulfmohzrdWa3q4bdEQErJaonI85B2ZmGsudS39f+rCY8yA7WwTWOw88oSMKj/fg8dCYv9jv6fm0H7oB5QOP6KzJbI3i76GZYEpyz81cYaqmOJPVO5jpbyxeizgkgpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dSpfziNhU3PtaClocl2SUjgf4fsAX85xVM1eBaXbzGQ=;
 b=nv9r3cqLtL3vvr9aNXst+0b2+EeRpgaAPf2hfxsRwDH0GyUuH1cFk6akjl+zd8gww12+0sOZMBIpMR2Jq+W9q79NZqtgF/1tkZ9VBmM4bVi/fREymmRV2JgjK8OmMPFI28u7iIolkNC/LoSLJBc377vlzcU+9z843JwuLXQIqwvWWB0Fh6I5M4UPsD5ucUQdJRkx+LiiekJ4HxLzeGQCoJ6jPhfLLFRzg8OwnHU9qAi6XFC30noSorBbAP4oPmv7n9Q5HRX3YAgLjNFRlh0oZxjNaxBTLQmoKPN7nZQMKyhmU73wAdeCHqoDEIpnUHhstrFycmaxLSwVjfQyDfM9Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dSpfziNhU3PtaClocl2SUjgf4fsAX85xVM1eBaXbzGQ=;
 b=Ay3P++WV9dV9F055ztW9z2SqSTfRJR2kSepehi91AX/TMKwrsGZZDTCeZNa1bTI2O5IOpds/Lnb8JBOE+AWwqTTybS4mT36M8rpm1wIew5YGA8gU7E8OEuIwRZwI5RSHujXXSlvHTkoWyHgIuPC2pDYDsmrzyrnH8L+gFRz/JWo=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB5306.eurprd08.prod.outlook.com (10.255.185.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.18; Mon, 12 Aug 2019 16:09:45 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604%3]) with mapi id 15.20.2157.022; Mon, 12 Aug 2019
 16:09:45 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Kevin Wolf <kwolf@redhat.com>
Thread-Topic: backup bug or question
Thread-Index: AQHVTrTrc8JESPxQGUmDMebwH05otKb3hPMAgAAuUIA=
Date: Mon, 12 Aug 2019 16:09:45 +0000
Message-ID: <1b4f5b7c-ca3c-365d-f4ec-d3009b0bde59@virtuozzo.com>
References: <6826e3c2-bc6e-b2a2-1bf1-3ed31079f0ee@virtuozzo.com>
 <20190812132352.GA6400@localhost.localdomain>
In-Reply-To: <20190812132352.GA6400@localhost.localdomain>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1P191CA0003.EURP191.PROD.OUTLOOK.COM (2603:10a6:3:cf::13)
 To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190812190937871
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4e95d55c-c355-4c79-1bfd-08d71f3f7e25
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DB8PR08MB5306; 
x-ms-traffictypediagnostic: DB8PR08MB5306:
x-microsoft-antispam-prvs: <DB8PR08MB5306BAFFE1F3933F4520C93FC1D30@DB8PR08MB5306.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 012792EC17
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(346002)(376002)(366004)(136003)(39840400004)(189003)(199004)(316002)(25786009)(52116002)(99286004)(102836004)(386003)(26005)(6506007)(66066001)(305945005)(76176011)(486006)(476003)(446003)(2616005)(11346002)(86362001)(186003)(31686004)(54906003)(6436002)(66446008)(6486002)(64756008)(6246003)(7736002)(5660300002)(6512007)(53936002)(66556008)(6116002)(3846002)(66946007)(3480700005)(6916009)(71190400001)(71200400001)(2906002)(66476007)(256004)(478600001)(14444005)(36756003)(31696002)(229853002)(14454004)(8936002)(4326008)(81156014)(81166006)(8676002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB5306;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: hAC8GUHS+RggNy+CSERTVMIAHENivfVw3CjvYx2vg4WosaLIKxZHiuQQP66S+ZTQZsyi5RcE8SElmGi6djLYvG30kP+Cwfhyyf66Au6osVAQ8X+2iGxGhsNc+NiOdyCAiQBQqSfXuP5q1wggoSsLt5Ovw7psBGyweNkfABvUhuK52hUOiy1kZzm0uYGAm7qFYaviplJ4YZvzCR4VQcKqpuyZVrACZwVUdc/f8V9hjEL3IIXaonBeJARnbo7EDZnosNXwCjbkNm8KxHiu15saEWtZHalNKSUi8lQddZGBxRZeIIhCpr8oPLQjpK0YYth/8iBLZp2qVrjhvf67LFvo2XfECORJKoaydzHLb71I1VP//yCtdfjhHYYRr174F7nrrSrrHqldKFyVdtbHok3580hsEQj4kH1EmGjv5goM3VM=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <885157B6B4BB504FA451A84DA68AD66B@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e95d55c-c355-4c79-1bfd-08d71f3f7e25
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2019 16:09:45.7747 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lW9JKsR2MBqEGjmHWwturfiImLkAMHpgVmyF4KAfxXsGwG2LEWDklfgAA9RWc4F/roYVhUWQeigeVDFYAMToTB3sKUJDgYmvN+ypAOQCVkI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5306
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:fe08::71c
Subject: Re: [Qemu-devel] backup bug or question
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
Cc: John Snow <jsnow@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 qemu block <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MTIuMDguMjAxOSAxNjoyMywgS2V2aW4gV29sZiB3cm90ZToNCj4gQW0gMDkuMDguMjAxOSB1bSAx
NToxOCBoYXQgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSBnZXNjaHJpZWJlbjoNCj4+IEhp
IQ0KPj4NCj4+IEhtbSwgaGFja2luZyBhcm91bmQgYmFja3VwIEkgaGF2ZSBhIHF1ZXN0aW9uOg0K
Pj4NCj4+IFdoYXQgcHJldmVudHMgZ3Vlc3Qgd3JpdGUgcmVxdWVzdCBhZnRlciBqb2Jfc3RhcnQg
YnV0IGJlZm9yZSBzZXR0aW5nDQo+PiB3cml0ZSBub3RpZmllcj8NCj4+DQo+PiBjb2RlIHBhdGg6
DQo+Pg0KPj4gcW1wX2RyaXZlX2JhY2t1cCBvciB0cmFuc2FjdGlvbiB3aXRoIGJhY2t1cA0KPj4N
Cj4+ICAgICAgam9iX3N0YXJ0DQo+PiAgICAgICAgIGFpb19jb19lbnRlcihqb2JfY29fZW50cnkp
IC8qIG1heSBvbmx5IHNjaGVkdWxlIGV4ZWN1dGlvbiwgaXNuJ3QgaXQgPyAqLw0KPj4NCj4+IC4u
Li4NCj4+DQo+PiBqb2JfY29fZW50cnkNCj4+ICAgICAgam9iX3BhdXNlX3BvaW50KCkgLyogaXQg
ZGVmaW5pdGVseSB5aWVsZHMsIGlzbid0IGl0IGJhZD8gKi8NCj4+ICAgICAgam9iLT5kcml2ZXIt
PnJ1bigpIC8qIGJhY2t1cF9ydW4gKi8NCj4+DQo+PiAtLS0tDQo+Pg0KPj4gYmFja3VwX3J1bigp
DQo+PiAgICAgIGJkcnZfYWRkX2JlZm9yZV93cml0ZV9ub3RpZmllcigpDQo+Pg0KPj4gLi4uDQo+
Pg0KPj4gQW5kIHdoYXQgZ3VhcmFudGVlcyB3ZSBnaXZlIHRvIHRoZSB1c2VyPyBJcyBpdCBndWFy
YW50ZWVkIHRoYXQgd3JpdGUgbm90aWZpZXIgaXMNCj4+IHNldCB3aGVuIHFtcCBjb21tYW5kIHJl
dHVybnM/DQo+Pg0KPj4gQW5kIEkgZ3Vlc3MsIGlmIHdlIHN0YXJ0IHNldmVyYWwgYmFja3VwcyBp
biBhIHRyYW5zYWN0aW9uIGl0IHNob3VsZCBiZSBndWFyYW50ZWVkDQo+PiB0aGF0IHRoZSBzZXQg
b2YgYmFja3VwcyBpcyBjb25zaXN0ZW50IGFuZCBjb3JyZXNwb25kIHRvIG9uZSBwb2ludCBpbiB0
aW1lLi4uDQo+IA0KPiBEbyB0aGUgcGF0Y2hlcyB0byBzd2l0Y2ggYmFja3VwIHRvIGEgZmlsdGVy
IG5vZGUgc29sdmUgdGhpcw0KPiBhdXRvbWF0aWNhbGx5IGJlY2F1c2UgdGhhdCBub2RlIHdvdWxk
IGJlIGluc2VydGVkIGluDQo+IGJhY2t1cF9qb2JfY3JlYXRlKCk/DQo+IA0KDQpIbW0sIGdyZWF0
LCBsb29rcyBsaWtlIHRoZXkgc2hvdWxkLiBBdCBsZWFzdCBpdCBtb3ZlcyBzY29wZSBvZiB0aGUg
cHJvYmxlbSB0byBkb19kcml2ZV9iYWNrdXANCmFuZCBkb19ibG9ja2Rldl9iYWNrdXAgZnVuY3Rp
b25zLi4NCg0KQW0gSSByaWdodCB0aGF0IGFpb19jb250ZXh0X2FjcXVpcmUvYWlvX2NvbnRleHRf
cmVsZWFzZSBndWFyYW50ZWVzIG5vIG5ldyByZXF1ZXN0IGNyZWF0ZWQgZHVyaW5nDQp0aGUgc2Vj
dGlvbj8gT3Igc2hvdWxkIHdlIGFkZCBkcmFpbmVkX2JlZ2luL2RyYWluZWRfZW5kIHBhaXIsIG9y
IGF0IGxlYXN0IGRyYWluKCkgYXQgc3RhcnQgb2YNCnFtcF9ibG9ja2Rldl9iYWNrdXAgYW5kIHFt
cF9kcml2ZV9iYWNrdXA/DQoNCkFzc3VtZSBzY2VuYXJpbyBsaWtlIHRoZSB0aGlzLA0KDQoxLiBm
c2ZyZWV6ZQ0KMi4gcW1wIGJhY2t1cA0KMy4gZnN0aGF3DQoNCnRvIG1ha2Ugc3VyZSB0aGF0IGJh
Y2t1cCBzdGFydGluZyBwb2ludCBpcyBjb25zaXN0ZW50LiBTbyBpbiBvdXIgcW1wIGNvbW1hbmQg
d2Ugc2hvdWxkOg0KMS4gY29tcGxldGUgYWxsIGN1cnJlbnQgcmVxdWVzdHMgdG8gbWFrZSBkcml2
ZXMgY29ycmVzcG9uZGluZyB0byBmc2ZyZWV6ZSBwb2ludA0KMi4gaW5pdGlhbGl6ZSB3cml0ZS1u
b3RpZmllcnMgb3IgZmlsdGVyIGJlZm9yZSBhbnkgbmV3IGd1ZXN0IHJlcXVlc3QsIGkuZS4gYmVm
b3JlIGZzdGhhdywNCmkuZS4gYmVmb3JlIHFtcCBjb21tYW5kIHJldHVybi4NCg0KVHJhbnNhY3Rp
b25zIHNob3VsZCBiZSBPSywgYXMgdGhleSB1c2UgZHJhaW5lZF9iZWdpbi9kcmFpbmVkX2VuZCBw
YWlycywgYW5kIGFkZGl0aW9uYWwNCmFpb19jb250ZXh0X2FjcXVpcmUvYWlvX2NvbnRleHRfcmVs
ZWFzZSBwYWlycy4NCg0KLS0gDQpCZXN0IHJlZ2FyZHMsDQpWbGFkaW1pcg0K

