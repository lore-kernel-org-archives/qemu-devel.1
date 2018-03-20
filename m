Received: from eggs.gnu.org ([2001:4830:134:3::10]:50604)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ey7lw-0006NZ-Q0
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 23:17:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ey7lt-0007ud-He
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 23:17:12 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56954 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1ey7lt-0007uN-AI
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 23:17:09 -0400
Date: Tue, 20 Mar 2018 05:17:01 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1521515720-612046-5-git-send-email-mst@redhat.com>
References: <1521515720-612046-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1521515720-612046-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL v2 04/50] acpi: remove unused acpi-dsdt.aml
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Igor Mammedov <imammedo@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Eric Auger <eric.auger@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>

From: Igor Mammedov <imammedo@redhat.com>

SeaBIOS blob which is currently shipped with QEMU
doesn't need acpi-dsdt.aml nor is able to use it
and code that loaded it in QEMU was removed by
(commit 9fb7aaaf4c "pc: drop external DSDT loading")
in 2013.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 Makefile              |   1 -
 pc-bios/acpi-dsdt.aml | Bin 4405 -> 0 bytes
 2 files changed, 1 deletion(-)
 delete mode 100644 pc-bios/acpi-dsdt.aml

diff --git a/Makefile b/Makefile
index c811669..677a54b 100644
--- a/Makefile
+++ b/Makefile
@@ -775,7 +775,6 @@ bepo    cz
 ifdef INSTALL_BLOBS
 BLOBS=bios.bin bios-256k.bin sgabios.bin vgabios.bin vgabios-cirrus.bin \
 vgabios-stdvga.bin vgabios-vmware.bin vgabios-qxl.bin vgabios-virtio.bin \
-acpi-dsdt.aml \
 ppc_rom.bin openbios-sparc32 openbios-sparc64 openbios-ppc QEMU,tcx.bin QEMU,cgthree.bin \
 pxe-e1000.rom pxe-eepro100.rom pxe-ne2k_pci.rom \
 pxe-pcnet.rom pxe-rtl8139.rom pxe-virtio.rom \
diff --git a/pc-bios/acpi-dsdt.aml b/pc-bios/acpi-dsdt.aml
deleted file mode 100644
index 558c10f51ccbbf9ec2f47a4a998a7055059a8963..0000000000000000000000000000000000000000
GIT binary patch
literal 0
HcmV?d00001

