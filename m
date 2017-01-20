Received: from eggs.gnu.org ([2001:4830:134:3::10]:40299)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cUdjG-000287-TN
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 13:16:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cUdjB-00052J-RB
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 13:16:02 -0500
Received: from indium.canonical.com ([91.189.90.7]:46474)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cUdjB-0004zF-FZ
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 13:15:57 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cUdjA-00019v-69
	for <qemu-devel@nongnu.org>; Fri, 20 Jan 2017 18:15:56 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 2CB1C2E80C3
	for <qemu-devel@nongnu.org>; Fri, 20 Jan 2017 18:15:56 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Jan 2017 18:04:17 -0000
From: Thomas Huth <889827@bugs.launchpad.net>
Reply-To: Bug 889827 <889827@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20111113132930.26928.51216.malonedeb@soybean.canonical.com>
Message-Id: <20170120180417.20224.75695.malone@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 889827] Re: Qemu hangs on loadvm
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

QEMU 0.15 is pretty much outdated ... can you still reproduce this issue
with the latest version of QEMU, or could we close this ticket nowadays?

** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/889827

Title:
  Qemu hangs on loadvm

Status in QEMU:
  Incomplete

Bug description:
  Hello.

  I'm new here but I believe this is a bug in Qemu since I did nothing
  special and it stoped to work. Please excuse me if this is not a bug
  but my error.

  Suddenly loadvm command stoped to work. It restores state (I see this
  in SDL window) and after that Qemu hangs, you even can close it only
  with SIGKILL. I did nothing special to cause this. Just only saved one
  more state with savevm, don't know if this is related.

  I already had this trouble, started from a new image and the trouble
  disappeared. And now this happened again.

  Here is a piece of strace output (at the end, last few syscalls clock_get=
time - ioctl repeat infinitely):
  [pid 32681] ioctl(6, KVM_SET_USER_MEMORY_REGION, 0xbfd6305c) =3D 0
  [pid 32681] ioctl(6, KVM_SET_USER_MEMORY_REGION, 0xbfd6305c) =3D 0
  [pid 32681] ioctl(6, KVM_SET_USER_MEMORY_REGION, 0xbfd6305c) =3D 0
  [pid 32681] ioctl(6, KVM_GET_DIRTY_LOG, 0xbfd6313c) =3D 0
  [pid 32681] ioctl(6, KVM_GET_DIRTY_LOG, 0xbfd6313c) =3D 0
  [pid 32681] ioctl(6, KVM_SET_PIT2 or KVM_SET_VCPU_EVENTS, 0xbfd6332c) =3D=
 0
  [pid 32681] ioctl(13, KVM_SET_REGS, 0xbfd62d9c) =3D 0
  [pid 32681] ioctl(13, KVM_SET_FPU, 0xbfd62c7c) =3D 0
  [pid 32681] ioctl(13, KVM_SET_SREGS, 0xbfd62e84) =3D 0
  [pid 32681] ioctl(13, KVM_SET_MSRS, 0xbfd62e84) =3D 49
  [pid 32681] ioctl(13, KVM_SET_MP_STATE, 0xbfd62e80) =3D 0
  [pid 32681] ioctl(13, KVM_SET_LAPIC, 0xbfd62a2c) =3D 0
  [pid 32681] ioctl(13, KVM_SET_PIT2 or KVM_SET_VCPU_EVENTS, 0xbfd62e84) =
=3D 0
  [pid 32681] clock_gettime(CLOCK_MONOTONIC, {79640, 743993495}) =3D 0
  [pid 32681] write(9, "\1\0\0\0\0\0\0\0", 8) =3D 8
  [pid 32681] write(9, "\1\0\0\0\0\0\0\0", 8) =3D 8
  [pid 32681] clock_gettime(CLOCK_MONOTONIC, {79640, 744620600}) =3D 0
  [pid 32681] gettimeofday({1321185168, 995648}, NULL) =3D 0
  [pid 32681] clock_gettime(CLOCK_MONOTONIC, {79640, 744994949}) =3D 0
  [pid 32681] timer_gettime(0, {it_interval=3D{0, 0}, it_value=3D{0, 0}}) =
