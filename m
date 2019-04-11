Return-Path: <SRS0=7PPA=SN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 635D5C10F13
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 23:56:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18F0B20869
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 23:56:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Uq2uBbgY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18F0B20869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:56496 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEjYe-0004b0-1n
	for qemu-devel@archiver.kernel.org; Thu, 11 Apr 2019 19:56:40 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51700)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1hEjXc-0003dL-La
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 19:55:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1hEjXV-0001pw-3l
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 19:55:32 -0400
Received: from mail-eopbgr750079.outbound.protection.outlook.com
	([40.107.75.79]:25504
	helo=NAM02-BL2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <brijesh.singh@amd.com>)
	id 1hEjXL-0001hc-SY
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 19:55:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=uLFzkXtQvhuNsfGT8YKqAYrpa4OelBWt3GM164npqjU=;
	b=Uq2uBbgYARw62ZIYiOn4kJNo7FczX7xmaviOP4jDXXDumMaPzDbht80R9wyhZEzYGx1hTR//wrvK6inQ9wQDKhN6YAI9DAzIAEOLxANZOVKPqWEOlS98gQEqJLudahbjuA0YQr2XSCfGlEh2uTVf429EpsiO79m6RwDFz4Ikytg=
Received: from DM6PR12MB2682.namprd12.prod.outlook.com (20.176.116.31) by
	DM6PR12MB2826.namprd12.prod.outlook.com (20.177.221.161) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1771.15; Thu, 11 Apr 2019 23:55:15 +0000
Received: from DM6PR12MB2682.namprd12.prod.outlook.com
	([fe80::9d54:69c5:d057:80de]) by
	DM6PR12MB2682.namprd12.prod.outlook.com
	([fe80::9d54:69c5:d057:80de%3]) with mapi id 15.20.1771.021;
	Thu, 11 Apr 2019 23:55:15 +0000
From: "Singh, Brijesh" <brijesh.singh@amd.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Thread-Topic: [PATCH v2] target/i386: sev: add 'sev-max-guests' field to
	'query-sev-capabilities'
Thread-Index: AQHU8MICSdEfZ1Yulk67b7vJ+MjSjg==
Date: Thu, 11 Apr 2019 23:55:15 +0000
Message-ID: <20190411235456.12918-1-brijesh.singh@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN6PR2101CA0029.namprd21.prod.outlook.com
	(2603:10b6:805:106::39) To DM6PR12MB2682.namprd12.prod.outlook.com
	(2603:10b6:5:4a::31)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=brijesh.singh@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [165.204.77.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2bd5e49b-323d-42fe-344e-08d6bed92492
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4618075)(2017052603328)(7193020);
	SRVR:DM6PR12MB2826; 
x-ms-traffictypediagnostic: DM6PR12MB2826:
x-microsoft-antispam-prvs: <DM6PR12MB282697435F2A109C08645B8EE52F0@DM6PR12MB2826.namprd12.prod.outlook.com>
x-forefront-prvs: 00046D390F
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10009020)(396003)(136003)(376002)(346002)(39860400002)(366004)(189003)(199004)(97736004)(102836004)(52116002)(25786009)(2616005)(186003)(14444005)(2501003)(1076003)(256004)(386003)(99286004)(7736002)(68736007)(6486002)(8936002)(50226002)(71200400001)(54906003)(26005)(6916009)(71190400001)(6506007)(6436002)(305945005)(316002)(6116002)(8676002)(81166006)(3846002)(2906002)(106356001)(36756003)(476003)(81156014)(86362001)(105586002)(14454004)(66066001)(5660300002)(486006)(6512007)(5640700003)(53936002)(478600001)(2351001)(4326008);
	DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB2826;
	H:DM6PR12MB2682.namprd12.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Nodjwer2n06y7HweUoJO0bhbVX9A3TvOnT1yOTev2OtRqFpn/FlhvRgSw2tWLvGxAFo6y8a4jvJHvgQ9D7gPQXb9iZnC4uUUSNgYC5bFzZj8NkFe7lZ76cIXQHPG/RBnaySc9goOQjglTDN7y5PxahEESxcvW8V0w8km+M0MVJlBKaIaGuU4wZu/+e+X9X1oL1mOU/V+JDw94oz63+sZsumYILHcsHF1lF6vlvIHxezlpELGA9ar+3SS93gufJwa4aaTZF+a7wkAawWVtKR/mW9/qxgaCk4IN0q1jJ1ADlMG3xAMffQc95C5uFYoMVVqCu+ohRD454sJmVTQ9bysljgywiYPUApcmh1J61qn/15VggbvOx29lXmwxY36ifg/OdJLa9NxlxnhJFwzJEH6b1TIL9jfprfpLTDdUS4I+2E=
Content-Type: text/plain; charset="UTF-8"
Content-ID: <8CE87D8491C0CC43A0A6F806EDDF16D7@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bd5e49b-323d-42fe-344e-08d6bed92492
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2019 23:55:15.6920 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2826
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.75.79
Subject: [Qemu-devel] [PATCH v2] target/i386: sev: add 'sev-max-guests'
 field to 'query-sev-capabilities'
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
Cc: "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
	Erik Skultety <eskultet@redhat.com>, Laszlo Ersek <lersek@redhat.com>,
	Markus Armbruster <armbru@redhat.com>, "Singh,
	Brijesh" <brijesh.singh@amd.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190411235515.ym6I6oEa4Rv8BTQf1gJ03dxAqDAwb2z-5A1J8tZDO8o@z>

