Received: from eggs.gnu.org ([2001:4830:134:3::10]:37954)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1dnODF-0000WI-JU
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 08:04:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1dnODC-0004jP-Rz
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 08:04:45 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:7808
	helo=heian.cn.fujitsu.com) by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1dnODB-0004il-Vd
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 08:04:42 -0400
From: Dou Liyang <douly.fnst@cn.fujitsu.com>
Date: Thu, 31 Aug 2017 20:04:27 +0800
Message-ID: <1504181068-17822-3-git-send-email-douly.fnst@cn.fujitsu.com>
In-Reply-To: <1504181068-17822-1-git-send-email-douly.fnst@cn.fujitsu.com>
References: <1504181068-17822-1-git-send-email-douly.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v5 2/3] ACPI/unit-test: Add a new testcase for
 RAM allocation in numa node
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: ehabkost@redhat.com, imammedo@redhat.com, mst@redhat.com, rth@twiddle.net, Dou Liyang <douly.fnst@cn.fujitsu.com>

As QEMU supports the memory-less node, it is possible that there is
no RAM in the first numa node(also be called as node0). eg:
  ... \
  -m 128,slots=3,maxmem=1G \
  -numa node -numa node,mem=128M \

But, this makes it hard for QEMU to build a known-to-work ACPI SRAT
table. Only fixing it is not enough.

Add a testcase for this situation to make sure the ACPI table is
correct for guest.

Suggested-by: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Dou Liyang <douly.fnst@cn.fujitsu.com>
---
 tests/acpi-test-data/pc/DSDT.numamem  | Bin 0 -> 5104 bytes
 tests/acpi-test-data/pc/SRAT.numamem  | Bin 0 -> 224 bytes
 tests/acpi-test-data/q35/DSDT.numamem | Bin 0 -> 7788 bytes
 tests/acpi-test-data/q35/SRAT.numamem | Bin 0 -> 224 bytes
 tests/bios-tables-test.c              |  24 ++++++++++++++++++++++++
 5 files changed, 24 insertions(+)
 create mode 100644 tests/acpi-test-data/pc/DSDT.numamem
 create mode 100644 tests/acpi-test-data/pc/SRAT.numamem
 create mode 100644 tests/acpi-test-data/q35/DSDT.numamem
 create mode 100644 tests/acpi-test-data/q35/SRAT.numamem

