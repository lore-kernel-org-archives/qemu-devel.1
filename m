Received: from eggs.gnu.org ([209.51.188.92]:42988)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1gkcj9-0005Ip-MH
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 17:35:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1gkcj3-0002b9-MW
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 17:35:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49844)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1gkcj3-0002YS-8o
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 17:34:57 -0500
From: Laszlo Ersek <lersek@redhat.com>
Date: Fri, 18 Jan 2019 23:34:00 +0100
Message-Id: <20190118223400.24311-6-lersek@redhat.com>
In-Reply-To: <20190118223400.24311-1-lersek@redhat.com>
References: <20190118223400.24311-1-lersek@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 5/5] tests/data: introduce "uefi-boot-images"
 with the "bios-tables-test" ISOs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu devel list <qemu-devel@nongnu.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>, Igor Mammedov <imammedo@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Shannon Zhao <shannon.zhaosl@gmail.com>

Add UEFI-bootable qcow2-compressed ISO images built from:

  tests/uefi-test-tools/UefiTestToolsPkg/BiosTablesTest

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>
Cc: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Cc: Shannon Zhao <shannon.zhaosl@gmail.com>
Signed-off-by: Laszlo Ersek <lersek@redhat.com>
---

Notes:
    Again, if needed, I'd be happy to be designated as Maintainer for the
    files being added in this patch; please let me know the right spot in
    "MAINTAINERS".

 tests/data/uefi-boot-images/bios-tables-test.aarch64.iso.qcow2 | Bin 0 -=
> 11776 bytes
 tests/data/uefi-boot-images/bios-tables-test.arm.iso.qcow2     | Bin 0 -=
> 11776 bytes
 tests/data/uefi-boot-images/bios-tables-test.i386.iso.qcow2    | Bin 0 -=
> 12800 bytes
 tests/data/uefi-boot-images/bios-tables-test.x86_64.iso.qcow2  | Bin 0 -=
> 13312 bytes
 4 files changed, 0 insertions(+), 0 deletions(-)

diff --git a/tests/data/uefi-boot-images/bios-tables-test.aarch64.iso.qco=
w2 b/tests/data/uefi-boot-images/bios-tables-test.aarch64.iso.qcow2
new file mode 100644
index 0000000000000000000000000000000000000000..fa2cf9291215c2fce59e526e1=
147be950cdce818
GIT binary patch
literal 11776
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
YB7nmK%e*8`^`$z5|HrM>|1a?00M!mU9smFU

literal 0
HcmV?d00001

