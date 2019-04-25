Return-Path: <SRS0=QtPl=S4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55124C43218
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 07:27:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C999206E0
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 07:27:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="d/hcSk58"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C999206E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40843 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJvGi-0004x7-AO
	for qemu-devel@archiver.kernel.org; Fri, 26 Apr 2019 03:27:36 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45795)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Janakarajan.Natarajan@amd.com>) id 1hJnPt-0000sW-Sh
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 19:04:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Janakarajan.Natarajan@amd.com>) id 1hJnK1-0000TG-3i
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 18:58:31 -0400
Received: from mail-eopbgr730086.outbound.protection.outlook.com
	([40.107.73.86]:18512
	helo=NAM05-DM3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Janakarajan.Natarajan@amd.com>)
	id 1hJnK0-0008Tp-U8
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 18:58:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=AgqdD6kckmnGWDK3dLu7nHaxf4DCngxnUzmWrb4JS+U=;
	b=d/hcSk58Zeff+pK7f3UjT3K3eUKziH4nY1ugTZw4eHq9eYHk6bwjsDHTrE5TuTEm/BHJjambavVA17KoUkpNh++aLwzYf+CAHt4/p4HBDBqfRmU8dcLpPDeVrVmwcoMyhJEIXLsAs23PQgAsAZCXQekvTLfnsjLktFb67NPZ49k=
Received: from SN6PR12MB2736.namprd12.prod.outlook.com (52.135.107.27) by
	SN6PR12MB2752.namprd12.prod.outlook.com (52.135.107.32) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1835.13; Thu, 25 Apr 2019 22:58:19 +0000
Received: from SN6PR12MB2736.namprd12.prod.outlook.com
	([fe80::65cb:af55:6bd4:55a]) by SN6PR12MB2736.namprd12.prod.outlook.com
	([fe80::65cb:af55:6bd4:55a%4]) with mapi id 15.20.1835.010;
	Thu, 25 Apr 2019 22:58:19 +0000
From: "Natarajan, Janakarajan" <Janakarajan.Natarajan@amd.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Thread-Topic: [PATCH 1/3] ram-encrypted-notifier: Introduce a RAM block
	encrypted notifier
Thread-Index: AQHU+7pfUbGsMaOONk2PjUweDqC9Xg==
Date: Thu, 25 Apr 2019 22:58:18 +0000
Message-ID: <20190425225610.28350-2-Janakarajan.Natarajan@amd.com>
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
x-ms-office365-filtering-correlation-id: ce883240-f058-44d4-f359-08d6c9d181dd
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);
	SRVR:SN6PR12MB2752; 
x-ms-traffictypediagnostic: SN6PR12MB2752:
x-microsoft-antispam-prvs: <SN6PR12MB2752A53F28C6997D7DF56046E73D0@SN6PR12MB2752.namprd12.prod.outlook.com>
x-forefront-prvs: 0018A2705B
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10009020)(376002)(366004)(396003)(346002)(136003)(39860400002)(189003)(199004)(256004)(99286004)(2351001)(81156014)(316002)(11346002)(68736007)(81166006)(2616005)(71200400001)(71190400001)(476003)(446003)(1076003)(486006)(478600001)(14454004)(72206003)(54906003)(53936002)(8676002)(4326008)(14444005)(76176011)(6506007)(305945005)(6916009)(2906002)(7736002)(386003)(66946007)(5640700003)(6436002)(64756008)(66476007)(66446008)(6486002)(25786009)(73956011)(66556008)(2501003)(26005)(186003)(86362001)(50226002)(102836004)(8936002)(6116002)(5660300002)(3846002)(6512007)(52116002)(97736004)(66066001)(36756003);
	DIR:OUT; SFP:1101; SCL:1; SRVR:SN6PR12MB2752;
	H:SN6PR12MB2736.namprd12.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: dzmcyd2+WmXK5wKH63zt57EaSPWwAJGzNCQc2qPQU2DLyv9+HGQRtBCDGEgb+OWbBLeKYjgp8EwRwJYTJoz1SkS5/JExU+0rRpbg8seyGg4zgqdcxNOQjK8sWYl39caeQiE6b/0Fo3819VfjPNJ9rkFEe2lZUC4B4TB07e3Va4SVMEm1VBR+eZrCu62BpapoMO6c6VdXj7HjjGu+6sGP6EPxlAI8qPZHZYQ88iUGVVxbJpIAStiD4+hLCnnrSB4qnv21F2ylEs/3LLyP98Zp4aiPI7WMe4kzGe8sMgaGuNla9fNrzpfCS1qZOE7txqgtSowa229DDQNan0TNzy/g5Hzi9sy3yuXRsYB1Srjb+xB82+51WmpTIhYbZ8pLE5FfUSEMNU7Y6pJLyne/JQs+foHEdwL+c5bRPJPBq9VuWLQ=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce883240-f058-44d4-f359-08d6c9d181dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2019 22:58:18.7110 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2752
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.73.86
X-Mailman-Approved-At: Fri, 26 Apr 2019 03:24:01 -0400
Subject: [Qemu-devel] [PATCH 1/3] ram-encrypted-notifier: Introduce a RAM
 block encrypted notifier
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
Message-ID: <20190425225818.s32ymEP_FUkoMAS97KctNn8X0qAhsooTC0T6t3DOIyU@z>

