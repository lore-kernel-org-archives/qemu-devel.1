Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F4DFC2D0CE
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 14:45:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA32E2253D
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 14:45:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="hXzYcU9W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA32E2253D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55902 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itumM-0005kd-Pr
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 09:45:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38398)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1itu0q-0005tT-GF
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 08:56:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1itu0o-0003PQ-HT
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 08:56:12 -0500
Received: from mail-db8eur05on2094.outbound.protection.outlook.com
 ([40.107.20.94]:20865 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1itu0f-0003LC-I2; Tue, 21 Jan 2020 08:56:02 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ll8qUOOvEYAkF6hv1KufDPzyf32rt2CYlhHJvVVs2Yveu1GvoWlRYVQtwl/XO+CFbkRMKnB5lLJ4ObCmod8PvK6eC/F3Z/mtm7Aoqjrxzpem0u1Vctp9AfZgQhqn0KSUeyeZUDp6NdAXx6LhfaXcaQ8OdOVtRxhU3yOI5pPlALTDVzUB4REP7othVGsn0xqRTwhG4j2t44Z6YC4LxTTS4pH2ECkB61b8dxAKGCl510a39Dl3R4aQGLZxMd13+gSNbyoWRxtZehSIeynJQSdVpsk7Iumyy3P4gp5NZgnh1Liy4Zzay7HON9HbwNqihg0MbvehRMOZzGkrC4xisK6Kng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mn4YDTU56vuSqEKwsy/ntc7pM/jc3XV/qjnrl3I8C1c=;
 b=Q6h5IDerZ/he/cWG30XXQTwNBPOSH/dhOpz9SR1HAiVYu/UAQMRhmG5KHkzuV8o96YPR3EXcUhon6pTkBcsAXAVEnufN6/PAR1zMfQz9a9/I4jgb2CuiBjfSjxXX/+ocIxwlyzOGcVT9c+GWOFsg4vjvUlfJBWlj8ofiqZoDGJ4M1x/W2+XH46g+Nb7jhizAsOc/YJmMUui20IGl4lXpmsfLpuzUzx217ujBGaFTdIWTW6q5B5O/OeX/+fSjD9aGoPcicrYzZggHW2bktI0OwkjQoXi4wkKh+ySJjVjCEVPsS0Mhi/pHu3N5ZLqWv7n8aInN9ywNMiusvKpkquh+zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mn4YDTU56vuSqEKwsy/ntc7pM/jc3XV/qjnrl3I8C1c=;
 b=hXzYcU9WFrcnDc44R8sDl85/VbiFCWG9t59rU+FDiNZIl0Yh4bat7O5Bg8mCcFWJxk/HRB50gtAqci9ucWd6rrZeeqtIjMs5FIJaZwKS8DTwVi1w8w3j4Mauxc+k0opeJuZDGB2oJPcS70fHdWR6m4eRnzzCTsoJI9/xqIe4hco=
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB3093.eurprd08.prod.outlook.com (52.135.161.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.19; Tue, 21 Jan 2020 13:55:59 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030%7]) with mapi id 15.20.2644.027; Tue, 21 Jan 2020
 13:55:59 +0000
