Return-Path: <SRS0=sEuR=S7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C20C7C43219
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 09:31:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7552F206BF
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 09:31:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="OcWZaEJ3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7552F206BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54738 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hL2dT-0003Vg-Dv
	for qemu-devel@archiver.kernel.org; Mon, 29 Apr 2019 05:31:43 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39444)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hL2c5-0002ai-8k
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 05:30:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hL2c4-0006v2-7y
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 05:30:17 -0400
Received: from mail-eopbgr90131.outbound.protection.outlook.com
	([40.107.9.131]:54240
	helo=FRA01-MR2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1hL2bz-0006cf-DY; Mon, 29 Apr 2019 05:30:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=lM5Jbw/dW/94FAZyNJf2cZ1qtnrlc54gK6Egq7dxnrQ=;
	b=OcWZaEJ3rBROkjgrTfnrL/YGBdsSN5d96HppoWnVVgov2KLoJ87mYAFzBiD84ZxuMr71wO4aeCK0b/zxO8mqmx8oOJz2NLKWste8tLpSoUtEUIGUqPt8Z5+mgRxSHJKy8dXHLieeIMxRjBjejDbJPaPgf8/EfDS1xGHV3M/MqYY=
Received: from PR2PR08MB4684.eurprd08.prod.outlook.com (52.133.109.209) by
	PR2PR08MB5227.eurprd08.prod.outlook.com (52.133.110.86) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1835.12; Mon, 29 Apr 2019 09:30:07 +0000
Received: from PR2PR08MB4684.eurprd08.prod.outlook.com
	([fe80::88d7:ecf0:1120:f1a1]) by
	PR2PR08MB4684.eurprd08.prod.outlook.com
	([fe80::88d7:ecf0:1120:f1a1%3]) with mapi id 15.20.1835.018;
	Mon, 29 Apr 2019 09:30:07 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: John Snow <jsnow@redhat.com>, "qemu-devel@nongnu.org"
	<qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Thread-Topic: [PATCH v3 2/2] docs/interop/bitmaps: rewrite and modernize doc
Thread-Index: AQHU/H2U/J65RWWtG0CTD3msFDjHwKZS40UA
Date: Mon, 29 Apr 2019 09:30:07 +0000
Message-ID: <2bc77854-242f-87a7-b09d-7f23dbec108f@virtuozzo.com>
References: <20190426221528.30293-1-jsnow@redhat.com>
	<20190426221528.30293-3-jsnow@redhat.com>
In-Reply-To: <20190426221528.30293-3-jsnow@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1P191CA0009.EURP191.PROD.OUTLOOK.COM (2603:10a6:3:cf::19)
	To PR2PR08MB4684.eurprd08.prod.outlook.com
	(2603:10a6:101:22::17)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190429123004533
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c5a1270b-a83c-4228-af53-08d6cc854476
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);
	SRVR:PR2PR08MB5227; 
x-ms-traffictypediagnostic: PR2PR08MB5227:
x-microsoft-antispam-prvs: <PR2PR08MB52273A23A7C96AE504490537C1390@PR2PR08MB5227.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0022134A87
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(376002)(136003)(366004)(39840400004)(346002)(396003)(199004)(189003)(6116002)(76176011)(3846002)(52116002)(71200400001)(71190400001)(36756003)(6512007)(7736002)(97736004)(256004)(110136005)(2616005)(476003)(446003)(11346002)(2906002)(99286004)(54906003)(478600001)(31686004)(486006)(186003)(316002)(7416002)(14454004)(6506007)(81156014)(386003)(102836004)(26005)(6436002)(66066001)(6246003)(73956011)(81166006)(8676002)(66556008)(25786009)(5660300002)(2501003)(66476007)(2201001)(8936002)(4326008)(31696002)(229853002)(6486002)(53936002)(86362001)(64756008)(305945005)(66946007)(68736007)(66446008);
	DIR:OUT; SFP:1102; SCL:1; SRVR:PR2PR08MB5227;
	H:PR2PR08MB4684.eurprd08.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: AEQjZHvNLkkVrn86XV+TlF2hMcyMi4Fatj07mzBqUS6c5gTDI8RjUadYFX/IGr9xUzy9J8+NQYwtFukKY8F8VaCt8CBAzIXRnfmj8eb/4np+ZS7Nm6hXc+6O22aLZd4gJ40rB5JqdsTicEN1aflkS7XK7nr9lGavEnXs4L/BxZn9s4gr3ChbnWNffiATTs06YCMcpLTKhwRZXYLHjnrdA+5+39823wCazxN3GG/BSl3lTYhwBLvCq1KCO7c/CA05Vc5AtqqTRyOWzzAMIlmpPPySW0wjsBIyvEexU4qlKwRdqcaCprMSPmoWBpRROwSM/1OnPaNZpOJpt0R13ZX3qcWB8hpsWQbx7ypaTvCsY6tNNtQ1qKSZXuseXC3kPcWLND3RowAtEvyEwjIJOFseHv3m7CjXP7XMUUlswz5mbfk=