=3D 0
  [pid 32681] timer_settime(0, 0, {it_interval=3D{0, 0}, it_value=3D{0, 250=
000}}, NULL) =3D 0
  [pid 32681] tgkill(32681, 32682, SIGRT_6) =3D 0
  [pid 32681] gettimeofday({1321185168, 996771}, NULL) =3D 0
  [pid 32681] write(5, "\0", 1)           =3D 1
  [pid 32679] <... read resumed> "\0", 1) =3D 1
  [pid 32679] exit_group(0)               =3D ?
  [pid 32681] chdir("/")                  =3D 0
  [pid 32681] open("/dev/null", O_RDWR|O_LARGEFILE|O_CLOEXEC) =3D 16
  [pid 32681] dup2(16, 0)                 =3D 0
  [pid 32681] dup2(16, 1)                 =3D 1
  [pid 32681] dup2(16, 2)                 =3D 2
  [pid 32681] close(16)                   =3D 0
  [pid 32681] futex(0x8314124, FUTEX_CMP_REQUEUE_PRIVATE, 1, 2147483647, 0x=
88ea1d4, 2 <unfinished ...>
  [pid 32682] <... futex resumed> )       =3D 0
  [pid 32682] futex(0x88ea1d4, FUTEX_WAIT_PRIVATE, 2, NULL <unfinished ...>
  [pid 32681] <... futex resumed> )       =3D 1
  [pid 32681] futex(0x88ea1d4, FUTEX_WAKE_PRIVATE, 1 <unfinished ...>
  [pid 32682] <... futex resumed> )       =3D 0
  [pid 32682] futex(0x88ea1d4, FUTEX_WAKE_PRIVATE, 1) =3D 0
  [pid 32682] ioctl(13, KVM_RUN, 0)       =3D -1 EINTR (Interrupted system =
call)
  [pid 32682] rt_sigtimedwait([BUS RT_6],  <unfinished ...>
  [pid 32681] <... futex resumed> )       =3D 1
  [pid 32682] <... rt_sigtimedwait resumed> {si_signo=3DSIGRT_6, si_code=3D=
SI_TKILL, si_pid=3D32681, si_uid=3D1000, si_value=3D{int=3D0, ptr=3D0}}, {0=
, 0}, 8) =3D 38
  [pid 32681] select(13, [3 7 8 10 12], [], [], {0, 0} <unfinished ...>
  [pid 32682] rt_sigpending( <unfinished ...>
  [pid 32681] <... select resumed> )      =3D 3 (in [7 8 12], left {0, 0})
  [pid 32682] <... rt_sigpending resumed> [USR2]) =3D 0
  [pid 32681] futex(0x88ea1d4, FUTEX_WAIT_PRIVATE, 2, NULL <unfinished ...>
  [pid 32682] futex(0x88ea1d4, FUTEX_WAKE_PRIVATE, 1 <unfinished ...>
  [pid 32681] <... futex resumed> )       =3D -1 EAGAIN (Resource temporari=
ly unavailable)
  [pid 32682] <... futex resumed> )       =3D 0
  [pid 32681] read(12,  <unfinished ...>
  [pid 32682] ioctl(13, KVM_RUN <unfinished ...>
  [pid 32681] <... read resumed> "\f\0\0\0\0\0\0\0\0\0\0\0\251\177\0\0\350\=
3\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 128) =3D 128
  [pid 32681] read(8, "~*\0\0\0\0\0\0", 512) =3D 8
  [pid 32681] read(7,  <unfinished ...>
  [pid 32682] <... ioctl resumed> , 0)    =3D 0
  [pid 32681] <... read resumed> "\16\0\0\0\0\0\0\0\376\377\377\377\0\0\0\0=
\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 128) =3D 128
  [pid 32682] futex(0x88ea1d4, FUTEX_WAIT_PRIVATE, 2, NULL <unfinished ...>
  [pid 32681] rt_sigaction(SIGALRM, NULL, {0x811bd80, ~[KILL STOP RTMIN RT_=
1], 0}, 8) =3D 0
  [pid 32681] write(9, "\1\0\0\0\0\0\0\0", 8) =3D 8
  [pid 32681] read(7, 0xbfd635ac, 128)    =3D -1 EAGAIN (Resource temporari=
ly unavailable)
  [pid 32681] clock_gettime(CLOCK_MONOTONIC, {79640, 757376201}) =3D 0
  [pid 32681] clock_gettime(CLOCK_MONOTONIC, {79640, 757540467}) =3D 0
  [pid 32681] gettimeofday({1321185169, 8534}, NULL) =3D 0
  [pid 32681] clock_gettime(CLOCK_MONOTONIC, {79640, 757846302}) =3D 0
  [pid 32681] timer_gettime(0, {it_interval=3D{0, 0}, it_value=3D{0, 0}}) =
=3D 0
  [pid 32681] timer_settime(0, 0, {it_interval=3D{0, 0}, it_value=3D{0, 250=
000}}, NULL) =3D 0
  [pid 32681] clock_gettime(CLOCK_MONOTONIC, {79640, 758327369}) =3D 0
  [pid 32681] clock_gettime(CLOCK_MONOTONIC, {79640, 758470124}) =3D 0
  [pid 32681] poll([{fd=3D14, events=3DPOLLIN|POLLOUT}], 1, -1) =3D 1 ([{fd=
=3D14, revents=3DPOLLIN|POLLOUT}])
  [pid 32681] read(14, "\34\0i\0\3\0 \2j\1\0\0:\321\275\4\0\0\0\0\0\0\0\0\0=
\0\0\0\0\0\0\0"..., 4096) =3D 192
  [pid 32681] writev(14, [{"\22\0\7\0\3\0 \2'\0\0\0\37\0\0\0\10\1\4\0\4\0\0=
\0QEMU\22\0\7\0"..., 116}, {NULL, 0}, {"", 0}], 3) =3D 116
  [pid 32681] poll([{fd=3D14, events=3DPOLLIN}], 1, -1) =3D 1 ([{fd=3D14, r=
events=3DPOLLIN}])
  [pid 32681] read(14, "\34\0j\0\3\0 \2'\0\0\0\2708\277\4\0\0\0\0\0\0\0\0\0=
\0\0\0\0\0\0\0"..., 4096) =3D 160
  [pid 32681] read(14, 0xa535ed8, 4096)   =3D -1 EAGAIN (Resource temporari=
ly unavailable)
  [pid 32681] poll([{fd=3D15, events=3DPOLLIN|POLLOUT}], 1, -1) =3D 1 ([{fd=
=3D15, revents=3DPOLLOUT}])
  [pid 32681] writev(15, [{"+\0\1\0", 4}, {NULL, 0}, {"", 0}], 3) =3D 4
  [pid 32681] poll([{fd=3D15, events=3DPOLLIN}], 1, -1) =3D 1 ([{fd=3D15, r=
events=3DPOLLIN}])
  [pid 32681] read(15, "\1\2\n\0\0\0\0\0\4\0\340\0\0\0\0\0\0\0\0\0\0\0\0\0\=
0\0\0\0\0\0\0\0", 4096) =3D 32
  [pid 32681] read(15, 0xa540448, 4096)   =3D -1 EAGAIN (Resource temporari=
ly unavailable)
  [pid 32681] poll([{fd=3D14, events=3DPOLLIN|POLLOUT}], 1, -1) =3D 1 ([{fd=
=3D14, revents=3DPOLLOUT}])
  [pid 32681] writev(14, [{"\22\0\30\0\3\0 \2(\0\0\0)\0\0\0 \1\4\0\22\0\0\0=
\0\0\0\0\0\0\0\0"..., 136}, {NULL, 0}, {"", 0}], 3) =3D 136
  [pid 32681] poll([{fd=3D14, events=3DPOLLIN}], 1, -1) =3D 1 ([{fd=3D14, r=
events=3DPOLLIN}])
  [pid 32681] read(14, "\34\0o\0\3\0 \2(\0\0\0\3038\277\4\0\0\0\0\0\0\0\0\0=
\0\0\0\0\0\0\0"..., 4096) =3D 64
  [pid 32681] read(14, 0xa535ed8, 4096)   =3D -1 EAGAIN (Resource temporari=
ly unavailable)
  [pid 32681] poll([{fd=3D14, events=3DPOLLIN|POLLOUT}], 1, -1) =3D 1 ([{fd=
=3D14, revents=3DPOLLOUT}])
  [pid 32681] writev(14, [{"\20\1\5\0\n\0 \2_WIN_HINTS\4\0", 20}, {NULL, 0}=
, {"", 0}], 3) =3D 20
  [pid 32681] poll([{fd=3D14, events=3DPOLLIN}], 1, -1) =3D 1 ([{fd=3D14, r=
events=3DPOLLIN}])
  [pid 32681] read(14, "\1\0r\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0=
\0\0\0\0\0\0", 4096) =3D 32
  [pid 32681] read(14, 0xa535ed8, 4096)   =3D -1 EAGAIN (Resource temporari=
ly unavailable)
  [pid 32681] poll([{fd=3D14, events=3DPOLLIN|POLLOUT}], 1, -1) =3D 1 ([{fd=
=3D14, revents=3DPOLLOUT}])
  [pid 32681] writev(14, [{"\f\1\5\0\3\0 \2\f\0IN \3\0\0X\2\0\0\f\0\5\0\r\0=
 \2\f\0\0\0"..., 44}, {NULL, 0}, {"", 0}], 3) =3D 44
  [pid 32681] poll([{fd=3D14, events=3DPOLLIN}], 1, -1) =3D 1 ([{fd=3D14, r=
events=3DPOLLIN}])
  [pid 32681] read(14, "\0010u\0\2\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\=
0\0\0\0\0\0\0"..., 4096) =3D 40
  [pid 32681] read(14, 0xa535ed8, 4096)   =3D -1 EAGAIN (Resource temporari=
ly unavailable)
  [pid 32681] poll([{fd=3D14, events=3DPOLLIN|POLLOUT}], 1, -1) =3D 1 ([{fd=
=3D14, revents=3DPOLLOUT}])
  [pid 32681] writev(14, [{"&\1\2\0s\0\0\0", 8}, {NULL, 0}, {"", 0}], 3) =
=3D 8
  [pid 32681] poll([{fd=3D14, events=3DPOLLIN}], 1, -1) =3D 1 ([{fd=3D14, r=
events=3DPOLLIN}])
  [pid 32681] read(14, "\26\0u\0\3\0 \2\3\0 \2\0\0\0\0\4\0\30\0 \3X\2\0\0\0=
\0\0\0\0\0", 4096) =3D 32
  [pid 32681] poll([{fd=3D14, events=3DPOLLIN}], 1, -1) =3D 1 ([{fd=3D14, r=
events=3DPOLLIN}])
  [pid 32681] read(14, "\1\1v\0\0\0\0\0s\0\0\0*\1\0\1\352\0\303\2\352\0\303=
\2\0\0\0\0\0\0\0\0", 4096) =3D 32
  [pid 32681] read(14, 0xa535ed8, 4096)   =3D -1 EAGAIN (Resource temporari=
ly unavailable)
  [pid 32681] poll([{fd=3D14, events=3DPOLLIN|POLLOUT}], 1, -1) =3D 1 ([{fd=
=3D14, revents=3DPOLLOUT}])
  [pid 32681] writev(14, [{"\214\2\2\0\17\0 \2+\0\1\0", 12}, {NULL, 0}, {""=
, 0}], 3) =3D 12
  [pid 32681] poll([{fd=3D14, events=3DPOLLIN}], 1, -1) =3D 1 ([{fd=3D14, r=
events=3DPOLLIN}])
  [pid 32681] read(14, "\1\2x\0\0\0\0\0\4\0\340\0\0\0\0\0\0\0\0\0\0\0\0\0\0=
\0\0\0\0\0\0\0", 4096) =3D 32
  [pid 32681] read(14, 0xa535ed8, 4096)   =3D -1 EAGAIN (Resource temporari=
ly unavailable)
  [pid 32681] shmdt(0x747ac000)           =3D 0
  [pid 32681] shmget(IPC_PRIVATE, 1920000, IPC_CREAT|0777) =3D 6848525
  [pid 32681] shmat(6848525, 0, 0)        =3D 0x73dd7000
  [pid 32681] poll([{fd=3D14, events=3DPOLLIN|POLLOUT}], 1, -1) =3D 1 ([{fd=
=3D14, revents=3DPOLLOUT}])
  [pid 32681] writev(14, [{"\214\1\4\0\24\0 \2\r\200h\0\0\3\0\0+\2\1\0", 20=
}, {NULL, 0}, {"", 0}], 3) =3D 20
  [pid 32681] poll([{fd=3D14, events=3DPOLLIN}], 1, -1) =3D 1 ([{fd=3D14, r=
events=3DPOLLIN}])
  [pid 32681] read(14, "\1\2z\0\0\0\0\0\4\0\340\0\0\0\0\0\0\0\0\0\0\0\0\0\0=
\0\0\0\0\0\0\0", 4096) =3D 32
  [pid 32681] read(14, 0xa535ed8, 4096)   =3D -1 EAGAIN (Resource temporari=
ly unavailable)
  [pid 32681] shmctl(6848525, IPC_64|IPC_RMID, 0) =3D 0
  [pid 32681] poll([{fd=3D14, events=3DPOLLIN|POLLOUT}], 1, -1) =3D 1 ([{fd=
=3D14, revents=3DPOLLOUT}])
  [pid 32681] writev(14, [{"+\1\1\0", 4}, {NULL, 0}, {"", 0}], 3) =3D 4
  [pid 32681] poll([{fd=3D14, events=3DPOLLIN}], 1, -1) =3D 1 ([{fd=3D14, r=
events=3DPOLLIN}])
  [pid 32681] read(14, "\1\2{\0\0\0\0\0\4\0\340\0\0\0\0\0\0\0\0\0\0\0\0\0\0=
\0\0\0\0\0\0\0", 4096) =3D 32
  [pid 32681] read(14, 0xa535ed8, 4096)   =3D -1 EAGAIN (Resource temporari=
ly unavailable)
  [pid 32681] poll([{fd=3D14, events=3DPOLLIN|POLLOUT}], 1, -1) =3D 1 ([{fd=
=3D14, revents=3DPOLLOUT}])
  [pid 32681] writev(14, [{"\2\1\4\0\r\0 \2\0@\0\0\v\0 \2+\2\1\0", 20}, {NU=
LL, 0}, {"", 0}], 3) =3D 20
  [pid 32681] poll([{fd=3D14, events=3DPOLLIN}], 1, -1) =3D 1 ([{fd=3D14, r=
events=3DPOLLIN}])
  [pid 32681] read(14, "\1\2}\0\0\0\0\0\4\0\340\0\0\0\0\0\0\0\0\0\0\0\0\0\0=
\0\0\0\0\0\0\0", 4096) =3D 32
  [pid 32681] read(14, 0xa535ed8, 4096)   =3D -1 EAGAIN (Resource temporari=
ly unavailable)
  [pid 32681] poll([{fd=3D14, events=3DPOLLIN|POLLOUT}], 1, -1) =3D 1 ([{fd=
=3D14, revents=3DPOLLOUT}])
  [pid 32681] writev(14, [{"&\1\2\0\r\0 \2", 8}, {NULL, 0}, {"", 0}], 3) =
=3D 8
  [pid 32681] poll([{fd=3D14, events=3DPOLLIN}], 1, -1) =3D 1 ([{fd=3D14, r=
events=3DPOLLIN}])
  [pid 32681] read(14, "\1\1~\0\0\0\0\0s\0\0\0\0\0\0\0\352\0\303\2\346\0z\2=
\0\0\0\0\0\0\0\0", 4096) =3D 32
  [pid 32681] read(14, 0xa535ed8, 4096)   =3D -1 EAGAIN (Resource temporari=
ly unavailable)
  [pid 32681] poll([{fd=3D15, events=3DPOLLIN|POLLOUT}], 1, -1) =3D 1 ([{fd=
=3D15, revents=3DPOLLOUT}])
  [pid 32681] writev(15, [{"b\0\4\0\7\0 \2", 8}, {"MIT-SHM", 7}, {"\0", 1}]=
, 3) =3D 16
  [pid 32681] poll([{fd=3D15, events=3DPOLLIN}], 1, -1) =3D 1 ([{fd=3D15, r=
events=3DPOLLIN}])
  [pid 32681] read(15, "\1\0\v\0\0\0\0\0\1\214M\221\0\0\0\0\0\0\0\0\0\0\0\0=
\0\0\0\0\0\0\0\0", 4096) =3D 32
  [pid 32681] read(15, 0xa540448, 4096)   =3D -1 EAGAIN (Resource temporari=
ly unavailable)
  [pid 32681] poll([{fd=3D15, events=3DPOLLIN|POLLOUT}], 1, -1) =3D 1 ([{fd=
=3D15, revents=3DPOLLOUT}])
  [pid 32681] writev(15, [{"b\0\10\0\27\0 \2", 8}, {"Generic Event Extensio=
n", 23}, {"\0", 1}], 3) =3D 32
  [pid 32681] poll([{fd=3D15, events=3DPOLLIN}], 1, -1) =3D 1 ([{fd=3D15, r=
events=3DPOLLIN}])
  [pid 32681] read(15, "\1\0\f\0\0\0\0\0\1\212\0\0\0\0\0\0\0\0\0\0\0\0\0\0\=
0\0\0\0\0\0\0\0", 4096) =3D 32
  [pid 32681] read(15, 0xa540448, 4096)   =3D -1 EAGAIN (Resource temporari=
ly unavailable)
  [pid 32681] poll([{fd=3D15, events=3DPOLLIN|POLLOUT}], 1, -1) =3D 1 ([{fd=
=3D15, revents=3DPOLLOUT}])
  [pid 32681] writev(15, [{"\212\0\2\0\1\0\0\0", 8}, {NULL, 0}, {"", 0}], 3=
) =3D 8
  [pid 32681] poll([{fd=3D15, events=3DPOLLIN}], 1, -1) =3D 1 ([{fd=3D15, r=
events=3DPOLLIN}])
  [pid 32681] read(15, "\1\0\r\0\0\0\0\0\1\0\0\0w\26\10\10\0\0\0\0\0\0\0\0\=
310\316\357\10\n\204\17\10", 4096) =3D 32
  [pid 32681] read(15, 0xa540448, 4096)   =3D -1 EAGAIN (Resource temporari=
ly unavailable)
  [pid 32681] poll([{fd=3D15, events=3DPOLLIN|POLLOUT}], 1, -1) =3D 1 ([{fd=
=3D15, revents=3DPOLLOUT}])
  [pid 32681] writev(15, [{"\214\3\n\0\r\0 \2\16\0 \2 \3X\2\0\0\0\0 \3X\2\0=
\0\0\0\30\2\0\0"..., 40}, {NULL, 0}, {"", 0}], 3) =3D 40
  [pid 32681] read(15, 0xa540448, 4096)   =3D -1 EAGAIN (Resource temporari=
ly unavailable)
  [pid 32681] read(14, 0xa535ed8, 4096)   =3D -1 EAGAIN (Resource temporari=
ly unavailable)
  [pid 32681] select(15, [14], NULL, NULL, {0, 0}) =3D 0 (Timeout)
  [pid 32681] read(14, 0xa535ed8, 4096)   =3D -1 EAGAIN (Resource temporari=
ly unavailable)
  [pid 32681] select(15, [14], NULL, NULL, {0, 0}) =3D 0 (Timeout)
  [pid 32681] clock_gettime(CLOCK_MONOTONIC, {79641, 111491325}) =3D 0
  [pid 32681] clock_gettime(CLOCK_MONOTONIC, {79641, 111667535}) =3D 0
  [pid 32681] gettimeofday({1321185169, 362674}, NULL) =3D 0
  [pid 32681] clock_gettime(CLOCK_MONOTONIC, {79641, 111990481}) =3D 0
  [pid 32681] timer_gettime(0, {it_interval=3D{0, 0}, it_value=3D{0, 0}}) =
=3D 0
  [pid 32681] timer_settime(0, 0, {it_interval=3D{0, 0}, it_value=3D{0, 250=
000}}, NULL) =3D 0
  [pid 32681] gettimeofday({1321185169, 363389}, NULL) =3D 0
  [pid 32681] clock_gettime(CLOCK_MONOTONIC, {79641, 112738342}) =3D 0
  [pid 32681] gettimeofday({1321185169, 363745}, NULL) =3D 0
  [pid 32681] clock_gettime(CLOCK_MONOTONIC, {79641, 113119396}) =3D 0
  [pid 32681] timer_gettime(0, {it_interval=3D{0, 0}, it_value=3D{0, 0}}) =
=3D 0
  [pid 32681] timer_settime(0, 0, {it_interval=3D{0, 0}, it_value=3D{0, 250=
000}}, NULL) =3D 0
  [pid 32681] ioctl(6, KVM_IRQ_LINE_STATUS, 0xbfd63594) =3D 0
  [pid 32681] clock_gettime(CLOCK_MONOTONIC, {79641, 113866418}) =3D 0
  [pid 32681] gettimeofday({1321185169, 364876}, NULL) =3D 0
  [pid 32681] clock_gettime(CLOCK_MONOTONIC, {79641, 114204170}) =3D 0
  [pid 32681] timer_gettime(0, {it_interval=3D{0, 0}, it_value=3D{0, 0}}) =
=3D 0
  [pid 32681] timer_settime(0, 0, {it_interval=3D{0, 0}, it_value=3D{0, 250=
000}}, NULL) =3D 0
  [pid 32681] ioctl(6, KVM_IRQ_LINE_STATUS, 0xbfd63594) =3D 0
  [pid 32681] clock_gettime(CLOCK_MONOTONIC, {79641, 114923815}) =3D 0
  [pid 32681] gettimeofday({1321185169, 365931}, NULL) =3D 0
  [pid 32681] clock_gettime(CLOCK_MONOTONIC, {79641, 117299536}) =3D 0
  [pid 32681] timer_gettime(0, {it_interval=3D{0, 0}, it_value=3D{0, 0}}) =
=3D 0
  [pid 32681] timer_settime(0, 0, {it_interval=3D{0, 0}, it_value=3D{0, 250=
000}}, NULL) =3D 0
  [pid 32681] ioctl(6, KVM_IRQ_LINE_STATUS, 0xbfd63594) =3D 0

  Host system is Debian stable 32 bit, guest is Windows XP 32 bit, qemu
  version is 0.15.1.

  I start qemu with this commandline:
  qemu -m 1024 -hda image -localtime -monitor tcp:127.0.0.1:10000,server,no=
wait -net nic,model=3Drtl8139 -net user,hostfwd=3Dtcp:127.0.0.1:4444-:4444 =
-cpu host -daemonize -loadvm somestate
  (Or without -loadvm switch and use loadvm command in the monitor, result =
is the same)

  Now I have 4 states/snapshots in the image, the last one I added is
  995 Mb, but I can't load old one either (170Mb). My computer has 2Gb
  of RAM, I also tried to add 2Gb of swap and that does not help. Tried
  to delete new state with qemu-img snapshot -d, but still can't load
  old states.

  I'm not much help in identifying the reason... Probably this is related t=
o rather big states comparing with amount of memory...
  May be related: https://bugzilla.redhat.com/show_bug.cgi?id=3D586643

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/889827/+subscriptions
