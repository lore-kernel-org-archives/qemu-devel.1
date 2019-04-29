Return-Path: <SRS0=sEuR=S7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88F1BC43219
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 09:21:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DF2920578
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 09:21:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Is6yvvTs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DF2920578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54569 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hL2Tn-0004O1-ED
	for qemu-devel@archiver.kernel.org; Mon, 29 Apr 2019 05:21:43 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36681)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hL2QH-0001vx-Lh
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 05:18:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hL2QG-0000Qg-P7
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 05:18:05 -0400
Received: from mail-eopbgr90102.outbound.protection.outlook.com
	([40.107.9.102]:58400
	helo=FRA01-MR2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1hL2QC-0000Nr-EC; Mon, 29 Apr 2019 05:18:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=iKLPCnsSr6tsW+iLTC/MG4fOVR3pPuKeMLfTbN9qtvE=;
	b=Is6yvvTsN3XMhH0rPahQng05izB0E+VpiYar3+eZz6uI2EGpriP7Z58h/w/uWfYChdeRuZSgYOC+5I/mKfZu3Ec5bsX+8PEDfN1eFn56Xvjp0d1tVRjIpBjBioOdpbGLh01y/FyXR44mh/qKV/ES3PFj6neWoNXfW9TIUO+PC7s=
Received: from PR2PR08MB4684.eurprd08.prod.outlook.com (52.133.109.209) by
	PR2PR08MB4745.eurprd08.prod.outlook.com (52.133.107.207) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1835.14; Mon, 29 Apr 2019 09:17:57 +0000
Received: from PR2PR08MB4684.eurprd08.prod.outlook.com
	([fe80::88d7:ecf0:1120:f1a1]) by
	PR2PR08MB4684.eurprd08.prod.outlook.com
	([fe80::88d7:ecf0:1120:f1a1%3]) with mapi id 15.20.1835.018;
	Mon, 29 Apr 2019 09:17:57 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: John Snow <jsnow@redhat.com>, "qemu-devel@nongnu.org"
	<qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Thread-Topic: [PATCH v3 1/2] Makefile: add nit-picky mode to sphinx-build
Thread-Index: AQHU/H2Tvr1RJmBar0S3pKfZon114qZS394A
Date: Mon, 29 Apr 2019 09:17:56 +0000
Message-ID: <5746f6e2-c6bc-23a4-686f-b6943fedbe2c@virtuozzo.com>
References: <20190426221528.30293-1-jsnow@redhat.com>
	<20190426221528.30293-2-jsnow@redhat.com>
In-Reply-To: <20190426221528.30293-2-jsnow@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0402CA0010.eurprd04.prod.outlook.com
	(2603:10a6:3:d0::20) To PR2PR08MB4684.eurprd08.prod.outlook.com
	(2603:10a6:101:22::17)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190429121753970
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 84641901-9552-4e4f-6b0b-08d6cc83912b
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);
	SRVR:PR2PR08MB4745; 
x-ms-traffictypediagnostic: PR2PR08MB4745:
x-microsoft-antispam-prvs: <PR2PR08MB4745A59E72D09D340FDE17C1C1390@PR2PR08MB4745.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0022134A87
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(136003)(366004)(39840400004)(346002)(376002)(396003)(189003)(199004)(2616005)(11346002)(8676002)(476003)(446003)(102836004)(6506007)(386003)(6486002)(229853002)(25786009)(4326008)(8936002)(6512007)(36756003)(68736007)(26005)(3846002)(110136005)(316002)(186003)(31686004)(6116002)(54906003)(7416002)(73956011)(66946007)(66446008)(66476007)(66556008)(64756008)(81166006)(81156014)(2501003)(99286004)(76176011)(86362001)(31696002)(71190400001)(71200400001)(52116002)(256004)(305945005)(66066001)(14444005)(347745004)(6246003)(53936002)(7736002)(14454004)(97736004)(2201001)(478600001)(5660300002)(6436002)(2906002)(486006);
	DIR:OUT; SFP:1102; SCL:1; SRVR:PR2PR08MB4745;
	H:PR2PR08MB4684.eurprd08.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Jkz/7sgB2rK55Zkeyy60BBON7LKzPE5PTdma4Xfyf/iPs/Kr/PTungHSWGxuf6S7qV3yAmMtjAYWIEhJkTcbbi+RoS7UT+yoZFIwWGhWWXtnEXdq9SYs1DEob0ATQQXTYxxAYsmXUE/y45q5NF09E0lT8590jF5/a1W9jGZcMc9KmAL/4W713L9T2seyzakfwig6x66r70hvZuPeb+Qdm83HF9zm1RntEQL+JiE8oLKqalJVNDUo3jMIoSlACjmv4sc8KT0fv8XkVJ7x14IJ92m5ztbgdhIwQq4Dn0RXW3qA5jZRDB/iGZ8sn1rdG49zo1ZVcflcCO/FHFvvpJUgfyif4wUu7+aHU1cROUC1942xZnsIXRYdn2XuI61aToLu/eWxy/cXOtl8+nQyD+dVGmwrppZvXvfp/fGJJ7HNckk=
