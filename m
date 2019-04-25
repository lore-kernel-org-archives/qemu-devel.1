Return-Path: <SRS0=QtPl=S4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75506C43218
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 07:27:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FCC5206E0
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 07:27:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="dNaTkoAg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FCC5206E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40845 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJvGs-00055k-Eb
	for qemu-devel@archiver.kernel.org; Fri, 26 Apr 2019 03:27:46 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45827)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Janakarajan.Natarajan@amd.com>) id 1hJnPv-0000sy-OE
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 19:04:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Janakarajan.Natarajan@amd.com>) id 1hJnK1-0000Vb-FA
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 18:58:30 -0400
Received: from mail-eopbgr730086.outbound.protection.outlook.com
	([40.107.73.86]:18512
	helo=NAM05-DM3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Janakarajan.Natarajan@amd.com>)
	id 1hJnK1-0008Tp-9J
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 18:58:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=F65ITms6J8Nm39P+icx+qFggGA3VCR8lkIfgvqjWliU=;
	b=dNaTkoAgLfKUuBLRn1RYw8kvmIcAjki6AQB5nJni8u0mlFp+ErsOLs2smIh1Ddub3Xjf10y9BxBTeLbmlKdzgrB57p6B6hJefl8B+w3nbltFJbY1TG+cz1cUYU0l9CrBKEXm+Tw9ZevdcPsTw1FqJcmkISeOfxHt42ytIDTRgjM=
Received: from SN6PR12MB2736.namprd12.prod.outlook.com (52.135.107.27) by
	SN6PR12MB2752.namprd12.prod.outlook.com (52.135.107.32) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1835.13; Thu, 25 Apr 2019 22:58:20 +0000
Received: from SN6PR12MB2736.namprd12.prod.outlook.com
	([fe80::65cb:af55:6bd4:55a]) by SN6PR12MB2736.namprd12.prod.outlook.com
	([fe80::65cb:af55:6bd4:55a%4]) with mapi id 15.20.1835.010;
	Thu, 25 Apr 2019 22:58:19 +0000
From: "Natarajan, Janakarajan" <Janakarajan.Natarajan@amd.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Thread-Topic: [PATCH 2/3] hw: Notify listeners about guest pages which contain
	encrypted data
Thread-Index: AQHU+7pfOeem7eBqGUG7OM4ayEByug==
Date: Thu, 25 Apr 2019 22:58:19 +0000
Message-ID: <20190425225610.28350-3-Janakarajan.Natarajan@amd.com>
References: <20190425225610.28350-1-Janakarajan.Natarajan@amd.com>
In-Reply-To: <20190425225610.28350-1-Janakarajan.Natarajan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN4PR0601CA0018.namprd06.prod.outlook.com
	(2603:10b6:803:2f::28) To SN6PR12MB2736.namprd12.prod.outlook.com
	(2603:10b6:805:77::27)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=Janakarajan.Natarajan@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.20.1
x-originating-ip: [165.204.78.2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5f7759fd-6bd7-4913-3015-08d6c9d18243
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);
	SRVR:SN6PR12MB2752; 
x-ms-traffictypediagnostic: SN6PR12MB2752:
x-microsoft-antispam-prvs: <SN6PR12MB2752D708CC6FE2C172C02E8CE73D0@SN6PR12MB2752.namprd12.prod.outlook.com>
x-forefront-prvs: 0018A2705B
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10009020)(376002)(366004)(396003)(346002)(136003)(39860400002)(189003)(199004)(256004)(99286004)(2351001)(81156014)(316002)(11346002)(68736007)(81166006)(2616005)(71200400001)(71190400001)(476003)(446003)(1076003)(486006)(478600001)(14454004)(72206003)(54906003)(53936002)(8676002)(4326008)(76176011)(6506007)(305945005)(6916009)(2906002)(7736002)(386003)(66946007)(5640700003)(6436002)(64756008)(66476007)(66446008)(6486002)(25786009)(73956011)(66556008)(2501003)(26005)(186003)(86362001)(50226002)(102836004)(8936002)(6116002)(5660300002)(3846002)(6512007)(52116002)(97736004)(66066001)(36756003);
	DIR:OUT; SFP:1101; SCL:1; SRVR:SN6PR12MB2752;
	H:SN6PR12MB2736.namprd12.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: jfToagu6KEqS626wPQljFrJ3D9gtUlB8R//67ZUoa/cPrluSVAUqS1yTecDUgJTJElqPiPwKkK0HwPCrzw3JUAXpwtNGK1IxBkp+awaoG1BLchiOhsAvApIe5+QcEPGyDuwsac5vFgGWMzuXggCNsbkyQuRB1jHHILx25nlnKKwyIhnv3GQRz5uZZ+5aOVSOjpyOfGIrHkPJpOqV+yhv126pcCrXWkukDFCm6gPtt2r1UrgC9wb3NBP3GiLRZkl5jux36auMNsSq+GiU3Ud8M1GA8txH6R/60c9pcXS1pDyR8poQGS3Z3tbiZCEdWVdcAN4dkVJLDBIbSy5rtvquqbZGH/jYAfi9u2yvo3IE3yAjsGkgznPFH+UOTY9uYEPuE+QasKEKj6ecDnuhJPC/6zjf7bfaeLrNbv0+WJPvfF4=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f7759fd-6bd7-4913-3015-08d6c9d18243
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2019 22:58:19.3295 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2752
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.73.86
X-Mailman-Approved-At: Fri, 26 Apr 2019 03:24:03 -0400
Subject: [Qemu-devel] [PATCH 2/3] hw: Notify listeners about guest pages
 which contain encrypted data
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
	Eduardo Habkost <ehabkost@redhat.com>, "Natarajan,
	Janakarajan" <Janakarajan.Natarajan@amd.com>,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
	Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190425225819.iz-kagI38X9NP9T76eI42moXie2P6RZPGomurgK1noc@z>

