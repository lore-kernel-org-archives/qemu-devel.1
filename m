Return-Path: <SRS0=zUjA=SZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4412AC10F03
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 18:12:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2CF5208E4
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 18:12:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="d36gn3MF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2CF5208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57789 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hIzuJ-0000R5-8X
	for qemu-devel@archiver.kernel.org; Tue, 23 Apr 2019 14:12:39 -0400
Received: from eggs.gnu.org ([209.51.188.92]:46346)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hIzso-0007U5-Q4
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 14:11:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hIzsk-0008O5-Ut
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 14:11:04 -0400
Received: from mail-eopbgr140138.outbound.protection.outlook.com
	([40.107.14.138]:58757
	helo=EUR01-VE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1hIzse-0008Kg-Aw; Tue, 23 Apr 2019 14:10:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=GwaeUtm3pF8o/SdcUMQM1ZFB4T3h+eATix6x/wyQJgw=;
	b=d36gn3MFPOFUWjV0nqmN85+J73Jfsfiv4LWdFFiZVWaAPmm8j4O/KIJ4imCulQpIqV0KETiy3Mip9hA79aia4OEiLztaUAgTYz4SbpNYaF7F7fI9isICz3EsfpEXhazvTF5Yff5wEFjrHT/jLcVZPYQMeeutmjQnGQkALnFAw0I=
Received: from DB7PR08MB3851.eurprd08.prod.outlook.com (20.178.46.222) by
	DB7PR08MB3754.eurprd08.prod.outlook.com (20.178.45.220) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1813.17; Tue, 23 Apr 2019 18:10:53 +0000
Received: from DB7PR08MB3851.eurprd08.prod.outlook.com
	([fe80::3c82:5da0:1633:f949]) by
	DB7PR08MB3851.eurprd08.prod.outlook.com
	([fe80::3c82:5da0:1633:f949%3]) with mapi id 15.20.1813.017;
	Tue, 23 Apr 2019 18:10:53 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: John Snow <jsnow@redhat.com>, "qemu-block@nongnu.org"
	<qemu-block@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Thread-Topic: [PATCH v2 0/2] docs/interop/bitmaps: rewrite and modernize doc
Thread-Index: AQHU+VkoSJ6u4RJceEytOsmEPbzhI6ZKDRKA
Date: Tue, 23 Apr 2019 18:10:53 +0000
Message-ID: <9b85bfbf-44c1-5b6b-8aca-c1354c9e3f05@virtuozzo.com>
References: <20190422221714.7630-1-jsnow@redhat.com>
In-Reply-To: <20190422221714.7630-1-jsnow@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0390.eurprd05.prod.outlook.com
	(2603:10a6:7:94::49) To DB7PR08MB3851.eurprd08.prod.outlook.com
	(2603:10a6:10:7b::30)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190423211051039
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 21296bc4-0120-40bc-f270-08d6c817062b
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);
	SRVR:DB7PR08MB3754; 
x-ms-traffictypediagnostic: DB7PR08MB3754:
x-microsoft-antispam-prvs: <DB7PR08MB37542C27A499DD43C13C5E42C1230@DB7PR08MB3754.eurprd08.prod.outlook.com>
x-forefront-prvs: 0016DEFF96
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(136003)(366004)(396003)(39850400004)(346002)(376002)(189003)(199004)(229853002)(66066001)(31696002)(25786009)(7736002)(305945005)(52116002)(8936002)(7416002)(8676002)(2201001)(97736004)(3846002)(86362001)(81156014)(4326008)(68736007)(81166006)(478600001)(36756003)(14454004)(102836004)(31686004)(71190400001)(54906003)(316002)(6116002)(186003)(5660300002)(26005)(53936002)(6246003)(99286004)(110136005)(2616005)(66946007)(386003)(66476007)(66446008)(64756008)(2501003)(11346002)(486006)(256004)(73956011)(446003)(66556008)(6506007)(2906002)(71200400001)(6512007)(476003)(6486002)(76176011)(6436002);
	DIR:OUT; SFP:1102; SCL:1; SRVR:DB7PR08MB3754;
	H:DB7PR08MB3851.eurprd08.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: AVjtlf7YXpIUBlOC6U9A6g+0WcrpIloaS9zyPO4QuaZjBqPZa9LFXAp0CRTW861ro1JOAVpF7COhfPiUT4dnzOmOZcJK8pLZ1Y62TgK0PGr1msRbjMgd8TACzosIixtFh14IUxib0iRqtcPZ4jFSbPcbrb8fT6E8YOseD6XwbMre/nQEOn005lPKDXeWrFFJXhkuvI7gRbtZ8DB3hOrr+d5Ob85e6saSY4KLHTQuNJkro6EiTXriTemW6Sjszenvrc9dnIgS4bdXFEtWfTFE9DuQWLi/RuhRg7LGgYG/15ljqp10GRNapRMSKu0tqIgEmmWZx5De77t0vLfPEjsULGuXYPYNyQTd1oclaGJjWnzYSeWAaDg5aUy9VC3KZLo+MfqV3HvMFejPRsz1kuHzbJ2uRyOB7ylhSTUBrcvWl98=
