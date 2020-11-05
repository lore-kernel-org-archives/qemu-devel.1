Return-Path: <SRS0=LLOU=EL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42BA1C00A89
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 04:28:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8192B20825
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 04:28:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8192B20825
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58832 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaWsw-0000hW-G9
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 23:28:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40184)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kaWqK-0005Vh-FS
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 23:25:48 -0500
Received: from indium.canonical.com ([91.189.90.7]:38070)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kaWqH-0000Bx-8h
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 23:25:48 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1kaWqG-0002rR-3K
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2020 04:25:44 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 178EC2E8130
 for <qemu-devel@nongnu.org>; Thu,  5 Nov 2020 04:25:44 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2020 04:17:20 -0000
From: Launchpad Bug Tracker <1715162@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Expired; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: janitor ross th-huth
X-Launchpad-Bug-Reporter: Ross Burton (ross)
X-Launchpad-Bug-Modifier: Launchpad Janitor (janitor)
References: <150462068248.17409.85035777459599057.malonedeb@gac.canonical.com>
Message-Id: <160454984104.10129.5238259602719388011.malone@loganberry.canonical.com>
Subject: [Bug 1715162] Re: qemu-user crashing when writing core dump
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="e39939c02bd86af4202bc6e2123a7708215ec8ea"; Instance="production"
X-Launchpad-Hash: b077dd8b787d785397fe8a4f5556a8a99c3a8bdf
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/04 21:30:42
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -65
X-Spam_score: -6.6
X-Spam_bar: ------
X-Spam_report: (-6.6 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Reply-To: Bug 1715162 <1715162@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

[Expired for QEMU because there has been no activity for 60 days.]

** Changed in: qemu
       Status: Incomplete =3D> Expired

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1715162

Title:
  qemu-user crashing when writing core dump

Status in QEMU:
  Expired

Bug description:
  I've a binary I'm running in qemux86-64 but it is segfaulting.  Whilst
  qemu writes the core dump for that, qemu itself is segfaulting.

  (gdb) bt full
  #0  0x00007efdd962e32e in sigsuspend () from /data/poky-tmp/master/build/=
sysroots-uninative/x86_64-linux/lib/libc.so.6
  No symbol table info available.
  #1  0x0000559176d74da4 in dump_core_and_abort (target_sig=3Dtarget_sig@en=
try=3D11)
      at /data/poky-tmp/master/build/work/x86_64-linux/qemu-native/2.10.0-r=
0/qemu-2.10.0/linux-user/signal.c:598
          cpu =3D <optimized out>
          env =3D <optimized out>
          ts =3D 0x55917a42d160
          core_dumped =3D <optimized out>
          act =3D {__sigaction_handler =3D {sa_handler =3D 0x0, sa_sigactio=
n =3D 0x0}, sa_mask =3D {__val =3D {18446744067267099647,
                18446744073709551615 <repeats 15 times>}}, sa_flags =3D 0, =
sa_restorer =3D 0x559100004010}
  #2  0x0000559176d75a38 in handle_pending_signal (cpu_env=3Dcpu_env@entry=
=3D0x55917a41c2a0, sig=3Dsig@entry=3D11,
      k=3Dk@entry=3D0x55917a42d190)
      at /data/poky-tmp/master/build/work/x86_64-linux/qemu-native/2.10.0-r=
0/qemu-2.10.0/linux-user/signal.c:6596
          handler =3D <optimized out>
          set =3D {__val =3D {4294967297, 4294967297, 94083256460867, 14, 1=
28, 0, 8, 3, 0, 1, 0, 4243635, 139628765215104,
              94083255852784, 94083309703424, 3351315493}}
          target_old_set =3D {sig =3D {0}}
          sa =3D <optimized out>
          ts =3D 0x55917a42d160
  #3  0x0000559176d765ac in process_pending_signals (cpu_env=3D<optimized o=
ut>)
      at /data/poky-tmp/master/build/work/x86_64-linux/qemu-native/2.10.0-r=
0/qemu-2.10.0/linux-user/signal.c:6674
          sig =3D 11
          ts =3D 0x55917a42d160
          set =3D {__val =3D {18446744067267100671, 18446744073709551615 <r=
epeats 15 times>}}
          blocked_set =3D <optimized out>
  #4  0x0000559176d5e0d8 in cpu_loop (env=3D0x55917a41c2a0)
      at /data/poky-tmp/master/build/work/x86_64-linux/qemu-native/2.10.0-r=