Content-Type: text/plain; charset="UTF-8"
Content-ID: <57C41FCC8C1BFB45B92A870F86DACE22@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84641901-9552-4e4f-6b0b-08d6cc83912b
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2019 09:17:57.0069 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR2PR08MB4745
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.9.102
Subject: Re: [Qemu-devel] [PATCH v3 1/2] Makefile: add nit-picky mode to
 sphinx-build
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
Message-ID: <20190429091756.jnXBcFTcqWvroZyXRA6Okpxe-ZAf1tMcf7XqcHHSG54@z>

MjcuMDQuMjAxOSAxOjE1LCBKb2huIFNub3cgd3JvdGU6DQo+IElmIHdlIGFkZCByZWZlcmVuY2Vz
IHRoYXQgZG9uJ3QgcmVzb2x2ZSAob3IgYWNjaWRlbnRhbGx5IHJlbW92ZSB0aGVtKSwNCj4gaXQg
d2lsbCBiZSBoZWxwZnVsIHRvIGhhdmUgYW4gZXJyb3IgbWVzc2FnZSBhbGVydGluZyB1cyB0byB0
aGF0Lg0KDQp0aGUgd29yZGluZyBzdGlsbCBhIGJpdCBpbiBjb25mbGljdCB3aXRoIHRoZSBmYWN0
IHRoYXQgLW4gaXMgb3JpZ2luYWxseSBhIHdhcm5pbmcsIG5vdCBlcnJvciwNCmJ1dCBJIGRvbid0
IHJlYWxseSBjYXJlOg0KDQpSZXZpZXdlZC1ieTogVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tp
eSA8dnNlbWVudHNvdkB2aXJ0dW96em8uY29tPg0KDQo+IA0KPiBUdXJuIHdhcm5pbmdzIGludG8g
ZXJyb3JzIHNvIHdlIGNhbiBiZSBhbGVydGVkIHRvIHByb2JsZW1zIGluIGJ1aWxkaW5nDQo+IHRo
ZSBkb2N1bWVudGF0aW9uIHdoZW4gdGhleSBhcmlzZS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEpv
aG4gU25vdyA8anNub3dAcmVkaGF0LmNvbT4NCj4gLS0tDQo+ICAgTWFrZWZpbGUgfCAyICstDQo+
ICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBk
aWZmIC0tZ2l0IGEvTWFrZWZpbGUgYi9NYWtlZmlsZQ0KPiBpbmRleCA2MjZhMDRkMzA1Li4xMjEx
ZTc4YzkxIDEwMDY0NA0KPiAtLS0gYS9NYWtlZmlsZQ0KPiArKysgYi9NYWtlZmlsZQ0KPiBAQCAt
OTI2LDcgKzkyNiw3IEBAIGRvY3MvdmVyc2lvbi50ZXhpOiAkKFNSQ19QQVRIKS9WRVJTSU9ODQo+
ICAgc3BoaW54ZG9jczogJChNQU5VQUxfQlVJTERESVIpL2RldmVsL2luZGV4Lmh0bWwgJChNQU5V
QUxfQlVJTERESVIpL2ludGVyb3AvaW5kZXguaHRtbA0KPiAgIA0KPiAgICMgQ2FubmVkIGNvbW1h
bmQgdG8gYnVpbGQgYSBzaW5nbGUgbWFudWFsDQo+IC1idWlsZC1tYW51YWwgPSAkKGNhbGwgcXVp
ZXQtY29tbWFuZCxzcGhpbngtYnVpbGQgJChpZiAkKFYpLCwtcSkgLWIgaHRtbCAtRCB2ZXJzaW9u
PSQoVkVSU0lPTikgLUQgcmVsZWFzZT0iJChGVUxMX1ZFUlNJT04pIiAtZCAuZG9jdHJlZXMvJDEg
JChTUkNfUEFUSCkvZG9jcy8kMSAkKE1BTlVBTF9CVUlMRERJUikvJDEgLCJTUEhJTlgiLCIkKE1B
TlVBTF9CVUlMRERJUikvJDEiKQ0KPiArYnVpbGQtbWFudWFsID0gJChjYWxsIHF1aWV0LWNvbW1h
bmQsc3BoaW54LWJ1aWxkICQoaWYgJChWKSwsLXEpIC1XIC1uIC1iIGh0bWwgLUQgdmVyc2lvbj0k
KFZFUlNJT04pIC1EIHJlbGVhc2U9IiQoRlVMTF9WRVJTSU9OKSIgLWQgLmRvY3RyZWVzLyQxICQo
U1JDX1BBVEgpL2RvY3MvJDEgJChNQU5VQUxfQlVJTERESVIpLyQxICwiU1BISU5YIiwiJChNQU5V
QUxfQlVJTERESVIpLyQxIikNCj4gICAjIFdlIGFzc3VtZSBhbGwgUlNUIGZpbGVzIGluIHRoZSBt
YW51YWwncyBkaXJlY3RvcnkgYXJlIHVzZWQgaW4gaXQNCj4gICBtYW51YWwtZGVwcyA9ICQod2ls
ZGNhcmQgJChTUkNfUEFUSCkvZG9jcy8kMS8qLnJzdCkgJChTUkNfUEFUSCkvZG9jcy8kMS9jb25m
LnB5ICQoU1JDX1BBVEgpL2RvY3MvY29uZi5weQ0KPiAgIA0KPiANCg0KDQotLSANCkJlc3QgcmVn
YXJkcywNClZsYWRpbWlyDQo=