diff --git a/tests/acpi-test-data/pc/DSDT.numamem b/tests/acpi-test-data/pc/DSDT.numamem
new file mode 100644
index 0000000000000000000000000000000000000000..bc703d77ee48720af1b801c518b43511c95c852d
GIT binary patch
literal 5104
zcmb7IZExE~5}qX~n_5aXWizjC8^LKVXmL&SlDFc3gC$b76k9SQ%DEh9oG8b|DMfK1
z(gvt&6i`&ab^ERG<!~RBK%e8E(EADf3B7-C=%I~2Rh=QVvMQTEE5Ovw&ckPBc4uct
zwj8VRzj**QUtBlKPP+KOHZ7cE06=5<)+@>;xE-sw(qx*XF!z}jjPX%ajXzq&jTQFq
zw)Zd3`{YZHwS3rmsXyOp`CsgNTR@<vTR!JB&=;FdvFUafY_pP4o8^j?D166dwOO$0
zpf)!u7SpS0h$*RMyVMXMh9Fd<8)dsug#^HNKWm`4&vcUK@0V&;+OAv8v~jEHGz#F;
zjOWu->obq*UN7;@fd>bkHW>7wH}lOw3;x+kz<+;?^`Xya)uvf@QYk*O7srT^929^Z
z(63x0Z^&J@d%=E?%?G|FWMJruoz0sP@PWP*8-tlj#VIsH94;*3Ze&b}dmP>U!{4qE
z3%v<Yz7ErCcB#hT4#;MK2C`YiFWtO!T^5Fk&F#KdZ<t6LE}4dlMgE@WXI7XGKIqaS
zuod<Mo`5v918(>BYS9|OW!Z=at1=2Sc+mq77{0X)+xWdGVZ3hlYIS{M^y2LN<clhg
zErL$Kg1T&(qfMM1dbGgLudpBFA7oHg*lYPUF4W=@ysHG<+2u96AU1p1s?4Qz;4!|=
zGmIZ{iC@9LIljOL{3HGopXI9BT((N7bKIab9REltxZOXm*^QB}3K-|Zt*0gRdQ-UF
zeR!daV%B+bg?%c2Dy!;ZC-A4FnCsQ7SkxE`Gf>dbhD6aE$wxA%i+Vt_Of<O(8ZM1^
za7QC~q$3G=ROHdi>TwcvY}08l4PJ2-Q=9}7b8sV#4=e3<oYGx9is~!MD2)WOm?_;w
zMX^?`GffW_B$&n8Mm6oS;+nY%#ueKv-Id(SBn<|Bo0R?zdj#~ldzGg9px5vS6`T4h
zr?fXL-n8ot@aLqC=R@mdG5);8JN{=aF2R<+`=qr6T!x1|{oo;j;&^P<YO5A(_uf8u
z$a<-R7FR~o4s5?jj-&#DQU?#YG@2<6XXMe03ETeXJ6l`_Jh-sG4dCy#(BA$w1Alwp
zYr)f2-*cb6eO)GR>8#LcV|M*sM#V>#9yxmCRb#$#4_CDp-{qY)9{PBnYsRh0J+mH1
zKs}S1;o4VI5D$`V2fn5`9>Zs)r#)|D%xxO?Y1-|sO=Fmt%;AAdU;&}>q~cmRsk40k
zs~L#PG0akqe;WSnfH51ML2`oJGg3{f;=t!L=AB?>mQFSF$)!L(*L3O*`??)^fz_;D
zq4}Zp;)Hd~-`{LKJ7zr_SkIz=<JPmr>DIGuw@R^_6V|!(JIv?C%;y60xe4>R2=lq2
zd27-<UJ$=I`uv#rd|*C5VLl&WKJRwd6^!1QG_Qo_MGDa^f?F=iu4YUHn{8;}8k4Iy
zMZ2r7-wrQ4lW!gueY;*7nc!1FawScBBVB&{iT}~lzo(yk@bTlPPab~oF}TdM*H(w+
zH_7=5gF`rE39QkWR6!Lv<O%oLWfBUIHtE7KD>a9i_3C|w1tG&gG0m!lrDl#mvgwr8
z(ulMQjkJ+yR%#X12by%d#rHOYDuup;{v`{hUCCs!8S)^!&tpc)Y%Kp(>hXg%?3tNN
z=8;jJ!WveHyO%ewE8=3K7|D04M3d8K%m=S`@nBLx-urykbFZGztgZGvqZ*@#exD&W
zNreoj@*CwD(=lsmR2a;AS<ntVyppk0PLkpZ_g0h>0R=mO%QXqd#b^Er&k*f1@5QRp
zE1#qa_VaWqE}!H=IC7mHXf<xGJB>tCpr`KF31=~4|IsON`COWuCFqBfleh$@dgp$z
zs!&?t8N&}|D5jR$rv$?!tQHz6jjNzi?}b{eNf}N_0me)dgVHE6Xg~T8Pway#7z>!u
zD|V?_%H(j*g0_pYn>JcsS4b6{^<koCZh`SWVzWSNGiuVp8+B~LHfw?Nze4DxRCs*o
zt_oYY;xzxqei9_?Xz??k2exEKiK7Hlah_qTiJ#Y~K1z(_B;JJp|NrtFK&YpCW-y?8
zhCUJm8qqYVgTc2yhnoNVM6H{tU{GP}mb7bjrhq|(C5Gn5Y74gFjRMy~PlMX>{o(hA
zOd*oHie0wr;nMt?1cN)JPMzd}SMZ7%*!jG(iRPVrb8bpu=roRRH0M+WyFu*pP`XJP
z3PAtU@$$LdYs-HzmqQ2cm8u(<5II6mc&x|t7*#{P<ZlLjP4#iG`b8`;7>4F#GT1}X
z4-mKeu9F=KxZV;N$d<LRi=;tL4DvK^yYD#JJNTlrQ5*h%!B=E3=7MyiK8p;HnxHwN
zB`97KXbPd&u0}uwYfM06QP8|##S0>2or;7C)@cEqj)LA0tk`~stZF1wu*L;69tFKA
zSh;}mNT^`N#0wqJqM)|~YeGO1kx;>!6wqW8^tND~5zv`Ps9?ngF!Xgc3VKJd>H?}q
zLIrC|KvPlB_XX>mfX+oi1?#+k&PPEDf)z7A49kdw3f40MdL{~56s%_j^lT(lu$~jp
zb5T%Ju$~vt^N~=&dO<)hL_saVdQm_xMnVPaf`BeWK}&-54FP>45-M2V6wo)Lpv!{w
zEdhNi5-M0P3FxKMphkJYx?gKZy~J)C@6tW0b&mo;M**u@D5Oacnk5vlB88d`38YEx
zwl%zn_Z%!MLrEfOq*GAB;xN>at(zkq8N(w!)RDDYBORH;gF4iaz1yUl-ECua#am?0
z!2>5`yhl(z*5hrm=it#1dTbU@KGy3b;~^0GbRZw=mq^BR7Wz&gAM1mNF)@W6FOxmT
z9Me<Om|`P6#chr0DRNAfkv>iGn0^Um-1d>aLo(`(OVoJae}w3#J#8W0bsKCru(<pS
DEH%hI

literal 0
HcmV?d00001

diff --git a/tests/acpi-test-data/pc/SRAT.numamem b/tests/acpi-test-data/pc/SRAT.numamem
new file mode 100644
index 0000000000000000000000000000000000000000..dbc595d9cb85d3fcb5a4243153f42bb431c9de8f
GIT binary patch
literal 224
zcmWFzatwLEz`(%x#mV2<BUr&HBEUHqD8>jB1F=Cg2*ZH@DxXmUE`z~9*2k!U%mXRq
Yf~!ZCL8t>-1O^}2VG2>z!9?-X08OU~0RR91