QSBjbGllbnQgY2FuIHJlZ2lzdGVyIHRvIHRoaXMgbm90aWZpZXIgdG8ga25vdyB3aGV0aGVyIHRo
ZSBuZXdseSBhZGRlZCBvcg0KcmVtb3ZlZCBtZW1vcnkgcmVnaW9uIGlzIG1hcmtlZCBhcyBlbmNy
eXB0ZWQuIFRoaXMgaW5mb3JtYXRpb24gaXMgbmVlZGVkDQpmb3IgdGhlIFNFViBndWVzdCBsYXVu
Y2guIEluIFNFViBndWVzdCwgc29tZSBtZW1vcnkgcmVnaW9ucyBtYXkgY29udGFpbg0KZW5jcnlw
dGVkIGRhdGEgKGUuZyBndWVzdCBSQU0pLiBUaGUgbWVtb3J5IHJlZ2lvbiB3aGljaCBjb250YWlu
cyB0aGUNCmVuY3J5cHRlZCBkYXRhIHNob3VsZCBiZSByZWdpc3RlcmVkL3VucmVnaXN0ZXJlZCB1
c2luZyB0aGUNCktWTV9NRU1PUllfe1JFRyxVTlJFR31fRU5DUllQVEVEIGlvY3RsLg0KDQpTaWdu
ZWQtb2ZmLWJ5OiBKYW5ha2FyYWphbiBOYXRhcmFqYW4gPEphbmFrYXJhamFuLk5hdGFyYWphbkBh
bWQuY29tPg0KLS0tDQogZXhlYy5jICAgICAgICAgICAgICAgICB8ICAxICsNCiBpbmNsdWRlL2V4
ZWMvbWVtb3J5LmggIHwgMTggKysrKysrKysrKysrKysrKysrDQogaW5jbHVkZS9leGVjL3JhbWxp
c3QuaCB8IDE5ICsrKysrKysrKysrKysrKysrKysNCiBtZW1vcnkuYyAgICAgICAgICAgICAgIHwg
MTYgKysrKysrKysrKysrKysrKw0KIG51bWEuYyAgICAgICAgICAgICAgICAgfCAzMyArKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysNCiBzdHVicy9yYW0tYmxvY2suYyAgICAgIHwgIDgg
KysrKysrKysNCiA2IGZpbGVzIGNoYW5nZWQsIDk1IGluc2VydGlvbnMoKykNCg0KZGlmZiAtLWdp
dCBhL2V4ZWMuYyBiL2V4ZWMuYw0KaW5kZXggMjY0NjIwNzY2MS4uYTAyYzM5NGU0OCAxMDA2NDQN
Ci0tLSBhL2V4ZWMuYw0KKysrIGIvZXhlYy5jDQpAQCAtNzksNiArNzksNyBAQA0KICAqIGFyZSBw
cm90ZWN0ZWQgYnkgdGhlIHJhbWxpc3QgbG9jay4NCiAgKi8NCiBSQU1MaXN0IHJhbV9saXN0ID0g
eyAuYmxvY2tzID0gUUxJU1RfSEVBRF9JTklUSUFMSVpFUihyYW1fbGlzdC5ibG9ja3MpIH07DQor
UkFNQmxvY2tFbmNyeXB0ZWROb3RpZmllckxpc3QgcmFtX2Jsb2NrX2VuY3J5cHRlZF9ub3RpZmll
cl9saXN0Ow0KIA0KIHN0YXRpYyBNZW1vcnlSZWdpb24gKnN5c3RlbV9tZW1vcnk7DQogc3RhdGlj
IE1lbW9yeVJlZ2lvbiAqc3lzdGVtX2lvOw0KZGlmZiAtLWdpdCBhL2luY2x1ZGUvZXhlYy9tZW1v
cnkuaCBiL2luY2x1ZGUvZXhlYy9tZW1vcnkuaA0KaW5kZXggOTE0NGE0N2Y1Ny4uYWU3MjBmZjUx
MSAxMDA2NDQNCi0tLSBhL2luY2x1ZGUvZXhlYy9tZW1vcnkuaA0KKysrIGIvaW5jbHVkZS9leGVj
L21lbW9yeS5oDQpAQCAtMzc0LDYgKzM3NCw3IEBAIHN0cnVjdCBNZW1vcnlSZWdpb24gew0KICAg
ICBib29sIHRlcm1pbmF0ZXM7DQogICAgIGJvb2wgcmFtX2RldmljZTsNCiAgICAgYm9vbCBlbmFi
bGVkOw0KKyAgICBib29sIGVuY3J5cHRlZDsNCiAgICAgYm9vbCB3YXJuaW5nX3ByaW50ZWQ7IC8q
IEZvciByZXNlcnZhdGlvbnMgKi8NCiAgICAgdWludDhfdCB2Z2FfbG9nZ2luZ19jb3VudDsNCiAg
ICAgTWVtb3J5UmVnaW9uICphbGlhczsNCkBAIC0xMTMxLDYgKzExMzIsMjMgQEAgaW50IG1lbW9y
eV9yZWdpb25faW9tbXVfYXR0cnNfdG9faW5kZXgoSU9NTVVNZW1vcnlSZWdpb24gKmlvbW11X21y
LA0KICAqLw0KIGludCBtZW1vcnlfcmVnaW9uX2lvbW11X251bV9pbmRleGVzKElPTU1VTWVtb3J5
UmVnaW9uICppb21tdV9tcik7DQogDQorLyoqDQorICogbWVtb3J5X3JlZ2lvbl9tYXJrX2VuY3J5
cHRlZDogbWFya3MgdGhlIG1lbW9yeSByZWdpb24gYXMgZW5jcnlwdGVkIGFuZA0KKyAqIGxldHMg
dGhlIGxpc3RlbmVycyBvZiBlbmNyeXB0ZWQgcmFtIGtub3cgdGhhdCBhIG1lbW9yeSByZWdpb24g
Y29udGFpbmluZw0KKyAqIGVuY3J5cHRlZCByYW0gYmxvY2sgaGFzIGJlZW4gYWRkZWQNCisgKg0K
KyAqIEBtcjogdGhlIG1lbW9yeSByZWdpb24NCisgKi8NCit2b2lkIG1lbW9yeV9yZWdpb25fbWFy
a19lbmNyeXB0ZWQoTWVtb3J5UmVnaW9uICptcik7DQorDQorLyoqDQorICogbWVtb3J5X3JlZ2lv
bl9pc19lbmNyeXB0ZWQ6IHJldHVybnMgaWYgdGhlIG1lbW9yeSByZWdpb24gd2FzIG1hcmtlZCBh
cw0KKyAqIGVuY3J5cHRlZCB3aGVuIGl0IHdhcyBjcmVhdGVkDQorICoNCisgKiBAbXI6IHRoZSBt
ZW1vcnkgcmVnaW9uDQorICovDQorYm9vbCBtZW1vcnlfcmVnaW9uX2lzX2VuY3J5cHRlZChNZW1v
cnlSZWdpb24gKm1yKTsNCisNCiAvKioNCiAgKiBtZW1vcnlfcmVnaW9uX25hbWU6IGdldCBhIG1l
bW9yeSByZWdpb24ncyBuYW1lDQogICoNCmRpZmYgLS1naXQgYS9pbmNsdWRlL2V4ZWMvcmFtbGlz
dC5oIGIvaW5jbHVkZS9leGVjL3JhbWxpc3QuaA0KaW5kZXggYmM0ZmFhMWIwMC4uNTM0OWYyN2Zh
NSAxMDA2NDQNCi0tLSBhL2luY2x1ZGUvZXhlYy9yYW1saXN0LmgNCisrKyBiL2luY2x1ZGUvZXhl
Yy9yYW1saXN0LmgNCkBAIC03LDYgKzcsNyBAQA0KICNpbmNsdWRlICJxZW11L3JjdV9xdWV1ZS5o
Ig0KIA0KIHR5cGVkZWYgc3RydWN0IFJBTUJsb2NrTm90aWZpZXIgUkFNQmxvY2tOb3RpZmllcjsN
Cit0eXBlZGVmIHN0cnVjdCBSQU1CbG9ja0VuY3J5cHRlZE5vdGlmaWVyIFJBTUJsb2NrRW5jcnlw
dGVkTm90aWZpZXI7DQogDQogI2RlZmluZSBESVJUWV9NRU1PUllfVkdBICAgICAgIDANCiAjZGVm
aW5lIERJUlRZX01FTU9SWV9DT0RFICAgICAgMQ0KQEAgLTU1LDYgKzU2LDExIEBAIHR5cGVkZWYg
c3RydWN0IFJBTUxpc3Qgew0KIH0gUkFNTGlzdDsNCiBleHRlcm4gUkFNTGlzdCByYW1fbGlzdDsN
CiANCit0eXBlZGVmIHN0cnVjdCBSQU1CbG9ja0VuY3J5cHRlZE5vdGlmaWVyTGlzdCB7DQorICAg
IFFMSVNUX0hFQUQoLCBSQU1CbG9ja0VuY3J5cHRlZE5vdGlmaWVyKSByYW1fYmxvY2tfbm90aWZp
ZXJzOw0KK30gUkFNQmxvY2tFbmNyeXB0ZWROb3RpZmllckxpc3Q7DQorZXh0ZXJuIFJBTUJsb2Nr
RW5jcnlwdGVkTm90aWZpZXJMaXN0IHJhbV9ibG9ja19lbmNyeXB0ZWRfbm90aWZpZXJfbGlzdDsN
CisNCiAvKiBTaG91bGQgYmUgaG9sZGluZyBlaXRoZXIgcmFtX2xpc3QubXV0ZXgsIG9yIHRoZSBS
Q1UgbG9jay4gKi8NCiAjZGVmaW5lICBJTlRFUk5BTF9SQU1CTE9DS19GT1JFQUNIKGJsb2NrKSAg
XA0KICAgICBRTElTVF9GT1JFQUNIX1JDVShibG9jaywgJnJhbV9saXN0LmJsb2NrcywgbmV4dCkN
CkBAIC03MCw2ICs3NiwxNCBAQCBzdHJ1Y3QgUkFNQmxvY2tOb3RpZmllciB7DQogICAgIFFMSVNU
X0VOVFJZKFJBTUJsb2NrTm90aWZpZXIpIG5leHQ7DQogfTsNCiANCitzdHJ1Y3QgUkFNQmxvY2tF
bmNyeXB0ZWROb3RpZmllciB7DQorICAgIHZvaWQgKCpyYW1fYmxvY2tfZW5jcnlwdGVkX2FkZGVk
KShSQU1CbG9ja0VuY3J5cHRlZE5vdGlmaWVyICpuLA0KKyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgdm9pZCAqaG9zdCwgc2l6ZV90IHNpemUpOw0KKyAgICB2b2lkICgqcmFt
X2Jsb2NrX2VuY3J5cHRlZF9yZW1vdmVkKShSQU1CbG9ja0VuY3J5cHRlZE5vdGlmaWVyICpuLA0K
KyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB2b2lkICpob3N0LCBzaXpl
X3Qgc2l6ZSk7DQorICAgIFFMSVNUX0VOVFJZKFJBTUJsb2NrRW5jcnlwdGVkTm90aWZpZXIpIG5l
eHQ7DQorfTsNCisNCiB2b2lkIHJhbV9ibG9ja19ub3RpZmllcl9hZGQoUkFNQmxvY2tOb3RpZmll
ciAqbik7DQogdm9pZCByYW1fYmxvY2tfbm90aWZpZXJfcmVtb3ZlKFJBTUJsb2NrTm90aWZpZXIg
Km4pOw0KIHZvaWQgcmFtX2Jsb2NrX25vdGlmeV9hZGQodm9pZCAqaG9zdCwgc2l6ZV90IHNpemUp
Ow0KQEAgLTc3LDQgKzkxLDkgQEAgdm9pZCByYW1fYmxvY2tfbm90aWZ5X3JlbW92ZSh2b2lkICpo
b3N0LCBzaXplX3Qgc2l6ZSk7DQogDQogdm9pZCByYW1fYmxvY2tfZHVtcChNb25pdG9yICptb24p
Ow0KIA0KK3ZvaWQgcmFtX2Jsb2NrX2VuY3J5cHRlZF9ub3RpZmllcl9hZGQoUkFNQmxvY2tFbmNy
eXB0ZWROb3RpZmllciAqbik7DQordm9pZCByYW1fYmxvY2tfZW5jcnlwdGVkX25vdGlmaWVyX3Jl
bW92ZShSQU1CbG9ja0VuY3J5cHRlZE5vdGlmaWVyICpuKTsNCit2b2lkIHJhbV9ibG9ja19lbmNy
eXB0ZWRfbm90aWZ5X2FkZCh2b2lkICpob3N0LCBzaXplX3Qgc2l6ZSk7DQordm9pZCByYW1fYmxv
Y2tfZW5jcnlwdGVkX25vdGlmeV9yZW1vdmUodm9pZCAqaG9zdCwgc2l6ZV90IHNpemUpOw0KKw0K
ICNlbmRpZiAvKiBSQU1MSVNUX0ggKi8NCmRpZmYgLS1naXQgYS9tZW1vcnkuYyBiL21lbW9yeS5j
DQppbmRleCBiYjJiNzFlZTM4Li5lY2EwMmQzNjliIDEwMDY0NA0KLS0tIGEvbWVtb3J5LmMNCisr
KyBiL21lbW9yeS5jDQpAQCAtMjAwOSw2ICsyMDA5LDIyIEBAIGludCBtZW1vcnlfcmVnaW9uX2lv
bW11X251bV9pbmRleGVzKElPTU1VTWVtb3J5UmVnaW9uICppb21tdV9tcikNCiAgICAgcmV0dXJu
IGltcmMtPm51bV9pbmRleGVzKGlvbW11X21yKTsNCiB9DQogDQordm9pZCBtZW1vcnlfcmVnaW9u
X21hcmtfZW5jcnlwdGVkKE1lbW9yeVJlZ2lvbiAqbXIpDQorew0KKyAgICBSQU1CbG9jayAqYmxv
Y2sgPSBtci0+cmFtX2Jsb2NrOw0KKw0KKyAgICBtci0+ZW5jcnlwdGVkID0ga3ZtX21lbWNyeXB0
X2VuYWJsZWQoKTsNCisNCisgICAgaWYgKG1yLT5lbmNyeXB0ZWQpIHsNCisgICAgICAgIHJhbV9i
bG9ja19lbmNyeXB0ZWRfbm90aWZ5X2FkZChibG9jay0+aG9zdCwgYmxvY2stPm1heF9sZW5ndGgp
Ow0KKyAgICB9DQorfQ0KKw0KK2Jvb2wgbWVtb3J5X3JlZ2lvbl9pc19lbmNyeXB0ZWQoTWVtb3J5
UmVnaW9uICptcikNCit7DQorICAgIHJldHVybiBtci0+ZW5jcnlwdGVkOw0KK30NCisNCiB2b2lk
IG1lbW9yeV9yZWdpb25fc2V0X2xvZyhNZW1vcnlSZWdpb24gKm1yLCBib29sIGxvZywgdW5zaWdu
ZWQgY2xpZW50KQ0KIHsNCiAgICAgdWludDhfdCBtYXNrID0gMSA8PCBjbGllbnQ7DQpkaWZmIC0t
Z2l0IGEvbnVtYS5jIGIvbnVtYS5jDQppbmRleCAzODc1ZTFlZmRhLi4wODYwMTM2NmM1IDEwMDY0
NA0KLS0tIGEvbnVtYS5jDQorKysgYi9udW1hLmMNCkBAIC02MzgsNiArNjM4LDM5IEBAIE1lbWRl
dkxpc3QgKnFtcF9xdWVyeV9tZW1kZXYoRXJyb3IgKiplcnJwKQ0KICAgICByZXR1cm4gbGlzdDsN
CiB9DQogDQordm9pZCByYW1fYmxvY2tfZW5jcnlwdGVkX25vdGlmaWVyX2FkZChSQU1CbG9ja0Vu
Y3J5cHRlZE5vdGlmaWVyICpuKQ0KK3sNCisgICAgUUxJU1RfSU5TRVJUX0hFQUQoJnJhbV9ibG9j
a19lbmNyeXB0ZWRfbm90aWZpZXJfbGlzdC5yYW1fYmxvY2tfbm90aWZpZXJzLA0KKyAgICAgICAg
ICAgICAgICAgICAgICBuLCBuZXh0KTsNCit9DQorDQordm9pZCByYW1fYmxvY2tfZW5jcnlwdGVk
X25vdGlmaWVyX3JlbW92ZShSQU1CbG9ja0VuY3J5cHRlZE5vdGlmaWVyICpuKQ0KK3sNCisgICAg
UUxJU1RfUkVNT1ZFKG4sIG5leHQpOw0KK30NCisNCit2b2lkIHJhbV9ibG9ja19lbmNyeXB0ZWRf
bm90aWZ5X2FkZCh2b2lkICpob3N0LCBzaXplX3Qgc2l6ZSkNCit7DQorICAgIFJBTUJsb2NrRW5j
cnlwdGVkTm90aWZpZXIgKm5vdGlmaWVyOw0KKw0KKyAgICBRTElTVF9GT1JFQUNIKG5vdGlmaWVy
LA0KKyAgICAgICAgICAgICAgICAgICZyYW1fYmxvY2tfZW5jcnlwdGVkX25vdGlmaWVyX2xpc3Qu
cmFtX2Jsb2NrX25vdGlmaWVycywNCisgICAgICAgICAgICAgICAgICBuZXh0KSB7DQorICAgICAg
ICBub3RpZmllci0+cmFtX2Jsb2NrX2VuY3J5cHRlZF9hZGRlZChub3RpZmllciwgaG9zdCwgc2l6
ZSk7DQorICAgIH0NCit9DQorDQordm9pZCByYW1fYmxvY2tfZW5jcnlwdGVkX25vdGlmeV9yZW1v
dmUodm9pZCAqaG9zdCwgc2l6ZV90IHNpemUpDQorew0KKyAgICBSQU1CbG9ja0VuY3J5cHRlZE5v
dGlmaWVyICpub3RpZmllcjsNCisNCisgICAgUUxJU1RfRk9SRUFDSChub3RpZmllciwNCisgICAg
ICAgICAgICAgICAgICAmcmFtX2Jsb2NrX2VuY3J5cHRlZF9ub3RpZmllcl9saXN0LnJhbV9ibG9j
a19ub3RpZmllcnMsDQorICAgICAgICAgICAgICAgICAgbmV4dCkgew0KKyAgICAgICAgbm90aWZp
ZXItPnJhbV9ibG9ja19lbmNyeXB0ZWRfcmVtb3ZlZChub3RpZmllciwgaG9zdCwgc2l6ZSk7DQor
ICAgIH0NCit9DQorDQogdm9pZCByYW1fYmxvY2tfbm90aWZpZXJfYWRkKFJBTUJsb2NrTm90aWZp
ZXIgKm4pDQogew0KICAgICBRTElTVF9JTlNFUlRfSEVBRCgmcmFtX2xpc3QucmFtYmxvY2tfbm90
aWZpZXJzLCBuLCBuZXh0KTsNCmRpZmYgLS1naXQgYS9zdHVicy9yYW0tYmxvY2suYyBiL3N0dWJz
L3JhbS1ibG9jay5jDQppbmRleCA3M2MwYTNlZTA4Li4wZjY4OTIyZmViIDEwMDY0NA0KLS0tIGEv
c3R1YnMvcmFtLWJsb2NrLmMNCisrKyBiL3N0dWJzL3JhbS1ibG9jay5jDQpAQCAtMjUsNiArMjUs
MTQgQEAgdm9pZCByYW1fYmxvY2tfbm90aWZpZXJfcmVtb3ZlKFJBTUJsb2NrTm90aWZpZXIgKm4p
DQogew0KIH0NCiANCit2b2lkIHJhbV9ibG9ja19lbmNyeXB0ZWRfbm90aWZpZXJfYWRkKFJBTUJs
b2NrRW5jcnlwdGVkTm90aWZpZXIgKm4pDQorew0KK30NCisNCit2b2lkIHJhbV9ibG9ja19lbmNy
eXB0ZWRfbm90aWZpZXJfcmVtb3ZlKFJBTUJsb2NrRW5jcnlwdGVkTm90aWZpZXIgKm4pDQorew0K
K30NCisNCiBpbnQgcWVtdV9yYW1fZm9yZWFjaF9ibG9jayhSQU1CbG9ja0l0ZXJGdW5jIGZ1bmMs
IHZvaWQgKm9wYXF1ZSkNCiB7DQogICAgIHJldHVybiAwOw0KLS0gDQoyLjIwLjENCg0K

