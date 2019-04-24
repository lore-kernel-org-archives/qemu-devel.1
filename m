Return-Path: <SRS0=3XOk=S2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E654C10F11
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 16:12:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35410208E4
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 16:12:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="eR12Hfnw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35410208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44017 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJKVh-0003aF-BH
	for qemu-devel@archiver.kernel.org; Wed, 24 Apr 2019 12:12:37 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38746)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1hJKTn-0002Dc-7j
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 12:10:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1hJKTU-0003y1-MW
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 12:10:34 -0400
Received: from mail-eopbgr780073.outbound.protection.outlook.com
	([40.107.78.73]:27328
	helo=NAM03-BY2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <brijesh.singh@amd.com>)
	id 1hJKTS-0003PD-FM
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 12:10:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=dt04xiqmlGp1YsYqoGTONzn4VfXThk4QE7ccUMPFe8s=;
	b=eR12Hfnw1rvARls3qFebobNa44lIk3YznCyWtEuzXtJOPRbYwFxYBWbC8Xad+xhfr52mIdq+kCAAI3/XiMBsNXu8XWl5E8cdCyW2HVBfnRlGJvKJu6mKnj0KeEozvrcr5dX1vlRJkFGXBmYMZOZmTQuzdV5w3e4VP7xeReyp7N8=
Received: from DM6PR12MB2682.namprd12.prod.outlook.com (20.176.116.31) by
	DM6PR12MB2907.namprd12.prod.outlook.com (20.179.71.213) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1835.12; Wed, 24 Apr 2019 16:10:04 +0000
Received: from DM6PR12MB2682.namprd12.prod.outlook.com
	([fe80::9183:846f:a93e:9a43]) by
	DM6PR12MB2682.namprd12.prod.outlook.com
	([fe80::9183:846f:a93e:9a43%5]) with mapi id 15.20.1813.017;
	Wed, 24 Apr 2019 16:10:04 +0000
From: "Singh, Brijesh" <brijesh.singh@amd.com>
To: "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Thread-Topic: [RFC PATCH v1 04/10] KVM: SVM: Add support for
	KVM_SEV_RECEIVE_START command
Thread-Index: AQHU+rgtPINgrzeHlEmNAR52bb0//w==
Date: Wed, 24 Apr 2019 16:10:03 +0000
Message-ID: <20190424160942.13567-5-brijesh.singh@amd.com>
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
x-ms-office365-filtering-correlation-id: 660ccdb4-dd77-461b-bd12-08d6c8cf4f72
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);
	SRVR:DM6PR12MB2907; 
x-ms-traffictypediagnostic: DM6PR12MB2907:
x-microsoft-antispam-prvs: <DM6PR12MB2907D6480DB9B6557A3B405DE53C0@DM6PR12MB2907.namprd12.prod.outlook.com>
x-forefront-prvs: 00179089FD
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10009020)(39860400002)(136003)(366004)(396003)(376002)(346002)(189003)(199004)(1730700003)(99286004)(2501003)(73956011)(478600001)(11346002)(6506007)(76176011)(14454004)(6116002)(52116002)(386003)(476003)(25786009)(66946007)(486006)(4326008)(71200400001)(66446008)(66556008)(3846002)(66476007)(64756008)(1076003)(66574012)(71190400001)(446003)(186003)(2616005)(5660300002)(2351001)(102836004)(97736004)(26005)(14444005)(86362001)(6512007)(8676002)(66066001)(8936002)(68736007)(2906002)(50226002)(256004)(81156014)(305945005)(36756003)(316002)(6436002)(54906003)(7736002)(5640700003)(81166006)(53936002)(6916009)(6486002)(7416002);
	DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB2907;
	H:DM6PR12MB2682.namprd12.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 9o8uv5pHmmeSWQSGDjVpDPrNG970EFQ6eSHD38oNKA9kelFU6tLpK1Cu6r7r3rIE1vTDgrgCBGO09MrVYlb7X1zbeS7pHncb5OTOz08803ATG9QBb1RT1cvu+GKJo6algPK4BX+trtgDxgwdkZoW4t6Tqf9sag/z3A8izBqQg4poGT3cmcfe07Nuu4+isYOMUuT3XYZpYegEocnSZS4DdcTQTgp0Hb55tiVtiAXZ1uKpXYq2dtggYxj+7yxHuqQ1MZvk+yPYXnIfC83odl+bUVtviaR5O3x8UwKnXDavwHQGPcq6BxdVYAiLsCasZp+mNl+YrNfdHEi2JMTM/2cbQUXGeuqAwAXudremzEj8FY7BaiPBISAPCVMjtmdxWq4zJGeRPTA5aeZV4a7QQNu8mVnMsLrwyJXl0aQX8wks+fY=