literal 4405
zcmb7{O>f)C8OI;KNTx=#Ov$uk$9XY?b_=xIjb0q@_EJP5WkrsxFrpHqP*76NE}&CE
zqzSOzpn&5RO*WTe*G<u*ve0?^5!z#q`3UV-*rJF}QJ-hVlxK_$u;qa>|Kam8znLL9
z<A?s>dJ#bTx_LkF0GjuGY(WhGo!+3koGWcQ9rFPU5B+94((<~g4WH$C9dAv`{m^gT
zZEJrW$A5|A$IoMJl)(Ns&a3@V^7|L@K9JFq{e&^9IOQm8M#H0x!0S}3=w`>a8*i9l
zMGe0XR&=-HYff+FBQoL^UcVI<n+xnWFBU<!u}c6mx@m3g#6Gb#3)?l@pr*I@_{5&;
z#Tgm?=lKNy@f?7`Y?dceyma7Ch?1^<&1QdpC#wIrasZas-`*<LS>@%=&fLZ0Lo8-=
z2|2%0`vJHO7J2;;UQ)-|gCMNeL^TdtX>}ZQ>$N1Pgb_W)N-Ls=$)m@-itRY~WHYgk
zgX+BqrWEW?)FoC3!tE_lT@6}k^@E_hy_E!2ipVPzkypAAJ^BL$Apdw8JA0Oxf|hkN
zXbsXi&~OfL^l_GN27^7ov3&C`59aWhLwfmMtLJY9eLvcCx1(^-fP`A&gqlWQ#LS5&
z_E*O-9LM?DYzmXYSH~mx^T>vO|2H#*DO<8=Sc*kf_+yTS?9DqcX}p{p+4*D-kG#yi
zb|d180Xv{$XK)dCIxy@<o~j1#hl>PNAErQ+8n3KJVco~H$7En{Z-6#s#%p5=&X1+|
z>%skMU4%Dqj4^z*PT^<HPDV28n4R#f8{BTI;^{1=ethujk0=Ux0^Ga?3*DgA)8G>@
zyarVauZe}V<Kx}wZd^0cwM;RGM?dcmJR}qgKaWeEhGmVdw6z2haP%@Q?MLtk^y~o)
zk3PQD^ylV=;pX_@&&QKH#t?&sUZ29JSeA7h*5T1l_HN&uJ1#AsceGfh3=SFYnmfKX
ze-#(NT@&+50P!S?b2^3B<~-vDTWf3I8Q&RTwzap$TO7yo4fv_alm4<B4CYDAc_<p8
z?+N9w#kTgj@ws7H<wNe@GQHb-)pT?+n)o23J)-e_Uzii)!~m=8@Gv_Rrgkn2)8}z;
zg5DcPKhZIcg>jsYb+#sOA%+7j58pBiUkMT(uE)EZc=I=hhhb|Mzl_$me4&!?nw8e>
zrn?k)tz9iS(8fRw?snkyc5t5KZ$5k#v#U?yN%1MgInZJNd^U)+Nr_tgvleDJyAxVO
zPWv%F!Kn)RgVL?v9+vVZzHHF#-SR=yHLN$FWK%oSQ8ZIwpzxryXxg(Ge)CX;b46Zg
zSP;*+ADX6;JTX4^)VU|xo+|Q8P4P9NjA+U|QIaS2hTGy7TG*Z{@=Q$);fbc)6D4`3
zS@1I<Y`Lcir;Oax6rO44QOcYd?wR%=!#z{ejPOi5k5cB$Dx6vFnVM!*PLwj|g2K7L
zJyXsFl@q1RX(^nR!fC0TC}mFkpyCLnoH>Ovr*fi{Ihn%A6i%jcqLexDH;OrNO!%zi
z70$fMiBjgo54$v<w!&$voG4|^MTHap`xqyk&qb9JrOa7SI137ALFGg#b1o^IOA6<b
z%863ubQDfU;dE3^lrkr7#-#ZyDx5`?6Q#^qQaDQrXG!HmDRV9>oXZO5vdW24=5!TK
zSK)M3PLwj|io&^~aIUDFC}qx7g>zNmTva(y%AB|xl-BJ9h4X^SiBjfVQ#jWY&NY=2
zrOdgmaIPzy>nbNone(E;c~RlKsB)r|IX4te+zyF%j(;^bR8EvK=Ou;nlEQgO<wPlS
zURF3SE1Z{APLwj|6@~MP!g)pIL@9G#RXDFIoL5y&l!9~k>_^uO`jgU*EWn+e7WD5_
zEWB0eR-;?pa+f=I@RvWyJ!OYu+`;CiEbnf2?s)wi8uTm00?U7yg&aRY9KcIzV;Q`6
zCiz!mc9@K*KBea2QFnpf=yXS7<8GMt+Vm$6i>qw;%L3#K{9WM*1%OT{c#v2UJ3Z<I
zb<ZtEekX+AQJo#~mL-1Dm{OOxz7U1|P<uHRy}+$`zeDY(*_-FG<L2rIXRk`xt2}!Z
z`$y-TG<((k{_NG^(H^mT=dv^X|43hx(${$U+PU<#_oT0#ruWaM$J5Rarmsus>pXq^
zT>AQZ($|Maw@suE&!;y<`g94=kqD<e-Q4HhET3#QFUFX<icK`TPP;%`LHD{B>@_qz
zV0*#s-WcMfm}eH?9)hk>GJY{)I`G1PBt~VzbmU(20$kE(UXx6W8+$q?xy%b%yZW%q
z{)wleKHuy9jcpE}*<9c)y5YFHS*&<~ODl{%!&5$OWOp*J;^)+h)37m&ChTd<7T}A0
zZU426&7a``5jTMQ$<uue9!|<%ACDd;4|&&Pn6TrAT5quPt5|z&@sb%&VyBmj+Chtt
z+hW5DI+aRg8*mW1l?u2kQL9pg2WMw1+E%*`w$|W**tBCmxpiGQZHeN#C{81NEYv5W
U_=PAMqG*c36NN8|mMC`Mf01wzJpcdz

-- 
MST
