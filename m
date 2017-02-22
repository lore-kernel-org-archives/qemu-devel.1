Received: from eggs.gnu.org ([2001:4830:134:3::10]:51867)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cgd11-0000ux-2P
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 14:55:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cgd0x-0002vo-5U
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 14:55:55 -0500
Received: from mail-wm0-x22b.google.com ([2a00:1450:400c:c09::22b]:35441)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cgd0w-0002vc-SI
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 14:55:51 -0500
Received: by mail-wm0-x22b.google.com with SMTP id v186so150756787wmd.0
	for <qemu-devel@nongnu.org>; Wed, 22 Feb 2017 11:55:50 -0800 (PST)
References: <20170222171327.26624-1-alex.bennee@linaro.org>
	<148778745330.150.5479386803551876071@0e2666bad730>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <148778745330.150.5479386803551876071@0e2666bad730>
Date: Wed, 22 Feb 2017 19:55:56 +0000
Message-ID: <8737f6vw37.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v13 00/24] MTTCG Base enabling patches with
 ARM enablement
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com, rth@twiddle.net, peter.maydell@linaro.org, mttcg@listserver.greensocs.com, nikunj@linux.vnet.ibm.com, jan.kiszka@siemens.com, mark.burton@greensocs.com, a.rigo@virtualopensystems.com, cota@braap.org, serge.fdrv@gmail.com, pbonzini@redhat.com, bobby.prani@gmail.com, bamvor.zhangjian@linaro.org, fred.konrad@greensocs.com


no-reply@patchew.org writes:

> Hi,
>
> This series failed build test on s390x host. Please find the details below.
>
> Type: series
> Subject: [Qemu-devel] [PATCH v13 00/24] MTTCG Base enabling patches with ARM enablement
> Message-id: 20170222171327.26624-1-alex.bennee@linaro.org
>
> === TEST SCRIPT BEGIN ===
> #!/bin/bash
> # Testing script will be invoked under the git checkout with
> # HEAD pointing to a commit that has the patches applied on top of "base"
> # branch
> set -e
> echo "=== ENV ==="
> env
> echo "=== PACKAGES ==="
> rpm -qa
> echo "=== TEST BEGIN ==="
> CC=$HOME/bin/cc
> INSTALL=$PWD/install
> BUILD=/var/tmp/patchew-qemu-build
> echo -n "Using CC: "
> realpath $CC
> test -e $BUILD && rm -rf $BUILD
> mkdir -p $BUILD $INSTALL
> SRC=$PWD
> cd $BUILD
> $SRC/configure --cc=$CC --prefix=$INSTALL
> make -j4
> make check -j4
> make install
> === TEST SCRIPT END ===
>
> Updating 3c8cf5a9c21ff8782164d1def7f44bd888713384
> From https://github.com/patchew-project/qemu
>  - [tag update]      patchew/1487763883-4877-1-git-send-email-nikunj@linux.vnet.ibm.com -> patchew/1487763883-4877-1-git-send-email-nikunj@linux.vnet.ibm.com
>  - [tag update]      patchew/20170222121527.7009-1-cornelia.huck@de.ibm.com -> patchew/20170222121527.7009-1-cornelia.huck@de.ibm.com
>  * [new tag]         patchew/20170222171327.26624-1-alex.bennee@linaro.org -> patchew/20170222171327.26624-1-alex.bennee@linaro.org
> Switched to a new branch 'test'
> 1045fbc tcg: enable MTTCG by default for ARM on x86 hosts
> 8a28277 hw/misc/imx6_src: defer clearing of SRC_SCR reset bits
> b03a900 target-arm: ensure all cross vCPUs TLB flushes complete
> d06c981 target-arm: don't generate WFE/YIELD calls for MTTCG
> ee4ea53 target-arm/powerctl: defer cpu reset work to CPU context
> 1dfc884 cputlb: introduce tlb_flush_*_all_cpus[_synced]
> 6e41ba9 cputlb: atomically update tlb fields used by tlb_reset_dirty
> a7636a0 cputlb: add tlb_flush_by_mmuidx async routines
> 7956595 cputlb and arm/sparc targets: convert mmuidx flushes from varg to bitmap
> 3bb2a0e cputlb: introduce tlb_flush_* async work.
> d9e636a cputlb: tweak qemu_ram_addr_from_host_nofail reporting
> a87ddd2 cputlb: add assert_cpu_is_self checks
> c7f549b tcg: handle EXCP_ATOMIC exception for system emulation
> 5b31921 tcg: enable thread-per-vCPU
> d6edfc4 tcg: enable tb_lock() for SoftMMU
> d650c59 tcg: remove global exit_request
> 20a3c7d tcg: drop global lock during TCG code execution
> c6f8201 tcg: rename tcg_current_cpu to tcg_current_rr_cpu
> 1473067 tcg: add kick timer for single-threaded vCPU emulation
> 497072f tcg: add options for enabling MTTCG
> f093899 tcg: move TCG_MO/BAR types into own file
> cc02aae mttcg: Add missing tb_lock/unlock() in cpu_exec_step()
> 414fdc5 mttcg: translate-all: Enable locking debug in a debug build
> d8651bb docs: new design document multi-thread-tcg.txt
>
> === OUTPUT BEGIN ===
<snip>
>   GTESTER check-qtest-or1k
>   GTESTER check-qtest-ppc64
>   GTESTER check-qtest-ppcemb
>   GTESTER check-qtest-ppc
> "kvm" accelerator not found.
> Warning! iasl couldn't parse the expected aml
> Warning! iasl couldn't parse the expected aml
>   GTESTER check-qtest-s390x
> Warning! iasl couldn't parse the expected aml
> "kvm" accelerator not found.
> Warning! iasl couldn't parse the expected aml
> Warning! iasl couldn't parse the expected aml
> Warning! iasl couldn't parse the expected aml
> Warning! iasl couldn't parse the expected aml
> "kvm" accelerator not found.
> Warning! iasl couldn't parse the expected aml
> Warning! iasl couldn't parse the expected aml
> Warning! iasl couldn't parse the expected aml
> "kvm" accelerator not found.
> Warning! iasl couldn't parse the expected aml
> Warning! iasl couldn't parse the expected aml
> Warning! iasl couldn't parse the expected aml
> "kvm" accelerator not found.
> **
> ERROR:/var/tmp/patchew-tester-tmp-_186415r/src/cpus.c:1554:qemu_mutex_lock_iothread: assertion failed: (!qemu_mutex_iothread_locked())
> GTester: last random seed: R02Sf1ce767b432f1559eaf8cc0c5a31eb02

