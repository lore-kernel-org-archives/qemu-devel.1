Received: from eggs.gnu.org ([2001:4830:134:3::10]:43702)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1duBM3-0005ir-1c
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 01:45:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1duBLz-0004JZ-Qw
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 01:45:55 -0400
Received: from indium.canonical.com ([91.189.90.7]:55295)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1duBLz-0004Ig-K0
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 01:45:51 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1duBLu-0003d9-QH
	for <qemu-devel@nongnu.org>; Tue, 19 Sep 2017 05:45:47 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id D7B6D2E84EF
	for <qemu-devel@nongnu.org>; Tue, 19 Sep 2017 04:30:17 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 19 Sep 2017 04:17:31 -0000
From: Launchpad Bug Tracker <1182490@bugs.launchpad.net>
Reply-To: Bug 1182490 <1182490@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20130521141106.20288.51455.malonedeb@gac.canonical.com>
Message-Id: <150579465122.28641.3118324055088297395.malone@loganberry.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1182490] Re: [qemu-1.5] coroutine-win32.c broken
 on NULL pointer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

[Expired for QEMU because there has been no activity for 60 days.]

** Changed in: qemu
       Status: Incomplete =3D> Expired

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1182490

Title:
  [qemu-1.5] coroutine-win32.c broken on NULL pointer

Status in QEMU:
  Expired

Bug description:
  Program received signal SIGSEGV, Segmentation fault.
  [Switching to Thread 4340.0x163c]
  qemu_coroutine_switch (action=3DCOROUTINE_TERMINATE, to_=3D0x0, from_=3D0=
x3ba1c80)
      at /home/cauchy/vcs/git/qemu/coroutine-win32.c:47
  (gdb) bt
  #0  qemu_coroutine_switch (action=3DCOROUTINE_TERMINATE, to_=3D0x0,
      from_=3D0x3ba1c80) at /home/cauchy/vcs/git/qemu/coroutine-win32.c:47
  #1  coroutine_trampoline (co_=3D0x3ba1c80)
      at /home/cauchy/vcs/git/qemu/coroutine-win32.c:58
  #2  0x0000000077098fed in ?? ()
  #3  0x0000000000000000 in ?? ()
  (gdb)
  (gdb) info registers
  rax            0x0      0
  rbx            0x3ba1c80        62528640
  rcx            0x0      0
  rdx            0x0      0
  rsi            0x770b28d0       1997220048
  rdi            0x3ba1b38        62528312
  rbp            0x0      0x0
  rsp            0xc0bff60        0xc0bff60
  r8             0x3184c0 3245248
  r9             0x43e31a 4449050
  r10            0x0      0
  r11            0x206    518
  r12            0x0      0
  r13            0x0      0
  r14            0x0      0
  r15            0x0      0
  rip            0x43e2cd 0x43e2cd <coroutine_trampoline+61>
  eflags         0x10206  [ PF IF RF ]
  cs             0x33     51
  ss             0x2b     43
  ds             0x0      0
  es             0x0      0
  fs             0x0      0
  gs             0x0      0
  (gdb) disassemble
  Dump of assembler code for function coroutine_trampoline:
     0x000000000043e290 <+0>:     push   %rdi
     0x000000000043e291 <+1>:     push   %rsi
     0x000000000043e292 <+2>:     push   %rbx
     0x000000000043e293 <+3>:     sub    $0x30,%rsp
     0x000000000043e297 <+7>:     mov    %rcx,%rbx
     0x000000000043e29a <+10>:    lea    0x26dc1f(%rip),%rcx        #
  0x6abec0 <__emutls_v.current>
     0x000000000043e2a1 <+17>:    mov    0x6868dd68(%rip),%rax        # 0x6=
8acc010
     0x000000000043e2a8 <+24>:    mov    %rax,0x28(%rsp)
     0x000000000043e2ad <+29>:    xor    %eax,%eax
     0x000000000043e2af <+31>:    callq  0x695808 <__emutls_get_address>
     0x000000000043e2b4 <+36>:    mov    0x9090d9(%rip),%rsi        #
  0xd47394 <__imp_SwitchToFiber>
     0x000000000043e2bb <+43>:    mov    %rax,%rdi
     0x000000000043e2be <+46>:    xchg   %ax,%ax
     0x000000000043e2c0 <+48>:    mov    0x8(%rbx),%rcx
     0x000000000043e2c4 <+52>:    callq  *(%rbx)
     0x000000000043e2c6 <+54>:    mov    0x10(%rbx),%rdx
     0x000000000043e2ca <+58>:    mov    %rdx,(%rdi)
  =3D> 0x000000000043e2cd <+61>:    movl   $0x2,0x38(%rdx)
     0x000000000043e2d4 <+68>:    mov    0x30(%rdx),%rcx
     0x000000000043e2d8 <+72>:    callq  *%rsi
     0x000000000043e2da <+74>:    jmp    0x43e2c0 <coroutine_trampoline+48>
  End of assembler dump.
  (gdb)

  =

  From:

  qemu_coroutine_switch (action=3DCOROUTINE_TERMINATE, to_=3D0x0, from_=3D0=
x3ba1c80)
      at /home/cauchy/vcs/git/qemu/coroutine-win32.c:47

  We can see qemu_coroutine_switch was call with to_=3DNULL, then crashed
  at line 47:

  to->action =3D action;

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1182490/+subscriptions
