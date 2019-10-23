Return-Path: <SRS0=brme=YQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6871BCA9EB6
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 14:12:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E16832086D
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 14:12:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="ebAHKvZL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E16832086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37144 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNHNh-0002dZ-No
	for qemu-devel@archiver.kernel.org; Wed, 23 Oct 2019 10:12:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53620)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iNHL2-0000d5-HO
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 10:10:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iNHL0-0000Zc-P1
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 10:10:12 -0400
Received: from mail-eopbgr140103.outbound.protection.outlook.com
 ([40.107.14.103]:61822 helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iNHKx-0000VE-4M; Wed, 23 Oct 2019 10:10:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f9Ska1ZnDQPPHVAXYcIIFoRSRCa9SSUI/QtRAAAubqZRkn6MjzSC+i5xAAWzQxF7VKTaahSdr4AWrQ3f+127YHV5vRrVOwa+H4IVPBggyJQFaUgi0RwR/2cXmzVHdYv2wZaWE8GRrhTLnWDUsNuMKEE63CM/wTBvCayyWsQNkbX0nOX1Oh1VLjkStcf0e9pghXRq4zDpVvrqcaqj0aBJnBji72/51i4xoZhWOpFUPXul7STwH/sOU2UCg3WtYQA7fgTpnThQ7zlX1EdsCmJjzDBz7TjWQ5HbC/uAfYjBh9f0l6zvNC4wOA3E1usezDb3sjjxvuTcFmBtU+2J5GYeyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sSYZnYhiSpAna0H6T7IL5dDmcl0VR/Zyxl7jysu+UD8=;
 b=LM+R8nsw9hgU1lhfBe3qoMZhvjRZ0dqhJO/Ci87eDxyOuAKJTjven9dBAXSCPb1gm+MiyTFXSAqfZzrt2Aug+5ZAON/kQ9BZAKOfGFIctndGOxhXjByu8E1ohguoBvm+H61CCtiFa7RHy7JWDoxSewqWbAMbZ17vk6ohFm/yejkjjiDbsZImYVidPAOJiol6B4aWW2N3kzoEG/kY1fD2K/OMILdNyy4G2ye0OIpsMh8Fsymv5DhviF53FHBWaNUHVLtdiP7V8AbhxyqOZaqdndszQxUGRW76aLN/8e9Apvjs+hmX1AbbegwLdi+5GcsdbfBoH2P8Q/GgdunW43ZRGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sSYZnYhiSpAna0H6T7IL5dDmcl0VR/Zyxl7jysu+UD8=;
 b=ebAHKvZLtWYAiAhnKztBH3mNUEMGVJEZVTQPtPjtMAPkL4MfhRCI1xwxcfdYUiAwmtCqUoGRKZjGrL614qk9//LnvdhENevcTUjcr1lLJj2cNPilX6S9eGWIR/digbXgNIc6NOPG1jpex5MWd8UoPCyLzHPxRB/Tq4CbnHK7tBM=
Received: from AM0PR08MB4435.eurprd08.prod.outlook.com (20.179.35.83) by
 AM0PR08MB3089.eurprd08.prod.outlook.com (52.134.90.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2367.24; Wed, 23 Oct 2019 14:10:03 +0000
Received: from AM0PR08MB4435.eurprd08.prod.outlook.com
 ([fe80::4461:dd32:b358:110c]) by AM0PR08MB4435.eurprd08.prod.outlook.com
 ([fe80::4461:dd32:b358:110c%7]) with mapi id 15.20.2367.022; Wed, 23 Oct 2019
 14:10:03 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, Denis Plotnikov <dplotnikov@virtuozzo.com>, 
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Subject: Re: [PATCH] blockdev: modify blockdev-change-medium to change
 non-removable device
Thread-Topic: [PATCH] blockdev: modify blockdev-change-medium to change
 non-removable device
Thread-Index: AQHVha0Z/0QasgfQvEOckQYkDP6jqKdgfsuAgAQtg4CAAdmZgIABwgUAgAAD1gA=
Date: Wed, 23 Oct 2019 14:10:02 +0000
Message-ID: <fb07097a-ec64-45e4-af17-be3aa803403b@virtuozzo.com>
References: <20191018120950.26849-1-dplotnikov@virtuozzo.com>
 <2b6cc2fe-5269-71ab-9f0b-1ab36d4dc050@redhat.com>
 <f5d689f6-4b23-8314-f92a-294ffcb6721b@virtuozzo.com>
 <bd5e9f28-d11b-982d-d2be-53b16186eeaa@redhat.com>
 <f29c8653-1824-eab2-558a-2f00a29924d9@virtuozzo.com>
In-Reply-To: <f29c8653-1824-eab2-558a-2f00a29924d9@virtuozzo.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0202CA0007.eurprd02.prod.outlook.com
 (2603:10a6:3:8c::17) To AM0PR08MB4435.eurprd08.prod.outlook.com
 (2603:10a6:208:144::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191023171000806
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b172df7b-4767-4f06-8f00-08d757c2b29e
x-ms-traffictypediagnostic: AM0PR08MB3089:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR08MB3089B63512CFDDD53CAD8214C16B0@AM0PR08MB3089.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 019919A9E4
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(346002)(366004)(39840400004)(376002)(136003)(396003)(189003)(199004)(54906003)(110136005)(2616005)(486006)(446003)(11346002)(476003)(71190400001)(71200400001)(305945005)(5024004)(14444005)(478600001)(256004)(3846002)(31686004)(86362001)(31696002)(7736002)(6116002)(316002)(2501003)(8676002)(76176011)(2906002)(81166006)(26005)(64756008)(102836004)(66476007)(66556008)(53546011)(66446008)(386003)(6506007)(186003)(66946007)(81156014)(99286004)(8936002)(66066001)(229853002)(6512007)(4326008)(6436002)(36756003)(6246003)(6486002)(14454004)(52116002)(25786009)(5660300002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB3089;
 H:AM0PR08MB4435.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XWiSYTL/v8BIKCLHYg5Wj3skCKiQaQVX33yTrr0uD8u20zz+FyjBhaWYWHWOV158qYFxqq5rYqB9zJVFpVaRT6SPk9OWlzzKC+nNRaX6QhhX25/bAbWUrn7DrNFEJLMN+SwbC1OnWklAnHzsQMPjNcaCLI6BtYbShOf8VIlR5+qNcPf+NbvLuzaYbt9Za1CrpCRbsG71bUgTDgDtuQah94JYIPscacjLRN0sqaO12Kv37oJ5ZUWnvSRweoEFO9rdzMyRtdbiS5uBkRUS3wQBFPu5hDTKty7zT/AJMeKM9Z8HgMkiojnlU6W/jtQYZ/urboWo57VctOAW/DjvYACe2N3CUcgb7MdjK870cb7QoPkx8klxAUP5PWUaNQCMFR6Q4EXz5yzx6h5zdlscEVuxonLdfERvo6dNNel86tJNS+ifo6O8w204GElz95sT6ZNJ
Content-Type: text/plain; charset="utf-8"
Content-ID: <53E1EEB5DEAE6A4E851BE787A2858B09@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b172df7b-4767-4f06-8f00-08d757c2b29e
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2019 14:10:03.0021 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r9MvJf/dpcablgaJVDbzCBjxE4clgacCYDjLbewdyANixm9x7/TTC4CFPLP8J9DI2Vqp4fyT/3efJ+/VgPFZzb4UE8vU+fmpzI09+IM6uDA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3089
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.14.103
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
 "armbru@redhat.com" <armbru@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>, Denis Lunev <den@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MjMuMTAuMjAxOSAxNjo1NiwgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4g
MjIuMTAuMjAxOSAxNDowNSwgTWF4IFJlaXR6IHdyb3RlOg0KPj4gT24gMjEuMTAuMTkgMDg6NTAs
IERlbmlzIFBsb3RuaWtvdiB3cm90ZToNCj4+Pg0KPj4+IE9uIDE4LjEwLjIwMTkgMTg6MDIsIE1h
eCBSZWl0eiB3cm90ZToNCj4+Pj4gT24gMTguMTAuMTkgMTQ6MDksIERlbmlzIFBsb3RuaWtvdiB3
cm90ZToNCj4+Pj4+IFRoZSBtb2RpZmljYXRpb24gaXMgdXNlZnVsIHRvIHdvcmthcm91bmQgZXhj
bHVzaXZlIGZpbGUgYWNjZXNzIHJlc3RyaWN0aW9ucywNCj4+Pj4+IGUuZy4gdG8gaW1wbGVtZW50
IFZNIG1pZ3JhdGlvbiB3aXRoIHNoYXJlZCBkaXNrIHN0b3JlZCBvbiBhIHN0b3JhZ2Ugd2l0aA0K
Pj4+Pj4gdGhlIGV4Y2x1c2l2ZSBmaWxlIG9wZW5pbmcgbW9kZWw6IGEgZGVzdGluYXRpb24gVk0g
aXMgc3RhcnRlZCB3YWl0aW5nIGZvcg0KPj4+Pj4gaW5jb21taW5nIG1pZ3JhdGlvbiB3aXRoIGEg
ZmFrZSBpbWFnZSBkcml2ZSwgYW5kIGxhdGVyLCBvbiB0aGUgbGFzdCBtaWdyYXRpb24NCj4+Pj4+
IHBoYXNlLCB0aGUgZmFrZSBpbWFnZSBmaWxlIGlzIHJlcGxhY2VkIHdpdGggdGhlIHJlYWwgb25l
Lg0KPj4+Pj4NCj4+Pj4+IFNpZ25lZC1vZmYtYnk6IERlbmlzIFBsb3RuaWtvdiA8ZHBsb3RuaWtv
dkB2aXJ0dW96em8uY29tPg0KPj4+PiBJc27igJl0IHRoaXMgd2hhdCB3ZSB3b3VsZCB3YW50IHRv
IHVzZSByZW9wZW4gZm9yPw0KPj4+Pg0KPj4+PiBNYXgNCj4+Pg0KPj4+IENvdWxkIHlvdSBwbGVh
c2UgZXhwbGFpbiB3aGF0IGlzICJ1c2UgcmVvcGVuIj8NCj4+DQo+PiBJIHdhcyB0aGlua2luZyBv
ZiB1c2luZyAoeC0pYmxvY2tkZXYtcmVvcGVuIHRvIGNoYW5nZSB0aGUgZmlsZSB0aGF0IGlzDQo+
PiB1c2VkIGJ5IHRoZSBmb3JtYXQgbm9kZSAoZS5nLiBmcm9tIGEgbnVsbC1jbyBub2RlIHRvIGEg
cmVhbCBmaWxlKTsgb3IgdG8NCj4+IGNoYW5nZSB0aGUgZmlsZW5hbWUgb2YgdGhlIHByb3RvY29s
IG5vZGUuDQo+Pg0KPj4gS2V2aW4gaGFzIHBvaW50ZWQgb3V0IChvbiBJUkMpIHRoYXQgdGhpcyB3
aWxsIG5vdCBhbGxvdyB5b3UgdG8gY2hhbmdlDQo+PiB0aGUgbm9kZSB0aGF0IGlzIGRpcmVjdGx5
IGF0dGFjaGVkIHRvIHRoZSBkZXZpY2UuICBXaGlsZSBJIGRvbuKAmXQga25vdw0KPj4gd2hldGhl
ciB0aGF04oCZcyByZWFsbHkgbmVjZXNzYXJ5IGluIHRoaXMgY2FzZSwgaWYgaXQgd2VyZSBpbmRl
ZWQNCj4+IG5lY2Vzc2FyeSwgSeKAmWQgcHJlZmVyIGEgbWV0aG9kIHRvIGNoYW5nZSBhIGd1ZXN0
IGRldmljZeKAmXMgQGRyaXZlIG9wdGlvbg0KPj4gYmVjYXVzZSB0aGF0IHNlZW1zIG1vcmUgbmF0
dXJhbCB0byBtZS4NCj4+DQo+PiBJbiBjb250cmFzdCwgdGhlIGFwcHJvYWNoIHRha2VuIGluIHRo
aXMgcGF0Y2ggc2VlbXMgbm90IHF1aXRlIHJpZ2h0IHRvDQo+PiBtZSwgYmVjYXVzZSBpdCBvdmVy
bG9hZHMgdGhlIHdob2xlIGJsb2NrZGV2LWNoYW5nZS1tZWRpdW0gY29tbWFuZCB3aXRoIGENCj4+
IGNvbXBsZXRlbHkgbmV3IGFuZCBkaWZmZXJlbnQgaW1wbGVtZW50YXRpb24gYmFzZWQgb24gd2hl
dGhlciB0aGVyZeKAmXMgYQ0KPj4gcmVtb3ZhYmxlIG1lZGl1bSBvciBub3QuICBJZiB0aGUgaW1w
bGVtZW50YXRpb24gaXMgc28gZGlmZmVyZW50IChhbmQgdGhlDQo+PiBpbnRlcmZhY2UgaXMsIHRv
bywgYmVjYXVzZSBpbiBvbmUgcGF0aCB5b3UgbXVzdCBnaXZlIEBtZWRpdW0gd2hlcmVhcyB0aGUN
Cj4+IG90aGVyIGRvZXNu4oCZdCBldmFsdWF0ZSBpdCBhdCBhbGwpLCBpdCBzaG91bGQgYmUgYSBu
ZXcgY29tbWFuZC4NCj4+DQo+PiBJIGRvbuKAmXQga25vdyB3aGV0aGVyIHdlIG5lZWQgYSBuZXcg
Y29tbWFuZCBhdCBhbGwsIHRob3VnaC4gIE9uIHRoZSBub2RlDQo+PiBsZXZlbCwgd2UgaGF2ZSAo
eC0pYmxvY2tkZXYtcmVvcGVuLiAgU28gYXNzdW1pbmcgd2UgbmVlZCBzb21ldGhpbmcgdG8NCj4+
IGNoYW5nZSB0aGUgbGluayBiZXR3ZWVuIHRoZSBndWVzdCBkZXZpY2UgYW5kIHRoZSBibG9jayBs
YXllciwgSSB3b25kZXINCj4+IHdoZXRoZXIgdGhlcmUgaXNu4oCZdCBzb21ldGhpbmcgc2ltaWxh
cjsgc3BlY2lmaWNhbGx5LCBJ4oCZZCBwcmVmZXINCj4+IHNvbWV0aGluZyB0byBzaW1wbHkgY2hh
bmdlIHRoZSBkZXZpY2XigJlzIEBkcml2ZSBvcHRpb24uDQo+IA0KPiBPaywgYXNzdW1lIHdlIGNh
biBzZXQgQGRyaXZlIG9wdGlvbiB3aXRoIGhlbHAgb2YgaW1wcm92ZWQgcW9tLXNldC4NCj4gQnV0
IGhvdyB0byBjcmVhdGUgdGhpcyBuZXcgYmxrPyBibG9ja2Rldi1hZGQgZG9uJ3QgaGF2ZSAnaWQn
IHBhcmFtZXRlciBhbnltb3JlDQo+IGFuZCBkb24ndCBjcmVhdGUgYmxrLi4uDQoNCg0KSG1tLCBJ
IHNlZSwgd2UgaGF2ZSBjb21tYW5kIGJsb2NrZGV2LWluc2VydC1tZWRpdW0oaWQsIG5vZGUtbmFt
ZSkuIElzbid0IGl0IHdoYXQNCndlIHdhbnQ/DQoNCj4gDQo+Pg0KPj4gS2V2aW4gaGFzIHBvaW50
ZWQgb3V0IChvbiBJUkMgYWdhaW4pIHRoYXQgdGhlcmUgaXMgaW5kZWVkIG9uZSBzdWNoDQo+PiBj
b21tYW5kLCBhbmQgdGhhdOKAmXMgcW9tLXNldC4gIFVuZm9ydHVuYXRlbHksIHRoaXMgaXMgd2hh
dCBoYXBwZW5zIGlmIHlvdQ0KPj4gdHJ5IHRvIHVzZSBpdCBmb3IgQGRyaXZlOg0KPj4NCj4+IHsi
ZXJyb3IiOiB7ImNsYXNzIjogIkdlbmVyaWNFcnJvciIsICJkZXNjIjogIkF0dGVtcHQgdG8gc2V0
IHByb3BlcnR5DQo+PiAnZHJpdmUnIG9uIGFub255bW91cyBkZXZpY2UgKHR5cGUgJ3ZpcnRpby1i
bGstZGV2aWNlJykgYWZ0ZXIgaXQgd2FzDQo+PiByZWFsaXplZCJ9fQ0KPj4NCj4+IEhvd2V2ZXIs
IEtldmluIGhhcyBjbGFpbWVkIGl0IHdvdWxkIGJlIHRlY2huaWNhbGx5IHBvc3NpYmxlIHRvIG1h
a2UgYW4NCj4+IGV4Y2VwdGlvbiBmb3IgQGRyaXZlLiAgTWF5YmUgdGhpcyBpcyB3b3J0aCBpbnZl
c3RpZ2F0aW5nPw0KPj4NCj4+DQo+PiAoQXMgZm9yIGJsb2NrZGV2LWNoYW5nZS1tZWRpdW0sIGFz
IEnigJl2ZSBzYWlkLCBJIGRvbuKAmXQgcmVhbGx5IHRoaW5rIHRoaXMNCj4+IGZpdHMgdGhlcmUu
ICBGdXJ0aGVybW9yZSwgYmxvY2tkZXYtY2hhbmdlLW1lZGl1bSBpcyBraW5kIG9mIGEgbGVnYWN5
DQo+PiBjb21tYW5kIGJlY2F1c2UgSSB0aGluayBldmVyeSBjb21tYW5kIGJ1dCBibG9ja2Rldi1h
ZGQgdGhhdCBkb2VzIGENCj4+IGJkcnZfb3BlbigpIGtpbmQgb2YgaXMgYSBsZWdhY3kgY29tbWFu
ZC4gIFNvIGlmIGFueXRoaW5nLCBpdCBzaG91bGQgYmUgYQ0KPj4gbmV3IGNvbW1hbmQgdGhhdCB0
aGVuIHRha2VzIGEgbm9kZS1uYW1lLg0KPj4gQnV0IE9UT0gsIGl0IHdvdWxkIGJlIGEgYml0IHN0
cmFuZ2UgdG8gYWRkIGEgc2VwYXJhdGUgY29tbWFuZCBmb3INCj4+IHNvbWV0aGluZyB0aGF0IGlu
IHRoZW9yeSBzaG91bGQgYmUgY292ZXJlZCBieSBxb20tc2V0IEBkcml2ZS4pDQo+Pg0KPj4gTWF4
DQo+Pg0KPiANCj4gDQoNCg0KLS0gDQpCZXN0IHJlZ2FyZHMsDQpWbGFkaW1pcg0K

