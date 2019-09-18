Return-Path: <SRS0=w+gu=XN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1362C4CEC9
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 10:35:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F731214AF
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 10:35:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="IvkSy5/n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F731214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57172 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAXIr-0000Y5-Eo
	for qemu-devel@archiver.kernel.org; Wed, 18 Sep 2019 06:35:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36410)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iAXES-0006vY-2r
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 06:30:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iAXEQ-00068A-JJ
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 06:30:43 -0400
Received: from mail-eopbgr140091.outbound.protection.outlook.com
 ([40.107.14.91]:61893 helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iAXEM-00066X-Ud; Wed, 18 Sep 2019 06:30:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=in2bWAhMh+0OPsskVf+UohjkOewiKBB8FcNQEzDdDtE04mwjXXE05KBcz77DDDJf9RegY9xX0dJFant7L2r9cEjyBOZCPU8lD+HKSFcVRbGg5y7VGX+uMBEMAAf52zeZQe0sVNm9p9GImObDBk1h0jX1o/eJoIyPioNLVVj8/fsMeMbVMxzuJTUZbtJNiJj2hGhI/pJ7/jgNydUuvYaHtVp+RNCdd1vSM09UgbI0772By9gWuaW1fVwej+vn+RYqUD7tkE0weDFejwrOxjpyB2CAUhZw7FzqqUT7tZYcIPrBcfz+6LaMs6WfvNA+YmofHFAZDjXM4lFx+jUBc+7Iwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eSpLmmzOrIzyyWR9soFRrIdKwO7+36/HRCQdtc6Gs/U=;
 b=gKYj8d+brOBpDr3NY6S9sx4dJkyPAmELAugInlX1tSc1KTDjN/p51gqcf3opCV95E9W9l6rSIPiCW0MemK/uyg4DpaP1wo/sYfTUCWKtVzW7iW1YH2pZ0XGhYPNkxsrx8rDB3nCpEW/oy7uO47tO6eh0o3KqZsa4o8QETTLuoz3dqNtXJpRVD9St9QMsg18E6+hdmBdLmil0IeIdDFCGrmmnEGzFP/vjjMEFZBA9pRsho77M2dylY7rn5biEfsvNkhVuzzikQ5AQAbavPKaVkdX6TgLlkSyJTjlhWJEPS1DX2zOq5aJxZQ4zc9SKcJRFvTWnDZgvxUdYMWbU6CyDDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eSpLmmzOrIzyyWR9soFRrIdKwO7+36/HRCQdtc6Gs/U=;
 b=IvkSy5/n+MJIl5kNNLS58T9p4VE/MyGcPmdzR47oZIQB7RP/20igCdT2e1tvKO9PggOguRfKOR3BWY5AWOyHXD+JuZbWgfaTscKrGHKCmaVdUkwwXamVveIcYHtUAWmjKBKxz3YbC9Z/Qj7iCYGGCqI7mU3fW8NcptqtsHpXzfU=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB5402.eurprd08.prod.outlook.com (52.133.241.74) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.20; Wed, 18 Sep 2019 10:30:35 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed%2]) with mapi id 15.20.2263.023; Wed, 18 Sep 2019
 10:30:35 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: John Snow <jsnow@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Thread-Topic: [Qemu-devel] [PATCH v4 1/4] iotests: add script_initialize
Thread-Index: AQHVaP+sHvXQg5mIX0qbfLdZwy5qOKcua+GAgAIQzoCAAMmFgA==
Date: Wed, 18 Sep 2019 10:30:35 +0000
Message-ID: <66bdafc2-cbdb-8e41-d4c6-5142729ef7a9@virtuozzo.com>
References: <20190912001633.11372-1-jsnow@redhat.com>
 <20190912001633.11372-2-jsnow@redhat.com>
 <974b64b8-a191-c529-4e77-6a38b372c4b8@virtuozzo.com>
 <e5d871da-c5e1-1a5e-4714-387cbc93a055@redhat.com>
