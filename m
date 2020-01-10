Return-Path: <SRS0=GavZ=27=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 049C4C282DD
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 15:16:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B81F020661
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 15:16:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B81F020661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47438 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipw17-0003MU-8Z
	for qemu-devel@archiver.kernel.org; Fri, 10 Jan 2020 10:16:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49485)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <farosas@linux.ibm.com>) id 1ipvz6-0001Kz-Pu
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 10:14:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <farosas@linux.ibm.com>) id 1ipvz2-0000qa-Gk
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 10:14:00 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:8022)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <farosas@linux.ibm.com>)
 id 1ipvz2-0000k6-74; Fri, 10 Jan 2020 10:13:56 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 00AFC44r054489; Fri, 10 Jan 2020 10:13:50 -0500
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2xe6ywpaw2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 10 Jan 2020 10:13:49 -0500
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 00AFClvS057582;
 Fri, 10 Jan 2020 10:13:49 -0500
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com
 [169.63.121.186])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2xe6ywpavb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 10 Jan 2020 10:13:49 -0500
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
 by ppma03wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 00AF9uRt004979;
 Fri, 10 Jan 2020 15:13:48 GMT
Received: from b03cxnp07028.gho.boulder.ibm.com
 (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
 by ppma03wdc.us.ibm.com with ESMTP id 2xajb77k2y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 10 Jan 2020 15:13:48 +0000
Received: from b03ledav006.gho.boulder.ibm.com
 (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
 by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 00AFDl7D45547924
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 10 Jan 2020 15:13:47 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 53745C6055;
 Fri, 10 Jan 2020 15:13:47 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CDF81C6059;
 Fri, 10 Jan 2020 15:13:45 +0000 (GMT)
Received: from farosas.linux.ibm.com.br.ibm.com (unknown [9.86.27.174])
 by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
 Fri, 10 Jan 2020 15:13:45 +0000 (GMT)
From: Fabiano Rosas <farosas@linux.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 0/3] target/ppc: single step for KVM HV
Date: Fri, 10 Jan 2020 12:13:41 -0300
Message-Id: <20200110151344.278471-1-farosas@linux.ibm.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-01-10_01:2020-01-10,
 2020-01-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 mlxlogscore=999
 priorityscore=1501 impostorscore=0 suspectscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 lowpriorityscore=0 phishscore=0 spamscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1910280000
 definitions=main-2001100129
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 148.163.156.1
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

Hi,

This version contains two major changes. A fix for stepping an
AIL-changing instruction and a fix for when other breakpoints happen
mid-step.

The issues with AIL were:
-------------------------

1) I missed the fact that AIL only matters when translation is enabled
(i.e., MSR_IR|DR=0 => AIL=0) and,

2) if translation is enabled and we step over the hypercall that sets
AIL (H_SET_MODE), the step breakpoint will be at the wrong location
when the next Trace interrupt occurs.

These are fixed by 1) looking at MSR_IR|DR and choosing the
appropriate value for AIL and 2) by moving the breakpoint when AIL is
altered (QEMU handles the H_SET_MODE hcall, so this is easy to do).

The issue with breakpoints mid-step was:
----------------------------------------

Consider the scenario where the user happens to step into a guest
userspace program (e.g. by stepping a 'rfid') and from there steps an
instruction that causes an interrupt, such as an 'sc'. Since the 'sc'
is not traced (see Power ISA), its handler will execute before we get
to see the Trace interrupt. This is generally not an issue because
upon return from the syscall handler, the instruction following 'sc'
will execute and the Trace will happen then.

However, if the user has set a breakpoint inside the system call
interrupt handler*, the single step gets interrupted leaving the 0xd00
breakpoint still in place, as well as the SE bit, which is saved and
restored later by the syscall handler. Depending on how the user
proceeds the debugging in GDB, two issues can happen:

- stepi over rfid:

If the handler is left by stepping all the way until after 'rfid' we
would be left with an extra breakpoint at 0xd00 because the actual
step that will bring us out of the interrupt handler would be the step
over 'rfid' and not the continuation of the original step over the
'sc' instruction.

- continue:

If the handler is left by issuing 'continue', the 'rfid' at the end of
the handler would eventually restore the MSR it has saved (along with
the SE bit) and the next instruction execution would cause a Trace,
which we are now not prepared to handle since although the 0xd00
breakpoint of the original step is still there, we are not single
stepping anymore (due to the 'continue').

So to avoid these issues I'm introducing the concept of a "pending
step" so that we can detect the states mentioned above and take the
appropriate measures of avoiding leaving the 0xd00 breakpoint behind
and handling the rest of the original step properly, respectively.

* the 'sc' is not traced so we would not normally see the system call
  handler executing, therefore setting a breakpoint inside the handler
  to debug it is likely.