Content-Type: text/plain; charset="UTF-8"
Content-ID: <C0D77E8D2912D54288AEF537324C4A62@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21296bc4-0120-40bc-f270-08d6c817062b
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2019 18:10:53.6192 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB3754
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.14.138
Subject: Re: [Qemu-devel] [PATCH v2 0/2] docs/interop/bitmaps: rewrite and
 modernize doc
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
Cc: Fam Zheng <fam@euphon.net>, "aliang@redhat.com" <aliang@redhat.com>,
	"kchamart@redhat.com" <kchamart@redhat.com>,
	"qemu-stable@nongnu.org" <qemu-stable@nongnu.org>,
	"armbru@redhat.com" <armbru@redhat.com>,
	"nsoffer@redhat.com" <nsoffer@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190423181053.nL8_Ug9AKvfcpiqhxSpgXJ-0RozzkZHNB9Y66rjHxgY@z>

MjMuMDQuMjAxOSAxOjE3LCBKb2huIFNub3cgd3JvdGU6DQo+IFRoZSBkb2N1bWVudGF0aW9uIGFz
IHdyaXR0ZW4gaW4gdGhlIDQuMCByZWxlYXNlIGlzIG5vdCBxdWl0ZSBjb3JyZWN0IGFzDQo+IG9m
IHRoZSA0LjAgcmVsZWFzZTsgdGhvdWdoIHRoYW5rcyB0byBiYWNrd2FyZHMgY29tcGF0aWJpbGl0
eSBpdCdzIG5vdA0KPiBxdWl0ZSB3cm9uZyBlaXRoZXIuIEl0IGlzIHN1aXRhYmxlIGZvciBpbmNs
dXNpb24gaW4gNC4wLjEsIG9yIGFueQ0KPiBkb3duc3RyZWFtIHRoYXQgcGFja2FnZXMgNC4wLg0K
PiANCj4gVGhpcyBwYXRjaCBpcyBhbiBhdHRlbXB0IGF0IGEgbmVhcmx5IGZ1bGwgcmV3cml0ZSB0
aGF0IHJldml0YWxpemVzIHRoaXMNCj4gZG9jdW1lbnQgdG8gYWRkcmVzcyBmcmVxdWVudCBxdWVz
dGlvbnMgSSBlbmNvdW50ZXIgd2hlbiBkaXNjdXNzaW5nIHRoZQ0KPiBBUEkuDQo+IA0KPiBWMjoN
Cj4gICAgLSBTcGxpdCBvZmYgbWFrZWZpbGUgY2hhbmdlIGludG8gaXRzIG93biBsaXR0bGUgcGF0
Y2guDQo+IA0KPiAgICAtIEFkZHJlc3NlZCAoYWxtb3N0KSBhbGwgY29tbWVudHMgZnJvbSBWbGFk
aW1pci4NCj4gICAgICAtIEV4YW1wbGUgc3R5bGluZyB3YXMgbm90IHJld29ya2VkLg0KPiAgICAt
IFJlbmFtZWQgYWxsIGZpbGVuYW1lcyB0byBiZSBjb25zaXN0ZW50IHRocm91Z2hvdXQgdGhlIGRv
Y3VtZW50LA0KPiAgICAgIGZpeGluZyBhIGZldyBtb3JlIGZpbGUgZXh0ZW5zaW9ucyBpbiB0aGUg
cHJvY2Vzcw0KPiAgICAtIFJlZmxvd2VkIGFsbW9zdCBhbGwgcGFyYWdyYXBocyB0byA3OCBjb2x1
bW5zIGZvciBjb25zaXN0ZW5jeS4NCj4gICAgLSBDaGFuZ2VkIGEgZmV3IGJ1bGxldGVkIGxpc3Rz
IHRvIHBhcmFncmFwaHMgaW5zdGVhZA0KPiAgICAtIENoYW5nZWQgdGhlIGJpZyBhc2NpaSB0ZXh0
IGRpYWdyYW0gdG8gYSBtb3JlIGNvbXBhY3QgdmVyc2lvbg0KPiAgICAgIGFuZCBjbGFyaWZpZWQg
aXRzIGxhbmd1YWdlDQo+ICAgIC0gV2hpbGUgaW4gZ2VuZXJhbCBJIHByZWZlciB0byB1c2UgZW5f
VVMgc3BlbGxpbmdzLCBJIGhhdmUNCj4gICAgICByZXBsYWNlZCAiY2FuY2VsZWQiIHdpdGggImNh
bmNlbGxlZCIgc28gaXQgZG9lcyBub3QgbG9vaw0KPiAgICAgIG91dCBvZiBwbGFjZSBqdXh0YXBv
c2VkIHdpdGggQkxPQ0tfSk9CX0NBTkNFTExFRC4uLg0KPiANCj4gRnV0dXJlIHdvcmsgdGhhdCBy
ZW1haW5zIHRvIGJlIGRvbmU6DQo+IA0KPiAtIFBheWluZyBoZWVkIHRvIGJsb2NrZGV2LWJhY2t1
cCB3b3JrZmxvd3MNCj4gLSBBZGRpbmcgYSBzbWFsbCBtaWdyYXRpb24gc2VjdGlvbiBleHBsYWlu
aW5nIHRoZSBvcHRpb25zIHRoZXJlDQo+IC0gUG9zc2libHkgcmV3b3JraW5nIHNvbWUgb2YgdGhl
IHNlY3Rpb25zIHRoYXQgYWxsIG1ha2UgdGhlaXIgb3duDQo+ICAgIHJlcGVhdGVkIGF0dGVtcHRz
IHRvIGNsYXJpZnkgdGltZSBpbnRlcnZhbCBkaXNjcmV0aXphdGlvbiBhbmQgYWRkaW5nDQo+ICAg
IGEgcHJvcGVyIHRyZWF0bWVudCBvZiB0aGUgaWRlYSBzdGFydCB0byBmaW5pc2g7IHRoaXMgbWF5
IGJlIG5lY2Nlc3NhcnkNCj4gICAgdG8gZXhwbGFpbiB0aGUgdHdvIGJlbG93IGl0ZW1zIHByb3Bl
cmx5Og0KPiAtIERpZmZlcmVudGlhbCBCYWNrdXBzDQo+IC0gUHVsbCBCYWNrdXBzIGFuZCBOQkQN
Cg0KVGhpcyBhbGwgbG9va3MgYSBiaXQgbW9yZSB0aGFuIGp1c3QgImJpdG1hcHMucnN0Ii4gSSB0
aGluayBhdCBsZWFzdCBtb3N0IG9mIHRoaW5ncw0KYWJvdXQgYmFja3VwcyBzaG91bGQgYmUgc2Vw
YXJhdGVkIGludG8gYmFja3VwLnJzdC4gKEJ1dCwgcGxlYXNlLCBhcyBhIGZvbGxvdy11cCwgaWYN
CnlvdSBhZ3JlZSkuDQoNCj4gDQo+IEpvaG4gU25vdyAoMik6DQo+ICAgIE1ha2VmaWxlOiBhZGQg
bml0LXBpY2t5IG1vZGUgdG8gc3BoaW54LWJ1aWxkDQo+ICAgIGRvY3MvaW50ZXJvcC9iaXRtYXBz
OiByZXdyaXRlIGFuZCBtb2Rlcm5pemUgZG9jDQo+IA0KPiAgIGRvY3MvaW50ZXJvcC9iaXRtYXBz
LnJzdCB8IDE2MDAgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0NCj4gICBN
YWtlZmlsZSAgICAgICAgICAgICAgICAgfCAgICAyICstDQo+ICAgMiBmaWxlcyBjaGFuZ2VkLCAx
MjY2IGluc2VydGlvbnMoKyksIDMzNiBkZWxldGlvbnMoLSkNCj4gDQoNCg0KLS0gDQpCZXN0IHJl
Z2FyZHMsDQpWbGFkaW1pcg0K

