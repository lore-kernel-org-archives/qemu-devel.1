Received: from eggs.gnu.org ([2001:4830:134:3::10]:33467)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gOz8t-0000d3-T7
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 01:04:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gOz6T-0004In-B9
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 01:01:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59300)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gOz6T-0004IF-1G
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 01:01:41 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5688D7FDF3
	for <qemu-devel@nongnu.org>; Tue, 20 Nov 2018 06:01:40 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 20 Nov 2018 07:01:38 +0100
Message-Id: <20181120060138.25446-2-kraxel@redhat.com>
In-Reply-To: <20181120060138.25446-1-kraxel@redhat.com>
References: <20181120060138.25446-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 1/1] update seabios to 1.12
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>

Seabios 1.12 has been released yesterday.  Update
our snapshot builds to the final release.

git shortlog
============

Kevin O'Connor (2):
      shadow: Rework bios copy code to prevent gcc array-bounds warning
      docs: Note v1.12.0 release

Shmuel Eiderman (1):
      pvscsi: Scan all 64 possible targets

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 pc-bios/bios-256k.bin             | Bin 262144 -> 262144 bytes
 pc-bios/bios.bin                  | Bin 131072 -> 131072 bytes
 pc-bios/vgabios-bochs-display.bin | Bin 27648 -> 27648 bytes
 pc-bios/vgabios-cirrus.bin        | Bin 38400 -> 38400 bytes
 pc-bios/vgabios-qxl.bin           | Bin 38912 -> 38912 bytes
 pc-bios/vgabios-ramfb.bin         | Bin 28160 -> 28160 bytes
 pc-bios/vgabios-stdvga.bin        | Bin 38912 -> 38912 bytes
 pc-bios/vgabios-virtio.bin        | Bin 38912 -> 38912 bytes
 pc-bios/vgabios-vmware.bin        | Bin 38912 -> 38912 bytes
 pc-bios/vgabios.bin               | Bin 38400 -> 38400 bytes
 roms/Makefile                     |   2 +-
 roms/seabios                      |   2 +-
 12 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/pc-bios/bios-256k.bin b/pc-bios/bios-256k.bin
