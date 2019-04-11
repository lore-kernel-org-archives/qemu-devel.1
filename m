Return-Path: <SRS0=7PPA=SN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B267FC10F13
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 18:01:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BF4F20850
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 18:01:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="HgOazl88"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BF4F20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52994 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEe0U-0005De-H2
	for qemu-devel@archiver.kernel.org; Thu, 11 Apr 2019 14:01:02 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60998)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1hEdzO-0004V7-UK
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 13:59:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1hEdzN-0002gC-SP
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 13:59:54 -0400
Received: from mail-eopbgr680045.outbound.protection.outlook.com
	([40.107.68.45]:44014
	helo=NAM04-BN3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <brijesh.singh@amd.com>)
	id 1hEdzN-0002ff-HG
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 13:59:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=JetKE8+EhNKomFaTzxAxRSOXZce6sB2Yh8/1lE8CPfU=;
	b=HgOazl88X1HR3/DV1fd6K6OFRzsFv0o+jLE80+ewqa3o9Hyq6HUK8Kj7TWA16LdblEUTDVZGtOixL4afPeViWfdf0QDzFgBmdmNKxkxJZEpAlPYBXrdByE/gcS1PidLyR9FyMHIr0JV9hqTy3b7TjWo8y0cCPScmkwxAsDf12Wc=
Received: from DM6PR12MB2682.namprd12.prod.outlook.com (20.176.116.31) by
	DM6PR12MB2748.namprd12.prod.outlook.com (20.176.118.90) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1771.16; Thu, 11 Apr 2019 17:59:50 +0000
Received: from DM6PR12MB2682.namprd12.prod.outlook.com
	([fe80::9d54:69c5:d057:80de]) by
	DM6PR12MB2682.namprd12.prod.outlook.com
	([fe80::9d54:69c5:d057:80de%3]) with mapi id 15.20.1771.021;
	Thu, 11 Apr 2019 17:59:50 +0000
From: "Singh, Brijesh" <brijesh.singh@amd.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Thread-Topic: [PATCH] target/i386: sev: add 'sev-max-guests' field to
	'query-sev-capabilities'
Thread-Index: AQHU8JBbMl53pn0tMEuZJLOOksDkdQ==
Date: Thu, 11 Apr 2019 17:59:50 +0000
Message-ID: <20190411175931.29235-1-brijesh.singh@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN1PR12CA0084.namprd12.prod.outlook.com
	(2603:10b6:802:21::19) To DM6PR12MB2682.namprd12.prod.outlook.com
	(2603:10b6:5:4a::31)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=brijesh.singh@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [165.204.77.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8e14c959-7925-4d80-d12c-08d6bea77e2d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4618075)(2017052603328)(7193020);
	SRVR:DM6PR12MB2748; 
x-ms-traffictypediagnostic: DM6PR12MB2748:
x-microsoft-antispam-prvs: <DM6PR12MB2748038307C4121950519793E52F0@DM6PR12MB2748.namprd12.prod.outlook.com>
x-forefront-prvs: 00046D390F
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10009020)(366004)(346002)(396003)(136003)(376002)(39860400002)(189003)(199004)(478600001)(14454004)(71200400001)(6506007)(71190400001)(54906003)(99286004)(8676002)(186003)(97736004)(36756003)(52116002)(5660300002)(386003)(68736007)(256004)(14444005)(3846002)(6116002)(81166006)(81156014)(26005)(316002)(8936002)(50226002)(102836004)(2906002)(1076003)(86362001)(6512007)(106356001)(5640700003)(2351001)(476003)(2501003)(105586002)(305945005)(7736002)(2616005)(6916009)(4326008)(66066001)(53936002)(6486002)(6436002)(25786009)(486006);
	DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB2748;
	H:DM6PR12MB2682.namprd12.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: a12UTdO5jcAyHOJ3kQKIrANDdrWu6tknEwDcj/JxJL3b2MP0XV6Ab34dJr3LJ9Md/PPLVdA/z+3kBrP7juLQIQQJOAZzUiZQBUC7nginVT32YrBC1q9vVWEfzgsj/xtczvwRt/SlyFTolWqUoe2qpOgCpXPPAPr18gBGruuwe9r58/BRN+w8qr29qAeoYUmd5HxTAbCNHw7twcBZoKnyU5IewSY1m/R8H84A7JplR8SqBfBeHkcECjg7JTZCEqcXy03t3Z+3mHmILFrQqQLCURTI1PuE4x/p47dQ6lt0c94EEXRysfKX3c7EbgQszKE7TBBprV+L19trUp+QkfleABNz3Zi8hvAAY+0Zl0dyInkWqcZApJCr8CNriJSE1i1f8ytceRjTBjmNQjknmkzQ3kp0PCYpkxDXrpDjXPzWpu0=
