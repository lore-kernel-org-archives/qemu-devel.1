Return-Path: <SRS0=axyf=VH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FF9EC74A35
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 20:24:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0AC4B20693
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 20:24:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="qE6rF72n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AC4B20693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36806 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlJ8X-0002sS-58
	for qemu-devel@archiver.kernel.org; Wed, 10 Jul 2019 16:24:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57046)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <brijesh.singh@amd.com>) id 1hlJ7H-0001UI-JQ
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 16:23:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <brijesh.singh@amd.com>) id 1hlJ7G-0002FY-DN
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 16:23:03 -0400
Received: from mail-eopbgr710059.outbound.protection.outlook.com
 ([40.107.71.59]:24298 helo=NAM05-BY2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <brijesh.singh@amd.com>)
 id 1hlJ7G-0002Ap-2b
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 16:23:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/HYqE1PCJLcOxRWS0i6CAUS74pHoE7gwQc8fgLK9XvE=;
 b=qE6rF72nH0RWASnigtsL+kwYnqrkjnyRbc+8wq7M0baT8BqS93Hk62yuCwKsaCQRLlrkBFwUn6FXjw45vi6jhCLudmg0lwm6siPUrBLlGIodVIfos0SHPmbKNKWJAXQpI9RFvZn+oL0lcJnJUSnWAe5qAAheShZazBKzKRIRDU4=
