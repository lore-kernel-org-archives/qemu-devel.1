Received: from eggs.gnu.org ([2001:4830:134:3::10]:41960)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fmkuB-0007F6-Ny
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 15:11:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fmku8-0005Ah-OH
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 15:10:59 -0400
Received: from indium.canonical.com ([91.189.90.7]:60140)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fmku8-0005AM-Bu
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 15:10:56 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fmku7-00018d-5J
	for <qemu-devel@nongnu.org>; Mon, 06 Aug 2018 19:10:55 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 2589F2E80C9
	for <qemu-devel@nongnu.org>; Mon,  6 Aug 2018 19:10:55 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Aug 2018 19:04:16 -0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Reply-To: Bug 1785670 <1785670@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <153357530568.2634.11935730297153408386.malonedeb@wampee.canonical.com>
Message-Id: <153358225682.18255.5813613025039919791.malone@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1785670] Re: Guest(ubuntu 18.04) crashes when
 trying uploading file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

#0  0x00007fffec275feb in raise () at /lib64/libc.so.6
#1  0x00007fffec2605c1 in abort () at /lib64/libc.so.6
#2  0x00007fffec2b89d7 in __libc_message () at /lib64/libc.so.6
#3  0x00007fffec2beeac in  () at /lib64/libc.so.6
#4  0x00007fffec2c091c in _int_free () at /lib64/libc.so.6
#5  0x00007ffff725b4d2 in g_free () at /lib64/libglib-2.0.so.0
#6  0x0000555555b49551 in m_free (m=3D0x7fffc44b0dd0) at /home/dgilbert/git=
/qemu/slirp/mbuf.c:114
#7  0x0000555555b4a33d in sbappend (so=3D<optimized out>, m=3D<optimized ou=
t>) at /home/dgilbert/git/qemu/slirp/sbuf.c:82
#8  0x0000555555b4d6ae in tcp_input (m=3D0x7fffc44b0dd0, iphlen=3D<optimize=
d out>, inso=3D<optimized out>, af=3D<optimized out>)
    at /home/dgilbert/git/qemu/slirp/tcp_input.c:1300
#9  0x0000555555b48d98 in slirp_input (slirp=3D<optimized out>, pkt=3D0x7ff=
fc44ad900 "RU\n", pkt_len=3Dpkt_len@entry=3D66)
    at /home/dgilbert/git/qemu/slirp/slirp.c:875
#10 0x0000555555b378e0 in net_slirp_receive (nc=3D<optimized out>, buf=3D<o=
ptimized out>, size=3D66) at /home/dgilbert/git/qemu/net/slirp.c:121
#11 0x0000555555b2ff4e in nc_sendv_compat (flags=3D<optimized out>, iovcnt=
=3D3, iov=3D0x7fffceff9a40, nc=3D0x5555567d5e60)
    at /home/dgilbert/git/qemu/net/net.c:701
#12 0x0000555555b2ff4e in qemu_deliver_packet_iov (sender=3D<optimized out>=
, flags=3D<optimized out>, iov=3D0x7fffceff9a40, iovcnt=3D3, opaque=3D0x555=
5567d5e60)
    at /home/dgilbert/git/qemu/net/net.c:728
#13 0x0000555555b32744 in qemu_net_queue_deliver_iov (iovcnt=3D3, iov=3D0x7=
fffceff9a40, flags=3D0, sender=3D0x555557a70ae0, queue=3D0x5555567d6010)
    at /home/dgilbert/git/qemu/net/queue.c:179
#14 0x0000555555b32744 in qemu_net_queue_send_iov (queue=3D0x5555567d6010, =
sender=3D0x555557a70ae0, flags=3D0, iov=3D0x7fffceff9a40, iovcnt=3D3, sent_=
cb=3D<optimized out>) at /home/dgilbert/git/qemu/net/queue.c:224
#15 0x0000555555a6ec61 in net_tx_pkt_sendv (pkt=3D0x555557a71010, iov_cnt=
=3D3, iov=3D0x7fffceff9a40, nc=3D0x555557a70ae0)
    at /home/dgilbert/git/qemu/hw/net/net_tx_pkt.c:546
#16 0x0000555555a6ec61 in net_tx_pkt_do_sw_fragmentation (pkt=3Dpkt@entry=
=3D0x555557a71010, nc=3Dnc@entry=3D0x555557a70ae0)
    at /home/dgilbert/git/qemu/hw/net/net_tx_pkt.c:588
#17 0x0000555555a6f87f in net_tx_pkt_send (pkt=3D0x555557a71010, nc=3Dnc@en=
try=3D0x555557a70ae0) at /home/dgilbert/git/qemu/hw/net/net_tx_pkt.c:625
#18 0x0000555555a78ff8 in e1000e_tx_pkt_send (queue_index=3D<optimized out>=
, tx=3D0x555557a1d1e8, core=3D0x5555579fcf80)
    at /home/dgilbert/git/qemu/hw/net/e1000e_core.c:665
#19 0x0000555555a78ff8 in e1000e_process_tx_desc (queue_index=3D<optimized =
out>, dp=3D0x7fffceff9f30, tx=3D0x555557a1d1e8, core=3D0x5555579fcf80)
    at /home/dgilbert/git/qemu/hw/net/e1000e_core.c:742