Content-Type: text/plain; charset="UTF-8"
Content-ID: <92061E548BE82E4A8C5B684CFD4CD405@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e14c959-7925-4d80-d12c-08d6bea77e2d
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2019 17:59:50.8483 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2748
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.68.45
Subject: [Qemu-devel] [PATCH] target/i386: sev: add 'sev-max-guests' field
 to 'query-sev-capabilities'
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
Cc: Erik Skultety <eskultet@redhat.com>, Laszlo Ersek <lersek@redhat.com>,
	Markus Armbruster <armbru@redhat.com>, "Singh,
	Brijesh" <brijesh.singh@amd.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190411175950.gl9iILcyDiUGWRAXoO9s-DFAAKPM8P30QNW1-pghPBo@z>

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
Q2M6IEVyaWsgU2t1bHRldHkgPGVza3VsdGV0QHJlZGhhdC5jb20+DQpTaWduZWQtb2ZmLWJ5OiBC
cmlqZXNoIFNpbmdoIDxicmlqZXNoLnNpbmdoQGFtZC5jb20+DQotLS0NCiBxYXBpL3RhcmdldC5q
c29uICB8IDYgKysrKy0tDQogdGFyZ2V0L2kzODYvc2V2LmMgfCA2ICsrKystLQ0KIDIgZmlsZXMg
Y2hhbmdlZCwgOCBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEv
cWFwaS90YXJnZXQuanNvbiBiL3FhcGkvdGFyZ2V0Lmpzb24NCmluZGV4IDFkNGQ1NGI2MDAuLmI0
NTEyMWQzMGIgMTAwNjQ0DQotLS0gYS9xYXBpL3RhcmdldC5qc29uDQorKysgYi9xYXBpL3Rhcmdl
dC5qc29uDQpAQCAtMTgzLDcgKzE4Myw4IEBADQogICAnZGF0YSc6IHsgJ3BkaCc6ICdzdHInLA0K
ICAgICAgICAgICAgICdjZXJ0LWNoYWluJzogJ3N0cicsDQogICAgICAgICAgICAgJ2NiaXRwb3Mn
OiAnaW50JywNCi0gICAgICAgICAgICAncmVkdWNlZC1waHlzLWJpdHMnOiAnaW50J30sDQorICAg
ICAgICAgICAgJ3JlZHVjZWQtcGh5cy1iaXRzJzogJ2ludCcsDQorICAgICAgICAgICAgJ3Nldi1t
YXgtZ3Vlc3RzJzogJ2ludCd9LA0KICAgJ2lmJzogJ2RlZmluZWQoVEFSR0VUX0kzODYpJyB9DQog
DQogIyMNCkBAIC0yMDAsNyArMjAxLDggQEANCiAjDQogIyAtPiB7ICJleGVjdXRlIjogInF1ZXJ5
LXNldi1jYXBhYmlsaXRpZXMiIH0NCiAjIDwtIHsgInJldHVybiI6IHsgInBkaCI6ICI4Q0NERDhE
REQiLCAiY2VydC1jaGFpbiI6ICI4ODhDQ0NERERFRSIsDQotIyAgICAgICAgICAgICAgICAgICJj
Yml0cG9zIjogNDcsICJyZWR1Y2VkLXBoeXMtYml0cyI6IDV9fQ0KKyMgICAgICAgICAgICAgICAg
ICAiY2JpdHBvcyI6IDQ3LCAicmVkdWNlZC1waHlzLWJpdHMiOiA1LA0KKyMgICAgICAgICAgICAg
ICAgICAic2V2LW1heC1ndWVzdHMiIDogMTV9fQ0KICMNCiAjIw0KIHsgJ2NvbW1hbmQnOiAncXVl
cnktc2V2LWNhcGFiaWxpdGllcycsICdyZXR1cm5zJzogJ1NldkNhcGFiaWxpdHknLA0KZGlmZiAt
LWdpdCBhL3RhcmdldC9pMzg2L3Nldi5jIGIvdGFyZ2V0L2kzODYvc2V2LmMNCmluZGV4IGNkNzdm
NmI1ZDQuLmJiMGNkNzlhY2QgMTAwNjQ0DQotLS0gYS90YXJnZXQvaTM4Ni9zZXYuYw0KKysrIGIv
dGFyZ2V0L2kzODYvc2V2LmMNCkBAIC00ODgsNyArNDg4LDcgQEAgc2V2X2dldF9jYXBhYmlsaXRp
ZXModm9pZCkNCiAgICAgZ3VjaGFyICpwZGhfZGF0YSA9IE5VTEw7DQogICAgIGd1Y2hhciAqY2Vy
dF9jaGFpbl9kYXRhID0gTlVMTDsNCiAgICAgc2l6ZV90IHBkaF9sZW4gPSAwLCBjZXJ0X2NoYWlu
X2xlbiA9IDA7DQotICAgIHVpbnQzMl90IGVieDsNCisgICAgdWludDMyX3QgZWJ4LCBlY3gsIGVk
eDsNCiAgICAgaW50IGZkOw0KIA0KICAgICBmZCA9IG9wZW4oREVGQVVMVF9TRVZfREVWSUNFLCBP
X1JEV1IpOw0KQEAgLTUwNyw3ICs1MDcsNyBAQCBzZXZfZ2V0X2NhcGFiaWxpdGllcyh2b2lkKQ0K
ICAgICBjYXAtPnBkaCA9IGdfYmFzZTY0X2VuY29kZShwZGhfZGF0YSwgcGRoX2xlbik7DQogICAg
IGNhcC0+Y2VydF9jaGFpbiA9IGdfYmFzZTY0X2VuY29kZShjZXJ0X2NoYWluX2RhdGEsIGNlcnRf
Y2hhaW5fbGVuKTsNCiANCi0gICAgaG9zdF9jcHVpZCgweDgwMDAwMDFGLCAwLCBOVUxMLCAmZWJ4
LCBOVUxMLCBOVUxMKTsNCisgICAgaG9zdF9jcHVpZCgweDgwMDAwMDFGLCAwLCBOVUxMLCAmZWJ4
LCAmZWN4LCAmZWR4KTsNCiAgICAgY2FwLT5jYml0cG9zID0gZWJ4ICYgMHgzZjsNCiANCiAgICAg
LyoNCkBAIC01MTYsNiArNTE2LDggQEAgc2V2X2dldF9jYXBhYmlsaXRpZXModm9pZCkNCiAgICAg
ICovDQogICAgIGNhcC0+cmVkdWNlZF9waHlzX2JpdHMgPSAxOw0KIA0KKyAgICAvKiB0aGUgbWF4
aW11bSBudW1iZXIgb2YgU0VWIGd1ZXN0cyB0aGF0IGNhbiBydW4gc2ltdWx0YW5lb3VzbHkgKi8N
CisgICAgY2FwLT5zZXZfbWF4X2d1ZXN0cyA9IGVjeCAtIGVkeCArIDE7DQogb3V0Og0KICAgICBn
X2ZyZWUocGRoX2RhdGEpOw0KICAgICBnX2ZyZWUoY2VydF9jaGFpbl9kYXRhKTsNCi0tIA0KMi4x
Ny4xDQoNCg==

