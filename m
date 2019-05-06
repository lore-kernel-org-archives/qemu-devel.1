Return-Path: <SRS0=msIk=TG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A97FFC04A6B
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 17:15:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61F4620C01
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 17:15:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="e7ytFgHc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61F4620C01
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59611 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNhDE-0003Y4-8k
	for qemu-devel@archiver.kernel.org; Mon, 06 May 2019 13:15:36 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60967)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hNhC6-00037m-Jq
	for qemu-devel@nongnu.org; Mon, 06 May 2019 13:14:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hNhC5-0001VO-8J
	for qemu-devel@nongnu.org; Mon, 06 May 2019 13:14:26 -0400
Received: from mail-eopbgr120103.outbound.protection.outlook.com
	([40.107.12.103]:28739
	helo=FRA01-PR2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1hNhC2-0001Rx-5I; Mon, 06 May 2019 13:14:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=V4s9IFFiy7tpF4azhZvMiaxePbq8DFgrsiLXAQ9/7fg=;
	b=e7ytFgHcA/M4XcLZ1N1vNdpxMW/Y4hGkdOKvWJ9Vqv079KKrfZovewB+YSdvfMWXBj/NfotG6HvVZMHzYGtXtATvSzEVp2f159J/yqi0UZOPLJrf9mXtDnO9+TAkpHYRF3qgsQJVfYmOdEHPEYsGSPF2EOEiP/yFcaZLc3+/jRI=
Received: from PR2PR08MB4684.eurprd08.prod.outlook.com (52.133.109.209) by
	PR2PR08MB4873.eurprd08.prod.outlook.com (52.133.108.86) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1856.12; Mon, 6 May 2019 17:14:19 +0000
Received: from PR2PR08MB4684.eurprd08.prod.outlook.com
	([fe80::9c35:2e89:30c4:5cc4]) by
	PR2PR08MB4684.eurprd08.prod.outlook.com
	([fe80::9c35:2e89:30c4:5cc4%3]) with mapi id 15.20.1856.012;
	Mon, 6 May 2019 17:14:19 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Thomas Huth <thuth@redhat.com>, =?utf-8?B?QWxleCBCZW5uw6ll?=
	<alex.bennee@linaro.org>
Thread-Topic: [Qemu-devel] [RFC PATCH] tests/qemu-iotests: re-format output to
	for make check-block
Thread-Index: AQHVAb4cTdKi/fUHQEO/dv33KGMISaZZfuKAgAAUc4CAAx63gIABqLwA
Date: Mon, 6 May 2019 17:14:18 +0000
Message-ID: <ce754049-a871-b45c-9264-4de9178de62c@virtuozzo.com>
References: <20190503143904.31211-1-alex.bennee@linaro.org>
	<98cd84db-2aed-4aa1-1f2d-eaa7ac63b72b@redhat.com>
	<87d0kz4iqs.fsf@zen.linaroharston>
	<0badc17e-90bc-1a09-89c1-20f88ff75d3b@redhat.com>
In-Reply-To: <0badc17e-90bc-1a09-89c1-20f88ff75d3b@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0180.eurprd05.prod.outlook.com
	(2603:10a6:3:f8::28) To PR2PR08MB4684.eurprd08.prod.outlook.com
	(2603:10a6:101:22::17)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190506201416147
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3d10649d-7b11-4b7e-27a0-08d6d2464637
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);
	SRVR:PR2PR08MB4873; 
