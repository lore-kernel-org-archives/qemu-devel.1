Return-Path: <SRS0=H6GY=TQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEC4BC04AAF
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 12:43:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B436020815
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 12:43:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B436020815
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54244 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRFjE-00048s-W5
	for qemu-devel@archiver.kernel.org; Thu, 16 May 2019 08:43:21 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49295)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hRFNu-00028N-DJ
	for qemu-devel@nongnu.org; Thu, 16 May 2019 08:21:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hRFNq-00039z-Fb
	for qemu-devel@nongnu.org; Thu, 16 May 2019 08:21:18 -0400
Received: from mail-qt1-f179.google.com ([209.85.160.179]:40042)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1hRFNo-00035H-UL
	for qemu-devel@nongnu.org; Thu, 16 May 2019 08:21:14 -0400
Received: by mail-qt1-f179.google.com with SMTP id k24so3555449qtq.7
	for <qemu-devel@nongnu.org>; Thu, 16 May 2019 05:21:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:content-transfer-encoding
	:in-reply-to;
	bh=wuUadsTNtZ98BRB36yzVIwkMhaMd+s3fY+m2koTAtvc=;
	b=gNomLUrG7evV7b7jc7DwTmONgWfbHvo2MkM81bSV0vIZDz+AcLpDjn9NGeH96C3pNS
	CvUvBsm4pMShoF3/sAJmUCKEn3orNVzrTotK57rDjt7xRQwpdRdcS4hdM6lFOEGT9XuI
	ntQWb27sMJDuKU7vHEVJuWuvSO/4ScfJblSc4MiQfYbzl1hrEgpVaUQq3MAk4+e7W2+s
	ZkNx3KcAteRdqsM8Otr3kqu1XtR7kBK16CmWTE9jgAvV8wx+Q3XfISIaRXkHL/Cs9qcr
	n8yqcjv4+PA23HpZ3dk4V0ofUpRGODdDQ+jHxcul1r6kEpzqEmsVIsZNWKVLGr4VA7sK
	CLag==
X-Gm-Message-State: APjAAAXPAsiK9rnuFA+57c0IKCo6v3tj/XrY8AdmvwTAngN4FAhYdtYc
	t2OtQXNW/rg1KAdxx9ge1AIFNHTBWwQ=
X-Google-Smtp-Source: APXvYqznyjNRoh1Td4SascxvC7d8HxDbsVmolRVYVpNpIEsDuAoTtCaHp+G2eYc1CN4g9vFZCh4kvw==
X-Received: by 2002:a0c:ba99:: with SMTP id x25mr40228955qvf.212.1558009267736;
	Thu, 16 May 2019 05:21:07 -0700 (PDT)
Received: from redhat.com ([185.54.206.10])
	by smtp.gmail.com with ESMTPSA id u9sm2239405qtg.91.2019.05.16.05.21.06
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Thu, 16 May 2019 05:21:06 -0700 (PDT)
Date: Thu, 16 May 2019 08:21:04 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Message-ID: <1556808723-226478-13-git-send-email-imammedo@redhat.com>
References: <20190515121146.7248-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190515121146.7248-1-mst@redhat.com>
X-Mailer: git-send-email 2.17.1.1206.gb667731e2e.dirty
X-Mutt-Fcc: =sent
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.160.179
Subject: [Qemu-devel] [PULL 34/37] tests: add expected ACPI tables for
 arm/virt board
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Peter Maydell <peter.maydell@linaro.org>,
	Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
	Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190516122104.oPL0QFS4M2G7PDwsXnfkLGgZngbzSUMtaZ7PjGxTGq4@z>

