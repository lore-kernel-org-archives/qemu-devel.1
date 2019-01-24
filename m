Received: from eggs.gnu.org ([209.51.188.92]:57568)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1gmlte-0005ln-Ba
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 15:46:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1gmlnq-0001vR-OB
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 15:40:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36880)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1gmlno-0001tj-NV
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 15:40:46 -0500
From: Laszlo Ersek <lersek@redhat.com>
Date: Thu, 24 Jan 2019 21:39:59 +0100
Message-Id: <20190124203959.30875-6-lersek@redhat.com>
In-Reply-To: <20190124203959.30875-1-lersek@redhat.com>
References: <20190124203959.30875-1-lersek@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 5/5] tests/data: introduce
 "uefi-boot-images" with the "bios-tables-test" ISOs
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
    v2:
    - refresh the images (should only differ in internal timestamps etc)
   =20
    v1:
    - Again, if needed, I'd be happy to be designated as Maintainer for t=
he
      files being added in this patch; please let me know the right spot =
in
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
index 0000000000000000000000000000000000000000..8d7f8e67e85aa2156adb34233=
22018f6a6ea890c
GIT binary patch
literal 11776
zcmeI2byyo)xUYk|yA^i}R;*YlG`PD3x8f9v2ZsX1-6>Ft6n7}@l430`#ogU5yX}7N
zefD$CJ^Rlq=3DUbV)^ZR6ywUW%NnTd+D%q;)_fO}g0S3~(F5Fvm2Fn+Hf{?V|15$2Eh
zuK@p)U}Xh&rS-%Z0Km-J+0}!}#M<@0s{0*>F?Dcue(UJ^FDqaGZ;U-XsGQ9$Oda0Z
zySn_l7y17^>#vXKzwQ6a5rBF69sh2q0OY4N*gp;KiGMA>8~oGyU+ur`|IrbE{OT7n
z;5RY<AMNFTck7=3DcApXmN3iw0WKb-yLetP<&*Z<c4<nK5d)<6CKR{yD|__z80%=3D=3DT%
z`cMDA)qm;*{<Hi)@u>eS4*nHD%m1B+uK9;9fA}=3Dt`9IrCUER2VKr^$W<1@4<<#vn=3D
zgMd4q<9;6T4g`EuelR=3D@w#D)?csT&sDV!?5M?45O5I%^pqa7wsfOwu*B27C5d~+;d
zg^!H@X#G%$*-3>jW&1O<MFnXajunG8w>&|%1Auw|NI90)Fx}n3khQ(B$fFNo*GA=3Dd
z&2KGtgr1Y%?YYHsHma88l8YiwV_*^xC<v>ygWkRI4y$e=3DYth^bHw;(WjW*L6{k*@5
zB;%4}I=3DOl{Vj^IBe2Rc6|C7QGKM5+Wekt09cDcX?BZ4c5T5h+gB?rG%7&T>L1Xo1#
zz^AFKspGFsx}K{bA7h=3DMA8R3FI=3D;PdJ#}?MKR&xOr6L63mO102vj70MhkGVqaDP7#
zRhr?c&MXG}WM;$&w0M6h04xfkbchO&1_q#J5(5Unp&(*n_jD+aGEuXb^mcZ)w<Eub
zM3)Ux2a*Co66zp{SHxfzVk&P@My1E)E9}>dBK&>Wwvvbxh%#ZGGQ4=3DXJB=3DB4_mXEB
z9X79F>|g+<-cSf$sVtho6pRHQ5VWHC95n<80C?H)Q1c6yX>+ny2Kk2v$NGo+fA(KN
zq78%%goA^%T2vVJU0d6xEG7H7wYEySw?S-Tm7kN-&e+D;WDzy)k9$zT?%g~?GK$*W
z`T#y#E1lLE`0@CXn>&I4!o=3DD3idu!5S*(qYi<wb_n!Z{<Pf3EBijl8UK!cj6T%Z<N
zN|c?kEhk5nnu{|yxg>|Fwt=3D|6RJ~uZOr2>!i-{R_FrU$4gL!LvoB7C@D-u>#e2WEe
zdrS$hjYm99Ml3)Cbfg3?`?R+|u84Ip5#v0K@&7L9a&m_C9mC1>#0g^q3{Ghs?1Xk=3D
zz2t%Tm!yA!#YfH=3D<l%}8$i)Ios6pUh5JP54*zVZwsCe<<khiv1;*jKc1g>vG!O4~u
z#0Y_ufPbd({7$ok9TI*@6A(&EZD{gf$r-E$0_lK}0TP&i(<l=3DvvR6m3<?i_CPe(yh
za1I8tqd6F)(-TQ^;V%*GpN`TG1em~tO_RQbCqsw-b_I-qU~kflV@yYOpukd*(vTAq
zn}Nn&1GW<LH4`Ajh{{MER&+UlvrI!-6B!yf^--8`X;|?CnAW_>j61U;Zvbvo@o2dA
z<-a|h`agSr^7p$F|FweN@VEXa|HPO6>Hk~*j$>f|t^Y0m)KUH>HURvq5GUa`@dSPo
zKkqjQCB*@M88I997fI57lk`CRmnJv+ttn1_lQR1^sWpC+7VbCcoWuct83XQbGE#&8
zk^sgB@n2;6Q_tM>TeFOTfB9MeI`{q$P5hUa?d5+M{1?tY_5bPi|K5Z`tQe?E9KW}1
z$YAz8W<Vef0;?;wdk<uJieuEyJ>vZqU07gBhrs&@|D5!<*t3e5_Ic-62MP!s?C+Zz
zv}sIGSG+&bV6HeFE?(XrtdqgcMw6fKLG}QKtX;~3s8`noC$F9nH!oMaBem~7R}O&e
zSS>hs!dSjlBVx3)w;SgJx9avaVp_{Ck@`PJBA3|=3Dg207k(vJJZh;E&rf+)(<1T#a+
z<HG{-BVo&wwo2v2;L4BMY_d*_8Z;Q8g;GmA$Jtv8m2*WS(Llb|cKmol)(vHX6K$Mn
zgrktsNDc^|nc133ZBQiUwxP++fy8d>bZcqcB|ncF)JB@pjTUuaZk{&kXJK$1XdnvW
z#`WgJPO;o6m_bW$&URr!e<n_`0OnIhjN&x=3D$3f<dF2r-i0=3D(uQQ^qF}o;k=3DBW0c>o
zu}b=3DF4!cpUv&l|KWK9VYI)s4_eLIx|7j`|Kt=3D|Pl$iI2XYoY~KNeU-!;2zaKAKcYT
z(9#~BGPx|aA+AoCJ8`hj-e^1h+VnYX&UX*>C(k*8K}@Tho(geqc6{J<yUG|V@^`*?
zDruf`Vph=3DZT5F6rEDK2jD&~l?9hxCOGleHcK~7G+-e^z9N{A{!<fDIUpusAWqFv1~
zcy8jdhVcE|?fDC_#ZTt${jAT>zC<`(XP)L5DE7m$q}wnv6IgcG(bM~o+4v9`N9c77
zvh2+1woz{N@hlPUzywZcONb!uMJqL`d;$LSw;_*ur_r=3D3?!GFxW8nDF6tjGwIUq@d
zqdY=3DzhC>Nddj?w6WLSqLf2u{y77@NJkbGW?qhZSV9Gdz#B7<T6{oozdcgazX)3wCB
zS>Prm-sx0Pec#x<gVt?sraSgHR8oWec$<Zpd&vEn!Z=3D2pU;HI}uV3g!h~*AU#Sq%v
zIiJ|tqM68P-(3ya$k@VTQ~jl@OhIPhVw7z6WrQ-nOpp(A5Cd(51qZeT-j#Qk*M#Z(
z?4rW5EiFS8`oS<cm(oufVeP6nkODFMU?C=3D#!*6S7EeAYVXv#D&&}_&FQIPX$k+2dG
zPgkZ<9c-Bw&m}i0{fLy_<8`n|Zshac7WO8dW?ea9i^tfTr6^@C&`TA3kwaS@LVP-U
z>KB<e_`LLVf>u%jlW`8n=3Dv7HMmF&P9$-wD2DuKduP+$<du^IcmpH&?)jm;Jx{!-45
z`=3Dx@s+!g0TpTjJ#(Z(iKsb}qO5fVYTI@Rl>UlyyzZEw{GNY33xI<lU@<ihYN4?nj!
zu?jlPrSBrAzjL2I<<$Qv6;8-M%!FQ@5b(BevVXK$Xhiv9VonP8yWo@;NB`M3S+6eD
z03``-pCvXcwq!%dG6JZ9X*XsazB?A_L>7&lx1M_fz1KOdre~oNWHpryKmAUSp!!8V
z5AxccL4ks{Q<{g1wFalt1x{glUUFXcjSPk;<DBPr@Iow6`f7;4-n{}lVWl8Pv!AoT
z?QTp6QQo-J4NDArakYJzE7s0D1YH%1mHLrdK-w>Gl9PKT1M&??C@W1xAWJgq(Zl84
z`G@lJ#x|ds2g;4E>*vd>eZ022C1dxZ2~1Yaj6Ymme6g+(>|#db$W-uqpkAgQr&tIR
z3Go@qdZaXES!h71U)XwZdEp3IQ%YUwk$u@z_mK_wI3g*SCS_B`X+rSVQiD5!X&aPX
zb2;?;9@~F_T=3DfMOWq!&MB`>Ycd%e5N;=3D(jo2wsb9KuJ{#dv10%JGJQ{Pj@}}_yg!C
z>hA<g*0;mje=3DocBsbwAPyk(j^VEM`uel%oPRBbLb5^}dIFI}#`u$J8;Hjaj>G!^UT
zh5upTlN4X8Eg1c(=3D$Tqs9ZNWE&e)n-XP!sAEsf3^QKjlyhBm`a%b8J(!CM`Nn0{sq
z|CaHDofp{#@0~{~t)g23+G$3l4S#;-D-vV@;?x8l>;9M$fg+rrG#pYgwt2T-=3DI*g7
zN85j3WTjr>UN!TtG*7o(h`hM8Up%&6;0(zQg(0jEwf;bPm2}K~J(xfCGL;QzUDAyl
zZ<%cPoa;EtUK5MC+G6XlxMkkDF1(@7>`T;D#K3hxN$9=3D%ZIYY$w~T5`GiOw}f_iUT
zO=3DQK#sN29xsyD&Bo9^g3egwEa`5FneVou{bv0L=3D}Dmu5f6f=3D4Ru~1t)74mM&B{>^k
zLV6rJ!8e`n>ps5+?=3DvXx+p4OcDO<Tj7e3QfqA63Zz0kmVi92Zk*J=3D2iK*V)hA^<f4
z$rOPAHZR;yJdUtMCf*a|2^7WZ+I-HlbS?csT<&3CjFPx-?}m4m&#K?kDS3wTblCSi
za%NCKjy$@e8{eh74%*JJ%tt?pJ4aiQs3IYCR0GyN3IdBeg1(`p!<KJ;&6>!2t&=3DBX
z?B{x<o0hYM^UUxl6^6S08)t0e^+RVbFLr{T>^^Rc=3D1b5J#^=3D_H=3D4_6*b?&9M@^rIC
zxOo;hsV;vn&mKyZ-LGGoe4pt?AewlcRlId`mui!4*mtAf<<=3DDTO6aaq6kR<p*y%!B
znK9m$2m?!TV)Rb29U(3V-!P9c?i_v%d@MvQO-ffUE~GP@b9^`qJ4|Q(ZmTkIGYmHy
zDwsB%+b!E9N}{G@eKmA<eua6i6CDs%@BK~~rUp&5NY|<QzVwKloI5IFG8x)fA33C`
zB+BSf9Dk(FgF9OpDA<Mn<{3~D?`U!P=3DK&w1?<)g6X^FTKw05fwl>KyN?1*(!lM>XB
z-fmHrz5*^1xlGlNbHwB6<ux};)wN9Yv=3DBBSUUNg+vk_hR`FAe~&&LVQ9+<SILf~d4
ztMcO)<n`~mZ;*nO<m6yg@E<k|C-$UFqBZjCkmrko)0<W}tktCVhcDP^(Ba{TB#a|c
zteI@oNbx}tG5VX7j;ov%OnF2WaES<tmfw)6t(*ieGY&HjV-dZRHP!QtgXFP&C$L+Z
zCeMihFZ(#wGI-&H>KVx6gemZ+fcc?uc)8AKYgJz^H%CyU%t6I$Ss1EDKSfe~iX%9t
zRb6^TlSDkA-{T5HRZU|qktdG0Z0^b%7s`$oBM;3L!htFa*Q@rj<x8zNz0(%QA#x;$
zNv^%YxCexZkOU^7O5X~(D{5t@n)gtd6Z_>1`uF=3DFc?Z0UZUvIy;z7-7H_acMd^POY
zQy5g1Fr!n@B4_uF#CW#iBA-)QyCRpAZJq5*?AJjrKE$`dZs(J|AWfdH?mm~l!nsEB
z;J3J(EC-2sws|Nu$`lTBbw&5CeBB|wYA9F;mVW4vet21y^>|LXP_A2jAbif#BFM<Z
z_@<%46;13@sYTc{zuZA(djH@mc%b{6V|Z{^#|f2O7d;{l(h%SG3|2}Y&z^TXTP;gw
ztT8H)a#ngSbr?pNp#PPivUgPN=3D3xHgV-H>;G5kIWF)EZB7{pd(nsNovah<ZXkS_a%
zRU7{dZk;Gd_|8lKJdc6fjJ1Zw^9VFT*04lX@9JDWIz>5+w!;u3XW*&=3D>eo1cudZON
z2x;NE5D;-f!rvnWF&1ml-CaSc&YO-;AF(YELole^>HR9xk)8SbN2o4mVHZ52AYNH{
zjhoalVn#tLroBs#)aX>V5VuOL{5!zsbm-{OF?PKCrGF_YnsiP!9%MtXN<f>X7X;4(
z1lq7ix?K%mx<<glNhY_TboC)@ql;1a+kEBXDSL^<Ipf!ziu7C#&P0=3Dj)vfv+#5<-H
zY9P<(3<QSB8?(&S=3D%;$nJb&vc-XfN@vWb;*?=3D4=3D(`OS!`6<7;+t1JS7H754`dix66
z^ah8WWikLcS0PkyXKwg2Q*u#JPPQPafjt{VXHq{|Q&LDesk5W3Wj$FyVNDS1?MiRg
zmS;J7fYsHq&(h{~)~1i4SWORAYoA;3*~N-9T)R0XZ%MYr10`Dqhsb>>d%j$mA28Sx
ztIcI$3yspM#i^&oG%yp+`mrHNfQ9VT@#o8GUX);Bv$_6uu8rW2;0l%G7~xMhiLc{(
zn;hvXdQUV#$@J<?IQo3oVKWS+J)!ak6QvO^ifs=3DMWRkmD`XhD};kUg`nin+B1gTyq
zG}l-~%aDAQ3{j7NC?@Y=3D4jDwg{hm(TH6Fboa9k}S5-r?Pu+`T13_9_6a%uZrK3aIF
z;*wl|wOM}KjKo<1`MiTs{n@5W`FB{55t6Y(05C1kla@9kMX7GL`?AWjv9)FCYaB<s
z1CbvOqh}WXxYaQmAbo7aHcpuz)O<i>WAfGt1w3#{u+r@xP>I&(>;AF4bwR0K@`h0(
zRv6T!j34s2Hf@u?pYt+^B`+XQKsP`B++SH(KwJMU4gx;`Q8FarX^yjITS*mc=3D4=3D(3
zr`+AsXQoeH7M4dSp&zOFWm6SRNdLh_kaDR}FjXs743)}V&UiEHY!SCsNZqm_ilFjb
z$`KZ*KZkd(f||;M>b$U@QtD(d-^HngR0DecpkjX8z=3D4`82E2WRp_p*D(G+mUB7A|z
zbyyxKPUh_EhHZFVvNMF)+wvNIqy{VLbDm#@i%?j-BEdinq8w8$QIzerh^d42^&^I@
zXjkGvy3rDkwPNbaQI59laMDcFPrdg_qpvN5W-A2nKKLX-@=3D?iQr^yW&(E4ynYU~>7
zhg+)kZU}6iud}^;D;?`~8_(t7@7RdnvPe;ad{0a7ti|UbOQ)qu16>@+ZCJsq$J8F@
zTp${LmFiajap{{mrJ)h7&TVy}qPg7OY_(b6QT%jOR=3DW^#J$!ucRSPcB_roh4{%m5t
zGcX$I=3D+?y=3DJEoo?P8~1467;z3e^8Beh9f+;vZ;O*IV&cj%;hj4PJDkL%BX1CuByDP
zDnU0rE$siZ*BpSDU#J&?8t$Kp!x{Pl=3D%*Z>J0yt0yBY59kBq_sYZHnI&bJ3K-@%#%
z2xu^P*I{=3D}2yctD9xjrVfp}2;6_tpf@3+7$(Q|!LXTA8y370_wIO85hY1vHUf`ey7
zCQU<&awSIq_&4hSTij)OU{mPZfLo662$nfxD2gHI93Lda(##CD>^?kf$QV8HzS)A_
z5X~shXkDzgzU4V|SHSVPbANpMR!l-BJc0oQfj+q-OQ4v~TbF0RE+tId98Qe)@Sxpn
z8I9+NfB1AksG4`(FJ%6+m(n*wq`k4cJvVK0&cek_8c)6T=3Dt>D8!@PO8bQdv?iwvhE
zpHmt_x5LT`z)n*ZM=3DTRbI-MM5dJuh|f-_62Os(u?k>U2U#^LmNG|k)}Fjp(Q0iisQ
zvPWSbY<N2vcZ0+QlO;ZBNZSwBcOfBMG17fo)3iPWd!>cCOYb-rLI;Mm*jq91_U(!H
zWqUCYtF&UQO7>7L*Y1=3DY=3D__sl<vA4EJ#3ln40|X!E*W0_?0J`_i~fTm53nLJZAxk?
z_<hj*9yh9&s`TR2)+h{V0%78vXPxZPBN7Gn=3D<n$caO*ij2Z)L6iPN^)?S`<R5fX@0
z+h$0(B*z%&iqXA(?Jeq_T%6F;tdJFsO|OH?+v}{N**s9d0f%J~YX=3D%@fbUSGdm{^T
zLMQ8exGn9f@-|A!J}kL8022T<U3q17^`byadW>>C^C-J6)<%r7a8}6H<9i6qD5*m3
zkkU6S)WN~HD&&SU*bOMb*@w1Ke~}EeI;Isq!pSLw_UhdXe(v)$rW{J6o?16emDiXa
z3_o5gFuMxtF~m1Z__yrSKPas>BwYXmyi+wU0yh0y)|p3HVDE%%-uQrsyD7}$#ptu#
z--&JiAZ%U5w8ZZ-9sve|Zpp9kA|^bee9CV#6>W)A$5_k1J$Br}oCYOwzfC6Ea-J$E
zy4hFL6BUatHX5HJtydyr9%xWam#L5-JUzeU|GZLlfvnp>wUM3<XZB2TXib0iTA)7@
zzD;V@3+?+FcX#8{HN?ytVxjiEC>o&=3D8P~eQylNN9%mt*ay^$Q+1Lkz#OKaIS(~Y8=3D
zd$A$kLEMW#jK*@~Y$2~Z1O*i_ke&qj!@<Hw6!;o-l~@Q$Y#miiKp;o7em+HWiu_27
zIAN|DMS4eIB*hN(mU5A0-jtWCqZKm_{+L@b`WK(k%(a3V#utWu&>y*7(Sf&LZ+-l}
z=3D*1Zx#-3el<kvr{dr}hRyH_x^F4WT&)(hHPEG_XP9fHN?d*^mB?PFd~jlAcFQFejQ
z0?3AzQaV3*^q@LdNWEBa(x`_kXtZ?=3DWfegpn~%qGrML$tj3V9$oepnBN}gtfkj=3DV;
z>lo`uOhcltIal8a52KLPB86JEI1$t;$#>^=3DlJ5~arDFy6Bvj0HSSH;Fu!u5Hdg+{J
zE;78UN9qZS-{U|n3W9D1vx{S<F&Sm9Kz{_)&&hE05omt%DfT*6y5yZI<HmEok{rDg
zGS3(=3DWd|1pw-fCcuYL)Aqm!$n*^@y&8O9@DS@ThD-k6}%5Zi5}@1D+5yDX*1$5)^O
zI69yOcV`*gq)=3Dn2r6+e_WBqyk<wEcAnqV?(LFpE!WO-Sahq;Av#BAT=3Dwdn(&hy2My
zvG9g_1X)sOE&ViOzMzEPWmm_pv4v$5`aFER@Pr?XPjs8yOBLdfHWxlAI_{R-l$;+q
zxe{IT!ZLE$_&+JZwNlvXlB+0r1wD8~K}lX8N2pnD8U+#Aoda|apN@F}vV#*jK3eo8
zxhw4}-b<%np<MXdb$}DpcCO_CL~rssAMcK??taS>b&#4MyfVg0I7~|lPK;)M7;%4V
z)X#fH;RA>2x@43o<9PKr4x;GG1|xLI!ktYwN<2feVdO*!Gs5a1JaDJEYPgpMxE&4X
zVdO4xy?{Xy!OJ0PR)QbVsf%!0@k!g|v$>tn2$$v_uO9s#Q=3DPE=3Dk;36-T6DOj8LH{z
zvFM{)3Z)hFljB3!sgQ-<qgnaG2qsbkh51hjw>zw4WTo!ZY1kx}k`H1-T&_qCtK;%2
z*3hvDs+fiIkBO}q2=3D@FU31l)i#r&3suF+q!DTAuvhGl}Bh`gAq_%@f|xd~jG51LX9
z`1=3DN&(ziVbgbnfZ$t-@tU!vUT7l_;Bh^C^hQ79ptwmnV3+MZ75$sgxi)n!AdRN}4R
z8YQuJ^AwtqUmB{8b+8X?EPsBKC`3#qBM+jw5eG?z&W<!Q2fkNSkeK9}kGaOB(AAF|
zXCSi5Iy4~H_dW`~ygv3>I=3DpS5vrx+?Wrw}Z4p8DN@Ve<*U4KO$EJ;-kxD}roBZ}XX
z%ud#zG!=3D8nGz;@F+iuua4|-JT2tU#+C{$uapCvCr@k=3D?aDonw2d^}2#)AQ5f(X>3R
zURO{(eEhzy5>?7K&%7fA@l;orMA$WJHvwikshFPAqjkF~R$V30SRpNrE#{^j-utc|
zGHhx%^f&mhK8(@O)``ubSEF$?69-+=3D!#j`&6t!}iho2qJ1S<%2q7!U}$U+VBM*5ot
zYbc%vFp)~=3DCXf@x#7`T{43JWHgc=3D^fO77KRCOlV9zy`=3D!S?!W$D%oO7ZKl7<9$W2~
zxhsL5zO9VjyB_eUk)f%RlinA*ml!SVZ^X@C>_D7OEPw6OdR?kEdTJEBNRTFts53Z^
zKjJ!Sv9gc)tUQBIX4))8*LqpoPp%BVpQ6VE8s(cE<M0BeAO<SiC63)o<cW4hQ5X91
zX9q#_xF)Vl4w#G16VuiWH}rsVLCnNQ&<DlmnVL1n_xP-h^lR|O<;dLn+N#gE_vkf(
zLIE%PWsK||Us&Ab^3NbQa{92a3Z#z^nMKmR3_G27u8Xi*dnoGQ?@WE-Z=3Df^M;*I+=3D
ze2aSa?t7R*<Y(G)5wqEKYlBvnbl+y;dXK9mB$RMHlVX_4c3Yb4PD~coG~TL>HC)Ui
zy-s$uj}IIEkg+CaMW)<)fH^j{C9=3Da=3D?f)(}Fu_$jvdM^|Ni>JJ_B8@4cT|5ux6YPO
zg;>`;3GXWASIYWNWIeiG6=3D_2->>QCA^OQ@%kjX1lSFRKVqq;oiBZOBw)sPdksHe+M
zPs7o3`YAHB^9$u0-1lKy)C9#y2weCr!4*6TNX<G6SSSzY_Bn)~6EA?#{GlFqi{R7J
z<Ifb+ud26n^zwxS4w_%@G*`rN<5f54$CX@1EN>9Lnka~{7=3D<$?u!#L}#hQ1L=3DD|<3
z?=3Dx$I{qrE#lbK^heYA|nPCyL1J{oy6Cni+pf%z1!0Y(UO)uDuz`l8h|&Ip4j-n%K$
znb^|Sjgcau=3DsC9(WXv#{Te{WaGPV*DA4DU{ZhFJM#;wL`3o6sIYdujcxjG2^_`L{=3D
zTSd^eg~pq8ioYzTL$M2p9^$pZ+?mU?0vY-M5-CN;#x=3DmPQwo!uZKBtmKxdSgn~N`-
zg>ibh9I<ayC3XuH_FhCk$|sGh36<9!Rw0{3DwuAX!Zem44Im6cDsL)zE|iZTtVFVz
zE&X;+wc^#QRPMUCk+8a#yLsk1i>>N=3Dd`S*$NiPn%75Xj5TB+F=3DqOITYlNu+KRf0bw
zwAFr4wz(4D_m8ZDELgx?UwYZ@O`(#B!LNLm4|aF7>B>z#^vZuUp=3Dd!lAB*;k`$)?0
zV!FfQzTwOFfW!}zycK9kdvSta5aiU7?h>^JpKY$co)7PnV;ms3zbnM%xpp7sEQ@JV
z>=3DH-s<vGRggG_Qy7SZC$bpupm^Bz0^mnL5{4}Si1VL7?bM}p5Y3mAD2om)~e?39yJ
zAOiPzNm1nX%11dnNI{?`D<xzt?yn0nC@wzkTDdZOSe*G%e3SwFhIe5{=3DYGFzQ62BN
zYrlD5Z`dJ$EAfhxq{@@{!%PCOgRB5XT@}%$d0i=3DzqScw*glrtoYfx|gwGgcW2?Ez-
zdc;-5;sfKj=3DT;Qny)54fL4_E+=3D=3DimEpc~VU)<jXtyYOTldJYA){YY9ewTFvXEQ8_7
zr*9}R!qKqe1Cj-^c7d<8f*Jw2vo%>Ljq13BgsglyseDUKviRp_5YFq@nQxt(TwR#2
zuw3!<DKg;s?Z!8i9j;psj~fzOiq{E*aHv1Ep9j&+Tr!25&2QR+M4mC=3DyO7AqzWc$M
zUx|%|12PGxbS>hu%e3A$GpOy=3Db(^az<xaJjnB_XV?pWOB;xYpDiJ&&f?><^yz@^Ht
zz45KvU>0<j%glbWNmI)#tfF!&_q2OpnweXm6exGFa~tW6UivtctI1ZjYyPpS(we(O
zw}g|dIumjC2wV0Y!r?NUcZlgbOvWP$-%iQ~?bJqitz1l!H|=3DoK!6E`dL`R5=3DonBY)
zM$7QN?VML=3DcFGd=3Duw3YoHvwOBP8vCjCh^#msR`asBaGUA7oU7X?t#a0bHgAvZI~uW
zuC#X?NohFg_)N~5<+!o?2kveW-+8N0j=3D-v7g^SULHj0*+60zv5NH&B31X8kK=3D_{%Y
zN>|e8*SJ<Gxd-27k3V8sp;!<rxAN2hiHud`+$C&vr*pu`g<-ReqMlIPB8>@kEo9qM
zNt+Rvx}bfHku4Kmg1Gd!C`YQyIZ+dUXyIViN4h{8=3DyNxCf{0g?2ir6Z9=3D0I_wTM%W
zfubLU>EFMw?ij1J;Vxxj??{D#)?^uEPl<;vGP)FVg-4qb-`qd~Z^9Ex&p97k8g(^G
z6jT=3D3(r$T%EJxh*BR57(f!Wr!UU7>RYJA%%Er!Mp(}ivD8gs?2!v^UFmXvLBX2`Pa
zitH?M3M$`#Rg<rNl8{+(H*6Fzt$ku{FyF}Mez%cGzhPF$bVavOkjzl{iCbWElMsJ>
z(}ECAqnR#=3Dj{E6OJQ9HCTjp((<Ym<|8&?R*&IOVWnvt2Sx3{y7V>GU0ms9!&=3D{BFl
z;Ws~QGx<~67INEKtx(`dAShw{a8BWH@V9~_q*Oz@mTQ|&Qyw~oO`=3D^QBKqBALi}X>
z0)~wpqQZ@&o#cGNWc=3DOa!b0<%fRrZs>ubTD8^wZDLFSuW@iFWiFtYY=3D&lK~d$l}7x
zjQY|TSN}}cFuaC@xLea#H49%Skcq0I4Ht+w6YV*Sf-)yPV<@>1*3%!F_d9ZN#g*};
z#_)QGq*U<#=3DcD5*?fX2YUynneDZ5l$hHEsG=3D>@qc3^fiH3Nwiy0zCmA20Mia93BrE
dE1577BN0CqH#Fm#FvXYh820a5tN&N<e*ob!KxhB}

