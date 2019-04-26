Return-Path: <SRS0=QtPl=S4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 956EBC43219
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 15:56:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3EE212077B
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 15:56:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="e88NKEvC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EE212077B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48716 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hK3DN-0005D7-4g
	for qemu-devel@archiver.kernel.org; Fri, 26 Apr 2019 11:56:41 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41963)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Janakarajan.Natarajan@amd.com>) id 1hK1uJ-0000jM-FX
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 10:32:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Janakarajan.Natarajan@amd.com>) id 1hK1uI-0005Pz-3w
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 10:32:55 -0400
Received: from mail-eopbgr800059.outbound.protection.outlook.com
	([40.107.80.59]:38737
	helo=NAM03-DM3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Janakarajan.Natarajan@amd.com>)
	id 1hK1uH-0005Pj-S5
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 10:32:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=5xpcuoJJY9AdzMl5tJGi3l4R9m+Yxzm+TIri48WiaSs=;
	b=e88NKEvC1yMOoffP7VwQ57hL0qlWciJ7IY+dBdwyIOUrbeAhtvNptnf6I+CggAOr684ZyY4PLMtF3aqbSofItPRaMIprd5npGmLu/mip4dd2IqVHb00MwRo6dLbBdU8FFBjhnQppVC5RxTMDCtycfVPJKjihDvENgW9p7/HJJx0=
Received: from SN6PR12MB2736.namprd12.prod.outlook.com (52.135.107.27) by
	SN6PR12MB2816.namprd12.prod.outlook.com (52.135.107.153) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1835.12; Fri, 26 Apr 2019 14:32:51 +0000
Received: from SN6PR12MB2736.namprd12.prod.outlook.com
	([fe80::65cb:af55:6bd4:55a]) by SN6PR12MB2736.namprd12.prod.outlook.com
	([fe80::65cb:af55:6bd4:55a%4]) with mapi id 15.20.1835.010;
	Fri, 26 Apr 2019 14:32:51 +0000
From: Janakarajan Natarajan <jnataraj@amd.com>
To: Igor Mammedov <imammedo@redhat.com>, "Natarajan, Janakarajan"
	<Janakarajan.Natarajan@amd.com>
Thread-Topic: [PATCH 1/3] ram-encrypted-notifier: Introduce a RAM block
	encrypted notifier
Thread-Index: AQHU+7pfUbGsMaOONk2PjUweDqC9XqZOX9QAgAAij4A=
Date: Fri, 26 Apr 2019 14:32:51 +0000
Message-ID: <3d272b2b-67ba-de54-9683-d3361ecbe276@amd.com>
References: <20190425225610.28350-1-Janakarajan.Natarajan@amd.com>
	<20190425225610.28350-2-Janakarajan.Natarajan@amd.com>
	<20190426142908.5d63d530@Igors-MacBook-Pro.local>
In-Reply-To: <20190426142908.5d63d530@Igors-MacBook-Pro.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN4PR0201CA0061.namprd02.prod.outlook.com
	(2603:10b6:803:20::23) To SN6PR12MB2736.namprd12.prod.outlook.com
	(2603:10b6:805:77::27)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=Janakarajan.Natarajan@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.77.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6345bf12-5b1f-4359-a8f2-08d6ca540fa7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);
	SRVR:SN6PR12MB2816; 