x-ms-traffictypediagnostic: PR2PR08MB4873:
x-microsoft-antispam-prvs: <PR2PR08MB4873710640095AF4140C657FC1300@PR2PR08MB4873.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0029F17A3F
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(39840400004)(346002)(376002)(136003)(396003)(366004)(189003)(199004)(6246003)(31696002)(316002)(4326008)(3846002)(14454004)(36756003)(6116002)(2906002)(7736002)(305945005)(66066001)(53936002)(6512007)(8936002)(8676002)(81156014)(446003)(64756008)(11346002)(2616005)(54906003)(99286004)(6436002)(486006)(476003)(26005)(6486002)(110136005)(102836004)(86362001)(186003)(256004)(14444005)(76176011)(52116002)(31686004)(68736007)(66574012)(478600001)(71190400001)(71200400001)(229853002)(25786009)(81166006)(386003)(6506007)(66476007)(66556008)(66946007)(66446008)(73956011)(5660300002);
	DIR:OUT; SFP:1102; SCL:1; SRVR:PR2PR08MB4873;
	H:PR2PR08MB4684.eurprd08.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Jx/g/vpD/Oy2CTEGX1rAvW+WAAZ8Ojhe6uiP1MjUGeYKiQ1VR/44VBymDUKtoDaAAx2t81yTtzv+Jyd1TMk9hhqnhLNZO5p7G3BOZXHEXa/fL10aa23bgcnsgskQIhgVdrCRUB5KElYywbp+49856lpqYiqTJVgyC9pLqQOcBacF4kOw+d0rPYnFqYxHnJOOgHUH5nMbezYtgcYyMVnthAfXF0OE6hkbkE1ga5ywL9uUiz3t5KvGHQTvz6vklD9OIlg5GauD9e5WG19+0jqmpNATXBtQnbTtpL9r48ZpReRDo97CuqLZxtDcBkCsrbhsMmsmDyUywFpTunh5KwshaxoNdFvLAtBdMQ/UwRWTVkjUqaZsitxAsyo0SOQ8XXYEfadkthZ5df7wjfZbBecc7tE/xiGUlVVgh8NDzX1nvXw=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6E60F37FD54B614FA83C2DD8CB5E9CD2@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d10649d-7b11-4b7e-27a0-08d6d2464637
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2019 17:14:18.9609 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR2PR08MB4873
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.12.103
Subject: Re: [Qemu-devel] [RFC PATCH] tests/qemu-iotests: re-format output
 to for make check-block
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
Cc: Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	"open list:Block layer core" <qemu-block@nongnu.org>,
	Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MDUuMDUuMjAxOSAxODo1NCwgVGhvbWFzIEh1dGggd3JvdGU6DQo+IE9uIDAzLzA1LzIwMTkgMTgu
