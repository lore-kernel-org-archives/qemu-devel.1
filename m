Return-Path: <SRS0=Q6KP=2B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C3F4C00454
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 19:11:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6937206A5
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 19:11:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6937206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48131 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1if7Ob-00019S-RZ
	for qemu-devel@archiver.kernel.org; Wed, 11 Dec 2019 14:11:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46114)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <farosas@linux.ibm.com>) id 1if7NZ-0008Jw-5E
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 14:10:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <farosas@linux.ibm.com>) id 1if7NX-00021n-IH
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 14:10:33 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:1376
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <farosas@linux.ibm.com>)
 id 1if7NX-0001yo-Bv; Wed, 11 Dec 2019 14:10:31 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xBBJ1o5i059944; Wed, 11 Dec 2019 14:10:19 -0500
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2wsqc2metj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 11 Dec 2019 14:10:18 -0500
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id xBBJ3YPO064401;
 Wed, 11 Dec 2019 14:10:18 -0500
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com
 [169.47.144.26])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2wsqc2met7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 11 Dec 2019 14:10:18 -0500
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
 by ppma04wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id xBBJ4ou8013336;
 Wed, 11 Dec 2019 19:10:17 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com
 (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
 by ppma04wdc.us.ibm.com with ESMTP id 2wr3q6qg7w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 11 Dec 2019 19:10:17 +0000
Received: from b03ledav006.gho.boulder.ibm.com
 (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
 by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 xBBJAGWG42533122
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 11 Dec 2019 19:10:16 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 23CF1C6070;
 Wed, 11 Dec 2019 19:10:16 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E04EAC605D;
 Wed, 11 Dec 2019 19:10:14 +0000 (GMT)
Received: from farosas.linux.ibm.com.br.ibm.com (unknown [9.86.27.131])
 by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
 Wed, 11 Dec 2019 19:10:14 +0000 (GMT)
From: Fabiano Rosas <farosas@linux.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 0/3] target/ppc: single step for KVM HV
Date: Wed, 11 Dec 2019 16:10:10 -0300
Message-Id: <20191211191013.454125-1-farosas@linux.ibm.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-11_05:2019-12-11,2019-12-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0
 malwarescore=0 suspectscore=0 clxscore=1011 mlxscore=0 phishscore=0
 priorityscore=1501 mlxlogscore=847 spamscore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912110156
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 148.163.158.5
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
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I'm resending this series now that the KVM capability got merged:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=1a9167a214f

---
Original cover-letter:

Single stepping via GDB/gdbstub is currently not working with KVM
HV. When asking for a single step (stepi), KVM simply ignores the
request and execution continues.

This has the direct effect of breaking GDB's 'step', 'stepi', 'next',
'nexti' commands. The 'continue' command is also affected since
continuing right after a breakpoint requires that GDB first perform a
single step so that the breakpoint can be re-inserted before
continuing - in this case the breakpoint is not re-inserted and it
won't hit again.

The issue here is that single stepping in POWER makes use of an
interrupt (Trace Interrupt [1]) that does not reach the hypervisor, so
while the single step would happen if properly triggered, it would not
cause an exit to KVM so there would be no way of handing control back
to GDB. Aside from that, the guest kernel is not prepared to deal with
such an interrupt in kernel mode (when not using KGDB, or some other
debugging facility) and it causes an Oops.

This series implements a "software single step" approach that makes
use of: i) the Trace Interrupt to perform the step inside the guest
and ii) a breakpoint at the Trace Interrupt handler address to cause a
vm exit (Emulation Assist) so that we can return control to QEMU.

With (i), we basically get the single step for free, without having to
discover what are the possible targets of instructions that divert
execution.

With (ii), we hide the single step from the guest and keep all of the
step logic in QEMU.

Supported scenarios:

- Stepping of multiple vcpus;
- GDB scheduler locking on and off [2];
- single stepping of kernel code with QEMU while stepping with GDB
  inside the guest (user space, KGDB).

1- PowerISA Section 6.5.15 - Trace Interrupt
2- https://sourceware.org/gdb/onlinedocs/gdb/All_002dStop-Mode.html

v4 -> v5:
 - rebase to v4.2.0-rc5;

 - use KVM_CAP_PPC_GUEST_DEBUG_SSTEP (#176) which is now in kernel
   v5.5-rc1:
   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=1a9167a214f

v3 -> v4:
 - patch 1: fix uninitialized 'offset' variable;

 - patch 2: squash with patch 7/7 (now 5/5);
            fix exception vector offset calculation when AIL == 0;

 - patch 3: squash with 4/7 (now 2/5);

 - patch 7: introduce ppc_gdb_get_{op,xop,spr} functions;

            introduce ppc_gdb_read_insn function;

	    define constants for mfmsr, rfid, mtspr extended opcodes;

            fix bug where instructions would not be properly
	    recognized in SLOF due to guest endianness being different
	    from host's;

	    pass arch_info->address directly into functions that only
	    need the address;

	    improve indentation by returning early when possible.

 https://lists.nongnu.org/archive/html/qemu-devel/2019-02/msg07994.html

v2 -> v3:
 - take Alternate Interrupt Location (AIL) into consideration when
   calculating the Trace Interrupt handler address (this allows single
   stepping in SLOF code);

 - check for a new KVM_GUEST_DEBUG_SSTEP capability (still to be
   submitted to kernel ml);

 - handle other vcpus (not currently stepping) hitting the single step
   breakpoint - by ignoring the breakpoint;

 - handle simultaneous single step by GDB inside guest - by first
   performing our step into the trace interrupt handler itself and
   returning to the guest afterwards;

 - handle single stepping when at the first trace interrupt handler
   instruction - by displacing the breakpoint to the next instruction;

 - restore MSR, SRR0, SRR1 after the step, taking into consideration
   possible mtspr, mtmsr instructions;

 - use stubs for arch-specific code that will not be implemented by
   other architectures at this point;

 https://lists.gnu.org/archive/html/qemu-devel/2019-01/msg04627.html

v1 -> v2:
 - split in more patches to facilitate review
 - use extract32 for decoding instruction instead of open-coding
 - add more people to CC

 https://lists.gnu.org/archive/html/qemu-devel/2018-11/msg04269.html

v1:

 https://lists.gnu.org/archive/html/qemu-devel/2018-11/msg03738.html


Fabiano Rosas (3):
  linux-headers: Update kvm.h for ppc single step capability
  kvm-all: Introduce kvm_set_singlestep
  target/ppc: support single stepping with KVM HV

 accel/kvm/kvm-all.c         |  14 +++
 accel/stubs/kvm-stub.c      |   4 +
 exec.c                      |   2 +-
 include/sysemu/kvm.h        |   4 +
 linux-headers/linux/kvm.h   |   1 +
 stubs/Makefile.objs         |   1 +
 stubs/kvm-arch-singlestep.c |  14 +++
 target/ppc/cpu.h            |  16 +++
 target/ppc/excp_helper.c    |  13 +++
 target/ppc/gdbstub.c        |  35 ++++++
 target/ppc/kvm.c            | 209 ++++++++++++++++++++++++++++++++++--
 11 files changed, 305 insertions(+), 8 deletions(-)
 create mode 100644 stubs/kvm-arch-singlestep.c

-- 
2.23.0