literal 0
HcmV?d00001

diff --git a/tests/acpi-test-data/q35/DSDT.numamem b/tests/acpi-test-data/q35/DSDT.numamem
new file mode 100644
index 0000000000000000000000000000000000000000..fcb18d947b28c09c8b5a4fa65692efb41ef3a5d9
GIT binary patch
literal 7788
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
EKkzjyY5)KL

literal 0
HcmV?d00001

diff --git a/tests/acpi-test-data/q35/SRAT.numamem b/tests/acpi-test-data/q35/SRAT.numamem
new file mode 100644
index 0000000000000000000000000000000000000000..dbc595d9cb85d3fcb5a4243153f42bb431c9de8f
GIT binary patch
literal 224
zcmWFzatwLEz`(%x#mV2<BUr&HBEUHqD8>jB1F=Cg2*ZH@DxXmUE`z~9*2k!U%mXRq
Yf~!ZCL8t>-1O^}2VG2>z!9?-X08OU~0RR91

literal 0
HcmV?d00001

diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
index 564da45..f092315 100644
--- a/tests/bios-tables-test.c
+++ b/tests/bios-tables-test.c
@@ -808,6 +808,28 @@ static void test_acpi_piix4_tcg_memhp(void)
     free_test_data(&data);
 }
 
+static void test_acpi_q35_tcg_numamem(void)
+{
+    test_data data;
+
+    memset(&data, 0, sizeof(data));
+    data.machine = MACHINE_Q35;
+    data.variant = ".numamem";
+    test_acpi_one(" -numa node -numa node,mem=128", &data);
+    free_test_data(&data);
+}
+
+static void test_acpi_piix4_tcg_numamem(void)
+{
+    test_data data;
+
+    memset(&data, 0, sizeof(data));
+    data.machine = MACHINE_PC;
+    data.variant = ".numamem";
+    test_acpi_one(" -numa node -numa node,mem=128", &data);
+    free_test_data(&data);
+}
+
 int main(int argc, char *argv[])
 {
     const char *arch = qtest_get_arch();
@@ -830,6 +852,8 @@ int main(int argc, char *argv[])
         qtest_add_func("acpi/q35/cpuhp", test_acpi_q35_tcg_cphp);
         qtest_add_func("acpi/piix4/memhp", test_acpi_piix4_tcg_memhp);
         qtest_add_func("acpi/q35/memhp", test_acpi_q35_tcg_memhp);
+        qtest_add_func("acpi/piix4/numamem", test_acpi_piix4_tcg_numamem);
+        qtest_add_func("acpi/q35/numamem", test_acpi_q35_tcg_numamem);
     }
     ret = g_test_run();
     boot_sector_cleanup(disk);
-- 
2.5.5
