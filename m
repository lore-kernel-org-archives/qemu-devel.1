Return-Path: <SRS0=3XOk=S2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FB47C10F11
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 14:20:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBC48218FE
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 14:20:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="W0Zmk9VQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBC48218FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42421 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJIkv-0006aQ-3L
	for qemu-devel@archiver.kernel.org; Wed, 24 Apr 2019 10:20:13 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39085)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hJIff-0002aF-Er
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 10:14:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hJIWu-00068i-No
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 10:05:49 -0400
Received: from mail-eopbgr40109.outbound.protection.outlook.com
	([40.107.4.109]:16636
	helo=EUR03-DB5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1hJIWu-00064P-22; Wed, 24 Apr 2019 10:05:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=Khc3Har5M/ybiLNA4Xqa6jEW71UlOMDqRGRmU5vutdo=;
	b=W0Zmk9VQjol6fwXvhs/x9QiMlHp6Ed4uV4rk9QGODuCB7LoBjcPdAALU7sOn5W6HmxeDj+IKxXwOQfmIfchFK9r1Nw6E1n/0w65tfmVKeLU5iw9wLJqoeRZjvyzhLu+WZhQ7Fi7R+4vTH4OVjzJ92uyAkZOldv3mYev52ZfLBWM=
Received: from DB7PR08MB3851.eurprd08.prod.outlook.com (20.178.46.222) by
	DB7PR08MB3612.eurprd08.prod.outlook.com (20.177.120.142) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1835.12; Wed, 24 Apr 2019 14:05:41 +0000
Received: from DB7PR08MB3851.eurprd08.prod.outlook.com
	([fe80::3c82:5da0:1633:f949]) by
	DB7PR08MB3851.eurprd08.prod.outlook.com
	([fe80::3c82:5da0:1633:f949%3]) with mapi id 15.20.1813.017;
	Wed, 24 Apr 2019 14:05:41 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
	<qemu-block@nongnu.org>
Thread-Topic: [Qemu-devel] [PATCH 0/3] qemu-img: Allow rebase with no input
	base
Thread-Index: AQHU8hOZBPDFXraAfkSD/PJ5F8DVG6ZCXoiAgAkGO4CAAAStgA==
Date: Wed, 24 Apr 2019 14:05:41 +0000
Message-ID: <f8b16373-3cf4-ff16-b453-dbdc741b41a9@virtuozzo.com>
References: <20180713111424.23670-1-mreitz@redhat.com>
	<9afddacb-ca54-6ac3-1c02-b8916a08fcd3@redhat.com>
	<c3f01ebe-37f7-d1d8-8bcd-45df37d80ff6@virtuozzo.com>
	<3583e4e9-d29e-fc5a-6e83-637e515c38f7@redhat.com>
In-Reply-To: <3583e4e9-d29e-fc5a-6e83-637e515c38f7@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR1001CA0017.EURPRD10.PROD.OUTLOOK.COM
	(2603:10a6:3:f7::27) To DB7PR08MB3851.eurprd08.prod.outlook.com
	(2603:10a6:10:7b::30)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190424170539080
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7a708b91-5181-43a1-bc67-08d6c8bdef73
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);
	SRVR:DB7PR08MB3612; 
