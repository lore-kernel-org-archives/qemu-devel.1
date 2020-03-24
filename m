Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9878DC54EEB
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 20:51:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CB36205ED
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 20:51:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CB36205ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54884 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGqWb-0005TG-Hz
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 16:51:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60323)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1jGqVf-0004Wr-9O
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 16:50:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1jGqVd-0002Wt-BV
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 16:50:51 -0400
Received: from indium.canonical.com ([91.189.90.7]:33412)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1jGqVd-0002Vc-5d
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 16:50:49 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jGqVb-0002B6-K4
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2020 20:50:47 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 953732E80C0
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2020 20:50:47 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Mar 2020 20:43:23 -0000
From: Robert Henry <1866892@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: mhodog pmaydell
X-Launchpad-Bug-Reporter: Robert Henry (mhodog)
X-Launchpad-Bug-Modifier: Robert Henry (mhodog)
References: <158386917575.11737.1131406657888792626.malonedeb@soybean.canonical.com>
Message-Id: <158508260309.28539.56786720039269760.malone@gac.canonical.com>
Subject: [Bug 1866892] Re: guest OS catches a page fault bug when running
 dotnet
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="3a6db24bbe7280ec09bae73384238390fcc98ad3";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 68970cfc242ac587206769da614228d7a7d60473
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Bug 1866892 <1866892@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I've stepped/nexted from the helper_iret_protected, going deep into the
bowels of the TLB, MMU and page table engine.  None of which I
understand. The helper_ret_protected faults in the first POPQ_RA.  I'll
investigate the value of sp at the time of the POPQ_RA.

Here's the POPQ_RA in i386/seg_helper.c:2140

    sp =3D env->regs[R_ESP];
    ssp =3D env->segs[R_SS].base;
    new_eflags =3D 0; /* avoid warning */
#ifdef TARGET_X86_64
    if (shift =3D=3D 2) {
        POPQ_RA(sp, new_eip, retaddr);
        POPQ_RA(sp, new_cs, retaddr);
        new_cs &=3D 0xffff;
        if (is_iret) {
            POPQ_RA(sp, new_eflags, retaddr);
        }

and here's the stack.  Note some of the logical intermediate frames are
optimized out due to -O3 and inline. (the value of env-errorcode is 1)

0  0x0000555555a370c0 in raise_interrupt2
    (env=3Denv@entry=3D0x5555566ef200, intno=3D14, is_int=3Dis_int@entry=3D=
0, error_code=3D1, next_eip_addend=3Dnext_eip_addend@entry=3D0, retaddr=3Dr=
etaddr@entry=3D140736367565663) at /mnt/robhenry/qemu_robhenry_amd64/qemu/i=
nclude/exec/cpu-all.h:426
#1  0x0000555555a377f9 in raise_exception_err_ra
    (env=3Denv@entry=3D0x5555566ef200, exception_index=3D<optimized out>, e=
rror_code=3D<optimized out>, retaddr=3Dretaddr@entry=3D140736367565663) at =
/mnt/robhenry/qemu_robhenry_amd64/qemu/target/i386/excp_helper.c:127
#2  0x0000555555a37d69 in x86_cpu_tlb_fill
    (cs=3D0x5555566e69a0, addr=3D140727872411616, size=3D<optimized out>, a=
ccess_type=3DMMU_DATA_LOAD, mmu_idx=3D0, probe=3D<optimized out>, retaddr=
=3D140736367565663) at /mnt/robhenry/qemu_robhenry_amd64/qemu/target/i386/e=
xcp_helper.c:697
#3  0x0000555555952295 in tlb_fill
    (cpu=3D0x5555566e69a0, addr=3D140727872411616, size=3D8, access_type=3D=
MMU_DATA_LOAD, mmu_idx=3D0, retaddr=3D140736367565663)
    at /mnt/robhenry/qemu_robhenry_amd64/qemu/accel/tcg/cputlb.c:1017
#4  0x0000555555956320 in load_helper
    (full_load=3D0x555555956140 <helper_le_ldq_mmu>, code_read=3Dfalse, op=
=3DMO_64, retaddr=3D93825010692608, oi=3D48, addr=3D140727872411616, env=3D=
0x5555566ef200) at /mnt/robhenry/qemu_robhenry_amd64/qemu/include/exec/cpu-=
all.h:426
#5  0x0000555555956320 in helper_le_ldq_mmu
    (env=3Denv@entry=3D0x5555566ef200, addr=3Daddr@entry=3D140727872411616,=
 oi=3Doi@entry=3D48, retaddr=3Dretaddr@entry=3D140736367565663)
    at /mnt/robhenry/qemu_robhenry_amd64/qemu/accel/tcg/cputlb.c:1688
#6  0x0000555555956dc0 in cpu_load_helper
    (full_load=3D0x555555956140 <helper_le_ldq_mmu>, op=3DMO_64, retaddr=3D=
140736367565663, mmu_idx=3D<optimized out>, addr=3D140727872411616, env=3D0=
x5555566ef200) at /mnt/robhenry/qemu_robhenry_amd64/qemu/accel/tcg/cputlb.c=
:1752
#7  0x0000555555956dc0 in cpu_ldq_mmuidx_ra
    (env=3Denv@entry=3D0x5555566ef200, addr=3Daddr@entry=3D140727872411616,=
 mmu_idx=3D<optimized out>, ra=3Dra@entry=3D140736367565663)
--Type <RET> for more, q to quit, c to continue without paging--
    at /mnt/robhenry/qemu_robhenry_amd64/qemu/accel/tcg/cputlb.c:1799
#8  0x0000555555a4ff09 in helper_ret_protected
    (env=3Denv@entry=3D0x5555566ef200, shift=3Dshift@entry=3D2, is_iret=3Di=
s_iret@entry=3D1, addend=3Daddend@entry=3D0, retaddr=3D140736367565663)
    at /mnt/robhenry/qemu_robhenry_amd64/qemu/target/i386/seg_helper.c:2140
#9  0x0000555555a50ff5 in helper_iret_protected (env=3D0x5555566ef200, shif=
t=3D2, next_eip=3D-999377888)
    at /mnt/robhenry/qemu_robhenry_amd64/qemu/target/i386/seg_helper.c:2363
