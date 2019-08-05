Return-Path: <SRS0=vzij=WB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 938AAC433FF
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 17:00:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54A742147A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 17:00:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Yd5JYALt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54A742147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56114 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hugL2-0003Wh-KG
	for qemu-devel@archiver.kernel.org; Mon, 05 Aug 2019 13:00:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41135)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hugKQ-0002to-As
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 12:59:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hugKP-0007ad-7b
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 12:59:22 -0400
Received: from mail-eopbgr20093.outbound.protection.outlook.com
 ([40.107.2.93]:29678 helo=EUR02-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1hugKM-0007Z3-BL; Mon, 05 Aug 2019 12:59:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ncUQwuc0CxPecbwY+YfsE4iWf+M7KOJPZC0NU0K0NGiO4AllHatdK71rqdFhoOcafCXObsHnyXgw1BRNPVJ9RVi26Q4IAzhR9c9fzcnnMxJWecU86ttXGes6ebuRjGbWVDIKtwolxVoNa1JHYOTx+ZQ/bLx4KZsJl0iBY2Tqi9juGikV1RG/8Tr/odBc+t1huyp97wEOWXWE7l7EnSaxrVKaRBQ4Edz/DQKbOGQGVjBq6LzpMWIgwrWsQUBOqkVKtGfTgH2j8ZSNSnPZexzpUiYQa8RC1g6JTiIgOGD2Fq97DCJLYECY9eVpcxhtUJ22FwMielRW8iBAO9Z/mbYmCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HMyVkU4CcKlWKhSlWWcg33BizebBrvTJIOZOR83HnuY=;
 b=Ple4s4YjAvoPn1EtLd2vNwkPcCOxemRIwo6CiW3jDCh38U1YCO2a1Rjcra6PBnb0uBLVaxP9aFspJv8RMCfTHz8dLc5nUdMoVfQKc2oW05s1tAl8cJJ9nlSd4PsTFUUzMnpLjx0ZOXqPYuKY/x8BC0QB14Vg9xtn7ys3cUxeHd3nZyIfguNcpf0a4oBevALLv3nDEL/Rv+L+uKUZtG928AsbpHN62w/k7uxBxv1mkouJ3R580i8q2sxnO+vQMcgVc/mm9qNYmha+h6PW23SzhhV4lRVj6057iDrnntPAlTm7cGaSpdfkF+oQHZuS6B9jjeWNlp7LgEroZG0/YK+/2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=virtuozzo.com;dmarc=pass action=none
 header.from=virtuozzo.com;dkim=pass header.d=virtuozzo.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HMyVkU4CcKlWKhSlWWcg33BizebBrvTJIOZOR83HnuY=;
 b=Yd5JYALttd2m8qLpCK3AbYjirWO/e4IolYbCcV3kMIJ3/i1j+hHGfLdEb6tEwe7CP7S2ELGJnrrtDPJq5CsHnktyO+nZn7ur0SwlywfZldaZeKUl/7+hPSYdHGgVyTDbB0gRlEZ6p7GLcYR3oY8TsF2HhqNwxaXxnWWqDPr1DNY=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB5274.eurprd08.prod.outlook.com (10.255.17.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.17; Mon, 5 Aug 2019 16:59:14 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604%3]) with mapi id 15.20.2136.018; Mon, 5 Aug 2019
 16:59:14 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Thread-Topic: [Qemu-devel] [PULL 0/7] Block patches for 4.1.0-rc4
