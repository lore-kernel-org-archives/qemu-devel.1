Return-Path: <SRS0=MhU4=WC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A07CEC31E40
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2019 16:55:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6AB12216B7
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2019 16:55:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="i7YSF1Ug"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AB12216B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35060 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hv2kb-0005sM-OR
	for qemu-devel@archiver.kernel.org; Tue, 06 Aug 2019 12:55:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50872)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <brijesh.singh@amd.com>) id 1hv2jd-0003zX-CD
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 12:54:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <brijesh.singh@amd.com>) id 1hv2jc-0003hq-2f
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 12:54:53 -0400
Received: from mail-eopbgr810075.outbound.protection.outlook.com
 ([40.107.81.75]:26111 helo=NAM01-BY2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <brijesh.singh@amd.com>)
 id 1hv2jb-0003gk-S2
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 12:54:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BrtcqQGBXZFXVdlllyYCpMhGr+GdykVvuStCph/ywS4QgPt+kgEaDPtf3ZPZh+Yz/mH4Jd07q+K4HFjKa0FX3MMnSHVFR18MFGkoR4lEePQn0JFs0y8wiG7TXH48trjoIPlAgxgQOn9ZfoZdoz5Ka572LIPQIS8aKSJd8lqgPzhhx80zQk/sL455Otsp9cjVfvBICSXU8uuh5PlwlukEKKeTlsG06KnYD9lm0z7iAvkpEJDQ417T4yVB7wlvIYRni8mJBSq4a8hRFkiq4gjTRIpf3aoyLizKawBNLOvwXtGJ5I8zRIyn+fQBmVr4Z8DqRZbOueBUCM2bVGsFYIIWew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/LwAwOQmlzVaorm9jHVyeKc7ZEeBfY4/VrQowUk8S58=;
 b=daAWxPlqK3oyKiOFM1uYIaqePGIL4P9ch9dViwGaRzm5VtZ5ylQIeMMa5SYJJOM1vteCmlLP3fMUm+lj4yWojS5FCYitgUYDXn3+XdtcTnHow6rn9v9yyRN5qGhKkIGYqmpn1L0ofgfEaMkOq386vwhuV827j4M/N/S4CFf/UkOHJ3cdIMLntEbucz1rR1lepzIqcGos+fy25a1FJ0nAu1U67cS6ehgmHhxxTcBVoX9b9k16eDS9E3vEtZIUDJ/7fzuP+//MtrAHBuSDBekCh7oJkFp9MH3C5/LEI8x+ks4NANXGg5qthrx8QSIvMR9VU1eRo+RPqt6GzmBV+TfjlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=amd.com;dmarc=pass action=none header.from=amd.com;dkim=pass
 header.d=amd.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/LwAwOQmlzVaorm9jHVyeKc7ZEeBfY4/VrQowUk8S58=;
 b=i7YSF1UgW30wnsirxARUCklKSfJcAS5fg5VVD/RMlpjfWgQrIf2uWXBV0+SWfknDm/3vqweqW1wMsXScEQ4o07c/7y255/DNNth9KYfZvFRVul9uqMZisW+2lNrs+IlxNvxd+xb/YGnDfS44rdPVt0cg6DTVOOpvtHtPBMsN3ks=