From: Igor Mammedov <imammedo@redhat.com>

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <1556808723-226478-13-git-send-email-imammedo@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/data/acpi/virt/APIC | Bin 0 -> 168 bytes
 tests/data/acpi/virt/DSDT | Bin 0 -> 18476 bytes
 tests/data/acpi/virt/FACP | Bin 0 -> 268 bytes
 tests/data/acpi/virt/GTDT | Bin 0 -> 96 bytes
 tests/data/acpi/virt/MCFG | Bin 0 -> 60 bytes
 tests/data/acpi/virt/SPCR | Bin 0 -> 80 bytes
 6 files changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 tests/data/acpi/virt/APIC
 create mode 100644 tests/data/acpi/virt/DSDT
 create mode 100644 tests/data/acpi/virt/FACP
 create mode 100644 tests/data/acpi/virt/GTDT
 create mode 100644 tests/data/acpi/virt/MCFG
 create mode 100644 tests/data/acpi/virt/SPCR

diff --git a/tests/data/acpi/virt/APIC b/tests/data/acpi/virt/APIC
new file mode 100644
index 0000000000000000000000000000000000000000..797dfde2841c51b7e72065602e99ce1714347f0d
GIT binary patch
literal 168
zcmZ<^@N{0mz`($~*~#D8BUr&HBEZ=ZD8>jB1F=Cg4Dd+6SPUF6788)c?E~X6Fu>G{
hBZPn~MyPrgD9sGlkD?67;f3451Xcqw&w(L;0RYV=2>}2A

literal 0
HcmV?d00001

diff --git a/tests/data/acpi/virt/DSDT b/tests/data/acpi/virt/DSDT
new file mode 100644
index 0000000000000000000000000000000000000000..20e85c7f89f645c69935c615c07084e221419960
GIT binary patch
literal 18476
zcmc)ScU)EVAII^7km3at6myGa+R|dUS|(gjDG>rqi;BuJN5jfYEla7?tSq%Xt!(eT
zr!AYd_uhN&!S8+U(D&=t`StIw9$oH>d%mB0pK#D~&LeJRL*=*uql2K;?26j>=!V`E
z6YJuY`dmg31mXSgWB#J~S-UqiR5Ud<cZ(Mn7iTw(uCB~0kJnWzh6dS9<Etx!#^$Q5
zcx_Gk!TOrf#l<BhsRy&0;`I#$-C~^=whh9GZG-$EIH7frk<mvrM_ZLw*5`%~G&Yxv
z9Mh1RGG=Ujt)>jdl!92h)D&$WWX;hthf7M5uZl}Dl25#TNmhEvu#pquBa=&ZuBsU?
zNU5HsVO)7EM{DBc|GlzR+b&ufK3RFzF7@fJLGsy(?FFt|xgHw}TBWeXJ_0W|JtBPC
ze~f4qtRGR58c`9xic&YHN5oo1&B(GDr9Pu9az<v<jMg@z%x4UWoRJkZBim*S@)?68
zXKWBPBW5!O`-~xxGg?Q@$h8?me8$ko8Ev9ww6hsQea5iJ8QD=Y@@>X2pRsl1jJ8oT
zI@pY@ZAJ-xjMnWRv8Wk^He(x~5xJZ4ha|nLZ)h{N^%>FoX>Qc(=wdUr^BK|mX<pQf
zZZ>0kpAo&Ewu_q4!)6Tk8PWS``=}YcY{m{gBYHp0kDAfjW{mI|(fesZ)QpX6M!C<3
z-cLJ3&DhvxRQQbO{j_7$jQ%zwZZk@w_tV0t8JpUSN}mzEpLU9xvANBt@)^<l>4s4=
z2H1>|J|lWR?Hn~@OPevuXGHI(U7}_b+YJ3Rp7<Lo{JWtvdOz(NHKWvKRQrtR{j^)u
zj6pVIN1qYBpLUO$F~nx<<TIl8(;iVXhS`iUJ|lWR?HM&=8=FyMGs>d((_T?CwzC;y
zeMa<tS`;;7xXq|d%~<euW?j5G^+M{#))ki*57U85TnA*yDhm%|sz&LyqGGIWbzr4i
z9iiog>%s@e)fW`SdejB+pgPzu=p7X6ze?Sk6-*5#>0_Xck_RDm_2W7&y)ZK;$m)=j
zmDAD^jB3z`<oyiYF9|y2hM$kMQk146Q&ARl$ji!YX~_t}HQFv!;VNy|F8Nquoi<Hp
zxKi^I+v=DpxoxV#mFZ1&KomZsHchNlhAY$0l9^bUeg&C9xH7$IW^$!AO{`RgEA@&J
z&!VHl<hH3w855i804k+Sr#m-*bA!ZlrkxukSEgUQ(w(j0)FH86L3&diaJf_I&Ngti
zfwK*rN_S?%nVndf{*veb&7DejwuMs%^U1GX;!Dz&PNh3zaK_-&0i8RQ?#zKR2hJQi
zmG0CTg?&GB;nV@3JC*LtgEJ4#JUW%`YzJpMICa42PNh5B!`U9r_H-)Usgo&l=EJE2
zOm`~XSpa7NoCS0$-Pr-o4shy#)SXIqc7(GdoE_;@y0Z|@LO68*>rSORJHgor&Q5eH
z-MJy08^WmrUUw?p*%{8xaCW9s=}w($+V`^yoH{^ur_!BW;p_@$S2~sM>;`8yICVhn
zPNh4$!`U6q?sO{M*#piVaOwcuol1B1gtI4{J?T`svlpDb;M4)TJC*J%g0l$DB081s
z><wpcICX&UPNh5hz}W}RK6EPGxe=Tj!Ko7hcPic47tX$L_N7zl&W+*R7*3r)xKruQ
zesK1Kvmc#GclL*~Kb$(@aHrCpo4~mVoSV?8bmyjUZVIPPP~53>=Vowj2IppUD&4s`
zoSVa`6B>6a-MIyvTfn&mol18OfO7zxIstO0(wzh090=z?I+gC+63#8*)CrS2mG0aM
z&aL3wicY0FbzRQ>ye)=PCs^)Ox>J|qv@(6<SpsJXol1A=BAiyHk337^)Crk8mG0D~
zH?2$`-<H8yMyJx9y5MHcL2&8>&Yenk>N1--2g5m-PNh3_am}1V;M579JC*L#B{g#n
zg>xvKN_Xl)nmLETsS`wZD&48eXXe}*&aLTGx>Fa;%()GmI-zu@(w(|gX3lNl+?GzI
zJ9UA~oZG>v6Hs?5-KooB=G-36?depyQy0U`IUG)%u)0&}PF(^s=MHf0K&R53Bj6kX
z=LkBL?ktD19L{n&mG0C<E^}7ESwW}Low~GT&N!TLI+gC!1ud;ip8;3GSxKkTow|&r
zmFYi+s^F}mQ|V4!yfWuVI7iZ{bf+#^nR67Jqv%w+Qx~etIU3H<bSmAc%Twm8hO?SZ
zr8{*|%A7mGxg(uQcj{7<Id_6{Cpwkx)CDMWj)8Lwol1A=vXeP$;H;rj=}uj2GUr%0
z$I_{Er!Fy>vlh-;I+gCMgR>6KIy#l^+!@ZD;oO-{r9124tcSCnPNh2=;B0`iflj46
z$H6%c&T(`q-8ml4@o<i(Q|ZoK;M@hyUFcN0a{`<b;G96G(w!6GoCxPcI+gC+70zAZ
z+?7tHJ9mR~H#m2rQ|Zn|I2++?q*Lk6-QnCF&fV!$x^oXW_keQ`I+gC+6V5&1+>=hF
zJDcEag0qQEr91b6b1yjeqEqS4z2V#&&b{eWx^o{m_knXCI+gC61m`3;C()^N=e}_6
z3+KLcD&488-uCD1esJzbr_!C1;hYTTWIC1Z+#k;U;oP52r8}p<IR(xsbSm9B70#(}
zPNh@n&S`K?gL4|4N_S3&b2^;U=~TM&05}hT^8h-P?mQ6A1K~W7PNh2!g7Y9a5291)
z&V%7R7|w&~RJwBpoHO8@L8sE4hroFVoQKe<bmyUP9t!87bSm9>7@UW}c^I8acg}=!
zCY&?rRJ!wUI1h*Oa5|OloCW7BIA_tRbmtLp9s%bObSm9B8_wBq&Zbl8&N*<-fpZR>
zN_WnMb1s~7=~TM&NH~v#^GG_C?mP<4qu@M>PNh5N!8s4kd2}k>c{H3y!+A8FN_QRu
z=P_^|L#NW6^WmHi=X^Sq?py%p0yr1YsdQ&EoXv1H)2Vdlv2Y#>=dpAu-FY0G$H93V
zol18e59jf49#5yzoeSYy2<JjNmF`>w=OQ>4(W!LjVmKGWxtLC+J5PY~1UOHiQ|Znn
za4vy!37txJo(SiOaGpq~(w!&4c@mr_(W!Lj$#9+w=gD*`-MJLbrEo5#Q|ZoA;5-G+
zQ|MH>^Hexbh4WN8mF`>y=Q22#(W!LjayXa6xtva=J6FKD0?rk5D&2V+oTtHg8l6ga
zo(|{faGp-5(w%3(c?O(k(5ZCinQ)#7=b3aW-FX(AXTf<Eol19}4d>Z#o=vCHo#()L
z4xH!EsdVSLaGne2xpXSsc^;hS!Fe8?N_U<Q=lO7+Pp8tI7r=P|oEOlkbmxU|UI^!f
zbSmAs63&%yuB21x&Wqr@2+oV>RJ!wGI4_3tVmg)Xyadim;Jk!Rr8`%_xeCrzbSm9>
zDV&$Wc`2PrcU}hPWpG|br_!C5!+ANJm(!_q=M`{X0p}HTD&2V{oL9nmC7nulUIph>
za9%~H(w$esc{Q9@)2VdlHE>=7=QVUH-FYpX*TQ)%ol19J2j_KgUPq_Wo!7&8J)GCm
zsdVQJaNYpt4Rk8qc_W-R!g(W|N_XA_=S^_lM5of7H^X@|oHx^{bmuK_-U8<>bSm9>
zE1b8&c`Kbtcisl)ZE)U3r_!Cb!+ATLx6`R~=N)j~0p}fbD&2V}oOi-`C!I=n-Ua7f
zaNb3y(w%q1c{iMQ)2VdlJ#gLw=RI^P-FYvZ_riHEol1A!2j_io-bbg>o%h3eKb-f|
zsdVQ9a6SO%19U3g`5>GR!ucSbN_Rd4=R<HlM5of7tKnP?=W05Y?tB=|hv9sfPNh2^
zf%6eKAE8s}&PU;V6wXKKRJ!vqI3I)aF*=p*d>qcl;e4D<r90QaxdzTPbSmBX1e{O6
z`2?LxcRmT{lW;ysr_!BI!TA)NPtmD#=hJXL4d>HzD&6@EoX^1d44q1MJ`3lwa6U_?
z(w%GJTnpz~I+gBx4$kM`e2z|~JD-R1c{rb^Q|ZnZ;Cunj7wA;F^F=scg!4r@mF|2A
z&X?ePiB6?EUxxE#IA5ky>CRW+d<D)|=v2D%RXAUT^Hn;P?tBf-*Wi4OPNh3vhx2tf
zU#C;)&NtwE1I{<-RJ!v`INyZxO*)nCd<)LE;Czctr90n-^KCfarc>$8ci?;n&Uffk
zy7OH)--YvCI+gBx56<`Ce2-40JKu-%eK_BzQ|ZnR;QRp259n07^Fug4g!4l>mG1lq
z&X3^yh)$(DKZf&TI6tOS>CR8!`~=QV=v2D%Q#e0`^HVyN?)(hS&*1!wPNh3Phx2nd
zKc`da&M)Bn0?se!RJ!v^IKPDROFEVA{0h#m;QWeCr8~cd^J_T2rc>$8Z{Yj}&Tr^c
zy7OB&zlHN#I+gDH4$kl3{EkkgJHLnXdpN(RQ|Znh;QRs3ALvxN^G7&;g!4x_mG1lr
z&Y$4?iB6?Ee}?mCIDe*7>CRu^`~}Wm=v2D%S2%x#^H(~R?)(kT-{Aa>PNh44hx2zh
zf2ULF&OhM%1I|C_RJ!v|IRAw6Pdb(E{0q*%;QWhDr91zI^KUr+rc>$87C2krY@t(`
zbT&3uXX$^8vEMh17mrN-KB;c&^rjx|VmXO7^5`2R-^e3;qYr+ruys>IeM3fSRO<I%
z!(UeYU!yjT7?u1SN2PvU``<?Oix`#s97m;oYy00u^^X{p{9I~OVSZD*qC8mDP8;Tr
z&`n`&`|y2Fg6#T=@goaHw~5VMoENmp)gwWmZ$=PgEb1Htxf$VI{gdC)^7ruM-Igu&
zNJegEvb1$#^A<gt5iHrl)+9EVuiKXJpY-ObkKyO%1grjU&z#*bzOF9Fj*qJ!6BLeZ
z+f>^S&ss7)h*wT1Svj`NiYWyhWBH9WZ<PH~)MLaM6K0k_u>C8OmrRdkX@gRI%+|-U
z8DWHT!aHT*s2N9wx3Qi<_+e#-<twIU%$TPKOJdo{(Os6WShsERf&9b+Gr|SoBdexg
zl%HCXm3U;;^umEnl?^pnEBhp0)!LzJK57^|w`N)A&uhA_j@PVgyJDKYkeL}7;f>w|
zCa1oxxGDL|)s4+HS@l)vx2#F-LE(GJgg*#nvEqMxyAr#GzF9>hQs1W3hy3tk_y#kh
z+l;EKP5s1`C*DVANccWF>wb|tH9P&T8$ss!chlJ<F+$r`RTuP)^**V)_Lt<pdO-VH
q*Pxf~WCr0A=(!5>nyQM+f`xSx>MLUN8=H&5JIVJQNjl<q-v0n?ptJx0

literal 0
HcmV?d00001

diff --git a/tests/data/acpi/virt/FACP b/tests/data/acpi/virt/FACP
new file mode 100644
index 0000000000000000000000000000000000000000..27de99f51bfe846b1f8796ace49d83f5b33a1aed
GIT binary patch
literal 268
ycmZ>BbPnKQWME+3?d0$55v<@85#a0w6axw|fY>0Kx<CNcIA#XwTY+i=(L4a*H3tCz

literal 0
HcmV?d00001

diff --git a/tests/data/acpi/virt/GTDT b/tests/data/acpi/virt/GTDT
new file mode 100644
index 0000000000000000000000000000000000000000..10107a65e958ff6495bb8c17d63d0539690f59f6
GIT binary patch
literal 96
zcmZ<{aS2IaU|?Xn>E!S15v<@85#a0&6k`O6f!H7#8OTC8azL5|h^3)?DJYFj0RVOU
B2mt^9

literal 0
HcmV?d00001

diff --git a/tests/data/acpi/virt/MCFG b/tests/data/acpi/virt/MCFG
new file mode 100644
index 0000000000000000000000000000000000000000..e8987e1af0ec3829770bf4fe11fab02b06160dd2
GIT binary patch
literal 60
scmeZuc5}C3U|?YMck*}k2v%^42ypfViZKGkKx`0=1Oyx)oc|yS05YNo0RR91

literal 0
HcmV?d00001

diff --git a/tests/data/acpi/virt/SPCR b/tests/data/acpi/virt/SPCR
new file mode 100644
index 0000000000000000000000000000000000000000..377271a0e7817cc21a28c02123a89facad63604f
GIT binary patch
literal 80
zcmWFza1IJ!U|?VpcJg=j2v%^42yhMtiZKGkKx`1r48#l^3?L>agsBLmm>C$E7#RKo
I0Z0r60QF4^0RR91

literal 0
HcmV?d00001

-- 
MST


