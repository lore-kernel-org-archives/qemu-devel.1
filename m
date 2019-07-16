Return-Path: <SRS0=+QfZ=VN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E25CC76188
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 12:55:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 490732173B
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 12:55:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="EgZuenHI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 490732173B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48542 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnMzU-0006Ob-As
	for qemu-devel@archiver.kernel.org; Tue, 16 Jul 2019 08:55:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40927)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1hnMzH-0005v9-Bj
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 08:55:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1hnMzG-0008LR-35
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 08:55:19 -0400
Received: from mail-eopbgr50095.outbound.protection.outlook.com
 ([40.107.5.95]:50515 helo=EUR03-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1hnMzF-0008Gb-9Y
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 08:55:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DBS2+8qPBeulmt5TPYuLSqRfcaZdH1jCEwB26yE23/q3yO5z4kgdNirtcJh0x8KmStDgoouwwbC8yVlF85t7nTa9uzWJwosAnHG015gHaDoi57gx3O+Xd+VURipF80hEFEt7i4o52e0QiG2iGt9GKn71cS5bUFS2xwsL23I7NvQsJn4RsmTDDjzXQKeEQ+ODali9laiYKwi77VPLU4vTBnwq4jXj4QrYeOVrw4bdq5veil2vAdZEQYeYOUdq9YDyKiTNNT8gjsPe2vJTOeQS19VvZaVK1YtiDe8+5cVqE5hyLnwoAwLsS5KB41gwRggamYm4rEZEeFAd9llFReev5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DI7svuxKq9pmZOqwuI6XL4bZIe/GzHHCtenw9if0MoY=;
 b=J1m7dceb0HGspBckcTMC+Ocxhem+DbxFMTOnwqyEKRK7u8Ptv9gaRvUUkdD0hC+AS66xDE+s9Obp3TsAE1u4z2VhDvJs/LhKZJcBgG1qqrGipPJEUtQLbiiNHBNOb/coQIpMEB7HLckkIEXSHetNPX1XfUZFbtcMoWyV+VwuAstu80pMpPXjmld4L9RFD+ui+JiAO19KUEXjew+wma59LlhZB2Sh3kSgT1zjJ+WnasSmP39RvkBsslPWNQdCe5awyXafEMVePD83Rj8CiI10F4n7lNgQQZjByMh4dsMCUUhmt1Z7Wrv4B2kY5v+3K49PhnGjsyJ8UjlkbHPTP3sXGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=virtuozzo.com;dmarc=pass action=none
 header.from=virtuozzo.com;dkim=pass header.d=virtuozzo.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DI7svuxKq9pmZOqwuI6XL4bZIe/GzHHCtenw9if0MoY=;
 b=EgZuenHIIIyho/ir+kLvhWMrQNR07GGm29JHpHkRe+HR5oThggiUBdmOmI3bgjrq3LfLjhhub0AkkCzPwVM08S12Mv9/Ll5KgCprwI66ABM8Utm1RY24lno/6PM/5+RbrSYsBCQha2vifuWhsZGTyd5ClEURSDiQe4d9Vzal4BM=
Received: from VI1PR08MB4399.eurprd08.prod.outlook.com (20.179.28.141) by
 VI1PR08MB4176.eurprd08.prod.outlook.com (20.178.204.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2073.14; Tue, 16 Jul 2019 12:55:13 +0000
Received: from VI1PR08MB4399.eurprd08.prod.outlook.com
 ([fe80::4c3d:79b3:a884:18c4]) by VI1PR08MB4399.eurprd08.prod.outlook.com
 ([fe80::4c3d:79b3:a884:18c4%3]) with mapi id 15.20.2073.012; Tue, 16 Jul 2019
 12:55:13 +0000
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
To: Alberto Garcia <berto@igalia.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Thread-Topic: [Qemu-devel] [PATCH v3 0/3] char-socket: Fix race condition
Thread-Index: AQHUyrVz5ag9lcLeAUuI9jFlBliFTabOFfyA
Date: Tue, 16 Jul 2019 12:55:13 +0000
Message-ID: <95175648-7e08-1b62-6002-32947150ddfa@virtuozzo.com>
References: <cover.1550842915.git.berto@igalia.com>
In-Reply-To: <cover.1550842915.git.berto@igalia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0301CA0022.eurprd03.prod.outlook.com
 (2603:10a6:3:76::32) To VI1PR08MB4399.eurprd08.prod.outlook.com
 (2603:10a6:803:102::13)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=andrey.shinkevich@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a1a14c14-b1ba-4b7f-b00b-08d709ecd788
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:VI1PR08MB4176; 
x-ms-traffictypediagnostic: VI1PR08MB4176:
x-ms-exchange-purlcount: 3
x-microsoft-antispam-prvs: <VI1PR08MB4176F8971F3194BF9847173AF4CE0@VI1PR08MB4176.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0100732B76
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(376002)(136003)(346002)(39850400004)(396003)(366004)(189003)(199004)(64756008)(66476007)(25786009)(66556008)(66446008)(5660300002)(486006)(6512007)(36756003)(4326008)(476003)(446003)(11346002)(2616005)(66066001)(76176011)(6436002)(44832011)(66946007)(53936002)(6486002)(68736007)(6506007)(86362001)(31696002)(53546011)(386003)(7736002)(14454004)(71200400001)(31686004)(305945005)(6116002)(3846002)(71190400001)(229853002)(99286004)(2501003)(6306002)(26005)(8936002)(2906002)(316002)(52116002)(478600001)(110136005)(54906003)(14444005)(256004)(81156014)(81166006)(186003)(8676002)(102836004)(6246003)(966005);
 DIR:OUT; SFP:1102; SCL:1; SRVR:VI1PR08MB4176;
 H:VI1PR08MB4399.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: CJf+FmjUT7cwmzS6rsRVNzPBYo9bLG8f3kHHflmfI7/eGDcx8rfJ7n9UAHFl9TKs2D46/IRL9CZLSc/Zo+CbRYxkJaJKV71wrpoc+gRsMbWPsHi7x3vV6oc9SgoRhUqoaT8M2GG9ImbgaV9zN9uhW2caqCQVbByHT9Sx4ODCLrdacCAku103O7ZBtBFIrXs1EtZQ0cNQ9auTap8UY7bYwPrz73wj8eokDGGMkB79eEKMyBo7VPrCPD4S2P66hkaO4IcCc0kga4j5yG774xzFo6469xVN45TrqVdr9rqfIt1pKIIg7htzz/2VbC6CWwZD0AJI2gUgBAOpmZJP9q+6tUZVXqe3iInjdujFB/2S/KMXPQXmehabU/p142GG8ntfcfq/1PVq6bwJfTn3JERgZdU6fhB1hEmUAVDZdJbSZtc=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C4D930913D348748B986D5AA3607E5C1@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1a14c14-b1ba-4b7f-b00b-08d709ecd788
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2019 12:55:13.1854 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: andrey.shinkevich@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB4176
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.5.95
Subject: Re: [Qemu-devel] [PATCH v3 0/3] char-socket: Fix race condition
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQoNCk9uIDIyLzAyLzIwMTkgMTY6NDYsIEFsYmVydG8gR2FyY2lhIHdyb3RlOg0KPiBUaGlzIGZp
eGVzIGEgcmFjZSBjb25kaXRpb24gaW4gd2hpY2ggdGhlIHRjcF9jaHJfcmVhZCgpIGlvYyBoYW5k
bGVyDQo+IGNhbiBjbG9zZSBhIGNvbm5lY3Rpb24gdGhhdCBpcyBiZWluZyB3cml0dGVuIHRvIGZy
b20gYW5vdGhlciB0aHJlYWQuDQo+IA0KPiBOb3RlOiB2aG9zdC11c2VyLXRlc3Qgc3RpbGwgZmFp
bHMgaWYgUVRFU1RfVkhPU1RfVVNFUl9GSVhNRSBpcyBzZXQuDQo+IA0KPiBCZXJ0bw0KPiANCj4g
UkZDOiBodHRwczovL2xpc3RzLmdudS5vcmcvYXJjaGl2ZS9odG1sL3FlbXUtZGV2ZWwvMjAxOS0w
Mi9tc2cwMTUxMC5odG1sDQo+IA0KPiB2MTogaHR0cHM6Ly9saXN0cy5nbnUub3JnL2FyY2hpdmUv
aHRtbC9xZW11LWRldmVsLzIwMTktMDIvbXNnMDE4MzQuaHRtbA0KPiAtIEZpeGVzIG1lbW9yeSBs
ZWFrcyBhbmQgYWRkcyBhIHFlbXVfaWRsZV9hZGQoKSBmdW5jdGlvbg0KPiANCj4gdjI6IGh0dHBz
Oi8vbGlzdHMuZ251Lm9yZy9hcmNoaXZlL2h0bWwvcWVtdS1kZXZlbC8yMDE5LTAyL21zZzA2MTM3
Lmh0bWwNCj4gLSBSZWJhc2VkIG9uIHRvcCBvZiB0aGUgY3VycmVudCBtYXN0ZXIgKGZjM2RiYjkw
ZjJlYjA2OTgwMWJmYjRjZmU5Y2JjKQ0KPiAtIFBhdGNoZXMgMSBhbmQgMjogUmVtb3ZlIHRoZSBj
aGFuZ2VzIGluIGNoYXItcHR5LmMsIHRoZXkncmUgbm90DQo+ICAgICAgICAgICAgICAgICAgICAg
bmVlZGVkIGFmdGVyIHRoZSByZWJhc2UuDQo+IC0gUGF0Y2ggMzogRml4IGNvbmZsaWN0cyBhZnRl
ciB0aGUgcmViYXNlLg0KPiANCj4gdjM6DQo+IC0gUGF0Y2ggMzogQWRkIHRjcF9jaHJfZGlzY29u
bmVjdF9sb2NrZWQoKSBbRGFuaWVsXQ0KPiANCj4gQWxiZXJ0byBHYXJjaWEgKDMpOg0KPiAgICBt
YWluLWxvb3A6IEZpeCBHU291cmNlIGxlYWsgaW4gcWlvX3Rhc2tfdGhyZWFkX3dvcmtlcigpDQo+
ICAgIG1haW4tbG9vcDogQWRkIHFlbXVfaWRsZV9hZGQoKQ0KPiAgICBjaGFyLXNvY2tldDogTG9j
ayB0Y3BfY2hyX2Rpc2Nvbm5lY3QoKSBhbmQgc29ja2V0X3JlY29ubmVjdF90aW1lb3V0KCkNCj4g
DQo+ICAgY2hhcmRldi9jaGFyLXNvY2tldC5jICAgIHwgMjUgKysrKysrKysrKysrKysrKysrKysr
LS0tLQ0KPiAgIGluY2x1ZGUvcWVtdS9tYWluLWxvb3AuaCB8IDEyICsrKysrKysrKysrKw0KPiAg
IGlvL3Rhc2suYyAgICAgICAgICAgICAgICB8ICA5ICsrKy0tLS0tLQ0KPiAgIHV0aWwvbWFpbi1s
b29wLmMgICAgICAgICB8ICA5ICsrKysrKysrKw0KPiAgIDQgZmlsZXMgY2hhbmdlZCwgNDUgaW5z
ZXJ0aW9ucygrKSwgMTAgZGVsZXRpb25zKC0pDQo+IA0KDQpQbGVhc2UgYWRkIG1lIHRvIGNjLg0K
SSBjb25maXJtIHRoYXQgY2hlY2stdW5pdDogdGVzdHMvdGVzdC1jaGFyIGRvZXMgbm90IHBhc3Mu
DQoNCkFuZHJleQ0KLS0gDQpXaXRoIHRoZSBiZXN0IHJlZ2FyZHMsDQpBbmRyZXkgU2hpbmtldmlj
aA0K

