Received: from eggs.gnu.org ([2001:4830:134:3::10]:45387)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1etXmF-0003Td-56
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 07:02:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1etXmC-0007dm-AM
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 07:02:35 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46946 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1etXmC-0007YS-3P
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 07:02:32 -0500
Date: Wed, 7 Mar 2018 13:02:22 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180307130222.11d7467a@redhat.com>
In-Reply-To: <20180305065710.25876-6-haozhong.zhang@intel.com>
References: <20180305065710.25876-1-haozhong.zhang@intel.com>
	<20180305065710.25876-6-haozhong.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 5/5] tests/bios-tables-test: add test
 cases for DIMM proximity
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Haozhong Zhang <haozhong.zhang@intel.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Dan Williams <dan.j.williams@intel.com>

On Mon,  5 Mar 2018 14:57:10 +0800
Haozhong Zhang <haozhong.zhang@intel.com> wrote:

> QEMU now builds one SRAT memory affinity structure for each
> static-plugged PC-DIMM and NVDIMM device with the proximity domain
> specified in the device option 'node', rather than only one SRAT
> memory affinity structure covering the entire hotpluggable address
> space with the proximity domain of the last node.
> 
> Add test cases on PC and Q35 machines with 3 proximity domains, and
> one PC-DIMM and one NVDIMM attached to the second proximity domain.
> Check whether the QEMU-built SRAT tables match with the expected ones.
> 
> Signed-off-by: Haozhong Zhang <haozhong.zhang@intel.com>
> Suggested-by: Igor Mammedov <imammedo@redhat.com>
> ---
>  tests/acpi-test-data/pc/APIC.dimmpxm  | Bin 0 -> 136 bytes
>  tests/acpi-test-data/pc/DSDT.dimmpxm  | Bin 0 -> 6710 bytes
>  tests/acpi-test-data/pc/NFIT.dimmpxm  | Bin 0 -> 224 bytes
>  tests/acpi-test-data/pc/SRAT.dimmpxm  | Bin 0 -> 416 bytes
>  tests/acpi-test-data/pc/SSDT.dimmpxm  | Bin 0 -> 685 bytes
>  tests/acpi-test-data/q35/APIC.dimmpxm | Bin 0 -> 136 bytes
>  tests/acpi-test-data/q35/DSDT.dimmpxm | Bin 0 -> 9394 bytes
>  tests/acpi-test-data/q35/NFIT.dimmpxm | Bin 0 -> 224 bytes
>  tests/acpi-test-data/q35/SRAT.dimmpxm | Bin 0 -> 416 bytes
>  tests/acpi-test-data/q35/SSDT.dimmpxm | Bin 0 -> 685 bytes
>  tests/bios-tables-test.c              |  33 +++++++++++++++++++++++++++++++++
>  11 files changed, 33 insertions(+)
>  create mode 100644 tests/acpi-test-data/pc/APIC.dimmpxm
>  create mode 100644 tests/acpi-test-data/pc/DSDT.dimmpxm
>  create mode 100644 tests/acpi-test-data/pc/NFIT.dimmpxm
>  create mode 100644 tests/acpi-test-data/pc/SRAT.dimmpxm
>  create mode 100644 tests/acpi-test-data/pc/SSDT.dimmpxm
>  create mode 100644 tests/acpi-test-data/q35/APIC.dimmpxm
>  create mode 100644 tests/acpi-test-data/q35/DSDT.dimmpxm
>  create mode 100644 tests/acpi-test-data/q35/NFIT.dimmpxm
>  create mode 100644 tests/acpi-test-data/q35/SRAT.dimmpxm
>  create mode 100644 tests/acpi-test-data/q35/SSDT.dimmpxm
drop binary blobs from patch,
just add in patch description which tables new and differ
from default ones, like

Note to maintainer, please update/add following tables
  tests/acpi-test-data/pc/APIC.dimmpxm
  tests/acpi-test-data/pc/NFIT.dimmpxm
  tests/acpi-test-data/pc/SRAT.dimmpxm
  ...

If you wish to simplify testing for reviewers it's ok post
an additional patch with blobs and "DO NOT APPLY" note in subj.

