Return-Path: <SRS0=3XOk=S2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E478C282E1
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 16:15:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B627D218FE
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 16:15:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ki5/DdoM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B627D218FE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44046 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJKYG-0006Nq-Un
	for qemu-devel@archiver.kernel.org; Wed, 24 Apr 2019 12:15:16 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38729)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1hJKTl-0002C7-74
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 12:10:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1hJKTJ-0003gL-Vn
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 12:10:24 -0400
Received: from mail-eopbgr780073.outbound.protection.outlook.com
	([40.107.78.73]:27328
	helo=NAM03-BY2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <brijesh.singh@amd.com>)
	id 1hJKTI-0003PD-06
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 12:10:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=zZ3sHg5rVXb95pzeWo6NWMPvuCsuoJLoZRkItkFdsyw=;
	b=ki5/DdoMSvSyC1rCs8WzZNDUBdXR6x4M4H/T9nagzSETxoxXmkCheaek9A7/sY+ScRe5BQ5D0WCDscAwiwPGNC7/8L2Rx0saQYOB3CYb7ef75neDkCCQMB2FeWrvDB64md5ODH4AGcp/bj5/BXVdhr6EOGyfY0Sjz08+38sMFvg=
Received: from DM6PR12MB2682.namprd12.prod.outlook.com (20.176.116.31) by
	DM6PR12MB2907.namprd12.prod.outlook.com (20.179.71.213) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1835.12; Wed, 24 Apr 2019 16:09:59 +0000
Received: from DM6PR12MB2682.namprd12.prod.outlook.com
	([fe80::9183:846f:a93e:9a43]) by
	DM6PR12MB2682.namprd12.prod.outlook.com
	([fe80::9183:846f:a93e:9a43%5]) with mapi id 15.20.1813.017;
	Wed, 24 Apr 2019 16:09:59 +0000
From: "Singh, Brijesh" <brijesh.singh@amd.com>
To: "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Thread-Topic: [RFC PATCH v1 01/10] KVM: SVM: Add KVM_SEV SEND_START command
Thread-Index: AQHU+rgqsjyUQYD5ekOPbYup8IOCmw==
Date: Wed, 24 Apr 2019 16:09:59 +0000
Message-ID: <20190424160942.13567-2-brijesh.singh@amd.com>
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
x-ms-office365-filtering-correlation-id: d43f2006-999b-4d7e-2da7-08d6c8cf4ce7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);
	SRVR:DM6PR12MB2907; 
x-ms-traffictypediagnostic: DM6PR12MB2907:
x-microsoft-antispam-prvs: <DM6PR12MB290775DC43CC597E294D63C9E53C0@DM6PR12MB2907.namprd12.prod.outlook.com>
x-forefront-prvs: 00179089FD
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10009020)(39860400002)(136003)(366004)(396003)(376002)(346002)(189003)(199004)(1730700003)(99286004)(2501003)(73956011)(478600001)(11346002)(6506007)(76176011)(14454004)(6116002)(52116002)(386003)(476003)(25786009)(66946007)(486006)(4326008)(71200400001)(66446008)(66556008)(3846002)(66476007)(64756008)(1076003)(71190400001)(446003)(186003)(2616005)(5660300002)(2351001)(102836004)(97736004)(26005)(86362001)(6512007)(8676002)(66066001)(8936002)(68736007)(2906002)(50226002)(256004)(81156014)(305945005)(36756003)(316002)(6436002)(54906003)(7736002)(5640700003)(81166006)(53936002)(6916009)(6486002)(7416002);
	DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB2907;
	H:DM6PR12MB2682.namprd12.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 38sUwAsh/EqgRD2Eu6uuMcwJ7h8z0QDY0ShosQ1jH5KtmR/bVt9x0d0/jPqieLZolfeuxDwy6bukVCtTgc5/USpolxc3jhgEoU4LmOevwF7dFJlyBhe5NtGbDyaBUSqP/ojRhMUSN/IiHNzj8JEy2RHP1HBd8iEm/AWLtCgDlHCVzJChy9hFqiXOe1lOqSzc2lfM3q67pFGkni/Hdwbnu7x/l06CnKHTQ22m4TygCsVDQ5PCR9f326Wnkpm7/BDSr6n/azFe9tIEiEh4/9zC+YDoJAPpNJAdXe4DBNSUzSR3Hn0FSO5LL8ZPBXOZx5WICszWa8PN4PbAFbFF/TLthVJwCoCFCca1NG6zZNbkW19HHWApr6ILMujRp00SF8BUvUK0jHLRvyqCnT77hvxRk4g3HJqF/g3oz3PNqdheVRw=