index 72801adc430d83a9ebb4959314015257ac6cb7fe..08ca873ab57ab6e14bb9a5cdf703c6501230f1d3 100644
GIT binary patch
delta 8024
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%0A7Q-26D
zWi`c(XZh_>e*nsKb2Tb8dUr-$YdKlst>tXW@COQH7a-kz^(F}~72QyHyG;L`Z=pcQ
zbF9Fiv;e2h?5E2AIF$X4XUYc_JGwtt&dTDCn^#jwlIyG2Yoyq$kdXUsa5`Nr==Gmh
zoFXr`J>7NDO(mI%-Ra`%r#GWa>FkGt=E+xndRr9TC;aqU&D0-Zkoq9A$a5Ur=ya}B
ze_8k&FkJ!G{tqAk!dSURV*K?W#K}(n`eZLv322rEE1&m}eg1m*Ybs@SJU9ou33At8
zZ$jh69H7UNLwW`1Eq&coZF{H4>2%D6??X<X@tG_S&;u!4>;ZZlUW%^==n-Deod~3*
z`{0qqr-mLmqcx~{roENfJYGpTp&for+uYS_9OUAICrkBQ=?##2ta~M@RJD~awpyWp
z@ni{@SSg+@!DSvR)WW%ya#iFli*}7{_imNlMj54MOvZ6r`L6T2X~RpOUAKKI-!avO
zbQ-QjusGnTy&v*!qSW@_Z%*gtmsf{ZjPm49FgoU20Bv`y`zqlNK7O|<rse_m2kvg7
zVkj~n9{)zvc5R`jsyMX?pp*hpY{#P_0I1#A(GKI0h!}M>&aoa=3{}8~?orVqDj!A}
z?Pwx{1NB-nz6D#EN(PDMnrQvd)<zqMw%*=Eb3-lX1yVPVt?AhKy({h|JJ$T7=)1=c
zL{6tU4itjr3ZLSIJj}5kV^Hw6?XG{y`jjU7xn6@S)GtmUya|=Fg{k+`vg%8MbiWy@
ztGT?xFg4!~1j<l7MIawm@1~9(aAl5z)78OU!Es21cgj}CF+hfFmZ^Ru`YZduSF~HL
zeys(brOOekU#&|0pH+|d{&!WGpBlKU73yDHo?16behAV#c!VN!rYE$LyFvO6IQ)&l
z`bg>`ejzab6loWtC&D>rgy^g23yBKV2O?^G8mfOnhPa36Q>vdqye;e)s62XEU7MfT
zu}reVp!z?_x-flM^$jX6cgJMbhzBa8FI^?!;rc0L4o|}Mxind3)zsTj3(2pk*A6|m
z8bYfO;wp94IeC!DDgd4CD-4d%1ERz31(~$g!6xl8zD*$}Z5O_jP?NS4-wvaBvVN88
zG-(tY6C3m1yDeI`8rG_H>*gb4CQKYLH0}MdmPQ|r7?;-QgNg5H3%Af+GFtc0uX#%B
z+q#<((NDh;PJ@g}AM4rgM4P)I4y}Lsd}PjA=vJxm^8ZDiOjlTPM0Hm(oo4Jhtmo){
slfhYO{?oXl3yzN5sZ@4kPJ1K!n11Os8fZ*9ufO3<n~a}t=-qt(57BC?!vFvP

delta 7985
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

diff --git a/pc-bios/bios.bin b/pc-bios/bios.bin
index 2bb57341a0f446afd9ed9dc06268f8d9bffb24f0..056e0f81f9c6572ff02167da0ffd0bb58f770143 100644
GIT binary patch
delta 8879
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

delta 8871
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

diff --git a/pc-bios/vgabios-bochs-display.bin b/pc-bios/vgabios-bochs-display.bin
index 9796e666222b41797fc7d35b03454e23d5faa7d6..0657f6695d655ffe3a5c252e7b19a3fa13ae002f 100644
GIT binary patch
delta 135
zcmZp;!Pszvkv(*k*~{hD5gXZ^co}C*_Ts(CIAgO4pQ0d;<0fwpB-`X?0ZBy#MIh;{
zU<o8^6<UELv!Wr8G*wjNo{{}7&GGd+y>77?o6{6|y;O|!40H{2(-X}sEs`xPEltyO
f3yM;cN;7jx^a@jROZD=L(itYt&rY0tz=Z<<T?8(J

delta 142
zcmZp;!Pszvkv(*k*~{hDM>euM@iH!$?8SSNalvL4K1D$w$4%ZINVdt(0+Nafia^p?
z!4gQ;DzpMgW<^6FX{xBky&(Htn&aztdfj3RHm51_dg&YL8R(iC=%yQ*7#SHRr&yS!
l>J}8GCY5I9l;{<v=9U6^`B|ySC3^Wq=?qLPlNV;k0RZx8F!TTb

diff --git a/pc-bios/vgabios-cirrus.bin b/pc-bios/vgabios-cirrus.bin
index fbd66aa959540562b8071bd888f4bdd045b9c3ec..de36372725297a05fa486b67ee26c6679dc3c6cd 100644
GIT binary patch
delta 136
zcmZoz!_=^bi9K|c_e-6?o{j7$gc)B<z94*)@x|s<B6eax&Py$OAgQT63rHT(Rs@pI
zv@L<8f=(-tT&80PByZ@bale@IF3s`vJH2kP7n?bCccrTs=^5x6=%y!{Sz07pSX!E<
h=@t~FCY5I9l;{<v=9cQ^7o{_7em_N!aq@&14gf^1Hs1gM

delta 143
zcmZoz!_=^bi9K|c_e-6?9~;?E2s3_|d_njo<A=?wMC`<XoR?bmKvGkC7LYumtq3Ha
zX<GtG1)WwPxlG3pNZ!y<<Nh$^U7F+TcY57oA2xI9?n>7;)HBdEHPB5rG%+$VOir;d
nOVuqXN=+)w%qh_;OwBC?^76A%lS}mSi_#gGST;At@G$}a6eu{r

diff --git a/pc-bios/vgabios-qxl.bin b/pc-bios/vgabios-qxl.bin
index e5645fa8af97db2c8d3e6e081614e836163acbe1..ce2e2141cebc185e37ce0c3948712199985abe25 100644
GIT binary patch
delta 135
zcmZqJz|^pTi9K|c&&$0bpEt61@-Z4rp2&BT(O`2ne}N2;b4S}ANXqEU0+QQx6oKST
z9ZMi7tlJ7CXX+XP$<w-O+y>L$r8&NSr`IiJu=$TJe}=k|o`J4`ZhE4brA4xZrKM?_
fZb4CMQfX#RiC$r9ZmC{=Q91(y6U*j{vF8{8l#(t;

delta 140
zcmZqJz|^pTi9K|c&&$0b@f+DY`4}xGPvpDFXt6n)zd#1axub0lBxQ7F0m<z;ia_$F
zjwO&3)@=onGj$Dt<Y`?sZi{K}(i~sE)9V(q*!)MAKSRe*&p_AIKsVjc#K_1nImN;(
jRkxrhHK{Z+r$nzXHMbPV%g;(pF44;`O5dzM?Ia@rS}8Eu

diff --git a/pc-bios/vgabios-ramfb.bin b/pc-bios/vgabios-ramfb.bin
index 5b65e9084e133f5f7f51990ea8bbbe30ad6a9b73..44b91cfd3dc5c043bb99453a2015a9ccccfe021a 100644
GIT binary patch
delta 141
zcmZp;!`N_#kv(*k`Ab$?fysex;v40(c^O3}d-2|66xpo8w@MJmIWKPyB>5F)0m)Sg
zia_#=f+dh-Q)~s2J&J}va-X6aw@B{0G{@KP^t#1F7Qa{YRyWc!&^6FaPc*Z%NVc%F
lG)>bjC`wH#&CDs$D@@HT)ypqRXJBArnXH(5e{w?@HvslkE7AY}

delta 149
zcmZp;!`N_#kv(*k`Ab&Yn#qA~;v40(c^PFUd-2|6l-aDpw@MJmIWKPyB>5F)0m)Sg
zia_#=f+dh-Q)~s2J&J}va-X6aw@mK4G{@KP^t#1l7Qa{Y);H8M&^0yCO*b?#GBQj~
su`o;3EhtJ&D$UF((JM^NEd}!Ovr>~w^zw_+8JJimE9Ty3W?*0d0J|wJX#fBK

diff --git a/pc-bios/vgabios-stdvga.bin b/pc-bios/vgabios-stdvga.bin
index 5818f6d6686cc621388d9cbb24e8a0468cc194b4..cfbcae944d5fd0901e21ded7b1fbcec6653a17eb 100644
GIT binary patch
delta 135
zcmZqJz|^pTi9K|c&&$0bcQ>+k@-Z4rp2&BT(O`2ne}N2;b4S}ANXqEU0+QQx6oKST
z9ZMi7tlJ7CXX+XP$<w-O+y>L$r8&NSr`IiJu=$TJe}=k|o`J4`ZhE4brA4xZrKM?_
fZb4CMQfX#RiC$r9ZmC{=Q91(y6U*j{vF8{8iWV+1

delta 140
zcmZqJz|^pTi9K|c&&$0bo*UUa`4}xGPvpDFXt6n)zd#1axub0lBxQ7F0m<z;ia_$F
zjwO&3)@=onGj$Dt<Y`?sZi{K}(i~sE)9V(q*!)MAKSRe*&p_AIKsVjc#K_1nImN;(
jRkxrhHK{Z+r$nzXHMbPV%g;(pF44;`O5dzM?Ia@rPd_lj

