Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,RCVD_ILLEGAL_IP,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14ABAC433E6
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 15:53:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCC2320719
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 15:53:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="SQgSFKsB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCC2320719
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60224 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCm7O-0002Fh-WF
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 11:53:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57534)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Thomas.Lendacky@amd.com>)
 id 1kCm6n-0001lV-Ci
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 11:52:37 -0400
Received: from mail-co1nam11on2045.outbound.protection.outlook.com
 ([40.107.220.45]:51389 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Thomas.Lendacky@amd.com>)
 id 1kCm6k-0003xI-UY
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 11:52:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iZBS6/83ZB3hVKddpnqJwL3OmV4qHHOc5AN/LAhgdkSapndor5CRS7zQvPbMH0foK3wQgmTTKOGqnKMmB+D6lKkhBu7FweEJECK7Jf/nSKsp3G2eOyvLdzXD6+SwORq4I2ds/7C/M62LTbVhJA7zVqNkSyDWlLi8qDFkJM5q11waBbgsUDVoagruisZ41PXSC/w9m3Rs9v6DUK4cozXqsM1jFFwlcUAWzYXcJkQMHM64G0R7iUeREj5xvGs6LQ0dRl/A3q8l8cxfh+Ve/S5j4hdR9HbZdoC3AYHw5o4LAdAWOBuZl+yAJIGfrUe69ug6Yjfu/uJ5XDXpUaVRyKmjaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VZ6+szD+ID4g5++/QKWSa+ebqnmajC9g4WYXGoRXiwQ=;
 b=LowbqtYso7k7WSaZG4R0wS5GAOYoE6tJZjLTWOLd8peVf/neml/xB437GLThmIWla30GTyERYKVZb/lflAMkocllVuKinCsNpYPhgZUelRkdHWjtpVcBpO05xuhM/IeZkT6/cVWLoZwBHvK8MZf0PN5Qd9xEVuXWTCMXkBEtT1GZG2/B1bcO2HT1DBUnvBeDkiNOgb0UQVpKOlnRo4qtYANIdGEC1F2DcrQJhEWzhwK3dwTyITZQ7cD/SD2xPS8rwR9ukiQ83yFVjdGdiSl6nO9rUSoPiEuKM3EjT0rrrmKGZg3bnxkrDWFDKSEY142waYBls7OqX9kn806MAwrGXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VZ6+szD+ID4g5++/QKWSa+ebqnmajC9g4WYXGoRXiwQ=;
 b=SQgSFKsBxN4Z42pvB8kbGI7KsmqbKhE+rDtGZffWH3stiYx+7JafeyHdjmACTmllsB6wGKC8yzGS7OO9LGoTYEQm+ZjxV/P1Qt8GdgMSyuKOENCfMJ7Fu6mO6vGJjxU/ukhxJ2TCiCnSjmRB7JLrCRtPJFZEktJsOpyY+E7wTAg=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1355.namprd12.prod.outlook.com (2603:10b6:3:6e::7) by
 DM6PR12MB4484.namprd12.prod.outlook.com (2603:10b6:5:28f::24) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3326.19; Mon, 31 Aug 2020 15:37:28 +0000
Received: from DM5PR12MB1355.namprd12.prod.outlook.com
 ([fe80::299a:8ed2:23fc:6346]) by DM5PR12MB1355.namprd12.prod.outlook.com
 ([fe80::299a:8ed2:23fc:6346%3]) with mapi id 15.20.3326.025; Mon, 31 Aug 2020
 15:37:28 +0000
From: Tom Lendacky <thomas.lendacky@amd.com>
To: qemu-devel@nongnu.org,
	kvm@vger.kernel.org
