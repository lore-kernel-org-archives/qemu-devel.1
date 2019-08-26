Return-Path: <SRS0=7Gz3=WW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAC27C3A59E
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2019 08:58:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85774206BA
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2019 08:58:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="TP61DK49"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85774206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51028 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2ApV-0006T7-KW
	for qemu-devel@archiver.kernel.org; Mon, 26 Aug 2019 04:58:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51716)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1i2Aom-0005zl-83
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 04:57:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1i2Aol-0001vk-2Z
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 04:57:40 -0400
Received: from mail-eopbgr140117.outbound.protection.outlook.com
 ([40.107.14.117]:2134 helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dplotnikov@virtuozzo.com>)
 id 1i2Aoh-0001pI-0I; Mon, 26 Aug 2019 04:57:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V3hLRPpRM222vhmK/c+di+1fc736lNPe6n7nNvFTuwCJRosDxT379nQn0gFbY7EG59UJ0jh2J5nvROy1IWV6/OaFRHqBpOfKgyODZdpynaQv6vUWN1Tj5IZFzb9EMWgI12SKM3zG5NyDa87w8isU23gWK0xtDnBj+sj28UFUz9+3FAMamZkrWYTc+e/7gC5iREwp2ikxyl0asDaxJAl9l1EuP0yFJ1VLr6T2hqD5fRR33Hb1k/odIJCIVc1X0MBCe+7D85eMYFfBC5F47DHsMjJQVqtlNPwNWTDcJQFkuMc9iRTFJIuPqs2pjq9dXF8AgyTAVWiuGV9TQFFJ56G31w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xs7j0OLLAkBziFHmF+DO2EfqDdIML+9m0lK3SqLAyNY=;
 b=GelQ0mOzqNiJz5BtA1+AI/jAV3vi2yN4Nc+KceuHnBcCWiAkpLNCiwJ5vAPL10avhxZUSYsMiLYAI6w+INEtO6uHV90TM0s4/nTRzPJJvgnavkpCRgacE94/kL0/1917n2sIQePJ2o8/n6+h+lgj0tTaQtFimc1o9AMMrsv7SQQ5/oejmEWCPqSPpkcNQ4EZ3qOph8nDSI9OfDhE2AkwoW7wap+ZGFBUMPiTzJUJZJdUgFdbzUIC1VcyKWP4DvgLq+NfvqEV3fjeZvjHOZ2m/jwRdKvs7b2WG8fmmV1hfOQuHVPGbeiKrba8jmo78ZjnXx6E5FwIPdJhTLckN22MQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xs7j0OLLAkBziFHmF+DO2EfqDdIML+9m0lK3SqLAyNY=;
 b=TP61DK49z8gwvGEXCfJAOrm/4hfXeSsJClS8vH+1dYXkMhNEmkfVxJ/NSYE66vvK1aFKm/VfqtOnYaauU674vzkmTdB5HD4uXRbKs8b1skj0uNtVZpiBeC76DjoZOyVjn0S7WvTe8aRCjMP+tJfYDvprdqmISGFp9QkwsjZ0DyQ=
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com (20.178.22.27) by
 AM0PR08MB3379.eurprd08.prod.outlook.com (20.177.109.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.16; Mon, 26 Aug 2019 08:57:29 +0000
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com
 ([fe80::ac29:7eee:83d9:4668]) by AM0PR08MB3745.eurprd08.prod.outlook.com
 ([fe80::ac29:7eee:83d9:4668%7]) with mapi id 15.20.2199.015; Mon, 26 Aug 2019
 08:57:29 +0000
From: Denis Plotnikov <dplotnikov@virtuozzo.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Thread-Topic: [Qemu-devel] [PATCH v3 0/3] qcow2: add zstd cluster compression
Thread-Index: AQHVVp8BXbc2YugS9kWndi2lXRZEdKcNK1IA
Date: Mon, 26 Aug 2019 08:57:28 +0000
Message-ID: <36d3c8ad-e5dc-9c51-0a6d-400b9d362e91@virtuozzo.com>
References: <20190819150049.28997-1-dplotnikov@virtuozzo.com>
In-Reply-To: <20190819150049.28997-1-dplotnikov@virtuozzo.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1P18901CA0017.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:3:8b::27) To AM0PR08MB3745.eurprd08.prod.outlook.com
 (2603:10a6:208:ff::27)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dplotnikov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 60b3518b-a046-4765-5531-08d72a036c4e
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600166)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);
 SRVR:AM0PR08MB3379; 
