Return-Path: <SRS0=VLgg=X4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32E0AC32792
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 15:25:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F118D2133F
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 15:25:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="epy51UuQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F118D2133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37556 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iG2z9-00024K-QJ
	for qemu-devel@archiver.kernel.org; Thu, 03 Oct 2019 11:25:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45430)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iG2tr-0007AP-JF
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 11:20:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iG2tj-0002de-DY
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 11:20:11 -0400
Received: from mail-eopbgr140127.outbound.protection.outlook.com
 ([40.107.14.127]:17282 helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iG2td-0002XQ-Q0; Thu, 03 Oct 2019 11:20:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jbrXB9r17j9MX7322JuSXK2B4MKqiUAmi3DENQtOQxb0tqMA4XopeckrPblmowao/JUrqoZ9iec7CdE3rmDdDhgXrbPapKNN3Nf+FV4IPOvIMNe3XaisaOM05yx9bWSFYZXsTMTFOFxHLRnEam8oGy4piV8wB2MobQGKFUKpc11HBjkKcRYnbX4RfYMydqg3/auyaAzCCMAS0uUzHc4tDLidkiWViMbEO7Rao/pWz2S5DEDrngJsXg5KhfgTNOoZRc0WzJ29etq+nPf9AB5HlTzExwleajaVwtCajVdb/AojZ10Mt6hUpLDs0I/mihrzWw3pErdxuz7PUWdjkVb5Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lcXvdCE7F/tUX/ePdBPXC/eEYTJnpJb25Sjxl518MJg=;
 b=k6MfABQ264QNddrXP1SJD+vsRP+DbZEwLZftDOEQN0Wo2x52USdqv/Wr9XeE2XJ93vhPln1TEDgz+T5sf6OFc+rEWfiwGevpD3SWwUTCLroBXz8tCBY7RlvVAhpob0AyqDU4eJ7vHuH621aqWUmCXsHlF+M7+b4dLK0/ahVOSrLuZdbDmJD51clt+5czPc7NZJpfzNNpTPZMpMQL3APdQGQa/jfUfMCIrZk2hW2hOOcyO4zW88NSpVgDbMg8r2AAzRo33hc1zynQsFsaKRzIEwKYMfDpYR+KRY3+loRaCWdkdDQMTxZANb1/gprD0WpPp+qAjPreaGX9usEpSAKvvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lcXvdCE7F/tUX/ePdBPXC/eEYTJnpJb25Sjxl518MJg=;
 b=epy51UuQyzU7SXfPT9DsX8KVbV4Vdy4oEGqsieFVEdO4gsLjH7Hi4qOUYBBi7KpfkBgQnPn+sA60oYOIW6RwgNXpLVHv3YReD4UKXlyp3OKH0wZqDcDk8l31QFjepNwy/EcOoMptXOsj3OSj7LJEQjg3+Zbks/HfAqkeTDznHcE=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB5066.eurprd08.prod.outlook.com (10.255.17.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.20; Thu, 3 Oct 2019 15:19:54 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::2856:990a:197a:288f]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::2856:990a:197a:288f%2]) with mapi id 15.20.2305.023; Thu, 3 Oct 2019
 15:19:54 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Subject: Re: [PATCH 02/67] iotests.py: Add @skip_for_imgopts()
Thread-Topic: [PATCH 02/67] iotests.py: Add @skip_for_imgopts()
Thread-Index: AQHVeJL3jVJC94J3Z0iQw9yDqpJ0bqdJCtqA
Date: Thu, 3 Oct 2019 15:19:54 +0000
Message-ID: <5e803464-8257-c61e-c459-16a3b898c192@virtuozzo.com>
References: <20191001194715.2796-1-mreitz@redhat.com>
 <20191001194715.2796-3-mreitz@redhat.com>