Received: from [172.16.24.200] (185.231.240.5) by
 AM0PR05CA0062.eurprd05.prod.outlook.com (2603:10a6:208:be::39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.20 via Frontend Transport; Tue, 21 Jan 2020 13:55:58 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Subject: Re: [PATCH 2/2] iotests: add test for backup-top failure on
 permission activation
Thread-Topic: [PATCH 2/2] iotests: add test for backup-top failure on
 permission activation
Thread-Index: AQHVzIVUyOIzH3fEwkGWDPORhit+OafzzmgAgAAESICAAQrFgIAANI8A///S/oCAABBigIAAIRyAgAATd4CAAACxAIAAAU+A
Date: Tue, 21 Jan 2020 13:55:59 +0000
Message-ID: <08bc201e-b40c-a79c-6388-bd17a3a8316c@virtuozzo.com>
References: <20200116155452.30972-1-vsementsov@virtuozzo.com>
 <20200116155452.30972-3-vsementsov@virtuozzo.com>
 <eedd42b6-bf4e-f6de-13a4-412d389fdb09@redhat.com>
 <ea9219cd-8cc1-8cc0-d568-a51013ba74a4@virtuozzo.com>
 <f52b6ff5-e993-d567-cbbe-1d6d158908da@redhat.com>
 <0e865df2-7d21-b18f-b73c-2948577b9dcb@virtuozzo.com>
 <1313e55e-0eb1-890a-4e8e-2517f1e80d38@redhat.com>
 <04a32d71-31da-a3e3-5c5f-cc6465fc9402@virtuozzo.com>
 <6923bc19-d203-63af-b206-8fe18e4a01c6@redhat.com>
 <6e0c4e88-6745-a668-6946-237032fdbedd@virtuozzo.com>
 <29434a72-d2cc-5976-cbd7-ceac714d4d65@redhat.com>
In-Reply-To: <29434a72-d2cc-5976-cbd7-ceac714d4d65@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM0PR05CA0062.eurprd05.prod.outlook.com
 (2603:10a6:208:be::39) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20200121165557882
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ab3c0a11-a36c-40da-88b7-08d79e79a4ed
x-ms-traffictypediagnostic: AM6PR08MB3093:
x-microsoft-antispam-prvs: <AM6PR08MB309332B5B45888F894C3BF66C10D0@AM6PR08MB3093.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0289B6431E
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(136003)(39850400004)(366004)(346002)(396003)(376002)(189003)(199004)(31696002)(86362001)(26005)(8676002)(52116002)(81156014)(53546011)(8936002)(6486002)(64756008)(66946007)(4326008)(31686004)(81166006)(66476007)(66446008)(66556008)(186003)(2616005)(110136005)(508600001)(16576012)(36756003)(5660300002)(2906002)(316002)(16526019)(54906003)(956004)(71200400001)(2004002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB3093;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6HPqSMoMNm0JtrZwx5uB7JxOaeKyqT6irVFOc74Kfyv6BaM1Q9d5Llvgs4J0VNL+sMibnoLdyJvkrpP48i0Ncdp4v0jIBxxyNf+szgbVKyifbQ5ShF6DXDHHUWUZnzxUyOYf+suI3GGHQKTYqDiH59/q1uQqxIv/6kZQVw1CT/aOzSz6Wcc28ksRZQLbhTj3Gt8FPjDadQ2PwUP5Kq8jkwrWEM7c3T1zAbbp0tdWaPmq+DAwJheL0Q+3f/iCH+KG1hT+NVEvEZDw8EIM2tPTASNrJRgfDRG8uAu4QtCjBsG81DPx9xoeKXjrJwWKGP5yCSl2ZrSpCzjLnE7P0Knf0k2G0qWkljfysn8Jj/D8mrM8D5y5NOMkwW4gTxbehVVKMc8ZfzpeDebCfz9XNuGEIhiaxxZHo7d3JUp90cQ9zgxTRio99elZfhcm37U6x/YYNsExDSpKeuwxECuvUkothkXgyn23E5NRWscWh8vG3naIsM5oV0tCa7FOYcbqinFCZXyqk8bQaf5ATt8kbqmgRdtCWwjqmlrOuu6YfpPEylYDaXM2L+/k0FpdGMUxQoAj
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <F4620D7A6BBD9F408F7F5DF2F88C4D94@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab3c0a11-a36c-40da-88b7-08d79e79a4ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2020 13:55:59.2435 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ypzg/BCFpV2zqxjp2Shex0CPvVJAdn3JDd7SAIFaEwI5ZVxEDouPZM0tm62JYTXV5l5t9zIAAnRsJ/StDd5Nf48oNHruTx0/UHNZqHGd71M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3093
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.20.94
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
 "qemu-stable@nongnu.org" <qemu-stable@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MjEuMDEuMjAyMCAxNjo1MSwgTWF4IFJlaXR6IHdyb3RlOg0KPiBPbiAyMS4wMS4yMCAxNDo0OCwg
VmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4+IDIxLjAxLjIwMjAgMTU6Mzks
IE1heCBSZWl0eiB3cm90ZToNCj4+PiBPbiAyMS4wMS4yMCAxMTo0MCwgVmxhZGltaXIgU2VtZW50
c292LU9naWV2c2tpeSB3cm90ZToNCj4+Pj4gMjEuMDEuMjAyMCAxMjo0MSwgTWF4IFJlaXR6IHdy
b3RlOg0KPj4+Pj4gT24gMjEuMDEuMjAgMTA6MjMsIFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNr
aXkgd3JvdGU6DQo+Pj4+Pj4gMjEuMDEuMjAyMCAxMjoxNCwgTWF4IFJlaXR6IHdyb3RlOg0KPj4+
Pj4+PiBPbiAyMC4wMS4yMCAxODoyMCwgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90
ZToNCj4+Pj4+Pj4+IDIwLjAxLjIwMjAgMjA6MDQsIE1heCBSZWl0eiB3cm90ZToNCj4+Pj4+Pj4+
PiBPbiAxNi4wMS4yMCAxNjo1NCwgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToN
Cj4+Pj4+Pj4+Pj4gVGhpcyB0ZXN0IGNoZWNrcyB0aGF0IGJ1ZyBpcyByZWFsbHkgZml4ZWQgYnkg
cHJldmlvdXMgY29tbWl0Lg0KPj4+Pj4+Pj4+Pg0KPj4+Pj4+Pj4+PiBDYzogcWVtdS1zdGFibGVA
bm9uZ251Lm9yZyAjIHY0LjIuMA0KPj4+Pj4+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBWbGFkaW1pciBT
ZW1lbnRzb3YtT2dpZXZza2l5IDx2c2VtZW50c292QHZpcnR1b3p6by5jb20+DQo+Pj4+Pj4+Pj4+
IC0tLQ0KPj4+Pj4+Pj4+PiAgICAgICB0ZXN0cy9xZW11LWlvdGVzdHMvMjgzICAgICB8IDc1ICsr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+Pj4+Pj4+Pj4+ICAgICAgIHRl
c3RzL3FlbXUtaW90ZXN0cy8yODMub3V0IHwgIDggKysrKw0KPj4+Pj4+Pj4+PiAgICAgICB0ZXN0
cy9xZW11LWlvdGVzdHMvZ3JvdXAgICB8ICAxICsNCj4+Pj4+Pj4+Pj4gICAgICAgMyBmaWxlcyBj
aGFuZ2VkLCA4NCBpbnNlcnRpb25zKCspDQo+Pj4+Pj4+Pj4+ICAgICAgIGNyZWF0ZSBtb2RlIDEw
MDY0NCB0ZXN0cy9xZW11LWlvdGVzdHMvMjgzDQo+Pj4+Pj4+Pj4+ICAgICAgIGNyZWF0ZSBtb2Rl
IDEwMDY0NCB0ZXN0cy9xZW11LWlvdGVzdHMvMjgzLm91dA0KPj4+Pj4+Pj4+DQo+Pj4+Pj4+Pj4g
VGhlIHRlc3QgbG9va3MgZ29vZCB0byBtZSwgSSBqdXN0IGhhdmUgYSBjb21tZW50IG5pdCBhbmQg
YSBub3RlIG9uIHRoZQ0KPj4+Pj4+Pj4+IGZhY3QgdGhhdCB0aGlzIHNob3VsZCBwcm9iYWJseSBi
ZSBxdWV1ZWQgb25seSBhZnRlciBUaG9tYXPigJlzIOKAnEVuYWJsZQ0KPj4+Pj4+Pj4+IG1vcmUg
aW90ZXN0cyBkdXJpbmcgIm1ha2UgY2hlY2stYmxvY2si4oCdIHNlcmllcy4NCj4+Pj4+Pj4+Pg0K
Pj4+Pj4+Pj4+PiBkaWZmIC0tZ2l0IGEvdGVzdHMvcWVtdS1pb3Rlc3RzLzI4MyBiL3Rlc3RzL3Fl
bXUtaW90ZXN0cy8yODMNCj4+Pj4+Pj4+Pj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4+Pj4+Pj4+
Pj4gaW5kZXggMDAwMDAwMDAwMC4uZjBmMjE2ZDEwOQ0KPj4+Pj4+Pj4+PiAtLS0gL2Rldi9udWxs
DQo+Pj4+Pj4+Pj4+ICsrKyBiL3Rlc3RzL3FlbXUtaW90ZXN0cy8yODMNCj4+Pj4+Pj4+Pj4gQEAg
LTAsMCArMSw3NSBAQA0KPj4+Pj4+Pj4+PiArIyEvdXNyL2Jpbi9lbnYgcHl0aG9uDQo+Pj4+Pj4+
Pj4+ICsjDQo+Pj4+Pj4+Pj4+ICsjIFRlc3QgZm9yIGJhY2t1cC10b3AgZmlsdGVyIHBlcm1pc3Np
b24gYWN0aXZhdGlvbiBmYWlsdXJlDQo+Pj4+Pj4+Pj4+ICsjDQo+Pj4+Pj4+Pj4+ICsjIENvcHly
aWdodCAoYykgMjAxOSBWaXJ0dW96em8gSW50ZXJuYXRpb25hbCBHbWJILg0KPj4+Pj4+Pj4+PiAr
Iw0KPj4+Pj4+Pj4+PiArIyBUaGlzIHByb2dyYW0gaXMgZnJlZSBzb2Z0d2FyZTsgeW91IGNhbiBy
ZWRpc3RyaWJ1dGUgaXQgYW5kL29yIG1vZGlmeQ0KPj4+Pj4+Pj4+PiArIyBpdCB1bmRlciB0aGUg
dGVybXMgb2YgdGhlIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlIGFzIHB1Ymxpc2hlZCBieQ0K
Pj4+Pj4+Pj4+PiArIyB0aGUgRnJlZSBTb2Z0d2FyZSBGb3VuZGF0aW9uOyBlaXRoZXIgdmVyc2lv
biAyIG9mIHRoZSBMaWNlbnNlLCBvcg0KPj4+Pj4+Pj4+PiArIyAoYXQgeW91ciBvcHRpb24pIGFu
eSBsYXRlciB2ZXJzaW9uLg0KPj4+Pj4+Pj4+PiArIw0KPj4+Pj4+Pj4+PiArIyBUaGlzIHByb2dy
YW0gaXMgZGlzdHJpYnV0ZWQgaW4gdGhlIGhvcGUgdGhhdCBpdCB3aWxsIGJlIHVzZWZ1bCwNCj4+
Pj4+Pj4+Pj4gKyMgYnV0IFdJVEhPVVQgQU5ZIFdBUlJBTlRZOyB3aXRob3V0IGV2ZW4gdGhlIGlt
cGxpZWQgd2FycmFudHkgb2YNCj4+Pj4+Pj4+Pj4gKyMgTUVSQ0hBTlRBQklMSVRZIG9yIEZJVE5F
U1MgRk9SIEEgUEFSVElDVUxBUiBQVVJQT1NFLiAgU2VlIHRoZQ0KPj4+Pj4+Pj4+PiArIyBHTlUg
R2VuZXJhbCBQdWJsaWMgTGljZW5zZSBmb3IgbW9yZSBkZXRhaWxzLg0KPj4+Pj4+Pj4+PiArIw0K
Pj4+Pj4+Pj4+PiArIyBZb3Ugc2hvdWxkIGhhdmUgcmVjZWl2ZWQgYSBjb3B5IG9mIHRoZSBHTlUg
R2VuZXJhbCBQdWJsaWMgTGljZW5zZQ0KPj4+Pj4+Pj4+PiArIyBhbG9uZyB3aXRoIHRoaXMgcHJv
Z3JhbS4gIElmIG5vdCwgc2VlIDxodHRwOi8vd3d3LmdudS5vcmcvbGljZW5zZXMvPi4NCj4+Pj4+
Pj4+Pj4gKyMNCj4+Pj4+Pj4+Pj4gKw0KPj4+Pj4+Pj4+PiAraW1wb3J0IGlvdGVzdHMNCj4+Pj4+
Pj4+Pj4gKw0KPj4+Pj4+Pj4+PiArIyBUaGUgdGVzdCBpcyB1bnJlbGF0ZWQgdG8gZm9ybWF0cywg
cmVzdHJpY3QgaXQgdG8gcWNvdzIgdG8gYXZvaWQgZXh0cmEgcnVucw0KPj4+Pj4+Pj4+PiAraW90
ZXN0cy52ZXJpZnlfaW1hZ2VfZm9ybWF0KHN1cHBvcnRlZF9mbXRzPVsncWNvdzInXSkNCj4+Pj4+
Pj4+Pj4gKw0KPj4+Pj4+Pj4+PiArc2l6ZSA9IDEwMjQgKiAxMDI0DQo+Pj4+Pj4+Pj4+ICsNCj4+
Pj4+Pj4+Pj4gKyIiIg0KPj4+Pj4+Pj4+PiArT24gYWN0aXZhdGlvbiwgYmFja3VwLXRvcCBpcyBn
b2luZyB0byB1bnNoYXJlIHdyaXRlIHBlcm1pc3Npb24gb24gaXRzDQo+Pj4+Pj4+Pj4+ICtzb3Vy
Y2UgY2hpbGQuIEl0IHdpbGwgYmUgaW1wb3NzaWJsZSBmb3IgdGhlIGZvbGxvd2luZyBjb25maWd1
cmF0aW9uOg0KPj4+Pj4+Pj4+DQo+Pj4+Pj4+Pj4g4oCcVGhlIGZvbGxvd2luZyBjb25maWd1cmF0
aW9uIHdpbGwgYmVjb21lIGltcG9zc2libGXigJ0/DQo+Pj4+Pj4+Pg0KPj4+Pj4+Pj4gSG1tLCBu
bywgdGhlIGNvbmZpZ3VyYXRpb24gaXMgcG9zc2libGUuIEJ1dCAiaXQiLCBpLmUuICJ1bnNoYXJl
IHdyaXRlIHBlcm1pc3Npb24iLA0KPj4+Pj4+Pj4gaXMgaW1wb3NzaWJsZSB3aXRoIHN1Y2ggY29u
ZmlndXJhdGlvbi4uDQo+Pj4+Pj4+DQo+Pj4+Pj4+IEJ1dCBiYWNrdXBfdG9wIGFsd2F5cyB1bnNo
YXJlcyB0aGUgd3JpdGUgcGVybWlzc2lvbiBvbiB0aGUgc291cmNlLg0KPj4+Pj4+DQo+Pj4+Pj4g
WWVzLCBhbmQgSSBqdXN0IHRyeSB0byBzYXksIHRoYXQgdGhpcyBhY3Rpb24gd2lsbCBmYWlsLiBB
bmQgdGhlIHRlc3QgY2hlY2tzIHRoYXQgaXQNCj4+Pj4+PiBmYWlscyAoYW5kIGl0IGNyYXNoZXMg
d2l0aCBjdXJyZW50IG1hc3RlciBpbnN0ZWFkIG9mIGZhaWwpLg0KPj4+Pj4NCj4+Pj4+IE9LLiAg
U28gd2hhdCBJIHdhcyB0cnlpbmcgdG8gc2F5IGlzIHRoYXQgdGhlIGNvbW1lbnQgY3VycmVudGx5
IG9ubHkNCj4+Pj4+IHN0YXRlcyB0aGF0IHRoaXMgd2lsbCBmYWlsLiAgSeKAmWQgcHJlZmVyIGl0
IHRvIGFsc28gcmVhc3N1cmUgbWUgdGhhdCBpdOKAmXMNCj4+Pj4+IGNvcnJlY3QgdGhhdCB0aGlz
IGZhaWxzIChiZWNhdXNlIGFsbCB3cml0ZXMgb24gdGhlIGJhY2t1cCBzb3VyY2UgbXVzdCBnbw0K
Pj4+Pj4gdGhyb3VnaCBiYWNrdXBfdG9wKSwgYW5kIHRoYXQgdGhpcyBpcyBleGFjdGx5IHdoYXQg
d2Ugd2FudCB0byB0ZXN0IGhlcmUuDQo+Pj4+Pg0KPj4+Pj4gT24gZmlyc3QgcmVhZGluZywgSSB3
YXMgd29uZGVyaW5nIHdoeSBleGFjdGx5IHRoaXMgY29tbWVudCB3b3VsZCB0ZWxsIG1lDQo+Pj4+
PiBhbGwgdGhlc2UgdGhpbmdzLCBiZWNhdXNlIEkgZGlkbuKAmXQga25vdyB3aGF0IHRoZSB0ZXN0
IHdhbnRzIHRvIHRlc3QgaW4NCj4+Pj4+IHRoZSBmaXJzdCBwbGFjZS4NCj4+Pj4+DQo+Pj4+PiBN
YXgNCj4+Pj4NCj4+Pj4gSG1tLCBzb21ldGhpbmcgbGlrZToNCj4+Pj4NCj4+Pj4gQmFja3VwIHdh
bnRzIHRvIGNvcHkgYSBwb2ludC1pbi10aW1lIHN0YXRlIG9mIHRoZSBzb3VyY2Ugbm9kZS4gU28s
IGl0IGNhdGNoZXMgYWxsIHdyaXRlcw0KPj4+PiB0byB0aGUgc291cmNlIG5vZGUgYnkgYXBwZW5k
aW5nIGJhY2t1cC10b3AgZmlsdGVyIGFib3ZlIGl0LiBTbyB3ZSBoYW5kbGUgYWxsIGNoYW5nZXMg
d2hpY2gNCj4+Pj4gY29tZXMgZnJvbSBzb3VyY2Ugbm9kZSBwYXJlbnRzLiBUbyBwcmV2ZW50IGFw
cGVhcmluZyBvZiBuZXcgd3JpdGluZyBwYXJlbnRzIGR1cmluZyB0aGUNCj4+Pj4gcHJvZ3Jlc3Ms
IGJhY2t1cC10b3AgdW5zaGFyZXMgd3JpdGUgcGVybWlzc2lvbiBvbiBpdHMgc291cmNlIGNoaWxk
LiBUaGlzIGhhcyBhZGRpdGlvbmFsDQo+Pj4+IGltcGxpY2F0aW9uOiBhcyB0aGlzICJ1bnNoYXJp
bmciIGlzIHByb3BhZ2F0ZWQgYnkgZGVmYXVsdCBieSBiYWNraW5nL2ZpbGUgY2hpbGRyZW4sDQo+
Pj4+IGJhY2t1cC10b3AgY29uZmxpY3RzIHdpdGggYW55IHNpZGUgcGFyZW50cyBvZiBzb3VyY2Ug
c3ViLXRyZWUgd2l0aCB3cml0ZSBwZXJtaXNzaW9uLg0KPj4+PiBBbmQgdGhpcyBpcyBpbiBnb29k
IHJlbGF0aW9uIHdpdGggdGhlIGdlbmVyYWwgaWRlYTogd2l0aCBzdWNoIHBhcmVudHMgd2UgY2Fu
J3QgZ3VhcmFudGVlDQo+Pj4+IHBvaW50LWluLXRpbWUgYmFja3VwLg0KPj4+DQo+Pj4gV29ya3Mg
Zm9yIG1lICh0aGFua3MgOi0pKSwgYnV0IGEgc2hvcnRlciDigJxXaGVuIHBlcmZvcm1pbmcgYSBi
YWNrdXAsIGFsbA0KPj4+IHdyaXRlcyBvbiB0aGUgc291cmNlIHN1YnRyZWUgbXVzdCBnbyB0aHJv
dWdoIHRoZSBiYWNrdXAtdG9wIGZpbHRlciBzbyBpdA0KPj4+IGNhbiBjb3B5IGFsbCBkYXRhIHRv
IHRoZSB0YXJnZXQgYmVmb3JlIGl0IGlzIGNoYW5nZWQuICBUaGVyZWZvcmUsDQo+Pj4gYmFja3Vw
LXRvcCBjYW5ub3QgYWxsb3cgb3RoZXIgbm9kZXMgdG8gY2hhbmdlIGRhdGEgb24gaXRzIHNvdXJj
ZSBjaGlsZC7igJ0NCj4+PiB3b3VsZCB3b3JrIGZvciBtZSBqdXN0IGFzIHdlbGwuDQo+Pj4NCj4+
Pj4gU28sIHRyeWluZyB0byBiYWNrdXAgdGhlIGNvbmZpZ3VyYXRpb24gd2l0aCB3cml0aW5nIHNp
ZGUgcGFyZW50cyBvZg0KPj4+PiBzb3VyY2Ugc3ViLXRyZWUgbm9kZXMgc2hvdWxkIGZhaWwuIExl
dCdzIHRlc3QgaXQuDQo+Pg0KPj4gQnV0IHRoYW4sIHdlIG5lZWQgc29tZWhvdyBsaW5rIHBhcnQg
YWJvdXQgYXBwZW5kaW5nIGJhY2t1cC10b3AgYW5kIHNvLW9uLi4uDQo+Pg0KPj4gV2hlbiBwZXJm
b3JtaW5nIGEgYmFja3VwLCBhbGwgd3JpdGVzIG9uIHRoZSBzb3VyY2Ugc3VidHJlZSBtdXN0IGdv
IHRocm91Z2ggdGhlIGJhY2t1cC10b3AgZmlsdGVyIHNvIGl0IGNhbiBjb3B5IGFsbCBkYXRhIHRv
IHRoZSB0YXJnZXQgYmVmb3JlIGl0IGlzIGNoYW5nZWQuDQo+PiBiYWNrdXAtdG9wIGZpbHRlciBp
cyBhcHBlbmRlZCBhYm92ZSBzb3VyY2Ugbm9kZSwgdG8gYWNoaWV2ZSB0aGlzIHRoaW5nLCBzbyBh
bGwgcGFyZW50cyBvZiBzb3VyY2Ugbm9kZSBhcmUgaGFuZGxlZC4NCj4+IEEgY29uZmlndXJhdGlv
biB3aXRoIHNpZGUgcGFyZW50cyBvZiBzb3VyY2Ugc3ViLXRyZWUgd2l0aCB3cml0ZSBwZXJtaXNz
aW9uIGlzIHVuc3VwcG9ydGVkICh3ZSdkIGhhdmUgYXBwZW5kIHNldmVyYWwgYmFja3VwLXRvcCBm
aWx0ZXIgbGlrZSBub2RlcyB0byBoYW5kbGUgc3VjaCBwYXJlbnRzKS4NCj4+IFRoZSB0ZXN0IGNy
ZWF0ZSBhbiBleGFtcGxlIG9mIHN1Y2ggY29uZmlndXJhdGlvbiBhbmQgY2hlY2tzIHRoYXQgYmFj
a3VwIGZhaWxzLg0KPiANCj4gU291bmRzIGdvb2QhDQo+IA0KPiAoRXhjZXB0IG1heWJlIHMvdGhh
dCBiYWNrdXAgZmFpbHMvdGhhdCBhIGJhY2t1cCBpcyB0aGVuIG5vdCBhbGxvd2VkLz8NCj4g4oCc
YmFja3VwIGZhaWxz4oCdIG1pZ2h0IGFsc28gbWVhbiB0aGF0IHRoZSBqb2IganVzdCBwcm9kdWNl
cyBnYXJiYWdlLikNCg0KT0sgZm9yIG1lLiBNYXkgYmUgImJhY2t1cCBpcyB0aGVuIG5vdCBhbGxv
d2VkIChibG9ja2Rldi1iYWNrdXAgY29tbWFuZCBzaG91bGQgZmFpbCkiLg0KDQpTaG91bGQgSSBy
ZXNlbmQ/IEkgdGhpbmsgaXQncyBiZXR0ZXIgZHJvcCAiYXV0byIgbWFyayBhbmQgbm90IGNyZWF0
ZSBleHRyYSBkZXBlbmRlbmN5IG9uIG90aGVyIHNlcmllcy4NCg0KDQotLSANCkJlc3QgcmVnYXJk
cywNClZsYWRpbWlyDQo=

