Return-Path: <SRS0=3XOk=S2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73468C282CE
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 16:15:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27C0C218FE
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 16:15:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="tOnH0Qml"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27C0C218FE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44044 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJKYF-0006KD-9f
	for qemu-devel@archiver.kernel.org; Wed, 24 Apr 2019 12:15:15 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38745)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1hJKTn-0002Db-7b
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 12:10:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1hJKTS-0003up-OA
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 12:10:34 -0400
Received: from mail-eopbgr780088.outbound.protection.outlook.com
	([40.107.78.88]:16416
	helo=NAM03-BY2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <brijesh.singh@amd.com>)
	id 1hJKTS-0003kU-0p
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 12:10:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=yJrMyjOweEJUu/E5ehbZk+M5UO0UDN7fzlRgSfjlSdw=;
	b=tOnH0QmlTQ5oZDR/A+g2l5MkepkMz3pom69YghGjvsliOS7REvP7FCvkuhrfWbq+bDt7Z/MkLOrTiTzwCwvpx2WjkrpNrcPQGQAQxC1NvYXID5HIcZYa5/FABE/kW9WFNcnFmP7OV6LyuohDrEEd88tz5bbrSQbaMhQ79ocDYak=
Received: from DM6PR12MB2682.namprd12.prod.outlook.com (20.176.116.31) by
	DM6PR12MB2907.namprd12.prod.outlook.com (20.179.71.213) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1835.12; Wed, 24 Apr 2019 16:10:05 +0000
Received: from DM6PR12MB2682.namprd12.prod.outlook.com
	([fe80::9183:846f:a93e:9a43]) by
	DM6PR12MB2682.namprd12.prod.outlook.com
	([fe80::9183:846f:a93e:9a43%5]) with mapi id 15.20.1813.017;
	Wed, 24 Apr 2019 16:10:05 +0000
From: "Singh, Brijesh" <brijesh.singh@amd.com>
To: "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Thread-Topic: [RFC PATCH v1 05/10] KVM: SVM: Add KVM_SEV_RECEIVE_UPDATE_DATA
	command
Thread-Index: AQHU+rgt1JBGvmrqzE6fg6speZH5KQ==
Date: Wed, 24 Apr 2019 16:10:05 +0000
Message-ID: <20190424160942.13567-6-brijesh.singh@amd.com>
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
x-ms-office365-filtering-correlation-id: 869cb85d-ea7a-4d2a-2555-08d6c8cf503c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);
	SRVR:DM6PR12MB2907; 
x-ms-traffictypediagnostic: DM6PR12MB2907:
x-microsoft-antispam-prvs: <DM6PR12MB290744A450F70364E1C3AD4BE53C0@DM6PR12MB2907.namprd12.prod.outlook.com>
x-forefront-prvs: 00179089FD
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10009020)(39860400002)(136003)(366004)(396003)(376002)(346002)(189003)(199004)(1730700003)(99286004)(2501003)(73956011)(478600001)(11346002)(6506007)(76176011)(14454004)(6116002)(52116002)(386003)(476003)(25786009)(66946007)(486006)(4326008)(71200400001)(66446008)(66556008)(3846002)(66476007)(64756008)(1076003)(66574012)(71190400001)(446003)(186003)(2616005)(5660300002)(2351001)(102836004)(97736004)(26005)(14444005)(86362001)(6512007)(8676002)(66066001)(8936002)(68736007)(2906002)(50226002)(256004)(81156014)(305945005)(36756003)(316002)(6436002)(54906003)(7736002)(5640700003)(81166006)(53936002)(6916009)(6486002)(7416002);
	DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB2907;
	H:DM6PR12MB2682.namprd12.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Dge4eNiYna9RVu/1FLanWNAXZd1PdcECftoOS1DN5wUh8XpOWEZnwKntcsbNxX0diERdDhBGVjYvdS2KM8hODEdd5MbWdLwFWU6BLhHIrJGR+FyMdh5CXxpwmT8ELccN9G7gwqeIm7MZP44jWChoJXDu1lIWQQME8EmK6PEVCP39iQORE4RxDFN9RQxBGO66SRDA95i5930Hp4FHg+XSB0dbJq6qWjvE2S5bz7BHzj+68N3uq8Dxdy+9UW4oVf/0OV/DoOHV2M6OF2t02zathhJxlehcS1O0IzfU3ZV/kOCgTUIVOeGLxp44czgTxfEv9wXnk2XCPnnr7w1fISN0guhk6qOV5lQnO+IYkGoOlNQTZ0f3PPph6B0Mey4YjMRAeIPWrcZLGxJWiMWJFvJRhe9rTYuRoUJvgqPc+mYx6Y4=