In-Reply-To: <e5d871da-c5e1-1a5e-4714-387cbc93a055@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR06CA0159.eurprd06.prod.outlook.com
 (2603:10a6:7:16::46) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190918133033292
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f0a55d15-a5ed-4ced-c0fd-08d73c233de6
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);
 SRVR:DB8PR08MB5402; 
x-ms-traffictypediagnostic: DB8PR08MB5402:
x-microsoft-antispam-prvs: <DB8PR08MB5402013E1EF504DE4F21E294C18E0@DB8PR08MB5402.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 01644DCF4A
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(346002)(396003)(366004)(39840400004)(376002)(136003)(189003)(199004)(52314003)(66556008)(66946007)(229853002)(64756008)(36756003)(52116002)(66476007)(316002)(6116002)(3846002)(66446008)(2906002)(186003)(86362001)(31686004)(386003)(6506007)(53546011)(25786009)(26005)(256004)(102836004)(446003)(11346002)(486006)(2616005)(476003)(31696002)(99286004)(6246003)(14444005)(76176011)(71190400001)(71200400001)(66066001)(8936002)(5660300002)(110136005)(81156014)(478600001)(6436002)(7736002)(4326008)(81166006)(305945005)(14454004)(2501003)(6512007)(54906003)(6486002)(8676002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB5402;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 0IclpACfgyiO9ydyUtuZKOQ3vJvMcmpvT1RUqWCtfiujHAkf6OgkiNjiCL0zSx0KS/ORe4jjTNgDSlPsAGrnQPG65ZfzYCc+EruZyoFNPibNmvdV/yOM8YLa68PyKHlVqPdtE83t1tgFug8S7iqMf3GSmq/yAVseeCmzz7UdKPcnbLFtzw1MQGqaXXdUOZA30FqwNXgP/KonKATPpKhON0iYgyS8Vz/GcwN03OsS/YVzmeq4KVYjgmnDtx3WhTlNAHcPqV6ac7mi5+24y5cVJDuDJp3WlglQZliar43oF3lbtJVqxnKmfyvTAX2A+80yGLWE0KPVQPtl8IBx3aIloX9YeaJU7BysCjOy6z0aRlfHrJ1pTVcwVIVwJa5Ot9cdFW0yeuWtJZhYKUZ48D5RxFdQIYTEWInTfKafS3H+tq0=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <112C198EEF5E7640BFE1E2CD176BCF6F@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0a55d15-a5ed-4ced-c0fd-08d73c233de6
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2019 10:30:35.7150 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z8/ep43El0YvFQmX0Ao4tnsfZbcTZqQYdWcYBGgMwNw/2GTrlpIHU69gJ3/lJ9++9OkGcGsEk7utlT+SEMVwbTIz6y9ugb9kwbUNhR7Ys+E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5402
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.14.91
Subject: Re: [Qemu-devel] [PATCH v4 1/4] iotests: add script_initialize
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MTguMDkuMjAxOSAxOjI5LCBKb2huIFNub3cgd3JvdGU6DQo+IA0KPiANCj4gT24gOS8xNi8xOSAx
MDo1NiBBTSwgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4+IDEyLjA5LjIw
MTkgMzoxNiwgSm9obiBTbm93IHdyb3RlOg0KPj4+IExpa2Ugc2NyaXB0X21haW4sIGJ1dCBkb2Vz
bid0IHJlcXVpcmUgYSBzaW5nbGUgcG9pbnQgb2YgZW50cnkuDQo+Pj4gUmVwbGFjZSBhbGwgZXhp
c3RpbmcgaW5pdGlhbGl6YXRpb24gc2VjdGlvbnMgd2l0aCB0aGlzIGRyb3AtaW4gcmVwbGFjZW1l
bnQuDQo+Pj4NCj4+PiBUaGlzIGJyaW5ncyBkZWJ1ZyBzdXBwb3J0IHRvIGFsbCBleGlzdGluZyBz
Y3JpcHQtc3R5bGUgaW90ZXN0cy4NCj4+Pg0KPj4+IE5vdGU6IHN1cHBvcnRlZF9vc2VzPVsnbGlu
dXgnXSB3YXMgb21pdHRlZCwgYXMgaXQgaXMgYSBkZWZhdWx0IGFyZ3VtZW50Lg0KPj4NCj4+IEJ1
dCBhZnRlciB0aGlzIHBhdGNoIGFsbCB0ZXN0IHdoaWNoIGRpZG4ndCBjaGVjayBvcyBzdGFydCB0
byBjaGVjayBsaW51eA0KPj4gKGFzIGl0J3MgZGVmYXVsdCkuLiBTbyBhbGwgdGVzdHMgd2hpY2gg
d29ya2VkIG9uIG90aGVyIHBsYXRmb3JtcyB3aWxsIG5vdw0KPj4gYmUgc2tpcHBlZCBvbiB0aGVz
ZSBvdGhlciBwbGF0Zm9ybXM/DQo+Pg0KPj4gRmluYWxseSBkbyB3ZSBzdXBwb3J0IHNvbWV0aGlu
ZyBleGNlcHQgbGludXggZm9yIGlvdGVzdHM/DQo+PiBmb3IgYmFzaCB0ZXN0cyBfc3VwcG9ydGVk
X29zIGFsc28gdXNlZCBvbmx5IHdpdGggIkxpbnV4IiBpbiA4NyB0ZXN0cy4uDQo+Pg0KPj4gTWF5
IGJlIHdlJ2QgYmV0dGVyIGRyb3AgYm90aCBfc3VwcG9ydGVkX29zIGFuZCBzdXBwb3J0ZWRfb3Nl
cyBhbGx0b2dldGhlciwNCj4+IGFuZCBkb24ndCBjYXJlPw0KPj4NCj4+IEFueXdheSwgaWYgd2Ug
c3VwcG9ydCBvbmx5IGxpbnV4LCBhbnkgcmVhc29uIHRvIHNraXAgYWxtb3N0IGFsbCB0ZXN0cywN
Cj4+IGlmIHNvbWVvbmUgdHJpZXMgdG8gcnVuIHRlc3Qgb24gb3RoZXIgcGxhdGZvcm0/IExldCBo
aW0gcnVuIHdoYXQgaGUgd2FudHMuDQo+Pg0KPiANCj4gQ3VycmVudGx5LCB0aGUgZm9sbG93aW5n
IHRlc3RzIGFyZSBweXRob246DQo+IA0KPiAwMzAgMDQwIDA0MSAwNDQgMDQ1IDA1NSAwNTYgMDU3
IDA2NSAwOTMgMDk2IDExOCAxMjQgMTI5IDEzMiAxMzYgMTM5IDE0Nw0KPiAxNDggMTQ5IDE1MSAx
NTIgMTU1IDE2MyAxNjUgMTY5IDE5NCAxOTYgMTk5IDIwMiAyMDMgMjA1IDIwNiAyMDcgMjA4IDIw
OQ0KPiAyMTAgMjExIDIxMiAyMTMgMjE2IDIxOCAyMTkgMjIyIDIyNCAyMjggMjM0IDIzNSAyMzYg
MjM3IDIzOCAyNDIgMjQ1IDI0Ng0KPiAyNDggMjU0IDI1NSAyNTYgMjU3IDI1OCAyNjIgMjY2DQo+
IA0KPiBBbmQgYXMgaXQgc3RhbmRzLCBub25lIG9mIHRoZSBzY3JpcHQtc3R5bGUgcHl0aG9uIHRl
c3RzIHdlJ3ZlIHNlbGVjdGVkDQo+IHRvIHJ1biBpbiBgbWFrZSBjaGVja2AgZmFpbCBvbiB0aGUg
RnJlZUJTRCBwbGF0Zm9ybS4NCj4gDQo+IFNvIGFzIGFuIGV4cGVyaW1lbnQsIEkgbGlmdGVkIHRo
ZSByZXN0cmljdGlvbiBvbiBweXRob24gdGVzdHMuIEkga2VwdA0KPiBydW5uaW5nIC4vY2hlY2sg
dW50aWwgSSBmb3VuZCBzb21lIGludm9jYXRpb24gdGhhdCB0aGV5IGRpZG4ndCBza2lwLg0KPiAN
Cj4gRmFpbHVyZXM6IDA0NSAxNDcgMTQ5IDE2OSAxOTQgMTk5IDIxMQ0KPiANCj4gTm90IHRvbyBi
YWQuLi4NCj4gDQo+IDA0NTogK3FlbXUubWFjaGluZS5RRU1VTWFjaGluZUVycm9yOiBzb2NrZXRf
c2NtX2hlbHBlciBkb2VzIG5vdCBleGlzdA0KPiAxNDk6IFdhbnRzIHRvIHVzZSAnc3VkbycsIGJ1
dCBvdXIgZnJlZWJzZCBpbWFnZSBkb2Vzbid0IGhhdmUgdGhhdC4NCj4gMTk0OiArT1NFcnJvcjog
QUZfVU5JWCBwYXRoIHRvbyBsb25nDQo+IDIxMToNCj4gLVt7ICJzdGFydCI6IDAsICJsZW5ndGgi
OiAzMDcyLCAiZGVwdGgiOiAwLCAiemVybyI6IGZhbHNlLCAiZGF0YSI6IHRydWUsDQo+ICJvZmZz
ZXQiOiAxMDI0fSwNCj4gLXsgInN0YXJ0IjogMzA3MiwgImxlbmd0aCI6IDMzNTUxMzYwLCAiZGVw
dGgiOiAwLCAiemVybyI6IHRydWUsICJkYXRhIjoNCj4gdHJ1ZSwgIm9mZnNldCI6IDQwOTZ9XQ0K
PiArW3sgInN0YXJ0IjogMCwgImxlbmd0aCI6IDMxNzQ0LCAiZGVwdGgiOiAwLCAiemVybyI6IGZh
bHNlLCAiZGF0YSI6DQo+IHRydWUsICJvZmZzZXQiOiAxMDI0fSwNCj4gK3sgInN0YXJ0IjogMzE3
NDQsICJsZW5ndGgiOiAzMzUyMjY4OCwgImRlcHRoIjogMCwgInplcm8iOiB0cnVlLCAiZGF0YSI6
DQo+IHRydWUsICJvZmZzZXQiOiAzMjc2OH1dDQo+IA0KPiANCj4gMTQ5IGNhbiBwcm9iYWJseSBi
ZSBmaXhlZCwgYW5kIDE5NCBhbmQgMjExIEkgaGF2ZSBmYWlsIGluIHNpbWlsYXIgd2F5cw0KPiBv
biBteSBvd24gTGludXggbWFjaGluZSwgc28gdGhhdCdzIHByb2JhYmx5IG5vdCBCU0QncyBmYXVs
dC4NCj4gDQo+IEludGVyZXN0aW5nbHksIDE2OSBhbmQgMTk5LCBiaXRtYXAgbWlncmF0aW9uIHJl
bGF0ZWQgdGVzdHMsIGNhdXNlIGENCj4gU0lHU0VHViBpbiBRRU1VIC4uLg0KPiANCj4gDQo+IDE2
OToNCj4gK0VFRUUuLi4uRUVFRS4uLi4uLi4uDQo+ICtXQVJOSU5HOnFlbXUubWFjaGluZTpxZW11
IHJlY2VpdmVkIHNpZ25hbCA2Og0KPiAvdXNyL2hvbWUvcWVtdS9xZW11LXRlc3QuSWZzUjY4L2J1
aWxkL3Rlc3RzL3FlbXUtaW90ZXN0cy8uLi8uLi94ODZfNjQtc29mdG1tdS9xZW11LXN5c3RlbS14
ODZfNjQNCj4gLWNoYXJkZXYNCj4gc29ja2V0LGlkPW1vbixwYXRoPS91c3IvaG9tZS9xZW11L3Fl
bXUtdGVzdC5JZnNSNjgvYnVpbGQvdGVzdHMvcWVtdS1pb3Rlc3RzL3NjcmF0Y2gvdG1wcnBjMGlk
YngvcWVtdWItMjY2MTctbW9uaXRvci5zb2NrDQo+IC1tb24gY2hhcmRldj1tb24sbW9kZT1jb250
cm9sIC1kaXNwbGF5IG5vbmUgLXZnYSBub25lIC1xdGVzdA0KPiB1bml4OnBhdGg9L3Vzci9ob21l
L3FlbXUvcWVtdS10ZXN0Lklmc1I2OC9idWlsZC90ZXN0cy9xZW11LWlvdGVzdHMvc2NyYXRjaC9x
ZW11Yi0yNjYxNy1xdGVzdC5zb2NrDQo+IC1tYWNoaW5lIGFjY2VsPXF0ZXN0IC1ub2RlZmF1bHRz
IC1kaXNwbGF5IG5vbmUgLW1hY2hpbmUgYWNjZWw9cXRlc3QNCj4gLWluY29taW5nIGRlZmVyIC1k
cml2ZQ0KPiBpZj12aXJ0aW8saWQ9ZHJpdmUwLGZpbGU9L3Vzci9ob21lL3FlbXUvcWVtdS10ZXN0
Lklmc1I2OC9idWlsZC90ZXN0cy9xZW11LWlvdGVzdHMvc2NyYXRjaC9kaXNrX2IsZm9ybWF0PXFj
b3cyLGNhY2hlPXdyaXRlYmFjaw0KPiANCj4gVGhlIGNvbW1vbiB0aHJlYWQgaW4gMTY5IGlzIHRo
ZSArbWlnYml0bWFwIHRyYWl0LCB3aGljaCAuLi4gbWFrZXMgbWUgYQ0KPiBsaXR0bGUgbmVydm91
cywgb2YgY291cnNlIQ0KPiANCj4gDQo+IDE5OToNCj4gK1dBUk5JTkc6cWVtdS5tYWNoaW5lOnFl
bXUgcmVjZWl2ZWQgc2lnbmFsIDY6DQo+IC91c3IvaG9tZS9xZW11L3FlbXUtdGVzdC5JZnNSNjgv
YnVpbGQvdGVzdHMvcWVtdS1pb3Rlc3RzLy4uLy4uL3g4Nl82NC1zb2Z0bW11L3FlbXUtc3lzdGVt
LXg4Nl82NA0KPiAtY2hhcmRldg0KPiBzb2NrZXQsaWQ9bW9uLHBhdGg9L3Vzci9ob21lL3FlbXUv
cWVtdS10ZXN0Lklmc1I2OC9idWlsZC90ZXN0cy9xZW11LWlvdGVzdHMvc2NyYXRjaC90bXB2enB5
YzlqNi9xZW11Yi0zMDE3MC1tb25pdG9yLnNvY2sNCj4gLW1vbiBjaGFyZGV2PW1vbixtb2RlPWNv
bnRyb2wgLWRpc3BsYXkgbm9uZSAtdmdhIG5vbmUgLXF0ZXN0DQo+IHVuaXg6cGF0aD0vdXNyL2hv
bWUvcWVtdS9xZW11LXRlc3QuSWZzUjY4L2J1aWxkL3Rlc3RzL3FlbXUtaW90ZXN0cy9zY3JhdGNo
L3FlbXViLTMwMTcwLXF0ZXN0LnNvY2sNCj4gLW1hY2hpbmUgYWNjZWw9cXRlc3QgLW5vZGVmYXVs
dHMgLWRpc3BsYXkgbm9uZSAtbWFjaGluZSBhY2NlbD1xdGVzdA0KPiAtZHJpdmUNCj4gaWY9dmly
dGlvLGlkPWRyaXZlMCxmaWxlPS91c3IvaG9tZS9xZW11L3FlbXUtdGVzdC5JZnNSNjgvYnVpbGQv
dGVzdHMvcWVtdS1pb3Rlc3RzL3NjcmF0Y2gvZGlza19iLGZvcm1hdD1xY293MixjYWNoZT1ub25l
DQo+IC1pbmNvbWluZyBleGVjOiBjYXQNCj4gJy91c3IvaG9tZS9xZW11L3FlbXUtdGVzdC5JZnNS
NjgvYnVpbGQvdGVzdHMvcWVtdS1pb3Rlc3RzL3NjcmF0Y2gvbWlnX2ZpZm8nDQo+ICtFDQo+IA0K
PiANCj4gVmxhZGltaXIsIEkgd2FzIGFibGUgdG8gcHJvdm9rZSB0aGlzIGVycm9yIGJ5IGVkaXRp
bmcNCj4gLi90ZXN0cy92bS9NYWtlZmlsZS5pbmNsdWRlIGFuZCByZW1vdmluZyB0aGUgLS1zbmFw
c2hvdCBpbnZvY2F0aW9uLCB0aGVuDQo+IHVzaW5nIGBtYWtlIHZtLWJ1aWxkLWZyZWVic2RgIGFu
ZCBmaW5hbGx5IHR5cGluZyBgbWFrZSB2bS1zc2gtZnJlZWJzZGANCj4gdG8gb3BlbiB1cCBhIHNo
ZWxsLg0KPiANCj4gVGhlbiB0aGUgdHJpY2tzIGFyZSB0aGUgdXN1YWwgb25lczsgbmF2aWdhdGUg
dG8gaW90ZXN0cyBkaXJlY3RvcnksDQo+IC4vY2hlY2sgLXYgLXFjb3cyIDE2OSwgZXRjLiBZb3Un
bGwgbmVlZCB0byBjcmVhdGUgYSBidWlsZCB0aGF0IGFsbG93cw0KPiBQeXRob24gdGVzdHMgdG8g
cnVuOyBkbyBpdCBiZWZvcmUgeW91IHJ1biB0aGUgc25hcHNob3QtbGVzcyBidWlsZC4NCj4gDQo+
IA0KDQpJbnRlcmVzdGluZywgSSdsbCB0cnkgdG8gcmVwcm9kdWNlLg0KDQo+IA0KPiANCj4gYWFh
bmQgbGFzdGx5LCBydW5uaW5nIGBtYWtlIGNoZWNrYCBkb2Vzbid0IGhhcHBlbiB0byBjYWxsIGFu
eSBvZiB0aGUNCj4gdGVzdHMgdGhhdCBhcHBlYXIgYnJva2VuIG9uIEZyZWVCU0QgcmlnaHQgbm93
LCBzbyBJJ20ganVzdCBnb2luZyB0byBnbw0KPiBhaGVhZCBhbmQgc2F5IHdlIGNhbiBvcGVuIFBh
bmRvcmEncyBib3ggYW5kIG1ha2UgdGhlIGRlZmF1bHQgcHl0aG9uIHRlc3QNCj4gYmVoYXZpb3Ig
dG8gcnVuIG9uIGFueSBPUywgYW5kIHN0YXJ0IHJlLWJsYWNrbGlzdGluZyB0aGUgZWRnZS1jYXNl
cyBhcw0KPiB3ZSBmaW5kIHRoZW0uDQo+IA0KPiBBcyBmYXIgYXMgaW90ZXN0cyBnbywgdGhlcmUg
YXJlIGEgZmV3IG5ldyBicm9rZW4gb25lcyB0aGF0IHN1cmZhY2UsIGJ1dA0KPiB0aGV5IHdvbid0
IGdhdGUgUGV0ZXIgTWF5ZGVsbCdzIGJ1aWxkIHByb2Nlc3MgYmVjYXVzZSB0aGV5IGRvbid0IGdl
dCBydW4NCj4gYnkgJ21ha2UgY2hlY2snLg0KPiANCj4gSSB0aGluayBpdCdzIGEgc2FmZSBtb3Zl
IHRvIG1ha2UuDQo+IA0KPiAtLWpzDQo+IA0KDQoNCi0tIA0KQmVzdCByZWdhcmRzLA0KVmxhZGlt
aXINCg==

