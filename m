Received: from eggs.gnu.org ([2001:4830:134:3::10]:58885)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eF2Gy-0003b4-Jx
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 13:18:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eF2Gx-0003Q0-19
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 13:18:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52092)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1eF2Gw-0003PS-OF
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 13:18:50 -0500
Date: Wed, 15 Nov 2017 20:18:47 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1510769835-31902-8-git-send-email-mst@redhat.com>
References: <1510769835-31902-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1510769835-31902-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL 07/10] tests/acpi-test-data: update _CRS in DSDT
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>

commit dadf988e81b15065ac1d6dbaf4b87b5b80c7b670
    hw/pci-host: Fix x86 Host Bridges 64bit PCI hole

Added a 64 bit hole to _CRS of PCI0.
Update the expected files accordingly.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/acpi-test-data/pc/DSDT         | Bin 5098 -> 5144 bytes
 tests/acpi-test-data/pc/DSDT.bridge  | Bin 6957 -> 7003 bytes
 tests/acpi-test-data/pc/DSDT.cphp    | Bin 5561 -> 5607 bytes
 tests/acpi-test-data/pc/DSDT.ipmikcs | Bin 5170 -> 5216 bytes
 tests/acpi-test-data/pc/DSDT.memhp   | Bin 6463 -> 6509 bytes
 tests/acpi-test-data/q35/DSDT        | Bin 7782 -> 7828 bytes
 tests/acpi-test-data/q35/DSDT.bridge | Bin 7799 -> 7845 bytes
 tests/acpi-test-data/q35/DSDT.cphp   | Bin 8245 -> 8291 bytes
 tests/acpi-test-data/q35/DSDT.ipmibt | Bin 7857 -> 7903 bytes
 tests/acpi-test-data/q35/DSDT.memhp  | Bin 9147 -> 9193 bytes
 10 files changed, 0 insertions(+), 0 deletions(-)

diff --git a/tests/acpi-test-data/pc/DSDT b/tests/acpi-test-data/pc/DSDT
index 15c3135d65f168a91edfdc3471ea1d3f012a824f..99f05a502752d9dbac38fdd93f1ebb79b4564fb4 100644
GIT binary patch
delta 98
zcmaE*K0|}cCD<iILWF^VF?=IeJhzy$NQ_>5uv2`1v!?+^ymL^npaU1zoXPdvIeJ~%
d3=BNX3`l?x$o~KTe?5ps0u3Pc=GWZ+*#RA&6M_H$

delta 51
zcmbQC@k*V`CD<k8l`sPXW5q_Ucy2LQ!5F>xV5j&1XHNr;c;}#CK__;uyvg<4Ih!SU
H{<8xBdNvM&

diff --git a/tests/acpi-test-data/pc/DSDT.bridge b/tests/acpi-test-data/pc/DSDT.bridge
index d38586c95bf31f0212279a2505efd8e2fd321ccc..cf23343e6402421f09da5d09f72811108fbd2661 100644
GIT binary patch
delta 98
zcmZ2$cH4~0CD<h-TAG1@aluBecy2Lgkr=)BV5j&1XHNr;c;}#CK?g3bIg{(TbM(5j
d85nq&8IS-Ykp2Jv|9TLO1R6l>&9Awg_yJmb6N3N%

delta 51
zcmca@w$_ZxCD<iISDJx=@xVr|cy2LQ!5F>xV5j&1XHNr;c;}#CK__;uyvg<4Ih!SU
GocIB3sttqy