In-Reply-To: <20191001194715.2796-3-mreitz@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0298.eurprd05.prod.outlook.com
 (2603:10a6:7:93::29) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191003181951649
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d30678e0-6306-46dc-115c-08d748152494
x-ms-traffictypediagnostic: DB8PR08MB5066:
x-microsoft-antispam-prvs: <DB8PR08MB5066094776716E6A184CBDCFC19F0@DB8PR08MB5066.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-forefront-prvs: 01792087B6
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(376002)(366004)(396003)(39840400004)(136003)(346002)(189003)(199004)(478600001)(66556008)(66946007)(8936002)(186003)(64756008)(256004)(66446008)(26005)(25786009)(66066001)(8676002)(6246003)(81156014)(31686004)(229853002)(6512007)(6486002)(81166006)(6436002)(446003)(14454004)(4326008)(2501003)(476003)(2616005)(486006)(7736002)(11346002)(305945005)(6506007)(386003)(2906002)(71200400001)(110136005)(5660300002)(102836004)(36756003)(54906003)(31696002)(86362001)(99286004)(6116002)(3846002)(316002)(52116002)(76176011)(71190400001)(66476007);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB5066;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rjju1+xMwtQ0GMSbC0ZNIXbKk6pScN9uhbCUxfHcZdRNywoqiCmvuD4D7IkB/YlMpXtDOoc8ClDqnpu/kSDOAzWhLsTbBn+PN5W8hf64+WhYPiClj866H5F9WEZpviBERyLBxe4j3fzrWaHCBMChmWbjiAyJIse7xSDFxMkEeT+Wer9oV/OMOCqtxSmK7VTeDJZhGKnSkPVkDp1CNkjIkDeGlfUIBFW1/p7wTo5XMEfJoukJN2bBVPWxOe9vz810LtFIj4VDo4bYrv76utjfzmtfRQZKWvIj0sWdYYVuKQsyoqDVA2C0KOBxVjFFHEcbkPRhfMKx5EY+1xH6A45cFYJkqKti4PUerI9gsL0Nu5KZT7pio96q2JxblHcCU6ZVQDYK+Wat1VLzPiyuKbVSTK8xz47hrezzv7JIrVB7QM4=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <E0E7798E3F5CC047A4DC67CAFC9A0365@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d30678e0-6306-46dc-115c-08d748152494
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2019 15:19:54.2992 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c+MSh2huebEjFM9FddLpLJR9PAB8LO160K+2q8Zjcjv/qqapu2Dr2FzHEt6oQ9Me6SwbNQxEc0bUDT+1XNwxwXnls1VLQZrxNYj9WfUl0hM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5066
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.14.127
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
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MDEuMTAuMjAxOSAyMjo0NiwgTWF4IFJlaXR6IHdyb3RlOg0KPiBTaWduZWQtb2ZmLWJ5OiBNYXgg
UmVpdHogPG1yZWl0ekByZWRoYXQuY29tPg0KPiAtLS0NCj4gICB0ZXN0cy9xZW11LWlvdGVzdHMv
aW90ZXN0cy5weSB8IDEzICsrKysrKysrKysrKysNCj4gICAxIGZpbGUgY2hhbmdlZCwgMTMgaW5z
ZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL3Rlc3RzL3FlbXUtaW90ZXN0cy9pb3Rlc3Rz
LnB5IGIvdGVzdHMvcWVtdS1pb3Rlc3RzL2lvdGVzdHMucHkNCj4gaW5kZXggNzAzMDkwMDgwNy4u
Y2RjYjYyYzRhYyAxMDA2NDQNCj4gLS0tIGEvdGVzdHMvcWVtdS1pb3Rlc3RzL2lvdGVzdHMucHkN
Cj4gKysrIGIvdGVzdHMvcWVtdS1pb3Rlc3RzL2lvdGVzdHMucHkNCj4gQEAgLTk1MCw2ICs5NTAs
MTkgQEAgZGVmIHNraXBfaWZfdW5zdXBwb3J0ZWQocmVxdWlyZWRfZm9ybWF0cz1bXSwgcmVhZF9v
bmx5PUZhbHNlKToNCj4gICAgICAgICAgIHJldHVybiBmdW5jX3dyYXBwZXINCj4gICAgICAgcmV0
dXJuIHNraXBfdGVzdF9kZWNvcmF0b3INCj4gICANCj4gK2RlZiBza2lwX2Zvcl9pbWdvcHRzKHVu
c3VwcG9ydGVkX29wdHM9W10pOg0KPiArICAgICcnJ1NraXAgVGVzdCBEZWNvcmF0b3INCj4gKyAg
ICAgICBTa2lwcyB0aGUgdGVzdCBpZiBpbWdvcHRzIGNvbnRhaW5zIGFueSBvZiB0aGUgZ2l2ZW4g
b3B0aW9ucycnJw0KPiArICAgIGRlZiBza2lwX3Rlc3RfZGVjb3JhdG9yKGZ1bmMpOg0KPiArICAg
ICAgICBkZWYgZnVuY193cmFwcGVyKHRlc3RfY2FzZTogUU1QVGVzdENhc2UsICphcmdzLCAqKmt3
YXJncyk6DQoNCmhvdyBhYm91dA0KDQp1bnN1cCA9IHNldChpbWdvcHRzKSAmIHNldCh1bnN1cHBv
cnRlZF9vcHRzKQ0KaWYgdW5zdXA6DQogICAgdGVzdF9jYXNlLmNhc2Vfc2tpcCgnLi4uIE9wdGlv
bnMge30gYXJlIC4uLicsIGZvcm1hdCguLi4sICcsICcuam9pbihtYXAoc3RyLCB1bnN1cCkpKQ0K
DQo+ICsgICAgICAgICAgICBmb3Igb3B0IGluIGltZ29wdHM6DQo+ICsgICAgICAgICAgICAgICAg
aWYgYW55KHVuc3VwcG9ydGVkIGluIG9wdCBmb3IgdW5zdXBwb3J0ZWQgaW4gdW5zdXBwb3J0ZWRf
b3B0cyk6DQo+ICsgICAgICAgICAgICAgICAgICAgIHRlc3RfY2FzZS5jYXNlX3NraXAoJ3t9OiBP
cHRpb24ge30gaXMgdW5zdXBwb3J0ZWQnLmZvcm1hdCgNCj4gKyAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICB0ZXN0X2Nhc2UsIG9wdCkpDQo+ICsgICAgICAgICAgICByZXR1
cm4gZnVuYyh0ZXN0X2Nhc2UsICphcmdzLCAqKmt3YXJncykNCj4gKyAgICAgICAgcmV0dXJuIGZ1
bmNfd3JhcHBlcg0KPiArICAgIHJldHVybiBza2lwX3Rlc3RfZGVjb3JhdG9yDQo+ICsNCj4gICBk
ZWYgZXhlY3V0ZV91bml0dGVzdChkZWJ1Zz1GYWxzZSk6DQo+ICAgICAgICIiIkV4ZWN1dGVzIHVu
aXR0ZXN0cyB3aXRoaW4gdGhlIGNhbGxpbmcgbW9kdWxlLiIiIg0KPiAgIA0KPiANCg0KDQotLSAN
CkJlc3QgcmVnYXJkcywNClZsYWRpbWlyDQo=