Content-Type: text/plain; charset="UTF-8"
Content-ID: <66B4A891EC049749B58F981AB90A362B@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d43f2006-999b-4d7e-2da7-08d6c8cf4ce7
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2019 16:09:59.8721 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2907
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.78.73
Subject: [Qemu-devel] [RFC PATCH v1 01/10] KVM: SVM: Add KVM_SEV SEND_START
 command
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
Message-ID: <20190424160959.PGSQ3MvNyqdZvvQ3ajf4BaGZ1YvvB-UJLRy3AomJhYk@z>

VGhlIGNvbW1hbmQgaXMgdXNlZCB0byBjcmVhdGUgYW4gb3V0Z29pbmcgU0VWIGd1ZXN0IGVuY3J5
cHRpb24gY29udGV4dC4NCg0KQ2M6IFRob21hcyBHbGVpeG5lciA8dGdseEBsaW51dHJvbml4LmRl
Pg0KQ2M6IEluZ28gTW9sbmFyIDxtaW5nb0ByZWRoYXQuY29tPg0KQ2M6ICJILiBQZXRlciBBbnZp
biIgPGhwYUB6eXRvci5jb20+DQpDYzogUGFvbG8gQm9uemluaSA8cGJvbnppbmlAcmVkaGF0LmNv
bT4NCkNjOiAiUmFkaW0gS3LEjW3DocWZIiA8cmtyY21hckByZWRoYXQuY29tPg0KQ2M6IEpvZXJn
IFJvZWRlbCA8am9yb0A4Ynl0ZXMub3JnPg0KQ2M6IEJvcmlzbGF2IFBldGtvdiA8YnBAc3VzZS5k
ZT4NCkNjOiBUb20gTGVuZGFja3kgPHRob21hcy5sZW5kYWNreUBhbWQuY29tPg0KQ2M6IHg4NkBr
ZXJuZWwub3JnDQpDYzoga3ZtQHZnZXIua2VybmVsLm9yZw0KQ2M6IGxpbnV4LWtlcm5lbEB2Z2Vy
Lmtlcm5lbC5vcmcNClNpZ25lZC1vZmYtYnk6IEJyaWplc2ggU2luZ2ggPGJyaWplc2guc2luZ2hA
YW1kLmNvbT4NCi0tLQ0KIC4uLi92aXJ0dWFsL2t2bS9hbWQtbWVtb3J5LWVuY3J5cHRpb24ucnN0
ICAgICB8ICAyNCArKysrKw0KIGFyY2gveDg2L2t2bS9zdm0uYyAgICAgICAgICAgICAgICAgICAg
ICAgICAgICB8IDEwMSArKysrKysrKysrKysrKysrKysNCiBpbmNsdWRlL3VhcGkvbGludXgva3Zt
LmggICAgICAgICAgICAgICAgICAgICAgfCAgMTIgKysrDQogMyBmaWxlcyBjaGFuZ2VkLCAxMzcg
aW5zZXJ0aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi92aXJ0dWFsL2t2bS9h
bWQtbWVtb3J5LWVuY3J5cHRpb24ucnN0IGIvRG9jdW1lbnRhdGlvbi92aXJ0dWFsL2t2bS9hbWQt
bWVtb3J5LWVuY3J5cHRpb24ucnN0DQppbmRleCA2NTliYmMwOTNiNTIuLjM0MGFjNGY4NzMyMSAx
MDA2NDQNCi0tLSBhL0RvY3VtZW50YXRpb24vdmlydHVhbC9rdm0vYW1kLW1lbW9yeS1lbmNyeXB0
aW9uLnJzdA0KKysrIGIvRG9jdW1lbnRhdGlvbi92aXJ0dWFsL2t2bS9hbWQtbWVtb3J5LWVuY3J5
cHRpb24ucnN0DQpAQCAtMjM4LDYgKzIzOCwzMCBAQCBSZXR1cm5zOiAwIG9uIHN1Y2Nlc3MsIC1u
ZWdhdGl2ZSBvbiBlcnJvcg0KICAgICAgICAgICAgICAgICBfX3UzMiB0cmFuc19sZW47DQogICAg
ICAgICB9Ow0KIA0KKzEwLiBLVk1fU0VWX1NFTkRfU1RBUlQNCistLS0tLS0tLS0tLS0tLS0tLS0t
LS0tDQorDQorVGhlIEtWTV9TRVZfU0VORF9TVEFSVCBjb21tYW5kIGNhbiBiZSB1c2VkIGJ5IHRo
ZSBoeXBlcnZpc29yIHRvIGNyZWF0ZSBhbg0KK291dGdvaW5nIGd1ZXN0IGVuY3J5cHRpb24gY29u
dGV4dC4NCisNCitQYXJhbWV0ZXJzIChpbik6IHN0cnVjdCBrdm1fc2V2X3NlbmRfc3RhcnQNCisN
CitSZXR1cm5zOiAwIG9uIHN1Y2Nlc3MsIC1uZWdhdGl2ZSBvbiBlcnJvcg0KKw0KKzo6DQorICAg
ICAgICBzdHJ1Y3Qga3ZtX3Nldl9zZW5kX3N0YXJ0IHsNCisgICAgICAgICAgICAgICAgX191MzIg
cG9saWN5OyAgICAgICAgICAgICAgICAgLyogZ3Vlc3QgcG9saWN5ICovDQorDQorICAgICAgICAg
ICAgICAgIF9fdTY0IHBkaF9jZXJ0X3VhZGRyOyAgICAgICAgIC8qIHBsYXRmb3JtIERpZmZpZS1I
ZWxsbWFuIGNlcnRpZmljYXRlICovDQorICAgICAgICAgICAgICAgIF9fdTMyIHBkaF9jZXJ0X2xl
bjsNCisNCisgICAgICAgICAgICAgICAgX191NjQgcGxhdF9jZXJ0X3VhZGRyOyAgICAgICAgLyog
cGxhdGZvcm0gY2VydGlmaWNhdGUgY2hhaW4gKi8NCisgICAgICAgICAgICAgICAgX191MzIgcGxh
dF9jZXJ0X2xlbjsNCisNCisgICAgICAgICAgICAgICAgX191NjQgYW1kX2NlcnRfdWFkZHI7ICAg
ICAgICAgLyogQU1EIGNlcnRpZmljYXRlICovDQorICAgICAgICAgICAgICAgIF9fdTMyIGFtZF9j
ZXJ0X2xlbjsNCisgICAgICAgIH07DQorDQogUmVmZXJlbmNlcw0KID09PT09PT09PT0NCiANCmRp
ZmYgLS1naXQgYS9hcmNoL3g4Ni9rdm0vc3ZtLmMgYi9hcmNoL3g4Ni9rdm0vc3ZtLmMNCmluZGV4
IDQwNmI1NThhYmZlZi4uNGMyYTIyNWJhNTQ2IDEwMDY0NA0KLS0tIGEvYXJjaC94ODYva3ZtL3N2
bS5jDQorKysgYi9hcmNoL3g4Ni9rdm0vc3ZtLmMNCkBAIC02OTU1LDYgKzY5NTUsMTA0IEBAIHN0
YXRpYyBpbnQgc2V2X2xhdW5jaF9zZWNyZXQoc3RydWN0IGt2bSAqa3ZtLCBzdHJ1Y3Qga3ZtX3Nl
dl9jbWQgKmFyZ3ApDQogCXJldHVybiByZXQ7DQogfQ0KIA0KK3N0YXRpYyBpbnQgc2V2X3NlbmRf
c3RhcnQoc3RydWN0IGt2bSAqa3ZtLCBzdHJ1Y3Qga3ZtX3Nldl9jbWQgKmFyZ3ApDQorew0KKwlz
dHJ1Y3Qga3ZtX3Nldl9pbmZvICpzZXYgPSAmdG9fa3ZtX3N2bShrdm0pLT5zZXZfaW5mbzsNCisJ
dm9pZCAqYW1kX2NlcnQgPSBOVUxMLCAqc2Vzc2lvbl9kYXRhID0gTlVMTDsNCisJdm9pZCAqcGRo
X2NlcnQgPSBOVUxMLCAqcGxhdF9jZXJ0ID0gTlVMTDsNCisJc3RydWN0IHNldl9kYXRhX3NlbmRf
c3RhcnQgKmRhdGEgPSBOVUxMOw0KKwlzdHJ1Y3Qga3ZtX3Nldl9zZW5kX3N0YXJ0IHBhcmFtczsN
CisJaW50IHJldDsNCisNCisJaWYgKCFzZXZfZ3Vlc3Qoa3ZtKSkNCisJCXJldHVybiAtRU5PVFRZ
Ow0KKw0KKwlpZiAoY29weV9mcm9tX3VzZXIoJnBhcmFtcywgKHZvaWQgX191c2VyICopKHVpbnRw
dHJfdClhcmdwLT5kYXRhLA0KKwkJCQlzaXplb2Yoc3RydWN0IGt2bV9zZXZfc2VuZF9zdGFydCkp
KQ0KKwkJcmV0dXJuIC1FRkFVTFQ7DQorDQorCWRhdGEgPSBremFsbG9jKHNpemVvZigqZGF0YSks
IEdGUF9LRVJORUwpOw0KKwlpZiAoIWRhdGEpDQorCQlyZXR1cm4gLUVOT01FTTsNCisNCisJLyog
dXNlcnNwYWNlIHdhbnRzIHRvIHF1ZXJ5IHRoZSBzZXNzaW9uIGxlbmd0aCAqLw0KKwlpZiAoIXBh
cmFtcy5zZXNzaW9uX2xlbikNCisJCWdvdG8gY21kOw0KKw0KKwlpZiAoIXBhcmFtcy5wZGhfY2Vy
dF91YWRkciB8fCAhcGFyYW1zLnBkaF9jZXJ0X2xlbiB8fA0KKwkgICAgIXBhcmFtcy5zZXNzaW9u
X3VhZGRyKQ0KKwkJcmV0dXJuIC1FSU5WQUw7DQorDQorCS8qIGNvcHkgdGhlIGNlcnRpZmljYXRl
IGJsb2JzIGZyb20gdXNlcnNwYWNlICovDQorCXBkaF9jZXJ0ID0gcHNwX2NvcHlfdXNlcl9ibG9i
KHBhcmFtcy5wZGhfY2VydF91YWRkciwgcGFyYW1zLnBkaF9jZXJ0X2xlbik7DQorCWlmIChJU19F
UlIocGRoX2NlcnQpKSB7DQorCQlyZXQgPSBQVFJfRVJSKHBkaF9jZXJ0KTsNCisJCWdvdG8gZV9m
cmVlOw0KKwl9DQorDQorCWRhdGEtPnBkaF9jZXJ0X2FkZHJlc3MgPSBfX3BzcF9wYShwZGhfY2Vy
dCk7DQorCWRhdGEtPnBkaF9jZXJ0X2xlbiA9IHBhcmFtcy5wZGhfY2VydF9sZW47DQorDQorCXBs
YXRfY2VydCA9IHBzcF9jb3B5X3VzZXJfYmxvYihwYXJhbXMucGxhdF9jZXJ0X3VhZGRyLCBwYXJh
bXMucGxhdF9jZXJ0X2xlbik7DQorCWlmIChJU19FUlIocGxhdF9jZXJ0KSkgew0KKwkJcmV0ID0g
UFRSX0VSUihwbGF0X2NlcnQpOw0KKwkJZ290byBlX2ZyZWVfcGRoOw0KKwl9DQorDQorCWRhdGEt
PnBsYXRfY2VydF9hZGRyZXNzID0gX19wc3BfcGEocGxhdF9jZXJ0KTsNCisJZGF0YS0+cGxhdF9j
ZXJ0X2xlbiA9IHBhcmFtcy5wbGF0X2NlcnRfbGVuOw0KKw0KKwlhbWRfY2VydCA9IHBzcF9jb3B5
X3VzZXJfYmxvYihwYXJhbXMuYW1kX2NlcnRfdWFkZHIsIHBhcmFtcy5hbWRfY2VydF9sZW4pOw0K
KwlpZiAoSVNfRVJSKGFtZF9jZXJ0KSkgew0KKwkJcmV0ID0gUFRSX0VSUihhbWRfY2VydCk7DQor
CQlnb3RvIGVfZnJlZV9wbGF0X2NlcnQ7DQorCX0NCisNCisJZGF0YS0+YW1kX2NlcnRfYWRkcmVz
cyA9IF9fcHNwX3BhKGFtZF9jZXJ0KTsNCisJZGF0YS0+YW1kX2NlcnRfbGVuID0gcGFyYW1zLmFt
ZF9jZXJ0X2xlbjsNCisNCisJcmV0ID0gLUVOT01FTTsNCisJc2Vzc2lvbl9kYXRhID0ga21hbGxv
YyhwYXJhbXMuc2Vzc2lvbl9sZW4sIEdGUF9LRVJORUwpOw0KKwlpZiAoIXNlc3Npb25fZGF0YSkN
CisJCWdvdG8gZV9mcmVlX2FtZF9jZXJ0Ow0KKw0KKwlkYXRhLT5zZXNzaW9uX2FkZHJlc3MgPSBf
X3BzcF9wYShzZXNzaW9uX2RhdGEpOw0KKwlkYXRhLT5zZXNzaW9uX2xlbiA9IHBhcmFtcy5zZXNz
aW9uX2xlbjsNCitjbWQ6DQorCWRhdGEtPmhhbmRsZSA9IHNldi0+aGFuZGxlOw0KKwlyZXQgPSBz
ZXZfaXNzdWVfY21kKGt2bSwgU0VWX0NNRF9TRU5EX1NUQVJULCBkYXRhLCAmYXJncC0+ZXJyb3Ip
Ow0KKw0KKwkvKiBpZiB3ZSBxdWVyaWVkIHRoZSBzZXNzaW9uIGxlbmd0aCwgRlcgcmVzcG9uZGVk
IHdpdGggZXhwZWN0ZWQgZGF0YSAqLw0KKwlpZiAoIXBhcmFtcy5zZXNzaW9uX2xlbikNCisJCWdv
dG8gZG9uZTsNCisNCisJaWYgKGNvcHlfdG9fdXNlcigodm9pZCBfX3VzZXIgKikodWludHB0cl90
KSBwYXJhbXMuc2Vzc2lvbl91YWRkciwNCisJCQlzZXNzaW9uX2RhdGEsIHBhcmFtcy5zZXNzaW9u
X2xlbikpIHsNCisJCXJldCA9IC1FRkFVTFQ7DQorCQlnb3RvIGVfZnJlZV9zZXNzaW9uOw0KKwl9
DQorDQorCXBhcmFtcy5wb2xpY3kgPSBkYXRhLT5wb2xpY3k7DQorDQorZG9uZToNCisJcGFyYW1z
LnNlc3Npb25fbGVuID0gZGF0YS0+c2Vzc2lvbl9sZW47DQorCWlmIChjb3B5X3RvX3VzZXIoKHZv
aWQgX191c2VyICopKHVpbnRwdHJfdClhcmdwLT5kYXRhLCAmcGFyYW1zLA0KKwkJCQlzaXplb2Yo
c3RydWN0IGt2bV9zZXZfc2VuZF9zdGFydCkpKQ0KKwkJcmV0ID0gLUVGQVVMVDsNCisNCitlX2Zy
ZWVfc2Vzc2lvbjoNCisJa2ZyZWUoc2Vzc2lvbl9kYXRhKTsNCitlX2ZyZWVfYW1kX2NlcnQ6DQor
CWtmcmVlKGFtZF9jZXJ0KTsNCitlX2ZyZWVfcGxhdF9jZXJ0Og0KKwlrZnJlZShwbGF0X2NlcnQp
Ow0KK2VfZnJlZV9wZGg6DQorCWtmcmVlKHBkaF9jZXJ0KTsNCitlX2ZyZWU6DQorCWtmcmVlKGRh
dGEpOw0KKwlyZXR1cm4gcmV0Ow0KK30NCisNCiBzdGF0aWMgaW50IHN2bV9tZW1fZW5jX29wKHN0
cnVjdCBrdm0gKmt2bSwgdm9pZCBfX3VzZXIgKmFyZ3ApDQogew0KIAlzdHJ1Y3Qga3ZtX3Nldl9j
bWQgc2V2X2NtZDsNCkBAIC02OTk2LDYgKzcwOTQsOSBAQCBzdGF0aWMgaW50IHN2bV9tZW1fZW5j
X29wKHN0cnVjdCBrdm0gKmt2bSwgdm9pZCBfX3VzZXIgKmFyZ3ApDQogCWNhc2UgS1ZNX1NFVl9M
QVVOQ0hfU0VDUkVUOg0KIAkJciA9IHNldl9sYXVuY2hfc2VjcmV0KGt2bSwgJnNldl9jbWQpOw0K
IAkJYnJlYWs7DQorCWNhc2UgS1ZNX1NFVl9TRU5EX1NUQVJUOg0KKwkJciA9IHNldl9zZW5kX3N0
YXJ0KGt2bSwgJnNldl9jbWQpOw0KKwkJYnJlYWs7DQogCWRlZmF1bHQ6DQogCQlyID0gLUVJTlZB
TDsNCiAJCWdvdG8gb3V0Ow0KZGlmZiAtLWdpdCBhL2luY2x1ZGUvdWFwaS9saW51eC9rdm0uaCBi
L2luY2x1ZGUvdWFwaS9saW51eC9rdm0uaA0KaW5kZXggNmQ0ZWE0YjZjOTIyLi5mNDI1NDE4YmVj
MTMgMTAwNjQ0DQotLS0gYS9pbmNsdWRlL3VhcGkvbGludXgva3ZtLmgNCisrKyBiL2luY2x1ZGUv
dWFwaS9saW51eC9rdm0uaA0KQEAgLTE1MjAsNiArMTUyMCwxOCBAQCBzdHJ1Y3Qga3ZtX3Nldl9k
Ymcgew0KIAlfX3UzMiBsZW47DQogfTsNCiANCitzdHJ1Y3Qga3ZtX3Nldl9zZW5kX3N0YXJ0IHsN
CisJX191MzIgcG9saWN5Ow0KKwlfX3U2NCBwZGhfY2VydF91YWRkcjsNCisJX191MzIgcGRoX2Nl
cnRfbGVuOw0KKwlfX3U2NCBwbGF0X2NlcnRfdWFkZHI7DQorCV9fdTMyIHBsYXRfY2VydF9sZW47
DQorCV9fdTY0IGFtZF9jZXJ0X3VhZGRyOw0KKwlfX3UzMiBhbWRfY2VydF9sZW47DQorCV9fdTY0
IHNlc3Npb25fdWFkZHI7DQorCV9fdTMyIHNlc3Npb25fbGVuOw0KK307DQorDQogI2RlZmluZSBL
Vk1fREVWX0FTU0lHTl9FTkFCTEVfSU9NTVUJKDEgPDwgMCkNCiAjZGVmaW5lIEtWTV9ERVZfQVNT
SUdOX1BDSV8yXzMJCSgxIDw8IDEpDQogI2RlZmluZSBLVk1fREVWX0FTU0lHTl9NQVNLX0lOVFgJ
KDEgPDwgMikNCi0tIA0KMi4xNy4xDQoNCg==

