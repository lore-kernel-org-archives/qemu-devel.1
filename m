Return-Path: <SRS0=QtPl=S4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FC14C43218
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 07:25:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3845D206E0
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 07:25:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="MGJe5sV7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3845D206E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40831 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJvEp-00032K-OA
	for qemu-devel@archiver.kernel.org; Fri, 26 Apr 2019 03:25:39 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45827)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Janakarajan.Natarajan@amd.com>) id 1hJnPs-0000sy-MH
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 19:04:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Janakarajan.Natarajan@amd.com>) id 1hJnK1-0000XR-TH
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 18:58:31 -0400
Received: from mail-eopbgr730086.outbound.protection.outlook.com
	([40.107.73.86]:18512
	helo=NAM05-DM3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Janakarajan.Natarajan@amd.com>)
	id 1hJnK1-0008Tp-KZ
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 18:58:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=c2P3uEZ3kAZf80Y9GmRli0svyzzkvQ+9J6QBBgDLDZU=;
	b=MGJe5sV7/QohLDKicdsESpuQqC6oCD+AtX6kctJt5DWatQ5DkiWlq4UCfKK7Uaz8CEMpHKyjvmAs5eyva4/L73XejeHoKdr01Syd552IOy7BuhnHDLre1PfMzQZkjlw5s/hQRKRQH8wyp8k9SoGmUMd2Nh/OVpdHThuA4C5w+U8=
Received: from SN6PR12MB2736.namprd12.prod.outlook.com (52.135.107.27) by
	SN6PR12MB2752.namprd12.prod.outlook.com (52.135.107.32) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1835.13; Thu, 25 Apr 2019 22:58:20 +0000
Received: from SN6PR12MB2736.namprd12.prod.outlook.com
	([fe80::65cb:af55:6bd4:55a]) by SN6PR12MB2736.namprd12.prod.outlook.com
	([fe80::65cb:af55:6bd4:55a%4]) with mapi id 15.20.1835.010;
	Thu, 25 Apr 2019 22:58:20 +0000
From: "Natarajan, Janakarajan" <Janakarajan.Natarajan@amd.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Thread-Topic: [PATCH 3/3] sev: Change SEV to use EncryptedRAMBlock Notifier
Thread-Index: AQHU+7pgyQ2ttP00hE6cLK0uTTt6AA==
Date: Thu, 25 Apr 2019 22:58:20 +0000
Message-ID: <20190425225610.28350-4-Janakarajan.Natarajan@amd.com>
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
x-ms-office365-filtering-correlation-id: 159e3312-4ec1-4c48-7c26-08d6c9d182a0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);
	SRVR:SN6PR12MB2752; 
x-ms-traffictypediagnostic: SN6PR12MB2752:
x-microsoft-antispam-prvs: <SN6PR12MB2752798246B03A5F73CCFB51E73D0@SN6PR12MB2752.namprd12.prod.outlook.com>
x-forefront-prvs: 0018A2705B
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10009020)(376002)(366004)(396003)(346002)(136003)(39860400002)(189003)(199004)(256004)(99286004)(2351001)(81156014)(316002)(11346002)(68736007)(81166006)(2616005)(71200400001)(71190400001)(476003)(446003)(1076003)(486006)(478600001)(14454004)(72206003)(54906003)(53936002)(8676002)(4326008)(76176011)(6506007)(305945005)(6916009)(2906002)(7736002)(386003)(66946007)(5640700003)(6436002)(64756008)(66476007)(66446008)(6486002)(25786009)(73956011)(66556008)(2501003)(26005)(186003)(86362001)(50226002)(102836004)(8936002)(6116002)(5660300002)(3846002)(6512007)(52116002)(97736004)(66066001)(36756003);
	DIR:OUT; SFP:1101; SCL:1; SRVR:SN6PR12MB2752;
	H:SN6PR12MB2736.namprd12.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: cgDn/8OI6loUHDNvAWJ1/3HD8+4THLeealSGqYJzbm8nDhDkroxPAGe8D3FqBQDaj91qFRnINBw9uMqMhhlM2WEAoHenktzLMXgkc7kcupO0BD2RJ54cGPZVAPI5WOmUpJjNw3YVh8CdQzpClF2BJK+y3Sj24aJNkk2UarYzFPWA47+fU+Et8bt77GnjT5K99pIbtsCmdmkbjK40ics3TfSHZZkDesKOkmpZsF67aPCxlUT3J5MYEAiS7nEQj7HPOfC3vdnktAKXzOBARAo9u8kVxXZ3xhATRlPZhqtXAkIr1wrnzPpq+c9qoUbrim4boNvUVWxtgv1oaiJcAh7XMBiWRJx/uBMnWep/eGxTxx8bRWuS7s1S2er/+ONNBY1+Bf2v+QZiydmo0NJ0nuTpCjSd46PD+Ud8UlK5lzxQvxQ=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 159e3312-4ec1-4c48-7c26-08d6c9d182a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2019 22:58:20.0630 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2752
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.73.86
X-Mailman-Approved-At: Fri, 26 Apr 2019 03:23:59 -0400
Subject: [Qemu-devel] [PATCH 3/3] sev: Change SEV to use EncryptedRAMBlock
 Notifier
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
Message-ID: <20190425225820.vj92KsEs31UqSrHHPdFru1Z21MR6sDc0NsvlyDyUF14@z>

