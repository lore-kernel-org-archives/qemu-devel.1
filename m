Return-Path: <SRS0=QtPl=S4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C277C43218
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 07:25:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59197206E0
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 07:25:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Fj0Hs6cG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59197206E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40833 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJvF4-0003AQ-J8
	for qemu-devel@archiver.kernel.org; Fri, 26 Apr 2019 03:25:54 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45798)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Janakarajan.Natarajan@amd.com>) id 1hJnPv-0000sX-ON
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 19:04:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Janakarajan.Natarajan@amd.com>) id 1hJnK0-0000R4-JB
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 18:58:29 -0400
Received: from mail-eopbgr730086.outbound.protection.outlook.com
	([40.107.73.86]:18512
	helo=NAM05-DM3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Janakarajan.Natarajan@amd.com>)
	id 1hJnK0-0008Tp-9i
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 18:58:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=pDW5PDf3h0FfVU6tx3+xkKryEYMLHXxrkA3frCOK+PA=;
	b=Fj0Hs6cGLjGto+kwgSnFg4KAm2GME5tUwodrISpyeRSBZ5AqT7yYz6SHNwgMIFDoOD9FXy3RsHE4Bs5x83KpSnZdwTDGJbiTcxlehf2Jt64NZTtXlNoQa7rn+A3T0QQc29pJxBQ7lTQMj7ogeVbMsH7QfLLkuaF/PiP9AVL9hOg=
Received: from SN6PR12MB2736.namprd12.prod.outlook.com (52.135.107.27) by
	SN6PR12MB2752.namprd12.prod.outlook.com (52.135.107.32) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1835.13; Thu, 25 Apr 2019 22:58:18 +0000
Received: from SN6PR12MB2736.namprd12.prod.outlook.com
	([fe80::65cb:af55:6bd4:55a]) by SN6PR12MB2736.namprd12.prod.outlook.com
	([fe80::65cb:af55:6bd4:55a%4]) with mapi id 15.20.1835.010;
	Thu, 25 Apr 2019 22:58:18 +0000
From: "Natarajan, Janakarajan" <Janakarajan.Natarajan@amd.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Thread-Topic: [PATCH 0/3] Add RAM block encrypted notifier
Thread-Index: AQHU+7pfNIuRN/Mm+E2dxwgHN/uYvQ==
Date: Thu, 25 Apr 2019 22:58:18 +0000
Message-ID: <20190425225610.28350-1-Janakarajan.Natarajan@amd.com>
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
x-ms-office365-filtering-correlation-id: 923070d6-cc03-44d4-f948-08d6c9d1817e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);
	SRVR:SN6PR12MB2752; 
x-ms-traffictypediagnostic: SN6PR12MB2752:
x-microsoft-antispam-prvs: <SN6PR12MB275252CE040A294A0E09D016E73D0@SN6PR12MB2752.namprd12.prod.outlook.com>
x-forefront-prvs: 0018A2705B
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10009020)(376002)(366004)(396003)(346002)(136003)(39860400002)(189003)(199004)(256004)(99286004)(2351001)(81156014)(316002)(68736007)(81166006)(2616005)(71200400001)(71190400001)(476003)(1076003)(486006)(478600001)(14454004)(72206003)(54906003)(53936002)(8676002)(4326008)(6506007)(305945005)(6916009)(2906002)(7736002)(386003)(66946007)(5640700003)(6436002)(64756008)(66476007)(66446008)(6486002)(25786009)(73956011)(66556008)(2501003)(26005)(186003)(86362001)(50226002)(102836004)(8936002)(6116002)(5660300002)(3846002)(6512007)(52116002)(97736004)(66066001)(36756003);
	DIR:OUT; SFP:1101; SCL:1; SRVR:SN6PR12MB2752;
	H:SN6PR12MB2736.namprd12.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: FSCXrSKdYcg7r9lYGWI+urjkQEDW4/TmzrLSRalZ/S4gcBvBrom6/8c9dIeNNUtSUm0fP83Z1lE21OzTrComh9bgdvCAxeD9bbG2LEhR+qhS4012cN8wNznAaJ+WqMoQ0fw+JVjYjoNlAklgtzH246e4JwonGe6sv432+uSEePxgfuq4zKKu+l6dv4T3ioSVmhR542HUBVIp4TbaM9tgZkn/ymDeGCAy7OYCCQ2e+gA/oKxjgPFthViCRkAeshpCcPt2KYWeLVLfv+KGoq/TjqXJaOm/C0xAdg1d6zczv9yOHmMPtF97zGU3cKlkWg/vwAniHJeenxJ9WR2ERen80QffhcgE6CMkiwildabEMsg704naxa0RC/+y2+JXI16Va7MR6AVbiTqBpZOndV2lM/BTstjOYf3NYUFWrgG0ih0=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 923070d6-cc03-44d4-f948-08d6c9d1817e
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2019 22:58:18.0376 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2752
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.73.86
X-Mailman-Approved-At: Fri, 26 Apr 2019 03:24:02 -0400
Subject: [Qemu-devel] [PATCH 0/3] Add RAM block encrypted notifier
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
Message-ID: <20190425225818.urRzY0UoJKWYTDEGFNoqE5sIXFWFlQCSbUHavr3cITA@z>

