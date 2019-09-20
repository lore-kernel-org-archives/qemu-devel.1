Return-Path: <SRS0=N0XV=XP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEECCC49ED7
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 08:42:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 980C22070C
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 08:42:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="v5KuIN/E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 980C22070C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56552 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBEVF-0007Gr-KZ
	for qemu-devel@archiver.kernel.org; Fri, 20 Sep 2019 04:42:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46182)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iBETE-0004oh-9L
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 04:40:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iBETB-0003gE-U0
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 04:40:51 -0400
Received: from mail-eopbgr70123.outbound.protection.outlook.com
 ([40.107.7.123]:15942 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iBET9-0003fS-M1; Fri, 20 Sep 2019 04:40:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iQP3PNrwwHulu01igaaZvNPW4W9bSi5zMOlXRrm425Tgc6HOHO1VPTxti1duqBNzpksuE69gdzufLIdftdWnzyEw0C5aCywvB8vDwFsm5ndxWRs7UT1+sn5CrGMIAFRYgCUrMQSwOtaYgo7z8QYb9SkzF2QduwwGZXOROiw14k0MWSYwZ/lUnPSyeDHAc4A+/UOO/YFXML4jLx/JajbqCm8+dMxJb0UX2MOVP+tBkpcA8XmNhbHfXbLpHV6uIZ118LtAQ+a6wlwwE2vAlE6E+dt3zNVha1kYw0I0AmT1Z8TX9s10Tb9IHwqolw3svOFRzL3FoH8tn/USrinvDiAR8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=99X0s4lC8DGm96td+BZWrDUtn4PzlOuggZrEqS1J2TY=;
 b=GH72+2oDG3RHFyB8GIvD56v6abIsp9361ZLGTigagUHcqMuWt7w4F9ZkLRjxrk7BmRP0YEFwgm5V+0TQ7PV5EisAIIQw3T+yuE4f/kecZJrNWoH/eoQwg4PoC00VW1Ve24E66gfD/ryG2b/qltyUiXnCZHJ+J4VulcF5j7hPbkOuGfydqVswZKuU4oA0KCesr0IkYnapS5TdgpsCgfjFL0bts1WIIhsoHWhmbpVmBh0HzVDpevsID8I3Sp2KN4Y8g1HpEfdw/m1OTFbND+Y5XX87wPdTeVq+O6wisAvczIVGWTno1rVPc607SioIcF+M+FR2FEgxSMoC6AVfzUMVHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=99X0s4lC8DGm96td+BZWrDUtn4PzlOuggZrEqS1J2TY=;
 b=v5KuIN/EkG67yD8NkOM62q8fqVUeAvyjM4CW9FlyDPiMwSotcqo2eCtNF4yNILLri0q5vG5s4kSAyf/2qkHJvu8aJGMtFvnY8gZNk1W4M5hnwjUbu3+ch5/dU/IVP6pCtLhObKy41YsBYtObqfJ8T1JQA4nO3EUKfixm3fBVKfo=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB5385.eurprd08.prod.outlook.com (52.133.241.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.20; Fri, 20 Sep 2019 08:40:45 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed%2]) with mapi id 15.20.2284.023; Fri, 20 Sep 2019
 08:40:45 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Kevin Wolf <kwolf@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Subject: Re: [PATCH v2 1/2] iotests: Require Python 3.6 or later
Thread-Topic: [PATCH v2 1/2] iotests: Require Python 3.6 or later
Thread-Index: AQHVbwgAcItFOgHuMUm6UeC6gwu0i6c0QBwA
Date: Fri, 20 Sep 2019 08:40:45 +0000
Message-ID: <5f0e3c27-1c33-0f9b-485b-c3e4a6700138@virtuozzo.com>
References: <20190919162905.21830-1-kwolf@redhat.com>
 <20190919162905.21830-2-kwolf@redhat.com>
