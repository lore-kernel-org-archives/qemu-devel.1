Received: from eggs.gnu.org ([2001:4830:134:3::10]:47091)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d6aFG-0002KY-Kv
	for qemu-devel@nongnu.org; Fri, 05 May 2017 06:13:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d6aFC-0006dH-K8
	for qemu-devel@nongnu.org; Fri, 05 May 2017 06:13:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41862)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1d6aFC-0006d3-Ah
	for qemu-devel@nongnu.org; Fri, 05 May 2017 06:13:50 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5575D7AE92
	for <qemu-devel@nongnu.org>; Fri,  5 May 2017 10:13:49 +0000 (UTC)
Received: from donizetti.redhat.com (ovpn-116-145.ams2.redhat.com
	[10.36.116.145])
	by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP
	id v45ADbkP026855
	for <qemu-devel@nongnu.org>; Fri, 5 May 2017 06:13:48 -0400
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri,  5 May 2017 12:13:24 +0200
Message-Id: <20170505101337.4650-9-pbonzini@redhat.com>
In-Reply-To: <20170505101337.4650-1-pbonzini@redhat.com>
References: <20170505101337.4650-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 08/21] sgabios: update for "fix wrong video
 attrs for int 10h, ah==13h"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Update the submodule and rebuild the binary.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 pc-bios/sgabios.bin | Bin 4096 -> 4096 bytes
 roms/sgabios        |   2 +-
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/pc-bios/sgabios.bin b/pc-bios/sgabios.bin
index c3da4c3d0a34e4eca9b0cda38d0538b332f7b09e..6308f2e2d7064b52ff3c2e207b71018710866c05 100644
GIT binary patch
delta 1136
zcmX|<Z%i9?7{`BiM|*9D?J|@#khM3(%h;Nu1xDGN4PzLU_@`@ulmZ6aEJEVOX3wZ`
zwoNB#sk)Kh3uCeuu=#@UrZ*QCkysfet0Tq@W5h+w&}_-mFgo2LS+D>6-E@2P{XGA^
z&+ndGkPC8}&S_1$SC{S@*Ys(ujdk_*I-7m`Eo1HBqeq6`f5Yz|s^tcUj&k*OZeZj%
zS8ui1Eu6JkXlN346YA_ZF#b*JmsBrRYod8y>^YU-J6A=s=7D6tNo|-IZZVgd^oWgK
z7JM<GiWXuH6aI+)a1%${O8I+V2r(0f^~}?Dj@Fj^O}sDkto!->NVM>=J~bZ+A<A$u
zxwHyrRiPB3sT3c5;y@^eD3P}PM!YyY%xv58VD`|X*>32?pEEn3<mgbU$jl(>Zakc#
z`8_JJDs%_Y!Y&6#FWnIsGJT6l?>ExndCEGM3D46K&IqweBRxx@$gi2m{nr1&@H`_`
zkUAwX4->RRWqQ1xq|%NJs!D^AzC9Hb*CX>Ly?OR8gd0^Y)J-g^UaB_InQqeQCWWb>
zUtJTJJxwj|<K8Zt9l<Lq3w0Z7)y>s$bet8&D&wfQDC}*L9z;ZnKf*EGtG+^Q#yoqt
z%$rU3;!oM_lo3npZj(0abb-0xXQwDX1H&b+CtY*j>2{gO+2Jl`G$#yx1S5rTmU@SI
zacvD8_>`u0yIZLnE~aYOYpZ3>XfnFh+~Y}_+$1~Zcpbs-cv;gQXqL@a$tOJqpA@8e
z=+8^-(38Kw!uf)=Wcw-ISL$-XXQk*b-hIe#aKc~#b`>Ny*z?}klFrc^5G{<}P!?&g
zh>r(LtZ0BX#b~Qyv?af0aYYxQuH-#vUEjElmWr2zy?Sy4l`uxc&q@pjd+?0*Df{1f
z_$n`Tz@;297DA44gyuvhyg(=WK`y#FqqkyR`o1?`(Ve_0GU>WfFi#Vm#1%R|&{PcO
zbtGyaswY}a)Ic;rw1Q}3(c^t&35SXU>FIyIUPNbP^79TOR&VBglRJ>_+%h6yA+VxA
z3jv)1P6B@@;2~f@d`i6oy~pw&>vt+_L2Vx>fuIB}2(*M-6?US4l6NWWLCXqz5v*px
zB8$1ic?4o^xP@Gf{mzNt1)SG)1SItTGyQrY;)tU)R!FIhG|<*L(loOf<?l`F&2T0w
zW}q#XAlv?w;h9|GWdzq{sLv&iAh;$&ZSJ8>cj9{l37KpWCgSL9JGxAsg<wUN-UY}C
z6B3Fn6n}{DCsBkyh*Yp3!#e(Xlg%QbF}@uM5k8J!+Xj5Qk+_PWT^1%edUO?z$r1-A
ZvXNC7l;JeCmA{Ie<@yW3@&H3M{0n1!(*FPe

delta 1123
zcmX|=ZA@EL7{{M`FXgr!wu?i2S=L?^ZwkZ1EeLMN2-|dK1WgBQDOD5(G+WKYK<{)P
zT-&gamM&T5{ot2rI`IRUiPn%zmtu$1(144|qE161M3?w<jABH|di&<N)A{NDd*07^
za*ki{3;M&C^eK-qHE>?vqqo~@rTSXC{rriC8cy}S<{|RP;PA+)5i&eDaIDWu`iD+b
z30=oz;l-hof>1Bm>znH9n;PuG;jaBcokR;i-uLP4UZ#q$qC5PYj<_ePS>D>0=(UuZ
zBc4`kvC#y4XpXqUq?#q+7NW@P=`9j#FXlErBw>rB6xb)8mRLj4+bFsNdpe)r3v!JZ
z?kN?60btCR6N@Vt(FKygGD$J?!2UoM7@4&%(O#0`;&$ABx3>TP+HQ0yA+Gu{i47zR
z+!bK{{A4uAio134BY|~b$<7vuU0f#|t^R>a?X|I^vy3#89-U>QN}7Z#Y;25y;7{q`
zoqhkBqqAIe8;vtj?w*5<GU=CG&V-h(6iX`1Hum<UUtSB&T1?g$FiNGamHA5<)U|K7
zvFUD_*+~PFes5`|FBV~LGz%joF~4$6SHs*=GP+&cV=&B<@roD}7D!X$^j(We;Ts%M
z+DqpdL8;&eN{(bwPUSTJC}UG1e1k=oade<H@8u^MFNdC@%b6;_<LK<L(6!?q$_D?o
zc^L4G{Ah+b$sJr>#b(8)ud-@k^W|hE|J_Q7Ba{d|Xmutmozywrauje`nb-IFnpEqz
z^g{RHxqP$^kLIFn*pr*$aVjqr?blPU7LRn`yT#Ctu4eF>9e6yCPv)bYxI5>1CE*xb
z#&CXYS({^+m&^S{UN++at<l3;qw?HpO-E<}Ym2T!(%R<Fuvqw#G@0lMbYz^0mydD+
zKBIhOc-*j&!_RWjE=(vl43@1g8_(R7xm0b@pJS;`C_1C)+g0%AjMQqNYNEP>s+nq>
z>Ncv41*eMyTFL-sWDffaeW?q7f4%@0RQf_az?-b1`=Slp6Tbn48VaaED+Qwl4hm};
zI4PJxOqSXp#EWN5)f(5pvu8DfXhth+8Yu76*a7D>e}~3S_+4Wc;IA1Zs+^5~0r+Ot
z(@Gb_Uv&VsDQRPuZyNqPrq@J*EiqW-2_42FE6vcPD_bGAami%G_cL-D4`k!5fHzg#
zla0RsxTNA!+4$>#*Hzq^z1OBY{ypG~N~e%W3_fUsIeIL>U)1PZcq>C9(-8csa4jgF
zfuMK@bU3Htx-z%LUN;TnVjGa47z4C!;?>Rg5@5SZE=ug!3XZ5z0ezX^3LaPS9hH9e
R_r6x_We2DHWj>Cv{sTIk(ntUR

diff --git a/roms/sgabios b/roms/sgabios
index 23d474943d..cbaee52287 160000
--- a/roms/sgabios
+++ b/roms/sgabios
@@ -1 +1 @@
-Subproject commit 23d474943dcd55d0550a3d20b3d30e9040a4f15b
+Subproject commit cbaee52287e5f32373181cff50a00b6c4ac9015a
-- 
2.12.2
