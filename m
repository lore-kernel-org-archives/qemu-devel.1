Received: from eggs.gnu.org ([2001:4830:134:3::10]:58842)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dG2zC-0003TT-Rl
	for qemu-devel@nongnu.org; Wed, 31 May 2017 08:44:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dG2z8-0005Uo-Ez
	for qemu-devel@nongnu.org; Wed, 31 May 2017 08:44:26 -0400
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 31 May 2017 14:44:18 +0200
Message-Id: <20170531124418.15752-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH] linuxboot_dma: compile for i486
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: rjones@redhat.com, thuth@redhat.com, rob@landley.net, qemu-stable@nongnu.org

The ROM uses the cmovne instruction, which is new in Pentium Pro and does not
work when running QEMU with "-cpu 486".  Avoid producing that instruction.

Suggested-by: Richard W.M. Jones <rjones@redhat.com>
Suggested-by: Thomas Huth <thuth@redhat.com>
Reported-by: Rob Landley <rob@landley.net>
Cc: qemu-stable@nongnu.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 pc-bios/linuxboot_dma.bin  | Bin 1536 -> 1536 bytes
 pc-bios/optionrom/Makefile |   1 +
 2 files changed, 1 insertion(+)

diff --git a/pc-bios/linuxboot_dma.bin b/pc-bios/linuxboot_dma.bin
index 218d3ab4a29bfb5ab7125ec7a4d29dad1860c673..d176f62797813e4b926dca9dfce7ce554dc1a4d6 100644
GIT binary patch
literal 1536
zcmeHFL2J`s82-{_T52KL%w~}udiW-YBE*9t=s~ClrIm^s9^6H6Pf%onr07*+kWd=L
zpW)d<4G1ZESU1FyUDSCf^YYaxioy<}t?!rmu^#*f?mHxJo;-Qp_kHp#Je^o$|2##;
zYs)n)qh6k7XI07O)9TW>>H@3WSgzkI-MW44`qG_Jxhgq7fAt@+rpuZy7{g_FpG^eo
zuoD<7Fjn!zK~Uydy3X@Fj1CnQuA}{tXz$^z=7>a?#S!%6CsARNbiO)h=v+Q~y@5O1
ze8y7!akTy&-YXMV@p3Es`0q*km+)Mtxe(3DE2)a5;c%$H0|Yu~mbnR0C7dKHR7Zsr
zmrccq5lm%U=wXc39<t?-(_m*ZnY&YH(d(0lj;0`jj8e`iWgX(jV5j3gg<B9Cgj2^d
zw;W8A$%i@ijhITTF%3U<ui*Zsgx!lc)pgIq-atzea+i1H+3Oj<V?5-VpBVlz4R#!?
zV3N_sX!mjsj*#|9H8ozR&D5ajsurT@(W<h&xG*;8UNvYI;`kVzRd@m7;AnvgFCdyy
zI>gV6@%Jl!9^%vQ9V0A-7a<bD(|L-BW|R)`qY*CS(3SQRXOVJqcpcuB8NLnUuosH3
zi{OJ7mufeeG{^49xY<M4U)CrSC7Fp}TjtSE>UkNnpxu8npp2ruY0}SsKn=BiGN9Y;
L*>&K*abWuoMsO(*

literal 1536
zcmeHF&ubGw6rN4Dn#RCxYN|nUh%gpJFME=L9)#^}1F5!ps0f07iy|#(O1<iu!xFNH
ze}?~naY4vZ57wZB1jMR`ST7r__~R&=_04QYJoq2jIn2&}@6GqV_sv^+G|^@MTxG^<
zD>W^nf~VP8b!3b3v@l;?V$SuIwL6uYt5>dGyH&BPBIn1?(K>6@S?eidI1hgSZ^wky
zNA%Hz@f^krJcQTH!Ptb+b>Z7QOZy_v)9!Gc_A*CUnxyOgP~7<9qN#In@`mGjfw=z$
z*1p4gW?~r|cz_FdqLT)y8y*s0Z-)z#_;!*cE?PD>cN4<HA{;MET(E~F0*Ke4l-T|Q
zN3kAs(B4Nz%(_i>CX-n&AUsLGXj9UuS(2NP%(`OENoGw|EGqnf#7ASHq-k?KrExJ~
z^CHnSr*VvZO%mMQmY+taei4m+{T$|c^(w4)XlpT*^|#=^eK`aF_0%gE_5j9w)aV=c
zk7$UtO_Fkt>S!)b5N*mx5@orPY(na#Hj4<S)0RarUXZ%Tp{&xoU+SGxcuC<|i62e-
zaCiw}LGfe}PpSO8%0DRczx~>MfwIDj65o<I`H@FBlkzycj5td1A}41qQPA(<_yF`A
z@IINro1ha6gE;8HfA4iFwHr(rWNnH$vl3XJyEGJ>hT<|dXkK7E?qHJ9XdoKqMjysh
NXm9N~@Si)N{RVuA8xQ~h

diff --git a/pc-bios/optionrom/Makefile b/pc-bios/optionrom/Makefile
index fa53d9e58e..a9a9e5e7eb 100644
--- a/pc-bios/optionrom/Makefile
+++ b/pc-bios/optionrom/Makefile
@@ -13,6 +13,7 @@ $(call set-vpath, $(SRC_PATH)/pc-bios/optionrom)
 ifeq ($(lastword $(filter -O%, -O0 $(CFLAGS))),-O0)
 override CFLAGS += -O2
 endif
+override CFLAGS += -march=i486
 
 # Drop -fstack-protector and the like
 QEMU_CFLAGS := $(filter -W%, $(QEMU_CFLAGS)) $(CFLAGS_NOPIE) -ffreestanding
-- 
2.13.0