Well I've seen this before if the IRQ chain doesn't do locking properly
but I'm at a loss why this breaks on an s390 host as the code is common.

Does anyone have a spare s390 that I can test on?

> "kvm" accelerator not found.
> Warning! iasl couldn't parse the expected aml
> Warning! iasl couldn't parse the expected aml
> Warning! iasl couldn't parse the expected aml
> Warning! iasl couldn't parse the expected aml
> "kvm" accelerator not found.
> Warning! iasl couldn't parse the expected aml
> Warning! iasl couldn't parse the expected aml
> Warning! iasl couldn't parse the expected aml
> Warning! iasl couldn't parse the expected aml
> "kvm" accelerator not found.
>   GTESTER check-qtest-sh4eb
> Warning! iasl couldn't parse the expected aml
> Warning! iasl couldn't parse the expected aml
> Warning! iasl couldn't parse the expected aml
> Warning! iasl couldn't parse the expected aml
> "kvm" accelerator not found.
> **
> ERROR:/var/tmp/patchew-tester-tmp-_186415r/src/cpus.c:1554:qemu_mutex_lock_iothread: assertion failed: (!qemu_mutex_iothread_locked())
> GTester: last random seed: R02Sf715de4b174a658e8948e81f3e393168
> "kvm" accelerator not found.
> Warning! iasl couldn't parse the expected aml
> Warning! iasl couldn't parse the expected aml
> Warning! iasl couldn't parse the expected aml
> Warning! iasl couldn't parse the expected aml
> Warning! iasl couldn't parse the expected aml
>   GTESTER check-qtest-sh4
>   GTESTER check-qtest-sparc64
>   GTESTER check-qtest-sparc
> Could not open option rom 'nvram1': No such file or directory
> Could not open option rom '1up-md.bin': No such file or directory
> Could not open option rom '1up-hv.bin': No such file or directory
> Could not open option rom 'reset.bin': No such file or directory
> Could not open option rom 'q.bin': No such file or directory
> Could not open option rom 'openboot.bin': No such file or directory
>   GTESTER check-qtest-tricore
>   GTESTER check-qtest-unicore32
>   GTESTER check-qtest-x86_64
>   GTESTER check-qtest-xtensaeb
>   GTESTER check-qtest-xtensa
>   GTESTER tests/test-qobject-output-visitor
>   GTESTER tests/test-clone-visitor
>   GTESTER tests/test-qobject-input-visitor
>   GTESTER tests/test-qobject-input-strict
>   GTESTER tests/test-qmp-commands
>   GTESTER tests/test-string-input-visitor
>   GTESTER tests/test-string-output-visitor
>   GTESTER tests/test-qmp-event
>   GTESTER tests/test-opts-visitor
>   GTESTER tests/test-visitor-serialization
>   GTESTER tests/test-qht-par
> "kvm" accelerator not found.
> Warning! iasl couldn't parse the expected aml
> Warning! iasl couldn't parse the expected aml
> Warning! iasl couldn't parse the expected aml
> "kvm" accelerator not found.
> "kvm" accelerator not found.
> "kvm" accelerator not found.
> Warning! iasl couldn't parse the expected aml
> Warning! iasl couldn't parse the expected aml
> Warning! iasl couldn't parse the expected aml
> Warning! iasl couldn't parse the expected aml
> "kvm" accelerator not found.
> Warning! iasl couldn't parse the expected aml
> Warning! iasl couldn't parse the expected aml
> Warning! iasl couldn't parse the expected aml
> "kvm" accelerator not found.
> Warning! iasl couldn't parse the expected aml
> Warning! iasl couldn't parse the expected aml
> Warning! iasl couldn't parse the expected aml
> "kvm" accelerator not found.
> **
> ERROR:/var/tmp/patchew-tester-tmp-_186415r/src/cpus.c:1554:qemu_mutex_lock_iothread: assertion failed: (!qemu_mutex_iothread_locked())
> GTester: last random seed: R02Sa8532fcbb9e49ae4113248e56a8274f1
> "kvm" accelerator not found.
> Warning! iasl couldn't parse the expected aml
> Warning! iasl couldn't parse the expected aml
> Warning! iasl couldn't parse the expected aml
> Warning! iasl couldn't parse the expected aml
> "kvm" accelerator not found.
> Warning! iasl couldn't parse the expected aml
> Warning! iasl couldn't parse the expected aml
> Warning! iasl couldn't parse the expected aml
> Warning! iasl couldn't parse the expected aml
> "kvm" accelerator not found.
> Warning! iasl couldn't parse the expected aml
> Warning! iasl couldn't parse the expected aml
> Warning! iasl couldn't parse the expected aml
> Warning! iasl couldn't parse the expected aml
> "kvm" accelerator not found.
> **
> ERROR:/var/tmp/patchew-tester-tmp-_186415r/src/cpus.c:1554:qemu_mutex_lock_iothread: assertion failed: (!qemu_mutex_iothread_locked())
> GTester: last random seed: R02S63f8b7c7e8b2e9f7801942da82d33919
> "kvm" accelerator not found.
> Warning! iasl couldn't parse the expected aml
> Warning! iasl couldn't parse the expected aml
> Warning! iasl couldn't parse the expected aml
> Warning! iasl couldn't parse the expected aml
> Warning! iasl couldn't parse the expected aml
> /var/tmp/patchew-tester-tmp-_186415r/src/tests/Makefile.include:793: recipe for target 'check-qtest-i386' failed
> make: *** [check-qtest-i386] Error 1
> make: *** Waiting for unfinished jobs....
> "kvm" accelerator not found.
> "kvm" accelerator not found.
> /var/tmp/patchew-tester-tmp-_186415r/src/tests/Makefile.include:793: recipe for target 'check-qtest-x86_64' failed
> make: *** [check-qtest-x86_64] Error 1
> === OUTPUT END ===
>
> Test command exited with code: 2
>
>
> ---
> Email generated automatically by Patchew [http://patchew.org/].
> Please send your feedback to patchew-devel@freelists.org


--
Alex Bennée