> 
> diff --git a/tests/acpi-test-data/pc/APIC.dimmpxm b/tests/acpi-test-data/pc/APIC.dimmpxm
> new file mode 100644
> index 0000000000000000000000000000000000000000..658d7e748e37540ff85a02f4391efc7eaae3c8b4
> GIT binary patch
> literal 136
> zcmZ<^@O18AU|?W8>g4b25v<@85#a0y6k`O6f!H9Lf#JbFFwFr}2jX%tGD2u3CJ@cY
> q0}?#&4@5F?0WpXHVzIIUX<iVElM}|`0xE!radU%NENuUQMgRcNAq@cl
> 
> literal 0
> HcmV?d00001
> 
> diff --git a/tests/acpi-test-data/pc/DSDT.dimmpxm b/tests/acpi-test-data/pc/DSDT.dimmpxm
> new file mode 100644
> index 0000000000000000000000000000000000000000..20e6433725bb3e70085cf6227f981106772bdaea
> GIT binary patch
> literal 6710
> zcmcgxUvJyi6~C9H9O_E4DVt54IBf){ZQ8C)^e1&vY#1z&vZYv*8BxwMFc>Mv!Q`St  
> z2satx2E`NwaMQjOT80hSgA(XD{s`Mg=tt<jLWi|^s&@{_ODnPov=5tr(D&T)<L{hv
> z@44sR%jlNgUOGbv-KeZ<H7i%SX=*z3Q9=l|@vl;sZV|huS5_UG5+rIrO8ISgRAlvi
> zy|S@N|Jrr`;=1>~aB0UQo6nV}n;q}*6L*s!=>De17&eqe$ErAXf5Fu1dD*Ge^>q0g  
> zCdy7(ZxPwqsOwZQ<N#BZYi700K@>os1~+PE+aPH|zWFglB>Rzq^4yJTQ_q<#-N~s-
> zj@2#`4|`k>yE>n_OmT<luLmv}xT%AK5gAT@J?M}>chclv|4EF<h|S23*0Qo$HocdG  
> zh=H6)gzOUKt&8Xlx@-4On>Pz3-`BKAD7a!4N}52}fwG(!gK1LTDmwuV1{QIb^P0e1
> z2JXK7yNk$zZxT|wL{2o!YLk+yMAXXI5VZ>YQM7ZHL~a<_?EVL>wg#lZkfmU-(BFCX  
> z+A8&kM-*X^&{euac8D;wOYHuYwTd3WMNv)qqY?$`zvvQ|P<U&LY{B0}0phj$7mW3d
> z=*5}2$rojoSR@Jp%kqk@MU!|U^k{+2uhQ?t??fW4(jUYhV4xP4$$OH|U07+DWj@&}
> zdVMyh5SC!;EKk`!6WCkuZ<Z~v1NI5~p3N{>c2@Li_7qbw4aa{12zLM14YM8jDiL))
> zn0g#icQ^&pJtEJfC}xFaR_O!rfhfz1J>Q?Iq^%nTKBx&AWFV)(35lb5DZUhmyr}pz
> zD@aqEpkYG912Y=SBfJ!VM+P3HCLbnI&(y3oO_3K&h7?CZgB;w*!9&m4J*#>RmZJOu
> zGb)9GR>@bdfuhnhS~R5u3KX<TbHm8lw9?Sli29bPRj&#5d6W(gye=xeUAj&1b^8K#
> zkBHKQB~)>gHHK-g>dY})ZQ{)eJ=Y_h=auBs4(oZJb(laly@xxUO~OQSd#DU<11Jg0  
> zrqNu}$=2}A!EHLs4mwPVx-GKxEE7p(0A&ZanGp3<!X7c|(a4tf`R*oD2rOLkWQ!2*
> zVF&Cz*`mbTdg6A-{m#g>AH8`=L~n7e;A*30>v~>>M*$y2e3WE$u6`Xxb(nm}dR<ub
> z$q`GbOZDqoD+z#BK0D1)Urv#vpKQD2E9_$lc-Duhr(KA-i|rA1+x^A~2osVySdeKb
> zAXuJc7%MA#lFfZNO_E{)vXsHU6#UyI>P)Z((Ft@<%{qGBBA;WM_57Y0T-9WRF8T5)  
> z$7)&ht8U;0RI^qc`$OxM3G0x*KiPU=%zDAMUI72btryhetrzURfw5~7)|v1#%ooSZ
> z7k%@^3G>Am^Tp7-K4~5{h@TvNY0P}dH(#1CUy3nbvis{2L~l)+mjd%Vg>V;vDd%N3
> zrB3;it)_x8MpvN=XIIg+V8hect;3>kwyKc{HsvQ*Ml&~ZwY&GcPwxLdw{z#yyZ3i)  
> z-}#i-R5KfEVfoE4wo1u9*{5l!(U4Sr71?KL`_Xw6$|R@ZhNIP+7S&qD4GIMzPl=>y
> zh7P4>7D1wBRU0`#>g9G$O*{2wUG@le+Wpn5xBMyvz6Abd%9>fv=L>oCAlT0n>N{F{  
> z<+s9+4Z37c%jfgk*reDjY!6d|E)%d_+*WH-P}<5#`~0m-65sDIbPNd#)MPjK;1PFt
> zW-zJ1pgcC?+82&!8fzn0H4+%;&oe|Pses{Fezi8OSz1$$3xm4P%c+42J2h0$Nm3a2
> z;i_~bAb)~j6er;@C)7LQ8K6DtK3kK9wWC!2G#^jJ#G_mQ2d?7-HImx8)lSC+dhC21
> zaTX%>wvUO+W5Q%FLO-7DgdsTAJNxmPgxLm54}OrikXrHx6AW_GD7UjICKDNtWS~ts  
> znE03!M4fgZs1!y<y4xSaLcVE`kgO1#JjThO%tmCCPLR<tGRn!Q{dgTcE8?*QY-bKV
> z!>Spv34+g-j$DI7#7yKH6F47qFTgTfHLFfFUxbYE&x*JtF%6+WCdMj>Q8R;DnK7GY  
> zzMNlz!GNtQW8C?}-JRWB_eenrj+Q|sVX%MAV<oAXc(5Rh&D;Ho5!3)+4mN=aX1#70
> zxve{Y+{W@G8+x<FMElXjv1vq~kWn;Rl|~L8HFz|z)qs|H)5+P7-aiIkCd<sIS`IaE
> zc^H`31|EfA|33yT8d%4S_390HSXxe<^EcpOa)3U;;SlzJn;QPfs61uB(2+wOtX2Cw
> z>JAQ`|LUoWZ+I>e4(A4eby!ibq<vSOogAuzz#Z(xRfW=yi|YtUMpXU4z+yZ`>;0`u  
> ze8SYgk0~f$KH62w^9F3jP_F_PI94`VOP8}HmjCJ(gupFi;`if0@Z;T~cmRhPe34Cq
> z=Z&B_3(Z>4e7jNQz3)LY>^*6eZ-&@2(5!hlP52Tv8b}0<Mh#!UMgvK9up1lrE(*RH  
> z-yW(@u@Ch-C{w>P>vz(7Q4h8nsA~-M69epq1ZtIv*>mjd7pKNU#!xX#4ABp-RAdb3
> z9f%2<)9`NCJP8gt9$H4VhvcaA&`(r_GlZ{2&85rgn~;YFotyv<vy)G%tG)w?)s~Kc
> zwlV3vk1^{4N_7$PG!G~5SEm!w1kyKvz`<h5F!OMu!qu670Cg-nWAymx1d{^wAY)k@
> zVNQiI7OfHb?8~!QHpCIShcZ+SRq@Np2p#deLW6Ms2@MwhKL+8Z6dEl4j}5}~z;X=F
> zAvm_-IRu)~IRx5p4mm8RC0<Ukx?xRFv?;8#{#=BI9jKw|M^JhT1UJIyq8{9;#yU)`
> z>F-ppAfO6W^Own9P(zzH^cL$Wni`0BhY9NMGGl*#k|6?o>A)<<2VB)(reCJ14E;1%  
> z{6B#DWjc~G{+jsr_)1~0Lh$~9KY{p~U`r!JJ~;TtkAdc&-yba~xLLvC`ctrJ1vq&2
> zu!SE0Gzo?!_y91m0bu{w2^Bu*w970twy%7<|Ls1NkmQ<V*34EgxUcR{Fcim}c8_wA
> z7vu$1;r{&YEl4M;<jhV<xGO{ZvNJ17@J#_C0O>>2p!3Qv4+q=sUtIZ(wh}mSy=rX0
> z`2o{%(qko|B=AhFRJ~jN?bx{M&s7C>1PCK#<@4|*0zYHf{r9XwD8TFpL<P2j4%-bj  
> zio8+6hTVVHDqMvZt&L{*84O+#i8|}ARlKdE0aPQjh_ncW%LbSND17vYfpXRahbH2n
> zCC&=hjDU427Rp&qaOjCR=w;3dA8`U!ITp%UlN_3igMP?a8Hci1C})Ml3mizrL6<md
> znnTmEP|lj+&`cck3TK_>(CJtxXNAuQfv+=h(5swP;ZP+O%2~4<nvH{g#93!KbT$^s
> zS?4%(E)H7etdRLZSZXYkv%bcmuf;(tob@D!o{WWZ)>9mMDh{e~)_D${kA-s9(;Rv_  
> z4ytq3GaPy*7Rp%{ICLQnTIH-~IrMBSl(W9hp|8h5S2*h%9QsBql(U}W&~wK@)!Kr7
> zquCaQ>4#modhKDY+x7(o1gK_#kVAoMmO+4u6li)VpeFOMn}U1Wo&{wklmwI_odgmT  
> zhfs&MK8$o|43>DPLu*Ts4$Z+r4RvVm3hHJacA>h$F0yCAg5xsmBOo8@VK>>cVCir@  
> z+$}*q)GH{%BH;R*FCXfcQHFHp`kpTz>ivizF}WT#lRZlt(__?-Vv!!>*2nZ1IV4M@  
> m&!Ie~Uj`YbJ<|732EBR?k1p{43iyE-rx5nK4H`CdCjJ)(Bz;=|
> 
> literal 0
> HcmV?d00001
> 
> diff --git a/tests/acpi-test-data/pc/NFIT.dimmpxm b/tests/acpi-test-data/pc/NFIT.dimmpxm
> new file mode 100644
> index 0000000000000000000000000000000000000000..207328ed9357409e4098df64f951a29527ab52de
> GIT binary patch
> literal 224
> zcmeZs^9*^wz`(#5;N<V@5v<@85#a0x6k`O6f!H7#0xTF<7?{CKkXYsA4{4vblsK$$
> z<~5es-g6r$!~s>y0aC=#03w0rG8iy0L6|`OtRNOx9x8-HL3Fb)1OQdFH828oB7<-f
> NAqGZ>^~k~m*#MLQ69E7K  
> 
> literal 0
> HcmV?d00001
> 
> diff --git a/tests/acpi-test-data/pc/SRAT.dimmpxm b/tests/acpi-test-data/pc/SRAT.dimmpxm
> new file mode 100644
> index 0000000000000000000000000000000000000000..b308d09b94cb8547f611bf8eb3a956359a71576c
> GIT binary patch
> literal 416
> zcmWFzatv9($iTp8?d0$55v<@85#SsQ6axw|fY=}!gyBE{ozKXKD$m4(%xBbq>x446
> z-~!my0WAQ74{&KX11Qd@0p~G66~br~cQR_gg;}8LU^JRKs4M{r$zGU#4wx2Z7z0Qn
> ZspEjU6t0dPMIGFI0#J1?VA9Cu0RYf$3jqKC
> 
> literal 0
> HcmV?d00001
> 
> diff --git a/tests/acpi-test-data/pc/SSDT.dimmpxm b/tests/acpi-test-data/pc/SSDT.dimmpxm
> new file mode 100644
> index 0000000000000000000000000000000000000000..2d5b721bcf9c398feb6d005761f898015042e8a4
> GIT binary patch
> literal 685
> zcmZXSKZw(C6vtnha!u0~lD6O<%8~6xbDe}6G))>CXws6TMaV(^RC>L(!w>Hk5uvTa
> z=?OwFn~0>6QE?aCT%DZU4_w7Xa8Q3QhlA(x-Y@U_^4{nB<L5Y<`!)x_+-~*Mjw4w^
> z%`i>+4FIjXeHF7{?d<zb%lB689je=$-!Zg`qV^40-fcp?TeVcBTOnrKRL0)I>Ki?#
> zbd~4x^lU38j7uPR%M#XE%he6ZTQ*Q&J6g9b+3let=>toZbj7~2_*w9l)l9X!ZA<ED  
> zio5t#NUq0oAYzRd(yzje^{aF7>F4TR{A2%pu(_FR$MZ5GXAR$9KD)R1R8>#E7$4s?  
> zKSaUiN>-QO6jiZuF0R)cNaYvfAi4G^9>ZBY2_PxPQ%FUY$pS;>NJb73jZBd(X*`Ud  
> z&-i?NGNWsr%m5<tI2w@=GLtd7I!0bTACd<l&qC<c5FNr^YoH&AIlz379@GV2bIg2-
> zH#Rw(&VaKWSAn`&uyw;Nay{K~flM$F>_N+y9WhLGi@}b}bZ{B~9Wfvna9C14i?d2f  
> z*OHSUJPs*V!o?wVmjkaB@KVM|iS!gh{gzLcbA+l9fzfN3AxJX{@b5&7acT*ezxqZ<
> zws2T<e-w_6q9F2C4QnXNoUdp$bJ-!|t+uJUo2h)RF8+G~eC|STUg+$9I?Lg^D#N$m
> Fg+DfN!vO#Q
> 
> literal 0
> HcmV?d00001
> 
> diff --git a/tests/acpi-test-data/q35/APIC.dimmpxm b/tests/acpi-test-data/q35/APIC.dimmpxm
> new file mode 100644
> index 0000000000000000000000000000000000000000..658d7e748e37540ff85a02f4391efc7eaae3c8b4
> GIT binary patch
> literal 136
> zcmZ<^@O18AU|?W8>g4b25v<@85#a0y6k`O6f!H9Lf#JbFFwFr}2jX%tGD2u3CJ@cY
> q0}?#&4@5F?0WpXHVzIIUX<iVElM}|`0xE!radU%NENuUQMgRcNAq@cl
> 
> literal 0
> HcmV?d00001
> 
> diff --git a/tests/acpi-test-data/q35/DSDT.dimmpxm b/tests/acpi-test-data/q35/DSDT.dimmpxm
> new file mode 100644
> index 0000000000000000000000000000000000000000..92f2385765ccba9b8cac2db64a68a96caeaab373
> GIT binary patch
> literal 9394
> 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  
> Ac>n+a  
> 
> literal 0
> HcmV?d00001
> 
> diff --git a/tests/acpi-test-data/q35/NFIT.dimmpxm b/tests/acpi-test-data/q35/NFIT.dimmpxm
> new file mode 100644
> index 0000000000000000000000000000000000000000..207328ed9357409e4098df64f951a29527ab52de
> GIT binary patch
> literal 224
> zcmeZs^9*^wz`(#5;N<V@5v<@85#a0x6k`O6f!H7#0xTF<7?{CKkXYsA4{4vblsK$$
> z<~5es-g6r$!~s>y0aC=#03w0rG8iy0L6|`OtRNOx9x8-HL3Fb)1OQdFH828oB7<-f
> NAqGZ>^~k~m*#MLQ69E7K  
> 
> literal 0
> HcmV?d00001
> 
> diff --git a/tests/acpi-test-data/q35/SRAT.dimmpxm b/tests/acpi-test-data/q35/SRAT.dimmpxm
> new file mode 100644
> index 0000000000000000000000000000000000000000..b308d09b94cb8547f611bf8eb3a956359a71576c
> GIT binary patch
> literal 416
> zcmWFzatv9($iTp8?d0$55v<@85#SsQ6axw|fY=}!gyBE{ozKXKD$m4(%xBbq>x446
> z-~!my0WAQ74{&KX11Qd@0p~G66~br~cQR_gg;}8LU^JRKs4M{r$zGU#4wx2Z7z0Qn
> ZspEjU6t0dPMIGFI0#J1?VA9Cu0RYf$3jqKC
> 
> literal 0
> HcmV?d00001
> 
> diff --git a/tests/acpi-test-data/q35/SSDT.dimmpxm b/tests/acpi-test-data/q35/SSDT.dimmpxm
> new file mode 100644
> index 0000000000000000000000000000000000000000..2d5b721bcf9c398feb6d005761f898015042e8a4
> GIT binary patch
> literal 685
> zcmZXSKZw(C6vtnha!u0~lD6O<%8~6xbDe}6G))>CXws6TMaV(^RC>L(!w>Hk5uvTa
> z=?OwFn~0>6QE?aCT%DZU4_w7Xa8Q3QhlA(x-Y@U_^4{nB<L5Y<`!)x_+-~*Mjw4w^
> z%`i>+4FIjXeHF7{?d<zb%lB689je=$-!Zg`qV^40-fcp?TeVcBTOnrKRL0)I>Ki?#
> zbd~4x^lU38j7uPR%M#XE%he6ZTQ*Q&J6g9b+3let=>toZbj7~2_*w9l)l9X!ZA<ED  
> zio5t#NUq0oAYzRd(yzje^{aF7>F4TR{A2%pu(_FR$MZ5GXAR$9KD)R1R8>#E7$4s?  
> zKSaUiN>-QO6jiZuF0R)cNaYvfAi4G^9>ZBY2_PxPQ%FUY$pS;>NJb73jZBd(X*`Ud  
> z&-i?NGNWsr%m5<tI2w@=GLtd7I!0bTACd<l&qC<c5FNr^YoH&AIlz379@GV2bIg2-
> zH#Rw(&VaKWSAn`&uyw;Nay{K~flM$F>_N+y9WhLGi@}b}bZ{B~9Wfvna9C14i?d2f  
> z*OHSUJPs*V!o?wVmjkaB@KVM|iS!gh{gzLcbA+l9fzfN3AxJX{@b5&7acT*ezxqZ<
> zws2T<e-w_6q9F2C4QnXNoUdp$bJ-!|t+uJUo2h)RF8+G~eC|STUg+$9I?Lg^D#N$m
> Fg+DfN!vO#Q
> 
> literal 0
> HcmV?d00001
> 
> diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
> index d45181aa51..319cf84c1a 100644
> --- a/tests/bios-tables-test.c
> +++ b/tests/bios-tables-test.c
> @@ -882,6 +882,37 @@ static void test_acpi_piix4_tcg_numamem(void)
>      free_test_data(&data);
>  }
>  
> +static void test_acpi_tcg_dimm_pxm(const char *machine)
> +{
> +    test_data data;
> +
> +    memset(&data, 0, sizeof(data));
> +    data.machine = machine;
> +    data.variant = ".dimmpxm";
> +    test_acpi_one("nvdimm=on",
> +                  " -smp 3"
> +                  " -m 128M,slots=3,maxmem=1G"


> +                  " -numa node,mem=32M,cpus=0,nodeid=0"
I'd use new CLI syntax to specify CPUs, see pc_numa_cpu(),
so we won't have to touch it later when deprecating "cpus="
option.


> +                  " -numa node,mem=32M,cpus=1,nodeid=1"
> +                  " -numa node,mem=64M,cpus=2,nodeid=2"
> +                  " -object memory-backend-ram,id=ram0,size=128M"
> +                  " -object memory-backend-ram,id=nvm0,size=128M"
> +                  " -device pc-dimm,id=dimm0,memdev=ram0,node=1"
> +                  " -device nvdimm,id=dimm1,memdev=nvm0,node=1",
maybe use a different node for dimm and nvdimm

> +                  &data);
> +    free_test_data(&data);
> +}
> +
> +static void test_acpi_q35_tcg_dimm_pxm(void)
> +{
> +    test_acpi_tcg_dimm_pxm(MACHINE_Q35);
> +}
> +
> +static void test_acpi_piix4_tcg_dimm_pxm(void)
> +{
> +    test_acpi_tcg_dimm_pxm(MACHINE_PC);
> +}
> +
>  int main(int argc, char *argv[])
>  {
>      const char *arch = qtest_get_arch();
> @@ -906,6 +937,8 @@ int main(int argc, char *argv[])
>          qtest_add_func("acpi/q35/memhp", test_acpi_q35_tcg_memhp);
>          qtest_add_func("acpi/piix4/numamem", test_acpi_piix4_tcg_numamem);
>          qtest_add_func("acpi/q35/numamem", test_acpi_q35_tcg_numamem);
> +        qtest_add_func("acpi/piix4/dimmpxm", test_acpi_piix4_tcg_dimm_pxm);
> +        qtest_add_func("acpi/q35/dimmpxm", test_acpi_q35_tcg_dimm_pxm);
>      }
>      ret = g_test_run();
>      boot_sector_cleanup(disk);
