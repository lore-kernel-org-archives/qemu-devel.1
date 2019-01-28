Received: from eggs.gnu.org ([209.51.188.92]:33018)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1goEMR-0008M2-Li
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 16:22:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1goEMJ-0001WB-Bz
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 16:22:30 -0500
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Mon, 28 Jan 2019 21:21:57 +0000
Message-Id: <20190128212157.424-3-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20190128212157.424-1-mark.cave-ayland@ilande.co.uk>
References: <20190128212157.424-1-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH 2/2] QemuMacDrivers: update qemu_vga.ndrv to
 90c488d built from submodule
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au

This update to qemu_vga.ndrv includes the following changes:

- Build guest resolution list from QEMU EDID data if enabled
- Fixes to re-enable 256 color mode

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 pc-bios/qemu_vga.ndrv | Bin 14752 -> 18752 bytes
 roms/QemuMacDrivers   |   2 +-
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/pc-bios/qemu_vga.ndrv b/pc-bios/qemu_vga.ndrv
index 6e02f74d61e01c87cf50b10e174a6626bee13677..de81cfd1c57c30671d2017eb1899583fb1c887c3 100644
GIT binary patch
literal 18752
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
H|2+Q<gYV+3

literal 14752
zcmc&*e{fsHonQU1B+DjoT9<S1kGzn$rx4?sVweXu#!i$V*LE;O!RcIXkSx8#y2_T2
z<XFDEM9+4@gn?_Ffpk(1s6&7YL+H3O{i9rfIBm*ZW&(w2OUn=-l!Pf$uFw*Cp@HZ=
z-+e3TNtP05@8%5Oyxs5ae)s!pzx&<Qd*6tRFO4djH%G^!0mhi=7q3qIJD#~e3o}zC
zjXxc^!o^qyEYr+tHMCWpVk`qqb0(9qO&`se#etG$#W?Y2!nD84(9b;4MjfgFXlG~f
zsASB1TGTmDC};kNX6ElpnF5|=fK1z!20YQeOw?Bx@D`L8Q5_T92v`gF2S5n09k3Jd
zAm9+-FyQBacL9GfGt&aVR{_@pdH@(_x(je0-~g9`u?nL7jW4g-wAP{>>2ywvbuQLw
zJ6CG=cGfWFj)k@=vGq!9Ybc<^dqab4oqt%lUD*<fCt~AN?_b?bk2^v^C1UKi+CLId
z!rsuZ5@Y?5NVqE;js*M(jE$q~NP?{&9|;V_A|s)HR=RIx-M6le3=jK9g57ZxqG2VW
zunkcf&bop@_h`(Y2t`J`k*>jbBs_}7^-7|9B%#D&qtQfe7PsOT^RNt)Yev9nw|jLY
zI$nr#hvLylTq#6%kAxCgTz@PQRbq+pTa==>^<bZ^83~5`BkRZf(QB?>g|Tar(Y`IQ
z)sd0Sp)I#7{@_3)7BqCa_Unb624bOv!h7AZzE^OSl}>1tp=q5mRt)Wq%)@$z6y0`i
zB_4={qNF`{L`Om0+>@>Ffa>Q?G3P6vnV9Jr`15IIf@i!)-Y>iZzM(qIPaK&@e>iPo
zjt7>eXH~T}sXnqSIlZ4n)i<t9s_C|*JZKK49{YXL!%TZ!^~~8dVQK;Hv4NSY8`S`7
zRzsF2)@fELHT6zXn_yA&`xhV4-d;;%9GahS7Jm-M&Js@67z2Kf0e><_!+g|$KbFJW
zUo+qj>9p;N0k@C(rjC7-Or1HO)Q<AG?=rL}Q$I!9X|(O9HtVkpZJXwgwf)f0-d?2r
zIYWD$&X4Uj1J2PllYR;M+D1Ago;-~84V<!X>zrgwP4&!#XQj+Y7p#W!_L#lZ!~Wi{
zb+KyIXKz*OEy>h@-zPN_+bAz({i?(A#9`QMoyMf;304PNNz+H!^69skYmbRF?ODoN
z_H?mUYUlRdpFW$lFKpZP+e#n!d0Cz`zuuEhA4T~CJfFcctxd8`C_gO^S{9?c5#{|T
zUyHIA<-G?R7@J+f81Xy3gt_)DVaoxYwj<0+JbGB;e&So+!OXhPG(Ji7CPccfN#=lz
zzofAk;{`N<MsM3&kQ-y+4^^q3eUy~vNEcV`_0b$D=pa}-PC6nzV*F0<)2BVp82Bl}
zSV@enF^v7D7+Y5`)`PLz^syI?qx@7)`odA2?`2QZ82Ics_^d|TG2$QX`!Q#ghh5Pv
z+OZxi?~1lvG&avJ&~;J0V=d6S%IV&60kqd-^r=B#S_88|UMqCsK;4P@0@N!}ucCR#
zr!nT5QuE#acKXw-ol~{6Zee5V!k+YJZ=~KiPx>`MmZc<zjDL)DrZ6_cx1cd6#$So?
z4|`bci+tQ5d?&!H9=3cBx3f;i1HbGfzs%4$V)Qx0k*RlCouGF;==B|}XIHowTdc<t
ztH;aoV~Olbe}LGrocP4Ej`;VmMfVU7>JEx4?3|7h>r=;_)^U!T4E<gfxQ`9EXLVe;
z9+UL32X$P<KN|WypyO<MjL`dOI&W;Z-nPit78EqzGtlVQahDl+Z`X0oVM9Nc!0j^N
zs&!mtmiMLxeI2#UrC*|0VYK04qwgI}pUe8f^DC26XR`XA?Ma`1Q699;9ejjcf$~xK
zAlYIiY!L<iM4>Ho9v1MJ4qJHjx@`sViMm^_JGd;Ux9auF_!>lgxoAHw`U{zyJZ7Wa
zD(HQtx3ja*?;l{__jUXNt~b<A>h%h4Gt^J$^~<=vP!~2`!1o8#59#fdJQkz=kX~PO
znV9E3QRlivyQ<f1^`bp2>Nkk`CcW+ua<N{$UTzZY?PL$gli{aHZ?6z?LjR1%OuqIo
zU!{<<Dia$~e<{zNu;DsQkKy@ivP|ts|D{~4;dyJXpznP>=}+Dev@g~7LG=A$slLYe
zl8a+yPh!k=EyY|e#CVF+7=Ie_)wNpEY1$(Q=V5<$HR<W|$DOhtgKncdS?SY)%q3fx
zY1)c8kiO{jF6VYCrGq0z|HrzO2g_cNC(B-eeHL>&G%%^{6k=clt&6gEz1FoI-m<$p
zytWrQymng$`2VB!2&-%NMdPw%G^!$l$G-5RPK|Z8`$8kKC9zrHb^=$^?h7iiWots<
zd>H>gyDuD-En_i(3j?RM`?jKAEG}>^j19N@;^VSqBp`6KM{dmUh;qL?XgaM~m}?q5
zqmKD+TO(WgHi&u)cnrvvkR<AoVQjUb>}Wfc{sZ}BF(12B9^nnxI%G@woC`Th*91fU
zXLA(B3D`m-f5me`JSWAI<GnsxM-yWc&?CuRg|dccHDq$3JcTmJSB>$K7`IS7Gj#{m
zi{`A@W4sr@Blf4=7Ul(?8DGRc!jjP6Cg2>HoBWe-L9GrG=lAPZkF2D<rF~$|b~EJx
zn#$O~sTx@gn12AggX`}hf!k@WmUl9<hkfO!4|Lkn%%m>)U1#S+`k3&`dHGr~-Vb6w
z^=@ByL8?a(Vx}rJ#gYf>m@V}d=nvY$@}zAHb6-Qbr>rqXIb`aEkCFrbX6ryc@UiyS
z=7j}$|2#f+2tF=k`S><+t|tW_Cd#)`@1D=_F<gv~zfxZ0W$7-mrNM3<VYgmxpP4UW
zpK88$>Gt{XqV~!7j|6+FK2w#<(jTannq<cBa<P@$<tNbp_rTX5Ap1pPEAM*}eTPf+
zHO5wz=Wg@-nD#`(Do*P>Xf5Syn{sg<7LvgSjJcd44$e^CL~(mJa&H&p6S11sf?KC+
zuR?Bi9I<>z`##$w&w%z(*6Cr@Jk}ylu;F~usajZ-YB4>a`fB>2pO>H?8S@Vz2lVl?
ziDBO|%s+dP`Gs8eM$F&6yMdn%t}c}8aB;e&<RX1_3b}6RNq_oB%C)@~S~KUzy+K<C
z$(fV!%Y2`Q9G$a}Q_TI>%4D#WeI4c=h0d?uhxsoi)93Vo<wB-G(5)9fz|RcWYv<87
z`a-_%+IK+@loxz(Y2URUKwruWK2Kk)iSxVu20tf%Y!x!T2U<5kcMSUj`76$03qx>s
zhCawC79OW^p-zo57xO=zw!@4Z>WzZ6Kz6GEt_fkk)yrPnaVeYS(dX-y)~BNuv?nsL
z#04G=Ywf;!-(u`u>=miGkLX-mJ#fl)GqtzPVGlXQ?AUucFeVLL4cangYPVCnJm~n^
zz%g6Lz!~!8zbwXGLQ1F4_0lvjXHU`I1-;<B_oc<8Bgj=ndP2RN>V-NpuC4ig$Ytt7
zKK3-(Lhy#z$Zo+Io@loMM>4`UdE81$sO#~Q*;Q5}i+<Uhm;4quQz0Kl+vWSK!;kq9
z6L^k%iCF8{hQ6Tvx%%$yNuT>w##TAL^|)VbZRFWp#8lx^he7L}B0eQ+OPEiOJ%4_N
z@*u<*hWHcYd2ItTlRhZ!pkFoeI7gvgjP^0ipN)ND{<krId6D^hvoU=?Vm*)P3%Y%n
z6K6mh#XRJmon0Ewjb4I1>(IX%c(-aby{cNwMxKhs#1cO9X;1pU$1}PWK9cbP7i4zM
z!hcBCeJN%JSb*~(j#+W<F;53Z-!SMPyRYavD8C$YmKD)K6Lh;tx53BPWo@v8MTOoI
zUqJ7Lb6(Yx{_~z9bCTV~oM(?_=cIjy&NHw(+W$A^UxWD<6`9|SdnAT)nF+S7!dzkO
z-N=8kc3uvB+rdYbetrprxegfnE}pPceqNF1gSp&shVG2@^B~2E@;iIdAMYyQg<|?X
z<g{Y{{pb_#c3a0&C*gb01>L3P_TdVC-zpE5#|ck4Cg@#vP!)a({tbTWCjF}QkO_MO
z=~8V#JK|=BE{*rFir2{3k<%omAA(;EmVc)wefDi3U(TP!ohr{+{pt5b{Fzp_<;nLb
z#y(y|z8P&BGq+8p(=)YMITw+f2VO5Gr<3npeC-j>xwW?uatx_;T&B7b^11juw9t=-
zIX@x!#63dhd_($3OxI@DQ4;xCl;>xVZJjpnZg__7>&cE&KgF8ld1m=DJ?W30DUg-+
z$U{vH=?k>y(4K{Q72Qjr?wERu=Z<0A|C(g{2EqM}_9B-4Y`UIVN$2Pv2Cw9km8wND
z`lFZbP~-{ZZHQAIR=%M?E{aVpas$>5Xp!#lbWohalkU*l@uYoea<-oDf0P&J>}$Lq
z%iT}va{r{#hrKl;_pf`>e>#dh)R-qjZgZu!-LRe-3fGhA{Tc9uTxBx1#!SDF1L<^5
zCdb5lnM^;Tae8d}@D1+{<ffR1#?hUxSQ{P>bL^$DkjVo%o$%v7;rA8~c>N0H<<N`W
z%YJu3Jz#njI$)q-o5r0CJ!dWOLH+3v&jsRHMNjnmQoF`HygbD&7tbq1+gCA<o656O
zxR-`~M49wqn>_%T8`vV8-|O(CGqwcV{s!fRz|nc_1j-Wd8p?CvJu`O$WYhUMfO`Yn
zPYb$N3cAbb3EsYnareP@%+uT10`%iNgO>);pT=4;V^J;>W#jnXV&l<QDnUc%Yl<0Z
z&>hN4;tr*#UuAQaM{#y7V|A+Uit2q+bcU)pPWR<xyTZG2<KD^dyR7=Sd*9*X_&s~!
zy^V1%%o|VhKF;dAK1X}%jJaB!T1N3tp}A*MWmtO^U4oD7-9$-Rlc2Rzr=<qX)iVJ;
zeld-wGb-ZF$5j5}yj9(3;EnS$ow9*9=i?XSP3U$;_OpKU<-aST?12p%@LOI#e(UpQ
z@K_HX=(=|r>jLB4=+~)DnjYh832R+`fzx<e%$K!gCN3Iv%J(+hJ0f3Qj(w$<?m20X
zL0oKdVV$9jvxu{sXyM-Co3!?L-%@At+}<+N_NcQ;-#eX<$+UvvBhL2YbXG>$Np}X`
zZCZmo=nM`Vvvv$93hpLNrh%VYuWtt*E;c)d`EgI=+<`Un9-YzfJb~C>qt;>%nP3jJ
z){?wGg*!!@2SBghyUp4`YXRj&UX_<ED3^J6pgicDP6c02rgq^sRNOIv*53QyVm<)B
z4?tZ~YZ0?Cr@Gx-jr$oZ?Ny`?`EmR>FoWN@9%juhEA0pA-{?=o<U!|C7~4(y_a3lz
zAioPjPj=*b;Y^IfZ?V@veE!=a^w&(ffDN;@IV|?AOWjq{{yoorgU+ABHpek1+0hHz
zHM=ku@eO@`h0i<ad=q^h2cNP$SOJ}+zlZyXdsH8t1>d|G<2-;SjDb8A$obOa=v#?0
zVsLsmLz8k5ls$reos8e~+O@5N^3Jd%AE9_yK1{wM<h$fL)cvCZc~H7s_!j(}y+}M8
z{1HCrIK$}z54}>nBmEVnpNUhTxmWa?7nd@9WLhtzHydl(jb$q2s>J=nF!*Q%E~87A
zwwbkPce7UQ2_{e6P4Ua|Lm{h~Vl>Y4{{^1r&1JCHj9729hMEj|q@1pw_E8VBHxf-g
zcg~J3$U$?!$Ist`zAec2TD2qK<NK6LI9AXYqd%33d#VpU{QYHEf0qCBTKO3p>(X+3
z24@x3x;9E@Zc#UjI)01c?N+`1$tM@neco@QG}ps?uK&>I`s6vHh4brsln03N8{Sm5
z{K~*wXLD-Kl0=S!yJ?h9@v_<Lb2s<X*;3?LM%!n88<c<RtRj1AHa&OA<ee1vXswcO
zdwsa?wzFpZ-ojjE99PY8TlDol4IIfwV{W+8S#^UM^c?f)@i8Hcc?U5fg!OC{`H2N*
z$}Of>1#QQ)f_ZFw9vA4;c-grflsDpc2Fm5k(`bXODZevOIWsrU)4S5Y6Mo9`boIey
zN%gsvNtxp6B>1WWUx<SlIYH;_0OU)Z!Fwx@o2#dOhMaUia;KxrjkRzc*7CjdZV12I
zUi*ur_BP?q?}0Aebj~o)IRrke@HfQkbK6n247jbhk2!Z2%BF$SysV&Xrnn9KH&HGV
z{rgb1i9TH@+d2IP)2m)9?@M=|4$*fh%H?XqdzrRHsMEZ-4>?zMzsiR0-^4cE|168*
zw+iy_PPJZ~+3Q#WeJKXya)0Qn*d7P}qTf3t_}d(4FTol5IzxE{^j0V8H=~XGpZZbx
zG8uaQ*V8QTcO~Q6n)iMY{9S#1C4Z-b_yg@Bya)6>TA#Ty49EA=`IYoQ?+H;m@($y;
zmh3r5{3e2a6GiCgzuOpMVdniA@}W$e6Z<;isAU7ufZpcCsUt>z!+FX3pshnayfUet
zyf)c(3cOBM93p?BSdBg0z^kc-=jix-OSM?Oi#a>_dn=O_N9e4B{r5HT?#W5=1uy&X
zdGvA9ehK|NTUUm0k076GU_bCO`w`gcvE4!VTqowoTEU+40DdQ}BpFby)2yt@#dw+a
zsuQ5`G(aQTY8m%q!k+<dFJMT>4qW9z)F%L5S1n(Yl|&2YNam{Jb!j)^g4beyp4KDg
z?pOI;>6;z<(C)=MVX4npGsag_K7jc;_4(4Bbhd+>dq{3P?-6<9Jm36+`}>Uey<{15
zew=8^n!cv7uk(CT4cM=PzUX(=7RV>hOmO==JOkc*Wz0OgAGQ$VFy<caX90UFc+ch@
z8GoJtooVuoN+`1zajjf`_YL^g68NeT`05h)-V*ql68QEKcvb@MDuI_u;9E-IttIeH
zCGd46@Nx-!X9>K!1b%r5yr%@dvKXH1N_es>*_YmHq<D#?^ndhM>BBNQ1~>uuCEzq(
zBmObqNx*}E`v6#CR<v8^0J8wNvh{kvm4JneSuOzH1%Qs_DZn;BAK+TRVr-#lzz2ZW
z0WSj{1E7yN2-+A|_6pzy#>)Q$_%#6Ui<UnM_zoZrxD&7ja24Qk{0#mn;BCNRz+M1o
zIs5?3>G&F;7GOqt{~q8cfCGSCfI+}Izzu*#Kow)Q^MI28^s|9?+qVH@fH1&;SD5bw
zBmt1Q0`pfO!a3gr{2YM(PS9{p1F%y#A&;{kIs`pR7b=$l7Glg90Q6UJ1aJsC^XkSd
zgT9S__0?1xPALCGPseR*`ZhG(aZ49fiu{>O9BI3}ncnIR`^WF(FG}Ben=(9FdQ=fY
zV0a`L+qyLrj1bA(tGrTRIJi0zRBmbvI+=KNIyACH8Ve<cq<F%g7>%Pza(yc_61-7r
zOs;SW>Id<h16k<C)Pgd}c@|~phV=rVCpHa8dSm{8f}wGzcpaSHj}H06c=LJnaFAVf
zm9#b#izlQ2UcJ82$s|cKaEBWHI;F;_-lD%x&e_7?c`bNnIuVP6sYxF*81ct~YggeN
z@R$;hON}jZc%vkceg0@v3DO(bI^M~6177?t(jD0O{nw262g9VTVP!ZH8<*lyh}zuj
z#LL=fQ1EVhA8%MscqyhNMq?vNP$E_9uTo1P=mHJ#(QpDP%HnTVVC(?bkKS=DI%ZX-
zqt=h&#qzikRDz^N9hZ|InrGI1fEfU6WqlU#GT=1e9M)nbKmxP^+5xaz*=zy8hVyXL
z2Wy4L3@XnEZZbAu0la}P{0ThZr#TL`<ydQ&%jO1n0ibP50CoZ%06YZ1y0L*z+X=(C
zlc>KB_*CG)x4jO~1ZWqyP2#DFXSkrA!C&gxtIN_83WxDQK~}5u4t}o2U$)OxSBLQl
zK(2agR2iY#Jg>h+!D<R8JorW-jBgtBnFO*)iYs9ykch-?Y7FTA(K2)Pig*KE@wj7r
zLWfQQBd)Lvy<EKAz~wD5e{?8B#)~QVID$TV2q|%9M7u*VFj=AzA2<{nbBiCJWps~h
zj`ZS_k34F(D>TDah4=8%ddX`BJ>HU!jQPj={af;Tf+27@p5IYPP``ZsiDY3%tfFWn
zmWX>0C&v6SW%Xz*9*O1A0{x4$x?}#ai!@`-{8s9}9*bq34B2lm@+Qal;tk-6K7pYR
zS?Gx%a@UPg9HpBYlhUw1{w+M6g{1fhqe(HkKQe|-bmnn{iA%K5n3%E|-_9WP@Q+l)
z=QV}1eZF3+{BcDD+(H7NJ_3)!w<m=yeF!myIG8SmFN2CT5e{GZAXMiKf+W26?aE!F
zSe^*YK_!|Pq75$!@8NqQ+!Rrpg8Zs3gy?XAQrBan3=9>UbDfe*;A<uN+^C2Ed>`-k
z$Na-_{o^M|uSjwKIQA)>0c@G{XV$Q<o<g1_p}Z0C8#tsWtPDV9TPL1~#dZx(Sv*nK
z|McCpudn-7_=rE)O#73&dwqZRo!#!68e3YE(j9$k`bg%!K_}ZV64zG*l+o>$mLe(8
z)rt_6NI(s=O(psNPPQ(RkTyp~M}pYLq%an^v{V|6ldgiwW<T~cOvO``Eq-b1HO(z8
zPIkwtUa&#me<^Su(Hk2jD2T7IAhZ|8ASybo1bqZ1B_dKhG&~x{%8@{Xq}afxD&9=Y
zNqSRU|NKmH-MU`dDBZlGiN;GK;629(s8JxNN%hFg)dc^L$h0|`r6Ir3I{tV(v;|xG
z)qXv}K)~th>hEn5Rko_@cH|acPx9F^ok^+LhT#xMU{>QWDJni1%j=nlM5Mvc7Q)en
sM1umzbH?y-7-u#x?AL2jC=P~U*d}QVABJ&7MuX5B@0M|k|F`G=0B)l1CIA2c

diff --git a/roms/QemuMacDrivers b/roms/QemuMacDrivers
index d4e7d7ac66..90c488d5f4 160000
--- a/roms/QemuMacDrivers
+++ b/roms/QemuMacDrivers
@@ -1 +1 @@
-Subproject commit d4e7d7ac663fcb55f1b93575445fcbca372f17a7
+Subproject commit 90c488d5f4a407342247b9ea869df1c2d9c8e266
-- 
2.11.0
