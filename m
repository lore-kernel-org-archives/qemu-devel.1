Received: from eggs.gnu.org ([2001:4830:134:3::10]:58670)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1eurFv-0004Lk-Tk
	for qemu-devel@nongnu.org; Sat, 10 Mar 2018 22:02:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1eurFt-00029k-Jd
	for qemu-devel@nongnu.org; Sat, 10 Mar 2018 22:02:39 -0500
Received: from mga04.intel.com ([192.55.52.120]:52978)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <haozhong.zhang@intel.com>)
	id 1eurFt-00023F-66
	for qemu-devel@nongnu.org; Sat, 10 Mar 2018 22:02:37 -0500
From: Haozhong Zhang <haozhong.zhang@intel.com>
Date: Sun, 11 Mar 2018 11:02:15 +0800
Message-Id: <20180311030215.11488-6-haozhong.zhang@intel.com>
In-Reply-To: <20180311030215.11488-1-haozhong.zhang@intel.com>
References: <20180311030215.11488-1-haozhong.zhang@intel.com>
Subject: [Qemu-devel] [PATCH v6 5/5] test/acpi-test-data: add ACPI tables
 for dimmpxm test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, Igor Mammedov <imammedo@redhat.com>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Dan Williams <dan.j.williams@intel.com>, Haozhong Zhang <haozhong.zhang@intel.com>

Reviewers can use ACPI tables in this patch to run
test_acpi_{piix4,q35}_tcg_dimm_pxm cases.

Signed-off-by: Haozhong Zhang <haozhong.zhang@intel.com>
---
 tests/acpi-test-data/pc/APIC.dimmpxm  | Bin 0 -> 144 bytes
 tests/acpi-test-data/pc/DSDT.dimmpxm  | Bin 0 -> 6803 bytes
 tests/acpi-test-data/pc/NFIT.dimmpxm  | Bin 0 -> 224 bytes
 tests/acpi-test-data/pc/SRAT.dimmpxm  | Bin 0 -> 472 bytes
 tests/acpi-test-data/pc/SSDT.dimmpxm  | Bin 0 -> 685 bytes
 tests/acpi-test-data/q35/APIC.dimmpxm | Bin 0 -> 144 bytes
 tests/acpi-test-data/q35/DSDT.dimmpxm | Bin 0 -> 9487 bytes
 tests/acpi-test-data/q35/NFIT.dimmpxm | Bin 0 -> 224 bytes
 tests/acpi-test-data/q35/SRAT.dimmpxm | Bin 0 -> 472 bytes
 tests/acpi-test-data/q35/SSDT.dimmpxm | Bin 0 -> 685 bytes
 10 files changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 tests/acpi-test-data/pc/APIC.dimmpxm
 create mode 100644 tests/acpi-test-data/pc/DSDT.dimmpxm
 create mode 100644 tests/acpi-test-data/pc/NFIT.dimmpxm
 create mode 100644 tests/acpi-test-data/pc/SRAT.dimmpxm
 create mode 100644 tests/acpi-test-data/pc/SSDT.dimmpxm
 create mode 100644 tests/acpi-test-data/q35/APIC.dimmpxm
 create mode 100644 tests/acpi-test-data/q35/DSDT.dimmpxm
 create mode 100644 tests/acpi-test-data/q35/NFIT.dimmpxm
 create mode 100644 tests/acpi-test-data/q35/SRAT.dimmpxm
 create mode 100644 tests/acpi-test-data/q35/SSDT.dimmpxm

diff --git a/tests/acpi-test-data/pc/APIC.dimmpxm b/tests/acpi-test-data/pc/APIC.dimmpxm
new file mode 100644
index 0000000000000000000000000000000000000000..427bb08248e6a029c1c988f74f5e48f93ee4ebe0
GIT binary patch
literal 144
zcmZ<^@N}NQz`($`&dJ}|BUr&HBEZ=ZD8>jB1F=Cg1H*%VV44G{4#eePWQ5R6Oc0ux
t8ALPkfFuw61CdNzKn!AlSgfo-nis_4<b<)ffC?aD+}vOm3)_F75dauy4FLcE

literal 0
HcmV?d00001