diff --git a/tests/acpi-test-data/pc/DSDT.cphp b/tests/acpi-test-data/pc/DSDT.cphp
index 2dd70bf9520406c36c3684714bb714e536a28d20..c99c49f43705e99d1e0a8ba19d44145dfa63d009 100644
GIT binary patch
delta 98
zcmdm~{al;NCD<k8xhMkz<He0!dc0!JA~AaL!A|i3&YlJw@y<cPf(~3<b0+)o=IC{4
eGcfQlGavy*Ap8IS|Megm2{eG%n|Ja4X9oa*yA)&q

delta 51
zcmaE^y;GaZCD<iorzish<HwC$dc0z;f-!pW!A|i3&YlJw@y<cPf==vQd6WHkb2h)=
H{m%{nhcXXj

diff --git a/tests/acpi-test-data/pc/DSDT.ipmikcs b/tests/acpi-test-data/pc/DSDT.ipmikcs
index 2796d96b0eec17fb68a79234cbccb70708ac2587..5e970fda7296f9ce44487e0a578a1dead982ba66 100644
GIT binary patch
delta 98
zcmdm_@j!#iCD<h-L4<*U@y<rB<=kS<A~AaL!A|i3&YlJw@y<cPf(~3<b0#0>&e7}A
eW?<l9W<UarK=%Lt|LZ|C5@-OiHyiW(X9oa_pA<O&

delta 51
zcmaE$u}Oo=CD<jzNQ8lb@y|xC<=kSff-!pW!A|i3&YlJw@y<cPf==vQd6SQG=WI^o
H`OgjjfCCRX

diff --git a/tests/acpi-test-data/pc/DSDT.memhp b/tests/acpi-test-data/pc/DSDT.memhp
index 53f6d5824359ff0ca20179b19b3b5cb79f017f82..1fe6871aa245277e0562ff0a1e93a9bf3bcf2295 100644
GIT binary patch
delta 98
zcmdmQ^wx;WCD<h-SCWB&F>)i<76CD5kr=)BV5j&1XHNr;c;}#CK?g3bIg_sl<mh#2
eGcfQlGavybAp8IS|Megm2{eG%n;iuIvjYHvJrphg

delta 51
zcmaEBwBLx!CD<jzUXp=<v3eud76CC=!5F>xV5j&1XHNr;c;}#CK__;uyvbJtayI7)
H{$~dOd}0qS

diff --git a/tests/acpi-test-data/q35/DSDT b/tests/acpi-test-data/q35/DSDT
index a080e2ace20ce9b88d5a61078d8caa0262617eed..aa402cca667f82ed0a2dc4969508d8f6e38ad910 100644
GIT binary patch
delta 97
zcmaE6GsTw6CD<ioiW~z2quNHUdop6~{4sj*!A|i3&YlJw@y<cPf(~3<b0+_j$<gc5
bW?<l9W<UarK=ywi;6M@sF+u#vS+aishSC&{

delta 50
zcmbPY`^<*RCD<h-O^$(qF?1u>JsB}io*2FOV5j&1XHNr;c;}#CK__;uyvhG$awgA^
G{R04T6c3I7

diff --git a/tests/acpi-test-data/q35/DSDT.bridge b/tests/acpi-test-data/q35/DSDT.bridge
index 31a76732e563dde32e6d976670baa732a6b91807..fc3e79c583ababf5615e76ba2f7bc3df1483abb4 100644
GIT binary patch
delta 98
zcmexvv(%Q$CD<iosT>0X<FSog_hiJ}`D66rgPr07oIMRV;+=zn1s%A!=1l%4lcU$A
c&A`CJ%zy+Kf$aZ4z=0$NVuJXavt)T00pV^GlK=n!

delta 51
zcmZ2#``w1iCD<jTT#kW(@#{vedop64JTZFl!A|i3&YlJw@y<cPf==vQd6WOi<ZPZH
H%gYD=pYsos

diff --git a/tests/acpi-test-data/q35/DSDT.cphp b/tests/acpi-test-data/q35/DSDT.cphp
index 3e23cb638f296644154100379584b30b644926bd..fd3cb3421814d0383863dc780d9a2a9077b727a3 100644
GIT binary patch
delta 97
zcmdn$@YsRNCD<h-S%HCpasEcGwQ^$a{4sj*!A|i3&YlJw@y<cPf(~3<b0(ja%hBu7
bW?<l9W<UarK=ywi;6M@sF+u#vmhyi9k`NSd

delta 50
zcmaFtu+@RfCD<jzRDpqk@!UqPwQ^#fJTZFl!A|i3&YlJw@y<cPf==vQd6Un|<xEbO
G{{sMeF%NJ6

diff --git a/tests/acpi-test-data/q35/DSDT.ipmibt b/tests/acpi-test-data/q35/DSDT.ipmibt
index 9c5e03fd2ffd3a99f3e5214ba187456a86410b22..332237529e114256384c051858fdac36b024c72e 100644
GIT binary patch
delta 97
zcmdmJd*7DJCD<k8z8nJsqxVKGO<6H_{usUZV5j&1XHNr;c;}#CK?g3bIg>qQbM(5j
b85nq&8IS-Yko_MBIFQ6ZOb~zaR@pxQS6~zP

delta 50
zcmca_yU~`*CD<ioqZ|VRW7S43O<6Hdo*2FOV5j&1XHNr;c;}#CK__;uyvd%jIg=mD
G{s91M?+*9?

diff --git a/tests/acpi-test-data/q35/DSDT.memhp b/tests/acpi-test-data/q35/DSDT.memhp
index 1b7c484a5e31ec456685bc246197252cb48a3adf..f0a27e1a3093ff7525f62b7509ea44dfe9eb8908 100644
GIT binary patch
delta 97
zcmdn({?eVxCD<k8r7{BpqsB%qV<j<n{usUZV5j&1XHNr;c;}#CK?g3bIg^8xa`d{i
c85nq&8IS-Iko_MBIFZCaOb#HPykF@L0BA-OI{*Lx

delta 50
zcmaFqzT2J4CD<iow=x3*W8_9IV<j<9o*2FOV5j&1XHNr;c;}#CK__;uyve~zIg{Ti
G{Q&@Tw+}l2

-- 
MST