x-ms-traffictypediagnostic: DB7PR08MB3612:
x-microsoft-antispam-prvs: <DB7PR08MB3612BFE3D729F6F76E925AACC13C0@DB7PR08MB3612.eurprd08.prod.outlook.com>
x-forefront-prvs: 00179089FD
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(346002)(366004)(376002)(136003)(396003)(39850400004)(189003)(199004)(102836004)(66446008)(6506007)(2501003)(186003)(66066001)(386003)(53546011)(66476007)(486006)(52116002)(26005)(53936002)(36756003)(11346002)(446003)(476003)(31696002)(73956011)(86362001)(5660300002)(64756008)(66946007)(6246003)(2616005)(66556008)(76176011)(7736002)(4744005)(31686004)(305945005)(2906002)(6486002)(6436002)(4326008)(81156014)(93886005)(81166006)(6512007)(229853002)(256004)(316002)(8676002)(8936002)(25786009)(6116002)(3846002)(97736004)(99286004)(68736007)(14454004)(54906003)(110136005)(478600001)(71190400001)(71200400001);
	DIR:OUT; SFP:1102; SCL:1; SRVR:DB7PR08MB3612;
	H:DB7PR08MB3851.eurprd08.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: X6l/jYPC6b2c7dPLARomRzWQC6KqtxtKwdvEacj9C8VtocXPqqwgQle1d+8nhP6+vj24rSBJQrXJECBCpCrvoGr3obb4qiLCeWrxVk/WCZq+Kvl8TPkioHgcgvRZ03rqews2JsQBCEb8L5ks8imM+JMRpipPtIfIONPBuuSwKNQMU3K1cainAqDj7quFs6g7ShFcewgQKkTerh8HVzWELh37e4SUpyHNXDaKc3mxLGn0thf9Wip8DFYB7WJzOxHHpBDFlRxmVRxLat1WM7jv9mMvrRWjKXPufDKAW1DY8Dt3kkTCgU/Fh3IDghIh1fMjuCntMWnYXwfyvhnA+GTRb/cFpvxASo4dnXkXNspXL9oZ1aAoL/tLpJM2OdmyHYND4HQRUOSnzXaUrZeJjkN1Zj7adzSzBL6wPIuIvDnJe3o=
Content-Type: text/plain; charset="UTF-8"
Content-ID: <EFAB9D39F2540D4D8AB247A803306EB3@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a708b91-5181-43a1-bc67-08d6c8bdef73
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2019 14:05:41.7722 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB3612
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.4.109
Subject: Re: [Qemu-devel] [PATCH 0/3] qemu-img: Allow rebase with no input
 base
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
Cc: Kevin Wolf <kwolf@redhat.com>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190424140541.GyaKrQ3tAoxMhSwbm3gelgxYEvolv5WgEx3HThnNgdo@z>

MjQuMDQuMjAxOSAxNjo0OCwgTWF4IFJlaXR6IHdyb3RlOg0KPiBPbiAxOC4wNC4xOSAxOTowMCwg
VmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4+IDEzLjA0LjIwMTkgMTk6MTEs
IE1heCBSZWl0eiB3cm90ZToNCj4+PiBQaW5nIGFnYWluDQo+Pj4NCj4+PiAoSSBmZWVsIGxpa2Ug
SSBqdXN0IG5lZWQgdG8gc3RhcnQgbWVyZ2luZyB1bnJldmlld2VkIHBhdGNoZXMgdW50aWwgSQ0K
Pj4+IGJyZWFrIHNvbWV0aGluZyAoY2FuJ3QgdGFrZSB0aGF0IGxvbmcpIHNvIHlvdSBnZXQgc28g
c2NhcmVkIG9mIG15DQo+Pj4gcGF0Y2hlcyB0aGF0IHlvdSBhdCBsZWFzdCByZWZ1c2UgdGhlbSBv
dXRyaWdodCkNCj4+DQo+PiBDb3VsZCB5b3UgcmVzZW5kIGJlZm9yZT8NCj4gDQo+IFN1cmUsIGJ1
dCBmb3IgbWUsIHRoaXMgc2VyaWVzIHN0aWxsIGFwcGxpZXMgYXMtaXMuDQo+IA0KDQpGb3IgbWUg
dGhlIHByb2JsZW0gaXMgdGhhdCBJJ3ZlIHJlbW92ZWQgbWFpbHMgb2xkZXIgdGhhbiBoYWxmIGEg
eWVhciBzb21lIHRpbWUNCmFnby4uDQoNCg0KLS0gDQpCZXN0IHJlZ2FyZHMsDQpWbGFkaW1pcg0K

