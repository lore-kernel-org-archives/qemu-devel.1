Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 330F5C00A89
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 02:37:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A00D22226
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 02:37:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A00D22226
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60388 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZmCE-0006pf-Ga
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 21:37:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45248)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kZmAc-0005Vu-E4
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 21:35:38 -0500
Received: from indium.canonical.com ([91.189.90.7]:37510)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kZmAY-0006hb-5J
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 21:35:38 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1kZmAU-0006UV-Py
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2020 02:35:30 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id C345F2E8074
 for <qemu-devel@nongnu.org>; Tue,  3 Nov 2020 02:35:30 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2020 02:30:10 -0000
From: Gaoning Pan <1902612@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided;
 assignee=pgn@zju.edu.cn; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: hades0506
X-Launchpad-Bug-Reporter: Gaoning Pan (hades0506)
X-Launchpad-Bug-Modifier: Gaoning Pan (hades0506)
Message-Id: <160437061077.30125.12787178418002366746.malonedeb@gac.canonical.com>
Subject: [Bug 1902612] [NEW] assert issue locates in xhci_kick_epctx() in
 hw/usb/hcd-xhci.c
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="96ff31b88b65a0d0ea73b89333fe7c4a2669d8fb"; Instance="production"
X-Launchpad-Hash: d69c854b56c4051456d6c5e8d3635c8cc23cf911
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/02 21:05:34
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
Reply-To: Bug 1902612 <1902612@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Public bug reported:

Hello,

I found an assertion failure through hw/usb/hcd-xhci.c.

This was found in latest version 5.1.0.

An assertion-failure flaw was found in xhci_kick_epctx() in  hw/usb/hcd-
xhci.c .  XHCI  slot's endpoint context is enabled in
xhci_configure_slot(), whose ep_ctx structure is controlled by user.
With uninitialized endPoint context  could trigger assert(ring->dequeue
!=3D 0).    The guest system could use this flaw to crash the qemu
resulting in denial of service.

To reproduce the assertion failure, please run the QEMU with following
command line.

$ qemu-system-x86_64 -enable-kvm -boot c -m 2G -drive
format=3Dqcow2,file=3D./ubuntu.img -nic
user,model=3Drtl8139,hostfwd=3Dtcp:0.0.0.0:5555-:22 -device nec-usb-
xhci,id=3Dxhci -device usb-tablet,bus=3Dxhci.0,port=3D1,id=3Dusbdev1

The poc is attached.

