Return-Path: <SRS0=e5mL=UC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 699B9C04AB5
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 17:06:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3415B2722C
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 17:06:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3415B2722C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38204 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hXqQD-0005Yc-Ey
	for qemu-devel@archiver.kernel.org; Mon, 03 Jun 2019 13:06:57 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41404)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hXqP3-0004zi-T9
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 13:05:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hXqP1-0003dn-RA
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 13:05:45 -0400
Received: from indium.canonical.com ([91.189.90.7]:51474)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1hXqP0-0003QX-6G
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 13:05:43 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1hXqOv-0000Tb-II
	for <qemu-devel@nongnu.org>; Mon, 03 Jun 2019 17:05:37 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 870B52E80C7
	for <qemu-devel@nongnu.org>; Mon,  3 Jun 2019 17:05:37 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Jun 2019 16:53:31 -0000
From: Andrew Randrianasulu <1830872@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Tags: arm testcase
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: ajbennee andrew-randrianasulu lersek
X-Launchpad-Bug-Reporter: Laszlo Ersek (Red Hat) (lersek)
X-Launchpad-Bug-Modifier: Andrew Randrianasulu (andrew-randrianasulu)
References: <155912118291.12579.8926874795813611531.malonedeb@soybean.canonical.com>
	<155957710101.12370.12687211354500875831.malone@soybean.canonical.com>
Message-Id: <201906031953.31315.randrianasulu@gmail.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="18968";
	Instance="launchpad-lazr.conf"
X-Launchpad-Hash: d338ade7f84773847075bc39141482a3133c42a3
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: Re: [Qemu-devel] [Bug 1830872] Re: AARCH64 to ARMv7 mistranslation
 in TCG
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Bug 1830872 <1830872@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

=D0=92 =D1=81=D0=BE=D0=BE=D0=B1=D1=89=D0=B5=D0=BD=D0=B8=D0=B8 =D0=BE=D1=82 =
Monday 03 June 2019 18:51:40 Alex Benn=C3=A9e =D0=BD=D0=B0=D0=BF=D0=B8=D1=
=81=D0=B0=D0=BB(=D0=B0):
> I managed to tweak the memory test enough to detect the failure on
> aarch64-on-armv7 and I the attached patch fixes it. Could you please
> double check with your test case?
> =



Hm, I manually applied path from LP(git diff disliked copypasted patch), =

