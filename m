Return-Path: <SRS0=TjK1=SW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B4CAC282E1
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Apr 2019 02:26:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03D5E2183F
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Apr 2019 02:26:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="AOTYM84N";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="OHz9M6HX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03D5E2183F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35774 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hHfht-0004wo-6t
	for qemu-devel@archiver.kernel.org; Fri, 19 Apr 2019 22:26:21 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49369)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=0062c52f7=Alistair.Francis@wdc.com>)
	id 1hHfg1-0003O9-Qz
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 22:24:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=0062c52f7=Alistair.Francis@wdc.com>)
	id 1hHffN-0002B1-Sk
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 22:23:46 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:26459)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <prvs=0062c52f7=Alistair.Francis@wdc.com>)
	id 1hHffM-00027f-59; Fri, 19 Apr 2019 22:23:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
	d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
	t=1555727024; x=1587263024;
	h=from:to:cc:subject:date:message-id:
	content-transfer-encoding:mime-version;
	bh=OMYOExwqBqA2eT6cjF4Gna+R5i1B22melGaqaRF/WXM=;
	b=AOTYM84NDKF92D5llZdk3P/1tnXv/pXBIrLRS77f6dNBDp/8WG21j3Aq
	WROTRQ7KYYpT0cBwHvvv1xREui6PpRtcxP53Dj+ZPPLoyLN0lhsdRPdLZ
	mrUB3c1GUFjbbHZkpODgzZr0zxC5L16a1PDydhXJmHSZxA+ZgqV27vg9h
	0jMzQ01rjeLOvEAp7ir/3LhXtii5lVKSVquXE7EAkmawfQmsym9HW3Zsz
	TzyHzmLmtW/JXdBobT2cZ+ZGraGArYOXL/oReyNk3KcXFDxKU1vAHaF/p
	97jsG7/s9YiOMnFQCvzsc1W0JAFRRqGsdG575/xAS1Yc6s2vPUl0gF8Jk g==;
X-IronPort-AV: E=Sophos;i="5.60,372,1549900800"; d="scan'208";a="107617862"
Received: from mail-by2nam03lp2058.outbound.protection.outlook.com (HELO
	NAM03-BY2-obe.outbound.protection.outlook.com) ([104.47.42.58])
	by ob1.hgst.iphmx.com with ESMTP; 20 Apr 2019 10:23:38 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=OMYOExwqBqA2eT6cjF4Gna+R5i1B22melGaqaRF/WXM=;
	b=OHz9M6HX/ltCE1z1WythlK3FdTj8a074BRAr3CWkjyvG8Y0sYPnpimFV+u1CiwMEE6pZDPrLTs1YV6+rUW2jKY5pPCh6hkU/afwegY+Ok3qwkaTv5tnsiiMmmKnxpMCKrDLhK020O8fpuF4VvhvGkp0KIwk0KVEap65aZkQtELo=
Received: from BYAPR04MB4901.namprd04.prod.outlook.com (52.135.232.206) by
	BYAPR04MB3943.namprd04.prod.outlook.com (52.135.215.18) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1813.12; Sat, 20 Apr 2019 02:23:36 +0000
Received: from BYAPR04MB4901.namprd04.prod.outlook.com
	([fe80::44e8:bd21:17b:348c]) by BYAPR04MB4901.namprd04.prod.outlook.com
	([fe80::44e8:bd21:17b:348c%4]) with mapi id 15.20.1813.011;
	Sat, 20 Apr 2019 02:23:36 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-riscv@nongnu.org"
	<qemu-riscv@nongnu.org>
Thread-Topic: [PATCH v1 0/6]  RISC-V: Add properties to the CPUs
Thread-Index: AQHU9yAPUeH+EbFBD0CHw2c2PV5Exw==
Date: Sat, 20 Apr 2019 02:23:36 +0000
Message-ID: <cover.1555726824.git.alistair.francis@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.21.0
x-clientproxiedby: BYAPR01CA0008.prod.exchangelabs.com (2603:10b6:a02:80::21)
	To BYAPR04MB4901.namprd04.prod.outlook.com
	(2603:10b6:a03:4f::14)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=Alistair.Francis@wdc.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [199.255.44.172]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 237a99c6-3210-4c3a-821a-08d6c5373154
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);
	SRVR:BYAPR04MB3943; 