Other points worth noting:
--------------------------

The -4 in restore_singlestep_env was indeed wrong. I'm now saving the
stepped instruction before the step so that we can access it after the
step. This also saves us from doing another cpu_memory_rw_debug to
read the instruction later on.

Due to the way the threads exit the guest and how GDB is notified of
that, it is possible that it sees one vcpu's breakpoint before turning
single-stepping off for another. I'm now setting singlestep_enabled =
false right after we are done handling the step to avoid that issue.

The cpu_memory_rw_debug function reads and writes to the memory "from
the guests perspective", taking the partition table into
consideration, which for general debugging I assume is the desired
behavior, but for reads/writes made by QEMU for QEMU's own purposes,
such as the 0xd00 breakpoint, this is not the most appropriate
function to use. Changing it, would, however, mean duplicating some of
the breakpoint logic from common code.

If anyone wants to break this, here is my gdb command line:

gdb -q --ex "target remote :1234" \
--ex "break configure_exceptions" \    # this is in early_setup, changes LPCR_AIL, MSR_IR|DR
--ex "break program_check_exception" \ # inside an interrupt handler
--ex "break *0xc00000000000baa0" \     # right before the 'rfid' in system_call_exit
--ex "break *0x100ecb0c" \             # 'sc' inside an userspace program (busybox)
--ex "break *0xc00000000000e66c" \     # somewhere in fast_exception_return
--ex "break schedule" \                # for testing interleaving of steps/breakpoints
--ex "break cmdline_proc_show" \       # just an arbitrary user-triggered breakpoint
--ex "break __enter_rtas" \            # changes MSR_IR|DR, alternates endianness**
--ex "layout asm" build/vmlinux

The command:
(gdb) x/i 0xc000000000004d00
should always show "mtsprg  2,r13"
except in the middle of a pending step, when it should show ".long 0xdddd00".

** endianness needs to be switched manually with:
   (gdb) set endian <big|little>

---
v5 -> v6:
 - patch 1: new preliminary patch to help readers understand whether
            we are returning to GDB or into the guest after handling a
            KVM_EXIT_DEBUG vm exit;

 - patch 2: remove kvm_has_guest_debug_singlestep wrapper;

            rename functions to better indicate their purpose:
            kvm_arch_has_guest_debug_singlestep -> kvm_arch_can_singlestep
            kvm_arch_set_singlestep -> kvm_arch_emulate_singlestep

            g_assert_not_reached when calling kvm_set_singlestep with
            !kvm_enabled;

 - patch 3: move instruction helpers that are only used by kvm code
            into kvm.c;

	    new variable sstep_kind used to determine if guest is
	    doing a single step or if the single step was interrupted
	    and is pending completion;

	    new variable sstep_insn to avoid calling ppc_gdb_read_insn
	    twice;

	    use kvm_arch_can_singlestep instead of cap_ppc_singlestep
	    for functions' early exits;

	    set singlestep_enabled to false after handling the step;

            AIL fixes:
              take MSR_IR|DR into consideration when computing the
              trace_handler_addr;

              reposition the single step breakpoint when guest calls
              h_set_mode_resource_addr_trans_mode to change the AIL;

              trace_handler_addr is now saved during the step;

            Mid-step breakpoint fixes:
              if a breakpoint in the vcpu being stepped is reached,
	      mark the step as 'pending';

	      if an rfid happens during a pending step, do not start a
	      new step, let the original one finish;

	      if a breakpoint at 0xd00 happens during a pending step,
	      handle it as a single step.

v4 -> v5:
 - rebase to v4.2.0-rc5;

 - use KVM_CAP_PPC_GUEST_DEBUG_SSTEP (#176) which is now in kernel
   v5.5-rc1:
   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=1a9167a214f

 https://lists.nongnu.org/archive/html/qemu-devel/2019-12/msg02103.html

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
  target/ppc: Clarify the meaning of return values in kvm_handle_debug
  kvm-all: Introduce kvm_set_singlestep
  target/ppc: support single stepping with KVM HV

 accel/kvm/kvm-all.c         |   9 +
 accel/stubs/kvm-stub.c      |   5 +
 exec.c                      |   2 +-
 hw/ppc/spapr_hcall.c        |   5 +
 include/sysemu/kvm.h        |   3 +
 stubs/Makefile.objs         |   1 +
 stubs/kvm-arch-singlestep.c |  14 ++
 target/ppc/cpu.h            |  21 +++
 target/ppc/excp_helper.c    |  15 ++
 target/ppc/kvm.c            | 358 ++++++++++++++++++++++++++++++++++--
 target/ppc/kvm_ppc.h        |   6 +-
 11 files changed, 425 insertions(+), 14 deletions(-)
 create mode 100644 stubs/kvm-arch-singlestep.c

-- 
2.23.0