Backtrace is as follows:
#0  0x00007f6dfd4c4f47 in __GI_raise (sig=3Dsig@entry=3D0x6) at ../sysdeps/=
unix/sysv/linux/raise.c:51
#1  0x00007f6dfd4c68b1 in __GI_abort () at abort.c:79
#2  0x00007f6dfd4b642a in __assert_fail_base (fmt=3D0x7f6dfd63da38 "%s%s%s:=
%u: %s%sAssertion `%s' failed.\n%n", assertion=3Dassertion@entry=3D0x55e9b9=
d38a64 "ring->dequeue !=3D 0", file=3Dfile@entry=3D0x55e9b9d388c0 "hw/usb/h=
cd-xhci.c", line=3Dline@entry=3D0x7a3, function=3Dfunction@entry=3D0x55e9b9=
d3a5c0 <__PRETTY_FUNCTION__.29754> "xhci_kick_epctx") at assert.c:92
#3  0x00007f6dfd4b64a2 in __GI___assert_fail (assertion=3Dassertion@entry=
=3D0x55e9b9d38a64 "ring->dequeue !=3D 0", file=3Dfile@entry=3D0x55e9b9d388c=
0 "hw/usb/hcd-xhci.c", line=3Dline@entry=3D0x7a3, function=3Dfunction@entry=
=3D0x55e9b9d3a5c0 <__PRETTY_FUNCTION__.29754> "xhci_kick_epctx") at assert.=
c:101
#4  0x000055e9b9a3292f in xhci_kick_epctx (epctx=3D0x7f6da836b510, streamid=
=3Dstreamid@entry=3D0x0) at hw/usb/hcd-xhci.c:1955
#5  0x000055e9b9a3c64b in xhci_kick_ep (streamid=3D0x0, epid=3D0x1, slotid=
=3D0x11, xhci=3D0x7f6df8b38010) at hw/usb/hcd-xhci.c:1861
#6  0x000055e9b9a3c64b in xhci_doorbell_write (ptr=3D0x7f6df8b38010, reg=3D=
0x11, val=3D0x1, size=3D<optimized out>) at hw/usb/hcd-xhci.c:3162
#7  0x000055e9b977d274 in memory_region_write_accessor (mr=3D0x7f6df8b38d80=
, addr=3D0x44, value=3D<optimized out>, size=3D0x1, shift=3D<optimized out>=
, mask=3D<optimized out>, attrs=3D...) at /home/zjusvn/qemu5-hypervisor/qem=
u-5.0.0/memory.c:483
#8  0x000055e9b977ad86 in access_with_adjusted_size (addr=3Daddr@entry=3D0x=
44, value=3Dvalue@entry=3D0x7f6dfb915f88, size=3Dsize@entry=3D0x1, access_s=
ize_min=3D<optimized out>, access_size_max=3D<optimized out>, access_fn=3D0=
x55e9b977d1f0 <memory_region_write_accessor>, mr=3D0x7f6df8b38d80, attrs=3D=
...) at /home/zjusvn/qemu5-hypervisor/qemu-5.0.0/memory.c:544
#9  0x000055e9b977f4c8 in memory_region_dispatch_write (mr=3Dmr@entry=3D0x7=
f6df8b38d80, addr=3D0x44, data=3D<optimized out>, op=3D<optimized out>, att=
rs=3Dattrs@entry=3D...) at /home/zjusvn/qemu5-hypervisor/qemu-5.0.0/memory.=
c:1483
#10 0x000055e9b972c691 in flatview_write_continue (fv=3Dfv@entry=3D0x7f6da9=
51f750, addr=3Daddr@entry=3D0xfebf2044, attrs=3D..., ptr=3Dptr@entry=3D0x7f=
6dfb9160e0, len=3Dlen@entry=3D0x1, addr1=3D<optimized out>, l=3D<optimized =
out>, mr=3D0x7f6df8b38d80) at /home/zjusvn/qemu5-hypervisor/qemu-5.0.0/exec=
.c:3137
#11 0x000055e9b972c826 in flatview_write (fv=3D0x7f6da951f750, addr=3D0xfeb=
f2044, attrs=3D..., buf=3Dbuf@entry=3D0x7f6dfb9160e0, len=3D0x1) at /home/z=
jusvn/qemu5-hypervisor/qemu-5.0.0/exec.c:3177
#12 0x000055e9b972c89a in subpage_write (opaque=3D<optimized out>, addr=3D<=
optimized out>, value=3D<optimized out>, len=3D<optimized out>, attrs=3D...=
) at /home/zjusvn/qemu5-hypervisor/qemu-5.0.0/exec.c:2789
#13 0x000055e9b977b269 in memory_region_write_with_attrs_accessor (mr=3D0x7=
f6da9534650, addr=3D0x44, value=3D<optimized out>, size=3D0x1, shift=3D<opt=
imized out>, mask=3D<optimized out>, attrs=3D...) at /home/zjusvn/qemu5-hyp=
ervisor/qemu-5.0.0/memory.c:503
#14 0x000055e9b977ad86 in access_with_adjusted_size (addr=3Daddr@entry=3D0x=
44, value=3Dvalue@entry=3D0x7f6dfb9161f8, size=3Dsize@entry=3D0x1, access_s=
ize_min=3D<optimized out>, access_size_max=3D<optimized out>, access_fn=3D0=
x55e9b977b1e0 <memory_region_write_with_attrs_accessor>, mr=3D0x7f6da953465=
0, attrs=3D...) at /home/zjusvn/qemu5-hypervisor/qemu-5.0.0/memory.c:544
#15 0x000055e9b977f4c8 in memory_region_dispatch_write (mr=3D0x7f6da9534650=
, addr=3Daddr@entry=3D0x44, data=3D<optimized out>, data@entry=3D0x1, op=3D=
op@entry=3DMO_8, attrs=3D...) at /home/zjusvn/qemu5-hypervisor/qemu-5.0.0/m=
emory.c:1483
#16 0x000055e9b979021f in io_writex (env=3Denv@entry=3D0x55e9baed5b50, iotl=
bentry=3Diotlbentry@entry=3D0x7f6da8b8bc10, mmu_idx=3Dmmu_idx@entry=3D0x1, =
val=3Dval@entry=3D0x1, addr=3Daddr@entry=3D0x7fbba0601044, retaddr=3Dretadd=
r@entry=3D0x7f6db9d90d48, op=3DMO_8) at /home/zjusvn/qemu5-hypervisor/qemu-=
5.0.0/accel/tcg/cputlb.c:1084
#17 0x000055e9b9794c42 in store_helper (op=3DMO_8, retaddr=3D0x7f6db9d90d48=
, oi=3D<optimized out>, val=3D<optimized out>, addr=3D0x7fbba0601044, env=
=3D0x55e9baed5b50) at /home/zjusvn/qemu5-hypervisor/qemu-5.0.0/accel/tcg/cp=
utlb.c:1954
#18 0x000055e9b9794c42 in helper_ret_stb_mmu (env=3D0x55e9baed5b50, addr=3D=
0x7fbba0601044, val=3D0x1, oi=3D<optimized out>, retaddr=3D0x7f6db9d90d48) =
at /home/zjusvn/qemu5-hypervisor/qemu-5.0.0/accel/tcg/cputlb.c:2056
#19 0x00007f6db9d90d48 in code_gen_buffer ()
#20 0x000055e9b97a5217 in cpu_tb_exec (itb=3D<optimized out>, cpu=3D0x7f6db=
9d240c0 <code_gen_buffer+97665171>) at /home/zjusvn/qemu5-hypervisor/qemu-5=
.0.0/accel/tcg/cpu-exec.c:172
#21 0x000055e9b97a5217 in cpu_loop_exec_tb (tb_exit=3D<synthetic pointer>, =
last_tb=3D<synthetic pointer>, tb=3D<optimized out>, cpu=3D0x7f6db9d240c0 <=
code_gen_buffer+97665171>) at /home/zjusvn/qemu5-hypervisor/qemu-5.0.0/acce=
l/tcg/cpu-exec.c:619
#22 0x000055e9b97a5217 in cpu_exec (cpu=3Dcpu@entry=3D0x55e9baecd2f0) at /h=
ome/zjusvn/qemu5-hypervisor/qemu-5.0.0/accel/tcg/cpu-exec.c:732
#23 0x000055e9b976ff9f in tcg_cpu_exec (cpu=3D0x55e9baecd2f0) at /home/zjus=
vn/qemu5-hypervisor/qemu-5.0.0/cpus.c:1405
#24 0x000055e9b97723cb in qemu_tcg_cpu_thread_fn (arg=3Darg@entry=3D0x55e9b=
aecd2f0) at /home/zjusvn/qemu5-hypervisor/qemu-5.0.0/cpus.c:1713
#25 0x000055e9b9be7d66 in qemu_thread_start (args=3D<optimized out>) at uti=
l/qemu-thread-posix.c:519
#26 0x00007f6dfd87e6db in start_thread (arg=3D0x7f6dfb917700) at pthread_cr=
eate.c:463
#27 0x00007f6dfd5a7a3f in clone () at ../sysdeps/unix/sysv/linux/x86_64/clo=
ne.S:95

** Affects: qemu
     Importance: Undecided
     Assignee: Gaoning Pan (hades0506)
         Status: New

** Attachment added: "poc.zip"
   https://bugs.launchpad.net/bugs/1902612/+attachment/5430475/+files/poc.z=
ip

** Changed in: qemu
     Assignee: (unassigned) =3D> Gaoning Pan (hades0506)

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1902612

Title:
  assert issue locates in xhci_kick_epctx() in  hw/usb/hcd-xhci.c

Status in QEMU:
  New

Bug description:
  Hello,

  I found an assertion failure through hw/usb/hcd-xhci.c.

  This was found in latest version 5.1.0.

  An assertion-failure flaw was found in xhci_kick_epctx() in  hw/usb
  /hcd-xhci.c .  XHCI  slot's endpoint context is enabled in
  xhci_configure_slot(), whose ep_ctx structure is controlled by user.
  With uninitialized endPoint context  could trigger
  assert(ring->dequeue !=3D 0).    The guest system could use this flaw to
  crash the qemu resulting in denial of service.

  To reproduce the assertion failure, please run the QEMU with following
  command line.

  $ qemu-system-x86_64 -enable-kvm -boot c -m 2G -drive
  format=3Dqcow2,file=3D./ubuntu.img -nic
  user,model=3Drtl8139,hostfwd=3Dtcp:0.0.0.0:5555-:22 -device nec-usb-
  xhci,id=3Dxhci -device usb-tablet,bus=3Dxhci.0,port=3D1,id=3Dusbdev1

  The poc is attached.

  Backtrace is as follows:
  #0  0x00007f6dfd4c4f47 in __GI_raise (sig=3Dsig@entry=3D0x6) at ../sysdep=
s/unix/sysv/linux/raise.c:51
  #1  0x00007f6dfd4c68b1 in __GI_abort () at abort.c:79
  #2  0x00007f6dfd4b642a in __assert_fail_base (fmt=3D0x7f6dfd63da38 "%s%s%=
s:%u: %s%sAssertion `%s' failed.\n%n", assertion=3Dassertion@entry=3D0x55e9=
b9d38a64 "ring->dequeue !=3D 0", file=3Dfile@entry=3D0x55e9b9d388c0 "hw/usb=
/hcd-xhci.c", line=3Dline@entry=3D0x7a3, function=3Dfunction@entry=3D0x55e9=
b9d3a5c0 <__PRETTY_FUNCTION__.29754> "xhci_kick_epctx") at assert.c:92
  #3  0x00007f6dfd4b64a2 in __GI___assert_fail (assertion=3Dassertion@entry=
