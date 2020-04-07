Return-Path: <SRS0=U3m5=5X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HK_RANDOM_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82C23C2BB1D
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 11:03:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 573F5206F7
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 11:03:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 573F5206F7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45208 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLm12-00013l-EZ
	for qemu-devel@archiver.kernel.org; Tue, 07 Apr 2020 07:03:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47322)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <miaoyubo@huawei.com>) id 1jLlvH-00080T-84
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 06:57:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <miaoyubo@huawei.com>) id 1jLlvF-0007Sz-SH
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 06:57:39 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3664 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <miaoyubo@huawei.com>) id 1jLlvF-0007Ra-Fr
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 06:57:37 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 0A3BCF0EC2D0DE2060E2;
 Tue,  7 Apr 2020 18:57:28 +0800 (CST)
Received: from DESKTOP-D7EVK5B.china.huawei.com (10.173.221.29) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.487.0; Tue, 7 Apr 2020 18:57:22 +0800
From: Yubo Miao <miaoyubo@huawei.com>
To: <peter.maydell@linaro.org>, <shannon.zhaosl@gmail.com>, <lersek@redhat.com>
Subject: [PATCH v5 8/8] unit-test: add the binary file and clear diff.h
Date: Tue, 7 Apr 2020 18:57:06 +0800
Message-ID: <20200407105706.1920-9-miaoyubo@huawei.com>
X-Mailer: git-send-email 2.24.1.windows.2
In-Reply-To: <20200407105706.1920-1-miaoyubo@huawei.com>
References: <20200407105706.1920-1-miaoyubo@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.173.221.29]
X-CFilter-Loop: Reflected
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.190
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: berrange@redhat.com, mst@redhat.com, qemu-devel@nongnu.org,
 xiexiangyou@huawei.com, miaoyubo@huawei.com, imammedo@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: miaoyubo <miaoyubo@huawei.com>

Add the binary file DSDT.pxb and clear bios-tables-test-allowed-diff.h

Signed-off-by: miaoyubo <miaoyubo@huawei.com>
---
 tests/data/acpi/virt/DSDT.pxb               | Bin 0 -> 7802 bytes
 tests/qtest/bios-tables-test-allowed-diff.h |   1 -
 2 files changed, 1 deletion(-)
 create mode 100644 tests/data/acpi/virt/DSDT.pxb