#20 0x0000555555a78ff8 in e1000e_start_xmit (core=3D0x5555579fcf80, txr=3D<=
optimized out>, txr=3D<optimized out>)
    at /home/dgilbert/git/qemu/hw/net/e1000e_core.c:933
#21 0x0000555555a792b9 in e1000e_set_tdt (core=3D<optimized out>, index=3D<=
optimized out>, val=3D<optimized out>)
    at /home/dgilbert/git/qemu/hw/net/e1000e_core.c:2450
#22 0x0000555555a7c0a5 in e1000e_core_write (core=3D0x5555579fcf80, addr=3D=
<optimized out>, val=3D220, size=3D4)
    at /home/dgilbert/git/qemu/hw/net/e1000e_core.c:3255
#23 0x0000555555876c37 in memory_region_write_accessor (mr=3D0x5555579fcbb0=
, addr=3D14360, value=3D<optimized out>, size=3D4, shift=3D<optimized out>,=
 mask=3D<optimized out>, attrs=3D...) at /home/dgilbert/git/qemu/memory.c:5=
27
---Type <return> to continue, or q <return> to quit---
 out>, access_size_max=3D<optimized out>, access_fn=3D0x555555876bc0 <memor=
y_region_write_accessor>, mr=3D0x5555579fcbb0, attrs=3D...) at /home/dgilbe=
rt/git/qemu/memory.c:594
#25 0x00005555558794c1 in memory_region_dispatch_write (mr=3Dmr@entry=3D0x5=
555579fcbb0, addr=3D14360, data=3D<optimized out>, size=3D4, attrs=3Dattrs@=
entry=3D...) at /home/dgilbert/git/qemu/memory.c:1479
#26 0x0000555555823833 in flatview_write_continue (fv=3Dfv@entry=3D0x7fffc5=
0aebc0, addr=3Daddr@entry=3D4273485848, attrs=3D..., buf=3Dbuf@entry=3D0x7f=
fff7ff3028 <incomplete sequence \334>, len=3Dlen@entry=3D4, addr1=3D<optimi=
zed out>, l=3D<optimized out>, mr=3D0x5555579fcbb0) at /home/dgilbert/git/q=
emu/exec.c:3255
#27 0x0000555555823a59 in flatview_write (fv=3D0x7fffc50aebc0, addr=3D42734=
85848, attrs=3D..., buf=3D0x7ffff7ff3028 <incomplete sequence \334>, len=3D=
4) at /home/dgilbert/git/qemu/exec.c:3294
#28 0x000055555582737f in address_space_write (as=3D<optimized out>, addr=
=3D<optimized out>, attrs=3D..., buf=3Dbuf@entry=3D0x7ffff7ff3028 <incomple=
te sequence \334>, len=3D<optimized out>) at /home/dgilbert/git/qemu/exec.c=
:3384
#29 0x000055555582740a in address_space_rw (as=3D<optimized out>, addr=3D<o=
ptimized out>, attrs=3D..., attrs@entry=3D..., buf=3Dbuf@entry=3D0x7ffff7ff=
3028 <incomplete sequence \334>, len=3D<optimized out>, is_write=3D<optimiz=
ed out>)
    at /home/dgilbert/git/qemu/exec.c:3395
#30 0x000055555588b7b8 in kvm_cpu_exec (cpu=3Dcpu@entry=3D0x55555683ddf0) a=
t /home/dgilbert/git/qemu/accel/kvm/kvm-all.c:1979
#31 0x0000555555862896 in qemu_kvm_cpu_thread_fn (arg=3D0x55555683ddf0) at =
/home/dgilbert/git/qemu/cpus.c:1215
#32 0x00007fffec605594 in start_thread () at /lib64/libpthread.so.0
#33 0x00007fffec3390df in clone () at /lib64/libc.so.6