=3D0x55e9b9d38a64 "ring->dequeue !=3D 0", file=3Dfile@entry=3D0x55e9b9d388c=
0 "hw/usb/hcd-xhci.c", line=3Dline@entry=3D0x7a3, function=3Dfunction@entry=
=3D0x55e9b9d3a5c0 <__PRETTY_FUNCTION__.29754> "xhci_kick_epctx") at assert.=
c:101
  #4  0x000055e9b9a3292f in xhci_kick_epctx (epctx=3D0x7f6da836b510, stream=
id=3Dstreamid@entry=3D0x0) at hw/usb/hcd-xhci.c:1955
  #5  0x000055e9b9a3c64b in xhci_kick_ep (streamid=3D0x0, epid=3D0x1, sloti=
d=3D0x11, xhci=3D0x7f6df8b38010) at hw/usb/hcd-xhci.c:1861
  #6  0x000055e9b9a3c64b in xhci_doorbell_write (ptr=3D0x7f6df8b38010, reg=
=3D0x11, val=3D0x1, size=3D<optimized out>) at hw/usb/hcd-xhci.c:3162
  #7  0x000055e9b977d274 in memory_region_write_accessor (mr=3D0x7f6df8b38d=
80, addr=3D0x44, value=3D<optimized out>, size=3D0x1, shift=3D<optimized ou=
t>, mask=3D<optimized out>, attrs=3D...) at /home/zjusvn/qemu5-hypervisor/q=
emu-5.0.0/memory.c:483
  #8  0x000055e9b977ad86 in access_with_adjusted_size (addr=3Daddr@entry=3D=