diff --git a/tests/data/uefi-boot-images/bios-tables-test.arm.iso.qcow2 b=
/tests/data/uefi-boot-images/bios-tables-test.arm.iso.qcow2
new file mode 100644
index 0000000000000000000000000000000000000000..c83358f2367630e6a6b499ac2=
6c1628dab2b0aff
GIT binary patch
literal 11776
zcmeHtWmH_-mM&UY0R<EmT!Xs?65OqT;KAJ;f&?d6fI@;xfCw5A+@X-*nm};Z;83{K
z%Sld;e(&_S-KXELJNouqqw3q=3DoZsAguUWNbtuc0K$}8O<At9mueEr{s^@{*P{>_K`
z`vCAKNBIMh|0Mqvp#2os*`Z$Q{X{4dl9j!OmmjT#z1M%0_dAYk>FVL(?dJ72Gmw#-
z%>DgnJ*;gkUA<krJpbNB{?%1~d_@0i|B@9z{<)5S4{RjNpGPSF&p`dfP=3DEG^KgO?R
z|1Vjk|M8O!`87jKq~D15KYqUdJHg)-ko*PMNPnX8pE&!=3D{qyZlzVUDTulPHTga23m
z-{pViQ~h22Uv+=3Dxv;Woqcln?BBL7JLXFUEN#m#;NaNhpb0d@aG&p+|!e&?UtEWLbq
zd3da>j*j6t@sJMO9OJOt7sq}4k}z~Iwy+r*J;-Kx*=3D#us(>;dvZI5IGVK`dELs$oL
zp$OSLnN*g3hS~M8h#eS&j?|hUhS$jhLJ#kjs*6Ceb%ung49<w)-P6v28xeAfP`hYZ
zDaQAPt+^IRb!IHnlofg}&7MdK;ZDiq7t|-5q~iFE#XOC{!n?+NHoy<cUS-Ho7xhov
zSE3c-sS+zmwJcUhJ2T6zhPC8uw2E+Ub1gW9N)NayBhW*i(QoO&daM&*cMcu+rLRAi
z-RIrKKh%bhp?d*<;Xk*smTtc$>2;=3Dwd5nJoJl4a+bMrp;I`#4a9>XszX-O0bD?GqJ
zHYB8*!#xW#v%WqaY<cFNc~(%fpJqjd&Or1BLqfp<$iLL&p+`p2wt$);p<)5>Ks_+X
z2n!<{U1w)^M+c_tE1+`3Q=3DSJric(J%rDVy>*vM!DpFGq+EMI~Y9zGWC1v$z9r~pdQ
z{z?Kw1wR^dZtrB^IWPwWWM^a~%fQhPqH<*%<4I&2K_0~wT_Nn3JV;0Z&ir)3Vio$_
zoS!2?V<MA6V?s+pS1=3DgDQNmGCQS5Z7ePex3;P_Lx?p`PExIUghUI8r#WI1Jt)VNxH
zM-t0-nxt)E4`_?NY7)%j@1eU_zP=3DkwN1oY(Et#5bS_mzMrskU_XQZZ-LX!=3D0Dn7gc
zK~u8yb4sC^dO3y>^!aHirVvO8G$XxpPzRD~_zY;J%VzaKmo0UjJr#^>Jwe2O3Wmes
z;OC8G^2kiIUc^W@$24gAL}b$xWFn+IZZu}gFFHC9D-vBSWCTBJ{GSCq|9v8xW@gKV
z&g-`87zN}V9h1Y_$k=3DF*jZ89m*cb-VSM3l~WB}mfq<oNk5GX4K84V71>kofN{zpMS
z4f6B93WMSQRh9W$#UHwn`%^_39!UIbL7W(}VL(Pk`17>17)Yn_7PJ&rM@f~wVBpUm
zK})kY_?T|iW+L5vujtQ1LKBm+3Ho@DERdt8<qcTokV_Sj=3D%P>vL95S1_PXEW)}zur
zcouR#04+>J8e><gU_s^uzQGF{SCmBFrf5y=3DPL>4#B9_br2$4MSw~60vu0NF7K!w^p
z^;Yk0`v2~r|D63r^4Dzv8~)MV{TW~U&*QlN?W+7fFD~_O1R<IIx&Xo1ZzLM}jl@mA
zku>2qlC%Cs3e?|7IV*|uhf&v?{X&|x-$-Zh8|fz{k^V47MYCVX6fXG-nWKL5htGd=3D
z7W3bnmHszp^FjKXX7)?R?)*39|3N1C%fmtU9|C`IP(d{8zPf>f?7wzTI{V-{g1s4S
zwx1#NL7)5Z=3Dw2_`lzn5}Mnkv8l;I}kHtDAJCmV3fps%$@my*kr4vwOglab=3DC(w1ee
zpnbmUmG0!C@@8Ok$>)+f@uD^H@CCP(x;c41HOj`?hMOh+Y^b!Z&Td_1Q8pEzF}LMv
z2R|5E0drHbY#Vhr5_G*fRn0NBo?cK(r4enMGJkt}NzxJ63|rbC9N|2L8buk2@z1ln
zVI#t3TKTbE7BE-fz>6kvJY`9IGSHpl#rPdN^<3m81cg?e_dN<Gb6oUI{Hx^^c@3MV
z2br`7q=3DoaDr<dyj70;^Vo3nbQu7wrb{QJU~-_MSMS@}c!ORlMuR*CbBv2CzDpg(vU
z6D%(u4Eqfcy>+vsNrnvgSLJ#Y5fv#Fuu>z7ND&}5)=3D7SZ_erh>a-URmp^E@V23OtD
zuqOR984oxJ;<135lYWMQDVpB}{6hWb8Se9qs<jC4-a%?yIK}XnDm%HpQ+qwV_d73C
zo6m-SEd5fO|1*I+=3DZ2=3D#@WY1o_1WtV{86qPBl-g-4`MxawQ;cZiHOk@%0AyhUK)*N
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
S2p;@zKYsqp)75`|`hNhrT|}P%

literal 0
HcmV?d00001

diff --git a/tests/data/uefi-boot-images/bios-tables-test.i386.iso.qcow2 =
b/tests/data/uefi-boot-images/bios-tables-test.i386.iso.qcow2
new file mode 100644
index 0000000000000000000000000000000000000000..2d897a221010607a5e48de4f2=
d8cc84024c5eae3
GIT binary patch
literal 12800
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
r
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

literal 0
HcmV?d00001

diff --git a/tests/data/uefi-boot-images/bios-tables-test.x86_64.iso.qcow=
2 b/tests/data/uefi-boot-images/bios-tables-test.x86_64.iso.qcow2
new file mode 100644
index 0000000000000000000000000000000000000000..e38ec57e7f391814ab924fdc2=
7e6917d341f652d
GIT binary patch
literal 13312
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
LPjddh-u{09w(Wq>

literal 0
HcmV?d00001

--=20
2.19.1.3.g30247aa5d201