x-ms-traffictypediagnostic: SN6PR12MB2816:
x-microsoft-antispam-prvs: <SN6PR12MB28165E86F9EF880C96F345DBE73E0@SN6PR12MB2816.namprd12.prod.outlook.com>
x-forefront-prvs: 001968DD50
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10009020)(376002)(39860400002)(366004)(396003)(346002)(136003)(189003)(199004)(6486002)(97736004)(6246003)(25786009)(2906002)(11346002)(5660300002)(2616005)(7736002)(4326008)(71190400001)(6512007)(6436002)(36756003)(186003)(305945005)(14444005)(71200400001)(26005)(53936002)(256004)(229853002)(66066001)(53546011)(110136005)(6636002)(102836004)(478600001)(6506007)(386003)(14454004)(76176011)(31696002)(72206003)(54906003)(68736007)(316002)(8936002)(8676002)(81156014)(81166006)(66946007)(446003)(6116002)(476003)(52116002)(31686004)(3846002)(66476007)(64756008)(66446008)(66556008)(73956011)(486006)(99286004);
	DIR:OUT; SFP:1101; SCL:1; SRVR:SN6PR12MB2816;
	H:SN6PR12MB2736.namprd12.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: jMQRbuGlXcwy+dDqxE2dwxMoRFiObmhSj1K+qMMhfwf/19FIHu1pe3rHF8O1uu3uLOHzuwYgHWu9c+2RecXkdBtkJuSYjzA7gcwHw0iWtIgsStyz81ROLnfTZrzNKjaYukMK5otK7xcB8zdfUwvRJIrUL0ru/nAsYOoK7++I2wZdfI0PkdILGFfFOH0385dtnXQDhDQr08KAlOphROlB9IZAKnX5QB58nppeyqvBcaYHtxW6MistAGIhE6RF23Qe6RbX8hyyp86NgtNoPjSjb+cXCeebs8K+jtduDFMDB0IRXA25yoUm1n9TGark1wj9+ulMInRDVf20lPnP90ggpKyVxBSf+OTC4sM5BbiZDBEtnG2zTslDlfddbUIciv/hiQ9Sg5+F+5SI4Gs6XmO4Vao+QdfFP4xOoJA4H7BcErs=
Content-Type: text/plain; charset="UTF-8"
Content-ID: <8F716271BEA6D6438F16D90982F4C431@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6345bf12-5b1f-4359-a8f2-08d6ca540fa7
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2019 14:32:51.3577 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2816
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.80.59
X-Mailman-Approved-At: Fri, 26 Apr 2019 11:55:52 -0400
Subject: Re: [Qemu-devel] [PATCH 1/3] ram-encrypted-notifier: Introduce a
 RAM block encrypted notifier
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
Cc: "Singh, Brijesh" <brijesh.singh@amd.com>,
	Eduardo Habkost <ehabkost@redhat.com>,
	"Michael S . Tsirkin" <mst@redhat.com>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190426143251.l2TGXaJE-eCOqHbg7IDOaCOQbt1105MHX2Cjs1Pny58@z>