0x44, value=3Dvalue@entry=3D0x7f6dfb915f88, size=3Dsize@entry=3D0x1, access=
_size_min=3D<optimized out>, access_size_max=3D<optimized out>, access_fn=
=3D0x55e9b977d1f0 <memory_region_write_accessor>, mr=3D0x7f6df8b38d80, attr=
s=3D...) at /home/zjusvn/qemu5-hypervisor/qemu-5.0.0/memory.c:544
  #9  0x000055e9b977f4c8 in memory_region_dispatch_write (mr=3Dmr@entry=3D0=
x7f6df8b38d80, addr=3D0x44, data=3D<optimized out>, op=3D<optimized out>, a=
ttrs=3Dattrs@entry=3D...) at /home/zjusvn/qemu5-hypervisor/qemu-5.0.0/memor=
y.c:1483
  #10 0x000055e9b972c691 in flatview_write_continue (fv=3Dfv@entry=3D0x7f6d=
a951f750, addr=3Daddr@entry=3D0xfebf2044, attrs=3D..., ptr=3Dptr@entry=3D0x=
7f6dfb9160e0, len=3Dlen@entry=3D0x1, addr1=3D<optimized out>, l=3D<optimize=
d out>, mr=3D0x7f6df8b38d80) at /home/zjusvn/qemu5-hypervisor/qemu-5.0.0/ex=
ec.c:3137
  #11 0x000055e9b972c826 in flatview_write (fv=3D0x7f6da951f750, addr=3D0xf=
ebf2044, attrs=3D..., buf=3Dbuf@entry=3D0x7f6dfb9160e0, len=3D0x1) at /home=
/zjusvn/qemu5-hypervisor/qemu-5.0.0/exec.c:3177
  #12 0x000055e9b972c89a in subpage_write (opaque=3D<optimized out>, addr=
=3D<optimized out>, value=3D<optimized out>, len=3D<optimized out>, attrs=
=3D...) at /home/zjusvn/qemu5-hypervisor/qemu-5.0.0/exec.c:2789
  #13 0x000055e9b977b269 in memory_region_write_with_attrs_accessor (mr=3D0=
