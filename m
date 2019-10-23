Return-Path: <SRS0=brme=YQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E64F5CA9EB6
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 13:57:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B507F2173B
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 13:57:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="LpuUwVNW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B507F2173B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36806 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNH94-0001VR-PM
	for qemu-devel@archiver.kernel.org; Wed, 23 Oct 2019 09:57:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51160)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iNH7i-0000uO-Cy
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 09:56:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iNH7g-0001a4-GS
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 09:56:25 -0400
Received: from mail-eopbgr130112.outbound.protection.outlook.com
 ([40.107.13.112]:10755 helo=EUR01-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iNH7f-0001Yc-Pu; Wed, 23 Oct 2019 09:56:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fKsvYxFrDjXd8DGmZyx+iRz1jBZB+vEv8uTfYRLF6Uwi8xhVUAS6L8ZwV71Xx+hnV+rAMId0elH8CPBykWFuc/rG20hZSE+7VejV05nNvvrlnsptydxHU/7irU1xzdh8Mh/sOu0mAG/Idnlww1aqZhWj5fABfYAZ0YDBascVm2BmzPhYg2EH6P5JZzn3MVzMSINUzj8cLUiQCf3sTilu7DozkmyAofIdob/obYx7XGRxT0vxDUDK4v7HEf3DhZksPV43uM2gdHbawUqS04KmGZ42jr47AL6Ai0HF9gkffukNzDDY3+U9QkM7Jx3XAUCDE9sw4MNKBkbwKzQwYMARJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YxIWKvSU8L/ajBsRNsf7qCYfK4/73KmL1e78opGpFT0=;
 b=lBtZrYQfO+SDSJYU0vgJY3ahOhT9REWWLFvE8wkIi1Z4Ps0eeaP/v89cdSrZzMuPy98JLNgpa91rP3vOUfPmmXmjJhihcJEZI+RjYv2ZvXQk7ZCZQy4GPK+WtprkxMOfhF3C7VF/M4my5WS2nxjKxZlwobx1/8V1SzyxNFCJ3LwGGGhhZSI4GtBIiuMtYTE2t04rtUQUmXEI5L77K5uRasVA535D8ERsCsJR8tuyxNaQ/v5TDJd8V0vJ+QtIKbYpUjsfMJYf71/EolYTR50u+933JSjeBJH2a1LECOMfy4GJMU8iILchCWmbnB3vPo/vJzado24BURxKyrvgJaOmlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YxIWKvSU8L/ajBsRNsf7qCYfK4/73KmL1e78opGpFT0=;
 b=LpuUwVNWZ3wfhW9+/H43SrL0iDH7aLVBkmGrBXXTjsMSQv6YtHTuqf56Go1Lx4ocQOKNQ4wV8LNVBk2dErSe1pHvR99Q4K27BIflVp4vzb7b9g9kA2iaW4cPqByG0ruoKXtmXOKbUt8VfiOfRarN4ouPefWq9H5TIGt1ef4T8kU=
Received: from AM0PR08MB4435.eurprd08.prod.outlook.com (20.179.35.83) by
 AM0PR08MB5139.eurprd08.prod.outlook.com (10.255.29.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.22; Wed, 23 Oct 2019 13:56:20 +0000
Received: from AM0PR08MB4435.eurprd08.prod.outlook.com
 ([fe80::4461:dd32:b358:110c]) by AM0PR08MB4435.eurprd08.prod.outlook.com
 ([fe80::4461:dd32:b358:110c%7]) with mapi id 15.20.2367.022; Wed, 23 Oct 2019
 13:56:19 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, Denis Plotnikov <dplotnikov@virtuozzo.com>, 
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Subject: Re: [PATCH] blockdev: modify blockdev-change-medium to change
 non-removable device
Thread-Topic: [PATCH] blockdev: modify blockdev-change-medium to change
 non-removable device
Thread-Index: AQHVha0Z/0QasgfQvEOckQYkDP6jqKdgfsuAgAQtg4CAAdmZgIABwgUA
Date: Wed, 23 Oct 2019 13:56:19 +0000
Message-ID: <f29c8653-1824-eab2-558a-2f00a29924d9@virtuozzo.com>
References: <20191018120950.26849-1-dplotnikov@virtuozzo.com>
 <2b6cc2fe-5269-71ab-9f0b-1ab36d4dc050@redhat.com>
 <f5d689f6-4b23-8314-f92a-294ffcb6721b@virtuozzo.com>
 <bd5e9f28-d11b-982d-d2be-53b16186eeaa@redhat.com>
In-Reply-To: <bd5e9f28-d11b-982d-d2be-53b16186eeaa@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0902CA0026.eurprd09.prod.outlook.com
 (2603:10a6:7:15::15) To AM0PR08MB4435.eurprd08.prod.outlook.com
 (2603:10a6:208:144::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191023165616675
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f50ab849-1166-4ee0-3bfa-08d757c0c7f7
x-ms-traffictypediagnostic: AM0PR08MB5139:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR08MB513902F8C7A0D75A78D5398CC16B0@AM0PR08MB5139.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 019919A9E4
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(366004)(136003)(376002)(346002)(396003)(39840400004)(199004)(189003)(446003)(8936002)(11346002)(66066001)(2616005)(476003)(486006)(7736002)(31686004)(81156014)(81166006)(8676002)(66446008)(64756008)(66556008)(66476007)(66946007)(25786009)(229853002)(4326008)(3846002)(6116002)(36756003)(54906003)(110136005)(52116002)(316002)(99286004)(6506007)(26005)(76176011)(386003)(53546011)(102836004)(186003)(6486002)(6512007)(14454004)(71200400001)(71190400001)(31696002)(6246003)(2501003)(478600001)(86362001)(14444005)(256004)(2906002)(5024004)(305945005)(5660300002)(6436002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB5139;
 H:AM0PR08MB4435.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cE7VXJXmxxMuEVGhnvjY9uXc3+YcrO68aHSEp4Z3RXyhCsyemZa/ZIqCzoVFMDKU2mabgmWuI2oANqwfOkD+gDWbskvkQ/zMt+Xno+IoFxYeTEx+IMwrDhRBSveXNrJjyu5zhChIuAw5qhP4ohJWDhv4ZScA3AXu9yo8pybWSb2ML0MHzIkBETuni3IFkoSaiB1XcxZlKqLoIWcT2DbRx0k6UreNBmonRrTA6MEobZqbwhToDAHCDX+zek3Gk7je1ofk7387vxyTZ/zmOXF8dihT2S805GTqO8cMuR9Ik0rzRMaOl7PW0EV1WsSvikeoiSN3TrMY2pQEAf3OHPtoI6yqh86Lab8cVyssMotP+Yo1YL86ebNxvzwgr+JOU6PfoRQXdyf3YzDWhjdHITXUnxFX+peKs8YvxSoB36TFOhFrXuZLaL9nXXvO13DBgXg1
Content-Type: text/plain; charset="utf-8"
Content-ID: <3D14567A93E2DE40A76348BFF9A443FE@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f50ab849-1166-4ee0-3bfa-08d757c0c7f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2019 13:56:19.8559 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QiukHE0Tr5maj1x3zXBmPoPiN8Oyv7NSQb9d6rVMlWLCdxoqb+jI+9g/yqjXRIQ6NYfmjZXoybjw7lnOxlFT4wrgfKcWSFHOxf9e/5n2qsQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB5139
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.13.112
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
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Denis Lunev <den@virtuozzo.com>, "dgilbert@redhat.com" <dgilbert@redhat.com>,
 "armbru@redhat.com" <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MjIuMTAuMjAxOSAxNDowNSwgTWF4IFJlaXR6IHdyb3RlOg0KPiBPbiAyMS4xMC4xOSAwODo1MCwg
RGVuaXMgUGxvdG5pa292IHdyb3RlOg0KPj4NCj4+IE9uIDE4LjEwLjIwMTkgMTg6MDIsIE1heCBS
ZWl0eiB3cm90ZToNCj4+PiBPbiAxOC4xMC4xOSAxNDowOSwgRGVuaXMgUGxvdG5pa292IHdyb3Rl
Og0KPj4+PiBUaGUgbW9kaWZpY2F0aW9uIGlzIHVzZWZ1bCB0byB3b3JrYXJvdW5kIGV4Y2x1c2l2
ZSBmaWxlIGFjY2VzcyByZXN0cmljdGlvbnMsDQo+Pj4+IGUuZy4gdG8gaW1wbGVtZW50IFZNIG1p
Z3JhdGlvbiB3aXRoIHNoYXJlZCBkaXNrIHN0b3JlZCBvbiBhIHN0b3JhZ2Ugd2l0aA0KPj4+PiB0
aGUgZXhjbHVzaXZlIGZpbGUgb3BlbmluZyBtb2RlbDogYSBkZXN0aW5hdGlvbiBWTSBpcyBzdGFy
dGVkIHdhaXRpbmcgZm9yDQo+Pj4+IGluY29tbWluZyBtaWdyYXRpb24gd2l0aCBhIGZha2UgaW1h
Z2UgZHJpdmUsIGFuZCBsYXRlciwgb24gdGhlIGxhc3QgbWlncmF0aW9uDQo+Pj4+IHBoYXNlLCB0
aGUgZmFrZSBpbWFnZSBmaWxlIGlzIHJlcGxhY2VkIHdpdGggdGhlIHJlYWwgb25lLg0KPj4+Pg0K
Pj4+PiBTaWduZWQtb2ZmLWJ5OiBEZW5pcyBQbG90bmlrb3YgPGRwbG90bmlrb3ZAdmlydHVvenpv
LmNvbT4NCj4+PiBJc27igJl0IHRoaXMgd2hhdCB3ZSB3b3VsZCB3YW50IHRvIHVzZSByZW9wZW4g
Zm9yPw0KPj4+DQo+Pj4gTWF4DQo+Pg0KPj4gQ291bGQgeW91IHBsZWFzZSBleHBsYWluIHdoYXQg
aXMgInVzZSByZW9wZW4iPw0KPiANCj4gSSB3YXMgdGhpbmtpbmcgb2YgdXNpbmcgKHgtKWJsb2Nr
ZGV2LXJlb3BlbiB0byBjaGFuZ2UgdGhlIGZpbGUgdGhhdCBpcw0KPiB1c2VkIGJ5IHRoZSBmb3Jt
YXQgbm9kZSAoZS5nLiBmcm9tIGEgbnVsbC1jbyBub2RlIHRvIGEgcmVhbCBmaWxlKTsgb3IgdG8N
Cj4gY2hhbmdlIHRoZSBmaWxlbmFtZSBvZiB0aGUgcHJvdG9jb2wgbm9kZS4NCj4gDQo+IEtldmlu
IGhhcyBwb2ludGVkIG91dCAob24gSVJDKSB0aGF0IHRoaXMgd2lsbCBub3QgYWxsb3cgeW91IHRv
IGNoYW5nZQ0KPiB0aGUgbm9kZSB0aGF0IGlzIGRpcmVjdGx5IGF0dGFjaGVkIHRvIHRoZSBkZXZp
Y2UuICBXaGlsZSBJIGRvbuKAmXQga25vdw0KPiB3aGV0aGVyIHRoYXTigJlzIHJlYWxseSBuZWNl
c3NhcnkgaW4gdGhpcyBjYXNlLCBpZiBpdCB3ZXJlIGluZGVlZA0KPiBuZWNlc3NhcnksIEnigJlk
IHByZWZlciBhIG1ldGhvZCB0byBjaGFuZ2UgYSBndWVzdCBkZXZpY2XigJlzIEBkcml2ZSBvcHRp
b24NCj4gYmVjYXVzZSB0aGF0IHNlZW1zIG1vcmUgbmF0dXJhbCB0byBtZS4NCj4gDQo+IEluIGNv
bnRyYXN0LCB0aGUgYXBwcm9hY2ggdGFrZW4gaW4gdGhpcyBwYXRjaCBzZWVtcyBub3QgcXVpdGUg
cmlnaHQgdG8NCj4gbWUsIGJlY2F1c2UgaXQgb3ZlcmxvYWRzIHRoZSB3aG9sZSBibG9ja2Rldi1j
aGFuZ2UtbWVkaXVtIGNvbW1hbmQgd2l0aCBhDQo+IGNvbXBsZXRlbHkgbmV3IGFuZCBkaWZmZXJl
bnQgaW1wbGVtZW50YXRpb24gYmFzZWQgb24gd2hldGhlciB0aGVyZeKAmXMgYQ0KPiByZW1vdmFi
bGUgbWVkaXVtIG9yIG5vdC4gIElmIHRoZSBpbXBsZW1lbnRhdGlvbiBpcyBzbyBkaWZmZXJlbnQg
KGFuZCB0aGUNCj4gaW50ZXJmYWNlIGlzLCB0b28sIGJlY2F1c2UgaW4gb25lIHBhdGggeW91IG11
c3QgZ2l2ZSBAbWVkaXVtIHdoZXJlYXMgdGhlDQo+IG90aGVyIGRvZXNu4oCZdCBldmFsdWF0ZSBp
dCBhdCBhbGwpLCBpdCBzaG91bGQgYmUgYSBuZXcgY29tbWFuZC4NCj4gDQo+IEkgZG9u4oCZdCBr
bm93IHdoZXRoZXIgd2UgbmVlZCBhIG5ldyBjb21tYW5kIGF0IGFsbCwgdGhvdWdoLiAgT24gdGhl
IG5vZGUNCj4gbGV2ZWwsIHdlIGhhdmUgKHgtKWJsb2NrZGV2LXJlb3Blbi4gIFNvIGFzc3VtaW5n
IHdlIG5lZWQgc29tZXRoaW5nIHRvDQo+IGNoYW5nZSB0aGUgbGluayBiZXR3ZWVuIHRoZSBndWVz
dCBkZXZpY2UgYW5kIHRoZSBibG9jayBsYXllciwgSSB3b25kZXINCj4gd2hldGhlciB0aGVyZSBp
c27igJl0IHNvbWV0aGluZyBzaW1pbGFyOyBzcGVjaWZpY2FsbHksIEnigJlkIHByZWZlcg0KPiBz
b21ldGhpbmcgdG8gc2ltcGx5IGNoYW5nZSB0aGUgZGV2aWNl4oCZcyBAZHJpdmUgb3B0aW9uLg0K
DQpPaywgYXNzdW1lIHdlIGNhbiBzZXQgQGRyaXZlIG9wdGlvbiB3aXRoIGhlbHAgb2YgaW1wcm92
ZWQgcW9tLXNldC4NCkJ1dCBob3cgdG8gY3JlYXRlIHRoaXMgbmV3IGJsaz8gYmxvY2tkZXYtYWRk
IGRvbid0IGhhdmUgJ2lkJyBwYXJhbWV0ZXIgYW55bW9yZQ0KYW5kIGRvbid0IGNyZWF0ZSBibGsu
Li4NCg0KPiANCj4gS2V2aW4gaGFzIHBvaW50ZWQgb3V0IChvbiBJUkMgYWdhaW4pIHRoYXQgdGhl
cmUgaXMgaW5kZWVkIG9uZSBzdWNoDQo+IGNvbW1hbmQsIGFuZCB0aGF04oCZcyBxb20tc2V0LiAg
VW5mb3J0dW5hdGVseSwgdGhpcyBpcyB3aGF0IGhhcHBlbnMgaWYgeW91DQo+IHRyeSB0byB1c2Ug
aXQgZm9yIEBkcml2ZToNCj4gDQo+IHsiZXJyb3IiOiB7ImNsYXNzIjogIkdlbmVyaWNFcnJvciIs
ICJkZXNjIjogIkF0dGVtcHQgdG8gc2V0IHByb3BlcnR5DQo+ICdkcml2ZScgb24gYW5vbnltb3Vz
IGRldmljZSAodHlwZSAndmlydGlvLWJsay1kZXZpY2UnKSBhZnRlciBpdCB3YXMNCj4gcmVhbGl6
ZWQifX0NCj4gDQo+IEhvd2V2ZXIsIEtldmluIGhhcyBjbGFpbWVkIGl0IHdvdWxkIGJlIHRlY2hu
aWNhbGx5IHBvc3NpYmxlIHRvIG1ha2UgYW4NCj4gZXhjZXB0aW9uIGZvciBAZHJpdmUuICBNYXli
ZSB0aGlzIGlzIHdvcnRoIGludmVzdGlnYXRpbmc/DQo+IA0KPiANCj4gKEFzIGZvciBibG9ja2Rl
di1jaGFuZ2UtbWVkaXVtLCBhcyBJ4oCZdmUgc2FpZCwgSSBkb27igJl0IHJlYWxseSB0aGluayB0
aGlzDQo+IGZpdHMgdGhlcmUuICBGdXJ0aGVybW9yZSwgYmxvY2tkZXYtY2hhbmdlLW1lZGl1bSBp
cyBraW5kIG9mIGEgbGVnYWN5DQo+IGNvbW1hbmQgYmVjYXVzZSBJIHRoaW5rIGV2ZXJ5IGNvbW1h
bmQgYnV0IGJsb2NrZGV2LWFkZCB0aGF0IGRvZXMgYQ0KPiBiZHJ2X29wZW4oKSBraW5kIG9mIGlz
IGEgbGVnYWN5IGNvbW1hbmQuICBTbyBpZiBhbnl0aGluZywgaXQgc2hvdWxkIGJlIGENCj4gbmV3
IGNvbW1hbmQgdGhhdCB0aGVuIHRha2VzIGEgbm9kZS1uYW1lLg0KPiBCdXQgT1RPSCwgaXQgd291
bGQgYmUgYSBiaXQgc3RyYW5nZSB0byBhZGQgYSBzZXBhcmF0ZSBjb21tYW5kIGZvcg0KPiBzb21l
dGhpbmcgdGhhdCBpbiB0aGVvcnkgc2hvdWxkIGJlIGNvdmVyZWQgYnkgcW9tLXNldCBAZHJpdmUu
KQ0KPiANCj4gTWF4DQo+IA0KDQoNCi0tIA0KQmVzdCByZWdhcmRzLA0KVmxhZGltaXINCg==