x-ms-traffictypediagnostic: BYAPR04MB3943:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <BYAPR04MB3943F44E22BEE8C0330C584590200@BYAPR04MB3943.namprd04.prod.outlook.com>
x-forefront-prvs: 0013079544
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(366004)(376002)(396003)(136003)(39860400002)(346002)(199004)(189003)(14454004)(2501003)(6486002)(53936002)(6436002)(50226002)(97736004)(5660300002)(4326008)(305945005)(71200400001)(86362001)(81166006)(8936002)(7736002)(8676002)(71190400001)(73956011)(68736007)(6512007)(4744005)(25786009)(66946007)(81156014)(66446008)(64756008)(66476007)(66556008)(2906002)(256004)(6116002)(3846002)(36756003)(478600001)(72206003)(99286004)(44832011)(52116002)(66066001)(110136005)(386003)(6506007)(102836004)(26005)(186003)(316002)(54906003)(2616005)(486006)(476003);
	DIR:OUT; SFP:1102; SCL:1; SRVR:BYAPR04MB3943;
	H:BYAPR04MB4901.namprd04.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: /6KdvHBWKa7LEgbe+OCyl4ixgxviB60Li2jVsvY6RqsDPpUW4xczEhTIN3xVK16NB/XswMYJ7Xvkk4YaoaYHLFUA/d2sSD+itBLKrXw1HAIr1qEYoefZJE0CWk4HSNTg85TFAd7NPQC+mlYgRCo7JiwM50WbgcGYDc7bTsLrbfSk0jVHLu7QHVOxuWkT0smbqvptKriT4DsdSSLo3mR2mEJaKnxlmnaWxcCd/cWUyIzja2026ekbqEzd9mAIhNM/5kjgyQl3Xu+xrm+2z7hka3zDBRg74fd/NCaehRKRBmyyjxYktbtONHH7v6NdsL5ymi4rRqghBjlIi/RAtRpGQ7kPw4jc/2eTqFYmx+kQxv5hRwtaSCHhrtv+XIxjKSq6ec55w/qJMQyWWcxidgh3rciAjLsQDYcXenk0+zyK/sc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 237a99c6-3210-4c3a-821a-08d6c5373154
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2019 02:23:36.5231 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB3943
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 216.71.153.144
Subject: [Qemu-devel] [PATCH v1 0/6]  RISC-V: Add properties to the CPUs
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
Cc: "alistair23@gmail.com" <alistair23@gmail.com>,
	"palmer@sifive.com" <palmer@sifive.com>,
	Alistair Francis <Alistair.Francis@wdc.com>,
	"imammedo@redhat.com" <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190420022336.Yquf4hK7m1GXk-3K060g9ETpDt0onNvk3iXsXyCK3JA@z>

VGhpcyBzZXJpZXMgaXMgYmFzZWQgb24gdGhlIHByZXZpb3VzICJSSVNDLVY6IEFsbG93IHNwZWNp
ZnlpbmcgQ1BVIElTQQ0KdmlhIGNvbW1hbmQgbGluZSIgc2VyaWVzLiBUaGlzIHNlcmllcyBkb2Vz
IG5vdCBhbGxvdyBjdXN0b20gSVNBDQpleHRlbnNpb25zIGluc3RlYWQgaXQganVzdCBhbGxvd3Mg
b3RoZXIgcHJvcGVydHkgc2V0dGluZy4NCg0KVGhpcyBzZXJpZXMgYWxsb3dzIHVzZXJzIHRvIHNw
ZWNpZnkgc3BlYyB2ZXJzaW9ucywgTU1VIHN1cHBvcnQgYW5kIFBNUA0Kc3VwcG9ydCBmcm9tIHRo
ZSBjb21tYW5kIGxpbmUuDQoNClRoaXMgc2VyaWVzIGRlcHJlYXRlcyBzb21lIGV4aXN0aW5nIENQ
VXMgYW5kIG1hY2hpbmVzIGFzIHRoZXkgYXJlIG5vDQpsb25nZXIgcmVxdWlyZWQuDQoNCkFsaXN0
YWlyIEZyYW5jaXMgKDYpOg0KICBsaW51eC11c2VyL3Jpc2N2OiBBZGQgdGhlIENQVSB0eXBlIGFz
IGEgY29tbWVudA0KICByaXNjdjogdmlydDogQWxsb3cgc3BlY2lmeWluZyBhIENQVSB2aWEgY29t
bWFuZGxpbmUNCiAgdGFyZ2V0L3Jpc2N2OiBDcmVhdGUgc2V0dGFibGUgQ1BVIHByb3BlcnRpZXMN
CiAgdGFyZ2V0L3Jpc2N2OiBBZGQgYSBiYXNlIDMyIGFuZCA2NCBiaXQgQ1BVDQogIHRhcmdldC9y
aXNjdjogRGVwcmVjYXRlIHRoZSBnZW5lcmljIG5vIE1NVSBDUFVzDQogIHJpc2N2OiBzcGlrZTog
QWRkIGEgZ2VuZXJpYyBzcGlrZSBtYWNoaW5lDQoNCiBody9yaXNjdi9zcGlrZS5jICAgICAgICAg
ICAgICB8IDEwNiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystDQogaHcvcmlzY3Yv
dmlydC5jICAgICAgICAgICAgICAgfCAgIDMgKy0NCiBpbmNsdWRlL2h3L3Jpc2N2L3ZpcnQuaCAg
ICAgICB8ICAgNCArLQ0KIGxpbnV4LXVzZXIvcmlzY3YvdGFyZ2V0X2VsZi5oIHwgICAxICsNCiBx
ZW11LWRlcHJlY2F0ZWQudGV4aSAgICAgICAgICB8ICAyMSArKysrKysrDQogdGFyZ2V0L3Jpc2N2
L2NwdS5jICAgICAgICAgICAgfCAgNjMgKysrKysrKysrKysrKysrKysrKysNCiB0YXJnZXQvcmlz
Y3YvY3B1LmggICAgICAgICAgICB8ICAxMCArKysrDQogNyBmaWxlcyBjaGFuZ2VkLCAyMDQgaW5z
ZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCg0KLS0gDQoyLjIxLjANCg0K