T24gNC8yNi8xOSA3OjI5IEFNLCBJZ29yIE1hbW1lZG92IHdyb3RlOg0KPiBPbiBUaHUsIDI1IEFw
ciAyMDE5IDIyOjU4OjE4ICswMDAwDQo+ICJOYXRhcmFqYW4sIEphbmFrYXJhamFuIiA8SmFuYWth
cmFqYW4uTmF0YXJhamFuQGFtZC5jb20+IHdyb3RlOg0KPg0KPj4gQSBjbGllbnQgY2FuIHJlZ2lz
dGVyIHRvIHRoaXMgbm90aWZpZXIgdG8ga25vdyB3aGV0aGVyIHRoZSBuZXdseSBhZGRlZCBvcg0K
Pj4gcmVtb3ZlZCBtZW1vcnkgcmVnaW9uIGlzIG1hcmtlZCBhcyBlbmNyeXB0ZWQuIFRoaXMgaW5m
b3JtYXRpb24gaXMgbmVlZGVkDQo+PiBmb3IgdGhlIFNFViBndWVzdCBsYXVuY2guIEluIFNFViBn
dWVzdCwgc29tZSBtZW1vcnkgcmVnaW9ucyBtYXkgY29udGFpbg0KPj4gZW5jcnlwdGVkIGRhdGEg
KGUuZyBndWVzdCBSQU0pLiBUaGUgbWVtb3J5IHJlZ2lvbiB3aGljaCBjb250YWlucyB0aGUNCj4+
IGVuY3J5cHRlZCBkYXRhIHNob3VsZCBiZSByZWdpc3RlcmVkL3VucmVnaXN0ZXJlZCB1c2luZyB0
aGUNCj4+IEtWTV9NRU1PUllfe1JFRyxVTlJFR31fRU5DUllQVEVEIGlvY3RsLg0KPj4NCj4+IFNp
Z25lZC1vZmYtYnk6IEphbmFrYXJhamFuIE5hdGFyYWphbiA8SmFuYWthcmFqYW4uTmF0YXJhamFu
QGFtZC5jb20+DQo+PiAtLS0NCj4+ICAgZXhlYy5jICAgICAgICAgICAgICAgICB8ICAxICsNCj4+
ICAgaW5jbHVkZS9leGVjL21lbW9yeS5oICB8IDE4ICsrKysrKysrKysrKysrKysrKw0KPj4gICBp
bmNsdWRlL2V4ZWMvcmFtbGlzdC5oIHwgMTkgKysrKysrKysrKysrKysrKysrKw0KPj4gICBtZW1v
cnkuYyAgICAgICAgICAgICAgIHwgMTYgKysrKysrKysrKysrKysrKw0KPj4gICBudW1hLmMgICAg
ICAgICAgICAgICAgIHwgMzMgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+PiAg
IHN0dWJzL3JhbS1ibG9jay5jICAgICAgfCAgOCArKysrKysrKw0KPj4gICA2IGZpbGVzIGNoYW5n
ZWQsIDk1IGluc2VydGlvbnMoKykNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvZXhlYy5jIGIvZXhlYy5j
DQo+PiBpbmRleCAyNjQ2MjA3NjYxLi5hMDJjMzk0ZTQ4IDEwMDY0NA0KPj4gLS0tIGEvZXhlYy5j
DQo+PiArKysgYi9leGVjLmMNCj4+IEBAIC03OSw2ICs3OSw3IEBADQo+PiAgICAqIGFyZSBwcm90
ZWN0ZWQgYnkgdGhlIHJhbWxpc3QgbG9jay4NCj4+ICAgICovDQo+PiAgIFJBTUxpc3QgcmFtX2xp
c3QgPSB7IC5ibG9ja3MgPSBRTElTVF9IRUFEX0lOSVRJQUxJWkVSKHJhbV9saXN0LmJsb2Nrcykg
fTsNCj4+ICtSQU1CbG9ja0VuY3J5cHRlZE5vdGlmaWVyTGlzdCByYW1fYmxvY2tfZW5jcnlwdGVk
X25vdGlmaWVyX2xpc3Q7DQo+PiAgIA0KPj4gICBzdGF0aWMgTWVtb3J5UmVnaW9uICpzeXN0ZW1f
bWVtb3J5Ow0KPj4gICBzdGF0aWMgTWVtb3J5UmVnaW9uICpzeXN0ZW1faW87DQo+PiBkaWZmIC0t
Z2l0IGEvaW5jbHVkZS9leGVjL21lbW9yeS5oIGIvaW5jbHVkZS9leGVjL21lbW9yeS5oDQo+PiBp
bmRleCA5MTQ0YTQ3ZjU3Li5hZTcyMGZmNTExIDEwMDY0NA0KPj4gLS0tIGEvaW5jbHVkZS9leGVj
L21lbW9yeS5oDQo+PiArKysgYi9pbmNsdWRlL2V4ZWMvbWVtb3J5LmgNCj4+IEBAIC0zNzQsNiAr
Mzc0LDcgQEAgc3RydWN0IE1lbW9yeVJlZ2lvbiB7DQo+PiAgICAgICBib29sIHRlcm1pbmF0ZXM7
DQo+PiAgICAgICBib29sIHJhbV9kZXZpY2U7DQo+PiAgICAgICBib29sIGVuYWJsZWQ7DQo+PiAr
ICAgIGJvb2wgZW5jcnlwdGVkOw0KPj4gICAgICAgYm9vbCB3YXJuaW5nX3ByaW50ZWQ7IC8qIEZv
ciByZXNlcnZhdGlvbnMgKi8NCj4+ICAgICAgIHVpbnQ4X3QgdmdhX2xvZ2dpbmdfY291bnQ7DQo+
PiAgICAgICBNZW1vcnlSZWdpb24gKmFsaWFzOw0KPj4gQEAgLTExMzEsNiArMTEzMiwyMyBAQCBp
bnQgbWVtb3J5X3JlZ2lvbl9pb21tdV9hdHRyc190b19pbmRleChJT01NVU1lbW9yeVJlZ2lvbiAq
aW9tbXVfbXIsDQo+PiAgICAqLw0KPj4gICBpbnQgbWVtb3J5X3JlZ2lvbl9pb21tdV9udW1faW5k
ZXhlcyhJT01NVU1lbW9yeVJlZ2lvbiAqaW9tbXVfbXIpOw0KPj4gICANCj4+ICsvKioNCj4+ICsg
KiBtZW1vcnlfcmVnaW9uX21hcmtfZW5jcnlwdGVkOiBtYXJrcyB0aGUgbWVtb3J5IHJlZ2lvbiBh
cyBlbmNyeXB0ZWQgYW5kDQo+PiArICogbGV0cyB0aGUgbGlzdGVuZXJzIG9mIGVuY3J5cHRlZCBy
YW0ga25vdyB0aGF0IGEgbWVtb3J5IHJlZ2lvbiBjb250YWluaW5nDQo+PiArICogZW5jcnlwdGVk
IHJhbSBibG9jayBoYXMgYmVlbiBhZGRlZA0KPj4gKyAqDQo+PiArICogQG1yOiB0aGUgbWVtb3J5
IHJlZ2lvbg0KPj4gKyAqLw0KPj4gK3ZvaWQgbWVtb3J5X3JlZ2lvbl9tYXJrX2VuY3J5cHRlZChN
ZW1vcnlSZWdpb24gKm1yKTsNCj4+ICsNCj4+ICsvKioNCj4+ICsgKiBtZW1vcnlfcmVnaW9uX2lz
X2VuY3J5cHRlZDogcmV0dXJucyBpZiB0aGUgbWVtb3J5IHJlZ2lvbiB3YXMgbWFya2VkIGFzDQo+
PiArICogZW5jcnlwdGVkIHdoZW4gaXQgd2FzIGNyZWF0ZWQNCj4+ICsgKg0KPj4gKyAqIEBtcjog
dGhlIG1lbW9yeSByZWdpb24NCj4+ICsgKi8NCj4+ICtib29sIG1lbW9yeV9yZWdpb25faXNfZW5j
cnlwdGVkKE1lbW9yeVJlZ2lvbiAqbXIpOw0KPj4gKw0KPj4gICAvKioNCj4+ICAgICogbWVtb3J5
X3JlZ2lvbl9uYW1lOiBnZXQgYSBtZW1vcnkgcmVnaW9uJ3MgbmFtZQ0KPj4gICAgKg0KPj4gZGlm
ZiAtLWdpdCBhL2luY2x1ZGUvZXhlYy9yYW1saXN0LmggYi9pbmNsdWRlL2V4ZWMvcmFtbGlzdC5o
DQo+PiBpbmRleCBiYzRmYWExYjAwLi41MzQ5ZjI3ZmE1IDEwMDY0NA0KPj4gLS0tIGEvaW5jbHVk
ZS9leGVjL3JhbWxpc3QuaA0KPj4gKysrIGIvaW5jbHVkZS9leGVjL3JhbWxpc3QuaA0KPj4gQEAg
LTcsNiArNyw3IEBADQo+PiAgICNpbmNsdWRlICJxZW11L3JjdV9xdWV1ZS5oIg0KPj4gICANCj4+
ICAgdHlwZWRlZiBzdHJ1Y3QgUkFNQmxvY2tOb3RpZmllciBSQU1CbG9ja05vdGlmaWVyOw0KPj4g
K3R5cGVkZWYgc3RydWN0IFJBTUJsb2NrRW5jcnlwdGVkTm90aWZpZXIgUkFNQmxvY2tFbmNyeXB0
ZWROb3RpZmllcjsNCj4+ICAgDQo+PiAgICNkZWZpbmUgRElSVFlfTUVNT1JZX1ZHQSAgICAgICAw
DQo+PiAgICNkZWZpbmUgRElSVFlfTUVNT1JZX0NPREUgICAgICAxDQo+PiBAQCAtNTUsNiArNTYs
MTEgQEAgdHlwZWRlZiBzdHJ1Y3QgUkFNTGlzdCB7DQo+PiAgIH0gUkFNTGlzdDsNCj4+ICAgZXh0
ZXJuIFJBTUxpc3QgcmFtX2xpc3Q7DQo+PiAgIA0KPj4gK3R5cGVkZWYgc3RydWN0IFJBTUJsb2Nr
RW5jcnlwdGVkTm90aWZpZXJMaXN0IHsNCj4+ICsgICAgUUxJU1RfSEVBRCgsIFJBTUJsb2NrRW5j
cnlwdGVkTm90aWZpZXIpIHJhbV9ibG9ja19ub3RpZmllcnM7DQo+PiArfSBSQU1CbG9ja0VuY3J5
cHRlZE5vdGlmaWVyTGlzdDsNCj4+ICtleHRlcm4gUkFNQmxvY2tFbmNyeXB0ZWROb3RpZmllckxp
c3QgcmFtX2Jsb2NrX2VuY3J5cHRlZF9ub3RpZmllcl9saXN0Ow0KPj4gKw0KPj4gICAvKiBTaG91
bGQgYmUgaG9sZGluZyBlaXRoZXIgcmFtX2xpc3QubXV0ZXgsIG9yIHRoZSBSQ1UgbG9jay4gKi8N
Cj4+ICAgI2RlZmluZSAgSU5URVJOQUxfUkFNQkxPQ0tfRk9SRUFDSChibG9jaykgIFwNCj4+ICAg
ICAgIFFMSVNUX0ZPUkVBQ0hfUkNVKGJsb2NrLCAmcmFtX2xpc3QuYmxvY2tzLCBuZXh0KQ0KPj4g
QEAgLTcwLDYgKzc2LDE0IEBAIHN0cnVjdCBSQU1CbG9ja05vdGlmaWVyIHsNCj4+ICAgICAgIFFM
SVNUX0VOVFJZKFJBTUJsb2NrTm90aWZpZXIpIG5leHQ7DQo+PiAgIH07DQo+PiAgIA0KPj4gK3N0
cnVjdCBSQU1CbG9ja0VuY3J5cHRlZE5vdGlmaWVyIHsNCj4+ICsgICAgdm9pZCAoKnJhbV9ibG9j
a19lbmNyeXB0ZWRfYWRkZWQpKFJBTUJsb2NrRW5jcnlwdGVkTm90aWZpZXIgKm4sDQo+PiArICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB2b2lkICpob3N0LCBzaXplX3Qgc2l6
ZSk7DQo+PiArICAgIHZvaWQgKCpyYW1fYmxvY2tfZW5jcnlwdGVkX3JlbW92ZWQpKFJBTUJsb2Nr
RW5jcnlwdGVkTm90aWZpZXIgKm4sDQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIHZvaWQgKmhvc3QsIHNpemVfdCBzaXplKTsNCj4+ICsgICAgUUxJU1RfRU5UUlko
UkFNQmxvY2tFbmNyeXB0ZWROb3RpZmllcikgbmV4dDsNCj4+ICt9Ow0KPj4gKw0KPj4gICB2b2lk
IHJhbV9ibG9ja19ub3RpZmllcl9hZGQoUkFNQmxvY2tOb3RpZmllciAqbik7DQo+PiAgIHZvaWQg
cmFtX2Jsb2NrX25vdGlmaWVyX3JlbW92ZShSQU1CbG9ja05vdGlmaWVyICpuKTsNCj4+ICAgdm9p
ZCByYW1fYmxvY2tfbm90aWZ5X2FkZCh2b2lkICpob3N0LCBzaXplX3Qgc2l6ZSk7DQo+PiBAQCAt
NzcsNCArOTEsOSBAQCB2b2lkIHJhbV9ibG9ja19ub3RpZnlfcmVtb3ZlKHZvaWQgKmhvc3QsIHNp
emVfdCBzaXplKTsNCj4+ICAgDQo+PiAgIHZvaWQgcmFtX2Jsb2NrX2R1bXAoTW9uaXRvciAqbW9u
KTsNCj4+ICAgDQo+PiArdm9pZCByYW1fYmxvY2tfZW5jcnlwdGVkX25vdGlmaWVyX2FkZChSQU1C
bG9ja0VuY3J5cHRlZE5vdGlmaWVyICpuKTsNCj4+ICt2b2lkIHJhbV9ibG9ja19lbmNyeXB0ZWRf
bm90aWZpZXJfcmVtb3ZlKFJBTUJsb2NrRW5jcnlwdGVkTm90aWZpZXIgKm4pOw0KPj4gK3ZvaWQg
cmFtX2Jsb2NrX2VuY3J5cHRlZF9ub3RpZnlfYWRkKHZvaWQgKmhvc3QsIHNpemVfdCBzaXplKTsN
Cj4+ICt2b2lkIHJhbV9ibG9ja19lbmNyeXB0ZWRfbm90aWZ5X3JlbW92ZSh2b2lkICpob3N0LCBz
aXplX3Qgc2l6ZSk7DQo+PiArDQo+PiAgICNlbmRpZiAvKiBSQU1MSVNUX0ggKi8NCj4+IGRpZmYg
LS1naXQgYS9tZW1vcnkuYyBiL21lbW9yeS5jDQo+PiBpbmRleCBiYjJiNzFlZTM4Li5lY2EwMmQz
NjliIDEwMDY0NA0KPj4gLS0tIGEvbWVtb3J5LmMNCj4+ICsrKyBiL21lbW9yeS5jDQo+PiBAQCAt
MjAwOSw2ICsyMDA5LDIyIEBAIGludCBtZW1vcnlfcmVnaW9uX2lvbW11X251bV9pbmRleGVzKElP
TU1VTWVtb3J5UmVnaW9uICppb21tdV9tcikNCj4+ICAgICAgIHJldHVybiBpbXJjLT5udW1faW5k
ZXhlcyhpb21tdV9tcik7DQo+PiAgIH0NCj4+ICAgDQo+PiArdm9pZCBtZW1vcnlfcmVnaW9uX21h
cmtfZW5jcnlwdGVkKE1lbW9yeVJlZ2lvbiAqbXIpDQo+PiArew0KPj4gKyAgICBSQU1CbG9jayAq
YmxvY2sgPSBtci0+cmFtX2Jsb2NrOw0KPj4gKw0KPj4gKyAgICBtci0+ZW5jcnlwdGVkID0ga3Zt
X21lbWNyeXB0X2VuYWJsZWQoKTsNCj4+ICsNCj4+ICsgICAgaWYgKG1yLT5lbmNyeXB0ZWQpIHsN
Cj4+ICsgICAgICAgIHJhbV9ibG9ja19lbmNyeXB0ZWRfbm90aWZ5X2FkZChibG9jay0+aG9zdCwg
YmxvY2stPm1heF9sZW5ndGgpOw0KPj4gKyAgICB9DQo+PiArfQ0KPj4gKw0KPj4gK2Jvb2wgbWVt
b3J5X3JlZ2lvbl9pc19lbmNyeXB0ZWQoTWVtb3J5UmVnaW9uICptcikNCj4+ICt7DQo+PiArICAg
IHJldHVybiBtci0+ZW5jcnlwdGVkOw0KPj4gK30NCj4+ICsNCj4+ICAgdm9pZCBtZW1vcnlfcmVn
aW9uX3NldF9sb2coTWVtb3J5UmVnaW9uICptciwgYm9vbCBsb2csIHVuc2lnbmVkIGNsaWVudCkN
Cj4+ICAgew0KPj4gICAgICAgdWludDhfdCBtYXNrID0gMSA8PCBjbGllbnQ7DQo+PiBkaWZmIC0t
Z2l0IGEvbnVtYS5jIGIvbnVtYS5jDQo+PiBpbmRleCAzODc1ZTFlZmRhLi4wODYwMTM2NmM1IDEw
MDY0NA0KPj4gLS0tIGEvbnVtYS5jDQo+PiArKysgYi9udW1hLmMNCj4gbG9va3MgbGlrZSB3cm9u
ZyBmaWxlIHRvIHB1dCBSQU1CbG9jayBjb2RlIGluLiBJIHRob3VnaCB0aGF0IHdlIHNob3VsZCBw
dXQgaXQgaW4gZXhlYy5jDQoNCg0KSSBwbGFjZWQgdGhlIFJBTUJsb2NrRW5jcnlwdGVkIE5vdGlm
aWVyIGNvZGUgYWxvbmcgd2l0aCB0aGUgUkFNQmxvY2sgDQpOb3RpZmllciBjb2RlLg0KDQoNCj4N
Cj4+IEBAIC02MzgsNiArNjM4LDM5IEBAIE1lbWRldkxpc3QgKnFtcF9xdWVyeV9tZW1kZXYoRXJy
b3IgKiplcnJwKQ0KPj4gICAgICAgcmV0dXJuIGxpc3Q7DQo+PiAgIH0NCj4+ICAgDQo+PiArdm9p
ZCByYW1fYmxvY2tfZW5jcnlwdGVkX25vdGlmaWVyX2FkZChSQU1CbG9ja0VuY3J5cHRlZE5vdGlm
aWVyICpuKQ0KPj4gK3sNCj4+ICsgICAgUUxJU1RfSU5TRVJUX0hFQUQoJnJhbV9ibG9ja19lbmNy
eXB0ZWRfbm90aWZpZXJfbGlzdC5yYW1fYmxvY2tfbm90aWZpZXJzLA0KPj4gKyAgICAgICAgICAg
ICAgICAgICAgICBuLCBuZXh0KTsNCj4+ICt9DQo+PiArDQo+PiArdm9pZCByYW1fYmxvY2tfZW5j
cnlwdGVkX25vdGlmaWVyX3JlbW92ZShSQU1CbG9ja0VuY3J5cHRlZE5vdGlmaWVyICpuKQ0KPj4g
K3sNCj4+ICsgICAgUUxJU1RfUkVNT1ZFKG4sIG5leHQpOw0KPj4gK30NCj4+ICsNCj4+ICt2b2lk
IHJhbV9ibG9ja19lbmNyeXB0ZWRfbm90aWZ5X2FkZCh2b2lkICpob3N0LCBzaXplX3Qgc2l6ZSkN
Cj4+ICt7DQo+PiArICAgIFJBTUJsb2NrRW5jcnlwdGVkTm90aWZpZXIgKm5vdGlmaWVyOw0KPj4g
Kw0KPj4gKyAgICBRTElTVF9GT1JFQUNIKG5vdGlmaWVyLA0KPj4gKyAgICAgICAgICAgICAgICAg
ICZyYW1fYmxvY2tfZW5jcnlwdGVkX25vdGlmaWVyX2xpc3QucmFtX2Jsb2NrX25vdGlmaWVycywN
Cj4+ICsgICAgICAgICAgICAgICAgICBuZXh0KSB7DQo+PiArICAgICAgICBub3RpZmllci0+cmFt
X2Jsb2NrX2VuY3J5cHRlZF9hZGRlZChub3RpZmllciwgaG9zdCwgc2l6ZSk7DQo+PiArICAgIH0N
Cj4+ICt9DQo+PiArDQo+PiArdm9pZCByYW1fYmxvY2tfZW5jcnlwdGVkX25vdGlmeV9yZW1vdmUo
dm9pZCAqaG9zdCwgc2l6ZV90IHNpemUpDQo+PiArew0KPj4gKyAgICBSQU1CbG9ja0VuY3J5cHRl
ZE5vdGlmaWVyICpub3RpZmllcjsNCj4+ICsNCj4+ICsgICAgUUxJU1RfRk9SRUFDSChub3RpZmll
ciwNCj4+ICsgICAgICAgICAgICAgICAgICAmcmFtX2Jsb2NrX2VuY3J5cHRlZF9ub3RpZmllcl9s
aXN0LnJhbV9ibG9ja19ub3RpZmllcnMsDQo+PiArICAgICAgICAgICAgICAgICAgbmV4dCkgew0K
Pj4gKyAgICAgICAgbm90aWZpZXItPnJhbV9ibG9ja19lbmNyeXB0ZWRfcmVtb3ZlZChub3RpZmll
ciwgaG9zdCwgc2l6ZSk7DQo+PiArICAgIH0NCj4+ICt9DQo+PiArDQo+PiAgIHZvaWQgcmFtX2Js
b2NrX25vdGlmaWVyX2FkZChSQU1CbG9ja05vdGlmaWVyICpuKQ0KPj4gICB7DQo+PiAgICAgICBR
TElTVF9JTlNFUlRfSEVBRCgmcmFtX2xpc3QucmFtYmxvY2tfbm90aWZpZXJzLCBuLCBuZXh0KTsN
Cj4+IGRpZmYgLS1naXQgYS9zdHVicy9yYW0tYmxvY2suYyBiL3N0dWJzL3JhbS1ibG9jay5jDQo+
PiBpbmRleCA3M2MwYTNlZTA4Li4wZjY4OTIyZmViIDEwMDY0NA0KPj4gLS0tIGEvc3R1YnMvcmFt
LWJsb2NrLmMNCj4+ICsrKyBiL3N0dWJzL3JhbS1ibG9jay5jDQo+PiBAQCAtMjUsNiArMjUsMTQg
QEAgdm9pZCByYW1fYmxvY2tfbm90aWZpZXJfcmVtb3ZlKFJBTUJsb2NrTm90aWZpZXIgKm4pDQo+
PiAgIHsNCj4+ICAgfQ0KPj4gICANCj4+ICt2b2lkIHJhbV9ibG9ja19lbmNyeXB0ZWRfbm90aWZp
ZXJfYWRkKFJBTUJsb2NrRW5jcnlwdGVkTm90aWZpZXIgKm4pDQo+PiArew0KPj4gK30NCj4+ICsN
Cj4+ICt2b2lkIHJhbV9ibG9ja19lbmNyeXB0ZWRfbm90aWZpZXJfcmVtb3ZlKFJBTUJsb2NrRW5j
cnlwdGVkTm90aWZpZXIgKm4pDQo+PiArew0KPj4gK30NCj4+ICsNCj4+ICAgaW50IHFlbXVfcmFt
X2ZvcmVhY2hfYmxvY2soUkFNQmxvY2tJdGVyRnVuYyBmdW5jLCB2b2lkICpvcGFxdWUpDQo+PiAg
IHsNCj4+ICAgICAgIHJldHVybiAwOw0K

