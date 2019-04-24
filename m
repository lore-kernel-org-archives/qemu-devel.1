Return-Path: <SRS0=3XOk=S2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5293EC10F11
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 16:12:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09961208E4
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 16:12:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="oHDumryG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09961208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44015 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJKVg-0003ZM-8L
	for qemu-devel@archiver.kernel.org; Wed, 24 Apr 2019 12:12:36 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38744)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1hJKTn-0002Da-7g
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 12:10:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1hJKTP-0003sH-Lp
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 12:10:30 -0400
Received: from mail-eopbgr780073.outbound.protection.outlook.com
	([40.107.78.73]:27328
	helo=NAM03-BY2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <brijesh.singh@amd.com>)
	id 1hJKTL-0003PD-W3
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 12:10:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=BXUtay9u6xsCnm/ubMf9AatplD5M6xs2nRBVpyg7C48=;
	b=oHDumryGwxJQdl8kEF6DSKFRbO4k3QZvjz9UbrV54O37u0mt0dPSMF8k7hTJMmDVT/HwrZjIj5QPdiS/f3762mEnDxTHJnhsO5yXkRc9exb1Bpn/uuCKagUNnCnKFesvt2lnys2BYRGfMCw/7JQvnUYzjPyW1id7BMuAdzm0cHU=
Received: from DM6PR12MB2682.namprd12.prod.outlook.com (20.176.116.31) by
	DM6PR12MB2907.namprd12.prod.outlook.com (20.179.71.213) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1835.12; Wed, 24 Apr 2019 16:10:01 +0000
Received: from DM6PR12MB2682.namprd12.prod.outlook.com
	([fe80::9183:846f:a93e:9a43]) by
	DM6PR12MB2682.namprd12.prod.outlook.com
	([fe80::9183:846f:a93e:9a43%5]) with mapi id 15.20.1813.017;
	Wed, 24 Apr 2019 16:10:01 +0000
From: "Singh, Brijesh" <brijesh.singh@amd.com>
To: "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Thread-Topic: [RFC PATCH v1 02/10] KVM: SVM: Add KVM_SEND_UPDATE_DATA command
Thread-Index: AQHU+rgr5ZWFEHS1e0SVdIqZ4Ix/vw==
Date: Wed, 24 Apr 2019 16:10:01 +0000
Message-ID: <20190424160942.13567-3-brijesh.singh@amd.com>
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
x-ms-office365-filtering-correlation-id: 3c7ec30c-416f-44e7-2eb2-08d6c8cf4db3
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);
	SRVR:DM6PR12MB2907; 
x-ms-traffictypediagnostic: DM6PR12MB2907:
x-microsoft-antispam-prvs: <DM6PR12MB29071F6469AC6AAD7B9C5BCBE53C0@DM6PR12MB2907.namprd12.prod.outlook.com>
x-forefront-prvs: 00179089FD
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10009020)(979002)(39860400002)(136003)(366004)(396003)(376002)(346002)(189003)(199004)(1730700003)(99286004)(2501003)(73956011)(478600001)(11346002)(6506007)(76176011)(14454004)(6116002)(52116002)(386003)(476003)(25786009)(66946007)(486006)(4326008)(71200400001)(66446008)(66556008)(3846002)(66476007)(64756008)(1076003)(66574012)(71190400001)(446003)(186003)(2616005)(5660300002)(2351001)(102836004)(97736004)(26005)(14444005)(86362001)(6512007)(8676002)(66066001)(8936002)(68736007)(2906002)(50226002)(256004)(81156014)(305945005)(36756003)(316002)(6436002)(54906003)(7736002)(5640700003)(81166006)(53936002)(6916009)(6486002)(7416002)(969003)(989001)(999001)(1009001)(1019001);
	DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB2907;
	H:DM6PR12MB2682.namprd12.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: d3NtRLpH5r2c54luP6BoUisgpaicOJrIkqdrpYoL80mNiaKx1tvRdsBvMh2tCop1mCjEmi8AYHQ2TUP00iJGTcykL2qmRw40eL59tkagp4w0jHHa7AMRnNUTMfRPVWvImqWrJidYK0jVgPHzue4EFYrrer7eDw+vGT8CM2hpji9T7TKZ+7xoVY4RbUykcogD8QL9R6O/7JbRCtssOCLKoeL7S9bBXcBFLSJRoSWDQ83gHRjpKVJmKumbdXnr/dE8K6O4A2ItZNDxKygCQIxCUYurTrfGd1gNam17YeZI4lM+j6oP4vZzZqKF11/1goxlJxjFfZQ9NgnuZvQhJq7LM4lRSS06nXGGNbczwuHvJwAPP7Z6d3uncXWsi3l4uFFAnGP9irsG+rKMnjWXg/YCnYLNxODi+5L2XfgKvhMXtTw=