Received: from DM6PR12MB2682.namprd12.prod.outlook.com (20.176.118.13) by
 DM6PR12MB2891.namprd12.prod.outlook.com (20.179.71.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.16; Tue, 6 Aug 2019 16:54:45 +0000
Received: from DM6PR12MB2682.namprd12.prod.outlook.com
 ([fe80::7439:ea87:cc5d:71]) by DM6PR12MB2682.namprd12.prod.outlook.com
 ([fe80::7439:ea87:cc5d:71%7]) with mapi id 15.20.2136.018; Tue, 6 Aug 2019
 16:54:45 +0000
From: "Singh, Brijesh" <brijesh.singh@amd.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Thread-Topic: [PATCH v3 00/14] Add SEV guest live migration support
Thread-Index: AQHVTHemTZIc9aVgAEOT7UG3/JuxLQ==
Date: Tue, 6 Aug 2019 16:54:45 +0000
Message-ID: <20190806165429.19327-1-brijesh.singh@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN4PR0701CA0027.namprd07.prod.outlook.com
 (2603:10b6:803:2d::13) To DM6PR12MB2682.namprd12.prod.outlook.com
 (2603:10b6:5:42::13)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=brijesh.singh@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [165.204.77.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8a831417-22c9-47e7-795f-08d71a8ec8f4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);
 SRVR:DM6PR12MB2891; 
x-ms-traffictypediagnostic: DM6PR12MB2891:
x-ms-exchange-purlcount: 2
x-microsoft-antispam-prvs: <DM6PR12MB28913F95FE19B71A07F4C3E7E5D50@DM6PR12MB2891.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0121F24F22
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(366004)(136003)(396003)(376002)(346002)(189003)(199004)(6116002)(3846002)(2906002)(6436002)(50226002)(54906003)(316002)(8676002)(81156014)(86362001)(81166006)(5640700003)(99286004)(52116002)(6486002)(386003)(102836004)(71200400001)(71190400001)(2616005)(2501003)(476003)(8936002)(14444005)(26005)(66066001)(256004)(6506007)(2351001)(186003)(486006)(6306002)(6512007)(66556008)(478600001)(66476007)(64756008)(66946007)(966005)(7736002)(53936002)(1076003)(66446008)(6916009)(5660300002)(36756003)(68736007)(25786009)(4326008)(305945005)(14454004)(6606295002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB2891;
 H:DM6PR12MB2682.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ND9mZAA0jgfNCks2ffh9st79n31GsxIFEpKiV/a9DSkiGF7/pHhoFWq58R2SnBW+weMh4a/lu02yVYWp7nlGbmQ0AZidomqCXyhM3bOwMb0BY1F3HaZv5RCr9BcweZ/MxXqFt+fn6KbcxTG+5oHzs90caH/TTmW+Wkp2TXrZDyxKDf8mLgbf/fXKxu3EomtnyUarO69rbvCL6uf7S56j0/oaETvEfSrRIBKQOgFLf1PUvlM3J53SVVT147rfxVmrhTjup2TGe+DBKByAA/AuqvUjVf2UGB6bFqbgxDNpHZQ0ZTUd/Xz1wN93yehjGiNb0TC/uB6nougjRdqsdYYfto3gb2fZf/gHet7opwQ9XCfobYmxrmTpQRDE4abl/QqxDrk7ssZn/S2KnnCK359l6y5+SGfKpd4TkVllLkT+46o=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a831417-22c9-47e7-795f-08d71a8ec8f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2019 16:54:45.8086 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sbrijesh@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2891
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.81.75
Subject: [Qemu-devel] [PATCH v3 00/14] Add SEV guest live migration support
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
https://github.com/codomania/qemu/tree/sev-migration-v3

Known Issues:
 - failed to reboot the guest after migration.
 - The top 10 lines of the vga buffer is sent as encrypted and because of t=
hat
   we get a garage on destination. I am still debugging it.

Changes since v2:
 - Remove direct kvm_memcrpt calls from migration.
 - Add MemoryEcryptionOps in machine which will be used by migration
   instead of kvm_memcrypt calls.
 - drop the RAM_SAVE_FLAG_PAGE_ENCRYPTED_BITMAP. Now the RAM_SAVE_FLAG_ENCR=
YPTED_PAGE
   can be used for sending bitmap as well as guest RAM encrypted pages
 - add some bound checks on incoming data
 - drop migrate-sev-set-info object
 - extend the migrate-parameters to include the SEV specific certificate fi=
elds.
 - multiple fixes based on the review comments from Dave
=20
Changes since v1:
 - use the dirty log sync APIs to also sync the page encryption bitmap
   when SEV is active.

Brijesh Singh (14):
  doc: update AMD SEV API spec web link
  doc: update AMD SEV to include Live migration flow
  migration.json: add AMD SEV specific migration parameters
  linux-headers: update kernel header to include SEV migration commands
  hw/machine: add helper to query the memory encryption state
  hw/machine: introduce MachineMemoryEncryptionOps for encrypted VMs
  target/i386: sev: provide callback to setup outgoing context
  target/i386: sev: do not create launch context for an incoming guest
  target/i386: sev: add support to encrypt the outgoing page
  target/i386: sev: add support to load incoming encrypted page
  migration: add support to migrate page encryption bitmap
  kvm: add support to sync the page encryption state bitmap
  migration/ram: add support to send encrypted pages
  target/i386: sev: remove migration blocker

 accel/kvm/kvm-all.c            |  91 ++++++
 accel/kvm/sev-stub.c           |  28 ++
 docs/amd-memory-encryption.txt |  48 ++-
 hw/core/machine.c              |   5 +
 include/exec/ram_addr.h        | 199 +++++++++++++
 include/exec/ramlist.h         |   3 +-
 include/hw/boards.h            |  25 ++
 include/sysemu/sev.h           |  11 +
 linux-headers/linux/kvm.h      |  53 ++++
 migration/migration.c          |  61 ++++
 migration/ram.c                | 148 +++++++++-
 monitor/hmp-cmds.c             |  18 ++
 qapi/migration.json            |  41 ++-
 target/i386/sev.c              | 513 ++++++++++++++++++++++++++++++++-
 target/i386/sev_i386.h         |   8 +
 target/i386/trace-events       |   8 +
 16 files changed, 1234 insertions(+), 26 deletions(-)

--=20
2.17.1