#10 0x00007fffbd321b5f in code_gen_buffer ()

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1866892

Title:
  guest OS catches a page  fault bug when running dotnet

Status in QEMU:
  New

Bug description:
  The linux guest OS catches a page fault bug when running the dotnet
  application.

  host =3D metal =3D x86_64
  host OS =3D ubuntu 19.10
  qemu emulation, without KVM, with "tiny code generator" tcg; no plugins; =
built from head/master
  guest emulation =3D x86_64
  guest OS =3D ubuntu 19.10
  guest app =3D dotnet, running any program

  qemu sha=3D7bc4d1980f95387c4cc921d7a066217ff4e42b70 (head/master Mar 10,
  2020)

  qemu invocation is:

  qemu/build/x86_64-softmmu/qemu-system-x86_64 \
    -m size=3D4096 \
    -smp cpus=3D1 \
    -machine type=3Dpc-i440fx-5.0,accel=3Dtcg \
    -cpu Skylake-Server-v1 \
    -nographic \
    -bios OVMF-pure-efi.fd \
    -drive if=3Dnone,id=3Dhd0,file=3Dubuntu-19.10-server-cloudimg-amd64.img=
 \
    -device virtio-blk,drive=3Dhd0 \
    -drive if=3Dnone,id=3Dcloud,file=3Dlinux_cloud_config.img \
    -device virtio-blk,drive=3Dcloud \
    -netdev user,id=3Duser0,hostfwd=3Dtcp::2223-:22 \
    -device virtio-net,netdev=3Duser0

  =

  Here's the guest kernel console output:

  =

  [ 2834.005449] BUG: unable to handle page fault for address: 00007fffffff=
c2c0
  [ 2834.009895] #PF: supervisor read access in user mode
  [ 2834.013872] #PF: error_code(0x0001) - permissions violation
  [ 2834.018025] IDT: 0xfffffe0000000000 (limit=3D0xfff) GDT: 0xfffffe00000=
