Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NORMAL_HTTP_TO_IP,NUMERIC_HTTP_ADDR,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43235C35247
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 01:48:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBB8921927
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 01:48:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBB8921927
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49302 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iynKX-0001t5-NR
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 20:48:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48320)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <guoheyi@huawei.com>) id 1iynIh-00087W-Ux
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 20:46:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <guoheyi@huawei.com>) id 1iynIe-00008w-GU
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 20:46:51 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:2753 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <guoheyi@huawei.com>)
 id 1iynIS-0008IA-VU; Mon, 03 Feb 2020 20:46:38 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 3456B39E3BB953705203;
 Tue,  4 Feb 2020 09:46:30 +0800 (CST)
Received: from linux-TFkxOR.huawei.com (10.175.104.212) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.439.0; Tue, 4 Feb 2020 09:46:19 +0800
From: Heyi Guo <guoheyi@huawei.com>
To: <qemu-devel@nongnu.org>
Subject: [PATCH v3 7/7] virt/acpi: update golden masters for DSDT update
Date: Tue, 4 Feb 2020 09:43:25 +0800
Message-ID: <20200204014325.16279-8-guoheyi@huawei.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20200204014325.16279-1-guoheyi@huawei.com>
References: <20200204014325.16279-1-guoheyi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.104.212]
X-CFilter-Loop: Reflected
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.191
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Shannon Zhao <shannon.zhaosl@gmail.com>,
 qemu-arm@nongnu.org, Igor
 Mammedov <imammedo@redhat.com>, Heyi Guo <guoheyi@huawei.com>,
 wanghaibin.wang@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Differences between disassembled ASL files:

@@ -5,13 +5,13 @@
  *
  * Disassembling to symbolic ASL+ operators
  *
- * Disassembly of DSDT, Thu Jan 23 16:00:04 2020
+ * Disassembly of DSDT.new, Thu Jan 23 16:47:12 2020
  *
  * Original Table Header:
  *     Signature        "DSDT"
- *     Length           0x0000481E (18462)
+ *     Length           0x000014BB (5307)
  *     Revision         0x02
- *     Checksum         0x60
+ *     Checksum         0xD1
  *     OEM ID           "BOCHS "
  *     OEM Table ID     "BXPCDSDT"
  *     OEM Revision     0x00000001 (1)
@@ -43,7 +43,6 @@ DefinitionBlock ("", "DSDT", 2, "BOCHS ", "BXPCDSDT", 0=
x00000001)
                     0x00000021,
                 }
             })
-            Name (_ADR, 0x09000000)  // _ADR: Address
         }

         Device (FLS0)