Thread-Index: AQHVS6xDZEVVtFAaNEC99bymFcYAmqbsxtyA
Date: Mon, 5 Aug 2019 16:59:14 +0000
Message-ID: <d7a1adf8-d0a2-dead-b8d5-2576d9b05f47@virtuozzo.com>
References: <20190805163740.23616-1-mreitz@redhat.com>
In-Reply-To: <20190805163740.23616-1-mreitz@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0802CA0008.eurprd08.prod.outlook.com
 (2603:10a6:3:bd::18) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190805195911255
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bd514322-b4a2-42df-a31d-08d719c63e91
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DB8PR08MB5274; 
x-ms-traffictypediagnostic: DB8PR08MB5274:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <DB8PR08MB527460690058DD2B39BA8887C1DA0@DB8PR08MB5274.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:404;
x-forefront-prvs: 01208B1E18
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(376002)(346002)(366004)(136003)(39850400004)(396003)(189003)(199004)(54906003)(186003)(110136005)(36756003)(66446008)(66476007)(3846002)(64756008)(99286004)(66556008)(66946007)(476003)(6306002)(2616005)(52116002)(229853002)(486006)(26005)(6436002)(6486002)(6512007)(66066001)(2501003)(76176011)(446003)(11346002)(53936002)(2906002)(102836004)(316002)(31696002)(6506007)(6246003)(68736007)(386003)(71190400001)(4326008)(86362001)(7736002)(305945005)(6116002)(31686004)(71200400001)(14444005)(81166006)(478600001)(966005)(14454004)(5660300002)(25786009)(8936002)(256004)(81156014)(8676002)(5024004);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB5274;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: VWo1hAIVMQCrXx8nkIGBwxgFOhrv+ryusJnQaUAeDKxCiyKaEDwsRmX+uVeqU5NvhvicwoLnW5Va3rOeLbJXRcmjlFkCLGujC726O7P6LiTHuHWz1Lz2OyPlh3h7gM74n3pUZyhCLnFElpt5k8UXuvEovpsRAq1ib3YncKfGmAIoVI3IbrHB6wgR89GnzbcTcVuTkOPrkBlgWUxGiTHRA4D69GyiZcg25ZLMEd9dYv3f+6B2QNRcTF7HFTriJDgO/9eYfOA6gS3SMVwnq7MvqTLHkTf0IW3qeT1L83pPLsWoa5r1bLk57SIgC/fLzRWbOgU+F3dN/gC7Smkfyebs3V+WsyySiIPoqYoaRm6v8bh8kAlbejTmnlcYxKGorXlNhYmsYRIKe2ErCv+nkyON03C/8uuplv2jmoUNCvETS6A=
Content-Type: text/plain; charset="utf-8"
Content-ID: <016C58B671B20744A8027D92A5953AD8@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd514322-b4a2-42df-a31d-08d719c63e91
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2019 16:59:14.2457 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vsementsov@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5274
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.2.93
Subject: Re: [Qemu-devel] [PULL 0/7] Block patches for 4.1.0-rc4
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 qemu-stable <qemu-stable@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MDUuMDguMjAxOSAxOTozNywgTWF4IFJlaXR6IHdyb3RlOg0KPiBUaGUgZm9sbG93aW5nIGNoYW5n
ZXMgc2luY2UgY29tbWl0IDliYjY4ZDM0ZGRhOWJlNjAzMzVlNzNlNjVjOGZiNjFiY2EwMzUzNjI6
DQo+IA0KPiAgICBNZXJnZSByZW1vdGUtdHJhY2tpbmcgYnJhbmNoICdyZW1vdGVzL3BoaWxtZC1n
aXRsYWIvdGFncy9lZGsyLW5leHQtMjAxOTA4MDMnIGludG8gc3RhZ2luZyAoMjAxOS0wOC0wNSAx
MTowNTozNiArMDEwMCkNCj4gDQo+IGFyZSBhdmFpbGFibGUgaW4gdGhlIEdpdCByZXBvc2l0b3J5
IGF0Og0KPiANCj4gICAgaHR0cHM6Ly9naXRodWIuY29tL1hhbkNsaWMvcWVtdS5naXQgdGFncy9w
dWxsLWJsb2NrLTIwMTktMDgtMDUNCj4gDQo+IGZvciB5b3UgdG8gZmV0Y2ggY2hhbmdlcyB1cCB0
byAwN2IwODUxYzU5MmVmZTE4OGE4NzI1OWFkYmRhMjZhNjNjNjFkYzkyOg0KPiANCj4gICAgYmxv
Y2svYmFja3VwOiBkaXNhYmxlIGNvcHlfcmFuZ2UgZm9yIGNvbXByZXNzZWQgYmFja3VwICgyMDE5
LTA4LTA1IDE4OjA1OjA1ICswMjAwKQ0KPiANCj4gLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiBCbG9jayBwYXRjaGVzIGZv
ciA0LjEuMC1yYzQ6DQo+IC0gRml4IHRoZSBiYWNrdXAgYmxvY2sgam9iIHdoZW4gdXNpbmcgY29w
eSBvZmZsb2FkaW5nDQo+IC0gRml4IHRoZSBtaXJyb3IgYmxvY2sgam9iIHdoZW4gdXNpbmcgdGhl
IHdyaXRlLWJsb2NraW5nIGNvcHkgbW9kZQ0KPiAtIEZpeCBpbmNyZW1lbnRhbCBiYWNrdXBzIGFm
dGVyIHRoZSBpbWFnZSBoYXMgYmVlbiBncm93biB3aXRoIHRoZQ0KPiAgICByZXNwZWN0aXZlIGJp
dG1hcCBhdHRhY2hlZCB0byBpdA0KPiANCj4gLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiBNYXggUmVpdHogKDUpOg0KPiAg
ICBiYWNrdXA6IENvcHkgb25seSBkaXJ0eSBhcmVhcw0KPiAgICBpb3Rlc3RzOiBUZXN0IGJhY2t1
cCBqb2Igd2l0aCB0d28gZ3Vlc3Qgd3JpdGVzDQo+ICAgIGlvdGVzdHM6IFRlc3QgaW5jcmVtZW50
YWwgYmFja3VwIGFmdGVyIHRydW5jYXRpb24NCj4gICAgbWlycm9yOiBPbmx5IG1pcnJvciBncmFu
dWxhcml0eS1hbGlnbmVkIGNodW5rcw0KPiAgICBpb3Rlc3RzOiBUZXN0IHVuYWxpZ25lZCBibG9j
a2luZyBtaXJyb3Igd3JpdGUNCj4gDQo+IFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkgKDIp
Og0KPiAgICB1dGlsL2hiaXRtYXA6IHVwZGF0ZSBvcmlnX3NpemUgb24gdHJ1bmNhdGUNCj4gICAg
YmxvY2svYmFja3VwOiBkaXNhYmxlIGNvcHlfcmFuZ2UgZm9yIGNvbXByZXNzZWQgYmFja3VwDQo+
IA0KDQpBcyBJIHVuZGVyc3RhbmQsIHRoaXMgYWxsIHNob3VsZCBnbyB0byBzdGFibGUgdG9vPyBD
QyBpdC4NCg0KLS0gDQpCZXN0IHJlZ2FyZHMsDQpWbGFkaW1pcg0K