x7f6da9534650, addr=3D0x44, value=3D<optimized out>, size=3D0x1, shift=3D<o=
ptimized out>, mask=3D<optimized out>, attrs=3D...) at /home/zjusvn/qemu5-h=
ypervisor/qemu-5.0.0/memory.c:503
  #14 0x000055e9b977ad86 in access_with_adjusted_size (addr=3Daddr@entry=3D=
0x44, value=3Dvalue@entry=3D0x7f6dfb9161f8, size=3Dsize@entry=3D0x1, access=
_size_min=3D<optimized out>, access_size_max=3D<optimized out>, access_fn=
=3D0x55e9b977b1e0 <memory_region_write_with_attrs_accessor>, mr=3D0x7f6da95=
34650, attrs=3D...) at /home/zjusvn/qemu5-hypervisor/qemu-5.0.0/memory.c:544
  #15 0x000055e9b977f4c8 in memory_region_dispatch_write (mr=3D0x7f6da95346=
50, addr=3Daddr@entry=3D0x44, data=3D<optimized out>, data@entry=3D0x1, op=
=3Dop@entry=3DMO_8, attrs=3D...) at /home/zjusvn/qemu5-hypervisor/qemu-5.0.=
0/memory.c:1483
  #16 0x000055e9b979021f in io_writex (env=3Denv@entry=3D0x55e9baed5b50, io=
tlbentry=3Diotlbentry@entry=3D0x7f6da8b8bc10, mmu_idx=3Dmmu_idx@entry=3D0x1=
, val=3Dval@entry=3D0x1, addr=3Daddr@entry=3D0x7fbba0601044, retaddr=3Dreta=
ddr@entry=3D0x7f6db9d90d48, op=3DMO_8) at /home/zjusvn/qemu5-hypervisor/qem=
u-5.0.0/accel/tcg/cputlb.c:1084
  #17 0x000055e9b9794c42 in store_helper (op=3DMO_8, retaddr=3D0x7f6db9d90d=
48, oi=3D<optimized out>, val=3D<optimized out>, addr=3D0x7fbba0601044, env=
=3D0x55e9baed5b50) at /home/zjusvn/qemu5-hypervisor/qemu-5.0.0/accel/tcg/cp=
utlb.c:1954
  #18 0x000055e9b9794c42 in helper_ret_stb_mmu (env=3D0x55e9baed5b50, addr=
=3D0x7fbba0601044, val=3D0x1, oi=3D<optimized out>, retaddr=3D0x7f6db9d90d4=
8) at /home/zjusvn/qemu5-hypervisor/qemu-5.0.0/accel/tcg/cputlb.c:2056
  #19 0x00007f6db9d90d48 in code_gen_buffer ()
  #20 0x000055e9b97a5217 in cpu_tb_exec (itb=3D<optimized out>, cpu=3D0x7f6=
db9d240c0 <code_gen_buffer+97665171>) at /home/zjusvn/qemu5-hypervisor/qemu=
-5.0.0/accel/tcg/cpu-exec.c:172
  #21 0x000055e9b97a5217 in cpu_loop_exec_tb (tb_exit=3D<synthetic pointer>=
, last_tb=3D<synthetic pointer>, tb=3D<optimized out>, cpu=3D0x7f6db9d240c0=
 <code_gen_buffer+97665171>) at /home/zjusvn/qemu5-hypervisor/qemu-5.0.0/ac=
cel/tcg/cpu-exec.c:619
  #22 0x000055e9b97a5217 in cpu_exec (cpu=3Dcpu@entry=3D0x55e9baecd2f0) at =
/home/zjusvn/qemu5-hypervisor/qemu-5.0.0/accel/tcg/cpu-exec.c:732
  #23 0x000055e9b976ff9f in tcg_cpu_exec (cpu=3D0x55e9baecd2f0) at /home/zj=
usvn/qemu5-hypervisor/qemu-5.0.0/cpus.c:1405
  #24 0x000055e9b97723cb in qemu_tcg_cpu_thread_fn (arg=3Darg@entry=3D0x55e=
9baecd2f0) at /home/zjusvn/qemu5-hypervisor/qemu-5.0.0/cpus.c:1713
  #25 0x000055e9b9be7d66 in qemu_thread_start (args=3D<optimized out>) at u=
til/qemu-thread-posix.c:519
  #26 0x00007f6dfd87e6db in start_thread (arg=3D0x7f6dfb917700) at pthread_=
create.c:463
  #27 0x00007f6dfd5a7a3f in clone () at ../sysdeps/unix/sysv/linux/x86_64/c=
lone.S:95

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1902612/+subscriptions