diff --git a/tests/acpi-test-data/pc/DSDT.dimmpxm b/tests/acpi-test-data/pc/DSDT.dimmpxm
new file mode 100644
index 0000000000000000000000000000000000000000..38661cb13ee348718ab45bfc69452cd642cf9bb9
GIT binary patch
literal 6803
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
M&bmz+HgqQb7xYSyTL1t6

literal 0
HcmV?d00001

diff --git a/tests/acpi-test-data/pc/NFIT.dimmpxm b/tests/acpi-test-data/pc/NFIT.dimmpxm
new file mode 100644
index 0000000000000000000000000000000000000000..2bfc6c51f31c25a052803c494c933d4948fc0106
GIT binary patch
literal 224
zcmeZs^9*^wz`(%h@8s|75v<@85#a0x6k`O6f!H7#0xTF<7?{CKCLmdP`9s?0EhP?X
zoOz8Uw)fly3UNTya)1<ZG=NB;xeNvjAoU=?!oUim!15plDuC!_VF&=KYHMHw>O=<N
OCPEC15bKeJ39<o`))N5$

literal 0
HcmV?d00001

diff --git a/tests/acpi-test-data/pc/SRAT.dimmpxm b/tests/acpi-test-data/pc/SRAT.dimmpxm
new file mode 100644
index 0000000000000000000000000000000000000000..3b10a607d5bba6cebb97d9174c2a54a577bba9a8
GIT binary patch
literal 472
zcmWFzatyh_$iTq3-O1nCBUr&HBEUHqC<YW_0I@+d2*ZH@I-ijdRi23nmCwwK%xBbq
zn*?QW!3D6Z16l|MAK=n(22h+)1I}ZDDumG}?q<}03$x%?#|)KbV8gEtrVKxg<UW{t
kIAA*9HUR~Y+{Xd+5nLTROaoXQT$cb;-3ypBTm~or07$zG0RR91

literal 0
HcmV?d00001

diff --git a/tests/acpi-test-data/pc/SSDT.dimmpxm b/tests/acpi-test-data/pc/SSDT.dimmpxm
new file mode 100644
index 0000000000000000000000000000000000000000..8ba0e67cb72daa81a65da4906d37a5e0f4af1fd4
GIT binary patch
literal 685
zcmZXSKZw(C6vtnha!u17ByGVzlq1`X<~j)uk|vD}G-*lFBIF?dq}OXZ{P1oO5!yPO
zo*?wHiAX9L6?ehS)yc`t;lSNRa8Q3QhlA(x-Y@U_^4{nB<L5Y<`?dhU4BCCQ>qyo}
zGfb0y13>%kK*cOryZgS=_PteSm+Cg>cMWY@Q3r-B@3o-Ot68ej+a_kmRL0)I8W?@1
za+T+c^lU38j4L2`%L>+6%he6ZTQ*T(yIQX!*`1Li=|fAEbj7~2_*wFnwOqA(9ZTwK
zio5t#O0Oq#AYz>tvTwqT^{aF7>F3(5<j4N|U~@CwN#<2V&KthJe0Fd1sivNOF+RR)
zeTah1mAo#$DXZf4xwu|)AXQ(CgY?>?WDIA?B!IM>Od%6lCJzjmBN;hFG%`iDwD~Z3
zKI4nY$&9XfG6RUn<0vLEGLtd7I!0c;7?KAe&qC<c5go#Qd#E3Y1;Bie9W(@AbIf9f
zH#Rw(&VaKWSAm9EvUS5PbA8=$flM$F>_N+y9WhL8i@}cEbZ{B~9Wf*ra9CPBOY%xa
z*OHSUJPs*V$|WInR{*ab@KVl5iS!IZ<F-$ibA+l9f%vt|5TuC%{5usBoLT|quf7q|
zEgTlzkHh#V3L<aSv_`Vb`HE&UmmM<RYKN+OxylzB;=dQb7cTVHh0gw`vmCywDt!H2
F`U7Br!vO#Q

literal 0
HcmV?d00001

diff --git a/tests/acpi-test-data/q35/APIC.dimmpxm b/tests/acpi-test-data/q35/APIC.dimmpxm
new file mode 100644
index 0000000000000000000000000000000000000000..427bb08248e6a029c1c988f74f5e48f93ee4ebe0
GIT binary patch
literal 144
zcmZ<^@N}NQz`($`&dJ}|BUr&HBEZ=ZD8>jB1F=Cg1H*%VV44G{4#eePWQ5R6Oc0ux
t8ALPkfFuw61CdNzKn!AlSgfo-nis_4<b<)ffC?aD+}vOm3)_F75dauy4FLcE

literal 0
HcmV?d00001

diff --git a/tests/acpi-test-data/q35/DSDT.dimmpxm b/tests/acpi-test-data/q35/DSDT.dimmpxm
new file mode 100644
index 0000000000000000000000000000000000000000..14904e8ea2376abd989aa9e99f5bf388a3b85032
GIT binary patch
literal 9487
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

literal 0
HcmV?d00001

diff --git a/tests/acpi-test-data/q35/NFIT.dimmpxm b/tests/acpi-test-data/q35/NFIT.dimmpxm
new file mode 100644
index 0000000000000000000000000000000000000000..2bfc6c51f31c25a052803c494c933d4948fc0106
GIT binary patch
literal 224
zcmeZs^9*^wz`(%h@8s|75v<@85#a0x6k`O6f!H7#0xTF<7?{CKCLmdP`9s?0EhP?X
zoOz8Uw)fly3UNTya)1<ZG=NB;xeNvjAoU=?!oUim!15plDuC!_VF&=KYHMHw>O=<N
OCPEC15bKeJ39<o`))N5$

literal 0
HcmV?d00001

diff --git a/tests/acpi-test-data/q35/SRAT.dimmpxm b/tests/acpi-test-data/q35/SRAT.dimmpxm
new file mode 100644
index 0000000000000000000000000000000000000000..3b10a607d5bba6cebb97d9174c2a54a577bba9a8
GIT binary patch
literal 472
zcmWFzatyh_$iTq3-O1nCBUr&HBEUHqC<YW_0I@+d2*ZH@I-ijdRi23nmCwwK%xBbq
zn*?QW!3D6Z16l|MAK=n(22h+)1I}ZDDumG}?q<}03$x%?#|)KbV8gEtrVKxg<UW{t
kIAA*9HUR~Y+{Xd+5nLTROaoXQT$cb;-3ypBTm~or07$zG0RR91

literal 0
HcmV?d00001

diff --git a/tests/acpi-test-data/q35/SSDT.dimmpxm b/tests/acpi-test-data/q35/SSDT.dimmpxm
new file mode 100644
index 0000000000000000000000000000000000000000..8ba0e67cb72daa81a65da4906d37a5e0f4af1fd4
GIT binary patch
literal 685
zcmZXSKZw(C6vtnha!u17ByGVzlq1`X<~j)uk|vD}G-*lFBIF?dq}OXZ{P1oO5!yPO
zo*?wHiAX9L6?ehS)yc`t;lSNRa8Q3QhlA(x-Y@U_^4{nB<L5Y<`?dhU4BCCQ>qyo}
zGfb0y13>%kK*cOryZgS=_PteSm+Cg>cMWY@Q3r-B@3o-Ot68ej+a_kmRL0)I8W?@1
za+T+c^lU38j4L2`%L>+6%he6ZTQ*T(yIQX!*`1Li=|fAEbj7~2_*wFnwOqA(9ZTwK
zio5t#O0Oq#AYz>tvTwqT^{aF7>F3(5<j4N|U~@CwN#<2V&KthJe0Fd1sivNOF+RR)
zeTah1mAo#$DXZf4xwu|)AXQ(CgY?>?WDIA?B!IM>Od%6lCJzjmBN;hFG%`iDwD~Z3
zKI4nY$&9XfG6RUn<0vLEGLtd7I!0c;7?KAe&qC<c5go#Qd#E3Y1;Bie9W(@AbIf9f
zH#Rw(&VaKWSAm9EvUS5PbA8=$flM$F>_N+y9WhL8i@}cEbZ{B~9Wf*ra9CPBOY%xa
z*OHSUJPs*V$|WInR{*ab@KVl5iS!IZ<F-$ibA+l9f%vt|5TuC%{5usBoLT|quf7q|
zEgTlzkHh#V3L<aSv_`Vb`HE&UmmM<RYKN+OxylzB;=dQb7cTVHh0gw`vmCywDt!H2
F`U7Br!vO#Q

literal 0
HcmV?d00001

-- 
2.14.1