Content-Type: text/plain; charset="UTF-8"
Content-ID: <B3845AC2D2D8BE40AF1E10CBF2576A02@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5a1270b-a83c-4228-af53-08d6cc854476
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2019 09:30:07.3951 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR2PR08MB5227
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.9.131
Subject: Re: [Qemu-devel] [PATCH v3 2/2] docs/interop/bitmaps: rewrite and
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
Message-ID: <20190429093007.pDqYeoRg_UQKU6GQhYjN55zJ_Kn5RcuvwAhZRcGExAw@z>

MjcuMDQuMjAxOSAxOjE1LCBKb2huIFNub3cgd3JvdGU6DQo+IFRoaXMganVzdCBhYm91dCByZXdy
aXRlcyB0aGUgZW50aXJldHkgb2YgdGhlIGJpdG1hcHMucnN0IGRvY3VtZW50IHRvDQo+IG1ha2Ug
aXQgY29uc2lzdGVudCB3aXRoIHRoZSA0LjAgcmVsZWFzZS4gSSBoYXZlIGFkZGVkIG5ldyBmZWF0
dXJlcyBzZWVuDQo+IGluIHRoZSA0LjAgcmVsZWFzZSwgYXMgd2VsbCBhcyB0cmllZCB0byBjbGFy
aWZ5IHNvbWUgcG9pbnRzIHRoYXQga2VlcA0KPiBjb21pbmcgdXAgd2hlbiBkaXNjdXNzaW5nIHRo
aXMgZmVhdHVyZSBib3RoIGluLWhvdXNlIGFuZCB1cHN0cmVhbS4NCj4gDQo+IFllcywgaXQncyBh
IGxvdCBsb25nZXIsIG1vc3RseSBkdWUgdG8gZXhhbXBsZXMuIEkgZ2V0IGEgYml0IGNoYXR0eS4N
Cj4gSSBjb3VsZCB1c2UgYSBnb29kIGVkaXRvciB0byBoZWxwIHJlaWduIGluIG15IGNoYXR0aW5l
c3MuDQo+IA0KPiBJdCBkb2VzIG5vdCB5ZXQgY292ZXIgcHVsbCBiYWNrdXBzIG9yIG1pZ3JhdGlv
biBkZXRhaWxzLCBidXQgSSBpbnRlbmQgdG8NCj4ga2VlcCBleHRlbmRpbmcgdGhpcyBkb2N1bWVu
dCB0byBjb3ZlciB0aG9zZSBjYXNlcy4NCj4gDQo+IFBsZWFzZSB0cnkgY29tcGlsaW5nIGl0IHdp
dGggc3BoaW54IGFuZCBsb29rIGF0IHRoZSByZW5kZXJlZCBvdXRwdXQsIEkNCj4gZG9uJ3QgaGF2
ZSBob3N0aW5nIHRvIHNoYXJlIG15IGNvcHkgYXQgcHJlc2VudC4gSSB0aGluayB0aGlzIG5ldyBs
YXlvdXQNCj4gcmVhZHMgbmljZXIgaW4gdGhlIEhUTUwgZm9ybWF0IHRoYW4gdGhlIG9sZCBvbmUg
ZGlkLCBhdCB0aGUgZXhwZW5zZSBvZg0KPiBsb29raW5nIGxlc3MgcmVhZGFibGUgaW4gdGhlIHNv
dXJjZSB0cmVlIGl0c2VsZiAodGhvdWdoIG5vdCBjb21wbGV0ZWx5DQo+IHVubWFuYWdhYmxlLiBX
ZSBkaWQgZGVjaWRlIHRvIGNvbnZlcnQgaXQgZnJvbSBNYXJrZG93biB0byBSZVNULCBhZnRlcg0K
PiBhbGwsIHNvIEkgYW0gZ29pbmcgYWxsLWluIG9uIFJlU1QuKQ0KPiANCj4gU2lnbmVkLW9mZi1i
eTogSm9obiBTbm93PGpzbm93QHJlZGhhdC5jb20+DQoNClJldmlld2VkLWJ5OiBWbGFkaW1pciBT
ZW1lbnRzb3YtT2dpZXZza2l5IDx2c2VtZW50c292QHZpcnR1b3p6by5jb20+DQoNCi0tIA0KQmVz
dCByZWdhcmRzLA0KVmxhZGltaXINCg==

