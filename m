Received: from eggs.gnu.org ([2001:4830:134:3::10]:55018)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eOddC-0001RF-5a
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 01:01:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eOdd7-000133-A7
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 01:01:30 -0500
Received: from indium.canonical.com ([91.189.90.7]:53558)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eOdd7-00011n-1R
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 01:01:25 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eOdd5-0005Tm-EY
	for <qemu-devel@nongnu.org>; Tue, 12 Dec 2017 06:01:23 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 695162E80C7
	for <qemu-devel@nongnu.org>; Tue, 12 Dec 2017 06:01:23 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 12 Dec 2017 05:49:47 -0000
From: =?utf-8?q?Juan_Melgarejo_Lude=C3=B1a?= <juan.melgarejo@gmail.com>
Reply-To: Bug 902413 <902413@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20111210020345.24327.32197.malonedeb@chaenomeles.canonical.com>
Message-Id: <151305778754.20061.13367334433983272228.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 902413] Re: qemu-i386-user on ARM host: wine
 hangs/spins when trying to run anything
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

A year has passed since last update by Nathan Shearer, but status is
labeled 'incomplete'. Please check if it's solved with wine 3.0

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/902413

Title:
  qemu-i386-user on ARM host: wine hangs/spins when trying to run
  anything

Status in QEMU:
  Incomplete
Status in wine package in Gentoo Linux:
  New

Bug description:
  With qemu built from git from 217bfb445b54db618a30f3a39170bebd9fd9dbf2
  and configured with './configure --target-list=3Di386-linux-user
  --static --interp-prefix=3D/home/pgriffais/natty-i386/', trying to run
  wine 1.3.15 from an Ubuntu 11.04 chroot results in hangs. If I run an
  i386 emulated wineserver, wineserver hangs in:

  0x600c7f8c in read () at ../sysdeps/unix/syscall-template.S:82
  82	../sysdeps/unix/syscall-template.S: No such file or directory.
  	in ../sysdeps/unix/syscall-template.S
  (gdb) bt
  #0  0x600c7f8c in read () at ../sysdeps/unix/syscall-template.S:82
  #1  0x6004a316 in read (cpu_env=3D0x622c3ee8, num=3D3, arg1=3D6, arg2=3D1=
121255519, =

      arg3=3D1, arg4=3D134875664, arg5=3D1, arg6=3D1121255528, arg7=3D0, ar=
g8=3D0)
      at /usr/include/bits/unistd.h:45
  #2  do_syscall (cpu_env=3D0x622c3ee8, num=3D3, arg1=3D6, arg2=3D112125551=
9, arg3=3D1, =

      arg4=3D134875664, arg5=3D1, arg6=3D1121255528, arg7=3D0, arg8=3D0)
      at /home/ubuntu/src/qemu/linux-user/syscall.c:4691
  #3  0x600262f0 in cpu_loop (env=3D0x622c3ee8)
      at /home/ubuntu/src/qemu/linux-user/main.c:321
  #4  0x60026bbc in main (argc=3D<value optimized out>, =

      argv=3D<value optimized out>, envp=3D<value optimized out>)
      at /home/ubuntu/src/qemu/linux-user/main.c:3817

  While wine hangs in:

  0x600c84ac in recvmsg () at ../sysdeps/unix/syscall-template.S:82
  82	../sysdeps/unix/syscall-template.S: No such file or directory.
  	in ../sysdeps/unix/syscall-template.S
  (gdb) bt
  #0  0x600c84ac in recvmsg () at ../sysdeps/unix/syscall-template.S:82
  #1  0x60041c4e in do_sendrecvmsg (fd=3D4, target_msg=3D<value optimized o=
ut>, =

      flags=3D1073741824, send=3D0)
      at /home/ubuntu/src/qemu/linux-user/syscall.c:1834
  #2  0x600497ec in do_socketcall (cpu_env=3D<value optimized out>, num=3D1=
02, =

      arg1=3D17, arg2=3D1122504544, arg3=3D2076831732, arg4=3D1122504568, =

      arg5=3D2076942688, arg6=3D1122504888, arg7=3D0, arg8=3D0)
      at /home/ubuntu/src/qemu/linux-user/syscall.c:2235
  #3  do_syscall (cpu_env=3D<value optimized out>, num=3D102, arg1=3D17, =

      arg2=3D1122504544, arg3=3D2076831732, arg4=3D1122504568, arg5=3D20769=