VGhlIEVuY3J5cHRlZFJBTUJsb2NrIE5vdGlmaWVyIGxldHMgU0VWIGtub3cgd2hpY2ggZ3Vlc3Qg
UkFNIHBhZ2VzDQp3aWxsIGNvbnRhaW4gZW5jcnlwdGVkIGd1ZXN0IGRhdGEuDQoNClVzaW5nIHRo
aXMgbm90aWZpZXIgbGV0cyBTRVYgc2tpcCBwaW5uaW5nIHBhZ2VzIHRoYXQgZG8gbm90IGNvbnRh
aW4NCmVuY3J5cHRlZCBkYXRhLg0KDQpTaWduZWQtb2ZmLWJ5OiBKYW5ha2FyYWphbiBOYXRhcmFq
YW4gPEphbmFrYXJhamFuLk5hdGFyYWphbkBhbWQuY29tPg0KLS0tDQogdGFyZ2V0L2kzODYvc2V2
LmMgfCAyNSArKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tDQogMSBmaWxlIGNoYW5nZWQsIDggaW5z
ZXJ0aW9ucygrKSwgMTcgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS90YXJnZXQvaTM4Ni9z
ZXYuYyBiL3RhcmdldC9pMzg2L3Nldi5jDQppbmRleCBjZDc3ZjZiNWQ0Li42MTBlOTkyZTY0IDEw
MDY0NA0KLS0tIGEvdGFyZ2V0L2kzODYvc2V2LmMNCisrKyBiL3RhcmdldC9pMzg2L3Nldi5jDQpA
QCAtMTI3LDIxICsxMjcsMTEgQEAgc2V2X3NldF9ndWVzdF9zdGF0ZShTZXZTdGF0ZSBuZXdfc3Rh
dGUpDQogfQ0KIA0KIHN0YXRpYyB2b2lkDQotc2V2X3JhbV9ibG9ja19hZGRlZChSQU1CbG9ja05v
dGlmaWVyICpuLCB2b2lkICpob3N0LCBzaXplX3Qgc2l6ZSkNCitzZXZfcmFtX2Jsb2NrX2VuY3J5
cHRlZF9hZGRlZChSQU1CbG9ja0VuY3J5cHRlZE5vdGlmaWVyICpuLA0KKyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIHZvaWQgKmhvc3QsIHNpemVfdCBzaXplKQ0KIHsNCiAgICAgaW50IHI7
DQogICAgIHN0cnVjdCBrdm1fZW5jX3JlZ2lvbiByYW5nZTsNCi0gICAgcmFtX2FkZHJfdCBvZmZz
ZXQ7DQotICAgIE1lbW9yeVJlZ2lvbiAqbXI7DQotDQotICAgIC8qDQotICAgICAqIFRoZSBSQU0g
ZGV2aWNlIHByZXNlbnRzIGEgbWVtb3J5IHJlZ2lvbiB0aGF0IHNob3VsZCBiZSB0cmVhdGVkDQot
ICAgICAqIGFzIElPIHJlZ2lvbiBhbmQgc2hvdWxkIG5vdCBiZSBwaW5uZWQuDQotICAgICAqLw0K
LSAgICBtciA9IG1lbW9yeV9yZWdpb25fZnJvbV9ob3N0KGhvc3QsICZvZmZzZXQpOw0KLSAgICBp
ZiAobXIgJiYgbWVtb3J5X3JlZ2lvbl9pc19yYW1fZGV2aWNlKG1yKSkgew0KLSAgICAgICAgcmV0
dXJuOw0KLSAgICB9DQogDQogICAgIHJhbmdlLmFkZHIgPSAoX191NjQpKHVuc2lnbmVkIGxvbmcp
aG9zdDsNCiAgICAgcmFuZ2Uuc2l6ZSA9IHNpemU7DQpAQCAtMTU2LDcgKzE0Niw4IEBAIHNldl9y
YW1fYmxvY2tfYWRkZWQoUkFNQmxvY2tOb3RpZmllciAqbiwgdm9pZCAqaG9zdCwgc2l6ZV90IHNp
emUpDQogfQ0KIA0KIHN0YXRpYyB2b2lkDQotc2V2X3JhbV9ibG9ja19yZW1vdmVkKFJBTUJsb2Nr
Tm90aWZpZXIgKm4sIHZvaWQgKmhvc3QsIHNpemVfdCBzaXplKQ0KK3Nldl9yYW1fYmxvY2tfZW5j
cnlwdGVkX3JlbW92ZWQoUkFNQmxvY2tFbmNyeXB0ZWROb3RpZmllciAqbiwNCisgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIHZvaWQgKmhvc3QsIHNpemVfdCBzaXplKQ0KIHsNCiAgICAg
aW50IHI7DQogICAgIHN0cnVjdCBrdm1fZW5jX3JlZ2lvbiByYW5nZTsNCkBAIC0xNzIsOSArMTYz
LDkgQEAgc2V2X3JhbV9ibG9ja19yZW1vdmVkKFJBTUJsb2NrTm90aWZpZXIgKm4sIHZvaWQgKmhv
c3QsIHNpemVfdCBzaXplKQ0KICAgICB9DQogfQ0KIA0KLXN0YXRpYyBzdHJ1Y3QgUkFNQmxvY2tO
b3RpZmllciBzZXZfcmFtX25vdGlmaWVyID0gew0KLSAgICAucmFtX2Jsb2NrX2FkZGVkID0gc2V2
X3JhbV9ibG9ja19hZGRlZCwNCi0gICAgLnJhbV9ibG9ja19yZW1vdmVkID0gc2V2X3JhbV9ibG9j
a19yZW1vdmVkLA0KK3N0YXRpYyBzdHJ1Y3QgUkFNQmxvY2tFbmNyeXB0ZWROb3RpZmllciBzZXZf
cmFtX2VuY3J5cHRlZF9ub3RpZmllciA9IHsNCisgICAgLnJhbV9ibG9ja19lbmNyeXB0ZWRfYWRk
ZWQgPSBzZXZfcmFtX2Jsb2NrX2VuY3J5cHRlZF9hZGRlZCwNCisgICAgLnJhbV9ibG9ja19lbmNy
eXB0ZWRfcmVtb3ZlZCA9IHNldl9yYW1fYmxvY2tfZW5jcnlwdGVkX3JlbW92ZWQsDQogfTsNCiAN
CiBzdGF0aWMgdm9pZA0KQEAgLTc5NCw3ICs3ODUsNyBAQCBzZXZfZ3Vlc3RfaW5pdChjb25zdCBj
aGFyICppZCkNCiAgICAgICAgIGdvdG8gZXJyOw0KICAgICB9DQogDQotICAgIHJhbV9ibG9ja19u
b3RpZmllcl9hZGQoJnNldl9yYW1fbm90aWZpZXIpOw0KKyAgICByYW1fYmxvY2tfZW5jcnlwdGVk
X25vdGlmaWVyX2FkZCgmc2V2X3JhbV9lbmNyeXB0ZWRfbm90aWZpZXIpOw0KICAgICBxZW11X2Fk
ZF9tYWNoaW5lX2luaXRfZG9uZV9ub3RpZmllcigmc2V2X21hY2hpbmVfZG9uZV9ub3RpZnkpOw0K
ICAgICBxZW11X2FkZF92bV9jaGFuZ2Vfc3RhdGVfaGFuZGxlcihzZXZfdm1fc3RhdGVfY2hhbmdl
LCBzKTsNCiANCi0tIA0KMi4yMC4xDQoNCg==

