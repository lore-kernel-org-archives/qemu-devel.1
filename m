Return-Path: <SRS0=3XOk=S2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40008C282CE
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 16:17:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAA6C208E4
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 16:17:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="V3vC9EjO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAA6C208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44106 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJKaq-00017z-6b
	for qemu-devel@archiver.kernel.org; Wed, 24 Apr 2019 12:17:56 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38740)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1hJKTn-0002DU-6W
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 12:10:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1hJKTP-0003sd-Pp
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 12:10:30 -0400
Received: from mail-eopbgr710060.outbound.protection.outlook.com
	([40.107.71.60]:21343
	helo=NAM05-BY2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <brijesh.singh@amd.com>)
	id 1hJKTN-0003lK-Uc
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 12:10:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=82sYA5FglOWsrg0DbVYRMp15GvBNRUbGrkkGiH2XfkU=;
	b=V3vC9EjObSxuZF2srPCHroNxg3y7YffZ2HNYYrb6JqlfLoCW/SEQaRqp8tmgad7gmz6gczxiaNSjnx1jcqmNIZpd7z8TuSZeNhMx+6fpiVSmiGsVeALV8T5l5CsNGb0ukRKSv+CwxQJEAFFq7wJyVVMreJHWZNz9x4nqsZcXdbQ=
Received: from DM6PR12MB2682.namprd12.prod.outlook.com (20.176.116.31) by
	DM6PR12MB3212.namprd12.prod.outlook.com (20.179.105.76) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1835.12; Wed, 24 Apr 2019 16:10:10 +0000
Received: from DM6PR12MB2682.namprd12.prod.outlook.com
	([fe80::9183:846f:a93e:9a43]) by
	DM6PR12MB2682.namprd12.prod.outlook.com
	([fe80::9183:846f:a93e:9a43%5]) with mapi id 15.20.1813.017;
	Wed, 24 Apr 2019 16:10:10 +0000
From: "Singh, Brijesh" <brijesh.singh@amd.com>
To: "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Thread-Topic: [RFC PATCH v1 09/10] KVM: x86: Introduce KVM_GET_PAGE_ENC_BITMAP
	ioctl
Thread-Index: AQHU+rgwNLa7fwTWiki9QPhUKWpx/Q==
Date: Wed, 24 Apr 2019 16:10:10 +0000
Message-ID: <20190424160942.13567-10-brijesh.singh@amd.com>
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
x-ms-office365-filtering-correlation-id: 200eb3ae-a45e-485a-b0d5-08d6c8cf534e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);
	SRVR:DM6PR12MB3212; 
x-ms-traffictypediagnostic: DM6PR12MB3212:
x-microsoft-antispam-prvs: <DM6PR12MB3212946F9BAD18FE243AFEA6E53C0@DM6PR12MB3212.namprd12.prod.outlook.com>
x-forefront-prvs: 00179089FD
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10009020)(396003)(136003)(376002)(39860400002)(366004)(346002)(199004)(189003)(6436002)(476003)(5640700003)(66556008)(66066001)(102836004)(6512007)(386003)(6506007)(6116002)(3846002)(6916009)(76176011)(2616005)(486006)(5660300002)(446003)(86362001)(97736004)(26005)(2501003)(11346002)(6486002)(186003)(2351001)(53936002)(14454004)(256004)(14444005)(36756003)(4326008)(54906003)(2906002)(25786009)(50226002)(68736007)(7416002)(8936002)(66476007)(99286004)(52116002)(81166006)(81156014)(73956011)(1076003)(8676002)(305945005)(1730700003)(71200400001)(66946007)(7736002)(66574012)(478600001)(316002)(64756008)(66446008)(71190400001);
	DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3212;
	H:DM6PR12MB2682.namprd12.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: tZZ/ByTmIGPysF3Y+0zu5F+xA2EIoRpOde/usZO/oTqiuG/7FncCdqHl5G/6nsiX5LfywmnClzhwbvrAF/UB9htik9mD5PPyNZJCAjUavUXwN5zyB2JEEl0ZA2pOeuhspXRRW4GBiTM34fJ0WnWO6hUITpSnbKkMKdYQ8fDhEV6yeeyqCNsfEstPPwW4nNHsW2oxK2MBc6xW2NBhOqV140ZIBMWoQGkeNBdNkwyIR7ptdq5zLRxcgje8fLUvw3m5SrY/byPBuYqokebOW1rqG9eK058GpmaEpcwETbdqvy5TjrBh6P+6EJzzjEzesiMci7mJzjayDnI19FRmtZbf5k5xbTnrflshMLGdg44y+5NV971ruydVFyCCfjTtCWgBmJVR202zYiWa72eQZGGOXBfsBWsTXf83O6fy7Vt3aYo=