42688, =

      arg6=3D1122504888, arg7=3D0, arg8=3D0)
      at /home/ubuntu/src/qemu/linux-user/syscall.c:6085
  #4  0x600262f0 in cpu_loop (env=3D0x622c3f08)
      at /home/ubuntu/src/qemu/linux-user/main.c:321
  #5  0x60026bbc in main (argc=3D<value optimized out>, =

      argv=3D<value optimized out>, envp=3D<value optimized out>)
      at /home/ubuntu/src/qemu/linux-user/main.c:3817

  However if I build wineserver 1.3.15 natively for ARM and run it on
  the host while wine is emulated, I get the following:

  root@tiberiusstation:/home/ubuntu# ./natty-i386/usr/bin/wine notepad
  Unsupported ancillary data: 1/2
  Unsupported ancillary data: 1/2
  Unsupported ancillary data: 1/2
  err:process:__wine_kernel_init boot event wait timed out

  I assume the last one is due to wineboot.exe hanging. The main wine
  process hangs in there:

  cg_temp_new_internal_i32 (temp_local=3D<value optimized out>)
      at /home/ubuntu/src/qemu/tcg/tcg.c:483
  483	}
  (gdb) bt
  #0  tcg_temp_new_internal_i32 (temp_local=3D<value optimized out>)
      at /home/ubuntu/src/qemu/tcg/tcg.c:483
  #1  0x60052ac6 in tcg_temp_new_i32 (val=3D6)
      at /home/ubuntu/src/qemu/tcg/tcg.h:442
  #2  tcg_const_i32 (val=3D6) at /home/ubuntu/src/qemu/tcg/tcg.c:530
  #3  0x6005ef0c in tcg_gen_shri_i32 (ot=3D2, op1=3D2, op2=3D7, is_right=3D=
1, =

      is_arith=3D0, s=3D<value optimized out>)
      at /home/ubuntu/src/qemu/tcg/tcg-op.h:605
  #4  gen_shift_rm_im (ot=3D2, op1=3D2, op2=3D7, is_right=3D1, is_arith=3D0=
, =

      s=3D<value optimized out>)
      at /home/ubuntu/src/qemu/target-i386/translate.c:1514
  #5  0x6006df90 in gen_shifti (s=3D0xbefea970, pc_start=3D<value optimized=
 out>)
      at /home/ubuntu/src/qemu/target-i386/translate.c:1946
  #6  disas_insn (s=3D0xbefea970, pc_start=3D<value optimized out>)
      at /home/ubuntu/src/qemu/target-i386/translate.c:5397
  #7  0x60091758 in gen_intermediate_code_internal (env=3D0x625656f8, =

      tb=3D0x402cdf48) at /home/ubuntu/src/qemu/target-i386/translate.c:7825
  #8  gen_intermediate_code_pc (env=3D0x625656f8, tb=3D0x402cdf48)
      at /home/ubuntu/src/qemu/target-i386/translate.c:7896
  #9  0x60054bf2 in cpu_restore_state (tb=3D0x402cdf48, env=3D0x62565690, =

      searched_pc=3D1617393812) at /home/ubuntu/src/qemu/translate-all.c:126
  #10 0x60091d9e in handle_cpu_signal (host_signum=3D<value optimized out>, =

      pinfo=3D<value optimized out>, puc=3D0xbefeab70)
      at /home/ubuntu/src/qemu/user-exec.c:117
  #11 cpu_x86_signal_handler (host_signum=3D<value optimized out>, =

      pinfo=3D<value optimized out>, puc=3D0xbefeab70)
      at /home/ubuntu/src/qemu/user-exec.c:458
  #12 0x6003c764 in host_signal_handler (host_signum=3D11, info=3D0xbefeaaf=
0, =

      puc=3D<value optimized out>)
      at /home/ubuntu/src/qemu/linux-user/signal.c:492
  #13 <signal handler called>
  #14 0x60677894 in static_code_gen_buffer ()
  #15 0x6000a260 in cpu_x86_exec (env=3D0x0)
      at /home/ubuntu/src/qemu/cpu-exec.c:566
  #16 0x68953200 in ?? ()
  #17 0x68953200 in ?? ()
  Backtrace stopped: previous frame identical to this frame (corrupt stack?

  Running the same version of wine through qemu-user-i386 running on an
  i386 host works fine with both wineserver and wine being emulated;
  that's the result I'm trying to achieve.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/902413/+subscriptions