Content-Type: text/plain; charset="UTF-8"
Content-ID: <9E9C901CA16DF34C901C217E2F8D17D3@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 869cb85d-ea7a-4d2a-2555-08d6c8cf503c
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2019 16:10:05.3621 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2907
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.78.88
Subject: [Qemu-devel] [RFC PATCH v1 05/10] KVM: SVM: Add
 KVM_SEV_RECEIVE_UPDATE_DATA command
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
Message-ID: <20190424161005.rQmphThQuO94vWOmCH80zoTnTioaysxfsWancOONICI@z>

VGhlIGNvbW1hbmQgaXMgdXNlZCBmb3IgY29weWluZyB0aGUgaW5jb21pbmcgYnVmZmVyIGludG8g
dGhlDQpTRVYgZ3Vlc3QgbWVtb3J5IHNwYWNlLg0KDQpDYzogVGhvbWFzIEdsZWl4bmVyIDx0Z2x4
QGxpbnV0cm9uaXguZGU+DQpDYzogSW5nbyBNb2xuYXIgPG1pbmdvQHJlZGhhdC5jb20+DQpDYzog
IkguIFBldGVyIEFudmluIiA8aHBhQHp5dG9yLmNvbT4NCkNjOiBQYW9sbyBCb256aW5pIDxwYm9u
emluaUByZWRoYXQuY29tPg0KQ2M6ICJSYWRpbSBLcsSNbcOhxZkiIDxya3JjbWFyQHJlZGhhdC5j
b20+DQpDYzogSm9lcmcgUm9lZGVsIDxqb3JvQDhieXRlcy5vcmc+DQpDYzogQm9yaXNsYXYgUGV0
a292IDxicEBzdXNlLmRlPg0KQ2M6IFRvbSBMZW5kYWNreSA8dGhvbWFzLmxlbmRhY2t5QGFtZC5j
b20+DQpDYzogeDg2QGtlcm5lbC5vcmcNCkNjOiBrdm1Admdlci5rZXJuZWwub3JnDQpDYzogbGlu
dXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KU2lnbmVkLW9mZi1ieTogQnJpamVzaCBTaW5naCA8
YnJpamVzaC5zaW5naEBhbWQuY29tPg0KLS0tDQogLi4uL3ZpcnR1YWwva3ZtL2FtZC1tZW1vcnkt
ZW5jcnlwdGlvbi5yc3QgICAgIHwgMjQgKysrKysrDQogYXJjaC94ODYva3ZtL3N2bS5jICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIHwgODQgKysrKysrKysrKysrKysrKysrKw0KIGluY2x1ZGUv
dWFwaS9saW51eC9rdm0uaCAgICAgICAgICAgICAgICAgICAgICB8ICA5ICsrDQogMyBmaWxlcyBj
aGFuZ2VkLCAxMTcgaW5zZXJ0aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi92
aXJ0dWFsL2t2bS9hbWQtbWVtb3J5LWVuY3J5cHRpb24ucnN0IGIvRG9jdW1lbnRhdGlvbi92aXJ0
dWFsL2t2bS9hbWQtbWVtb3J5LWVuY3J5cHRpb24ucnN0DQppbmRleCBhY2RmZjI0NTQ2NDkuLmI5
YzNkYzAyZjM0NCAxMDA2NDQNCi0tLSBhL0RvY3VtZW50YXRpb24vdmlydHVhbC9rdm0vYW1kLW1l
bW9yeS1lbmNyeXB0aW9uLnJzdA0KKysrIGIvRG9jdW1lbnRhdGlvbi92aXJ0dWFsL2t2bS9hbWQt
bWVtb3J5LWVuY3J5cHRpb24ucnN0DQpAQCAtMzIyLDYgKzMyMiwzMCBAQCBPbiBzdWNjZXNzLCB0
aGUgJ2hhbmRsZScgZmllbGQgY29udGFpbnMgYSBuZXcgaGFuZGxlIGFuZCBvbiBlcnJvciwgYSBu
ZWdhdGl2ZSB2YQ0KIA0KIEZvciBtb3JlIGRldGFpbHMsIHNlZSBTRVYgc3BlYyBTZWN0aW9uIDYu
MTIuDQogDQorMTQuIEtWTV9TRVZfUkVDRUlWRV9VUERBVEVfREFUQQ0KKy0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0NCisNCitUaGUgS1ZNX1NFVl9SRUNFSVZFX1VQREFURV9EQVRBIGNvbW1h
bmQgY2FuIGJlIHVzZWQgYnkgdGhlIGh5cGVydmlzb3IgdG8gY29weQ0KK3RoZSBpbmNvbWluZyBi
dWZmZXJzIGludG8gdGhlIGd1ZXN0IG1lbW9yeSByZWdpb24gd2l0aCBlbmNyeXB0aW9uIGNvbnRl
eHQNCitjcmVhdGVkIGR1cmluZyB0aGUgS1ZNX1NFVl9SRUNFSVZFX1NUQVJULg0KKw0KK1BhcmFt
ZXRlcnMgKGluKTogc3RydWN0IGt2bV9zZXZfcmVjZWl2ZV91cGRhdGVfZGF0YQ0KKw0KK1JldHVy
bnM6IDAgb24gc3VjY2VzcywgLW5lZ2F0aXZlIG9uIGVycm9yDQorDQorOjoNCisNCisgICAgICAg
IHN0cnVjdCBrdm1fc2V2X2xhdW5jaF9yZWNlaXZlX3VwZGF0ZV9kYXRhIHsNCisgICAgICAgICAg
ICAgICAgX191NjQgaGRyX3VhZGRyOyAgICAgICAgLyogdXNlcnNwYWNlIGFkZHJlc3MgY29udGFp
bmluZyB0aGUgcGFja2V0IGhlYWRlciAqLw0KKyAgICAgICAgICAgICAgICBfX3UzMiBoZHJfbGVu
Ow0KKw0KKyAgICAgICAgICAgICAgICBfX3U2NCBndWVzdF91YWRkcjsgICAgICAvKiB0aGUgZGVz
dGluYXRpb24gZ3Vlc3QgbWVtb3J5IHJlZ2lvbiAqLw0KKyAgICAgICAgICAgICAgICBfX3UzMiBn
dWVzdF9sZW47DQorDQorICAgICAgICAgICAgICAgIF9fdTY0IHRyYW5zX3VhZGRyOyAgICAgIC8q
IHRoZSBpbmNvbWluZyBidWZmZXIgbWVtb3J5IHJlZ2lvbiAgKi8NCisgICAgICAgICAgICAgICAg
X191MzIgdHJhbnNfbGVuOw0KKyAgICAgICAgfTsNCisNCiBSZWZlcmVuY2VzDQogPT09PT09PT09
PQ0KIA0KZGlmZiAtLWdpdCBhL2FyY2gveDg2L2t2bS9zdm0uYyBiL2FyY2gveDg2L2t2bS9zdm0u
Yw0KaW5kZXggYTdkY2YxOWJhZWZiLi5jODFjYWMwOWM1YWYgMTAwNjQ0DQotLS0gYS9hcmNoL3g4
Ni9rdm0vc3ZtLmMNCisrKyBiL2FyY2gveDg2L2t2bS9zdm0uYw0KQEAgLTcyNjksNiArNzI2OSw4
NyBAQCBzdGF0aWMgaW50IHNldl9yZWNlaXZlX3N0YXJ0KHN0cnVjdCBrdm0gKmt2bSwgc3RydWN0
IGt2bV9zZXZfY21kICphcmdwKQ0KIAlyZXR1cm4gcmV0Ow0KIH0NCiANCitzdGF0aWMgaW50IHNl
dl9yZWNlaXZlX3VwZGF0ZV9kYXRhKHN0cnVjdCBrdm0gKmt2bSwgc3RydWN0IGt2bV9zZXZfY21k
ICphcmdwKQ0KK3sNCisJc3RydWN0IGt2bV9zZXZfaW5mbyAqc2V2ID0gJnRvX2t2bV9zdm0oa3Zt
KS0+c2V2X2luZm87DQorCXN0cnVjdCBrdm1fc2V2X3JlY2VpdmVfdXBkYXRlX2RhdGEgcGFyYW1z
Ow0KKwlzdHJ1Y3Qgc2V2X2RhdGFfcmVjZWl2ZV91cGRhdGVfZGF0YSAqZGF0YTsNCisJdm9pZCAq
aGRyID0gTlVMTCwgKnRyYW5zID0gTlVMTDsNCisJc3RydWN0IHBhZ2UgKipndWVzdF9wYWdlOw0K
Kwl1bnNpZ25lZCBsb25nIG47DQorCWludCByZXQsIG9mZnNldDsNCisNCisJaWYgKCFzZXZfZ3Vl
c3Qoa3ZtKSkNCisJCXJldHVybiAtRUlOVkFMOw0KKw0KKwlpZiAoY29weV9mcm9tX3VzZXIoJnBh
cmFtcywgKHZvaWQgX191c2VyICopKHVpbnRwdHJfdClhcmdwLT5kYXRhLA0KKwkJCXNpemVvZihz
dHJ1Y3Qga3ZtX3Nldl9yZWNlaXZlX3VwZGF0ZV9kYXRhKSkpDQorCQlyZXR1cm4gLUVGQVVMVDsN
CisNCisJaWYgKCFwYXJhbXMuaGRyX3VhZGRyIHx8ICFwYXJhbXMuaGRyX2xlbiB8fA0KKwkgICAg
IXBhcmFtcy5ndWVzdF91YWRkciB8fCAhcGFyYW1zLmd1ZXN0X2xlbiB8fA0KKwkgICAgIXBhcmFt
cy50cmFuc191YWRkciB8fCAhcGFyYW1zLnRyYW5zX2xlbikNCisJCXJldHVybiAtRUlOVkFMOw0K
Kw0KKwkvKiBDaGVjayBpZiB3ZSBhcmUgY3Jvc3NpbmcgdGhlIHBhZ2UgYm91bmRyeSAqLw0KKwlv
ZmZzZXQgPSBwYXJhbXMuZ3Vlc3RfdWFkZHIgJiAoUEFHRV9TSVpFIC0gMSk7DQorCWlmICgocGFy
YW1zLmd1ZXN0X2xlbiArIG9mZnNldCA+IFBBR0VfU0laRSkpDQorCQlyZXR1cm4gLUVJTlZBTDsN
CisNCisJZGF0YSA9IGt6YWxsb2Moc2l6ZW9mKCpkYXRhKSwgR0ZQX0tFUk5FTCk7DQorCWlmICgh
ZGF0YSkNCisJCXJldHVybiAtRU5PTUVNOw0KKw0KKwloZHIgPSBwc3BfY29weV91c2VyX2Jsb2Io
cGFyYW1zLmhkcl91YWRkciwgcGFyYW1zLmhkcl9sZW4pOw0KKwlpZiAoSVNfRVJSKGhkcikpIHsN
CisJCXJldCA9IFBUUl9FUlIoaGRyKTsNCisJCWdvdG8gZV9mcmVlOw0KKwl9DQorDQorCWRhdGEt
Pmhkcl9hZGRyZXNzID0gX19wc3BfcGEoaGRyKTsNCisJZGF0YS0+aGRyX2xlbiA9IHBhcmFtcy5o
ZHJfbGVuOw0KKw0KKwl0cmFucyA9IHBzcF9jb3B5X3VzZXJfYmxvYihwYXJhbXMudHJhbnNfdWFk
ZHIsIHBhcmFtcy50cmFuc19sZW4pOw0KKwlpZiAoSVNfRVJSKHRyYW5zKSkgew0KKwkJcmV0ID0g
UFRSX0VSUih0cmFucyk7DQorCQlnb3RvIGVfZnJlZTsNCisJfQ0KKw0KKwlkYXRhLT50cmFuc19h
ZGRyZXNzID0gX19wc3BfcGEodHJhbnMpOw0KKwlkYXRhLT50cmFuc19sZW4gPSBwYXJhbXMudHJh
bnNfbGVuOw0KKw0KKwkvKiBQaW4gZ3Vlc3QgbWVtb3J5ICovDQorCXJldCA9IC1FRkFVTFQ7DQor
CWd1ZXN0X3BhZ2UgPSBzZXZfcGluX21lbW9yeShrdm0sIHBhcmFtcy5ndWVzdF91YWRkciAmIFBB
R0VfTUFTSywNCisJCQkJICAgIFBBR0VfU0laRSwgJm4sIDApOw0KKwlpZiAoIWd1ZXN0X3BhZ2Up
DQorCQlnb3RvIGVfZnJlZTsNCisNCisJZGF0YS0+Z3Vlc3RfYWRkcmVzcyA9IF9fc21lX3BhZ2Vf
cGEoZ3Vlc3RfcGFnZVswXSkgKyBvZmZzZXQ7DQorCWRhdGEtPmd1ZXN0X2xlbiA9IHBhcmFtcy5n
dWVzdF9sZW47DQorDQorCS8qDQorCSAqIFRoZSBSRUNFSVZFX1VQREFURV9EQVRBIGNvbW1hbmQg
cmVxdWlyZXMgQy1iaXQgdG8gYmUgYWx3YXlzIHNldC4NCisJICogVGhlIF9fc21lX3BhZ2VfcGEo
KSB0YWtlcyBjYXJlIG9mIHNldHRpbmcgdGhlIEMtYml0IG9ubHkgd2hlbiBTTUUNCisJICogaXMg
ZW5hYmxlZCBvbiB0aGUgaG9zdC4gQnV0IHdlIG5lZWQgdG8gc2V0IHRoZSBDLWJpdCByZWdhcmxl
c3Mgb2YNCisJICogdGhlIFNNRSBzdGF0ZS4NCisJICovDQorCWRhdGEtPmd1ZXN0X2FkZHJlc3Mg
fD0gbWVfbWFzazsNCisNCisJLyogZmx1c2ggdGhlIGNhY2hlcyB0byBlbnN1cmUgdGhhdCBEUkFN
IGhhcyByZWNlbnQgY29udGVudHMgKi8NCisJc2V2X2NsZmx1c2hfcGFnZXMoZ3Vlc3RfcGFnZSwg
bik7DQorDQorCWRhdGEtPmhhbmRsZSA9IHNldi0+aGFuZGxlOw0KKwlyZXQgPSBzZXZfaXNzdWVf
Y21kKGt2bSwgU0VWX0NNRF9SRUNFSVZFX1VQREFURV9EQVRBLCBkYXRhLCAmYXJncC0+ZXJyb3Ip
Ow0KKw0KKwlzZXZfdW5waW5fbWVtb3J5KGt2bSwgZ3Vlc3RfcGFnZSwgbik7DQorZV9mcmVlOg0K
KwlrZnJlZShkYXRhKTsNCisJa2ZyZWUoaGRyKTsNCisJa2ZyZWUodHJhbnMpOw0KKwlyZXR1cm4g
cmV0Ow0KK30NCisNCiBzdGF0aWMgaW50IHN2bV9tZW1fZW5jX29wKHN0cnVjdCBrdm0gKmt2bSwg
dm9pZCBfX3VzZXIgKmFyZ3ApDQogew0KIAlzdHJ1Y3Qga3ZtX3Nldl9jbWQgc2V2X2NtZDsNCkBA
IC03MzIyLDYgKzc0MDMsOSBAQCBzdGF0aWMgaW50IHN2bV9tZW1fZW5jX29wKHN0cnVjdCBrdm0g
Kmt2bSwgdm9pZCBfX3VzZXIgKmFyZ3ApDQogCWNhc2UgS1ZNX1NFVl9SRUNFSVZFX1NUQVJUOg0K
IAkJciA9IHNldl9yZWNlaXZlX3N0YXJ0KGt2bSwgJnNldl9jbWQpOw0KIAkJYnJlYWs7DQorCWNh
c2UgS1ZNX1NFVl9SRUNFSVZFX1VQREFURV9EQVRBOg0KKwkJciA9IHNldl9yZWNlaXZlX3VwZGF0
ZV9kYXRhKGt2bSwgJnNldl9jbWQpOw0KKwkJYnJlYWs7DQogCWRlZmF1bHQ6DQogCQlyID0gLUVJ
TlZBTDsNCiAJCWdvdG8gb3V0Ow0KZGlmZiAtLWdpdCBhL2luY2x1ZGUvdWFwaS9saW51eC9rdm0u
aCBiL2luY2x1ZGUvdWFwaS9saW51eC9rdm0uaA0KaW5kZXggZmVlNzViZjFmZDkwLi4wN2UwNThh
M2VjMTEgMTAwNjQ0DQotLS0gYS9pbmNsdWRlL3VhcGkvbGludXgva3ZtLmgNCisrKyBiL2luY2x1
ZGUvdWFwaS9saW51eC9rdm0uaA0KQEAgLTE1NTAsNiArMTU1MCwxNSBAQCBzdHJ1Y3Qga3ZtX3Nl
dl9yZWNlaXZlX3N0YXJ0IHsNCiAJX191MzIgc2Vzc2lvbl9sZW47DQogfTsNCiANCitzdHJ1Y3Qg
a3ZtX3Nldl9yZWNlaXZlX3VwZGF0ZV9kYXRhIHsNCisJX191NjQgaGRyX3VhZGRyOw0KKwlfX3Uz
MiBoZHJfbGVuOw0KKwlfX3U2NCBndWVzdF91YWRkcjsNCisJX191MzIgZ3Vlc3RfbGVuOw0KKwlf
X3U2NCB0cmFuc191YWRkcjsNCisJX191MzIgdHJhbnNfbGVuOw0KK307DQorDQogI2RlZmluZSBL
Vk1fREVWX0FTU0lHTl9FTkFCTEVfSU9NTVUJKDEgPDwgMCkNCiAjZGVmaW5lIEtWTV9ERVZfQVNT
SUdOX1BDSV8yXzMJCSgxIDw8IDEpDQogI2RlZmluZSBLVk1fREVWX0FTU0lHTl9NQVNLX0lOVFgJ
KDEgPDwgMikNCi0tIA0KMi4xNy4xDQoNCg==