literal 0
HcmV?d00001

diff --git a/tests/data/uefi-boot-images/bios-tables-test.arm.iso.qcow2 b=
/tests/data/uefi-boot-images/bios-tables-test.arm.iso.qcow2
new file mode 100644
index 0000000000000000000000000000000000000000..373947a2f3a6b08934009035e=
7151ad845985ab2
GIT binary patch
literal 11776
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
ZIw1cxO@)iUIAr+0*E{*Yz54w{{}-})Lwf)K

literal 0
HcmV?d00001

diff --git a/tests/data/uefi-boot-images/bios-tables-test.i386.iso.qcow2 =
b/tests/data/uefi-boot-images/bios-tables-test.i386.iso.qcow2
new file mode 100644
index 0000000000000000000000000000000000000000..7c846195e552b948fd0b50ae3=
f4a39e9df65f7c6
GIT binary patch
literal 12800
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
Aod5s;

literal 0
HcmV?d00001

diff --git a/tests/data/uefi-boot-images/bios-tables-test.x86_64.iso.qcow=
2 b/tests/data/uefi-boot-images/bios-tables-test.x86_64.iso.qcow2
new file mode 100644
index 0000000000000000000000000000000000000000..9d9b391e88145cf0f729ff50d=
8383096bb3a8b06
GIT binary patch
literal 13312
zcmeHtbyOVRmTor<O#_X)Hw1!9;{<EmU4u3nAXsn$0U8Y!2q8fd2rdDF1W0iA;1(bW
z9z3|)aKmrby6>);H}{XX-prbrQ>*H$Z|`qc_1UMYcAZtNt)P4X002O@>)$u5KLi~7
zuQuGf9q?Zq?QaPDi~L7`ek-uI2b~(;VgdkQ<KXV;2eWeU{Ey=3D9{6K40cXuy0&wnxk
z2yn7|>IZYTwX=3D5ha`E)|=3DT7oJUG=3Dvi`rr0HG6TTd`}l6b24LRqq1`T^zgz#Ff&O^@
z-2DF|bM@c2)4_lG1_9h5-hbns{%_a*J_Cq91RL-ds{DmBf6TX=3Dzxc|(@_)oTKMwvs
z+W%SpS3K=3DMtN%ycU-2COX#Z#VU-2UUp8hX?+`s2X{&C>s-szwQf1&eV81~2gUwC8f
z=3D?&-QwXxaVJH(08YQcSH7IOJ)uZJJeia~-cj6`Q7u$!Mp&WAvrM8R@95n)83=3DwU3a
zEx>FMitiNCX+|l?^F0xJ5&{fB;|n-m8!rKRXou{_FtpXdOgV0@)kP5zp-T0aH$mtj
za<WX=3DjPMCZpJ<G4AuIFlp08@4Lx2ws<#gxJ#)EgOroL#ejFMC4kuMM`>8MVcomTIe
zgL)@Tq6(DuccTItS&3*T@M<H@@e1d`VimH^(+dN8(_!q$B0&jT*_=3Dt4QRaIY_GP9q
zW&Os^=3DjJ_tt`-G`Cm0%f`zmYg_NSAcN7|4*{C()2Aq3CO>)7+a(;K>Xcw!ABQz9yL
zCxNm902e!3R!C$|4=3D=3DXD{o6R31mtbAp}@FD{5J+b!vZTrX!9}x0lHQRNB{^6j7QMf
zsx`>Uz}`2|*3r@ek&A_@gz528@hVB{DM`ywAlWHk0g^15H}j_iiYyYs-2{(i!L(rI
z=3DTDUdh_g0o-(6nG9=3D>aJR0KK$0oDOS!NeshIA#+-J3(Hh1p^`M2wnid-<h95Sgh2D
zhpQqC6&3yx6@@B7EnwaYMGFOi(Cpm<xC6G9*Xc{B7uS}TsJ4DlSlQ=3DhX11_2^VHeJ
zjiQKtmvaTwPg4$JcQjrj50^{6J?x#jk>TTuAq{5bX_jNqW?++QW`eV^=3Drb^X5;4(~
zW`MB>R*2{`@Rx~HL*ym7Sei34br|40;mO6BtkqvAdP?+qG)nbYdktCH(E4&&?0&JW
zt*^7~y2E49R1j<IfQvnPbR%MlZ`2eb<h*V{r$e{-B)HA)zisx|Kg6HJed4+Q1osyb
zX;jzOHq?eM!yk+)ep`S>0?F*-hsTCw;RD8WgF!%WL|!rHCFdnffEWZ>TVF`TROJ^r
zyNE<4KeD612&D)7qm2Jf_6V(C>{ce1lFIs}&W}B_?-Q?p5npVGG#=3Dm}&I(2?kWfa7
zhh|Dip)-@B-66@l26y9!^K$Z9BHfT7&x?8(zrivAofIyWa)nEbqqt~HUkrivfoKWG
z<w#@#gET!ureUJ7c3bc+f92eQH>h+{Rhd)SCb&m}S9Z9k1%+A&HrIC42;}Q1<rNOK
z7x2>fFZ@vWfAG@~e~tky`S%X>mw)X4?#D&H(-8oWe}se~cSv+}XD314ani9nBsaUW
zQ+&GPlq+{gO?qdiQM=3D=3D`6L(1Oc!#hy1mJItQ33e}?=3D{>ZGe6=3DFzyI=3D%v#j4C>-=
?Ra
z9sQ1T$lY;HjXUJ}D~|iG`pJE9r{h_>LpaTyj*k`apWO0>#Z*Dk1b}&oJtZA<dMqo1
z_5ykg1WS?^+Z`B=3DRRUvje91~icAOE1WPm5s9;gJN)KxaWnTl&W>5<IAtg7u>>`5y`
z9$7oAlZn;$Zw(6ff4hmu)4=3D2Zm2X-6K^WduI=3D=3Dw1My?8^FC~#J)fn$&fxg;<f=3DxH=
M
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
J&i~ib{|mGmiBtdp

literal 0
HcmV?d00001

--=20
2.19.1.3.g30247aa5d201