diff --git a/tests/data/acpi/virt/DSDT.pxb b/tests/data/acpi/virt/DSDT.px=
b
new file mode 100644
index 0000000000000000000000000000000000000000..d5f0533a02d62bc2ae2db9b9d=
e9484e5c06652fe
GIT binary patch
literal 7802
zcmeI1%WoT16o;=3DLiS6+tw&OgUms2Pe&&rRcNlRN|kDbINPK+mQkW$GN2t>&y5*4DY
z5GE1@x}%ZUunAHY{255B*s){5x*Prhb`0mvok@O&o()@MN3!S4-1E)-#wYff>!#D(
zdAOidc(<`_Z#avMce{3z_Jx#EdRxC{zj_wB({~#Ey~7#1TrS7^8|`MgZg<-hEUS3`
zR=3DcV84zJqVo#0rnvr#TrD*mx}-|jiN8EfisLTO+^WtIANRE0w4D0)D-m9<UB&)wYW
zZBy<N%gtFCKbI0zG)SqKsqmDLIo(-GG)P%l+qKtB$~&#jEt-9m&f@IUtt92x^?zrE
z6Vv|u>e1W1K-`?I3=3D=3D%fJX5q(*jFqgf=3DxI;=3D+i!j2&*$h#YZ&sEUM@nAgr*&hytU=
E
zjGD-ZNQ_Zn)R1vWWJD!K92l37u_Q7^B!&fyC1hL{8KV*-1&qtcSQZ&EiID-uGBQ>~
zMqFZKfw6*&D<UHyG4jB;0*ng#H#)5kOJWp&aTOV2neu;<pwuUU@g_3lI!#IQm<Gl*
zWXN@zmKZa@xQ-0DPBRi?4j4C(A=3Dl}c#8?2vTgZ^>G%GO{fw77VxlVHu;{{;Uks;S<
zUSgaFMgtjgosLV43&5~}QI+eoATeGBMiUuwolZ!MSAo$&hFqtU661AXtRX|L(<zB@
z5g6;pkn40>Vw8cgfeg7$ixQ&>j5adlI-QXimw<5-8FHP@N{q|EcpDjVoz6*&6<};4
zL$1?#iE$Me9bnYtI$e+$*MPBw47pBA65|FiwtYtDhpxTi&!fB5E!WE{)VJ8wgqf&D
zQN7vI`@BBFX|2<Cqp@WTyyi^5I6J*u(V9F^pQ-oMqH3xS)Tip6dY@hu4es`K#y3B)
z2Ki((>AGs&X_uAR4$*c+<x_gU6{esX1Q7~qDxZ#~T$kE9GtQ5677fgpV_qH&4MLqs
zd~YoENoK4c>C9j#H9`7}G}OzaP-oI?ys;54Gnhd{>C9kg#AMP?FOx!@Ni*^?sUtLF
z{m6IphEmhyTLvL|jxf&=3D@0@|>h{+5lPa%4aGEZuLX$HYiYO>IiLiCI=3D&lvNJaZd`-
zGtNBYUS@Dfs3}8F3ehvcJgIFrSI@g73GPWDdRolWVxH8*p(lmtnPi?x=3D9%Q46ryK}
zd8U{rHGSwwA$q2nXPSAYxhI9_nPHw8=3D1EN=3DdQym<W6X1md5&>U3el5po1kv9%#)f*
z^rR3ybIdcxJagQWLiEft&ph*_CKNp>M9*>NInF%CxhI9_Szw+8=3D1EN}dQym<6U=3Djh
zc}{Ro3ej_tc}_A<YI4z&LiC(so>R<oihELso^*Q&@8>l0q^1}>DMZgA^DHvYBKM>a
zJ!hEb4D+NW8a*jQ&spX<%RFbfCxz%a$2{klCpF#ZNg;a9GtYVEInO;QL{D1OFrQi8
zXZ!;5q$V9bDMZf_^DHsX68EIgc<vpxqx!8hH*orE*)Ffq_o`kR(ci94E@LIVC65=3Dq
zFLnB=3Der{i3wD0tskdN|v28N=3DQ0z{n`P-fpL>ZYER-{LZqUNJz{O9IR6<1D|`<t$n`
zK-L9;W%l_jV?SZ#ze%eweR!(@{V7@-dZ6OYt!`Jv?VaAHDy${?+m0Q5vajssZsm9*
zcJxth+{*5C{;2&`np^#T_kR87>%V{aWZ#O?fGWMl>9uyC1I^JJHH~_tpRAI8KF&Tp
zx)=3DJKj#RwSmE*~$N5MF=3DJF5>K=3D)rpb$^MTSvtOU2a<X4|qu+Eo(c^PwHoq<Z`pj8+
z*!gbi&rb0dyK|g4`dFRhBB79eqQ$NCpSm_yhSa{Dwrr+m(mI1Sb=3DOw1=3DDNyOZR*q(
zRaxlWOw%{);DXL(*um+pd)UFb?y!T?l`!n!TzA;P=3D}H)OaIQP-;DjF4`mY^aA=3D|eb
zb#+2_!795-PldYI)KTNJ5wq?GeVtNY(6NE~n(mQOv_|ATvab8LUS6k%dy$TWQnZp|
z9<=3DmC50{RH)RWgB$2&aG$MnOC&YtxC|7GXciS}B-@1myT)<0P4JBON8e(w5s?*m<(
z((2iz(Oa}?V18w7#O_?wzvHgAntf9Q=3D11I$UO=3DQfl{6jj`Q~mV5_-j?4q820Q>0Ek
zp0J{OUnX^Ex184IVqw1Dy1kP)(81l~?9rpUmR_}c+}-Uptij%4QEy<y+2&m8A6W)v
ATL1t6

literal 0
HcmV?d00001

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bi=
os-tables-test-allowed-diff.h
index 90c53925fc..dfb8523c8b 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1,2 +1 @@
 /* List of comma-separated changed AML files to ignore */
-"tests/data/acpi/virt/DSDT.pxb",
--=20
2.19.1