(This is with a fedora guest, so that's irrelevant)

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1785670

Title:
  Guest(ubuntu 18.04) crashes when trying uploading file

Status in QEMU:
  Confirmed

Bug description:
  I speficy slirp network, and I can open websites, git clone repos. But
  when I try to upload a file to slack, or try to do a git push, it
  crashes.

  My host is ubuntu 16.04 with kernel 4.15.0-29-generic, and qemu is
  latest source in git(commit 1fb57da72ae0886e). The command I use is

  ./x86_64-softmmu/qemu-system-x86_64 -machine q35,accel=3Dkvm -m 2048
  -drive file=3D../qcow2/guest.qcow2  -netdev user,id=3Drealnet0 -device
  e1000e,netdev=3Drealnet0

  The trace is as follows

  *** Error in `./x86_64-softmmu/qemu-system-x86_64': free(): invalid next =
size (normal): 0x00007f66d80b7300 ***
  =3D=3D=3D=3D=3D=3D=3D Backtrace: =3D=3D=3D=3D=3D=3D=3D=3D=3D
  /lib/x86_64-linux-gnu/libc.so.6(+0x777e5)[0x7f66fb7967e5]
  /lib/x86_64-linux-gnu/libc.so.6(+0x8037a)[0x7f66fb79f37a]
  /lib/x86_64-linux-gnu/libc.so.6(cfree+0x4c)[0x7f66fb7a353c]
  ./x86_64-softmmu/qemu-system-x86_64(+0x6a8549)[0x55dc10c7d549]
  ./x86_64-softmmu/qemu-system-x86_64(+0x6a99d4)[0x55dc10c7e9d4]
  ./x86_64-softmmu/qemu-system-x86_64(+0x6ad09a)[0x55dc10c8209a]
  ./x86_64-softmmu/qemu-system-x86_64(+0x6a3feb)[0x55dc10c78feb]
  ./x86_64-softmmu/qemu-system-x86_64(+0x6a746e)[0x55dc10c7c46e]
  ./x86_64-softmmu/qemu-system-x86_64(+0x68fe2c)[0x55dc10c64e2c]
  ./x86_64-softmmu/qemu-system-x86_64(+0x685b3b)[0x55dc10c5ab3b]
  ./x86_64-softmmu/qemu-system-x86_64(+0x685bfd)[0x55dc10c5abfd]
  ./x86_64-softmmu/qemu-system-x86_64(+0x6885a8)[0x55dc10c5d5a8]
  ./x86_64-softmmu/qemu-system-x86_64(+0x688717)[0x55dc10c5d717]
  ./x86_64-softmmu/qemu-system-x86_64(+0x685d27)[0x55dc10c5ad27]
  ./x86_64-softmmu/qemu-system-x86_64(+0x685d54)[0x55dc10c5ad54]
  ./x86_64-softmmu/qemu-system-x86_64(+0x586bb8)[0x55dc10b5bbb8]
  ./x86_64-softmmu/qemu-system-x86_64(+0x586d92)[0x55dc10b5bd92]
  ./x86_64-softmmu/qemu-system-x86_64(+0x586ecd)[0x55dc10b5becd]
  ./x86_64-softmmu/qemu-system-x86_64(+0x593ea8)[0x55dc10b68ea8]
  ./x86_64-softmmu/qemu-system-x86_64(+0x59419d)[0x55dc10b6919d]
  ./x86_64-softmmu/qemu-system-x86_64(+0x5947df)[0x55dc10b697df]
  ./x86_64-softmmu/qemu-system-x86_64(+0x597ddf)[0x55dc10b6cddf]
  ./x86_64-softmmu/qemu-system-x86_64(+0x5989e7)[0x55dc10b6d9e7]
  ./x86_64-softmmu/qemu-system-x86_64(+0x58ae11)[0x55dc10b5fe11]
  ./x86_64-softmmu/qemu-system-x86_64(+0x30d4f6)[0x55dc108e24f6]
  ./x86_64-softmmu/qemu-system-x86_64(+0x30d70e)[0x55dc108e270e]
  ./x86_64-softmmu/qemu-system-x86_64(+0x310336)[0x55dc108e5336]
  ./x86_64-softmmu/qemu-system-x86_64(+0x2ac368)[0x55dc10881368]
  ./x86_64-softmmu/qemu-system-x86_64(+0x2ac4b2)[0x55dc108814b2]
  ./x86_64-softmmu/qemu-system-x86_64(+0x2ac7b8)[0x55dc108817b8]
  ./x86_64-softmmu/qemu-system-x86_64(+0x2ac809)[0x55dc10881809]
  ./x86_64-softmmu/qemu-system-x86_64(+0x32b673)[0x55dc10900673]
  ./x86_64-softmmu/qemu-system-x86_64(+0x2f2875)[0x55dc108c7875]
  ./x86_64-softmmu/qemu-system-x86_64(+0x81b91c)[0x55dc10df091c]
  /lib/x86_64-linux-gnu/libpthread.so.0(+0x76ba)[0x7f66fbaf06ba]
  /lib/x86_64-linux-gnu/libc.so.6(clone+0x6d)[0x7f66fb82641d]
  =3D=3D=3D=3D=3D=3D=3D Memory map: =3D=3D=3D=3D=3D=3D=3D=3D
  55dc105d5000-55dc112a9000 r-xp 00000000 103:02 5767220                   =
/home/biggerfish/src/qemu/x86_64-softmmu/qemu-system-x86_64
  55dc114a9000-55dc115bd000 r--p 00cd4000 103:02 5767220                   =
/home/biggerfish/src/qemu/x86_64-softmmu/qemu-system-x86_64
  55dc115bd000-55dc11773000 rw-p 00de8000 103:02 5767220                   =
/home/biggerfish/src/qemu/x86_64-softmmu/qemu-system-x86_64
  55dc11773000-55dc117b5000 rw-p 00000000 00:00 0 =

  55dc134d6000-55dc14e20000 rw-p 00000000 00:00 0                          =
[heap]
  7f6634000000-7f6634021000 rw-p 00000000 00:00 0 =

  7f6634021000-7f6638000000 ---p 00000000 00:00 0 =

  7f663c000000-7f663c021000 rw-p 00000000 00:00 0 =

  7f663c021000-7f6640000000 ---p 00000000 00:00 0 =

  7f6642000000-7f6644000000 rw-s 00000000 00:05 4882443                    =
/SYSV00000000 (deleted)
  7f6644000000-7f6644021000 rw-p 00000000 00:00 0 =

  7f6644021000-7f6648000000 ---p 00000000 00:00 0 =

  7f66491cc000-7f66491cd000 ---p 00000000 00:00 0 =

  7f66491cd000-7f66499cd000 rw-p 00000000 00:00 0 =

  7f66499cd000-7f66499ce000 ---p 00000000 00:00 0 =

  7f66499ce000-7f664a1ce000 rw-p 00000000 00:00 0 =

  7f664a1ce000-7f664a1cf000 ---p 00000000 00:00 0 =

  7f664a1cf000-7f664a9cf000 rw-p 00000000 00:00 0 =

  7f664a9cf000-7f664a9d0000 ---p 00000000 00:00 0 =

  7f664a9d0000-7f664b1d0000 rw-p 00000000 00:00 0 =

  7f664b1d0000-7f664b1d1000 ---p 00000000 00:00 0 =

  7f664b1d1000-7f664b9d1000 rw-p 00000000 00:00 0 =

  7f664b9d1000-7f664b9d2000 ---p 00000000 00:00 0 =

  7f664b9d2000-7f664bad2000 rw-p 00000000 00:00 0 =

  7f664bad2000-7f664bad3000 ---p 00000000 00:00 0 =

  7f664bad3000-7f664bbd3000 rw-p 00000000 00:00 0 =

  7f664bbd3000-7f664bbd4000 ---p 00000000 00:00 0 =

  7f664bbd4000-7f664bcd4000 rw-p 00000000 00:00 0 =

  7f664bcd4000-7f664bcd5000 ---p 00000000 00:00 0 =

  7f664bcd5000-7f664c4d5000 rw-p 00000000 00:00 0 =

  7f664c4d5000-7f664c4d6000 ---p 00000000 00:00 0 =

  7f664c4d6000-7f664c5d6000 rw-p 00000000 00:00 0 =

  7f664c5d6000-7f664c5d7000 ---p 00000000 00:00 0 =

  7f664c5d7000-7f664c6d7000 rw-p 00000000 00:00 0 =

  7f664c6d7000-7f664c6d8000 ---p 00000000 00:00 0 =

  7f664c6d8000-7f664c7d8000 rw-p 00000000 00:00 0 =

  7f664c7d8000-7f664c7d9000 ---p 00000000 00:00 0 =

  7f664c7d9000-7f664c8d9000 rw-p 00000000 00:00 0 =

  7f664c8d9000-7f664c8da000 ---p 00000000 00:00 0 =

  7f664c8da000-7f664c9da000 rw-p 00000000 00:00 0 =

  7f664c9da000-7f664c9db000 ---p 00000000 00:00 0 =

  7f664c9db000-7f664cadb000 rw-p 00000000 00:00 0 =

  7f664cadb000-7f664cadc000 ---p 00000000 00:00 0 =

  7f664cadc000-7f664cbdc000 rw-p 00000000 00:00 0 =

  7f664cbdc000-7f664cbdd000 ---p 00000000 00:00 0 =

  7f664cbdd000-7f664ccdd000 rw-p 00000000 00:00 0 =

  7f664ccdd000-7f664ccde000 ---p 00000000 00:00 0 =

  7f664ccde000-7f664cdde000 rw-p 00000000 00:00 0 =

  7f664cdde000-7f664cddf000 ---p 00000000 00:00 0 =

  7f664cddf000-7f664cedf000 rw-p 00000000 00:00 0 =

  7f664cedf000-7f664cee0000 ---p 00000000 00:00 0 =

  7f664cee0000-7f664cfe0000 rw-p 00000000 00:00 0 =

  7f664cfe0000-7f664cfe1000 ---p 00000000 00:00 0 =

  7f664cfe1000-7f664d0e1000 rw-p 00000000 00:00 0 =

  7f664d0e1000-7f664d0e2000 ---p 00000000 00:00 0 =

  7f664d0e2000-7f664d1e2000 rw-p 00000000 00:00 0 =

  7f664d1e2000-7f664d1e3000 ---p 00000000 00:00 0 =

  7f664d1e3000-7f664d2e3000 rw-p 00000000 00:00 0 =

  7f664d2e3000-7f664d2e4000 ---p 00000000 00:00 0 =

  7f664d2e4000-7f664d3e4000 rw-p 00000000 00:00 0 =

  7f664d3e4000-7f664d3e5000 ---p 00000000 00:00 0 =

  7f664d3e5000-7f664d4e5000 rw-p 00000000 00:00 0 =

  7f664d4e5000-7f664d4e6000 ---p 00000000 00:00 0 =

  7f664d4e6000-7f664d5e6000 rw-p 00000000 00:00 0 =

  7f664d5e6000-7f664d5e7000 ---p 00000000 00:00 0 =

  7f664d5e7000-7f664d6e7000 rw-p 00000000 00:00 0 =

  7f664d6e7000-7f664d6e8000 ---p 00000000 00:00 0 =

  7f664d6e8000-7f664d7e8000 rw-p 00000000 00:00 0 =

  7f664d7e8000-7f664d7e9000 ---p 00000000 00:00 0 =

  7f664d7e9000-7f664d8e9000 rw-p 00000000 00:00 0 =

  7f664d8e9000-7f664d8ea000 ---p 00000000 00:00 0 =

  7f664d8ea000-7f664d9ea000 rw-p 00000000 00:00 0 =

  7f664d9ea000-7f664d9eb000 ---p 00000000 00:00 0 =

  7f664d9eb000-7f664daeb000 rw-p 00000000 00:00 0 =

  7f664daeb000-7f664daec000 ---p 00000000 00:00 0 =

  7f664daec000-7f664dbec000 rw-p 00000000 00:00 0 =

  7f664dbec000-7f664dbed000 ---p 00000000 00:00 0 =

  7f664dbed000-7f664dced000 rw-p 00000000 00:00 0 =

  7f664dced000-7f664dcee000 ---p 00000000 00:00 0 =

  7f664dcee000-7f664ddee000 rw-p 00000000 00:00 0 =

  7f664ddee000-7f664ddef000 ---p 00000000 00:00 0 =

  7f664ddef000-7f664deef000 rw-p 00000000 00:00 0 =

  7f664deef000-7f664def0000 ---p 00000000 00:00 0 =

  7f664def0000-7f664dff0000 rw-p 00000000 00:00 0 =

  7f664dff0000-7f664dff1000 ---p 00000000 00:00 0 =

  7f664dff1000-7f664e0f1000 rw-p 00000000 00:00 0 =

  7f664e0f1000-7f664e0f2000 ---p 00000000 00:00 0 =

  7f664e0f2000-7f664e1f2000 rw-p 00000000 00:00 0 =

  7f664e1f2000-7f664e1f3000 ---p 00000000 00:00 0 =

  7f664e1f3000-7f664e2f3000 rw-p 00000000 00:00 0 =

  7f664e2f3000-7f664e2f4000 ---p 00000000 00:00 0 =

  7f664e2f4000-7f664e3f4000 rw-p 00000000 00:00 0 =

  7f664e3f4000-7f664e3f5000 ---p 00000000 00:00 0 =

  7f664e3f5000-7f664e4f5000 rw-p 00000000 00:00 0 =

  7f664e4f5000-7f664e4f6000 ---p 00000000 00:00 0 =

  7f664e4f6000-7f664e5f6000 rw-p 00000000 00:00 0 =

  7f664e5f6000-7f664e5f7000 ---p 00000000 00:00 0 =

  7f664e5f7000-7f664e6f7000 rw-p 00000000 00:00 0 =

  7f664e6f7000-7f664e6f8000 ---p 00000000 00:00 0 =

  7f664e6f8000-7f664e7f8000 rw-p 00000000 00:00 0 =

  7f664e7f8000-7f664e7f9000 ---p 00000000 00:00 0 =

  7f664e7f9000-7f664e8f9000 rw-p 00000000 00:00 0 =

  7f664e8f9000-7f664e8fa000 ---p 00000000 00:00 0 =

  7f664e8fa000-7f664e9fa000 rw-p 00000000 00:00 0 =

  7f664e9fa000-7f664e9fb000 ---p 00000000 00:00 0 =

  7f664e9fb000-7f664eafb000 rw-p 00000000 00:00 0 =

  7f664eafb000-7f664eafc000 ---p 00000000 00:00 0 =

  7f664eafc000-7f664ebfc000 rw-p 00000000 00:00 0 =

  7f664ebfc000-7f664ebfd000 ---p 00000000 00:00 0 =

  7f664ebfd000-7f664ecfd000 rw-p 00000000 00:00 0 =

  7f664ecfd000-7f664ecfe000 ---p 00000000 00:00 0 =

  7f664ecfe000-7f664edfe000 rw-p 00000000 00:00 0 =

  7f664edfe000-7f664edff000 ---p 00000000 00:00 0 =

  7f664edff000-7f664eeff000 rw-p 00000000 00:00 0 =

  7f664eeff000-7f664ef00000 ---p 00000000 00:00 0 =

  7f664ef00000-7f664f000000 rw-p 00000000 00:00 0 =

  7f664f6fe000-7f664f6ff000 ---p 00000000 00:00 0 =

  7f664f6ff000-7f664f7ff000 rw-p 00000000 00:00 0 =

  7f664f7ff000-7f664f800000 ---p 00000000 00:00 0 =

  7f664f800000-7f6650000000 rw-p 00000000 00:00 0 =

  7f6650000000-7f6650022000 rw-p 00000000 00:00 0 =

  7f6650022000-7f6654000000 ---p 00000000 00:00 0 =

  7f66540f5000-7f66540f6000 ---p 00000000 00:00 0 =

  7f66540f6000-7f66541f6000 rw-p 00000000 00:00 0 =

  7f66541f6000-7f66541f7000 ---p 00000000 00:00 0 =

  7f66541f7000-7f66542f7000 rw-p 00000000 00:00 0 =

  7f66542f7000-7f66542f8000 ---p 00000000 00:00 0 =

  7f66542f8000-7f66543f8000 rw-p 00000000 00:00 0 =

  7f66543f8000-7f66543f9000 ---p 00000000 00:00 0 =

  7f66543f9000-7f66544f9000 rw-p 00000000 00:00 0 =

  7f66544f9000-7f66544fa000 ---p 00000000 00:00 0 =

  7f66544fa000-7f66545fa000 rw-p 00000000 00:00 0 =

  7f66545fa000-7f66545fb000 ---p 00000000 00:00 0 =

  7f66545fb000-7f66546fb000 rw-p 00000000 00:00 0 =

  7f66546fb000-7f66546fc000 ---p 00000000 00:00 0 =

  7f66546fc000-7f66547fc000 rw-p 00000000 00:00 0 =

  7f66547fc000-7f66547fd000 ---p 00000000 00:00 0 =

  7f66547fd000-7f66548fd000 rw-p 00000000 00:00 0 =

  7f66548fd000-7f66548fe000 ---p 00000000 00:00 0 =

  7f66548fe000-7f66549fe000 rw-p 00000000 00:00 0 =

  7f66549fe000-7f66549ff000 ---p 00000000 00:00 0 =

  7f66549ff000-7f6654aff000 rw-p 00000000 00:00 0 =

  7f6654aff000-7f6654b00000 ---p 00000000 00:00 0 =

  7f6654b00000-7f6654c00000 rw-p 00000000 00:00 0 =

  7f6654c00000-7f6654c01000 rw-p 00000000 00:00 0 =

  7f6654c01000-7f6654c02000 ---p 00000000 00:00 0 =

  7f6654cff000-7f6654d00000 ---p 00000000 00:00 0 =

  7f6654d00000-7f6654e00000 rw-p 00000000 00:00 0 =

  7f6654e00000-7f6654e01000 rw-p 00000000 00:00 0 =

  7f6654e01000-7f6654e02000 ---p 00000000 00:00 0 =

  7f6654eff000-7f6654f00000 ---p 00000000 00:00 0 =

  7f6654f00000-7f6655000000 rw-p 00000000 00:00 0 =

  7f6655000000-7f6655200000 rw-p 00000000 00:00 0 =

  7f6655200000-7f6655201000 ---p 00000000 00:00 0 =

  7f665523b000-7f6656af1000 r-xp 00000000 103:02 2233416                   =
/usr/lib/x86_64-linux-gnu/libicudata.so.55.1
  7f6656af1000-7f6656cf0000 ---p 018b6000 103:02 2233416                   =
/usr/lib/x86_64-linux-gnu/libicudata.so.55.1
  7f6656cf0000-7f6656cf1000 r--p 018b5000 103:02 2233416                   =
/usr/lib/x86_64-linux-gnu/libicudata.so.55.1
  7f6656cf1000-7f6656cf2000 rw-p 018b6000 103:02 2233416                   =
/usr/lib/x86_64-linux-gnu/libicudata.so.55.1
  7f6656cf2000-7f6656e71000 r-xp 00000000 103:02 2233420                   =
/usr/lib/x86_64-linux-gnu/libicuuc.so.55.1
  7f6656e71000-7f6657071000 ---p 0017f000 103:02 2233420                   =
/usr/lib/x86_64-linux-gnu/libicuuc.so.55.1
  7f6657071000-7f6657081000 r--p 0017f000 103:02 2233420                   =
/usr/lib/x86_64-linux-gnu/libicuuc.so.55.1
  7f6657081000-7f6657082000 rw-p 0018f000 103:02 2233420                   =
/usr/lib/x86_64-linux-gnu/libicuuc.so.55.1
  7f6657082000-7f6657086000 rw-p 00000000 00:00 0 =

  7f6657086000-7f6657237000 r-xp 00000000 103:02 2237922                   =
/usr/lib/x86_64-linux-gnu/libxml2.so.2.9.3
  7f6657237000-7f6657436000 ---p 001b1000 103:02 2237922                   =
/usr/lib/x86_64-linux-gnu/libxml2.so.2.9.3
  7f6657436000-7f665743e000 r--p 001b0000 103:02 2237922                   =
/usr/lib/x86_64-linux-gnu/libxml2.so.2.9.3
  7f665743e000-7f6657440000 rw-p 001b8000 103:02 2237922                   =
/usr/lib/x86_64-linux-gnu/libxml2.so.2.9.3
  7f6657440000-7f6657441000 rw-p 00000000 00:00 0 =

  7f6657441000-7f6657e00000 r--p 00000000 103:02 2235565                   =
/usr/lib/locale/locale-archive
  7f6657e00000-7f66d7e00000 rw-p 00000000 00:00 0 =

  7f66d7e00000-7f66d7e01000 ---p 00000000 00:00 0 =

  7f66d7eff000-7f66d7f00000 ---p 00000000 00:00 0 =

  7f66d7f00000-7f66d8000000 rw-p 00000000 00:00 0 =

  7f66d8000000-7f66d8b29000 rw-p 00000000 00:00 0 =

  7f66d8b29000-7f66dc000000 ---p 00000000 00:00 0 =

  7f66dc000000-7f66dc022000 rw-p 00000000 00:00 0 =

  7f66dc022000-7f66e0000000 ---p 00000000 00:00 0 =

  7f66e008a000-7f66e008b000 ---p 00000000 00:00 0 =

  7f66e008b000-7f66e018b000 rw-p 00000000 00:00 0 =

  7f66e018b000-7f66e01c2000 r-xp 00000000 103:02 2236734                   =
/usr/lib/x86_64-linux-gnu/libcroco-0.6.so.3.0.1
  7f66e01c2000-7f66e03c2000 ---p 00037000 103:02 2236734                   =
/usr/lib/x86_64-linux-gnu/libcroco-0.6.so.3.0.1
  7f66e03c2000-7f66e03c5000 r--p 00037000 103:02 2236734                   =
/usr/lib/x86_64-linux-gnu/libcroco-0.6.so.3.0.1
  7f66e03c5000-7f66e03c6000 rw-p 0003a000 103:02 2236734                   =
/usr/lib/x86_64-linux-gnu/libcroco-0.6.so.3.0.1
  7f66e03c6000-7f66e03fb000 r-xp 00000000 103:02 2237572                   =
/usr/lib/x86_64-linux-gnu/librsvg-2.so.2.40.13
  7f66e03fb000-7f66e05fb000 ---p 00035000 103:02 2237572                   =
/usr/lib/x86_64-linux-gnu/librsvg-2.so.2.40.13
  7f66e05fb000-7f66e05fc000 r--p 00035000 103:02 2237572                   =
/usr/lib/x86_64-linux-gnu/librsvg-2.so.2.40.13
  7f66e05fc000-7f66e05fd000 rw-p 00036000 103:02 2237572                   =
/usr/lib/x86_64-linux-gnu/librsvg-2.so.2.40.13
  7f66e05fd000-7f66e05ff000 r-xp 00000000 103:02 2493292                   =
/usr/lib/x86_64-linux-gnu/gdk-pixbuf-2.0/2.10.0/loaders/libpixbufloader-svg=
.so
  7f66e05ff000-7f66e07fe000 ---p 00002000 103:02 2493292                   =
/usr/lib/x86_64-linux-gnu/gdk-pixbuf-2.0/2.10.0/loaders/libpixbufloader-svg=
.so
  7f66e07fe000-7f66e07ff000 r--p 00001000 103:02 2493292                   =
/usr/lib/x86_64-linux-gnu/gdk-pixbuf-2.0/2.10.0/loaders/libpixbufloader-svg=
.so
  7f66e07ff000-7f66e0800000 rw-p 00002000 103:02 2493292                   =
/usr/lib/x86_64-linux-gnu/gdk-pixbuf-2.0/2.10.0/loaders/libpixbufloader-svg=
.so
  7f66e0800000-7f66e0840000 rw-p 00000000 00:00 0 =

  7f66e0840000-7f66e0841000 ---p 00000000 00:00 0 =

  7f66e08ff000-7f66e0900000 ---p 00000000 00:00 0 =

  7f66e0900000-7f66e0a00000 rw-p 00000000 00:00 0 =

  7f66e0a00000-7f66e0a10000 rw-p 00000000 00:00 0 =

  7f66e0a10000-7f66e0a11000 ---p 00000000 00:00 0 =

  7f66e0aff000-7f66e0b00000 ---p 00000000 00:00 0 =

  7f66e0b00000-7f66e0c00000 rw-p 00000000 00:00 0 =

  7f66e0c00000-7f66e1c00000 rw-p 00000000 00:00 0 =

  7f66e1c00000-7f66e1c01000 ---p 00000000 00:00 0 =

  7f66e1cff000-7f66e1d00000 ---p 00000000 00:00 0 =

  7f66e1d00000-7f66e1e00000 rw-p 00000000 00:00 0 =

  7f66e1e00000-7f66e1e20000 rw-p 00000000 00:00 0 =

  7f66e1e20000-7f66e1e21000 ---p 00000000 00:00 0 =

  7f66e1e5c000-7f66e1eb3000 r--p 00000000 103:02 3277771                   =
/usr/share/fonts/truetype/ubuntu-font-family/Ubuntu-R.ttf
  7f66e1eb3000-7f66e1ebe000 r--s 00000000 103:02 3019418                   =
/var/cache/fontconfig/945677eb7aeaf62f1d50efc3fb3ec7d8-le64.cache-6
  7f66e1ebe000-7f66e1ed3000 r--s 00000000 103:02 3019394                   =
/var/cache/fontconfig/04aabc0a78ac019cf9454389977116d2-le64.cache-6
  7f66e1eff000-7f66e1f00000 ---p 00000000 00:00 0 =

  7f66e1f00000-7f66e2000000 rw-p 00000000 00:00 0 =

  7f66e2000000-7f66e2040000 rw-p 00000000 00:00 0 =

  7f66e2040000-7f66e2041000 ---p 00000000 00:00 0 =

  7f66e204a000-7f66e204b000 rw-p 00000000 00:00 0 =

  7f66e204b000-7f66e2051000 r--s 00000000 103:02 3019400                   =
/var/cache/fontconfig/2cd17615ca594fa2959ae173292e504c-le64.cache-6
  7f66e2051000-7f66e2052000 r--s 00000000 103:02 3019397                   =
/var/cache/fontconfig/0d8c3b2ac0904cb8a57a757ad11a4a08-le64.cache-6
  7f66e2052000-7f66e2053000 r--s 00000000 103:02 3019399                   =
/var/cache/fontconfig/1ac9eb803944fde146138c791f5cc56a-le64.cache-6
  7f66e2053000-7f66e2057000 r--s 00000000 103:02 3019404                   =
/var/cache/fontconfig/385c0604a188198f04d133e54aba7fe7-le64.cache-6
  7f66e2057000-7f66e2058000 r--s 00000000 103:02 3019431                   =
/var/cache/fontconfig/dc05db6664285cc2f12bf69c139ae4c3-le64.cache-6
  7f66e2058000-7f66e205b000 r--s 00000000 103:02 3019414                   =
/var/cache/fontconfig/767a8244fc0220cfb567a839d0392e0b-le64.cache-6
  7f66e205b000-7f66e2060000 r--s 00000000 103:02 3019417                   =
/var/cache/fontconfig/8801497958630a81b71ace7c5f9b32a8-le64.cache-6
  7f66e2060000-7f66e2067000 r--s 00000000 103:02 3019401                   =
/var/cache/fontconfig/3047814df9a2f067bd2d96a2b9c36e5a-le64.cache-6
  7f66e2067000-7f66e206d000 r--s 00000000 103:02 3019422                   =
/var/cache/fontconfig/b47c4e1ecd0709278f4910c18777a504-le64.cache-6
  7f66e206d000-7f66e2080000 r--s 00000000 103:02 3019428                   =
/var/cache/fontconfig/d52a8644073d54c13679302ca1180695-le64.cache-6
  7f66e2080000-7f66e208b000 r--s 00000000 103:02 3019416                   =
/var/cache/fontconfig/83bf95040141907cd45bb53cf7c1c148-le64.cache-6
  7f66e208b000-7f66e209d000 r--s 00000000 103:02 3019420                   =
/var/cache/fontconfig/9b89f8e3dae116d678bbf48e5f21f69b-le64.cache-6
  7f66e209d000-7f66e20bc000 r--s 00000000 103:02 2752558                   =
/usr/share/mime/mime.cache
  7f66e20bc000-7f66e20bd000 ---p 00000000 00:00 0 =

  7f66e20bd000-7f66e21bd000 rw-p 00000000 00:00 0 =

  7f66e21bd000-7f66e21be000 ---p 00000000 00:00 0 =

  7f66e21be000-7f66e2ca2000 rw-p 00000000 00:00 0 =

  7f66e2ca2000-7f66e2ca3000 ---p 00000000 00:00 0 =

  7f66e2ca3000-7f66e2da3000 rw-p 00000000 00:00 0 =

  7f66e2da3000-7f66e2da4000 ---p 00000000 00:00 0 =

  7f66e2da4000-7f66e35a4000 rw-p 00000000 00:00 0 =

  7f66e35a4000-7f66e35ab000 r-xp 00000000 103:02 2237425                   =
/usr/lib/x86_64-linux-gnu/libogg.so.0.8.2
  7f66e35ab000-7f66e37ab000 ---p 00007000 103:02 2237425                   =
/usr/lib/x86_64-linux-gnu/libogg.so.0.8.2
  7f66e37ab000-7f66e37ac000 r--p 00007000 103:02 2237425                   =
/usr/lib/x86_64-linux-gnu/libogg.so.0.8.2
  7f66e37ac000-7f66e37ad000 rw-p 00008000 103:02 2237425                   =
/usr/lib/x86_64-linux-gnu/libogg.so.0.8.2
  7f66e37ad000-7f66e37d7000 r-xp 00000000 103:02 2233113                   =
/usr/lib/x86_64-linux-gnu/libvorbis.so.0.4.8
  7f66e37d7000-7f66e39d6000 ---p 0002a000 103:02 2233113                   =
/usr/lib/x86_64-linux-gnu/libvorbis.so.0.4.8
  7f66e39d6000-7f66e39d7000 r--p 00029000 103:02 2233113                   =
/usr/lib/x86_64-linux-gnu/libvorbis.so.0.4.8
  7f66e39d7000-7f66e39d8000 rw-p 0002a000 103:02 2233113                   =
/usr/lib/x86_64-linux-gnu/libvorbis.so.0.4.8
  7f66e39d8000-7f66e39e1000 r-xp 00000000 103:02 2237286                   =
/usr/lib/x86_64-linux-gnu/libltdl.so.7.3.1
  7f66e39e1000-7f66e3be0000 ---p 00009000 103:02 2237286                   =
/usr/lib/x86_64-linux-gnu/libltdl.so.7.3.1
  7f66e3be0000-7f66e3be1000 r--p 00008000 103:02 2237286                   =
/usr/lib/x86_64-linux-gnu/libltdl.so.7.3.1
  7f66e3be1000-7f66e3be2000 rw-p 00009000 103:02 2237286                   =
/usr/lib/x86_64-linux-gnu/libltdl.so.7.3.1
  7f66e3be2000-7f66e3bf6000 r-xp 00000000 103:02 2237676                   =
/usr/lib/x86_64-linux-gnu/libtdb.so.1.3.8Aborted (core dumped)

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1785670/+subscriptions