diff --git a/pc-bios/vgabios-virtio.bin b/pc-bios/vgabios-virtio.bin
index 67359653478605bc0af39921ae0b8eda25854a79..d81fd281a2a3f0d484becdf9432b62fc2fdda404 100644
GIT binary patch
delta 135
zcmZqJz|^pTi9K|c&&$0b*Eh0v@-Z4rp2&BT(O`2ne}N2;b4S}ANXqEU0+QQx6oKST
z9ZMi7tlJ7CXX+XP$<w-O+y>L$r8&NSr`IiJu=$TJe}=k|o`J4`ZhE4brA4xZrKM?_
fZb4CMQfX#RiC$r9ZmC{=Q91(y6U*j{vF8{8hdM4S

delta 140
zcmZqJz|^pTi9K|c&&$0b&Kub~`4}xGPvpDFXt6n)zd#1axub0lBxQ7F0m<z;ia_$F
zjwO&3)@=onGj$Dt<Y`?sZi{K}(i~sE)9V(q*!)MAKSRe*&p_AIKsVjc#K_1nImN;(
jRkxrhHK{Z+r$nzXHMbPV%g;(pF44;`O5dzM?Ia@rOhqug

diff --git a/pc-bios/vgabios-vmware.bin b/pc-bios/vgabios-vmware.bin
index b76947a12820a69b54e3b55c31311bcef86b8ec6..05db8b1b0d62d59eb549d6eabedcd19223d17e0d 100644
GIT binary patch
delta 135
zcmZqJz|^pTi9K|c&&$0bRU6qm`4|l*PvpDFXs|h(zd#1axub0lBxQ7F0m<z;ia_$F
zjwO&3)@=onGj$Dt<Y`?sZi8v>(i~sE)9V&9*!)MAKSSL}&p_8eH$BnJ(jwWy($X|d
fx1cCBsWdaEM6WP4w^T2`D4l_UiDmP}*mH~kTIem$

delta 140
zcmZqJz|^pTi9K|c&&$0b&o;7m@-bRWp2&BT(PDEpe}N2;b4S}ANXqEU0+QQx6oKST
z9ZMi7tlJ7CXX+XP$<w-O+!oW`r8&NSr`IiJvH6cKe};~so`J5Zfo{5?iII_Ea*Bmn
js%}A1YEo%tPKjP&YHlfzm!FlIT%wm>l)hPi+DS$Logy({

diff --git a/pc-bios/vgabios.bin b/pc-bios/vgabios.bin
index 729aecc426dade9ef5266cdd3c1ded1717dce98d..b469f5d0f0fc59736988fcee99da6ffe9efae022 100644
GIT binary patch
delta 138
zcmZoz!_=^bi9K|c_sbW-#*;6`h;NiD;$xJVJdy7vqs-=P{sI{w=Z>~Lkd)Dx1thoY
zC<4iwI+j3EShp2O&eSyolBadmxMilkOLKhvPOn=`X7eB2-)ZVbdIq`%y6K5#mKMnt
imX@Yzx&=k4Nu`-NC3=OaxutsfMd=I-Oe{cq9{~XN{x5$3

delta 146
zcmZoz!_=^bi9K|c_sbW-^Cw@75#K0R#K)*Ic_QCUMwQLk`~@;V&K+%gASt6W3rKF)
zQ3R4Vbu59Tux=}moT+OFBv0$AajQ&ym*)8TonE(?%H}`1zti*$^$c`P4Rq5DO^l2T
olT$3rQgsW8Qj<zEb4v6IQ*%p!y!@=x<PyF7qI3o(7NGsN0My+xe*gdg

diff --git a/roms/Makefile b/roms/Makefile
index f1ac85ae9b..f4141e1d96 100644
--- a/roms/Makefile
+++ b/roms/Makefile
@@ -39,7 +39,7 @@ powerpc_cross_prefix := $(call find-cross-prefix,powerpc)
 x86_64_cross_prefix := $(call find-cross-prefix,x86_64)
 
 # tag our seabios builds
-SEABIOS_EXTRAVERSION="-prebuilt.qemu-project.org"
+SEABIOS_EXTRAVERSION="-prebuilt.qemu.org"
 
 #
 # EfiRom utility is shipped with edk2 / tianocore, in BaseTools/
diff --git a/roms/seabios b/roms/seabios
index 14221cd86e..a698c8995f 160000
--- a/roms/seabios
+++ b/roms/seabios
@@ -1 +1 @@
-Subproject commit 14221cd86eadba82255fdc55ed174d401c7a0a04
+Subproject commit a698c8995ffb2838296ec284fe3c4ad33dfca307
-- 
2.9.3
