Received: from eggs.gnu.org ([209.51.188.92]:43364)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1hB47j-0004Nc-Tb
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:05:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1hB47g-0005Us-Bp
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:05:43 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41080)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1hB47f-00054N-9t
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:05:39 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x31L4xdP140423
	for <qemu-devel@nongnu.org>; Mon, 1 Apr 2019 17:05:07 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2rksqasqq5-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 01 Apr 2019 17:05:05 -0400
Received: from localhost
	by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 1 Apr 2019 22:02:04 +0100
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon,  1 Apr 2019 15:59:08 -0500
In-Reply-To: <20190401210011.16009-1-mdroth@linux.vnet.ibm.com>
References: <20190401210011.16009-1-mdroth@linux.vnet.ibm.com>
Message-Id: <20190401210011.16009-35-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 34/97] tests: update acpi expected files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>

From: "Michael S. Tsirkin" <mst@redhat.com>

Fixes: dbb6da8ba7e ("pc: acpi: revert back to 1 SRAT entry for hotpluggable area")
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
(cherry picked from commit d2a1b1d602986a5f02658f6d4fc9ed422f8ddebf)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 tests/acpi-test-data/pc/DSDT          | Bin 5144 -> 5131 bytes
 tests/acpi-test-data/pc/DSDT.bridge   | Bin 7003 -> 6990 bytes
 tests/acpi-test-data/pc/DSDT.cphp     | Bin 5607 -> 5594 bytes
 tests/acpi-test-data/pc/DSDT.dimmpxm  | Bin 6803 -> 6790 bytes
 tests/acpi-test-data/pc/DSDT.ipmikcs  | Bin 5216 -> 5203 bytes
 tests/acpi-test-data/pc/DSDT.memhp    | Bin 6509 -> 6496 bytes
 tests/acpi-test-data/pc/DSDT.numamem  | Bin 5150 -> 5137 bytes
 tests/acpi-test-data/pc/SRAT.dimmpxm  | Bin 472 -> 392 bytes
 tests/acpi-test-data/pc/SRAT.memhp    | Bin 264 -> 264 bytes
 tests/acpi-test-data/q35/DSDT         | Bin 7828 -> 7815 bytes
 tests/acpi-test-data/q35/DSDT.bridge  | Bin 7845 -> 7832 bytes
 tests/acpi-test-data/q35/DSDT.cphp    | Bin 8291 -> 8278 bytes
 tests/acpi-test-data/q35/DSDT.dimmpxm | Bin 9487 -> 9474 bytes
 tests/acpi-test-data/q35/DSDT.ipmibt  | Bin 7903 -> 7890 bytes
 tests/acpi-test-data/q35/DSDT.memhp   | Bin 9193 -> 9180 bytes
 tests/acpi-test-data/q35/DSDT.numamem | Bin 7834 -> 7821 bytes
 tests/acpi-test-data/q35/SRAT.dimmpxm | Bin 472 -> 392 bytes
 tests/acpi-test-data/q35/SRAT.memhp   | Bin 264 -> 264 bytes
 18 files changed, 0 insertions(+), 0 deletions(-)

diff --git a/tests/acpi-test-data/pc/DSDT b/tests/acpi-test-data/pc/DSDT
index 99f05a502752d9dbac38fdd93f1ebb79b4564fb4..c6adfe32d5ba6a5db2ca3e210766839547e122c8 100644
GIT binary patch
delta 45
zcmbQC(XGMd66_MfEyBRSxN##_B|DRk+2mIC)lB}{n~gYHnHVi5@8r_l{EkbD695z3
B42=K)

delta 57
zcmeCyn4!Vt66_KpA;Q4G7`~CKlAX!Zd~z%MY9=3@%|;xpOiZpUlXq}wa&gDIdKoY}
L1BuP|xpX)Iow5#g

diff --git a/tests/acpi-test-data/pc/DSDT.bridge b/tests/acpi-test-data/pc/DSDT.bridge
index cf23343e6402421f09da5d09f72811108fbd2661..f01fa3ad4ee6aed5262daef464a1ade41e06975d 100644
GIT binary patch
delta 45
zcmca@cFv5;CD<jzPnv;&@z+MKN_Hk6v&pUOtC{?@Hyd%ZGBH|A-pQr8`5jlT002W>
B4h#SQ