x-ms-traffictypediagnostic: AM0PR08MB3379:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR08MB33792A3B784A33FB24484572CFA10@AM0PR08MB3379.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 01415BB535
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(376002)(136003)(39840400004)(396003)(366004)(346002)(189003)(199004)(71190400001)(11346002)(6436002)(81166006)(66446008)(2501003)(8676002)(3846002)(66476007)(316002)(2906002)(6116002)(54906003)(26005)(31686004)(66066001)(99286004)(86362001)(66556008)(6916009)(71200400001)(446003)(52116002)(2351001)(8936002)(64756008)(5660300002)(478600001)(186003)(229853002)(36756003)(386003)(53936002)(6512007)(25786009)(4326008)(66946007)(19627235002)(14454004)(6506007)(6486002)(2616005)(5640700003)(256004)(486006)(305945005)(7736002)(6246003)(102836004)(31696002)(476003)(81156014)(76176011)(53546011);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB3379;
 H:AM0PR08MB3745.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: xsDx+Q8NMHOOkXE+eZtDjx32lU28RuUumjtFwWAiHY3f+FCJWZirn9wpNBtrEZL7UAR3p5m0z6y4/Bq3E+ggAZ6LFRMaPlpfNZNG4oJe7sA3CAVrpuMlQm8Xj0rHsq93TpoK6s2q+CZFiurltwyw3LOnzp0u6GIEu9j2D/1iwbHrjMd/35AaiXZReBGncoc4DalamcPvfy8nf4erUdp9UIGruTJiQp5x1IqhxpN8UH4ch5xL9gmUarLs0L63FFsKjGg1HiXKh2/8pMXDwT17rT1bJNrTkIlVcywL1TKZwOnt/7El92i1OtfrQJJjU3IuKKrkBHne4FDHv72YTomp3pS1iScilL688XL8lPs0G/sLzBZdokQMn1cpK05K7FwcZ0B8vXM2co498NMN0NMUeqTDSC+j1Dz8jZ8r/+lfl3k=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3D7CFCE74A78144B92E3BA449783AA27@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60b3518b-a046-4765-5531-08d72a036c4e
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2019 08:57:28.9694 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rcgKoVcdOCEhsCl/WWh+ERZkjVWyKDRcvlyYZHmCGi3ERB+g3MadqSLzNbbC3tlX1EmiF2L5htWsZpeFOjvH8+0RA1uLNHZIx6N7E3VeswM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3379
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.14.117
Subject: Re: [Qemu-devel] [PATCH v3 0/3] qcow2: add zstd cluster compression
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
 "armbru@redhat.com" <armbru@redhat.com>,
 "mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGluZyENCg0KT24gMTkuMDguMjAxOSAxODowMCwgRGVuaXMgUGxvdG5pa292IHdyb3RlOg0KPiB2
