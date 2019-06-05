Return-Path: <SRS0=3v23=UE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D02ACC28CC5
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 14:29:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E04E2075B
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 14:29:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="hejR6p4I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E04E2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43578 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYWv3-000564-V7
	for qemu-devel@archiver.kernel.org; Wed, 05 Jun 2019 10:29:37 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53694)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hYWuF-0004nX-Gx
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 10:28:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hYWuD-0005xw-HO
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 10:28:47 -0400
Received: from mail-eopbgr30130.outbound.protection.outlook.com
	([40.107.3.130]:3669
	helo=EUR03-AM5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1hYWu9-0005mg-Di; Wed, 05 Jun 2019 10:28:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=o2UYwQJpx6lURYsc0a4hC42wYktk3wh8Nm4nIS/Li7A=;
	b=hejR6p4IsmrPLs6kCDmTBXu2zpUoLxRu8Gjm3gfMW1RQcb6xmimP7lW3UMXeD5Dw0WKgNZvNFAPpcenpmWU4TgLCod8nC7zWZhhS5VjQddvwNvi6wj0JxkRC5GdS7rnPIgwXGULuK12Iugh1olm/9L4vwmc0GHwyZNuBAqndqtQ=
Received: from AM0PR08MB2961.eurprd08.prod.outlook.com (52.134.126.11) by
	AM0PR08MB5043.eurprd08.prod.outlook.com (10.255.29.148) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1943.22; Wed, 5 Jun 2019 14:28:37 +0000
Received: from AM0PR08MB2961.eurprd08.prod.outlook.com
	([fe80::8d90:32ae:bdd6:48e8]) by
	AM0PR08MB2961.eurprd08.prod.outlook.com
	([fe80::8d90:32ae:bdd6:48e8%7]) with mapi id 15.20.1965.011;
	Wed, 5 Jun 2019 14:28:37 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: John Snow <jsnow@redhat.com>, "qemu-devel@nongnu.org"
	<qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Thread-Topic: [Qemu-devel] [PATCH v3 1/3] docs/interop/bitmaps.rst: Fix typos
Thread-Index: AQHVGlZ0LGG82Xst6k6mQiBANP/1baaNITwA
Date: Wed, 5 Jun 2019 14:28:37 +0000
Message-ID: <2cfbd96d-afa3-b688-6bfe-8431a5823877@virtuozzo.com>
References: <20190603214653.29369-1-jsnow@redhat.com>
	<20190603214653.29369-2-jsnow@redhat.com>
In-Reply-To: <20190603214653.29369-2-jsnow@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0402CA0052.eurprd04.prod.outlook.com
	(2603:10a6:7:7c::41) To AM0PR08MB2961.eurprd08.prod.outlook.com
	(2603:10a6:208:66::11)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190605172834688
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 659d9a0a-ccbb-42b2-4ba4-08d6e9c218c8
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
	SRVR:AM0PR08MB5043; 
x-ms-traffictypediagnostic: AM0PR08MB5043:
x-microsoft-antispam-prvs: <AM0PR08MB50436C45BAFD8D9F4C9D98B6C1160@AM0PR08MB5043.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1265;
x-forefront-prvs: 00594E8DBA
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(39850400004)(396003)(366004)(136003)(346002)(376002)(199004)(189003)(8676002)(76176011)(36756003)(26005)(68736007)(478600001)(81166006)(4744005)(81156014)(53936002)(229853002)(6486002)(31696002)(2201001)(6116002)(99286004)(8936002)(3846002)(14454004)(186003)(86362001)(6512007)(446003)(305945005)(52116002)(6436002)(7736002)(2906002)(71190400001)(71200400001)(25786009)(31686004)(66446008)(64756008)(486006)(66476007)(66556008)(11346002)(2616005)(476003)(66066001)(386003)(73956011)(6246003)(2501003)(256004)(66946007)(6506007)(4326008)(110136005)(54906003)(316002)(5660300002)(102836004);
	DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB5043;
	H:AM0PR08MB2961.eurprd08.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 3UFTRSCGu1un7+q9GkDfo5wjWtz8+qMgbXX3prRld0HLVKsBFvBHrSqpMm8OWhsoLesScSJLvPtk/BcgjebjOZhUnPvqxbmkttxHA2fCw1sbzBCrf86NbP7QPLZ9F2KzAxPrUuHFBgmQufIKvukfK4rOJ1qJ+1e4oVDPV0MNNCERvMEjKKLDKsAZO9FBCn/oB+S334Yh7fiohzd6s4OPI9w7R+uloQLR4CBHsYWKE90AsR6cmOnOsiaHH8GLet1brZsYLYwrQ05aArAaGr6W3HSledWg+osXINlok43ZheljrqEQCykJcdtcx7nQ/c7FuTFbqn1pyy7eYEB/NqEbBfqKa7W5g48LEHNKbZZZdIB1BTvEruTbRrKXdkNePp1RhxaHxN+NhoJbJ4CRS0qpe76RmUNnaXS7kVG8ddIdpYM=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5F3D30C3212E514B9D4EC0D6E05A0755@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 659d9a0a-ccbb-42b2-4ba4-08d6e9c218c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2019 14:28:37.4637 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vsementsov@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB5043
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.3.130
Subject: Re: [Qemu-devel] [PATCH v3 1/3] docs/interop/bitmaps.rst: Fix typos
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
	Aarushi Mehta <mehta.aaru20@gmail.com>,
	Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MDQuMDYuMjAxOSAwOjQ2LCBKb2huIFNub3cgd3JvdGU6DQo+IFB5Z21lbnRzIGFuZCBTcGhpbngg
Z2V0IHBpY2tpZXIgYWxsIHRoZSB0aW1lOyBTcGhpbnggMi4xKyBub3cgY2F0Y2hlcw0KPiB0aGVz
ZSBlcnJvcnMuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBKb2huIFNub3cgPGpzbm93QHJlZGhhdC5j
b20+DQoNClJldmlld2VkLWJ5OiBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IDx2c2VtZW50
c292QHZpcnR1b3p6by5jb20+DQoNCj4gLS0tDQo+ICAgZG9jcy9pbnRlcm9wL2JpdG1hcHMucnN0
IHwgNCArKy0tDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlv
bnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kb2NzL2ludGVyb3AvYml0bWFwcy5yc3QgYi9kb2Nz
L2ludGVyb3AvYml0bWFwcy5yc3QNCj4gaW5kZXggNTEwZTg4MDlhOS4uYzI5YWM0YTg1NCAxMDA2
NDQNCj4gLS0tIGEvZG9jcy9pbnRlcm9wL2JpdG1hcHMucnN0DQo+ICsrKyBiL2RvY3MvaW50ZXJv
cC9iaXRtYXBzLnJzdA0KPiBAQCAtMzk5LDcgKzM5OSw3IEBAIGluIGFueSBvbmUgc291cmNlIGJp
dG1hcCwgdGhlIHRhcmdldCBiaXRtYXAgd2lsbCBtYXJrIHRoYXQgc2VnbWVudCBkaXJ0eS4NCj4g
ICAgICAgICAgImFyZ3VtZW50cyI6IHsNCj4gICAgICAgICAgICAibm9kZSI6ICJkcml2ZTAiLA0K
PiAgICAgICAgICAgICJ0YXJnZXQiOiAibmV3X2JpdG1hcCIsDQo+IC0gICAgICAgICAiYml0bWFw
czogWyAiYml0bWFwMCIgXQ0KPiArICAgICAgICAgImJpdG1hcHMiOiBbICJiaXRtYXAwIiBdDQo+
ICAgICAgICAgIH0NCj4gICAgICAgIH0NCj4gICANCj4gQEAgLTE0MzcsNyArMTQzNyw3IEBAIGFw
cGxpZWQ6DQo+ICAgICAgLi4gY29kZTo6IGpzb24NCj4gICANCj4gICAgICAgPC0gew0KPiAtICAg
ICAgICAgInRpbWVzdGFtcCI6IHsuLi59DQo+ICsgICAgICAgICAidGltZXN0YW1wIjogey4uLn0s
DQo+ICAgICAgICAgICAgImRhdGEiOiB7DQo+ICAgICAgICAgICAgICAiZGV2aWNlIjogImRyaXZl
MCIsDQo+ICAgICAgICAgICAgICAidHlwZSI6ICJiYWNrdXAiLA0KPiANCg0KDQotLSANCkJlc3Qg
cmVnYXJkcywNClZsYWRpbWlyDQo=