Content-Type: text/plain; charset="UTF-8"
Content-ID: <2EB5FEF7F66F974FA3F26867EDA5F475@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 200eb3ae-a45e-485a-b0d5-08d6c8cf534e
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2019 16:10:10.4167 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3212
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.71.60
Subject: [Qemu-devel] [RFC PATCH v1 09/10] KVM: x86: Introduce
 KVM_GET_PAGE_ENC_BITMAP ioctl
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
Message-ID: <20190424161010.Qci6BHMWHjkmBHgilbHGqulx_crV7NEg59MlIS-1V9A@z>

VGhlIGlvY3RsIGNhbiBiZSB1c2VkIHRvIHJldHJpZXZlIHBhZ2UgZW5jcnlwdGlvbiBiaXRtYXAg
Zm9yIGEgZ2l2ZW4NCmt2bSBtZW1vcnkgc2xvdC4NCg0KQ2M6IFRob21hcyBHbGVpeG5lciA8dGds
eEBsaW51dHJvbml4LmRlPg0KQ2M6IEluZ28gTW9sbmFyIDxtaW5nb0ByZWRoYXQuY29tPg0KQ2M6
ICJILiBQZXRlciBBbnZpbiIgPGhwYUB6eXRvci5jb20+DQpDYzogUGFvbG8gQm9uemluaSA8cGJv
bnppbmlAcmVkaGF0LmNvbT4NCkNjOiAiUmFkaW0gS3LEjW3DocWZIiA8cmtyY21hckByZWRoYXQu
Y29tPg0KQ2M6IEpvZXJnIFJvZWRlbCA8am9yb0A4Ynl0ZXMub3JnPg0KQ2M6IEJvcmlzbGF2IFBl
dGtvdiA8YnBAc3VzZS5kZT4NCkNjOiBUb20gTGVuZGFja3kgPHRob21hcy5sZW5kYWNreUBhbWQu
Y29tPg0KQ2M6IHg4NkBrZXJuZWwub3JnDQpDYzoga3ZtQHZnZXIua2VybmVsLm9yZw0KQ2M6IGxp
bnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNClNpZ25lZC1vZmYtYnk6IEJyaWplc2ggU2luZ2gg
PGJyaWplc2guc2luZ2hAYW1kLmNvbT4NCi0tLQ0KIGFyY2gveDg2L2luY2x1ZGUvYXNtL2t2bV9o
b3N0LmggfCAgMSArDQogYXJjaC94ODYva3ZtL3N2bS5jICAgICAgICAgICAgICB8IDU0ICsrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrLQ0KIGFyY2gveDg2L2t2bS94ODYuYyAgICAgICAg
ICAgICAgfCAxMiArKysrKysrKw0KIGluY2x1ZGUvdWFwaS9saW51eC9rdm0uaCAgICAgICAgfCAx
MiArKysrKysrKw0KIDQgZmlsZXMgY2hhbmdlZCwgNzggaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlv
bigtKQ0KDQpkaWZmIC0tZ2l0IGEvYXJjaC94ODYvaW5jbHVkZS9hc20va3ZtX2hvc3QuaCBiL2Fy
Y2gveDg2L2luY2x1ZGUvYXNtL2t2bV9ob3N0LmgNCmluZGV4IGFkYjBjYTAzNWI5Ny4uOTk0N2M0
YmU4MjVkIDEwMDY0NA0KLS0tIGEvYXJjaC94ODYvaW5jbHVkZS9hc20va3ZtX2hvc3QuaA0KKysr
IGIvYXJjaC94ODYvaW5jbHVkZS9hc20va3ZtX2hvc3QuaA0KQEAgLTExOTgsNiArMTE5OCw3IEBA
IHN0cnVjdCBrdm1feDg2X29wcyB7DQogCWJvb2wgKCpuZWVkX2VtdWxhdGlvbl9vbl9wYWdlX2Zh
dWx0KShzdHJ1Y3Qga3ZtX3ZjcHUgKnZjcHUpOw0KIAlpbnQgKCpwYWdlX2VuY19zdGF0dXNfaGMp
KHN0cnVjdCBrdm0gKmt2bSwgdW5zaWduZWQgbG9uZyBncGEsDQogCQkJCSAgdW5zaWduZWQgbG9u
ZyBzeiwgdW5zaWduZWQgbG9uZyBtb2RlKTsNCisJaW50ICgqZ2V0X3BhZ2VfZW5jX2JpdG1hcCko
c3RydWN0IGt2bSAqa3ZtLCBzdHJ1Y3Qga3ZtX3BhZ2VfZW5jX2JpdG1hcCAqYm1hcCk7DQogfTsN
CiANCiBzdHJ1Y3Qga3ZtX2FyY2hfYXN5bmNfcGYgew0KZGlmZiAtLWdpdCBhL2FyY2gveDg2L2t2
bS9zdm0uYyBiL2FyY2gveDg2L2t2bS9zdm0uYw0KaW5kZXggZjAyNGYyMDhiMDUyLi5mMzg2ZDcy
YzkyOWIgMTAwNjQ0DQotLS0gYS9hcmNoL3g4Ni9rdm0vc3ZtLmMNCisrKyBiL2FyY2gveDg2L2t2
bS9zdm0uYw0KQEAgLTc0MzcsNiArNzQzNyw1NyBAQCBzdGF0aWMgaW50IHN2bV9wYWdlX2VuY19z
dGF0dXNfaGMoc3RydWN0IGt2bSAqa3ZtLCB1bnNpZ25lZCBsb25nIGdwYSwNCiAJcmV0dXJuIHI7
DQogfQ0KIA0KK3N0YXRpYyBpbnQgc3ZtX2dldF9wYWdlX2VuY19iaXRtYXAoc3RydWN0IGt2bSAq
a3ZtLA0KKwkJCQkgICBzdHJ1Y3Qga3ZtX3BhZ2VfZW5jX2JpdG1hcCAqYm1hcCkNCit7DQorCXN0
cnVjdCBrdm1fc2V2X2luZm8gKnNldiA9ICZ0b19rdm1fc3ZtKGt2bSktPnNldl9pbmZvOw0KKwl1
bnNpZ25lZCBsb25nIGdmbl9zdGFydCwgZ2ZuX2VuZDsNCisJc3RydWN0IGt2bV9tZW1vcnlfc2xv
dCAqbWVtc2xvdDsNCisJc3RydWN0IGt2bV9tZW1zbG90cyAqc2xvdHM7DQorCXVuc2lnbmVkIGxv
bmcgKmJpdG1hcDsNCisJdW5zaWduZWQgbG9uZyBzeiwgaTsNCisJaW50IHJldCwgYXNfaWQsIGlk
Ow0KKw0KKwlpZiAoIXNldl9ndWVzdChrdm0pKQ0KKwkJcmV0dXJuIC1FTk9UVFk7DQorDQorCWFz
X2lkID0gYm1hcC0+c2xvdCA+PiAxNjsNCisJaWQgPSAodTE2KWJtYXAtPnNsb3Q7DQorCWlmIChh
c19pZCA+PSBLVk1fQUREUkVTU19TUEFDRV9OVU0gfHwgaWQgPj0gS1ZNX1VTRVJfTUVNX1NMT1RT
KQ0KKwkJcmV0dXJuIC1FSU5WQUw7DQorDQorCXNsb3RzID0gX19rdm1fbWVtc2xvdHMoa3ZtLCBh
c19pZCk7DQorCW1lbXNsb3QgPSBpZF90b19tZW1zbG90KHNsb3RzLCBpZCk7DQorDQorCWdmbl9z
dGFydCA9IG1lbXNsb3QtPmJhc2VfZ2ZuOw0KKwlnZm5fZW5kID0gZ2ZuX3N0YXJ0ICsgbWVtc2xv
dC0+bnBhZ2VzOw0KKw0KKwlzeiA9IEFMSUdOKG1lbXNsb3QtPm5wYWdlcywgQklUU19QRVJfTE9O
RykgLyA4Ow0KKwliaXRtYXAgPSBrbWFsbG9jKHN6LCBHRlBfS0VSTkVMKTsNCisJaWYgKCFiaXRt
YXApDQorCQlyZXR1cm4gLUVOT01FTTsNCisNCisJbWVtc2V0KGJpdG1hcCwgMHhmZiwgc3opOyAv
KiBieSBkZWZhdWx0IGFsbCBwYWdlcyBhcmUgbWFya2VkIGVuY3J5cHRlZCAqLw0KKw0KKwltdXRl
eF9sb2NrKCZrdm0tPmxvY2spOw0KKwlpZiAoc2V2LT5wYWdlX2VuY19ibWFwKSB7DQorCQlpID0g
Z2ZuX3N0YXJ0Ow0KKwkJZm9yX2VhY2hfY2xlYXJfYml0X2Zyb20oaSwgc2V2LT5wYWdlX2VuY19i
bWFwLA0KKwkJCQkgICAgICBtaW4oc2V2LT5wYWdlX2VuY19ibWFwX3NpemUsIGdmbl9lbmQpKQ0K
KwkJCWNsZWFyX2JpdChpIC0gZ2ZuX3N0YXJ0LCBiaXRtYXApOw0KKwl9DQorCW11dGV4X3VubG9j
aygma3ZtLT5sb2NrKTsNCisNCisJcmV0ID0gLUVGQVVMVDsNCisJaWYgKGNvcHlfdG9fdXNlcihi
bWFwLT5lbmNfYml0bWFwLCBiaXRtYXAsIHN6KSkNCisJCWdvdG8gb3V0Ow0KKw0KKwlyZXQgPSAw
Ow0KK291dDoNCisJa2ZyZWUoYml0bWFwKTsNCisJcmV0dXJuIHJldDsNCit9DQorDQogc3RhdGlj
IGludCBzdm1fbWVtX2VuY19vcChzdHJ1Y3Qga3ZtICprdm0sIHZvaWQgX191c2VyICphcmdwKQ0K
IHsNCiAJc3RydWN0IGt2bV9zZXZfY21kIHNldl9jbWQ7DQpAQCAtNzc3OSw3ICs3ODMwLDggQEAg
c3RhdGljIHN0cnVjdCBrdm1feDg2X29wcyBzdm1feDg2X29wcyBfX3JvX2FmdGVyX2luaXQgPSB7
DQogDQogCS5uZWVkX2VtdWxhdGlvbl9vbl9wYWdlX2ZhdWx0ID0gc3ZtX25lZWRfZW11bGF0aW9u
X29uX3BhZ2VfZmF1bHQsDQogDQotCS5wYWdlX2VuY19zdGF0dXNfaGMgPSBzdm1fcGFnZV9lbmNf
c3RhdHVzX2hjDQorCS5wYWdlX2VuY19zdGF0dXNfaGMgPSBzdm1fcGFnZV9lbmNfc3RhdHVzX2hj
LA0KKwkuZ2V0X3BhZ2VfZW5jX2JpdG1hcCA9IHN2bV9nZXRfcGFnZV9lbmNfYml0bWFwDQogfTsN
CiANCiBzdGF0aWMgaW50IF9faW5pdCBzdm1faW5pdCh2b2lkKQ0KZGlmZiAtLWdpdCBhL2FyY2gv
eDg2L2t2bS94ODYuYyBiL2FyY2gveDg2L2t2bS94ODYuYw0KaW5kZXggZGVhNjQ0YmU1OTkyLi40
NDA3OTk3OWIxYzUgMTAwNjQ0DQotLS0gYS9hcmNoL3g4Ni9rdm0veDg2LmMNCisrKyBiL2FyY2gv
eDg2L2t2bS94ODYuYw0KQEAgLTQ4ODIsNiArNDg4MiwxOCBAQCBsb25nIGt2bV9hcmNoX3ZtX2lv
Y3RsKHN0cnVjdCBmaWxlICpmaWxwLA0KIAkJciA9IGt2bV92bV9pb2N0bF9odl9ldmVudGZkKGt2
bSwgJmh2ZXZmZCk7DQogCQlicmVhazsNCiAJfQ0KKwljYXNlIEtWTV9HRVRfUEFHRV9FTkNfQklU
TUFQOiB7DQorCQlzdHJ1Y3Qga3ZtX3BhZ2VfZW5jX2JpdG1hcCBiaXRtYXA7DQorDQorCQlyID0g
LUVGQVVMVDsNCisJCWlmIChjb3B5X2Zyb21fdXNlcigmYml0bWFwLCBhcmdwLCBzaXplb2YoYml0
bWFwKSkpDQorCQkJZ290byBvdXQ7DQorDQorCQlyID0gLUVOT1RUWTsNCisJCWlmIChrdm1feDg2
X29wcy0+Z2V0X3BhZ2VfZW5jX2JpdG1hcCkNCisJCQlyID0ga3ZtX3g4Nl9vcHMtPmdldF9wYWdl
X2VuY19iaXRtYXAoa3ZtLCAmYml0bWFwKTsNCisJCWJyZWFrOw0KKwl9DQogCWRlZmF1bHQ6DQog
CQlyID0gLUVOT1RUWTsNCiAJfQ0KZGlmZiAtLWdpdCBhL2luY2x1ZGUvdWFwaS9saW51eC9rdm0u
aCBiL2luY2x1ZGUvdWFwaS9saW51eC9rdm0uaA0KaW5kZXggMDdlMDU4YTNlYzExLi43Zjk0NGQ0
ZTI1MmMgMTAwNjQ0DQotLS0gYS9pbmNsdWRlL3VhcGkvbGludXgva3ZtLmgNCisrKyBiL2luY2x1
ZGUvdWFwaS9saW51eC9rdm0uaA0KQEAgLTQ5Miw2ICs0OTIsMTYgQEAgc3RydWN0IGt2bV9kaXJ0
eV9sb2cgew0KIAl9Ow0KIH07DQogDQorLyogZm9yIEtWTV9HRVRfUEFHRV9FTkNfQklUTUFQICov
DQorc3RydWN0IGt2bV9wYWdlX2VuY19iaXRtYXAgew0KKwlfX3UzMiBzbG90Ow0KKwlfX3UzMiBw
YWRkaW5nMTsNCisJdW5pb24gew0KKwkJdm9pZCBfX3VzZXIgKmVuY19iaXRtYXA7IC8qIG9uZSBi
aXQgcGVyIHBhZ2UgKi8NCisJCV9fdTY0IHBhZGRpbmcyOw0KKwl9Ow0KK307DQorDQogLyogZm9y
IEtWTV9DTEVBUl9ESVJUWV9MT0cgKi8NCiBzdHJ1Y3Qga3ZtX2NsZWFyX2RpcnR5X2xvZyB7DQog
CV9fdTMyIHNsb3Q7DQpAQCAtMTQ0MCw2ICsxNDUwLDggQEAgc3RydWN0IGt2bV9lbmNfcmVnaW9u
IHsNCiAvKiBBdmFpbGFibGUgd2l0aCBLVk1fQ0FQX0hZUEVSVl9DUFVJRCAqLw0KICNkZWZpbmUg
S1ZNX0dFVF9TVVBQT1JURURfSFZfQ1BVSUQgX0lPV1IoS1ZNSU8sIDB4YzEsIHN0cnVjdCBrdm1f
Y3B1aWQyKQ0KIA0KKyNkZWZpbmUgS1ZNX0dFVF9QQUdFX0VOQ19CSVRNQVAJX0lPVyhLVk1JTywg
MHhjMiwgc3RydWN0IGt2bV9wYWdlX2VuY19iaXRtYXApDQorDQogLyogU2VjdXJlIEVuY3J5cHRl
ZCBWaXJ0dWFsaXphdGlvbiBjb21tYW5kICovDQogZW51bSBzZXZfY21kX2lkIHsNCiAJLyogR3Vl
c3QgaW5pdGlhbGl6YXRpb24gY29tbWFuZHMgKi8NCi0tIA0KMi4xNy4xDQoNCg==