MzoNCj4gKiByZWxheCB0aGUgY29tcHJlc3Npb24gdHlwZSBzZXR0aW5nIHJlcXVpcmVtZW50IHdo
ZW4NCj4gICAgdGhlIGNvbXByZXNzaW9uIHR5cGUgaXMgbm90IHpsaWIgW0VyaWMsIEtldmluXQ0K
PiAqIGFkZCBjb21wcmVzc2lvbiB0eXBlIHZhbHVlcyB0byB0aGUgc3BlYyBbRXJpY10NCj4gKiBm
aXggd29yZGluZyBpbiB0aGUgc3BlYyBhbmQgZGVzY3JpcHRpb25zIFtFcmljXQ0KPiAqIGZpeCBm
dW5jdGlvbnMgZGVzY3JpcHRpb25zIFtNYXhdDQo+ICogZml4IHpzdGQgKGRlKWNvbXByZXNzaW9u
IGZ1bmN0aW9ucyBmbGF3cyBbTWF4XQ0KPiAqIGZpeCB6c3RkIHJlbGF0ZWQgcGFydHMgb2YgY29u
ZmlndXJlIGZpbGUgW01heF0NCj4gKiByZWJhc2VkIHRvIHY0LjEuMC1yYzUgYW5kIGNoZW5nZWQg
dGhlIHNlcmllcyB2ZXJzaW9uIGFpbWluZyB0byA0LjINCj4gDQo+IHYyOg0KPiAqIHJlbGF4IHRo
ZSBjb21wcmVzc2lvbiB0eXBlIHNldHRpbmcgcmVzdHJpY3Rpb24gaW4gdGhlIHNwZWMNCj4gKiBm
aXggcWNvdzIgaGVhZGVyIHNpemUgY2hlY2tpbmcNCj4gKiBmaXggZXJyb3IgcHJvY2Vzc2luZyBh
bmQgbWVzc2FnaW5nDQo+ICogZml4IHFjb3cyIGltYWdlIHNwZWNpZmljIGluZm8gcmVwb3J0aW5n
DQo+ICogc2V0IFFjb3cyQ29tcHJlc3Npb25UeXBlIHpzdGQgY29uZmlnIGRlcGVuZGFudA0KPiAq
IGFkZCB6c3RkIGNvbXByZXNzZWQgY2x1c3RlciBmb3JtYXQgZGVzY3JpcHRpb24gdG8gdGhlIHNw
ZWMNCj4gDQo+IHYxOg0KPiAqIGV4dGVuZCBxY293MiBoZWFkZXIgaW5zdGVhZCBvZiBhZGRpbmcg
YSBuZXcgaW5jb21wYXRpYmxlIGV4dGVuc2lvbiBoZWFkZXINCj4gc3BlY2lmaWNhdGlvbiByZS13
cml0dGVuIGFjY29yZGluZ2x5DQo+ICogZW5hYmxlIHpzdGQgY29tcHJlc3Npb24gdmlhIGNvbmZp
Zw0KPiAqIGZpeCB6c3RkIChkZSljb21wcmVzc2lvbiBmdW5jdGlvbnMNCj4gKiBmaXggY29tbWVu
dHMvZGVzY3JpcHRpb24NCj4gKiBmaXggZnVuY3Rpb24gbmFtaW5nDQo+IA0KPiAtLS0NCj4gVGhl
IGdvYWwgb2YgdGhlIHBhdGNoLXNldCBpcyB0byBlbmFibGUgcWNvdzIgdG8gdXNlIHpzdGQgY29t
cHJlc3Npb24gZm9yDQo+IGNsdXN0ZXJzLiBaU1REIHByb3ZpZGVzIGJldHRlciAoZGUpY29tcHJl
c3Npb24gcGVyZm9ybWFuY2UgdGhhbiBjdXJyZW50bHkNCj4gdXNlZCBaTElCLiBVc2luZyBpdCB3
aWxsIGltcHJvdmUgcGVyZm9yYW1uY2UgKHJlZHVjZSBjb21wcmVzc2lvbiB0aW1lKQ0KPiB3aGVu
IHRoZSBjb21wcmVzc2VkIGNsdXN0ZXJzIGlzIHVzZWQsIGUuZyBiYWNrdXAgc2NlbmFyaW9zLg0K
PiANCj4gQWxzbywgdGhlIHBhdGNoLXNldCBleHRlbmRzIHFjb3cyIHNwZWNpZmljYXRpb24gYnkg
YWRkaW5nIGNvbXByZXNzaW9uX3R5cGUNCj4gZmVhdHVyZS4gVGhlIGZlYXR1cmUgZW5hYmxlcyBh
ZGRpbmcgWlNURCBhbmQgYW5vdGhlciBjb21wcmVzc2lvbiBhbGdvcml0aG1zDQo+IGluIHRoZSBm
dXR1cmUuDQo+IA0KPiBIZXJlIGlzIHNvbWUgbWVhc3VyZW1lbnRzIFpTVEQgdnMgWkxJQjoNCj4g
DQo+IFRoZSB0ZXN0Og0KPiBUZXN0IGNvbXByZXNzZXMgYW5kIGRlY29tcHJlc3NlcyBxZW11IHFj
b3cyIGltYWdlIHdpdGgganVzdA0KPiBpbnN0YWxsZWQgcmhlbC03LjYgZ3Vlc3QuDQo+IEltYWdl
IGNsdXN0ZXIgc2l6ZTogNjRLLiBJbWFnZSBvbiBkaXNrIHNpemU6IDIuMkcNCj4gDQo+IFRoZSB0
ZXN0IHdhcyBjb25kdWN0ZWQgd2l0aCBicmQgZGlzayB0byByZWR1Y2UgdGhlIGluZmx1ZW5jZQ0K
PiBvZiBkaXNrIHN1YnN5c3RlbSB0byB0aGUgdGVzdCByZXN1bHRzLg0KPiBUaGUgcmVzdWx0cyBp
cyBnaXZlbiBpbiBzZWNvbmRzLg0KPiANCj4gY29tcHJlc3MgY21kOg0KPiB0aW1lIC4vcWVtdS1p
bWcgY29udmVydCAtTyBxY293MiAtYyAtbyBjb21wcmVzc2lvbl90eXBlPVt6bGlifHpzdGRdDQo+
IHNyYy5pbWcgW3psaWJ8enN0ZF1fY29tcHJlc3NlZC5pbWcNCj4gZGVjb21wcmVzcyBjbWQNCj4g
dGltZSAuL3FlbXUtaW1nIGNvbnZlcnQgLU8gcWNvdzINCj4gW3psaWJ8enN0ZF1fY29tcHJlc3Nl
ZC5pbWcgdW5jb21wcmVzc2VkLmltZw0KPiANCj4gDQo+IFRoZSByZXN1bHRzOg0KPiBjb21wcmVz
c2lvbiBkZWNvbXByZXNzaW9uDQo+IHpsaWIgenN0ZCB6bGliIHpzdGQNCj4gLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+IHJlYWwg
NjUuNSAxNi4zICgtNzUgJSkgMS45IDEuNiAoLTE2ICUpDQo+IHVzZXIgNjUuMCAxNS44IDUuMyAy
LjUNCj4gc3lzIDMuMyAwLjIgMi4wIDIuMA0KPiANCj4gQm90aCBaTElCIGFuZCBaU1REIGdhdmUg
dGhlIHNhbWUgY29tcHJlc3Npb24gcmF0aW86IH4xLjUNCj4gY29tcHJlc3NlZCBpbWFnZSBzaXpl
IGluIGJvdGggY2FzZXM6IH4xLjRHDQo+IA0KPiBEZW5pcyBQbG90bmlrb3YgKDMpOg0KPiAgICBx
Y293MjogaW50cm9kdWNlIGNvbXByZXNzaW9uIHR5cGUgZmVhdHVyZQ0KPiAgICBxY293MjogcmV3
b3JrIHRoZSBjbHVzdGVyIGNvbXByZXNzaW9uIHJvdXRpbmUNCj4gICAgcWNvdzI6IGFkZCB6c3Rk
IGNsdXN0ZXIgY29tcHJlc3Npb24NCj4gDQo+ICAgYmxvY2svcWNvdzItdGhyZWFkcy5jICAgICB8
IDE3MiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLQ0KPiAgIGJsb2NrL3Fj
b3cyLmMgICAgICAgICAgICAgfCAxMDAgKysrKysrKysrKysrKysrKysrKysrKw0KPiAgIGJsb2Nr
L3Fjb3cyLmggICAgICAgICAgICAgfCAgMjYgKysrKy0tDQo+ICAgY29uZmlndXJlICAgICAgICAg
ICAgICAgICB8ICAzNCArKysrKysrKw0KPiAgIGRvY3MvaW50ZXJvcC9xY293Mi50eHQgICAgfCAg
MzkgKysrKysrKystDQo+ICAgaW5jbHVkZS9ibG9jay9ibG9ja19pbnQuaCB8ICAgMSArDQo+ICAg
cWFwaS9ibG9jay1jb3JlLmpzb24gICAgICB8ICAyMyArKysrLQ0KPiAgIDcgZmlsZXMgY2hhbmdl
ZCwgMzcxIGluc2VydGlvbnMoKyksIDI0IGRlbGV0aW9ucygtKQ0KPiANCg0KLS0gDQpCZXN0LA0K
RGVuaXMNCg==