VGhlcmUgYXJlIGxpbWl0ZWQgbnVtYmVycyBvZiB0aGUgU0VWIGd1ZXN0cyB0aGF0IGNhbiBiZSBy
dW4gY29uY3VycmVudGx5Lg0KQSBtYW5hZ2VtZW50IGFwcGxpY2F0aW9ucyBtYXkgbmVlZCB0byBr
bm93IHRoaXMgbGltaXQgc28gdGhhdCBpdCBjYW4gcGxhY2UNClNFViBWTXMgb24gaG9zdHMgd2hp
Y2ggaGF2ZSBzdWl0YWJsZSByZXNvdXJjZXMgYXZhaWxhYmxlLg0KDQpDdXJyZW50bHksIHRoaXMg
bGltaXQgaXMgbm90IGV4cG9zZWQgdG8gdGhlIGFwcGxpY2F0aW9uLiBBZGQgYSBuZXcNCidzZXYt
bWF4LWd1ZXN0JyBmaWVsZCBpbiB0aGUgcXVlcnktc2V2LWNhcGFiaWxpdGllcyB0byBwcm92aWRl
IHRoaXMNCmluZm9ybWF0aW9uLg0KDQpDYzogUGFvbG8gQm9uemluaSA8cGJvbnppbmlAcmVkaGF0
LmNvbT4NCkNjOiBNYXJrdXMgQXJtYnJ1c3RlciA8YXJtYnJ1QHJlZGhhdC5jb20+DQpDYzogRXJp
YyBCbGFrZSA8ZWJsYWtlQHJlZGhhdC5jb20+DQpDYzogRGFuaWVsIFAuIEJlcnJhbmfDqSA8YmVy
cmFuZ2VAcmVkaGF0LmNvbT4NCkNjOiBMYXN6bG8gRXJzZWsgPGxlcnNla0ByZWRoYXQuY29tPg0K
Q2M6IEVyaWsgU2t1bHRldHkgPGVza3VsdGV0QHJlZGhhdC5jb20+DQpDYzogVG9tIExlbmRhY2t5
IDxUaG9tYXMuTGVuZGFja3lAYW1kLmNvbT4NClNpZ25lZC1vZmYtYnk6IEJyaWplc2ggU2luZ2gg
PGJyaWplc2guc2luZ2hAYW1kLmNvbT4NCi0tLQ0KDQpjaGFuZ2VzIHNpbmNlIHYxOg0KIC0gZG9j
dW1lbnQgdGhlIG5ldyBmaWVsZCBhbmQgYWRkIChzaW5jZSA0LjEpIGFubm90YXRpb24uDQoNCiBx
YXBpL3RhcmdldC5qc29uICB8IDkgKysrKysrKy0tDQogdGFyZ2V0L2kzODYvc2V2LmMgfCA5ICsr
KysrKystLQ0KIDIgZmlsZXMgY2hhbmdlZCwgMTQgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMo
LSkNCg0KZGlmZiAtLWdpdCBhL3FhcGkvdGFyZ2V0Lmpzb24gYi9xYXBpL3RhcmdldC5qc29uDQpp
bmRleCAxZDRkNTRiNjAwLi44Y2Q0ZmM3OTE5IDEwMDY0NA0KLS0tIGEvcWFwaS90YXJnZXQuanNv
bg0KKysrIGIvcWFwaS90YXJnZXQuanNvbg0KQEAgLTE3NywxMyArMTc3LDE3IEBADQogIyBAcmVk
dWNlZC1waHlzLWJpdHM6IE51bWJlciBvZiBwaHlzaWNhbCBBZGRyZXNzIGJpdCByZWR1Y3Rpb24g
d2hlbiBTRVYgaXMNCiAjICAgICAgICAgICAgICAgICAgICAgZW5hYmxlZA0KICMNCisjIEBzZXYt
bWF4LWd1ZXN0czogbWF4aW11bSBudW1iZXIgb2YgY29uY3VycmVudCBTRVYgZ3Vlc3Qgd2l0aCBT
RVYtRVMgZGlzYWJsZWQNCisjICAgICAgICAgICAgICAgICAgKHNpbmNlIDQuMSkNCisjDQogIyBT
aW5jZTogMi4xMg0KICMjDQogeyAnc3RydWN0JzogJ1NldkNhcGFiaWxpdHknLA0KICAgJ2RhdGEn
OiB7ICdwZGgnOiAnc3RyJywNCiAgICAgICAgICAgICAnY2VydC1jaGFpbic6ICdzdHInLA0KICAg
ICAgICAgICAgICdjYml0cG9zJzogJ2ludCcsDQotICAgICAgICAgICAgJ3JlZHVjZWQtcGh5cy1i
aXRzJzogJ2ludCd9LA0KKyAgICAgICAgICAgICdyZWR1Y2VkLXBoeXMtYml0cyc6ICdpbnQnLA0K
KyAgICAgICAgICAgICdzZXYtbWF4LWd1ZXN0cyc6ICdpbnQnfSwNCiAgICdpZic6ICdkZWZpbmVk
KFRBUkdFVF9JMzg2KScgfQ0KIA0KICMjDQpAQCAtMjAwLDcgKzIwNCw4IEBADQogIw0KICMgLT4g
eyAiZXhlY3V0ZSI6ICJxdWVyeS1zZXYtY2FwYWJpbGl0aWVzIiB9DQogIyA8LSB7ICJyZXR1cm4i
OiB7ICJwZGgiOiAiOENDREQ4REREIiwgImNlcnQtY2hhaW4iOiAiODg4Q0NDRERERUUiLA0KLSMg
ICAgICAgICAgICAgICAgICAiY2JpdHBvcyI6IDQ3LCAicmVkdWNlZC1waHlzLWJpdHMiOiA1fX0N
CisjICAgICAgICAgICAgICAgICAgImNiaXRwb3MiOiA0NywgInJlZHVjZWQtcGh5cy1iaXRzIjog
NSwNCisjICAgICAgICAgICAgICAgICAgInNldi1tYXgtZ3Vlc3RzIiA6IDE1fX0NCiAjDQogIyMN
CiB7ICdjb21tYW5kJzogJ3F1ZXJ5LXNldi1jYXBhYmlsaXRpZXMnLCAncmV0dXJucyc6ICdTZXZD
YXBhYmlsaXR5JywNCmRpZmYgLS1naXQgYS90YXJnZXQvaTM4Ni9zZXYuYyBiL3RhcmdldC9pMzg2
L3Nldi5jDQppbmRleCBjZDc3ZjZiNWQ0Li42ODI5NTg2ZmJlIDEwMDY0NA0KLS0tIGEvdGFyZ2V0
L2kzODYvc2V2LmMNCisrKyBiL3RhcmdldC9pMzg2L3Nldi5jDQpAQCAtNDg4LDcgKzQ4OCw3IEBA
IHNldl9nZXRfY2FwYWJpbGl0aWVzKHZvaWQpDQogICAgIGd1Y2hhciAqcGRoX2RhdGEgPSBOVUxM
Ow0KICAgICBndWNoYXIgKmNlcnRfY2hhaW5fZGF0YSA9IE5VTEw7DQogICAgIHNpemVfdCBwZGhf
bGVuID0gMCwgY2VydF9jaGFpbl9sZW4gPSAwOw0KLSAgICB1aW50MzJfdCBlYng7DQorICAgIHVp
bnQzMl90IGVieCwgZWN4LCBlZHg7DQogICAgIGludCBmZDsNCiANCiAgICAgZmQgPSBvcGVuKERF
RkFVTFRfU0VWX0RFVklDRSwgT19SRFdSKTsNCkBAIC01MDcsNyArNTA3LDcgQEAgc2V2X2dldF9j
YXBhYmlsaXRpZXModm9pZCkNCiAgICAgY2FwLT5wZGggPSBnX2Jhc2U2NF9lbmNvZGUocGRoX2Rh
dGEsIHBkaF9sZW4pOw0KICAgICBjYXAtPmNlcnRfY2hhaW4gPSBnX2Jhc2U2NF9lbmNvZGUoY2Vy
dF9jaGFpbl9kYXRhLCBjZXJ0X2NoYWluX2xlbik7DQogDQotICAgIGhvc3RfY3B1aWQoMHg4MDAw
MDAxRiwgMCwgTlVMTCwgJmVieCwgTlVMTCwgTlVMTCk7DQorICAgIGhvc3RfY3B1aWQoMHg4MDAw
MDAxRiwgMCwgTlVMTCwgJmVieCwgJmVjeCwgJmVkeCk7DQogICAgIGNhcC0+Y2JpdHBvcyA9IGVi
eCAmIDB4M2Y7DQogDQogICAgIC8qDQpAQCAtNTE2LDYgKzUxNiwxMSBAQCBzZXZfZ2V0X2NhcGFi
aWxpdGllcyh2b2lkKQ0KICAgICAgKi8NCiAgICAgY2FwLT5yZWR1Y2VkX3BoeXNfYml0cyA9IDE7
DQogDQorICAgIC8qDQorICAgICAqIFRoZSBtYXhpbXVtIG51bWJlciBvZiBTRVYgZ3Vlc3RzIHdp
dGggU0VWLUVTIGRpc2FibGVkIHRoYXQgY2FuIHJ1bg0KKyAgICAgKiBzaW11bHRhbmVvdXNseS4N
CisgICAgICovDQorICAgIGNhcC0+c2V2X21heF9ndWVzdHMgPSBlY3ggLSBlZHggKyAxOw0KIG91
dDoNCiAgICAgZ19mcmVlKHBkaF9kYXRhKTsNCiAgICAgZ19mcmVlKGNlcnRfY2hhaW5fZGF0YSk7
DQotLSANCjIuMTcuMQ0KDQo=