0/qemu-2.10.0/linux-user/main.c:369
          trapnr =3D 14
          pc =3D <optimized out>
          ret =3D <optimized out>
          info =3D {si_signo =3D 11, si_errno =3D 0, si_code =3D 196609, _s=
ifields =3D {_pad =3D {101897450, 192, -647518572, 32509,
                842, 0, 1993519912, 21905, 2051194736, 21905, 1997320506, 2=
1905, 2051195440, 21905, 1993546713, 0,
                12767276, 64, 1997233696, 21905, 42, 0, 1997233824, 21905, =
1997320464, 21905, 350755584, -1438022877},
              _kill =3D {_pid =3D 101897450, _uid =3D 192}, _timer =3D {_ti=
mer1 =3D 101897450, _timer2 =3D 192}, _rt =3D {
                _pid =3D 101897450, _uid =3D 192, _sigval =3D {sival_int =
=3D -647518572, sival_ptr =3D 139628739274388}},
              _sigchld =3D {_pid =3D 101897450, _uid =3D 192, _status =3D -=
647518572, _utime =3D 842, _stime =3D 94083252138792},
              _sigfault =3D {_addr =3D 824735618282}, _sigpoll =3D {_band =
=3D 101897450, _fd =3D 192}}}
  #5  0x0000559176d2a4b8 in main (argc=3D<optimized out>, argv=3D<optimized=
 out>, envp=3D<optimized out>)
      at /data/poky-tmp/master/build/work/x86_64-linux/qemu-native/2.10.0-r=
0/qemu-2.10.0/linux-user/main.c:4862
          regs1 =3D {r15 =3D 0, r14 =3D 0, r13 =3D 0, r12 =3D 0, rbp =3D 0,=
 rbx =3D 0, r11 =3D 0, r10 =3D 0, r9 =3D 0, r8 =3D 0, rax =3D 0,
            rcx =3D 0, rdx =3D 0, rsi =3D 0, rdi =3D 0, orig_rax =3D 0, rip=
 =3D 274888416832, cs =3D 0, eflags =3D 0,
            rsp =3D 274888401360, ss =3D 0}
          regs =3D 0x7ffda5b29fc0
          info1 =3D {load_bias =3D 274888413184, load_addr =3D 274877906944=
, start_code =3D 274877906944,
            end_code =3D 274877917360, start_data =3D 274880015120, end_dat=
a =3D 274880016400, start_brk =3D 0,
            brk =3D 274880016472, start_mmap =3D 183251939328, start_stack =
=3D 274888401360, stack_limit =3D 274880024576,
            entry =3D 274888416832, code_offset =3D 0, data_offset =3D 0, s=
aved_auxv =3D 274888402256,
            auxv_len =3D 18446744073709550728, arg_start =3D 274888401368, =
arg_end =3D 274888401408,
            arg_strings =3D 274888402550, env_strings =3D 274888402788, fil=
e_string =3D 274888413067, elf_flags =3D 0,
            personality =3D 0}
          info =3D 0x7ffda5b2a070
          bprm =3D {
            buf =3D "\177ELF\002\001\001\000\000\000\000\000\000\000\000\00=
0\003\000>\000\001\000\000\000@\016\000\000\000\000\000\000@\000\000\000\00=
0\000\000\000\230`\002\000\000\000\000\000\000\000\000\000@\000\070\000\006=
\000@\000\027\000\026\000\001\000\000\000\005", '\000' <repeats 27 times>, =
"\264C\002\000\000\000\000\000\264C\002\000\000\000\000\000\000\000 \000\00=
0\000\000\000\001\000\000\000\006\000\000\000\240G\002\000\000\000\000\000\=
240G\"\000\000\000\000\000\240G\"\000\000\000\000\000\330\027\000\000\000\0=
00\000\000p\031\000\000\000\000\000\000\000\000 \000\000\000\000\000\002\00=
0\000\000\006\000\000\000\030N\002\000\000\000\000\000\030N\"\000\000\000\0=
00\000"..., p =3D 274888401360, fd =3D 3,
            e_uid =3D 1000, e_gid =3D 1000, argc =3D 5, envc =3D 104, argv =
=3D 0x55917a42d120, envp =3D 0x55917a42a8f0,
            filename =3D 0x7ffda5b2c683 "/data/poky-tmp/master/build/work/i=
ntel_corei7_64-poky-linux/core-image-weston/1.0-r0/rootfs/usr/bin/fc-cache"=
, core_dump =3D 0x559176d76ed0 <elf_core_dump>}
          ts =3D <optimized out>
          env =3D 0x55917a41c2a0
          cpu =3D 0x55917a414010
          target_environ =3D 0x55917a42a8f0
          wrk =3D 0x55917a42ac30
          target_argv =3D 0x55917a42d120
          target_argc =3D 5
          i =3D <optimized out>
          ret =3D <optimized out>
          execfd =3D <optimized out>

  (I'll reproduce this with glibc debug symbols shortly)

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1715162/+subscriptions

