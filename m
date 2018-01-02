Received: from eggs.gnu.org ([2001:4830:134:3::10]:49259)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eWECq-0008K5-Kf
	for qemu-devel@nongnu.org; Mon, 01 Jan 2018 23:29:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eWECn-0002PQ-CG
	for qemu-devel@nongnu.org; Mon, 01 Jan 2018 23:29:40 -0500
Received: from indium.canonical.com ([91.189.90.7]:47256)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eWECn-0002Od-5L
	for qemu-devel@nongnu.org; Mon, 01 Jan 2018 23:29:37 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eWECj-0005ei-9D
	for <qemu-devel@nongnu.org>; Tue, 02 Jan 2018 04:29:33 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 39E3A2E80D2
	for <qemu-devel@nongnu.org>; Tue,  2 Jan 2018 04:29:33 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 02 Jan 2018 04:17:26 -0000
From: Launchpad Bug Tracker <1246990@bugs.launchpad.net>
Reply-To: Bug 1246990 <1246990@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20131101065844.10659.568.malonedeb@soybean.canonical.com>
Message-Id: <151486664696.7876.7339120288096315773.malone@loganberry.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1246990] Re: [qemu-x86-64-linux-user 1.6.1] qemu:
 uncaught target signal 11 (Segmentation fault) - core dumped
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

[Expired for qemu (Ubuntu) because there has been no activity for 60
days.]

** Changed in: qemu (Ubuntu)
       Status: Incomplete =3D> Expired

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1246990

Title:
  [qemu-x86-64-linux-user 1.6.1] qemu: uncaught target signal 11
  (Segmentation fault) - core dumped

Status in QEMU:
  Expired
Status in qemu package in Ubuntu:
  Expired

Bug description:
  Rjsupplicant is an authentication client of Campus Network in most
  universities in China. Its Linux version has only x86 and amd64
  version.

  On linux:

  ./qemu-x86_64 is compiled from latest qemu 1.6.1, with ./configure
  options: --enable-debug --target-list=3Dx86_64-linux-user . Compiler is
  gcc version 4.7.3 (Debian 4.7.3-4)

  $ sudo ./qemu-x86_64  ./rjsupplicant -n eth0 -u USER -p PASS -d 1 -s inte=
rnet =

  qemu: uncaught target signal 11 (Segmentation fault) - core dumped

  $ sudo gdb ./qemu-x86_64
  (gdb) r ./rjsupplicant -n eth0 -u USER -p PASS -d 1 -s internet
  (gdb) where
  #0  0x00005555559c21bd in static_code_gen_buffer ()
  #1  0x00005555555b74d5 in cpu_tb_exec (cpu=3D0x555557972580, tb_ptr=3D0x5=
555559c2190 <static_code_gen_buffer+819792> "A\213n\250\205\355\017\205\257=
")
      at /home/USER/x/rjsupplicant/x64/qemu-1.6.1/cpu-exec.c:56
  #2  0x00005555555b817d in cpu_x86_exec (env=3D0x5555579726b0) at /home/US=
ER/x/rjsupplicant/x64/qemu-1.6.1/cpu-exec.c:631
  #3  0x00005555555d997a in cpu_loop (env=3D0x5555579726b0) at /home/USER/x=
/rjsupplicant/x64/qemu-1.6.1/linux-user/main.c:283
  #4  0x00005555555eca6b in clone_func (arg=3D0x7fffffffc1d0) at /home/USER=
/x/rjsupplicant/x64/qemu-1.6.1/linux-user/syscall.c:4266
  #5  0x00007ffff71bfe0e in start_thread (arg=3D0x7ffff7f04700) at pthread_=
create.c:311
  #6  0x00007ffff6ef493d in clone () at ../sysdeps/unix/sysv/linux/x86_64/c=
lone.S:113

  $ file rjsupplicant =

  rjsupplicant: ELF 64-bit LSB  executable, x86-64, version 1 (SYSV), dynam=
ically linked (uses shared libs), for GNU/Linux 2.6.9, not stripped

  $ uname -r
  3.10-2-amd64

  =

  And it can be run on Linux amd64 successfully.

  Though I don't have the source code of rjsupplicant, so I don't have
  further information.

  `qemu-x86_64 -strace ./rjsupplicant -n eth0 -u USER -p PASS -d 1 -s
  internet` is attached as strace_qemu.log

  =

  The binary is available to download at http://ge.tt/6pgG1tw/v/0

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1246990/+subscriptions