Content-Type: text/plain; charset="UTF-8"
Content-ID: <16FC0C507B7DFD4AA54FD9B66F0E83B8@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 660ccdb4-dd77-461b-bd12-08d6c8cf4f72
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2019 16:10:04.1102 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2907
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.78.73
Subject: [Qemu-devel] [RFC PATCH v1 04/10] KVM: SVM: Add support for
 KVM_SEV_RECEIVE_START command
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
Message-ID: <20190424161003.jlD3vFKSt8x5K1uN-nQ0H7YnoDLWS_rgBExmxrBbJSA@z>

VGhlIGNvbW1hbmQgaXMgdXNlZCB0byBjcmVhdGUgZW5jcnlwdGlvbiBjb250ZXh0IGZvciB0aGUg
aW5jb21pbmcNClNFViBndWVzdC4gVGhlIGVuY3J5cHRpb24gY29udGV4dCBjYW4gYmUgbGF0ZXIg
dW51c2VkIGJ5IHRoZSBoeXBlcnZpc29yDQp0byBpbXBvcnQgdGhlIGluY29taW5nIGRhdGEgaW50
byB0aGUgU0VWIGd1ZXN0IG1lbW9yeSBzcGFjZS4NCg0KQ2M6IFRob21hcyBHbGVpeG5lciA8dGds
eEBsaW51dHJvbml4LmRlPg0KQ2M6IEluZ28gTW9sbmFyIDxtaW5nb0ByZWRoYXQuY29tPg0KQ2M6
ICJILiBQZXRlciBBbnZpbiIgPGhwYUB6eXRvci5jb20+DQpDYzogUGFvbG8gQm9uemluaSA8cGJv
bnppbmlAcmVkaGF0LmNvbT4NCkNjOiAiUmFkaW0gS3LEjW3DocWZIiA8cmtyY21hckByZWRoYXQu
Y29tPg0KQ2M6IEpvZXJnIFJvZWRlbCA8am9yb0A4Ynl0ZXMub3JnPg0KQ2M6IEJvcmlzbGF2IFBl
dGtvdiA8YnBAc3VzZS5kZT4NCkNjOiBUb20gTGVuZGFja3kgPHRob21hcy5sZW5kYWNreUBhbWQu
Y29tPg0KQ2M6IHg4NkBrZXJuZWwub3JnDQpDYzoga3ZtQHZnZXIua2VybmVsLm9yZw0KQ2M6IGxp
bnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNClNpZ25lZC1vZmYtYnk6IEJyaWplc2ggU2luZ2gg
PGJyaWplc2guc2luZ2hAYW1kLmNvbT4NCi0tLQ0KIC4uLi92aXJ0dWFsL2t2bS9hbWQtbWVtb3J5
LWVuY3J5cHRpb24ucnN0ICAgICB8IDI5ICsrKysrKysNCiBhcmNoL3g4Ni9rdm0vc3ZtLmMgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgfCA4MCArKysrKysrKysrKysrKysrKysrDQogaW5jbHVk
ZS91YXBpL2xpbnV4L2t2bS5oICAgICAgICAgICAgICAgICAgICAgIHwgIDkgKysrDQogMyBmaWxl
cyBjaGFuZ2VkLCAxMTggaW5zZXJ0aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlv
bi92aXJ0dWFsL2t2bS9hbWQtbWVtb3J5LWVuY3J5cHRpb24ucnN0IGIvRG9jdW1lbnRhdGlvbi92
aXJ0dWFsL2t2bS9hbWQtbWVtb3J5LWVuY3J5cHRpb24ucnN0DQppbmRleCAwMDY4MzIyNTZhZTMu
LmFjZGZmMjQ1NDY0OSAxMDA2NDQNCi0tLSBhL0RvY3VtZW50YXRpb24vdmlydHVhbC9rdm0vYW1k
LW1lbW9yeS1lbmNyeXB0aW9uLnJzdA0KKysrIGIvRG9jdW1lbnRhdGlvbi92aXJ0dWFsL2t2bS9h
bWQtbWVtb3J5LWVuY3J5cHRpb24ucnN0DQpAQCAtMjkzLDYgKzI5MywzNSBAQCBpc3N1ZWQgYnkg
dGhlIGh5cGVydmlzb3IgdG8gZGVsZXRlIHRoZSBlbmNyeXB0aW9uIGNvbnRleHQuDQogDQogUmV0
dXJuczogMCBvbiBzdWNjZXNzLCAtbmVnYXRpdmUgb24gZXJyb3INCiANCisxMy4gS1ZNX1NFVl9S
RUNFSVZFX1NUQVJUDQorLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQorDQorVGhlIEtWTV9TRVZf
UkVDRUlWRV9TVEFSVCBjb21tYW5kIGlzIHVzZWQgZm9yIGNyZWF0aW5nIHRoZSBtZW1vcnkgZW5j
cnlwdGlvbg0KK2NvbnRleHQgZm9yIGFuIGluY29taW5nIFNFViBndWVzdC4gVG8gY3JlYXRlIHRo
ZSBlbmNyeXB0aW9uIGNvbnRleHQsIHVzZXIgbXVzdA0KK3Byb3ZpZGUgYSBndWVzdCBwb2xpY3ks
IHRoZSBwbGF0Zm9ybSBwdWJsaWMgRGlmZmllLUhlbGxtYW4gKFBESCkga2V5IGFuZCBzZXNzaW9u
DQoraW5mb3JtYXRpb24uDQorDQorUGFyYW1ldGVyczogc3RydWN0ICBrdm1fc2V2X3JlY2VpdmVf
c3RhcnQgKGluL291dCkNCisNCitSZXR1cm5zOiAwIG9uIHN1Y2Nlc3MsIC1uZWdhdGl2ZSBvbiBl
cnJvcg0KKw0KKzo6DQorDQorICAgICAgICBzdHJ1Y3Qga3ZtX3Nldl9yZWNlaXZlX3N0YXJ0IHsN
CisgICAgICAgICAgICAgICAgX191MzIgaGFuZGxlOyAgICAgICAgICAgLyogaWYgemVybyB0aGVu
IGZpcm13YXJlIGNyZWF0ZXMgYSBuZXcgaGFuZGxlICovDQorICAgICAgICAgICAgICAgIF9fdTMy
IHBvbGljeTsgICAgICAgICAgIC8qIGd1ZXN0J3MgcG9saWN5ICovDQorDQorICAgICAgICAgICAg
ICAgIF9fdTY0IHBkaF91YWRkcjsgICAgICAgICAvKiB1c2Vyc3BhY2UgYWRkcmVzcyBwb2ludGlu
ZyB0byB0aGUgUERIIGtleSAqLw0KKyAgICAgICAgICAgICAgICBfX3UzMiBkaF9sZW47DQorDQor
ICAgICAgICAgICAgICAgIF9fdTY0IHNlc3Npb25fYWRkcjsgICAgIC8qIHVzZXJzcGFjZSBhZGRy
ZXNzIHdoaWNoIHBvaW50cyB0byB0aGUgZ3Vlc3Qgc2Vzc2lvbiBpbmZvcm1hdGlvbiAqLw0KKyAg
ICAgICAgICAgICAgICBfX3UzMiBzZXNzaW9uX2xlbjsNCisgICAgICAgIH07DQorDQorT24gc3Vj
Y2VzcywgdGhlICdoYW5kbGUnIGZpZWxkIGNvbnRhaW5zIGEgbmV3IGhhbmRsZSBhbmQgb24gZXJy
b3IsIGEgbmVnYXRpdmUgdmFsdWUuDQorDQorRm9yIG1vcmUgZGV0YWlscywgc2VlIFNFViBzcGVj
IFNlY3Rpb24gNi4xMi4NCisNCiBSZWZlcmVuY2VzDQogPT09PT09PT09PQ0KIA0KZGlmZiAtLWdp
dCBhL2FyY2gveDg2L2t2bS9zdm0uYyBiL2FyY2gveDg2L2t2bS9zdm0uYw0KaW5kZXggMjYzZjNj
N2RlYWU3Li5hN2RjZjE5YmFlZmIgMTAwNjQ0DQotLS0gYS9hcmNoL3g4Ni9rdm0vc3ZtLmMNCisr
KyBiL2FyY2gveDg2L2t2bS9zdm0uYw0KQEAgLTcxOTIsNiArNzE5Miw4MyBAQCBzdGF0aWMgaW50
IHNldl9zZW5kX2ZpbmlzaChzdHJ1Y3Qga3ZtICprdm0sIHN0cnVjdCBrdm1fc2V2X2NtZCAqYXJn
cCkNCiAJcmV0dXJuIHJldDsNCiB9DQogDQorc3RhdGljIGludCBzZXZfcmVjZWl2ZV9zdGFydChz
dHJ1Y3Qga3ZtICprdm0sIHN0cnVjdCBrdm1fc2V2X2NtZCAqYXJncCkNCit7DQorCXN0cnVjdCBr
dm1fc2V2X2luZm8gKnNldiA9ICZ0b19rdm1fc3ZtKGt2bSktPnNldl9pbmZvOw0KKwlzdHJ1Y3Qg
c2V2X2RhdGFfcmVjZWl2ZV9zdGFydCAqc3RhcnQ7DQorCXN0cnVjdCBrdm1fc2V2X3JlY2VpdmVf
c3RhcnQgcGFyYW1zOw0KKwlpbnQgKmVycm9yID0gJmFyZ3AtPmVycm9yOw0KKwl2b2lkICpzZXNz
aW9uX2RhdGEgPSBOVUxMOw0KKwl2b2lkICpwZGhfZGF0YSA9IE5VTEw7DQorCWludCByZXQ7DQor
DQorCWlmICghc2V2X2d1ZXN0KGt2bSkpDQorCQlyZXR1cm4gLUVOT1RUWTsNCisNCisJLyogR2V0
IHBhcmFtZXRlciBmcm9tIHRoZSB1c2VyICovDQorCWlmIChjb3B5X2Zyb21fdXNlcigmcGFyYW1z
LCAodm9pZCBfX3VzZXIgKikodWludHB0cl90KWFyZ3AtPmRhdGEsDQorCQkJc2l6ZW9mKHN0cnVj
dCBrdm1fc2V2X3JlY2VpdmVfc3RhcnQpKSkNCisJCXJldHVybiAtRUZBVUxUOw0KKw0KKwlpZiAo
IXBhcmFtcy5wZGhfdWFkZHIgfHwgIXBhcmFtcy5wZGhfbGVuIHx8DQorCSAgICAhcGFyYW1zLnNl
c3Npb25fdWFkZHIgfHwgIXBhcmFtcy5zZXNzaW9uX2xlbikNCisJCXJldHVybiAtRUlOVkFMOw0K
Kw0KKwlzdGFydCA9IGt6YWxsb2Moc2l6ZW9mKCpzdGFydCksIEdGUF9LRVJORUwpOw0KKwlpZiAo
IXN0YXJ0KQ0KKwkJcmV0dXJuIC1FTk9NRU07DQorDQorCXN0YXJ0LT5oYW5kbGUgPSBwYXJhbXMu
aGFuZGxlOw0KKwlzdGFydC0+cG9saWN5ID0gcGFyYW1zLnBvbGljeTsNCisNCisJcGRoX2RhdGEg
PSBwc3BfY29weV91c2VyX2Jsb2IocGFyYW1zLnBkaF91YWRkciwgcGFyYW1zLnBkaF9sZW4pOw0K
KwlpZiAoSVNfRVJSKHBkaF9kYXRhKSkgew0KKwkJcmV0ID0gUFRSX0VSUihwZGhfZGF0YSk7DQor
CQlnb3RvIGVfZnJlZTsNCisJfQ0KKw0KKwlzdGFydC0+cGRoX2NlcnRfYWRkcmVzcyA9IF9fcHNw
X3BhKHBkaF9kYXRhKTsNCisJc3RhcnQtPnBkaF9jZXJ0X2xlbiA9IHBhcmFtcy5wZGhfbGVuOw0K
Kw0KKwlzZXNzaW9uX2RhdGEgPSBwc3BfY29weV91c2VyX2Jsb2IocGFyYW1zLnNlc3Npb25fdWFk
ZHIsIHBhcmFtcy5zZXNzaW9uX2xlbik7DQorCWlmIChJU19FUlIoc2Vzc2lvbl9kYXRhKSkgew0K
KwkJcmV0ID0gUFRSX0VSUihzZXNzaW9uX2RhdGEpOw0KKwkJZ290byBlX2ZyZWVfcGRoOw0KKwl9
DQorDQorCXN0YXJ0LT5zZXNzaW9uX2FkZHJlc3MgPSBfX3BzcF9wYShzZXNzaW9uX2RhdGEpOw0K
KwlzdGFydC0+c2Vzc2lvbl9sZW4gPSBwYXJhbXMuc2Vzc2lvbl9sZW47DQorDQorCS8qIGNyZWF0
ZSBtZW1vcnkgZW5jcnlwdGlvbiBjb250ZXh0ICovDQorCXJldCA9IF9fc2V2X2lzc3VlX2NtZChh
cmdwLT5zZXZfZmQsIFNFVl9DTURfUkVDRUlWRV9TVEFSVCwgc3RhcnQsIGVycm9yKTsNCisJaWYg
KHJldCkNCisJCWdvdG8gZV9mcmVlX3Nlc3Npb247DQorDQorCS8qIEJpbmQgQVNJRCB0byB0aGlz
IGd1ZXN0ICovDQorCXJldCA9IHNldl9iaW5kX2FzaWQoa3ZtLCBzdGFydC0+aGFuZGxlLCBlcnJv
cik7DQorCWlmIChyZXQpDQorCQlnb3RvIGVfZnJlZV9zZXNzaW9uOw0KKw0KKwlwYXJhbXMuaGFu
ZGxlID0gc3RhcnQtPmhhbmRsZTsNCisJaWYgKGNvcHlfdG9fdXNlcigodm9pZCBfX3VzZXIgKiko
dWludHB0cl90KWFyZ3AtPmRhdGEsDQorCQkJICZwYXJhbXMsIHNpemVvZihzdHJ1Y3Qga3ZtX3Nl
dl9yZWNlaXZlX3N0YXJ0KSkpIHsNCisJCXJldCA9IC1FRkFVTFQ7DQorCQlzZXZfdW5iaW5kX2Fz
aWQoa3ZtLCBzdGFydC0+aGFuZGxlKTsNCisJCWdvdG8gZV9mcmVlX3Nlc3Npb247DQorCX0NCisN
CisJc2V2LT5oYW5kbGUgPSBzdGFydC0+aGFuZGxlOw0KKwlzZXYtPmZkID0gYXJncC0+c2V2X2Zk
Ow0KKw0KK2VfZnJlZV9zZXNzaW9uOg0KKwlrZnJlZShzZXNzaW9uX2RhdGEpOw0KK2VfZnJlZV9w
ZGg6DQorCWtmcmVlKHBkaF9kYXRhKTsNCitlX2ZyZWU6DQorCWtmcmVlKHN0YXJ0KTsNCisJcmV0
dXJuIHJldDsNCit9DQorDQogc3RhdGljIGludCBzdm1fbWVtX2VuY19vcChzdHJ1Y3Qga3ZtICpr
dm0sIHZvaWQgX191c2VyICphcmdwKQ0KIHsNCiAJc3RydWN0IGt2bV9zZXZfY21kIHNldl9jbWQ7
DQpAQCAtNzI0Miw2ICs3MzE5LDkgQEAgc3RhdGljIGludCBzdm1fbWVtX2VuY19vcChzdHJ1Y3Qg
a3ZtICprdm0sIHZvaWQgX191c2VyICphcmdwKQ0KIAljYXNlIEtWTV9TRVZfU0VORF9GSU5JU0g6
DQogCQlyID0gc2V2X3NlbmRfZmluaXNoKGt2bSwgJnNldl9jbWQpOw0KIAkJYnJlYWs7DQorCWNh
c2UgS1ZNX1NFVl9SRUNFSVZFX1NUQVJUOg0KKwkJciA9IHNldl9yZWNlaXZlX3N0YXJ0KGt2bSwg
JnNldl9jbWQpOw0KKwkJYnJlYWs7DQogCWRlZmF1bHQ6DQogCQlyID0gLUVJTlZBTDsNCiAJCWdv
dG8gb3V0Ow0KZGlmZiAtLWdpdCBhL2luY2x1ZGUvdWFwaS9saW51eC9rdm0uaCBiL2luY2x1ZGUv
dWFwaS9saW51eC9rdm0uaA0KaW5kZXggMGJlZTkxYmJhMzI5Li5mZWU3NWJmMWZkOTAgMTAwNjQ0
DQotLS0gYS9pbmNsdWRlL3VhcGkvbGludXgva3ZtLmgNCisrKyBiL2luY2x1ZGUvdWFwaS9saW51
eC9rdm0uaA0KQEAgLTE1NDEsNiArMTU0MSwxNSBAQCBzdHJ1Y3Qga3ZtX3Nldl9zZW5kX3VwZGF0
ZV9kYXRhIHsNCiAJX191MzIgdHJhbnNfbGVuOw0KIH07DQogDQorc3RydWN0IGt2bV9zZXZfcmVj
ZWl2ZV9zdGFydCB7DQorCV9fdTMyIGhhbmRsZTsNCisJX191MzIgcG9saWN5Ow0KKwlfX3U2NCBw
ZGhfdWFkZHI7DQorCV9fdTMyIHBkaF9sZW47DQorCV9fdTY0IHNlc3Npb25fdWFkZHI7DQorCV9f
dTMyIHNlc3Npb25fbGVuOw0KK307DQorDQogI2RlZmluZSBLVk1fREVWX0FTU0lHTl9FTkFCTEVf
SU9NTVUJKDEgPDwgMCkNCiAjZGVmaW5lIEtWTV9ERVZfQVNTSUdOX1BDSV8yXzMJCSgxIDw8IDEp
DQogI2RlZmluZSBLVk1fREVWX0FTU0lHTl9NQVNLX0lOVFgJKDEgPDwgMikNCi0tIA0KMi4xNy4x
DQoNCg==