delta 57
zcmX?ScH4~0CD<h-TAG1@aluBeN_Hks^U1C3tC@UsHXCuYGBLTbOy0qz$;BP->Se&_
M3?w$+=gJoV0Nbw*^#A|>

diff --git a/tests/acpi-test-data/pc/DSDT.cphp b/tests/acpi-test-data/pc/DSDT.cphp
index c99c49f43705e99d1e0a8ba19d44145dfa63d009..3295d81c7f725472671632ac612a1c3ed81d7492 100644
GIT binary patch
delta 45
zcmaE^eM_6mCD<k8mM8-QqxMFwN_Hmi;K{A*tC{>fHXCsqWMZ_N{FO^{vljPWE&xQw
B4gvrG

delta 57
zcmcbm{al;NCD<k8xhMkz<He0!mF!F&A(LC#S2KBgZZ_gL$i(E$GWiRaCKq?StCs<z
MGmzLU&Ap!s01Y4z>i_@%

diff --git a/tests/acpi-test-data/pc/DSDT.dimmpxm b/tests/acpi-test-data/pc/DSDT.dimmpxm
index 38661cb13ee348718ab45bfc69452cd642cf9bb9..f6ec911b1180a409e61ef8d50279ab6dba7f1bdd 100644
GIT binary patch
delta 45
zcmbPi+Gfh-66_MvCdI(OXt<H9lAX!LV{$9|Y9@Ev%|;w6m>BIQ-{I2SEXdu&4*(kq
B41fRt

delta 57
zcmZoOooveG66_K(S&D&y@%l!tN_Hkk&&jRqtC?KvHXCuQU}ExSnS7f|lZ!jv)ysg<
M8Axnq;%?yw0M!W(X#fBK

diff --git a/tests/acpi-test-data/pc/DSDT.ipmikcs b/tests/acpi-test-data/pc/DSDT.ipmikcs
index 5e970fda7296f9ce44487e0a578a1dead982ba66..2633a8cecf017bfce01ba8377428b8c5433e0be2 100644
GIT binary patch
delta 45
zcmaE$aan`QCD<h-ScHLr(QG5vL3Sn|v&m=KS2Ou*Z?58KWn#3L%*d^|*^FC@696%Z
B3{(IB

delta 56
zcmcbt@j!#iCD<h-L4<*U@y<rBgX~P6=9AB|uV(Vm*<8iZ%EaW#GKpK0i#y)c%Ye}t
LNNiT;*5L#I;W7_A

diff --git a/tests/acpi-test-data/pc/DSDT.memhp b/tests/acpi-test-data/pc/DSDT.memhp
index 1fe6871aa245277e0562ff0a1e93a9bf3bcf2295..e31ef502968b14e2146cb1a1328dc0ce555b1d7f 100644
GIT binary patch
delta 44
zcmaEB^uUPACD<h-L6U)i@z6%DN_Ix4$t~<_m|S%>8*#KUG1^Vu$)&mZ9alXc05=~E
A%m4rY

delta 56
zcmaE0^wx;WCD<h-SCWB&F>)hUB|D@4<QDcdOisF+jW}AFn7mmg@8Htp;*NLqGGKHD
L5}WUHHSz%f%cl>u

diff --git a/tests/acpi-test-data/pc/DSDT.numamem b/tests/acpi-test-data/pc/DSDT.numamem
index 224cfdd9e983e02dac5f4bf7e210eaa64cb0dc78..71a975b3e25f8b5cc4491f16d5575a3a35afc777 100644
GIT binary patch
delta 44
zcmbQIF;RodCD<iIP=tYjF?u6cB|D?j<QDcdOs+bcjW}AF80{wS<kH;yj>~`(00AKk
A3jhEB

delta 56
zcmbQJF;9cbCD<iIPK1Gh@zX}GN_Iy7$t~<_n4EMs8*#KUF?q90-od5G#U1bJWx(hR
LBsSmYGU5aPu8j`#

diff --git a/tests/acpi-test-data/pc/SRAT.dimmpxm b/tests/acpi-test-data/pc/SRAT.dimmpxm
index 5aa6f693ef9819b3d30cbd76cafb0ee8b5fc5534..f5c0267ea24bb404b6b4e687390140378fbdc3f1 100644
GIT binary patch
delta 58
qcmcb?+`-Hh9OM|%!N|bC*szf+f>Di`0S16#An*f1F)$!x7#IKwZw2lE

delta 138
zcmeBRzQN2D9OM{sgOP!Oao0w!2*xrX3kskt4j7*q#sJcc8cZ-A2f8|Tm<(7QMA!fS
P|G$IOAxvjrKsFBmfb|MK

diff --git a/tests/acpi-test-data/pc/SRAT.memhp b/tests/acpi-test-data/pc/SRAT.memhp
index 5de8a100a4adf968b79a7b154a7f98123d583474..e508b4ae3cd9e3000209a4f9597913faa4206ec1 100644
GIT binary patch
delta 51
pcmeBR>R{pu4ss0PU}RumTr`pEo&p09068G=141z{FvA!?8UWLX1)2Z=

delta 51
pcmeBR>R{pu4ss0PU}RumTso2Kp2GkC|Gxt{3?K{x%rFL!1^_r@2$}!@

diff --git a/tests/acpi-test-data/q35/DSDT b/tests/acpi-test-data/q35/DSDT
index aa402cca667f82ed0a2dc4969508d8f6e38ad910..7576ffcd05991ad5a3901c0f7698a52fffc6d6e2 100644
GIT binary patch
delta 45
zcmbPY+iuI{66_MvF2}&Y*szhySdz)dY_h%NY9@c}&2J=InHVi57t3gFULo^_5dbFH
B4Y>dS

delta 57
zcmZp-onp)766_K(MUH`iQEelau_TkH`DA;^)l5D*o8L&bGBLTbOfHhq<l>HZ^)g^|
M1`?ZR%DiI)0Jy6Uq5uE@

diff --git a/tests/acpi-test-data/q35/DSDT.bridge b/tests/acpi-test-data/q35/DSDT.bridge
index fc3e79c583ababf5615e76ba2f7bc3df1483abb4..c623cc5d72a2e346793fa9128e7e88b6781241b2 100644
GIT binary patch
delta 45
zcmZ2#JHwXCCD<ioh8zO}qryfmV@W0-v&r_7tC{?@H@}f=Wn#3LTr8uxd4<ehMgSw1
B4V?f0

delta 57
zcmbPXyVRD;CD<iosT>0X<FSog#*$2)=9BFuS2OwOY<?rz%EaW#GPy`blZ!jv)ysg<
M8AxoNDf6EZ0Nzayh5!Hn

diff --git a/tests/acpi-test-data/q35/DSDT.cphp b/tests/acpi-test-data/q35/DSDT.cphp
index fd3cb3421814d0383863dc780d9a2a9077b727a3..7ac526e4669fd84048b2d8ec6af8661503e1a9fa 100644
GIT binary patch
delta 45
zcmaFtaLs|sCD<h-Oo4%c@#jV^V@W3O;K}xqtC{>fHouWP$i!$jdA*G0<|i`s%m7rz
B4=w-z

delta 57
zcmccS@YsRNCD<h-S%HCpasEawV@W2DkjeIvtC_q#H@}fQ$i(E$GI^bhCKq?StCs<z
MGmzMPRi=>{0Qw9O7XSbN

diff --git a/tests/acpi-test-data/q35/DSDT.dimmpxm b/tests/acpi-test-data/q35/DSDT.dimmpxm
index 14904e8ea2376abd989aa9e99f5bf388a3b85032..3837792dec13c4c77c66b140f68959d86a09de8e 100644
GIT binary patch
delta 45
zcmeD8YVzW833dr#Qe|LZe7KRzSdz)bW3s*EY9@Ev&2J=EFfrOqo+hKY`Lv7+2LLB$
B4UPZ+

delta 57
zcmZqj>i6Pu33dtLS7l&eY~RRbEXm~PIoV!vHIs|o<~Ncnn3%j-CQp^o<l>HZ^)g^|
M1`?b1$hdI;0KEDScK`qY

diff --git a/tests/acpi-test-data/q35/DSDT.ipmibt b/tests/acpi-test-data/q35/DSDT.ipmibt
index 332237529e114256384c051858fdac36b024c72e..c7f431f058bcb54e364be4edfd9d4609bc9bb602 100644
GIT binary patch
delta 45
zcmca_d&!o|CD<k8k{kmA<I;^>b&^azW|O-lS2Ou*Z#I`|Wn#3LyiZ1R^Jkeii~v_f
B4>te+

delta 57
zcmca)d*7DJCD<k8z8nJsqxVLxI!Pu^^T}P3tC@UsHk(VeGBLTbOx`P_$;BP->Se&_
M3?w!`k$J}m0QWEvAOHXW

diff --git a/tests/acpi-test-data/q35/DSDT.memhp b/tests/acpi-test-data/q35/DSDT.memhp
index f0a27e1a3093ff7525f62b7509ea44dfe9eb8908..8fba0baf79de0239f2630035afeee78f3e7f43c2 100644
GIT binary patch
delta 44
zcmaFqe#f25CD<k8jxqxS<HU_z#*&OqlkFteFuCe%ek0k+#Ar9USVnX63K>Us07u#l
A`2YX_

delta 56
zcmccP{?eVxCD<k8r7{BpqsB%qV@XE;$##-!n4EMszmaTZV)AC0TqL8(#U1bJWx(hR
LBsR~Kab^bq<X#Wr

diff --git a/tests/acpi-test-data/q35/DSDT.numamem b/tests/acpi-test-data/q35/DSDT.numamem
index 8c9fa445b0119b6f67533cb968855b41fb9925d9..6c0d4f2bcb384cc3f3919b7472021ed51b93cbf5 100644
GIT binary patch
delta 44
zcmbPb+iT0^66_MvE62dVsI`&HSd!6cvYq4_CRd%!ZzNlp80{t(%V=(1A@hk502A8{
AHvj+t

delta 56
zcmeCRon_1A66_K(OOAno@!&=-V@XE;$##-!n4EMszmaTZV)AC0TqL8(#U1bJWx(hR
LBsR~K`N9YQ$wLqz

diff --git a/tests/acpi-test-data/q35/SRAT.dimmpxm b/tests/acpi-test-data/q35/SRAT.dimmpxm
index 5aa6f693ef9819b3d30cbd76cafb0ee8b5fc5534..f5c0267ea24bb404b6b4e687390140378fbdc3f1 100644
GIT binary patch
delta 58
qcmcb?+`-Hh9OM|%!N|bC*szf+f>Di`0S16#An*f1F)$!x7#IKwZw2lE

delta 138
zcmeBRzQN2D9OM{sgOP!Oao0w!2*xrX3kskt4j7*q#sJcc8cZ-A2f8|Tm<(7QMA!fS
P|G$IOAxvjrKsFBmfb|MK

diff --git a/tests/acpi-test-data/q35/SRAT.memhp b/tests/acpi-test-data/q35/SRAT.memhp
index 5de8a100a4adf968b79a7b154a7f98123d583474..e508b4ae3cd9e3000209a4f9597913faa4206ec1 100644
GIT binary patch
delta 51
pcmeBR>R{pu4ss0PU}RumTr`pEo&p09068G=141z{FvA!?8UWLX1)2Z=

delta 51
pcmeBR>R{pu4ss0PU}RumTso2Kp2GkC|Gxt{3?K{x%rFL!1^_r@2$}!@

-- 
2.17.1
