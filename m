Return-Path: <SRS0=3XOk=S2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5D19C10F11
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 16:17:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BFD5208E4
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 16:17:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="XxHnV3ho"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BFD5208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44104 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJKao-00017Y-SP
	for qemu-devel@archiver.kernel.org; Wed, 24 Apr 2019 12:17:54 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38833)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1hJKTx-0002Ph-2t
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 12:10:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1hJKTo-0004Fg-7A
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 12:10:48 -0400
Received: from mail-eopbgr780088.outbound.protection.outlook.com
	([40.107.78.88]:16416
	helo=NAM03-BY2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <brijesh.singh@amd.com>)
	id 1hJKTn-0003kU-Ug
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 12:10:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=0AbNq/2n+Ph+bp0Xi0fv/gXV+7tZjbjPocmRBDJnA0k=;
	b=XxHnV3hop+C1iMCz08tQxyGPcMkbe5fNPRpfCUsLdpU8kVsereABxngEwGYvFCS+/GVfqeIVecn0r0gQt345IALu6w33xC8JryjNSezOcBhblc0hPWscAlQUBkFKbgPOBJNmsGEp1W9KatnpNpiz6p6WiFMGmMLBjS3+xJgtVic=
Received: from DM6PR12MB2682.namprd12.prod.outlook.com (20.176.116.31) by
	DM6PR12MB2907.namprd12.prod.outlook.com (20.179.71.213) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1835.12; Wed, 24 Apr 2019 16:10:09 +0000
Received: from DM6PR12MB2682.namprd12.prod.outlook.com
	([fe80::9183:846f:a93e:9a43]) by
	DM6PR12MB2682.namprd12.prod.outlook.com
	([fe80::9183:846f:a93e:9a43%5]) with mapi id 15.20.1813.017;
	Wed, 24 Apr 2019 16:10:09 +0000
From: "Singh, Brijesh" <brijesh.singh@amd.com>
To: "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Thread-Topic: [RFC PATCH v1 08/10] KVM: X86: Introduce KVM_HC_PAGE_ENC_STATUS
	hypercall
Thread-Index: AQHU+rgwAA7BoThJdki7pfNbyU+1kA==
Date: Wed, 24 Apr 2019 16:10:09 +0000
Message-ID: <20190424160942.13567-9-brijesh.singh@amd.com>
References: <20190424160942.13567-1-brijesh.singh@amd.com>
In-Reply-To: <20190424160942.13567-1-brijesh.singh@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN4PR0601CA0019.namprd06.prod.outlook.com
	(2603:10b6:803:2f::29) To DM6PR12MB2682.namprd12.prod.outlook.com
	(2603:10b6:5:4a::31)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=brijesh.singh@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [165.204.77.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: de0128d5-3b93-4651-c0e3-08d6c8cf52a2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);
	SRVR:DM6PR12MB2907; 
x-ms-traffictypediagnostic: DM6PR12MB2907:
x-microsoft-antispam-prvs: <DM6PR12MB29073A6D79CCB0F1AFEEB8C0E53C0@DM6PR12MB2907.namprd12.prod.outlook.com>
x-forefront-prvs: 00179089FD
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10009020)(39860400002)(136003)(366004)(396003)(376002)(346002)(189003)(199004)(1730700003)(99286004)(2501003)(73956011)(478600001)(11346002)(6506007)(76176011)(14454004)(6116002)(52116002)(386003)(476003)(25786009)(66946007)(486006)(4326008)(71200400001)(66446008)(66556008)(3846002)(66476007)(64756008)(1076003)(66574012)(71190400001)(446003)(186003)(2616005)(5660300002)(2351001)(102836004)(97736004)(26005)(14444005)(86362001)(6512007)(8676002)(66066001)(8936002)(68736007)(2906002)(50226002)(256004)(81156014)(305945005)(36756003)(316002)(6436002)(54906003)(7736002)(5640700003)(81166006)(53936002)(6916009)(6486002)(7416002);
	DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB2907;
	H:DM6PR12MB2682.namprd12.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: fJTdd4IHeFHM2AqxpEKGIBhAm5Uc+3nvGTWUyin0RYyBplEUAe7iLKDFcB2rPjAhkZC2p4rsPZ373uQ9qsGLmLvnaF/sgo9fI1rC8D6lwZW6gwSooIcNvcxxU4cZ4jK6HZLYSMNRdNOiARZfnrwLNl0X1qkbgSKOFJa+N3mc1xe5/zxuGmtPq7RkjHbGkYTseHc8BVXEWgiXVYe9wZN92uM5aaBJQZ2GCaJ1o1PS+2B/jQ/sciaN2l062x6tNWhCntnS1utjoZtxo+0BFZHLVbsX+PLwYACfLL+j7QD+0TNSr4AmXSaygIeY74nuj2MEv6ndHpOnUoZqHuO7NKxi/faKi5dJSG2U2UddStxhngd4joDSSATW22nLYVYj1EmzyzDnoSYeonQYqRrC9XfU4woqsg/2M8N7ha8t4R5dJ54=