@@ -668,11 +667,10 @@ DefinitionBlock ("", "DSDT", 2, "BOCHS ", "BXPCDSDT=
", 0x00000001)
             Name (_CID, "PNP0A03" /* PCI Bus */)  // _CID: Compatible ID
             Name (_SEG, Zero)  // _SEG: PCI Segment
             Name (_BBN, Zero)  // _BBN: BIOS Bus Number
-            Name (_ADR, Zero)  // _ADR: Address
             Name (_UID, "PCI0")  // _UID: Unique ID
             Name (_STR, Unicode ("PCIe 0 Device"))  // _STR: Description=
 String
             Name (_CCA, One)  // _CCA: Cache Coherency Attribute
-            Name (_PRT, Package (0x0400)  // _PRT: PCI Routing Table
+            Name (_PRT, Package (0x80)  // _PRT: PCI Routing Table
             {
                 Package (0x04)
                 {
@@ -1696,7174 +1694,6 @@ DefinitionBlock ("", "DSDT", 2, "BOCHS ", "BXPCD=
SDT", 0x00000001)
                     0x03,
                     GSI2,
                     Zero
-                },
-
-                Package (0x04)
-                {
-                    0x0020FFFF,
-                    Zero,
-                    GSI0,
-                    Zero
-                },
-
-                *Omit the other (4 * (256 - 32) - 2) packages*
-
-                Package (0x04)
-                {
-                    0x00FFFFFF,
-                    0x03,
-                    GSI2,
-                    Zero
                 }
             })
             Device (GSI0)
@@ -8892,7 +1722,7 @@ DefinitionBlock ("", "DSDT", 2, "BOCHS ", "BXPCDSDT=
", 0x00000001)
             Device (GSI1)
             {
                 Name (_HID, "PNP0C0F" /* PCI Interrupt Link Device */)  =
// _HID: Hardware ID
-                Name (_UID, Zero)  // _UID: Unique ID
+                Name (_UID, One)  // _UID: Unique ID
                 Name (_PRS, ResourceTemplate ()  // _PRS: Possible Resou=
rce Settings
                 {
                     Interrupt (ResourceConsumer, Level, ActiveHigh, Excl=
usive, ,, )
@@ -8915,7 +1745,7 @@ DefinitionBlock ("", "DSDT", 2, "BOCHS ", "BXPCDSDT=
", 0x00000001)
             Device (GSI2)
             {
                 Name (_HID, "PNP0C0F" /* PCI Interrupt Link Device */)  =
// _HID: Hardware ID
-                Name (_UID, Zero)  // _UID: Unique ID
+                Name (_UID, 0x02)  // _UID: Unique ID
                 Name (_PRS, ResourceTemplate ()  // _PRS: Possible Resou=
rce Settings
                 {
                     Interrupt (ResourceConsumer, Level, ActiveHigh, Excl=
usive, ,, )
@@ -8938,7 +1768,7 @@ DefinitionBlock ("", "DSDT", 2, "BOCHS ", "BXPCDSDT=
", 0x00000001)
             Device (GSI3)
             {
                 Name (_HID, "PNP0C0F" /* PCI Interrupt Link Device */)  =
// _HID: Hardware ID
-                Name (_UID, Zero)  // _UID: Unique ID
+                Name (_UID, 0x03)  // _UID: Unique ID
                 Name (_PRS, ResourceTemplate ()  // _PRS: Possible Resou=
rce Settings
                 {
                     Interrupt (ResourceConsumer, Level, ActiveHigh, Excl=
usive, ,, )
@@ -8965,37 +1795,6 @@ DefinitionBlock ("", "DSDT", 2, "BOCHS ", "BXPCDSD=
T", 0x00000001)

             Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource S=
ettings
             {
-                Name (RBUF, ResourceTemplate ()
-                {
-                    WordBusNumber (ResourceProducer, MinFixed, MaxFixed,=
 PosDecode,
-                        0x0000,             // Granularity
-                        0x0000,             // Range Minimum
-                        0x00FF,             // Range Maximum
-                        0x0000,             // Translation Offset
-                        0x0100,             // Length
-                        ,, )
-                    DWordMemory (ResourceProducer, PosDecode, MinFixed, =
MaxFixed, NonCacheable, ReadWrite,
-                        0x00000000,         // Granularity
-                        0x10000000,         // Range Minimum
-                        0x3EFEFFFF,         // Range Maximum
-                        0x00000000,         // Translation Offset
-                        0x2EFF0000,         // Length
-                        ,, , AddressRangeMemory, TypeStatic)
-                    DWordIO (ResourceProducer, MinFixed, MaxFixed, PosDe=
code, EntireRange,
-                        0x00000000,         // Granularity
-                        0x00000000,         // Range Minimum
-                        0x0000FFFF,         // Range Maximum
-                        0x3EFF0000,         // Translation Offset
-                        0x00010000,         // Length
-                        ,, , TypeStatic, DenseTranslation)
-                    QWordMemory (ResourceProducer, PosDecode, MinFixed, =
MaxFixed, NonCacheable, ReadWrite,
-                        0x0000000000000000, // Granularity
-                        0x0000008000000000, // Range Minimum
-                        0x000000FFFFFFFFFF, // Range Maximum
-                        0x0000000000000000, // Translation Offset
-                        0x0000008000000000, // Length
-                        ,, , AddressRangeMemory, TypeStatic)
-                })
                 Return (ResourceTemplate ()
                 {
                     WordBusNumber (ResourceProducer, MinFixed, MaxFixed,=
 PosDecode,
@@ -9080,11 +1879,6 @@ DefinitionBlock ("", "DSDT", 2, "BOCHS ", "BXPCDSD=
T", 0x00000001)
                 })
             }

-            Device (RP0)
-            {
-                Name (_ADR, Zero)  // _ADR: Address
-            }
-
             Device (RES0)
             {
                 Name (_HID, "PNP0C02" /* PNP Motherboard Resources */)  =
// _HID: Hardware ID
@@ -9131,7 +1925,6 @@ DefinitionBlock ("", "DSDT", 2, "BOCHS ", "BXPCDSDT=
", 0x00000001)
         Device (PWRB)
         {
             Name (_HID, "PNP0C0C" /* Power Button Device */)  // _HID: H=
ardware ID
-            Name (_ADR, Zero)  // _ADR: Address
             Name (_UID, Zero)  // _UID: Unique ID
         }
     }

The differences between the two versions of DSDT.memhp are almost the
same as the above, except for total length and checksum.

DSDT.numamem binary is just the same with DSDT on virt machine, so we
don't show the differences again.

Signed-off-by: Heyi Guo <guoheyi@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

---
Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>
Cc: Shannon Zhao <shannon.zhaosl@gmail.com>
Cc: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org
---
 tests/data/acpi/virt/DSDT                   | Bin 18462 -> 5307 bytes
 tests/data/acpi/virt/DSDT.memhp             | Bin 19799 -> 6644 bytes
 tests/data/acpi/virt/DSDT.numamem           | Bin 18462 -> 5307 bytes
 tests/qtest/bios-tables-test-allowed-diff.h |   3 ---
 4 files changed, 3 deletions(-)

diff --git a/tests/data/acpi/virt/DSDT b/tests/data/acpi/virt/DSDT
index d0f3afeb134fdf1c11f64cd06dbcdd30be603b80..d6f5c617881c4247f55d4dcd0=
6581f9693916b2f 100644
GIT binary patch
delta 156
zcmbO?fpNDcmrJlq$Zin^2BwP>xulufJQ*iyC^K43^tIeLL4lLWeZ}O>oO+X=3Db6T<Z
z6mvCfR_C%{pDgc^#>hCi&BajKi^V<I(}*M9!_$Q~z%RhS*}#o~BR<sAg^OwOMVP!X
lHhJdBGOmtnjvVpMLBX3Jy81CrwsAkqC^^YPgaxRb0RT`TDiQzy

literal 18462
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
A00000

diff --git a/tests/data/acpi/virt/DSDT.memhp b/tests/data/acpi/virt/DSDT.=
memhp
index 41ccc6431b917252bcbaac86c33b340c796be5ce..c527ac4739af3df3c3e042bf9=
1c412033a2b73c3 100644
GIT binary patch
delta 173
zcmcaUi}8ywmrJlq$QMZl2ByY|T++<_a~LOTC^K43^tIeLL4lLWeZ}O>oO+X=3Db6T<Z
z6mvCfR_C%{pDgc^#>hCi&BajKi^V<I(}*M9!_$Q~z%RhS*}#o~BR<sAg^OwOMVP!X
pHhJdBGOmtnjvVpMLBX3Jy81D0wsHT%Dk&Kd9^{0q-Wg&Z0|3#tFC_o~

literal 19799
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
S
z+!D?$=3D~Q&*R&Z_w=3DT>woy0aC|RybSfRCMRoaBdCf)^sYma~n9ffpZ%=3D72UZloZG^=3D
zEuD()Y=3Dg56&Ney~-8lu$DR54qQ_-E<!MPor+tI1$&h6pc9?tFQRCMPKaP9!-4s<HI
zb4NILgmXta72T;>Z#&;kg>x#MitgMA&Yj@giB3g#?hNP7aPCZ}qC2O-IStNfbSk=3DY
zI-JwtoKB~rJ9mL|7dUsJQ_-C>;G6;H3_2CvxhtHz!nrG*itgME&fVbLjZQ^(?hfbf
zaPCg0qC5A1a}PN8pi|ME?Qpik*-odTJNJZhPdN9aQ_-C>;hYKQOga_axfh&!!MPWm
zitd~R=3DPWp9(W&Upz2V#&&b{eWbmu;B?gQsObSk=3DYUpV)Lb6+|Y-MJr}`@y*%or><9
z4d-k)XVa<Z&i&!sAI|;hRCMP7a2^2X0dy+5^FTNcg!4c;72SCdoCm>q5S@zdJQ&V{
z;XIg5MRy(o=3DOJ(&LZ_lT=3DfF7!&N*}{x^pg^bK#szr=3DmOO!8s4kd2}ke^H4Ysh4WB4
z72SCloQJ`A7@dmlJRHu$;XIs9MR(4Jb3UB&=3D~Q&*5pW&>=3DMi)&y7NdlkA(9`Iu+e{
z6r4xFc@&+B?py%p0yr1Ysp!t5;XE47qv=3D$1=3DP_^|1LrYxD!TJnIFE(%SUMHmc^sU_
z!Fe2=3Ditaof&g0=3Dco=3D!z~o&e_waGpS?qB~E7^F%mLq*KwIC&76VoF~z#=3D*|u}JK*e=
~
zQ_-C#!+A2CC)26u&Qst#1<q6GRCMR5aGnb1sdOs3^E5b5gYz^x72SC{oTtNiI-QE{
zJOj=3D%;5>s)MR%SF=3Db3PxNvEPa&w}$TIM1R}(Vb_*c{ZG9)2ZmrbKpD&&U5HgbmzHn
zo(t!>bSk>@JUGvT^E^5g-Ps9eC!C#hD!TK0IM0Xkd^#1~c>$akz<B|kitfA+&I{qZ
zkWNK+cEQ;NXBVA{?z{-ji{QM7PDOWK4ClpgUQDN=3DJ1>Fr5;!lRQ_-E5!g(p2m(r=3D|
z&dcDu49?5wRCMR%a9$4Q<#Z~#^9nexfb$AE72SCyoL9nmC7p`yyb8{%;Jk`XMR#5e
z=3DhbjtO{bzeuYvO#IIp2o(Vf@Ac`cmR(y8dq>)^Z&&g<w@bm#SOUJvK>bSk>@1~_kk
z^9DK<-FYLNH^O-%or><f3C^3~yopXlcis%=3D&2ZjKr=3DmM=3Df%6tPZ=3DqAsowveyE1b8=
|
zsp!tz;Jgja+vrqu=3Dk0Lb4(IK3D!TIyIPZY-4muUxc_*BA!g(j1itfA%&b#2ei%vy%
z-VNv7aNbR)qC4+_^By?wp;OVF_riHEocGeH=3D+67#ybsR%=3Du~v){czq7=3Dlygly7K`z
zAAs`#Iu+gdAe;}v`5>K&?tBQ&hv0mOPDOV<4CljeK1`>gJ0F4b5jY>AQ_-D|!ucqi
zkJ72=3D&d1<<49>^sRCMR#a6S&_<8&&z^9eYgfb$7D72WwHoKM2}B%O-xd<xE|;CzZs
zMRz_8=3DhJXLO{bzepMmokIG>?Y(Vfr2`7E5z(y8dq=3Diqz}&gbY<bm#MMJ`d;fbSk>@
z1vp=3DT^94E;-T5M%FT(jEor>;!3C@?`e2Gp)cfJhg%W%F-r=3DmMwf%6qOU!hacov*_A
zDx9y<sp!tv;Cv0v*XUGq=3Dj(934(IE1D!TIxINyNt4LTLw`6iri!uckhitc<1&bQ!v
zi%vy%z76NwaK25aqC4M#^Bp+fp;OVF@51>mobS@9=3D+5`xd=3DJj|=3Du~v)`*6Mw=3DlgU=
j
zy7L1#KY;TCIu+gdA)Ft=3D`5~Q(?)(VOkKp`>PDOWq4ClvieoUvLJ3oQ*6F5JiQ_-ED
z!uctjpVF!5&d=3Dcd49?H!RCMR(aDEQw=3DX5H%^9wk?fb$DF72WwIoL|EEC7p`y{0h#m
z;QWeCMR$G;=3Dhtw4O{bzezk%}`IKQD&(VgGI`7NB^(y8dq@8J9n&hO|{bm#YQeh=3DsO
zbSk>@2RMI#^9MQ=3D-T5P&Kf?JVor>=3DK3C^G3{E1FQcm53L&v5=3Dsr=3DmN5f%6wQf1y*=
+
zoxj5QE1bX5sp!t%;QS5F-{@3y=3DkIX-4(IQ5D!TIzIRAk24>}dy`6rxz!ucniithXi
z&cERNi%vy%{tf5faQ;oFqC30c?1r<OPQ|RVbzXg;{>K>mzG<p_T=3Dx5<dTrE0J^Ce!
zGY|4uF3LX0BRuGX>q>jJH8(XUa;0+Le+^$&{l7{rA5$v3j-_&6*Zyy%R){H;UB^<n
zZ*Bj#QY*%k%C5_mDlKVCRaZq_{nW5ztX@hd^bgNHiHe%4CypCX*DE>e$i7jJKH3sR
z`Y@s>am0`)>XQhI`d8B3{r5)M#qKq=3DCDErKo76hfyjxon(Sp^iPo}{fy>^Fx`R2Kw
zVg2l=3D>;G-fMa>f%8>6CBOH)HsI<9xygyvM?f*Db&W^zSmU9XO50|q5aTGMY-{xV|t
z*i$FZs=3D9Z>S9V%3BUz{hBlWXLKP%fq2zA0jWhiw(cu9^3ubm|)bxcnjq%9Sh))k$D
zPwL3G%dRd78{0$Uu)b@?`Ter%!%ix?W|XecR@0m=3D>|7>$G|#T{*hkH4@1H(#$mi)L
z9!RA-dw1-jH?Sa)2rqj0OL0?Ud0X~N)vfc=3Dg-x~jN7ZCUPI!h)_ywp;mjCNx$_xp8
zNF&DPKAzl<lJGM;Sf;*c>ovnub~dT4(JmG}Vy7Z}r8|6qTN`rqv%g>kiB+;)=3DhQao
z8{ZmOMZJ@St#gY*Ow~5mHk6f)YO9^p(z`u`DV>8m4w#aN5?ilT5cZR<YfPn^Q{y{J
zv^v>CXMp*QlbfoOb6V$(Uo3klYEqLul;Eo>ADugr^wiz<m^r&_+8(pocinsEvYAu&
z+GFpTJ51dxcX$h*x6>>C)SNkWjp?RvguQwvhqlfe+pw^HDz1J_eL7vX<J5hoXKJQv
z#y2GkTIa61=3D)h}2y@GU8bwin6>h#hOmKwCwxJ6r8>)e(9(Y7iYn@ra>w<Xf`<C_!d
zru3vlx^~mHMC;tLf3z$}hc_-gp>~p9np0(^gTiBhA`OLb98p))l`L*eq#IJ3MWt0e
z!y9PZ+M_A0%Y|*--4|?d%9PNfeM%_UIjAGM=3Daz9>PD!+94&(g6ouwVwLkVk>1zN2G
zn>i&hrFErHq$^RnM!KoFC1GXT&zKfv3Kn-{JnhN;`PNfPtA?gE{CejPA>Xzr-86dC
z!a=3D$4tdbjm(chVq$D-3mE_Tn37KDz;eme4o?BYNz)@2u0Y^cqzT~&*@wS&`DTjbgf
z(_&qF_;^C6u+R_+X`!JmbO;L#p~%dzIxK{~A!Ig(-kqhVgmq#2%#ahAl>;&>6SEes
z2}=3D!OTSI3}ua2-f61j3@c+NrQ6uXcdsDT}b8D8bcWK!kZWYS_k_025~)&aG(hdqbQ
z?V)(s*dC5EY|4E?q1(d6(W6S2*Z4~({`mp4hf%rcV_I1QtEKQ?ji!e|*S<>_b=3Di`o
z%W904_xM-C%+Sp?(OIZxx-mSDDx4w8_bU&Nc+k0{Pt~)1=3D9Fgt{&a;w5w<Ibq1+Y5
zR4(gimGzp*19XmVDF{aw;<V|zsE3Xq?5{ktCbv8N5zp-|JmKqqzB~P)&+RUpVE=3Dc!
zD_uFQU&J1r$&P8!{P3<$4~vPgSTVh`xMP}5ky;)(y>;G*aH?E%>PnTTbYu&kwGsUX
DDbP3`

diff --git a/tests/data/acpi/virt/DSDT.numamem b/tests/data/acpi/virt/DSD=
T.numamem
index d0f3afeb134fdf1c11f64cd06dbcdd30be603b80..d6f5c617881c4247f55d4dcd0=
6581f9693916b2f 100644
GIT binary patch
delta 156
zcmbO?fpNDcmrJlq$Zin^2BwP>xulufJQ*iyC^K43^tIeLL4lLWeZ}O>oO+X=3Db6T<Z
z6mvCfR_C%{pDgc^#>hCi&BajKi^V<I(}*M9!_$Q~z%RhS*}#o~BR<sAg^OwOMVP!X
lHhJdBGOmtnjvVpMLBX3Jy81CrwsAkqC^^YPgaxRb0RT`TDiQzy

literal 18462
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
A00000

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bi=
os-tables-test-allowed-diff.h
index 32a401ae35..dfb8523c8b 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1,4 +1 @@
 /* List of comma-separated changed AML files to ignore */
-"tests/data/acpi/virt/DSDT",
-"tests/data/acpi/virt/DSDT.memhp",
-"tests/data/acpi/virt/DSDT.numamem",
--=20
2.19.1


