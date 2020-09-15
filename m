Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1DAAC433E2
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 21:47:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F9CE2078E
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 21:47:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="25iEgd2C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F9CE2078E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56310 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIInC-0003Dk-9w
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 17:47:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49166)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Thomas.Lendacky@amd.com>)
 id 1kIIlB-00027r-34
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 17:45:09 -0400
Received: from mail-eopbgr750075.outbound.protection.outlook.com
 ([40.107.75.75]:29152 helo=NAM02-BL2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Thomas.Lendacky@amd.com>)
 id 1kIIl8-0004ID-LS
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 17:45:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mMcg3cicsTTc2uYuQ0tSZbz3Ws5QSKxKCmb/dTX80RxxEtE+Io/+F2TI6VJ1vzVPX4FN43bIrcSYqBoIg4SEres5USOdnDj/kOtctCP6RzOeMIWykDd0RQSn1C5/PcIg8ggsGkOYbaFpFN7tgfK2cQRDZr9sz7sX1XX1rALOCILsHnxSy9wU5dyeVYqPeVbICBxj8WtQxTfeY58KE+ejbcne1H9YXae5sRupyBeyh690E86u5c9IIwO0M4ls3y+39b5ENK4BCB78tkY0lkGXdcenL2rD6AxSiNXMQzSMrd6e0P2/JP2a209+yW/1yFDCWGCEXVRnvLE2tVbnacODLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=USmlxAFyX1tiqZMcVVg3IFWaDI1hfi9wypUsGGyCTxI=;
 b=J6vaWRQLOIqyVKhavcwXAXw4z/K22MlzDIiaFx3IXsWoaT+P2fZ1i0K/JMqCT8wDzHC20rgXHy1SbyQd5CMbvGqofbyufH/eKGmOSkXLZz3lAV04rHfvJmRY6u9mimnRhN22xZOin8FIOsP++ZWQ1coKtHLPayC8UKoleFk2je0T+/vIlKIHxrp3jVBHOrNkTMFMkgxGudrBx7jwdvnpOoN0yMn9qdeB/lGmCfdl98eT7UfDhRW0KhY6I7olc41O5S1p7glNH1ozHHJ3YYPlT/RuLcgoh80jqmm1x9TIQUu7LF1v+pQFu/Uk6wKAQwgBoa2vLjhcjSc5JHk02JzKuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=USmlxAFyX1tiqZMcVVg3IFWaDI1hfi9wypUsGGyCTxI=;
 b=25iEgd2C+2alBq62A2wG3ZgtS7YQFoVESILULoZsgMM0pJK1Grf7X+ku+eBjeCD8b3BH5ANXu5ABn7/uuZCjChx7A4NXoM4lC6fxHgNgGfbUxmYbx4njMp/UT65I/xhMOf7p+fSC4NeajkYSkMz3yC4vBOsIoKw//X3APxq5cz8=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1352.namprd12.prod.outlook.com (2603:10b6:903:3a::13)
 by CY4PR12MB1607.namprd12.prod.outlook.com (2603:10b6:910:b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Tue, 15 Sep
 2020 21:29:59 +0000
Received: from CY4PR12MB1352.namprd12.prod.outlook.com
 ([fe80::989b:b1b2:464c:443]) by CY4PR12MB1352.namprd12.prod.outlook.com
 ([fe80::989b:b1b2:464c:443%10]) with mapi id 15.20.3370.019; Tue, 15 Sep 2020
 21:29:59 +0000
From: Tom Lendacky <thomas.lendacky@amd.com>
To: qemu-devel@nongnu.org,
	kvm@vger.kernel.org
Subject: [PATCH v3 0/5] Qemu SEV-ES guest support
Date: Tue, 15 Sep 2020 16:29:39 -0500
Message-Id: <cover.1600205384.git.thomas.lendacky@amd.com>
X-Mailer: git-send-email 2.28.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM5PR07CA0132.namprd07.prod.outlook.com
 (2603:10b6:3:13e::22) To CY4PR12MB1352.namprd12.prod.outlook.com
 (2603:10b6:903:3a::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from tlendack-t1.amd.com (165.204.77.1) by
 DM5PR07CA0132.namprd07.prod.outlook.com (2603:10b6:3:13e::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3391.11 via Frontend Transport; Tue, 15 Sep 2020 21:29:58 +0000
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3c21e423-2610-4feb-97ae-08d859be7f9a
X-MS-TrafficTypeDiagnostic: CY4PR12MB1607:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR12MB1607D34A05FB4F5EA65CB3B6EC200@CY4PR12MB1607.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r7gnvV24pj58z87c0MBJ8cLfB+rQy8hNR01Qr3a8fqI+9+Qv7hFy37VwRdxAmBd1PVhchfOVV+dFJN2dSom9mCg0gexdzER58JclvkZbJ/T+XTKqchT5wul1wvLkAw1ZzlSw8SoRME65r4FXClIShWvUGH6Jv/Nn6Z9u5Zi9HhBNQGhWCFlwIsfOUlHDYgsn5478WnDBE31KLPI6mIBejvydlquwFJV4fYhWHNFCEdMuq7d24GBqAF9hfqwmFYSJFXR7zRbLuTQDH7LCOEVv2lD9ICZN0I6oVB/LZxgj+LNk5ZLZSxWHB/R6eaMDQRiSx73uxnu1haIOSBn806tmcbwgH+cNRO3Fl9zl2Bk7TD/5JmjMH+CPGGv3JbKSWP5aU4dcYv+WQNWPMB5+9/b2HA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1352.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(346002)(136003)(39860400002)(376002)(5660300002)(956004)(478600001)(6666004)(966005)(86362001)(52116002)(2616005)(2906002)(7696005)(36756003)(66476007)(8936002)(66556008)(66946007)(316002)(54906003)(7416002)(26005)(6486002)(4326008)(8676002)(16526019)(83380400001)(186003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: Sek8TuZ/oxG+Pox3CziOsvqdD9sZ/HOvqx6vUQkXo9dtrPL09E8BmFnZsrWLqIrajqnhbTqDvR3yfqdu1NQv+pEzBzbUKAp6OyylxGO6XqaQHBZujvcERNQCKjVLvyb2Do76v33SOXQl7+UmjHjSY8y+qw6M3/MyIA84iI1ysaOf9CTreJ3vQl0jf3p0AG9kEe+BV7WfZ+hHjykC6HrmbABXsYalgvuFS0WCBt576eRst+S91LSAAWbPUEHZRZYgzOyE1WDdpxIPL54t+EKKhivJmJazdZWwQdTCtF4uEXyu0i/MSmKbZZCdiMFlE3lglHNrJq1naG8Gd77mooRgUg5eTe13Hhv5izdPWy+Xv4PewDxskDQHdpyehKK1zNMC/TrKwDh9++zZYmNo8eR3vDZPOvKTFCzOspN0CjHfrJHWGO4aPVKrxAQG+lEsab9mhB1LDayPz3S9cincUMU+XKG3irF1Qy5AveOk5lKLyp2Rmnf5eZoDKlsaqoGGzFYqEKhM8YSO3C242IWCCP26hq8TXAz6s6KmR++n7DhZs6UeStilzE/AI2FWNiUy3tqVzEdEbZY1b51iQ1DGUHPLYVAbkmVs+54B3RlDBx6bEtJ287Xa6NZOa5D4ug8FCqjCl+Pm6Hxwmy02z4kdQpR2Tg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c21e423-2610-4feb-97ae-08d859be7f9a
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1352.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2020 21:29:59.5339 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yead7xBxnOcJokr3lTJ3NRg2ta4LpW12xGMOw5y9+BFJqL6dsXKQtjOWZhTWWGloe08W7baFvXTLt3qxHYZSUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1607
Received-SPF: none client-ip=40.107.75.75;
 envelope-from=Thomas.Lendacky@amd.com;
 helo=NAM02-BL2-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/15 17:45:05
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, FORGED_SPF_HELO=1, MSGID_FROM_MTA_HEADER=0.001,
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
performed. SEV-ES also requires the use of the in-kernel irqchip support
in order to minimize the changes required to Qemu to support AP booting.

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
https://github.com/AMDESE/qemu/tree/sev-es-v11

Changes since v2:
- Add in-kernel irqchip requirement for SEV-ES guests

Changes since v1:
- Fixed checkpatch.pl errors/warnings

Tom Lendacky (5):
  sev/i386: Add initial support for SEV-ES
  sev/i386: Require in-kernel irqchip support for SEV-ES guests
  sev/i386: Allow AP booting under SEV-ES
  sev/i386: Don't allow a system reset under an SEV-ES guest
  sev/i386: Enable an SEV-ES guest based on SEV policy

 accel/kvm/kvm-all.c       |  73 ++++++++++++++++++++++++++
 accel/stubs/kvm-stub.c    |   5 ++
 hw/i386/pc_sysfw.c        |  10 +++-
 include/sysemu/cpus.h     |   2 +
 include/sysemu/hw_accel.h |   5 ++
 include/sysemu/kvm.h      |  18 +++++++
 include/sysemu/sev.h      |   3 ++
 softmmu/cpus.c            |   5 ++
 softmmu/vl.c              |   5 +-
 target/i386/cpu.c         |   1 +
 target/i386/kvm.c         |   2 +
 target/i386/sev-stub.c    |   5 ++
 target/i386/sev.c         | 105 +++++++++++++++++++++++++++++++++++++-
 target/i386/sev_i386.h    |   1 +
 14 files changed, 236 insertions(+), 4 deletions(-)

-- 
2.28.0