Content-Type: text/plain; charset="UTF-8"
Content-ID: <6B8DECB3663B0344BE95803E07CBE394@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de0128d5-3b93-4651-c0e3-08d6c8cf52a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2019 16:10:09.2789 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2907
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.78.88
Subject: [Qemu-devel] [RFC PATCH v1 08/10] KVM: X86: Introduce
 KVM_HC_PAGE_ENC_STATUS hypercall
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
Cc: "Lendacky, Thomas" <Thomas.Lendacky@amd.com>, "Singh,
	Brijesh" <brijesh.singh@amd.com>,
	=?utf-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
	Joerg Roedel <joro@8bytes.org>, "x86@kernel.org" <x86@kernel.org>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
	Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@suse.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190424161009.JkhcXu2QlDS4P8ox8H_aZ51rcgnJo85c8cr9xBrOeFw@z>

VGhlIGh5cGVyY2FsbCBjYW4gYmUgdXNlZCBieSB0aGUgU0VWIGd1ZXN0IHRvIG5vdGlmeSB0aGUg
cGFnZSBlbmNyeXB0aW9uDQpzdGF0dXMgdG8gdGhlIGh5cGVydmlzb3IuIFRoZSBoeXBlcmNhbGwg
c2hvdWxkIGJlIGludm9rZWQgb25seSB3aGVuDQp0aGUgZW5jcnlwdGlvbiBhdHRyaWJ1dGUgaXMg
Y2hhbmdlZCBmcm9tIGVuY3J5cHRlZCAtPiBkZWNyeXB0ZWQgYW5kIHZpY2UNCnZlcnNhLiBCeSBk
ZWZhdWx0IGFsbCB0aGUgZ3Vlc3QgcGFnZXMgc2hvdWxkIGJlIGNvbnNpZGVyZWQgZW5jcnlwdGVk
Lg0KDQpDYzogVGhvbWFzIEdsZWl4bmVyIDx0Z2x4QGxpbnV0cm9uaXguZGU+DQpDYzogSW5nbyBN
b2xuYXIgPG1pbmdvQHJlZGhhdC5jb20+DQpDYzogIkguIFBldGVyIEFudmluIiA8aHBhQHp5dG9y
LmNvbT4NCkNjOiBQYW9sbyBCb256aW5pIDxwYm9uemluaUByZWRoYXQuY29tPg0KQ2M6ICJSYWRp
bSBLcsSNbcOhxZkiIDxya3JjbWFyQHJlZGhhdC5jb20+DQpDYzogSm9lcmcgUm9lZGVsIDxqb3Jv
QDhieXRlcy5vcmc+DQpDYzogQm9yaXNsYXYgUGV0a292IDxicEBzdXNlLmRlPg0KQ2M6IFRvbSBM
ZW5kYWNreSA8dGhvbWFzLmxlbmRhY2t5QGFtZC5jb20+DQpDYzogeDg2QGtlcm5lbC5vcmcNCkNj
OiBrdm1Admdlci5rZXJuZWwub3JnDQpDYzogbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0K
U2lnbmVkLW9mZi1ieTogQnJpamVzaCBTaW5naCA8YnJpamVzaC5zaW5naEBhbWQuY29tPg0KLS0t
DQogRG9jdW1lbnRhdGlvbi92aXJ0dWFsL2t2bS9oeXBlcmNhbGxzLnR4dCB8IDE0ICsrKysrDQog
YXJjaC94ODYvaW5jbHVkZS9hc20va3ZtX2hvc3QuaCAgICAgICAgICB8ICAyICsNCiBhcmNoL3g4
Ni9rdm0vc3ZtLmMgICAgICAgICAgICAgICAgICAgICAgIHwgNjkgKysrKysrKysrKysrKysrKysr
KysrKysrDQogYXJjaC94ODYva3ZtL3ZteC92bXguYyAgICAgICAgICAgICAgICAgICB8ICAxICsN
CiBhcmNoL3g4Ni9rdm0veDg2LmMgICAgICAgICAgICAgICAgICAgICAgIHwgIDUgKysNCiBpbmNs
dWRlL3VhcGkvbGludXgva3ZtX3BhcmEuaCAgICAgICAgICAgIHwgIDEgKw0KIDYgZmlsZXMgY2hh
bmdlZCwgOTIgaW5zZXJ0aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi92aXJ0
dWFsL2t2bS9oeXBlcmNhbGxzLnR4dCBiL0RvY3VtZW50YXRpb24vdmlydHVhbC9rdm0vaHlwZXJj
YWxscy50eHQNCmluZGV4IGRhMjRjMTM4YzhkMS4uZWNkNDRlNDg4Njc5IDEwMDY0NA0KLS0tIGEv
RG9jdW1lbnRhdGlvbi92aXJ0dWFsL2t2bS9oeXBlcmNhbGxzLnR4dA0KKysrIGIvRG9jdW1lbnRh
dGlvbi92aXJ0dWFsL2t2bS9oeXBlcmNhbGxzLnR4dA0KQEAgLTE0MSwzICsxNDEsMTcgQEAgYTAg
Y29ycmVzcG9uZHMgdG8gdGhlIEFQSUMgSUQgaW4gdGhlIHRoaXJkIGFyZ3VtZW50IChhMiksIGJp
dCAxDQogY29ycmVzcG9uZHMgdG8gdGhlIEFQSUMgSUQgYTIrMSwgYW5kIHNvIG9uLg0KIA0KIFJl
dHVybnMgdGhlIG51bWJlciBvZiBDUFVzIHRvIHdoaWNoIHRoZSBJUElzIHdlcmUgZGVsaXZlcmVk
IHN1Y2Nlc3NmdWxseS4NCisNCis3LiBLVk1fSENfUEFHRV9FTkNfU1RBVFVTDQorLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLQ0KK0FyY2hpdGVjdHVyZTogeDg2DQorU3RhdHVzOiBhY3RpdmUNCitQ
dXJwb3NlOiBOb3RpZnkgdGhlIGVuY3J5cHRpb24gc3RhdHVzIGNoYW5nZXMgaW4gZ3Vlc3QgcGFn
ZSB0YWJsZSAoU0VWIGd1ZXN0KQ0KKw0KK2EwOiB0aGUgZ3Vlc3QgcGh5c2ljYWwgYWRkcmVzcyBv
ZiB0aGUgc3RhcnQgcGFnZQ0KK2ExOiB0aGUgbnVtYmVyIG9mIHBhZ2VzDQorYTI6IHNldCBvciBj
bGVhciB0aGUgZW5jcnlwdGlvbiBhdHRyaWJ1dGUNCisNCisgICBXaGVyZToNCisJKiAxOiBFbmNy
eXB0aW9uIGF0dHJpYnV0ZSBpcyBzZXQNCisJKiAwOiBFbmNyeXB0aW9uIGF0dHJpYnV0ZSBpcyBj
bGVhcmVkDQpkaWZmIC0tZ2l0IGEvYXJjaC94ODYvaW5jbHVkZS9hc20va3ZtX2hvc3QuaCBiL2Fy
Y2gveDg2L2luY2x1ZGUvYXNtL2t2bV9ob3N0LmgNCmluZGV4IGE5ZDAzYWYzNDAzMC4uYWRiMGNh
MDM1Yjk3IDEwMDY0NA0KLS0tIGEvYXJjaC94ODYvaW5jbHVkZS9hc20va3ZtX2hvc3QuaA0KKysr
IGIvYXJjaC94ODYvaW5jbHVkZS9hc20va3ZtX2hvc3QuaA0KQEAgLTExOTYsNiArMTE5Niw4IEBA
IHN0cnVjdCBrdm1feDg2X29wcyB7DQogCXVpbnQxNl90ICgqbmVzdGVkX2dldF9ldm1jc192ZXJz
aW9uKShzdHJ1Y3Qga3ZtX3ZjcHUgKnZjcHUpOw0KIA0KIAlib29sICgqbmVlZF9lbXVsYXRpb25f
b25fcGFnZV9mYXVsdCkoc3RydWN0IGt2bV92Y3B1ICp2Y3B1KTsNCisJaW50ICgqcGFnZV9lbmNf
c3RhdHVzX2hjKShzdHJ1Y3Qga3ZtICprdm0sIHVuc2lnbmVkIGxvbmcgZ3BhLA0KKwkJCQkgIHVu
c2lnbmVkIGxvbmcgc3osIHVuc2lnbmVkIGxvbmcgbW9kZSk7DQogfTsNCiANCiBzdHJ1Y3Qga3Zt
X2FyY2hfYXN5bmNfcGYgew0KZGlmZiAtLWdpdCBhL2FyY2gveDg2L2t2bS9zdm0uYyBiL2FyY2gv
eDg2L2t2bS9zdm0uYw0KaW5kZXggNzRiNTdhYjc0MmFkLi5mMDI0ZjIwOGIwNTIgMTAwNjQ0DQot
LS0gYS9hcmNoL3g4Ni9rdm0vc3ZtLmMNCisrKyBiL2FyY2gveDg2L2t2bS9zdm0uYw0KQEAgLTEz
OCw2ICsxMzgsOCBAQCBzdHJ1Y3Qga3ZtX3Nldl9pbmZvIHsNCiAJaW50IGZkOwkJCS8qIFNFViBk
ZXZpY2UgZmQgKi8NCiAJdW5zaWduZWQgbG9uZyBwYWdlc19sb2NrZWQ7IC8qIE51bWJlciBvZiBw
YWdlcyBsb2NrZWQgKi8NCiAJc3RydWN0IGxpc3RfaGVhZCByZWdpb25zX2xpc3Q7ICAvKiBMaXN0
IG9mIHJlZ2lzdGVyZWQgcmVnaW9ucyAqLw0KKwl1bnNpZ25lZCBsb25nICpwYWdlX2VuY19ibWFw
Ow0KKwl1bnNpZ25lZCBsb25nIHBhZ2VfZW5jX2JtYXBfc2l6ZTsNCiB9Ow0KIA0KIHN0cnVjdCBr
dm1fc3ZtIHsNCkBAIC0xOTExLDYgKzE5MTMsOCBAQCBzdGF0aWMgdm9pZCBzZXZfdm1fZGVzdHJv
eShzdHJ1Y3Qga3ZtICprdm0pDQogDQogCXNldl91bmJpbmRfYXNpZChrdm0sIHNldi0+aGFuZGxl
KTsNCiAJc2V2X2FzaWRfZnJlZShrdm0pOw0KKw0KKwlrdmZyZWUoc2V2LT5wYWdlX2VuY19ibWFw
KTsNCiB9DQogDQogc3RhdGljIHZvaWQgYXZpY192bV9kZXN0cm95KHN0cnVjdCBrdm0gKmt2bSkN
CkBAIC03MzcwLDYgKzczNzQsNjkgQEAgc3RhdGljIGludCBzZXZfcmVjZWl2ZV9maW5pc2goc3Ry
dWN0IGt2bSAqa3ZtLCBzdHJ1Y3Qga3ZtX3Nldl9jbWQgKmFyZ3ApDQogCXJldHVybiByZXQ7DQog
fQ0KIA0KK3N0YXRpYyBpbnQgc2V2X3Jlc2l6ZV9wYWdlX2VuY19iaXRtYXAoc3RydWN0IGt2bSAq
a3ZtLCB1bnNpZ25lZCBsb25nIG5ld19zaXplKQ0KK3sNCisJc3RydWN0IGt2bV9zZXZfaW5mbyAq
c2V2ID0gJnRvX2t2bV9zdm0oa3ZtKS0+c2V2X2luZm87DQorCXVuc2lnbmVkIGxvbmcgKm1hcDsN
CisJdW5zaWduZWQgbG9uZyBzejsNCisNCisJaWYgKHNldi0+cGFnZV9lbmNfYm1hcF9zaXplID49
IG5ld19zaXplKQ0KKwkJcmV0dXJuIDA7DQorDQorCXN6ID0gQUxJR04obmV3X3NpemUsIEJJVFNf
UEVSX0xPTkcpIC8gODsNCisNCisJaWYgKHN6ID4gUEFHRV9TSVpFKQ0KKwkJbWFwID0gdm1hbGxv
Yyhzeik7DQorCWVsc2UNCisJCW1hcCA9IGttYWxsb2Moc3osIEdGUF9LRVJORUwpOw0KKw0KKwlp
ZiAoIW1hcCkgew0KKwkJcHJfZXJyX29uY2UoIkZhaWxlZCB0byBhbGxvY2F0ZSBkZWNyeXB0ZWQg
Yml0bWFwIHNpemUgJWx4XG4iLCBzeik7DQorCQlyZXR1cm4gMTsNCisJfQ0KKw0KKwkvKiBtYXJr
IHRoZSBwYWdlIGVuY3J5cHRlZCAoYnkgZGVmYXVsdCkgKi8NCisJbWVtc2V0KG1hcCwgMHhmZiwg
c3opOw0KKw0KKwliaXRtYXBfY29weShtYXAsIHNldi0+cGFnZV9lbmNfYm1hcCwgc2V2LT5wYWdl
X2VuY19ibWFwX3NpemUpOw0KKwlrdmZyZWUoc2V2LT5wYWdlX2VuY19ibWFwKTsNCisNCisJc2V2
LT5wYWdlX2VuY19ibWFwID0gbWFwOw0KKwlzZXYtPnBhZ2VfZW5jX2JtYXBfc2l6ZSA9IG5ld19z
aXplOw0KKw0KKwlyZXR1cm4gMDsNCit9DQorDQorc3RhdGljIGludCBzdm1fcGFnZV9lbmNfc3Rh
dHVzX2hjKHN0cnVjdCBrdm0gKmt2bSwgdW5zaWduZWQgbG9uZyBncGEsDQorCQkJCSAgdW5zaWdu
ZWQgbG9uZyBucGFnZXMsIHVuc2lnbmVkIGxvbmcgZW5jKQ0KK3sNCisJc3RydWN0IGt2bV9zZXZf
aW5mbyAqc2V2ID0gJnRvX2t2bV9zdm0oa3ZtKS0+c2V2X2luZm87DQorCWdmbl90IGdmbl9zdGFy
dCwgZ2ZuX2VuZDsNCisJaW50IHI7DQorDQorCWlmICghbnBhZ2VzKQ0KKwkJcmV0dXJuIDA7DQor
DQorCWdmbl9zdGFydCA9IGdwYV90b19nZm4oZ3BhKTsNCisJZ2ZuX2VuZCA9IGdmbl9zdGFydCAr
IG5wYWdlczsNCisNCisJbXV0ZXhfbG9jaygma3ZtLT5sb2NrKTsNCisNCisJciA9IDE7DQorCWlm
IChzZXZfcmVzaXplX3BhZ2VfZW5jX2JpdG1hcChrdm0sIGdmbl9lbmQpKQ0KKwkJZ290byB1bmxv
Y2s7DQorDQorCWlmIChlbmMpDQorCQlfX2JpdG1hcF9zZXQoc2V2LT5wYWdlX2VuY19ibWFwLCBn
Zm5fc3RhcnQsIGdmbl9lbmQgLSBnZm5fc3RhcnQpOw0KKwllbHNlDQorCQlfX2JpdG1hcF9jbGVh
cihzZXYtPnBhZ2VfZW5jX2JtYXAsIGdmbl9zdGFydCwgZ2ZuX2VuZCAtIGdmbl9zdGFydCk7DQor
DQorCXIgPSAwOw0KK3VubG9jazoNCisJbXV0ZXhfdW5sb2NrKCZrdm0tPmxvY2spOw0KKwlyZXR1
cm4gcjsNCit9DQorDQogc3RhdGljIGludCBzdm1fbWVtX2VuY19vcChzdHJ1Y3Qga3ZtICprdm0s
IHZvaWQgX191c2VyICphcmdwKQ0KIHsNCiAJc3RydWN0IGt2bV9zZXZfY21kIHNldl9jbWQ7DQpA
QCAtNzcxMSw2ICs3Nzc4LDggQEAgc3RhdGljIHN0cnVjdCBrdm1feDg2X29wcyBzdm1feDg2X29w
cyBfX3JvX2FmdGVyX2luaXQgPSB7DQogCS5uZXN0ZWRfZ2V0X2V2bWNzX3ZlcnNpb24gPSBuZXN0
ZWRfZ2V0X2V2bWNzX3ZlcnNpb24sDQogDQogCS5uZWVkX2VtdWxhdGlvbl9vbl9wYWdlX2ZhdWx0
ID0gc3ZtX25lZWRfZW11bGF0aW9uX29uX3BhZ2VfZmF1bHQsDQorDQorCS5wYWdlX2VuY19zdGF0
dXNfaGMgPSBzdm1fcGFnZV9lbmNfc3RhdHVzX2hjDQogfTsNCiANCiBzdGF0aWMgaW50IF9faW5p
dCBzdm1faW5pdCh2b2lkKQ0KZGlmZiAtLWdpdCBhL2FyY2gveDg2L2t2bS92bXgvdm14LmMgYi9h
cmNoL3g4Ni9rdm0vdm14L3ZteC5jDQppbmRleCBiNGU3ZDY0NTI3NWEuLjljODE0ZTU2MGUwZiAx
MDA2NDQNCi0tLSBhL2FyY2gveDg2L2t2bS92bXgvdm14LmMNCisrKyBiL2FyY2gveDg2L2t2bS92
bXgvdm14LmMNCkBAIC03NzMxLDYgKzc3MzEsNyBAQCBzdGF0aWMgc3RydWN0IGt2bV94ODZfb3Bz
IHZteF94ODZfb3BzIF9fcm9fYWZ0ZXJfaW5pdCA9IHsNCiAJLmdldF92bWNzMTJfcGFnZXMgPSBO
VUxMLA0KIAkubmVzdGVkX2VuYWJsZV9ldm1jcyA9IE5VTEwsDQogCS5uZWVkX2VtdWxhdGlvbl9v
bl9wYWdlX2ZhdWx0ID0gdm14X25lZWRfZW11bGF0aW9uX29uX3BhZ2VfZmF1bHQsDQorCS5wYWdl
X2VuY19zdGF0dXNfaGMgPSBOVUxMLA0KIH07DQogDQogc3RhdGljIHZvaWQgdm14X2NsZWFudXBf
bDFkX2ZsdXNoKHZvaWQpDQpkaWZmIC0tZ2l0IGEvYXJjaC94ODYva3ZtL3g4Ni5jIGIvYXJjaC94
ODYva3ZtL3g4Ni5jDQppbmRleCBhMGQxZmM4MGFjNWEuLmRlYTY0NGJlNTk5MiAxMDA2NDQNCi0t
LSBhL2FyY2gveDg2L2t2bS94ODYuYw0KKysrIGIvYXJjaC94ODYva3ZtL3g4Ni5jDQpAQCAtNzE0
MSw2ICs3MTQxLDExIEBAIGludCBrdm1fZW11bGF0ZV9oeXBlcmNhbGwoc3RydWN0IGt2bV92Y3B1
ICp2Y3B1KQ0KIAljYXNlIEtWTV9IQ19TRU5EX0lQSToNCiAJCXJldCA9IGt2bV9wdl9zZW5kX2lw
aSh2Y3B1LT5rdm0sIGEwLCBhMSwgYTIsIGEzLCBvcF82NF9iaXQpOw0KIAkJYnJlYWs7DQorCWNh
c2UgS1ZNX0hDX1BBR0VfRU5DX1NUQVRVUzoNCisJCXJldCA9IC1LVk1fRU5PU1lTOw0KKwkJaWYg
KGt2bV94ODZfb3BzLT5wYWdlX2VuY19zdGF0dXNfaGMpDQorCQkJcmV0ID0ga3ZtX3g4Nl9vcHMt
PnBhZ2VfZW5jX3N0YXR1c19oYyh2Y3B1LT5rdm0sIGEwLCBhMSwgYTIpOw0KKwkJYnJlYWs7DQog
CWRlZmF1bHQ6DQogCQlyZXQgPSAtS1ZNX0VOT1NZUzsNCiAJCWJyZWFrOw0KZGlmZiAtLWdpdCBh
L2luY2x1ZGUvdWFwaS9saW51eC9rdm1fcGFyYS5oIGIvaW5jbHVkZS91YXBpL2xpbnV4L2t2bV9w
YXJhLmgNCmluZGV4IDZjMGNlNDk5MzFlNS4uM2RjOWU1NzlmNGY5IDEwMDY0NA0KLS0tIGEvaW5j
bHVkZS91YXBpL2xpbnV4L2t2bV9wYXJhLmgNCisrKyBiL2luY2x1ZGUvdWFwaS9saW51eC9rdm1f
cGFyYS5oDQpAQCAtMjgsNiArMjgsNyBAQA0KICNkZWZpbmUgS1ZNX0hDX01JUFNfQ09OU09MRV9P
VVRQVVQJOA0KICNkZWZpbmUgS1ZNX0hDX0NMT0NLX1BBSVJJTkcJCTkNCiAjZGVmaW5lIEtWTV9I
Q19TRU5EX0lQSQkJMTANCisjZGVmaW5lIEtWTV9IQ19QQUdFX0VOQ19TVEFUVVMJCTExDQogDQog
LyoNCiAgKiBoeXBlcmNhbGxzIHVzZSBhcmNoaXRlY3R1cmUgc3BlY2lmaWMNCi0tIA0KMi4xNy4x
DQoNCg==