so for now git diff in qemu tree shows:

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index cdcc377102..b796ab1cbe 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1303,7 +1303,7 @@ load_helper(CPUArchState *env, target_ulong addr, TCG=
MemOpIdx oi,
         && unlikely((addr & ~TARGET_PAGE_MASK) + size - 1
                     >=3D TARGET_PAGE_SIZE)) {
         target_ulong addr1, addr2;
-        tcg_target_ulong r1, r2;
+        uint64_t r1, r2;
         unsigned shift;
     do_unaligned_access:
         addr1 =3D addr & ~(size - 1);
lines 1-13/13 (END)                          =


---------

but x86_64-softmmu/qemu-system-x86_64 -kernel /boot/bzImage-4.12.0-x64 -acc=
el tcg
still hangs at 'booting the kernel" (it decompress OK)

I make distclean'ed source tree and reconfigured it:
 ./configure --target-list=3Dx86_64-softmmu --disable-werror --enable-debug=
-tcg  --cross-cc-x86_64=3D"/opt/kgcc64/bin/x86_64-unknown-linux-gnu-gcc-6.5=
.0"

next, make -j 5 and test.

Hm.

I tried debug switches, it seems to hang a bit differently for two runs:

x86_64-softmmu/qemu-system-x86_64 -kernel /boot/bzImage-4.12.0-x64
-accel tcg -nographic -d in_asm,op,op_opt,op_ind,out_asm

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

IN:
0xffffffff810e8a63:  48 83 c3 64              addq     $0x64, %rbx
0xffffffff810e8a67:  eb c2                    jmp      0xffffffff810e8a2b

OP:
 ld_i32 tmp18,env,$0xfffffff0
 movi_i32 tmp19,$0x0
 brcond_i32 tmp18,tmp19,lt,$L0

 ---- ffffffff810e8a63 0000000000000000
 movi_i32 tmp2,$0x64
 movi_i32 tmp3,$0x0
 mov_i32 tmp0,rbx_0
 mov_i32 tmp1,rbx_1
 add2_i32 tmp0,tmp1,tmp0,tmp1,tmp2,tmp3
 mov_i32 rbx_0,tmp0
 mov_i32 rbx_1,tmp1
 mov_i32 cc_src_0,tmp2
 mov_i32 cc_src_1,tmp3
 mov_i32 cc_dst_0,tmp0
 mov_i32 cc_dst_1,tmp1
 discard cc_src2_0
 discard cc_src2_1
 discard cc_op

 ---- ffffffff810e8a67 0000000000000009
 movi_i32 cc_op,$0x9
 goto_tb $0x0
 movi_i32 tmp6,$0x810e8a2b
 movi_i32 tmp7,$0xffffffff
 st_i32 tmp6,env,$0x80
 st_i32 tmp7,env,$0x84
 exit_tb $0xf2f1c080
 set_label $L0
 exit_tb $0xf2f1c083

OP after optimization and liveness analysis:
 ld_i32 tmp18,env,$0xfffffff0             dead: 1  pref=3D0xff
 movi_i32 tmp19,$0x0                      pref=3D0xff
 brcond_i32 tmp18,tmp19,lt,$L0            dead: 0 1

 ---- ffffffff810e8a63 0000000000000000
 movi_i32 tmp2,$0x64                      pref=3D0xff
 movi_i32 tmp3,$0x0                       pref=3D0xff
 add2_i32 tmp0,tmp1,rbx_0,rbx_1,tmp2,tmp3  dead: 2 3  pref=3D0xff,0xff
 mov_i32 rbx_0,tmp0                       sync: 0  dead: 1  pref=3D0xff
 mov_i32 rbx_1,tmp1                       sync: 0  dead: 1  pref=3D0xff
 mov_i32 cc_src_0,tmp2                    sync: 0  dead: 0 1  pref=3D0xff
 mov_i32 cc_src_1,tmp3                    sync: 0  dead: 0 1  pref=3D0xff
 mov_i32 cc_dst_0,rbx_0                   sync: 0  dead: 0 1  pref=3D0xff
 mov_i32 cc_dst_1,rbx_1                   sync: 0  dead: 0 1  pref=3D0xff
 discard cc_src2_0                        pref=3D0xff
 discard cc_src2_1                        pref=3D0xff
 discard cc_op                            pref=3D0xff mov_i32 cc_dst_0,tmp0
 mov_i32 cc_dst_1,tmp1
 discard cc_src2_0
 discard cc_src2_1
 discard cc_op

 ---- ffffffff810e8a55 0000000000000021
 movi_i32 cc_op,$0x21
 movi_i32 tmp20,$0x0
 movi_i32 tmp21,$0x0
 brcond2_i32 cc_dst_0,cc_dst_1,tmp20,tmp21,eq,$L1
 goto_tb $0x0
 movi_i32 tmp6,$0x810e8a57
 movi_i32 tmp7,$0xffffffff
 st_i32 tmp6,env,$0x80
 st_i32 tmp7,env,$0x84
 exit_tb $0xf2f1c180
 set_label $L1
 goto_tb $0x1
 movi_i32 tmp6,$0x810e8a63
 movi_i32 tmp7,$0xffffffff
 st_i32 tmp6,env,$0x80
 st_i32 tmp7,env,$0x84
 exit_tb $0xf2f1c181
 set_label $L0
 exit_tb $0xf2f1c183

OP after optimization and liveness analysis:
 ld_i32 tmp18,env,$0xfffffff0             dead: 1  pref=3D0xff
 movi_i32 tmp19,$0x0                      pref=3D0xff
 brcond_i32 tmp18,tmp19,lt,$L0            dead: 0 1

 ---- ffffffff810e8a4c 0000000000000000

 ---- ffffffff810e8a52 0000000000000000
 movi_i32 tmp1,$0x0                       pref=3D0xff
 movi_i32 tmp0,$0x64                      pref=3D0xff
 mov_i32 r14_0,tmp0                       sync: 0  dead: 1  pref=3D0xf8
 mov_i32 r14_1,tmp1                       sync: 0  dead: 1  pref=3D0xf8
 call cc_compute_c,$0x5,$2,cc_src_0,cc_src_1,cc_dst_0,cc_dst_1,cc_src_0,cc_=
src_1,cc_src2_0,cc_src2_1,cc_op  sync: 0 1  dead: 0 1 2 3 4 5 6 7 8  pref=
=3Dnone,none
 mov_i32 cc_dst_0,r14_0                   sync: 0  dead: 0 1  pref=3D0xff
 mov_i32 cc_dst_1,r14_1                   sync: 0  dead: 0 1  pref=3D0xff=
=D0=A3=D0=B1=D0=B8=D1=82=D0=BE

(killed by me)

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

IN:
0xffffffff810e8a61:  eb ef                    jmp      0xffffffff810e8a52

OP:
 ld_i32 tmp18,env,$0xfffffff0
 movi_i32 tmp19,$0x0
 brcond_i32 tmp18,tmp19,lt,$L0

 ---- ffffffff810e8a61 0000000000000000
 goto_tb $0x0
 movi_i32 tmp6,$0x810e8a52
 movi_i32 tmp7,$0xffffffff
 st_i32 tmp6,env,$0x80
 st_i32 tmp7,env,$0x84
 exit_tb $0xf2f22900
 set_label $L0
 exit_tb $0xf2f22903

OP after optimization and liveness analysis:
 ld_i32 tmp18,env,$0xfffffff0             dead: 1  pref=3D0xff
 movi_i32 tmp19,$0x0                      pref=3D0xff
 brcond_i32 tmp18,tmp19,lt,$L0            dead: 0 1

 ---- ffffffff810e8a61 0000000000000000
 goto_tb $0x0
 movi_i32 tmp6,$0x810e8a52                pref=3D0xff
 movi_i32 tmp7,$0xffffffff                pref=3D0xff
 st_i32 tmp6,env,$0x80                    dead: 0
 st_i32 tmp7,env,$0x84                    dead: 0 1
 exit_tb $0xf2f22900
 set_label $L0
 exit_tb $0xf2f22903

OUT: [size=3D56]
0xf2f22980:  8b 5d f0                 movl     -0x10(%ebp), %ebx
0xf2f22983:  85 db                    testl    %ebx, %ebx
0xf2f22985:  0f 8c 23 00 00 00        jl       0xf2f229ae
0xf2f2298b:  e9 00 00 00 00           jmp      0xf2f22990
0xf2f22990:  c7 85 80 00 00 00 52 8a  movl     $0x810e8a52, 0x80(%ebp)
0xf2f22998:  0e 81
0xf2f2299a:  c7 85 84 00 00 00 ff ff  movl     $0xffffffff, 0x84(%ebp)
0xf2f229a2:  ff ff
0xf2f229a4:  b8 00 29 f2 f2           movl     $0xf2f22900, %eax
0xf2f229a9:  e9 69 46 c9 ff           jmp      0xf2bb7017
0xf2f229ae:  b8 03 29 f2 f2           movl     $0xf2f22903, %eax
0xf2f229b3:  e9 5f 46 c9 ff           jmp      0xf2bb7017

----------------
IN:
0xffffffff810e8a52:  49 ff ce                 decq     %r14
0xffffffff810e8a55:  74 0c                    je       0xffffffff810e8a63

OP:
 ld_i32 tmp18,env,$0xfffffff0
 movi_i32 tmp19,$0x0
 brcond_i32 tmp18,tmp19,lt,$L0

 ---- ffffffff810e8a52 0000000000000000
 mov_i32 tmp0,r14_0
 mov_i32 tmp1,r14_1
 mov_i32 tmp0,r14_0
 mov_i32 tmp1,r14_1
 movi_i32 tmp20,$0xffffffff
 movi_i32 tmp21,$0xffffffff
 add2_i32 tmp0,tmp1,tmp0,tmp1,tmp20,tmp21
 mov_i32 r14_0,tmp0
 mov_i32 r14_1,tmp1
 call cc_compute_c,$0x5,$2,cc_src_0,cc_src_1,cc_dst_0,cc_dst_1,cc_src_0,cc_=
src_1,cc_src2_0,cc_src2_1,cc_op
 mov_i32 cc_dst_0,tmp0
 mov_i32 cc_dst_1,tmp1
 discard cc_src2_0
 discard cc_src2_1
 discard cc_op

 ---- ffffffff810e8a55 0000000000000021 mov_i32 cc_dst_0,r14_0             =
      sync: 0  dead: 1  pref=3D0xff
 mov_i32 cc_dst_1,r14_1                   sync: 0  dead: 1  pref=3D0xff
 discard cc_src2_0                        pref=3D0xff
 discard cc_src2_1                        pref=3D0xff
 discard cc_op                            pref=3D0xff

 ---- ffffffff810e8a55 0000000000000021
 movi_i32 cc_op,$0x21                     sync: 0  dead: 0  pref=3D0xff
 movi_i32 tmp20,$0x0                      pref=3D0xff
 movi_i32 tmp21,$0x0                      pref=3D0xff
 brcond2_i32 cc_dst_0,cc_dst_1,tmp20,tmp21,eq,$L1  dead: 0 1 2 3
 goto_tb $0x0
 movi_i32 tmp6,$0x810e8a57                pref=3D0xff
 movi_i32 tmp7,$0xffffffff                pref=3D0xff
 st_i32 tmp6,env,$0x80                    dead: 0
 st_i32 tmp7,env,$0x84                    dead: 0 1
 exit_tb $0xf2f229c0
 set_label $L1
 goto_tb $0x1
 movi_i32 tmp6,$0x810e8a63                pref=3D0xff movi_i32 cc_op,$0x9  =
                    sync: 0  dead: 0  pref=3D0xff
 goto_tb $0x0
 movi_i32 tmp6,$0x810e8a2b                pref=3D0xff
 movi_i32 tmp7,$0xffffffff                pref=3D0xff
 st_i32 tmp6,env,$0x80                    dead: 0
 st_i32 tmp7,env,$0x84                    dead: 0 1
 exit_tb $0xf2f22b40
 set_label $L0
 exit_tb $0xf2f22b43

OUT: [size=3D116]
0xf2f22bc0:  8b 5d f0                 movl     -0x10(%ebp), %ebx
0xf2f22bc3:  85 db                    testl    %ebx, %ebx
0xf2f22bc5:  0f 8c 5f 00 00 00        jl       0xf2f22c2a
0xf2f22bcb:  8b 5d 18                 movl     0x18(%ebp), %ebx
0xf2f22bce:  8b 75 1c                 movl     0x1c(%ebp), %esi
0xf2f22bd1:  83 c3 64                 addl     $0x64, %ebx
0xf2f22bd4:  83 d6 00                 adcl     $0, %esi
0xf2f22bd7:  89 5d 18                 movl     %ebx, 0x18(%ebp)
=D0=A3=D0=B1=D0=B8=D1=82=D0=BE

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D

try kernel I use (it works with qemu compiiled under 64-bit Slackware,
and also with kvm on 32-bit x86)

sha256sum /boot/bzImage-4.12.0-x64
b4183376de17e8ea7a25094b7a526e99bcb8339b8703090684c93e0e0a50d284  /boot/bzI=
mage-4.12.0-x64

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1830872

Title:
  AARCH64 to ARMv7 mistranslation in TCG

Status in QEMU:
  New

Bug description:
  The following guest code:

  https://github.com/tianocore/edk2/blob/3604174718e2afc950c3cc64c64ba5165c=
8692bd/MdePkg/Library/BaseMemoryLibOptDxe/AArch64/CopyMem.S

  implements, in hand-optimized aarch64 assembly, the CopyMem() edk2 (EFI
  Development Kit II) library function. (CopyMem() basically has memmove()
  semantics, to provide a standard C analog here.) The relevant functions
  are InternalMemCopyMem() and __memcpy().

  When TCG translates this aarch64 code to x86_64, everything works
  fine.

  When TCG translates this aarch64 code to ARMv7, the destination area of
  the translated CopyMem() function becomes corrupted -- it differs from
  the intended source contents. Namely, in every 4096 byte block, the
  8-byte word at offset 4032 (0xFC0) is zeroed out in the destination,
  instead of receiving the intended source value.

  I'm attaching two hexdumps of the same destination area:

  - "good.txt" is a hexdump of the destination area when CopyMem() was
    translated to x86_64,

  - "bad.txt" is a hexdump of the destination area when CopyMem() was
    translated to ARMv7.

  In order to assist with the analysis of this issue, I disassembled the
  aarch64 binary with "objdump". Please find the listing in
  "DxeCore.objdump", attached. The InternalMemCopyMem() function starts at
  hex offset 2b2ec. The __memcpy() function starts at hex offset 2b180.

  And, I ran the guest on the ARMv7 host with "-d
  in_asm,op,op_opt,op_ind,out_asm". Please find the log in
  "tcg.in_asm.op.op_opt.op_ind.out_asm.log", attached.

  The TBs that correspond to (parts of) the InternalMemCopyMem() and
  __memcpy() functions are scattered over the TCG log file, but the offset
  between the "nice" disassembly from "DxeCore.objdump", and the in-RAM
  TBs in the TCG log, can be determined from the fact that there is a
  single prfm instruction in the entire binary. The instruction's offset
  is 0x2b180 in "DxeCore.objdump" -- at the beginning of the __memcpy()
  function --, and its RAM address is 0x472d2180 in the TCG log. Thus the
  difference (=3D the load address of DxeCore.efi) is 0x472a7000.

  QEMU was built at commit a4f667b67149 ("Merge remote-tracking branch
  'remotes/cohuck/tags/s390x-20190521-3' into staging", 2019-05-21).

  The reproducer command line is (on an ARMv7 host):

    qemu-system-aarch64 \
      -display none \
      -machine virt,accel=3Dtcg \
      -nodefaults \
      -nographic \
      -drive if=3Dpflash,format=3Draw,file=3D$prefix/share/qemu/edk2-aarch6=
4-code.fd,readonly \
      -drive if=3Dpflash,format=3Draw,file=3D$prefix/share/qemu/edk2-arm-va=
rs.fd,snapshot=3Don \
      -cpu cortex-a57 \
      -chardev stdio,signal=3Doff,mux=3Don,id=3Dchar0 \
      -mon chardev=3Dchar0,mode=3Dreadline \
      -serial chardev:char0

  The apparent symptom is an assertion failure *in the guest*, such as

  > ASSERT [DxeCore]
  > /home/lacos/src/upstream/qemu/roms/edk2/MdePkg/Library/BaseLib/String.c=
(1090):
  > Length < _gPcd_FixedAtBuild_PcdMaximumAsciiStringLength

  but that is only a (distant) consequence of the CopyMem()
  mistranslation, and resultant destination area corruption.

  Originally reported in the following two mailing list messages:
  - http://mid.mail-archive.com/9d2e260c-c491-03d2-9b8b-b57b72083f77@redhat=
.com
  - http://mid.mail-archive.com/f1cec8c0-1a9b-f5bb-f951-ea0ba9d276ee@redhat=
.com

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1830872/+subscriptions