01000 (limit=3D0x7f)
  [ 2834.022242] LDTR: NULL
  [ 2834.026306] TR: 0x40 -- base=3D0xfffffe0000003000 limit=3D0x206f
  [ 2834.030395] PGD 80000000360d0067 P4D 80000000360d0067 PUD 36105067 PMD=
 36193067 PTE 8000000076d8e867
  [ 2834.038672] Oops: 0001 [#4] SMP PTI
  [ 2834.042707] CPU: 0 PID: 13537 Comm: dotnet Tainted: G      D          =
 5.3.0-29-generic #31-Ubuntu
  [ 2834.050591] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIO=
S 0.0.0 02/06/2015
  [ 2834.054785] RIP: 0033:0x1555547eaeda
  [ 2834.059017] Code: d0 00 00 00 4c 8b a7 d8 00 00 00 4c 8b af e0 00 00 0=
0 4c 8b b7 e8 00 00 00 4c 8b bf f0 00 00 00 48 8b bf b0 00 00 00 9d 74 02 <=
48> cf 48 8d 64 24 30 5d c3 90 cc c3 66 90 55 4c 8b a7 d8 00 00 00
  [ 2834.072103] RSP: 002b:00007fffffffc2c0 EFLAGS: 00000202
  [ 2834.076507] RAX: 0000000000000000 RBX: 00001554b401af38 RCX: 000000000=
0000001
  [ 2834.080832] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00007ffff=
fffcfb0
  [ 2834.085010] RBP: 00007fffffffd730 R08: 0000000000000000 R09: 00007ffff=
fffd1b0
  [ 2834.089184] R10: 0000155555331dd5 R11: 00001555553ad8d0 R12: 000000000=
0000002
  [ 2834.093350] R13: 0000000000000001 R14: 0000000000000001 R15: 00001554b=
401d388
  [ 2834.097309] FS:  0000155554fa5740 GS:  0000000000000000
  [ 2834.101131] Modules linked in: isofs nls_iso8859_1 dm_multipath scsi_d=
h_rdac scsi_dh_emc scsi_dh_alua ppdev input_leds serio_raw parport_pc parpo=
rt sch_fq_codel ip_tables x_tables autofs4 btrfs zstd_compress raid10 raid4=
56 async_raid6_recov async_memcpy async_pq async_xor async_tx xor raid6_pq =
libcrc32c raid1 raid0 multipath linear crct10dif_pclmul crc32_pclmul ghash_=
clmulni_intel aesni_intel aes_x86_64 crypto_simd cryptd glue_helper virtio_=
net psmouse net_failover failover virtio_blk floppy
  [ 2834.122539] CR2: 00007fffffffc2c0
  [ 2834.126867] ---[ end trace dfae51f1d9432708 ]---
  [ 2834.131239] RIP: 0033:0x14d793262eda
  [ 2834.135715] Code: Bad RIP value.
  [ 2834.140243] RSP: 002b:00007ffddb4e2980 EFLAGS: 00000202
  [ 2834.144615] RAX: 0000000000000000 RBX: 000014d6f402acb8 RCX: 000000000=
0000002
  [ 2834.148943] RDX: 0000000001cd6950 RSI: 0000000000000000 RDI: 00007ffdd=
b4e3670
  [ 2834.153335] RBP: 00007ffddb4e3df0 R08: 0000000000000001 R09: 00007ffdd=
b4e3870
  [ 2834.157774] R10: 000014d793da9dd5 R11: 000014d793e258d0 R12: 000000000=
0000002
  [ 2834.162132] R13: 0000000000000001 R14: 0000000000000001 R15: 000014d6f=
402d040
  [ 2834.166239] FS:  0000155554fa5740(0000) GS:ffff97213ba00000(0000) knlG=
S:0000000000000000
  [ 2834.170529] CS:  0033 DS: 0000 ES: 0000 CR0: 0000000080050033
  [ 2834.174751] CR2: 000014d793262eb0 CR3: 0000000036130000 CR4: 000000000=
07406f0
  [ 2834.178892] PKRU: 55555554

  I run the application from a shell with `ulimit -s unlimited`
  (unlimited stack to size).

  The application creates a number of threads, and those threads make a
  lot of calls to sigaltstack() and mprotect(); see the relevant source
  for dotnet here
  https://github.com/dotnet/runtime/blob/15ec69e47b4dc56098e6058a11ccb6ae4d=
5d4fa1/src/coreclr/src/pal/src/thread/thread.cpp#L2467

  using strace -f on the app shows that no alt stacks come anywhere near
  the failing address; all alt stacks are in the heap, as expected.
  None of the mmap/mprotect/munmap syscalls were given arguments in the
  high memory 0x7fffffff0000 and up.

  gdb (with default signal stop/print/pass semantics) does not report
  any signals prior to the kernel bug being tripped, so I doubt the
  alternate signal stack is actually used.

  When I run the same dotnet binary on the host (eg, on "bare metal"),
  the host kernel seems happy and dotnet runs as expected.

  I have not tried different qemu or guest or host O/S.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1866892/+subscriptions