Subject: [PATCH v2 0/4] Qemu SEV-ES guest support
Date: Mon, 31 Aug 2020 10:37:09 -0500
Message-Id: <cover.1598888232.git.thomas.lendacky@amd.com>
X-Mailer: git-send-email 2.28.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0501CA0011.namprd05.prod.outlook.com
 (2603:10b6:803:40::24) To DM5PR12MB1355.namprd12.prod.outlook.com
 (2603:10b6:3:6e::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by
 SN4PR0501CA0011.namprd05.prod.outlook.com (2603:10b6:803:40::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.7 via Frontend
 Transport; Mon, 31 Aug 2020 15:37:27 +0000
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 36f710d3-1b33-4f52-be30-08d84dc3c446
X-MS-TrafficTypeDiagnostic: DM6PR12MB4484:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4484A3DDBE68747368978BA3EC510@DM6PR12MB4484.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KyXrmsCQqJqETX5jC4xSEe3++XXr1IqP1htfHeJadNlAJmu4n+D13GqTYyd9GlHcQNAm00d3khkCGCBBAs0C3ozbZF9FjUGD7OhbXZMFo679K2dqQdfwz+v7gL43r70wDE2XxtC/h3d3wtbdTfZs1NiBf2lmAtCI5AAMbei4tYApgxcVMH5yZA5aLttwPLLtbh65HuabvDueAe65JnlnEKkunVmnZKCx9Q2J9jXv7gpsWnOzZxDZYskU3xMbgAxThq2F/4NWE2jZ4v4XBLunQfYPdYNqaaeHyRwlHi50GNKzxlIKXrpfiwLgVUQbwBkw16SZw9Tfn9lvpxOHFrmWgi1fmgdMQrEH6NWAewaGtcVsfrqac/gKOnsDk+4PdrgYbk+ChZBh7lYHz7/b+lB8kQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1355.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(366004)(346002)(376002)(136003)(54906003)(956004)(966005)(16576012)(7416002)(2906002)(6666004)(4326008)(2616005)(6486002)(316002)(66556008)(8676002)(66946007)(478600001)(186003)(5660300002)(8936002)(86362001)(83380400001)(66476007)(36756003)(52116002)(26005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: I2gbbspU8tDUPtqlRZ4vGDc6kwwJTPu+2NBt7GZTW4zuv8957GNSttltKgi9RRVAKHnl9dTaohZ3/rZHoFl3OkcG5LJraYeFP27lSeB63PKRwcs7SN1hyR3HaKclckXKAy79Dh3fwMKHXojczEi+2h8hijC38gjr3SGERthglseeAEFg8bWbK54IuCL+Tey23kQ8lwcYX2pfzu6olzrlwwR3RjX0/Xa4FAmb90vVHEvBuKtqDA4Scq96rLgUX+ffiXBTEpsGCoGCIf/brcooBVA6g62CX2h3PQDH79XeuixqJlK9MK6NqRE4YmTTmfBU16z92jbQzN8KylFKkP8SxuEatqfSNMjLWwixnRo10nOfQ3tWLdo9/WuNqsLAb+Oz6kxalQCpsPvMASgkshpQ/KsD5HKEvVCaaJvT8T9cgD8jcCXKbhOTkWYi4C2/+IFwTgGaL0HnYBwvFI+IJbKgD1RF4q5//ApRYBS+mLTBqYWPXnd8UDV8HgOaINz2S7yI7KLc05pkuuYothnY0mDnZzRJJeN/wtkvGhbLokoIhNzOtJ3VWSHU8Gzju72vjCOLlL0kUIGsf4DGkVE7rWO73I3c+/GpEmn9PeYFNTucHo2HeVa07gL1fi6K1Byb8PJPBuJqG8zrMTHyx8vCEOGB3g==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36f710d3-1b33-4f52-be30-08d84dc3c446
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1355.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2020 15:37:28.2925 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6pKzLdbCWHE0mvw5ukuXiyQaDWhTZ2u4eE0RkhrdBcZssfpyYqFTtQiMdSF7kC9x7lQDeubaUQ7n0/pEBjI5mQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4484
Received-SPF: none client-ip=40.107.220.45;
 envelope-from=Thomas.Lendacky@amd.com;
 helo=NAM11-CO1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/31 11:52:32
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 FORGED_SPF_HELO=1, MSGID_FROM_MTA_HEADER=0.001, RCVD_ILLEGAL_IP=1.3,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
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
Cc: Brijesh Singh <brijesh.singh@amd.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Connor Kuehl <ckuehl@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Jiri Slaby <jslaby@suse.cz>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Tom Lendacky <thomas.lendacky@amd.com>

This patch series provides support for launching an SEV-ES guest.

Secure Encrypted Virtualization - Encrypted State (SEV-ES) expands on the
SEV support to protect the guest register state from the hypervisor. See
"AMD64 Architecture Programmer's Manual Volume 2: System Programming",
section "15.35 Encrypted State (SEV-ES)" [1].

In order to allow a hypervisor to perform functions on behalf of a guest,
there is architectural support for notifying a guest's operating system
when certain types of VMEXITs are about to occur. This allows the guest to
selectively share information with the hypervisor to satisfy the requested
function. The notification is performed using a new exception, the VMM
Communication exception (#VC). The information is shared through the
Guest-Hypervisor Communication Block (GHCB) using the VMGEXIT instruction.
The GHCB format and the protocol for using it is documented in "SEV-ES
Guest-Hypervisor Communication Block Standardization" [2].

The main areas of the Qemu code that are updated to support SEV-ES are
around the SEV guest launch process and AP booting in order to support
booting multiple vCPUs.

There are no new command line switches required. Instead, the desire for
SEV-ES is presented using the SEV policy object. Bit 2 of the SEV policy
object indicates that SEV-ES is required.

The SEV launch process is updated in two ways. The first is that a the
KVM_SEV_ES_INIT ioctl is used to initialize the guest instead of the
standard KVM_SEV_INIT ioctl. The second is that before the SEV launch
measurement is calculated, the LAUNCH_UPDATE_VMSA SEV API is invoked for
each vCPU that Qemu has created. Once the LAUNCH_UPDATE_VMSA API has been
invoked, no direct changes to the guest register state can be made.

AP booting poses some interesting challenges. The INIT-SIPI-SIPI sequence
is typically used to boot the APs. However, the hypervisor is not allowed
to update the guest registers. For the APs, the reset vector must be known
in advance. An OVMF method to provide a known reset vector address exists
by providing an SEV information block, identified by UUID, near the end of
the firmware [3]. OVMF will program the jump to the actual reset vector in
this area of memory. Since the memory location is known in advance, an AP
can be created with the known reset vector address as its starting CS:IP.
The GHCB document [2] talks about how SMP booting under SEV-ES is
performed.

[1] https://www.amd.com/system/files/TechDocs/24593.pdf
[2] https://developer.amd.com/wp-content/resources/56421.pdf
[3] 30937f2f98c4 ("OvmfPkg: Use the SEV-ES work area for the SEV-ES AP reset vector")
    https://github.com/tianocore/edk2/commit/30937f2f98c42496f2f143fe8374ae7f7e684847

---

These patches are based on commit:
d0ed6a69d3 ("Update version for v5.1.0 release")

(I tried basing on the latest Qemu commit, but I was having build issues
that level)

A version of the tree can be found at:
https://github.com/AMDESE/qemu/tree/sev-es-v10

Changes since v1:
- Fixed checkpatch.pl errors/warnings

Tom Lendacky (4):
  sev/i386: Add initial support for SEV-ES
  sev/i386: Allow AP booting under SEV-ES
  sev/i386: Don't allow a system reset under an SEV-ES guest
  sev/i386: Enable an SEV-ES guest based on SEV policy

 accel/kvm/kvm-all.c       | 73 +++++++++++++++++++++++++++++
 accel/stubs/kvm-stub.c    |  5 ++
 hw/i386/pc_sysfw.c        | 10 +++-
 include/sysemu/cpus.h     |  2 +
 include/sysemu/hw_accel.h |  5 ++
 include/sysemu/kvm.h      | 18 +++++++
 include/sysemu/sev.h      |  3 ++
 softmmu/cpus.c            |  5 ++
 softmmu/vl.c              |  5 +-
 target/i386/cpu.c         |  1 +
 target/i386/kvm.c         |  2 +
 target/i386/sev-stub.c    |  5 ++
 target/i386/sev.c         | 99 ++++++++++++++++++++++++++++++++++++++-
 target/i386/sev_i386.h    |  1 +
 14 files changed, 230 insertions(+), 4 deletions(-)

-- 
2.28.0