Content-Type: text/plain; charset="UTF-8"
Content-ID: <C509C629540EE44A93D185C8B0E64C0A@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c7ec30c-416f-44e7-2eb2-08d6c8cf4db3
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2019 16:10:01.5904 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2907
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.78.73
Subject: [Qemu-devel] [RFC PATCH v1 02/10] KVM: SVM: Add
 KVM_SEND_UPDATE_DATA command
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
Message-ID: <20190424161001.OXcfzj7SrctiKkyCi2N_6ZxmV9P8s2ujAvY0czYVeCE@z>

VGhlIGNvbW1hbmQgaXMgdXNlZCBmb3IgZW5jcnlwdGluZyB0aGUgZ3Vlc3QgbWVtb3J5IHJlZ2lv
biB1c2luZyB0aGUgZW5jcnlwdGlvbg0KY29udGV4dCBjcmVhdGVkIHdpdGggS1ZNX1NFVl9TRU5E
X1NUQVJULg0KDQpDYzogVGhvbWFzIEdsZWl4bmVyIDx0Z2x4QGxpbnV0cm9uaXguZGU+DQpDYzog
SW5nbyBNb2xuYXIgPG1pbmdvQHJlZGhhdC5jb20+DQpDYzogIkguIFBldGVyIEFudmluIiA8aHBh
QHp5dG9yLmNvbT4NCkNjOiBQYW9sbyBCb256aW5pIDxwYm9uemluaUByZWRoYXQuY29tPg0KQ2M6
ICJSYWRpbSBLcsSNbcOhxZkiIDxya3JjbWFyQHJlZGhhdC5jb20+DQpDYzogSm9lcmcgUm9lZGVs
IDxqb3JvQDhieXRlcy5vcmc+DQpDYzogQm9yaXNsYXYgUGV0a292IDxicEBzdXNlLmRlPg0KQ2M6
IFRvbSBMZW5kYWNreSA8dGhvbWFzLmxlbmRhY2t5QGFtZC5jb20+DQpDYzogeDg2QGtlcm5lbC5v
cmcNCkNjOiBrdm1Admdlci5rZXJuZWwub3JnDQpDYzogbGludXgta2VybmVsQHZnZXIua2VybmVs
Lm9yZw0KU2lnbmVkLW9mZi1ieTogQnJpamVzaCBTaW5naCA8YnJpamVzaC5zaW5naEBhbWQuY29t
Pg0KLS0tDQogLi4uL3ZpcnR1YWwva3ZtL2FtZC1tZW1vcnktZW5jcnlwdGlvbi5yc3QgICAgIHwg
IDIzICsrKysNCiBhcmNoL3g4Ni9rdm0vc3ZtLmMgICAgICAgICAgICAgICAgICAgICAgICAgICAg
fCAxMjggKysrKysrKysrKysrKysrKystDQogaW5jbHVkZS91YXBpL2xpbnV4L2t2bS5oICAgICAg
ICAgICAgICAgICAgICAgIHwgICA5ICsrDQogMyBmaWxlcyBjaGFuZ2VkLCAxNTcgaW5zZXJ0aW9u
cygrKSwgMyBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vdmlydHVh
bC9rdm0vYW1kLW1lbW9yeS1lbmNyeXB0aW9uLnJzdCBiL0RvY3VtZW50YXRpb24vdmlydHVhbC9r
dm0vYW1kLW1lbW9yeS1lbmNyeXB0aW9uLnJzdA0KaW5kZXggMzQwYWM0Zjg3MzIxLi5hMDIwOGUx
NzE0ODkgMTAwNjQ0DQotLS0gYS9Eb2N1bWVudGF0aW9uL3ZpcnR1YWwva3ZtL2FtZC1tZW1vcnkt
ZW5jcnlwdGlvbi5yc3QNCisrKyBiL0RvY3VtZW50YXRpb24vdmlydHVhbC9rdm0vYW1kLW1lbW9y
eS1lbmNyeXB0aW9uLnJzdA0KQEAgLTI2Miw2ICsyNjIsMjkgQEAgUmV0dXJuczogMCBvbiBzdWNj
ZXNzLCAtbmVnYXRpdmUgb24gZXJyb3INCiAgICAgICAgICAgICAgICAgX191MzIgYW1kX2NlcnRf
bGVuOw0KICAgICAgICAgfTsNCiANCisxMS4gS1ZNX1NFVl9TRU5EX1VQREFURV9EQVRBDQorLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KKw0KK1RoZSBLVk1fU0VWX1NFTkRfVVBEQVRFX0RB
VEEgY29tbWFuZCBjYW4gYmUgdXNlZCBieSB0aGUgaHlwZXJ2aXNvciB0byBlbmNyeXB0IHRoZQ0K
K291dGdvaW5nIGd1ZXN0IG1lbW9yeSByZWdpb24gd2l0aCBlbmNyeXB0aW9uIGNvbnRleHQgY3Jl
YXRpbmcgdXNpbmcgS1ZNX1NFVl9TRU5EX1NUQVJULg0KKw0KK1BhcmFtZXRlcnMgKGluKTogc3Ry
dWN0IGt2bV9zZXZfc2VuZF91cGRhdGVfZGF0YQ0KKw0KK1JldHVybnM6IDAgb24gc3VjY2Vzcywg
LW5lZ2F0aXZlIG9uIGVycm9yDQorDQorOjoNCisNCisgICAgICAgIHN0cnVjdCBrdm1fc2V2X2xh
dW5jaF9zZW5kX3VwZGF0ZV9kYXRhIHsNCisgICAgICAgICAgICAgICAgX191NjQgaGRyX3VhZGRy
OyAgICAgICAgLyogdXNlcnNwYWNlIGFkZHJlc3MgY29udGFpbmluZyB0aGUgcGFja2V0IGhlYWRl
ciAqLw0KKyAgICAgICAgICAgICAgICBfX3UzMiBoZHJfbGVuOw0KKw0KKyAgICAgICAgICAgICAg
ICBfX3U2NCBndWVzdF91YWRkcjsgICAgICAvKiB0aGUgc291cmNlIG1lbW9yeSByZWdpb24gdG8g
YmUgZW5jcnlwdGVkICovDQorICAgICAgICAgICAgICAgIF9fdTMyIGd1ZXN0X2xlbjsNCisNCisg
ICAgICAgICAgICAgICAgX191NjQgdHJhbnNfdWFkZHI7ICAgICAgLyogdGhlIGRlc3RpdGlvbiBt
ZW1vcnkgcmVnaW9uICAqLw0KKyAgICAgICAgICAgICAgICBfX3UzMiB0cmFuc19sZW47DQorICAg
ICAgICB9Ow0KKw0KIFJlZmVyZW5jZXMNCiA9PT09PT09PT09DQogDQpkaWZmIC0tZ2l0IGEvYXJj
aC94ODYva3ZtL3N2bS5jIGIvYXJjaC94ODYva3ZtL3N2bS5jDQppbmRleCA0YzJhMjI1YmE1NDYu
LmExY2ZkMzZkNjE5NSAxMDA2NDQNCi0tLSBhL2FyY2gveDg2L2t2bS9zdm0uYw0KKysrIGIvYXJj
aC94ODYva3ZtL3N2bS5jDQpAQCAtNDE4LDYgKzQxOCw3IEBAIGVudW0gew0KIA0KIHN0YXRpYyB1
bnNpZ25lZCBpbnQgbWF4X3Nldl9hc2lkOw0KIHN0YXRpYyB1bnNpZ25lZCBpbnQgbWluX3Nldl9h
c2lkOw0KK3N0YXRpYyB1bnNpZ25lZCBsb25nIG1lX21hc2s7DQogc3RhdGljIHVuc2lnbmVkIGxv
bmcgKnNldl9hc2lkX2JpdG1hcDsNCiAjZGVmaW5lIF9fc21lX3BhZ2VfcGEoeCkgX19zbWVfc2V0
KHBhZ2VfdG9fcGZuKHgpIDw8IFBBR0VfU0hJRlQpDQogDQpAQCAtMTIxNiwxNSArMTIxNywyMSBA
QCBzdGF0aWMgaW50IGF2aWNfZ2FfbG9nX25vdGlmaWVyKHUzMiBnYV90YWcpDQogc3RhdGljIF9f
aW5pdCBpbnQgc2V2X2hhcmR3YXJlX3NldHVwKHZvaWQpDQogew0KIAlzdHJ1Y3Qgc2V2X3VzZXJf
ZGF0YV9zdGF0dXMgKnN0YXR1czsNCisJaW50IGVheCwgZWJ4Ow0KIAlpbnQgcmM7DQogDQotCS8q
IE1heGltdW0gbnVtYmVyIG9mIGVuY3J5cHRlZCBndWVzdHMgc3VwcG9ydGVkIHNpbXVsdGFuZW91
c2x5ICovDQotCW1heF9zZXZfYXNpZCA9IGNwdWlkX2VjeCgweDgwMDAwMDFGKTsNCisJLyoNCisJ
ICogUXVlcnkgdGhlIG1lbW9yeSBlbmNyeXB0aW9uIGluZm9ybWF0aW9uLg0KKwkgKiAgRUJYOiAg
Qml0IDA6NSBQYWdldGFibGUgYml0IHBvc2l0aW9uIHVzZWQgdG8gaW5kaWNhdGUgZW5jcnlwdGlv
biAoYWthIENiaXQpLg0KKwkgKiAgRUNYOiAgTWF4aW11bSBudW1iZXIgb2YgZW5jcnlwdGVkIGd1
ZXN0cyBzdXBwb3J0ZWQgc2ltdWx0YW5lb3VzbHkuDQorCSAqICBFRFg6ICBNaW5pbXVtIEFTSUQg
dmFsdWUgdGhhdCBzaG91bGQgYmUgdXNlZCBmb3IgU0VWIGd1ZXN0Lg0KKwkgKi8NCisJY3B1aWQo
MHg4MDAwMDAxZiwgJmVheCwgJmVieCwgJm1heF9zZXZfYXNpZCwgJm1pbl9zZXZfYXNpZCk7DQog
DQogCWlmICghbWF4X3Nldl9hc2lkKQ0KIAkJcmV0dXJuIDE7DQogDQotCS8qIE1pbmltdW0gQVNJ
RCB2YWx1ZSB0aGF0IHNob3VsZCBiZSB1c2VkIGZvciBTRVYgZ3Vlc3QgKi8NCisJbWVfbWFzayA9
IDFVTCA8PCAoZWJ4ICYgMHgzZik7DQogCW1pbl9zZXZfYXNpZCA9IGNwdWlkX2VkeCgweDgwMDAw
MDFGKTsNCiANCiAJLyogSW5pdGlhbGl6ZSBTRVYgQVNJRCBiaXRtYXAgKi8NCkBAIC03MDUzLDYg
KzcwNjAsMTE4IEBAIHN0YXRpYyBpbnQgc2V2X3NlbmRfc3RhcnQoc3RydWN0IGt2bSAqa3ZtLCBz
dHJ1Y3Qga3ZtX3Nldl9jbWQgKmFyZ3ApDQogCXJldHVybiByZXQ7DQogfQ0KIA0KK3N0YXRpYyBp
bnQgc2V2X3NlbmRfdXBkYXRlX2RhdGEoc3RydWN0IGt2bSAqa3ZtLCBzdHJ1Y3Qga3ZtX3Nldl9j
bWQgKmFyZ3ApDQorew0KKwlzdHJ1Y3Qga3ZtX3Nldl9pbmZvICpzZXYgPSAmdG9fa3ZtX3N2bShr
dm0pLT5zZXZfaW5mbzsNCisJc3RydWN0IHNldl9kYXRhX3NlbmRfdXBkYXRlX2RhdGEgKmRhdGE7
DQorCXN0cnVjdCBrdm1fc2V2X3NlbmRfdXBkYXRlX2RhdGEgcGFyYW1zOw0KKwl2b2lkICpoZHIg
PSBOVUxMLCAqdHJhbnNfZGF0YSA9IE5VTEw7DQorCXN0cnVjdCBwYWdlICoqZ3Vlc3RfcGFnZSA9
IE5VTEw7DQorCXVuc2lnbmVkIGxvbmcgbjsNCisJaW50IHJldCwgb2Zmc2V0Ow0KKw0KKwlpZiAo
IXNldl9ndWVzdChrdm0pKQ0KKwkJcmV0dXJuIC1FTk9UVFk7DQorDQorCWlmIChjb3B5X2Zyb21f
dXNlcigmcGFyYW1zLCAodm9pZCBfX3VzZXIgKikodWludHB0cl90KWFyZ3AtPmRhdGEsDQorCQkJ
c2l6ZW9mKHN0cnVjdCBrdm1fc2V2X3NlbmRfdXBkYXRlX2RhdGEpKSkNCisJCXJldHVybiAtRUZB
VUxUOw0KKw0KKwlkYXRhID0ga3phbGxvYyhzaXplb2YoKmRhdGEpLCBHRlBfS0VSTkVMKTsNCisJ
aWYgKCFkYXRhKQ0KKwkJcmV0dXJuIC1FTk9NRU07DQorDQorCS8qIHVzZXJzcGFjZSB3YW50cyB0
byBxdWVyeSBlaXRoZXIgaGVhZGVyIG9yIHRyYW5zIGxlbmd0aCAqLw0KKwlpZiAoIXBhcmFtcy50
cmFuc19sZW4gfHwgIXBhcmFtcy5oZHJfbGVuKQ0KKwkJZ290byBjbWQ7DQorDQorCXJldCA9IC1F
SU5WQUw7DQorCWlmICghcGFyYW1zLnRyYW5zX3VhZGRyIHx8ICFwYXJhbXMuZ3Vlc3RfdWFkZHIg
fHwNCisJICAgICFwYXJhbXMuZ3Vlc3RfbGVuIHx8ICFwYXJhbXMuaGRyX3VhZGRyKQ0KKwkJZ290
byBlX2ZyZWU7DQorDQorCS8qIENoZWNrIGlmIHdlIGFyZSBjcm9zc2luZyB0aGUgcGFnZSBib3Vu
ZHJ5ICovDQorCXJldCA9IC1FSU5WQUw7DQorCW9mZnNldCA9IHBhcmFtcy5ndWVzdF91YWRkciAm
IChQQUdFX1NJWkUgLSAxKTsNCisJaWYgKChwYXJhbXMuZ3Vlc3RfbGVuICsgb2Zmc2V0ID4gUEFH
RV9TSVpFKSkNCisJCWdvdG8gZV9mcmVlOw0KKw0KKwlyZXQgPSAtRU5PTUVNOw0KKwloZHIgPSBr
bWFsbG9jKHBhcmFtcy5oZHJfbGVuLCBHRlBfS0VSTkVMKTsNCisJaWYgKCFoZHIpDQorCQlnb3Rv
IGVfZnJlZTsNCisNCisJZGF0YS0+aGRyX2FkZHJlc3MgPSBfX3BzcF9wYShoZHIpOw0KKwlkYXRh
LT5oZHJfbGVuID0gcGFyYW1zLmhkcl9sZW47DQorDQorCXJldCA9IC1FTk9NRU07DQorCXRyYW5z
X2RhdGEgPSBrbWFsbG9jKHBhcmFtcy50cmFuc19sZW4sIEdGUF9LRVJORUwpOw0KKwlpZiAoIXRy
YW5zX2RhdGEpDQorCQlnb3RvIGVfZnJlZTsNCisNCisJZGF0YS0+dHJhbnNfYWRkcmVzcyA9IF9f
cHNwX3BhKHRyYW5zX2RhdGEpOw0KKwlkYXRhLT50cmFuc19sZW4gPSBwYXJhbXMudHJhbnNfbGVu
Ow0KKw0KKwkvKiBQaW4gZ3Vlc3QgbWVtb3J5ICovDQorCXJldCA9IC1FRkFVTFQ7DQorCWd1ZXN0
X3BhZ2UgPSBzZXZfcGluX21lbW9yeShrdm0sIHBhcmFtcy5ndWVzdF91YWRkciAmIFBBR0VfTUFT
SywNCisJCQkJICAgIFBBR0VfU0laRSwgJm4sIDApOw0KKwlpZiAoIWd1ZXN0X3BhZ2UpDQorCQln
b3RvIGVfZnJlZTsNCisNCisJZGF0YS0+Z3Vlc3RfYWRkcmVzcyA9IF9fc21lX3BhZ2VfcGEoZ3Vl
c3RfcGFnZVswXSkgKyBvZmZzZXQ7DQorCWRhdGEtPmd1ZXN0X2xlbiA9IHBhcmFtcy5ndWVzdF9s
ZW47DQorDQorCS8qDQorCSAqIFRoZSBTRU5EX1VQREFURV9EQVRBIGNvbW1hbmQgcmVxdWlyZXMg
Qy1iaXQgdG8gYmUgYWx3YXlzIHNldC4NCisJICogVGhlIF9fc21lX3BhZ2VfcGEoKSB0YWtlcyBj
YXJlIG9mIHNldHRpbmcgdGhlIEMtYml0IG9ubHkgd2hlbiBTTUUNCisJICogaXMgZW5hYmxlZCBv
biB0aGUgaG9zdC4gQnV0IHdlIG5lZWQgdG8gc2V0IHRoZSBDLWJpdCByZWdhcmxlc3Mgb2YNCisJ
ICogdGhlIFNNRSBzdGF0ZS4NCisJICovDQorCWRhdGEtPmd1ZXN0X2FkZHJlc3MgfD0gbWVfbWFz
azsNCisNCisJLyogZmx1c2ggdGhlIGNhY2hlcyB0byBlbnN1cmUgdGhhdCBEUkFNIGhhcyByZWNl
bnQgY29udGVudHMgKi8NCisJc2V2X2NsZmx1c2hfcGFnZXMoZ3Vlc3RfcGFnZSwgMSk7DQorDQor
Y21kOg0KKwlkYXRhLT5oYW5kbGUgPSBzZXYtPmhhbmRsZTsNCisJcmV0ID0gc2V2X2lzc3VlX2Nt
ZChrdm0sIFNFVl9DTURfU0VORF9VUERBVEVfREFUQSwgZGF0YSwgJmFyZ3AtPmVycm9yKTsNCisN
CisJLyogdXNlcnNwYWNlIGFza2VkIGZvciBoZWFkZXIgb3IgdHJhbnMgbGVuZ3RoIGFuZCBGVyBy
ZXNwb25kZWQgd2l0aCBkYXRhICovDQorCWlmICghcGFyYW1zLnRyYW5zX2xlbiB8fCAhcGFyYW1z
Lmhkcl9sZW4pIHsNCisJCXBhcmFtcy5oZHJfbGVuID0gZGF0YS0+aGRyX2xlbjsNCisJCXBhcmFt
cy50cmFuc19sZW4gPSBkYXRhLT50cmFuc19sZW47DQorCQlnb3RvIGRvbmU7DQorCX0NCisNCisJ
aWYgKHJldCkNCisJCWdvdG8gZV91bnBpbjsNCisNCisJLyogY29weSB0cmFuc3BvcnQgYnVmZmVy
IHRvIHVzZXIgc3BhY2UgKi8NCisJaWYgKGNvcHlfdG9fdXNlcigodm9pZCBfX3VzZXIgKikodWlu
dHB0cl90KXBhcmFtcy50cmFuc191YWRkciwNCisJCQkgdHJhbnNfZGF0YSwgcGFyYW1zLnRyYW5z
X2xlbikpIHsNCisJCXJldCA9IC1FRkFVTFQ7DQorCQlnb3RvIGVfdW5waW47DQorCX0NCisNCisJ
LyogY29weSBwYWNrZXQgaGVhZGVyIHRvIHVzZXJzcGFjZSAqLw0KKwlpZiAoY29weV90b191c2Vy
KCh2b2lkIF9fdXNlciAqKSh1aW50cHRyX3QpcGFyYW1zLmhkcl91YWRkciwgaGRyLCBwYXJhbXMu
aGRyX2xlbikpDQorCQlyZXQgPSAtRUZBVUxUOw0KKw0KK2VfdW5waW46DQorCXNldl91bnBpbl9t
ZW1vcnkoa3ZtLCBndWVzdF9wYWdlLCBuKTsNCitkb25lOg0KKwlpZiAoY29weV90b191c2VyKCh2
b2lkIF9fdXNlciAqKSh1aW50cHRyX3QpYXJncC0+ZGF0YSwgJnBhcmFtcywNCisJCQlzaXplb2Yo
c3RydWN0IGt2bV9zZXZfc2VuZF91cGRhdGVfZGF0YSkpKQ0KKwkJcmV0ID0gLUVGQVVMVDsNCitl
X2ZyZWU6DQorCWtmcmVlKGRhdGEpOw0KKwlrZnJlZSh0cmFuc19kYXRhKTsNCisJa2ZyZWUoaGRy
KTsNCisNCisJcmV0dXJuIHJldDsNCit9DQorDQogc3RhdGljIGludCBzdm1fbWVtX2VuY19vcChz
dHJ1Y3Qga3ZtICprdm0sIHZvaWQgX191c2VyICphcmdwKQ0KIHsNCiAJc3RydWN0IGt2bV9zZXZf
Y21kIHNldl9jbWQ7DQpAQCAtNzA5Nyw2ICs3MjE2LDkgQEAgc3RhdGljIGludCBzdm1fbWVtX2Vu
Y19vcChzdHJ1Y3Qga3ZtICprdm0sIHZvaWQgX191c2VyICphcmdwKQ0KIAljYXNlIEtWTV9TRVZf
U0VORF9TVEFSVDoNCiAJCXIgPSBzZXZfc2VuZF9zdGFydChrdm0sICZzZXZfY21kKTsNCiAJCWJy
ZWFrOw0KKwljYXNlIEtWTV9TRVZfU0VORF9VUERBVEVfREFUQToNCisJCXIgPSBzZXZfc2VuZF91
cGRhdGVfZGF0YShrdm0sICZzZXZfY21kKTsNCisJCWJyZWFrOw0KIAlkZWZhdWx0Og0KIAkJciA9
IC1FSU5WQUw7DQogCQlnb3RvIG91dDsNCmRpZmYgLS1naXQgYS9pbmNsdWRlL3VhcGkvbGludXgv
a3ZtLmggYi9pbmNsdWRlL3VhcGkvbGludXgva3ZtLmgNCmluZGV4IGY0MjU0MThiZWMxMy4uMGJl
ZTkxYmJhMzI5IDEwMDY0NA0KLS0tIGEvaW5jbHVkZS91YXBpL2xpbnV4L2t2bS5oDQorKysgYi9p
bmNsdWRlL3VhcGkvbGludXgva3ZtLmgNCkBAIC0xNTMyLDYgKzE1MzIsMTUgQEAgc3RydWN0IGt2
bV9zZXZfc2VuZF9zdGFydCB7DQogCV9fdTMyIHNlc3Npb25fbGVuOw0KIH07DQogDQorc3RydWN0
IGt2bV9zZXZfc2VuZF91cGRhdGVfZGF0YSB7DQorCV9fdTY0IGhkcl91YWRkcjsNCisJX191MzIg
aGRyX2xlbjsNCisJX191NjQgZ3Vlc3RfdWFkZHI7DQorCV9fdTMyIGd1ZXN0X2xlbjsNCisJX191
NjQgdHJhbnNfdWFkZHI7DQorCV9fdTMyIHRyYW5zX2xlbjsNCit9Ow0KKw0KICNkZWZpbmUgS1ZN
X0RFVl9BU1NJR05fRU5BQkxFX0lPTU1VCSgxIDw8IDApDQogI2RlZmluZSBLVk1fREVWX0FTU0lH
Tl9QQ0lfMl8zCQkoMSA8PCAxKQ0KICNkZWZpbmUgS1ZNX0RFVl9BU1NJR05fTUFTS19JTlRYCSgx
IDw8IDIpDQotLSANCjIuMTcuMQ0KDQo=