Q3VycmVudGx5LCB0aGUgU0VWIGd1ZXN0IGxhdW5jaCByZWdpc3RlcnMgdG8gYSBSQU0gYmxvY2sg
bm90aWZpZXIuIFdoZW4NCmNhbGxlZCwgd2UgaXNzdWUgS1ZNX01FTU9SWV9FTkNSWVBUX3tSRUcs
VU5SRUd9X1JFR0lPTiBpb2N0bCB0byByZWdpc3Rlcg0KdGhlIG1lbW9yeSB3aXRoIHRoZSBLVk0g
ZHJpdmVyLiBUaGVzZSBpb2N0bHMgc2hvdWxkIGJlIGNhbGxlZCBvbmx5IGZvcg0KdGhlIHJlZ2lv
biB3aGljaCBjb250YWlucyB0aGUgZW5jcnlwdGVkIGRhdGEgYnV0IHRoZSBSQU0gYmxvY2sgbm90
aWZpZXINCmdldHMgY2FsbGVkIGZvciBhbnkgbWVtb3J5IHJlZ2lvbiBhbGxvY2F0ZWQgZHVyaW5n
IHRoZSBndWVzdCBjcmVhdGlvbi4NClNvbWUgb2YgdGhvc2UgbWVtb3J5IHJlZ2lvbnMgZG8gbm90
IGNvbnRhaW4gZW5jcnlwdGVkIGRhdGEgc28gd2UgZW5kIHVwDQpjYWxsaW5nIHRoZSBpb2N0bCBm
b3IgYSBtZW1vcnkgcmVnaW9uIHdoaWNoIGNvbnRhaW5zIHVuZW5jcnlwdGVkIGRhdGENCihlLmcu
IHZnYSBSQU0gZXRjLikuDQoNCkluIGNhc2Ugb2YgU0VWLCBvbmx5IHRoZSBndWVzdCBSQU0gYW5k
IHBmbGFzaCB1bml0PTAgY29udGFpbiB0aGUNCmVuY3J5cHRlZCBkYXRhLiBUbyBzb2x2ZSB0aGlz
IHByb2JsZW0sIHdlIGludHJvZHVjZSBhIG5ldyBub3RpZmllciAoUkFNDQpibG9jayBlbmNyeXB0
ZWQpLiBJZiBhIG1lbW9yeSByZWdpb24gd2lsbCBjb250YWluIGVuY3J5cHRlZCBkYXRhIHRoZW4N
CnRoZSBjYWxsZXIgY2FuIHVzZSBtZW1vcnlfcmVnaW9uX21hcmtfZW5jcnlwdGVkKCkgdG8gc2V0
IHRoZSBtZW1vcnkNCnJlZ2lvbiBhcyBlbmNyeXB0ZWQuIENsaWVudHMgY2FuIHJlZ2lzdGVyIHRv
IHRoZSBSQU0gYmxvY2sgZW5jcnlwdGVkDQpub3RpZmllciBhbmQgdGhleSB3aWxsIGJlIGNhbGxl
ZCB3aGVuIGEgbWVtb3J5IHJlZ2lvbiBpcyBzZXQgZW5jcnlwdGVkLg0KDQpKYW5ha2FyYWphbiBO
YXRhcmFqYW4gKDMpOg0KICByYW0tZW5jcnlwdGVkLW5vdGlmaWVyOiBJbnRyb2R1Y2UgYSBSQU0g
YmxvY2sgZW5jcnlwdGVkIG5vdGlmaWVyDQogIGh3OiBOb3RpZnkgbGlzdGVuZXJzIGFib3V0IGd1
ZXN0IHBhZ2VzIHdoaWNoIGNvbnRhaW4gZW5jcnlwdGVkIGRhdGENCiAgc2V2OiBDaGFuZ2UgU0VW
IHRvIHVzZSBFbmNyeXB0ZWRSQU1CbG9jayBOb3RpZmllcg0KDQogZXhlYy5jICAgICAgICAgICAg
ICAgICB8ICA2ICsrKysrKw0KIGh3L2kzODYvcGMuYyAgICAgICAgICAgfCAgMSArDQogaHcvaTM4
Ni9wY19zeXNmdy5jICAgICB8ICAyICsrDQogaHcvbWVtL21lbW9yeS1kZXZpY2UuYyB8ICAxICsN
CiBpbmNsdWRlL2V4ZWMvbWVtb3J5LmggIHwgMTggKysrKysrKysrKysrKysrKysrDQogaW5jbHVk
ZS9leGVjL3JhbWxpc3QuaCB8IDE5ICsrKysrKysrKysrKysrKysrKysNCiBtZW1vcnkuYyAgICAg
ICAgICAgICAgIHwgMTYgKysrKysrKysrKysrKysrKw0KIG51bWEuYyAgICAgICAgICAgICAgICAg
fCAzMyArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCiBzdHVicy9yYW0tYmxvY2su
YyAgICAgIHwgIDggKysrKysrKysNCiB0YXJnZXQvaTM4Ni9zZXYuYyAgICAgIHwgMjUgKysrKysr
KystLS0tLS0tLS0tLS0tLS0tLQ0KIDEwIGZpbGVzIGNoYW5nZWQsIDExMiBpbnNlcnRpb25zKCsp
LCAxNyBkZWxldGlvbnMoLSkNCg0KLS0gDQoyLjIwLjENCg0K