In-Reply-To: <20190919162905.21830-2-kwolf@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1P190CA0002.EURP190.PROD.OUTLOOK.COM (2603:10a6:3:bc::12)
 To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190920114042825
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 64aff1a4-eba7-4a88-e4ae-08d73da63aa4
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DB8PR08MB5385; 
x-ms-traffictypediagnostic: DB8PR08MB5385:
x-microsoft-antispam-prvs: <DB8PR08MB538521796CBDA7C95B8DB025C1880@DB8PR08MB5385.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:404;
x-forefront-prvs: 0166B75B74
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(376002)(366004)(136003)(396003)(39850400004)(346002)(189003)(199004)(66946007)(76176011)(52116002)(86362001)(66476007)(31696002)(66556008)(66446008)(64756008)(102836004)(6486002)(386003)(6506007)(2906002)(6246003)(71190400001)(71200400001)(36756003)(14444005)(66066001)(6116002)(4326008)(3846002)(6436002)(2501003)(256004)(478600001)(8936002)(316002)(99286004)(14454004)(81156014)(54906003)(26005)(110136005)(25786009)(81166006)(229853002)(31686004)(2616005)(476003)(446003)(5660300002)(11346002)(486006)(8676002)(7736002)(186003)(6512007)(305945005);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB5385;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: GzVbVE6Cx06NetS2aUUcWLqArmJ/4FLrLOkMbQHog+4lvotYaj8gqOl/C5RPhzMrSMqQYjqPhxT6Y2MHo0yVryDG3oQp+alblw2/2RryKfAkspke7pBQAL8WFYM9eoOSDG2VYq+mPPhGUNn757+spIsjLm7C2bbRN1/I1RXIF9k71ZMdngSx0getpZzNBP3IFs4w64C7fDfdf7bv6xgvi0E2mUiC2U03Oa5EghSCHiG2oAwketeljo9y06xFzMO6KOuiTy+xT/6+OthPQRdgPsRl0gLhJTdsdUi4F/5HPywKDoIpJA4MNOVUb648Gwvqk85erOOtnjtE29nzd3MaRs5+LC1IdN9lJjwFVc2mQ07v4RVvFVWczHgTA80q3yUIkg+EB6VYcOBZmGpE7ow0YOzS9/7xsxMXhfvpRjKbaXM=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <F41FB9785540AB44BB63CAA1CF7253AE@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64aff1a4-eba7-4a88-e4ae-08d73da63aa4
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2019 08:40:45.5115 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aqvnmh5AGxYModcLtgZ5TwTa9nldgQo5i0zqogvgO7YWnoXTqvyFww+ltCE9TFfJm+EtNYZhOUoegcmWcAIhfs2YxeUFhSK4oyn5c85JzwE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5385
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.7.123
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
Cc: "thuth@redhat.com" <thuth@redhat.com>,
 "ehabkost@redhat.com" <ehabkost@redhat.com>,
 "jsnow@redhat.com" <jsnow@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>,
 "philmd@redhat.com" <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MTkuMDkuMjAxOSAxOToyOSwgS2V2aW4gV29sZiB3cm90ZToNCj4gUnVubmluZyBpb3Rlc3RzIGlz