UEMgcmFtLCBwZmxhc2ggdW5pdCAwIHJvbSBhbmQgcGMtZGltbSBtZW1vcnkgaG90cGx1ZyByYW0g
YmxvY2tzIG5lZWQgdG8gYmUNCmVuY3J5cHRlZC4NCg0KQWxzbywgbm90aWZ5IGxpc3RlbmVycyB3
aGVuIGZyZWVpbmcgYSBNZW1vcnlSZWdpb24gaWYgaXQgaGFzIGVuY3J5cHRlZA0KZGF0YS4NCg0K
U2lnbmVkLW9mZi1ieTogSmFuYWthcmFqYW4gTmF0YXJhamFuIDxKYW5ha2FyYWphbi5OYXRhcmFq
YW5AYW1kLmNvbT4NCi0tLQ0KIGV4ZWMuYyAgICAgICAgICAgICAgICAgfCA1ICsrKysrDQogaHcv
aTM4Ni9wYy5jICAgICAgICAgICB8IDEgKw0KIGh3L2kzODYvcGNfc3lzZncuYyAgICAgfCAyICsr
DQogaHcvbWVtL21lbW9yeS1kZXZpY2UuYyB8IDEgKw0KIDQgZmlsZXMgY2hhbmdlZCwgOSBpbnNl
cnRpb25zKCspDQoNCmRpZmYgLS1naXQgYS9leGVjLmMgYi9leGVjLmMNCmluZGV4IGEwMmMzOTRl
NDguLjI1YmU4Zjg0ZjMgMTAwNjQ0DQotLS0gYS9leGVjLmMNCisrKyBiL2V4ZWMuYw0KQEAgLTI0
NDIsNiArMjQ0MiwxMSBAQCB2b2lkIHFlbXVfcmFtX2ZyZWUoUkFNQmxvY2sgKmJsb2NrKQ0KICAg
ICB9DQogDQogICAgIGlmIChibG9jay0+aG9zdCkgew0KKyAgICAgICAgLyogTm90aWZ5IG9ubHkg
aWYgZW5jcnlwdGVkICovDQorICAgICAgICBpZiAobWVtb3J5X3JlZ2lvbl9pc19lbmNyeXB0ZWQo
YmxvY2stPm1yKSkgew0KKyAgICAgICAgICAgIHJhbV9ibG9ja19lbmNyeXB0ZWRfbm90aWZ5X3Jl
bW92ZShibG9jay0+aG9zdCwgYmxvY2stPm1heF9sZW5ndGgpOw0KKyAgICAgICAgfQ0KKw0KICAg
ICAgICAgcmFtX2Jsb2NrX25vdGlmeV9yZW1vdmUoYmxvY2stPmhvc3QsIGJsb2NrLT5tYXhfbGVu
Z3RoKTsNCiAgICAgfQ0KIA0KZGlmZiAtLWdpdCBhL2h3L2kzODYvcGMuYyBiL2h3L2kzODYvcGMu
Yw0KaW5kZXggZjJjMTViZjFmMi4uM2FmMzA5NDU0MyAxMDA2NDQNCi0tLSBhL2h3L2kzODYvcGMu
Yw0KKysrIGIvaHcvaTM4Ni9wYy5jDQpAQCAtMTc0MCw2ICsxNzQwLDcgQEAgdm9pZCBwY19tZW1v
cnlfaW5pdChQQ01hY2hpbmVTdGF0ZSAqcGNtcywNCiAgICAgcmFtID0gZ19tYWxsb2Moc2l6ZW9m
KCpyYW0pKTsNCiAgICAgbWVtb3J5X3JlZ2lvbl9hbGxvY2F0ZV9zeXN0ZW1fbWVtb3J5KHJhbSwg
TlVMTCwgInBjLnJhbSIsDQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBtYWNoaW5lLT5yYW1fc2l6ZSk7DQorICAgIG1lbW9yeV9yZWdpb25fbWFya19lbmNyeXB0ZWQo
cmFtKTsNCiAgICAgKnJhbV9tZW1vcnkgPSByYW07DQogICAgIHJhbV9iZWxvd180ZyA9IGdfbWFs
bG9jKHNpemVvZigqcmFtX2JlbG93XzRnKSk7DQogICAgIG1lbW9yeV9yZWdpb25faW5pdF9hbGlh
cyhyYW1fYmVsb3dfNGcsIE5VTEwsICJyYW0tYmVsb3ctNGciLCByYW0sDQpkaWZmIC0tZ2l0IGEv
aHcvaTM4Ni9wY19zeXNmdy5jIGIvaHcvaTM4Ni9wY19zeXNmdy5jDQppbmRleCBjNjI4NTQwNzc0
Li40MGQ3ZGE1ZmY2IDEwMDY0NA0KLS0tIGEvaHcvaTM4Ni9wY19zeXNmdy5jDQorKysgYi9ody9p
Mzg2L3BjX3N5c2Z3LmMNCkBAIC0xOTksNiArMTk5LDggQEAgc3RhdGljIHZvaWQgcGNfc3lzdGVt
X2ZsYXNoX21hcChQQ01hY2hpbmVTdGF0ZSAqcGNtcywNCiANCiAgICAgICAgICAgICAvKiBFbmNy
eXB0IHRoZSBwZmxhc2ggYm9vdCBST00gKi8NCiAgICAgICAgICAgICBpZiAoa3ZtX21lbWNyeXB0
X2VuYWJsZWQoKSkgew0KKyAgICAgICAgICAgICAgICAvKiBNYXJrIHBmbGFzaCB1bml0IDAgYXMg
ZW5jcnlwdGVkLiBUaGlzIHdpbGwgcGluIHRoZSBwYWdlcyAqLw0KKyAgICAgICAgICAgICAgICBt
ZW1vcnlfcmVnaW9uX21hcmtfZW5jcnlwdGVkKGZsYXNoX21lbSk7DQogICAgICAgICAgICAgICAg
IGZsYXNoX3B0ciA9IG1lbW9yeV9yZWdpb25fZ2V0X3JhbV9wdHIoZmxhc2hfbWVtKTsNCiAgICAg
ICAgICAgICAgICAgZmxhc2hfc2l6ZSA9IG1lbW9yeV9yZWdpb25fc2l6ZShmbGFzaF9tZW0pOw0K
ICAgICAgICAgICAgICAgICByZXQgPSBrdm1fbWVtY3J5cHRfZW5jcnlwdF9kYXRhKGZsYXNoX3B0
ciwgZmxhc2hfc2l6ZSk7DQpkaWZmIC0tZ2l0IGEvaHcvbWVtL21lbW9yeS1kZXZpY2UuYyBiL2h3
L21lbS9tZW1vcnktZGV2aWNlLmMNCmluZGV4IDVmMmM0MDgwMzYuLmIyZTc3Nzc0ZDQgMTAwNjQ0
DQotLS0gYS9ody9tZW0vbWVtb3J5LWRldmljZS5jDQorKysgYi9ody9tZW0vbWVtb3J5LWRldmlj
ZS5jDQpAQCAtMjk1LDYgKzI5NSw3IEBAIHZvaWQgbWVtb3J5X2RldmljZV9wbHVnKE1lbW9yeURl
dmljZVN0YXRlICptZCwgTWFjaGluZVN0YXRlICptcykNCiANCiAgICAgbWVtb3J5X3JlZ2lvbl9h
ZGRfc3VicmVnaW9uKCZtcy0+ZGV2aWNlX21lbW9yeS0+bXIsDQogICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBhZGRyIC0gbXMtPmRldmljZV9tZW1vcnktPmJhc2UsIG1yKTsNCisgICAg
bWVtb3J5X3JlZ2lvbl9tYXJrX2VuY3J5cHRlZChtcik7DQogICAgIHRyYWNlX21lbW9yeV9kZXZp
Y2VfcGx1ZyhERVZJQ0UobWQpLT5pZCA/IERFVklDRShtZCktPmlkIDogIiIsIGFkZHIpOw0KIH0N
CiANCi0tIA0KMi4yMC4xDQoNCg==