MTUsIEFsZXggQmVubsOpZSB3cm90ZToNCj4+DQo+PiBUaG9tYXMgSHV0aCA8dGh1dGhAcmVkaGF0
LmNvbT4gd3JpdGVzOg0KPj4NCj4+PiBPbiAwMy8wNS8yMDE5IDE2LjM5LCBBbGV4IEJlbm7DqWUg
d3JvdGU6DQo+Pj4+IFRoaXMgYXR0ZW1wdHMgdG8gY2xlYW4tdXAgdGhlIG91dHB1dCB0byBiZXR0
ZXIgbWF0Y2ggdGhlIG91dHB1dCBvZiB0aGUNCj4+Pj4gcmVzdCBvZiB0aGUgUUVNVSBjaGVjayBz
eXN0ZW0uIFRoaXMgaW5jbHVkZXM6DQo+Pj4+DQo+Pj4+ICAgIC0gZm9ybWF0dGluZyBhcyAiICBU
RVNUICAgIGlvdGVzdDogbm5uIg0KPj4+PiAgICAtIGNhbGN1bGF0aW5nIHRpbWUgZGlmZiBhdCB0
aGUgZW5kDQo+Pj4+ICAgIC0gb25seSBkdW1waW5nIGNvbmZpZyBvbiBmYWlsdXJlDQo+Pj4+DQo+
Pj4+IFNpZ25lZC1vZmYtYnk6IEFsZXggQmVubsOpZSA8YWxleC5iZW5uZWVAbGluYXJvLm9yZz4N
Cj4+Pj4gLS0tDQo+Pj4+ICAgdGVzdHMvcWVtdS1pb3Rlc3RzL2NoZWNrIHwgNzEgKysrKysrKysr
KysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPj4+PiAgIDEgZmlsZSBjaGFuZ2VkLCAz
NCBpbnNlcnRpb25zKCspLCAzNyBkZWxldGlvbnMoLSkNCj4+Pg0KPj4+IFRoYW5rcyBmb3IgdGFj
a2xpbmcgdGhpcyEgVGhlIG91dHB1dCBub3cgbG9va3MgbmljZXIgaW5kZWVkIGlmIHlvdSBydW4N
Cj4+PiAibWFrZSBjaGVjay1xdGVzdCBjaGVjay1ibG9jayAtajgiLiBIb3dldmVyLCBpZiB5b3Ug
YWRkIGEgIlY9MSIgYXQgdGhlDQo+Pj4gZW5kIG9mIHRoZSBjb21tYW5kIGxpbmUsIHRoZSBvdXRw
dXRzIGxvb2sgcXVpdGUgZGlmZmVyZW50IGFnYWluLi4uDQo+Pj4NCj4+PiBUaGF0J3Mgd2h5IEkg
dGhvdWdodCB0aGF0IGhhdmluZyBhIFRBUCBtb2RlIGZvciB0aGUgY2hlY2sgc2NyaXB0IGNvdWxk
DQo+Pj4gYmUgYSBnb29kIGlkZWEsIHRvby4gVGhlbiB3ZSBjb3VsZCBwaXBlIHRoZSBvdXRwdXQg
dGhyb3VnaCB0aGUNCj4+PiB0YXAtZHJpdmVyLnBsIHNjcmlwdCwgdG9vLCBzbyB3ZSBnZXQgdW5p
Zm9ybSBvdXRwdXQgZm9yIGFsbCB0ZXN0cy4uLj8NCj4+DQo+PiBUaGF0IHdvdWxkIHByb2JhYmx5
IGJlIGEgY2xlYW5lciBhcHByb2FjaC4gV2hhdCB3b3VsZCBiZSBldmVuIGJldHRlciBpcw0KPj4g
c29tZWhvdyBleHBhbmRpbmcgdGhlIGxpc3Qgb2YgdGVzdHMgYXQgbWFrZSB0aW1lIHNvIHlvdSBj
b3VsZCBydW4geW91cg0KPj4gdGVzdHMgaW4gcGFyYWxsZWwuDQo+IA0KPiBJIGFncmVlIHRoYXQg
dGhpcyBtaWdodCBiZSB0aGUgdWx0aW1hdGUgc29sdXRpb24gLi4uIGJ1dCBJJ20gbm90IHN1cmUN
Cj4gd2hldGhlciB0aGUgaW90ZXN0cyBhcmUgcmVhbGx5IHJlYWR5IGZvciBiZWluZyBydW4gaW4g
cGFyYWxsZWwgeWV0LCBzbw0KPiBpdCB3aWxsIGxpa2VseSB0YWtlIHF1aXRlIHNvbWUgd2hpbGUg
J3RpbGwgd2UgYXJlIGF0IHRoYXQgcG9pbnQuIFdpdGgNCj4gdGhhdCBpbiBtaW5kIChhbmQgdGh1
cyBhbHNvIG5vdCBzdXJlIHlldCB3aGV0aGVyIG15IFRBUCBpZGVhIGlzIHJlYWxseQ0KPiB0aGUg
cmlnaHQgYXBwcm9hY2gpLCB5b3VyIHBhdGNoIGlzIGNlcnRhaW5seSBhIGdvb2QgaW50ZXJpbSBz
b2x1dGlvbg0KPiB3aGljaCB3ZSBzaG91bGQgdHJ5IHRvIGdldCBtZXJnZWQsIHRvbywgd2hlbiBt
eSAibWFrZSBjaGVjayIgc2VyaWVzIGdldHMNCj4gYWNjZXB0ZWQ/DQo+IA0KPj4gSSBkaWQgd29u
ZGVyIGhvdyB1c2VmdWwgdGhlIHRpbWluZyBzdHVmZiB3YXMgdG8gZGV2ZWxvcGVycy4NCj4gDQo+
IFllcywgbWUgdG9vIC4uLiBtYXliZSB0aGUgYmxvY2sgbGF5ZXIgZm9sa3MgY2FuIGNvbW1lbnQg
b24gdGhhdCBvbmUuLi4/DQo+IA0KPiAgIFRob21hcw0KPiANCg0KSGkhDQoNCkl0IHdhcyB1c2Vm
dWwgdG8gbm90IG1pc3MgcGVyZm9ybWFuY2UgZGVncmFkYXRpb24gKDEpIGFuZA0KdG8gdW5kZXJz
dGFuZCB0aGF0IHRlc3QgaGFuZ3MgKDIpIChpZiB5b3Uga25vdyB0aGF0IGl0IHNob3VsZA0KZmlu
aXNoIGluIDEgc2Vjb25kLCBidXQgMTAgc2Vjb25kcyBhbHJlYWR5IHBhc3NlZCwgdGhlIHRlc3QN
Cm1vc3QgcHJvYmFibHkgaGFuZ3MpDQoNClJ1biB0ZXN0cyB3aXRoIHlvdXIgcGF0Y2g6DQoNCmZp
cnN0IHJ1bjoNCiMgY2hlY2sgLXFjb3cyIC1UDQogICBURVNUICAgIGlvdGVzdDogMDAxIFsyMDow
MDozMF0gLT4gWzIwOjAwOjMxXQ0KICAgVEVTVCAgICBpb3Rlc3Q6IDAwMiBbMjA6MDA6MzFdIC0+
IFsyMDowMDozM10NCiAgIFRFU1QgICAgaW90ZXN0OiAwMDMgWzIwOjAwOjMzXSAtPiBbMjA6MDA6
MzRdDQogICBURVNUICAgIGlvdGVzdDogMDA0IFsyMDowMDozNF0gLT4gWzIwOjAwOjM1XQ0KICAg
VEVTVCAgICBpb3Rlc3Q6IDAwNSBbMjA6MDA6MzVdIC0+IFsyMDowMDozNl0NCiAgIFRFU1QgICAg
aW90ZXN0OiAwMDcgWzIwOjAwOjM2XSAtPiBbMjA6MDA6MzldDQoNCg0Kc2Vjb25kIHJ1bjoNCiMg
Y2hlY2sgLXFjb3cyIC1UDQogICBURVNUICAgIGlvdGVzdDogMDAxIFsyMDowMDo0MV0gLT4gWzIw
OjAwOjQzXSAycyAobGFzdCAxcykNCiAgIFRFU1QgICAgaW90ZXN0OiAwMDIgWzIwOjAwOjQzXSAt
PiBbMjA6MDA6NDRdIDFzIChsYXN0IDJzKQ0KICAgVEVTVCAgICBpb3Rlc3Q6IDAwMyBbMjA6MDA6
NDRdIC0+IFsyMDowMDo0Nl0gMnMgKGxhc3QgMXMpDQogICBURVNUICAgIGlvdGVzdDogMDA0IFsy
MDowMDo0Nl0gLT4gWzIwOjAwOjQ2XSAwcyAobGFzdCAxcykNCiAgIFRFU1QgICAgaW90ZXN0OiAw
MDUgWzIwOjAwOjQ2XSAtPiBbMjA6MDA6NDddIDFzIChsYXN0IDFzKQ0KICAgVEVTVCAgICBpb3Rl
c3Q6IDAwNyBbMjA6MDA6NDddIC0+IFsyMDowMDo1MF0gM3MgKGxhc3QgM3MpDQogICBURVNUICAg
IGlvdGVzdDogMDA4IFsyMDowMDo1MF0gLT4gWzIwOjAwOjUxXQ0KICAgVEVTVCAgICBpb3Rlc3Q6
IDAwOSBbMjA6MDA6NTFdIC0+IFsyMDowMDo1MV0NCiAgIFRFU1QgICAgaW90ZXN0OiAwMTAgWzIw
OjAwOjUxXSAtPiBbMjA6MDA6NTFdDQoNCg0KU28sIGluIGZpcnN0IHJ1biBkZWx0YSB3YXMgbm90
IGNhbGN1bGF0ZWQgYW5kIG9uIHNlY29uZCAtIGNhbGN1bGF0ZWQuDQpDb3VsZCB5b3UgY2FsY3Vs
YXRlIGRlbHRhIGluIGFsbCBjYXNlcywgdG8gbWFrZSBmaXJzdCBydW4gbG9vayBsaWtlDQojIGNo
ZWNrIC1xY293MiAtVA0KICAgVEVTVCAgICBpb3Rlc3Q6IDAwMSBbMjA6MDA6MzBdIC0+IFsyMDow
MDozMV0gMXMNCiAgIFRFU1QgICAgaW90ZXN0OiAwMDIgWzIwOjAwOjMxXSAtPiBbMjA6MDA6MzNd
IDJzDQogICBURVNUICAgIGlvdGVzdDogMDAzIFsyMDowMDozM10gLT4gWzIwOjAwOjM0XSAxcw0K
ICAgVEVTVCAgICBpb3Rlc3Q6IDAwNCBbMjA6MDA6MzRdIC0+IFsyMDowMDozNV0gMXMNCiAgIFRF
U1QgICAgaW90ZXN0OiAwMDUgWzIwOjAwOjM1XSAtPiBbMjA6MDA6MzZdIDFzDQogICBURVNUICAg
IGlvdGVzdDogMDA3IFsyMDowMDozNl0gLT4gWzIwOjAwOjM5XSAzcw0KDQoNCi0tIA0KQmVzdCBy
ZWdhcmRzLA0KVmxhZGltaXINCg==