Received: from DM6PR12MB2682.namprd12.prod.outlook.com (20.176.116.31) by
 DM6PR12MB2618.namprd12.prod.outlook.com (20.176.116.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2052.19; Wed, 10 Jul 2019 20:22:59 +0000
Received: from DM6PR12MB2682.namprd12.prod.outlook.com
 ([fe80::bc1a:a30d:9da2:1cdd]) by DM6PR12MB2682.namprd12.prod.outlook.com
 ([fe80::bc1a:a30d:9da2:1cdd%6]) with mapi id 15.20.2073.008; Wed, 10 Jul 2019
 20:22:59 +0000
From: "Singh, Brijesh" <brijesh.singh@amd.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Thread-Topic: [PATCH v2 00/13] Add SEV guest live migration support
Thread-Index: AQHVN11DVr1yNvx2/kyGjSnRTUfVFw==
Date: Wed, 10 Jul 2019 20:22:58 +0000
Message-ID: <20190710202219.25939-1-brijesh.singh@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: DM3PR11CA0020.namprd11.prod.outlook.com
 (2603:10b6:0:54::30) To DM6PR12MB2682.namprd12.prod.outlook.com
 (2603:10b6:5:4a::31)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=brijesh.singh@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [165.204.77.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 56075fd3-b01d-495b-61c9-08d70574665a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);
 SRVR:DM6PR12MB2618; 
x-ms-traffictypediagnostic: DM6PR12MB2618:
x-ms-exchange-purlcount: 2
x-microsoft-antispam-prvs: <DM6PR12MB26188429DDE0195B47758AF1E5F00@DM6PR12MB2618.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 0094E3478A
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(346002)(136003)(39860400002)(376002)(396003)(189003)(199004)(5640700003)(14444005)(8676002)(99286004)(66066001)(53936002)(2351001)(6306002)(6116002)(3846002)(6436002)(6486002)(305945005)(7736002)(52116002)(6916009)(6512007)(81166006)(5660300002)(8936002)(66946007)(66476007)(81156014)(386003)(6506007)(2501003)(2906002)(486006)(476003)(50226002)(68736007)(2616005)(86362001)(478600001)(25786009)(316002)(966005)(54906003)(66446008)(64756008)(256004)(71200400001)(71190400001)(66556008)(14454004)(102836004)(1076003)(26005)(36756003)(4326008)(186003)(6606295002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB2618;
 H:DM6PR12MB2682.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: cJGOrxlCtyKYX+XZ5/hQp9pebiWpyhMtyCynBBKfDWkNZqEYkz7nv7Y/xUMVk+Hivab7tL+xuhg3iU+NoePrvssSxR/9sU+lpd8YbQ1hXjhGcDoYDpu28teDmV/mZYpTcg9x1uc215ZftoIIR/NwVLiBnkGbowTYhS1ZM6bIUfmEEIIr/12m9rQGDZVzKCSoWiL/d8OU/4ue4ROauRqjxv9k7FSLtBpAHsZCouCXcL0DyOkK48zOpLJFTJONXly7rz76+qN7lqAikpKElGH67K/WYcmcu7IpbBNv99nnCvWvZ+/Vd0uR7N6VxZ9WL36+mFCqUpOep19PTwP2rO4hg0KCSD5KawmlsMv/f1lexJTgRtgxHRIOQPkpHxNt2L0tJisYhqKUtntC2tiuQuaXlCI0lfJLriVYbOI95bs4vnQ=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56075fd3-b01d-495b-61c9-08d70574665a
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2019 20:22:58.9038 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sbrijesh@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2618
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.71.59
Subject: [Qemu-devel] [PATCH v2 00/13] Add SEV guest live migration support
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>, "Lendacky,
 Thomas" <Thomas.Lendacky@amd.com>, "Singh, Brijesh" <brijesh.singh@amd.com>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>,
 "ehabkost@redhat.com" <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

AMD SEV encrypts the memory of VMs and because this encryption is done usin=
g
an address tweak, the hypervisor will not be able to simply copy ciphertext
between machines to migrate a VM. Instead the AMD SEV Key Management API
provides a set of functions which the hypervisor can use to package a
guest encrypted pages for migration, while maintaining the confidentiality
provided by AMD SEV.

The patch series add the support required in Qemu to perform the SEV
guest live migration. Before initiating the live migration a user
should use newly added 'migrate-set-sev-info' command to pass the
target machines certificate chain. See the docs/amd-memory-encryption.txt
for further details.

The patch series depends on kernel patches available here:
https://marc.info/?l=3Dkvm&m=3D156278967226011&w=3D2

The complete tree with patch is available at:
https://github.com/codomania/qemu/tree/sev-migration-v2

Changes since v1:
 - use the dirty log sync APIs to also sync the page encryption bitmap
   when SEV is active.

Brijesh Singh (13):
  linux-headers: update kernel header to include SEV migration commands
  kvm: introduce high-level API to support encrypted page migration
  migration/ram: add support to send encrypted pages
  kvm: add support to sync the page encryption state bitmap
  doc: update AMD SEV API spec web link
  doc: update AMD SEV to include Live migration flow
  target/i386: sev: do not create launch context for an incoming guest
  misc.json: add migrate-set-sev-info command
  target/i386: sev: add support to encrypt the outgoing page
  target/i386: sev: add support to load incoming encrypted page
  kvm: introduce high-level API to migrate the page encryption bitmap
  migration: add support to migrate page encryption bitmap
  target/i386: sev: remove migration blocker

 accel/kvm/kvm-all.c            | 108 ++++++++
 accel/kvm/sev-stub.c           |  22 ++
 accel/stubs/kvm-stub.c         |  22 ++
 docs/amd-memory-encryption.txt |  44 +++-
 include/exec/ram_addr.h        | 161 +++++++++++-
 include/exec/ramlist.h         |   3 +-
 include/sysemu/kvm.h           |  25 ++
 include/sysemu/sev.h           |   6 +
 linux-headers/linux/kvm.h      |  53 ++++
 migration/ram.c                |  91 ++++++-
 qapi/misc-target.json          |  18 ++
 target/i386/monitor.c          |  10 +
 target/i386/sev-stub.c         |   5 +
 target/i386/sev.c              | 455 +++++++++++++++++++++++++++++++--
 target/i386/sev_i386.h         |  11 +-
 target/i386/trace-events       |   8 +
 16 files changed, 1016 insertions(+), 26 deletions(-)

--=20
2.17.1