IG5vdCByZXF1aXJlZCB0byBidWlsZCBRRU1VLCBzbyB3ZSBjYW4gaGF2ZSBzdHJpY3Rlcg0KPiB2
ZXJzaW9uIHJlcXVpcmVtZW50cyBmb3IgUHl0aG9uIGhlcmUgYW5kIGNhbiBtYWtlIHVzZSBvZiBu
ZXcgZmVhdHVyZXMNCj4gYW5kIGRyb3AgY29tcGF0aWJpbGl0eSBjb2RlIGVhcmxpZXIuDQo+IA0K
PiBUaGlzIG1ha2VzIHFlbXUtaW90ZXN0cyBza2lwIGFsbCBQeXRob24gdGVzdHMgaWYgYSBQeXRo
b24gdmVyc2lvbiBiZWZvcmUNCj4gMy42IGlzIHVzZWQgZm9yIHRoZSBidWlsZC4NCj4gDQo+IFN1
Z2dlc3RlZC1ieTogRWR1YXJkbyBIYWJrb3N0IDxlaGFia29zdEByZWRoYXQuY29tPg0KPiBTaWdu
ZWQtb2ZmLWJ5OiBLZXZpbiBXb2xmIDxrd29sZkByZWRoYXQuY29tPg0KPiAtLS0NCj4gICB0ZXN0
cy9xZW11LWlvdGVzdHMvY2hlY2sgfCAxMyArKysrKysrKysrKystDQo+ICAgMSBmaWxlIGNoYW5n
ZWQsIDEyIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS90
ZXN0cy9xZW11LWlvdGVzdHMvY2hlY2sgYi90ZXN0cy9xZW11LWlvdGVzdHMvY2hlY2sNCj4gaW5k
ZXggODc1Mzk5ZDc5Zi4uNTg4YzQ1M2E5NCAxMDA3NTUNCj4gLS0tIGEvdGVzdHMvcWVtdS1pb3Rl
c3RzL2NoZWNrDQo+ICsrKyBiL3Rlc3RzL3FlbXUtaW90ZXN0cy9jaGVjaw0KPiBAQCAtNjMzLDYg
KzYzMywxMiBAQCB0aGVuDQo+ICAgICAgIGV4cG9ydCBTT0NLRVRfU0NNX0hFTFBFUj0iJGJ1aWxk
X2lvdGVzdHMvc29ja2V0X3NjbV9oZWxwZXIiDQo+ICAgZmkNCj4gICANCj4gK3B5dGhvbl91c2Fi
bGU9ZmFsc2UNCj4gK2lmICRQWVRIT04gLWMgJ2ltcG9ydCBzeXM7IHN5cy5leGl0KDAgaWYgc3lz
LnZlcnNpb25faW5mbyA+PSAoMyw2KSBlbHNlIDEpJw0KPiArdGhlbg0KPiArICAgIHB5dGhvbl91
c2FibGU9dHJ1ZQ0KPiArZmkNCj4gKw0KPiAgIGRlZmF1bHRfbWFjaGluZT0kKCRRRU1VX1BST0cg
LW1hY2hpbmUgaGVscCB8IHNlZCAtbiAnLyhkZWZhdWx0KS8gcy8gLiovL3AnKQ0KPiAgIGRlZmF1
bHRfYWxpYXNfbWFjaGluZT0kKCRRRU1VX1BST0cgLW1hY2hpbmUgaGVscCB8IFwNCj4gICAgICBz
ZWQgLW4gIi8oYWxpYXMgb2YgJGRlZmF1bHRfbWFjaGluZSkvIHsgcy8gLiovL3A7IHE7IH0iKQ0K
PiBAQCAtODA5LDcgKzgxNSwxMiBAQCBkbw0KPiAgICAgICAgICAgc3RhcnQ9JChfd2FsbGNsb2Nr
KQ0KPiAgIA0KPiAgICAgICAgICAgaWYgWyAiJChoZWFkIC1uIDEgIiRzb3VyY2VfaW90ZXN0cy8k
c2VxIikiID09ICIjIS91c3IvYmluL2VudiBweXRob24iIF07IHRoZW4NCj4gLSAgICAgICAgICAg
IHJ1bl9jb21tYW5kPSIkUFlUSE9OICRzZXEiDQo+ICsgICAgICAgICAgICBpZiAkcHl0aG9uX3Vz
YWJsZTsgdGhlbg0KDQpobW0gSSB3YW50ZWQgdG8gc2F5IHRoYXQgdGhpcyBzaG91bGQgbm90IHdv
cmssIGFzIHB5dGhvbl91c2FibGUgaXMgYSBzdHJpbmcuIEJ1dCBJIGNoZWNrZWQNCmFuZCBzZWUg
LSBpdCdzIHdvcmsuIFdvdy4gR29vZ2xlZC4gQW5kIG5vdyBJIHVuZGVyc3RhbmQgdGhhdCBoZXJl
ICJmYWxzZSIgb3IgInRydWUiIGNvbW1hbmQNCmlzIGNhbGxlZCwgdG8gb2J0YWluIGl0J3MgcmV0
dXJuIHZhbHVlLi4gSSBkb24ndCBsaWtlIGJhc2ggYW5kIGRvbid0IGtub3cgaXRzIGJlc3QgcHJh
Y3RpY2UsDQpidXQgSSdkIHByZWZlciBweXRob25fdXNhYmxlIHRvIGJlIGp1c3QgcmV0dXJuIHZh
bHVlIG9mIHlvdXIgcHl0aG9uIGNvbW1hbmQsIGxpa2UNCg0KYWJvdmU6DQoNCiAgICRQWVRIT04g
LWMgJ2ltcG9ydCBzeXM7IHN5cy5leGl0KDAgaWYgc3lzLnZlcnNpb25faW5mbyA+PSAoMyw2KSBl
bHNlIDEpJw0KICAgcHl0aG9uX3VzYWJsZT0kPw0KDQphbmQgaGVyZToNCg0KICAgaWYgWyAkcHl0
aG9uX3VzYWJsZSAtZXEgMCBdOyB0aGVuDQoNCg0KPiArICAgICAgICAgICAgICAgIHJ1bl9jb21t
YW5kPSIkUFlUSE9OICRzZXEiDQo+ICsgICAgICAgICAgICBlbHNlDQo+ICsgICAgICAgICAgICAg
ICAgcnVuX2NvbW1hbmQ9ImZhbHNlIg0KPiArICAgICAgICAgICAgICAgIGVjaG8gIlVuc3VwcG9y
dGVkIFB5dGhvbiB2ZXJzaW9uIiA+ICRzZXEubm90cnVuDQo+ICsgICAgICAgICAgICBmaQ0KPiAg
ICAgICAgICAgZWxzZQ0KPiAgICAgICAgICAgICAgIHJ1bl9jb21tYW5kPSIuLyRzZXEiDQo+ICAg
ICAgICAgICBmaQ0KPiANCg0KDQotLSANCkJlc3QgcmVnYXJkcywNClZsYWRpbWlyDQo=

