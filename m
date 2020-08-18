Return-Path: <SRS0=kYy5=B4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NORMAL_HTTP_TO_IP,NUMERIC_HTTP_ADDR,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 070C3C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 12:25:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB6302076D
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 12:25:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EblQRoKt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB6302076D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43390 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k80fo-0001Bv-VD
	for qemu-devel@archiver.kernel.org; Tue, 18 Aug 2020 08:25:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60168)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1k80dO-0005gH-Hs
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 08:22:34 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:23146
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1k80dL-0001vy-LG
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 08:22:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597753351;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s13BQkNNlQLwUBLfKNzenzB85HVSJQHpHQ/xukPBF7g=;
 b=EblQRoKtroh/imX7KCczxi6F664c01tTLM2Rg27TWOJ6iIlxM0ss2fMZwlitDiItrJITNR
 lbkib/bL2RjgJgCQWv8zU2xMoXks21T8IzuGBEulLXtU+oD2fUzByMIduM0jl5tTxre0wx
 w3Urd1vfAHck5P2GGbcQ1yiSTzG2FaY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-434-Esqcdlt2P6yKoyiQ1V4rxQ-1; Tue, 18 Aug 2020 08:22:26 -0400
X-MC-Unique: Esqcdlt2P6yKoyiQ1V4rxQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 828C61DE0D;
 Tue, 18 Aug 2020 12:22:25 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
 (dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 58ED85C64D;
 Tue, 18 Aug 2020 12:22:24 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 7/7] tests: acpi: update acpi blobs with new AML
Date: Tue, 18 Aug 2020 08:22:08 -0400
Message-Id: <20200818122208.1243901-8-imammedo@redhat.com>
In-Reply-To: <20200818122208.1243901-1-imammedo@redhat.com>
References: <20200818122208.1243901-1-imammedo@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=imammedo@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=205.139.110.120; envelope-from=imammedo@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/18 03:19:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: boris.ostrovsky@oracle.com, lersek@redhat.com, aaron.young@oracle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Update CPU hotplug AML with following changes

             Method (CSCN, 0, Serialized)
             {
                 Acquire (\_SB.PCI0.PRES.CPLK, 0xFFFF)
+                Name (CNEW, Package (0x01){})
+                Local1 = Zero
                 Local0 = One
-                While ((Local0 == One))
+                Local3 = Zero
+                While (((Local0 == One) && (Local3 < One)))
                 {
                     Local0 = Zero
+                    \_SB.PCI0.PRES.CSEL = Local3
                     \_SB.PCI0.PRES.CCMD = Zero
+                    If ((\_SB.PCI0.PRES.CDAT < Local3))
+                    {
+                        Break
+                    }
+
+                    Local3 = \_SB.PCI0.PRES.CDAT
                     If ((\_SB.PCI0.PRES.CINS == One))
                     {
-                        CTFY (\_SB.PCI0.PRES.CDAT, One)
-                        \_SB.PCI0.PRES.CINS = One
+                        CNEW [Local1] = Local3
+                        Local1++
                         Local0 = One
                     }
                     ElseIf ((\_SB.PCI0.PRES.CRMV == One))
                     {
-                        CTFY (\_SB.PCI0.PRES.CDAT, 0x03)
+                        CTFY (Local3, 0x03)
                         \_SB.PCI0.PRES.CRMV = One
                         Local0 = One
                     }
+
+                    Local3++
+                }
+
+                Local2 = Zero
+                While ((Local2 < Local1))
+                {
+                    CTFY (DerefOf (CNEW [Local2]), One)
+                    \_SB.PCI0.PRES.CINS = One
+                    Local2++
                 }

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 tests/qtest/bios-tables-test-allowed-diff.h |  19 -------------------
 tests/data/acpi/pc/DSDT                     | Bin 4934 -> 5009 bytes
 tests/data/acpi/pc/DSDT.acpihmat            | Bin 6258 -> 6334 bytes
 tests/data/acpi/pc/DSDT.bridge              | Bin 6793 -> 6868 bytes
 tests/data/acpi/pc/DSDT.cphp                | Bin 5397 -> 5473 bytes
 tests/data/acpi/pc/DSDT.dimmpxm             | Bin 6587 -> 6663 bytes
 tests/data/acpi/pc/DSDT.ipmikcs             | Bin 5006 -> 5081 bytes
 tests/data/acpi/pc/DSDT.memhp               | Bin 6293 -> 6368 bytes
 tests/data/acpi/pc/DSDT.numamem             | Bin 4940 -> 5015 bytes
 tests/data/acpi/q35/DSDT                    | Bin 7678 -> 7753 bytes
 tests/data/acpi/q35/DSDT.acpihmat           | Bin 9002 -> 9078 bytes
 tests/data/acpi/q35/DSDT.bridge             | Bin 7695 -> 7770 bytes
 tests/data/acpi/q35/DSDT.cphp               | Bin 8141 -> 8217 bytes
 tests/data/acpi/q35/DSDT.dimmpxm            | Bin 9331 -> 9407 bytes
 tests/data/acpi/q35/DSDT.ipmibt             | Bin 7753 -> 7828 bytes
 tests/data/acpi/q35/DSDT.memhp              | Bin 9037 -> 9112 bytes
 tests/data/acpi/q35/DSDT.mmio64             | Bin 8808 -> 8883 bytes
 tests/data/acpi/q35/DSDT.numamem            | Bin 7684 -> 7759 bytes
 tests/data/acpi/q35/DSDT.tis                | Bin 8283 -> 8358 bytes
 19 files changed, 19 deletions(-)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index dba32d5613..dfb8523c8b 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1,20 +1 @@
 /* List of comma-separated changed AML files to ignore */
-"tests/data/acpi/pc/DSDT",
-"tests/data/acpi/q35/DSDT",
-"tests/data/acpi/q35/DSDT.tis",
-"tests/data/acpi/q35/DSDT.bridge",
-"tests/data/acpi/q35/DSDT.mmio64",
-"tests/data/acpi/q35/DSDT.ipmibt",
-"tests/data/acpi/q35/DSDT.cphp",
-"tests/data/acpi/q35/DSDT.memhp",
-"tests/data/acpi/q35/DSDT.numamem",
-"tests/data/acpi/q35/DSDT.dimmpxm",
-"tests/data/acpi/q35/DSDT.acpihmat",
-"tests/data/acpi/pc/DSDT.bridge",
-"tests/data/acpi/pc/DSDT.ipmikcs",
-"tests/data/acpi/pc/DSDT.cphp",
-"tests/data/acpi/pc/DSDT.memhp",
-"tests/data/acpi/pc/DSDT.numamem",
-"tests/data/acpi/pc/DSDT.dimmpxm",
-"tests/data/acpi/pc/DSDT.acpihmat",
-"tests/data/acpi/pc/DSDT.acpihmat",
diff --git a/tests/data/acpi/pc/DSDT b/tests/data/acpi/pc/DSDT
index 6d0aaf729ac7d64cf966621adf276534de5cc555..716d412a2474e0990136560b0340f808e490b514 100644
GIT binary patch
delta 304
zcmX@6Hc_3+CD<ioqA&vk<I0U(TiBS~ttTH~Tg~KUFgcg~FO#$I<Qxu}dJbnl*Ki>w
z#sY@K0>*>_hU7&~JQF4-FiuSd3MCXI$LO=f2Rp?FIC~ld1i1z~2fO+dFrW)M`?@R;
zpNcN(;uw;=v;dpv0+q>7;d;2io_@iM1<4&C=Oi+ef*iBZe1R!U9b8$EZy2L<h+AYb
t7jpq4y4gTUpuW=N0*0hT8dH-JK?<9}MkX;ZVk!q($yA!O*_M-&3jjiOSquOG

delta 172
zcmbQJeoT$aCD<jzO_+g!asNiHEo@9aW|I%Ft!DDqo}A16m&t=~at?=#N&#cSB1i7Y
z35*2{2?Y!>`YiFmPVoWGo(2IyuEEaEzAg*gStkGI5EXY0af?Kkc5w`uT)-)23N&P)
bH_HMKmdWTUf_%dmap`p6l-k_E$;kx(->We%

diff --git a/tests/data/acpi/pc/DSDT.acpihmat b/tests/data/acpi/pc/DSDT.acpihmat
index 2e5e02400b1bd2842989d395c573fc593f45503b..198e87dfc2d7df261f2f51d685d90db5c6eb8929 100644
GIT binary patch
delta 295
zcmexlu+NaoCD<iop9BK~W7<ZpEo@9~j*}0tt!DBx+nmeJ!N}<%>>TXu#}TbOnUO=-
z?EilbXFu0)Att5*hQtEKgaU@-Mb11ECMPgXP38iMB@`sb=(EHJJH-b$dm01;xduB2
zyZTI?&mmSXJ{4WY#W5s#X#qCT1uB!#g+2X(84Hp-K(;3`l!EMDXuiM{Ls^h-7^8ED
zTVyg9a{(i=8I$cex%5ht3mB3XX-rK@1gU8To0i1Dh^i9gXrOJSNt5F_#5Tuqitqyf
D&!|=a

delta 215
zcmdmI_{o6FCD<jTNP>ZZv3Dca7B(g?o5=^*Rx|k;Zq8-rU}X2;a}IX)<CwgWQ=*<R
zVUZ*E<OIe7hJ*r!7=4!bV5j&1XHSEGAlG1LXJ3~E?ktnhg+2X(8J$DiBGJWN977lj
o7|}(6stXts7J9QR@W3=mI><K+msyj2IHe}XbBJwT#VNuM0G&-dEC2ui

diff --git a/tests/data/acpi/pc/DSDT.bridge b/tests/data/acpi/pc/DSDT.bridge
index 623c4c03585c47d4d28adc611823b7cce8f4a5c7..e105bb152eff5b064b1a02aefa70e4cc3e18ffc5 100644
GIT binary patch
delta 304
zcmeA)y<*Dc66_LkMT&ue@zX}GEo@Bg){_sgt!DBvn4HW0m&sXpat?<~J%_WOYq$^-
zV*x{A0b@b|L-Hago(Yo^7^fx!g%S#qWAs_#gPr07oIMQ!f?R{0gI#?J7|;cseO(ra
zPem7XaSTabT7XS-fy!j4a6Q~$PrqQsg5(a6a}pU!L5^8yzQ7cw4z4W7H;mCa#4R$J
ti@AUi-E5#FP+w_s0YlOvjj2hAAcf6fBa;{yF_i<YWGYSCY|H5*2mlk)S_}XH

delta 172
zcmca&+G)z=66_MvDaF9R$gz=Y3mcP<+2jLktC{?@C+D*NW%A&goWmibQoxw7$dP+;
z0%HL~LIFdJK1+PCQ+$B4r$IoFYp}Dkugd~=mdXD)M8%y$+#=DXT^vIu7jTN10u5Q{
b&9cCQWiq;oAm1=XTsj>%r8akP`UnC5wjePt

diff --git a/tests/data/acpi/pc/DSDT.cphp b/tests/data/acpi/pc/DSDT.cphp
index e0a43ccdadae150c0f39599c85e4e21ed8fff2a4..01c8baf29575aa9c90489891ea14a707fccbf326 100644
GIT binary patch
delta 232
zcmbQL^-zn;CD<h-QIvs!k#i&07B(jLh{*@oRx^3|Zq8-5WMp>{b`Ey-<CyHvA+E^b
z?B^OT#Kcy>kXXQ&P{5G9$eCxt<OIg4$y`9Ogo5PB|Jg++U*Zs95}!JmkyDsCd1(QN
zc1d2KGC4+{B|g|GKET=2ARx#!*xA!Bn6V(a17u_(Ln+9>h2{%PF_Z=QhA}#axJ4#U
rj^~upD@`t7NLr*ZH7OA!)(qC2#K2g<h{g2Mq{$OF#5VVHws8Xh#TG-G

delta 200
zcmaE;HC2ntCD<iIRFr{%(PAUl7B(jD;K>KrRx|l|Y|dr3WMuc?a}IX)<CyHvA(79R
zu*i{nasp!kLqY*Vj6O?zuv2`1v!_8okZZ8Bv#-kncb3WM!k&J?jLso$k?7(sjv<T%
pjOe03)dh?R3%ywuc(6>K+{h^`flKq`T286S6F9^+-{x%N1^{(<H|zia

diff --git a/tests/data/acpi/pc/DSDT.dimmpxm b/tests/data/acpi/pc/DSDT.dimmpxm
index 21eb065a0ee3bd96f1a2e7601aa83fefa833349a..a766128d7a37ba5577699ec6fca1e418f7f2c905 100644
GIT binary patch
delta 306
zcmdmO+-}0<66_MfF2%sW_+=y47B(ga-^mBqRx>#}ZO&y^U}SO;p4`tNQ_tb-=Nc}=
z#8SYJSiqQ2z>vJinP<Y}1jeb!TtKmeg5(%|miS<&_yA{5gMc8{VCP_0p8^JSL1$l=
z1>#fDMO_?2l9v`>6J4M(86rIS8V6r}L2?Jk6^RU`AU7;DUtkKAMc5kT8^-7y;ue|A
x#azIMZX!?;sIN4+fFWs-#?+)lkiurLkx2}Un94o<f=iR4)#0XW&gKjd0093fS%d%p

delta 212
zcmZoS*=@|_66_MPTatl+QDGz37B(gqkI4tvRx`QVZq8*_U}W;(o7~SK!&AVRu*i{n
zasp!kL&D_y9AfqEER$pOS>l78;scyL4FZB(gPlG7f*GAd+#=D%T^vIg3mDNwfvSOq
iF7#$u;DKpWkZ%|+qqvwsW{IF$4O9;_Z1Wn<XaNAP9Xk&I

diff --git a/tests/data/acpi/pc/DSDT.ipmikcs b/tests/data/acpi/pc/DSDT.ipmikcs
index b8f08f266b5735fe6967d4e105ee6b3662dad7e6..e6de2da36e01436be3d5d05a2bebe5666ccfbe37 100644
GIT binary patch
delta 268
zcmeBEzp2jU66_LkQ<#B)(RL%(A2ud;>&YDKtC_qECU0f`TkkCF9PI4J5v?4f&k`T(
z6d&O1X%G<P8tfe4<Ng0XhqIq+xDXR#0YhQ|V?qH#@**dm36m2TrzQi15(<*hH3hr+
z6fmF*I{UgT5TA-J>f#uZytKd;oA3ga$>_qKe!+|d$sHi)Br=qO9JA1Tf$3y>PD#e(
p$=RGzVx`Fi3`vVLrY0pihqy&HgH<LmOjh6&V=7JB+{($x1po~KP!0e9

delta 182
zcmcbq-lxvx66_MvC(OXW7`&0|4;zz@*<=p()lB}{lee<}W%uB74tDnAnEaMg!iF(n
zkt6ry1jYh}gaU>beU|uOr}zM8PlJFU*I;L7UzY{$ER)fNJ^g|iokQFrCmV7K%QF@*
lVv#RkOjzj6vcQ97avrB7NSzcHGp52I-!P!U%@;U1xd2{IGED#g

diff --git a/tests/data/acpi/pc/DSDT.memhp b/tests/data/acpi/pc/DSDT.memhp
index 9a9418f4bde5fb18883c244ea956122e371ff01a..71f34760fe10a7f4face8d9f956b96668d5d2951 100644
GIT binary patch
delta 304
zcmbPg_`s0MCD<k8fdm5sW6wseEo@A_){_sgt!8pCoSe)4m&sXpat?<~J%_WOYq$^-
zV*x{A0b@b|L-Hago(Yo^7^fx!g%S#qWAs_#gPr07oIMQ!f?R{0gI#?J7|;cseO(ra
zPem7XaSTabT7XS-fy!j4a6Q~$PrqQsg5(a6a}pU!L5^8yzQ7cw4z4W7H;mCa#4R$J
ti@AUi-E5#FP+w_s0YlOvjj2hAAcf6fBa;{yF_i<YWGYSCY|9zJ4*<KkS;qhX

delta 172
zcmaE0IMtBLCD<iosssZA<Hn6#TiBSK%qJgUTg~LEGdY+2FOvt~<Qxtel>)|uMULE)
z6Br8^5(*e%^jYGAo#F$WJq-eaT!WpReO(r~vrPWaAu8@1;ueW6?cx|Rxqws56llmo
bZ<YlfER)ey1o?(B;?n8BDYdzSGlCxgB{(ta

diff --git a/tests/data/acpi/pc/DSDT.numamem b/tests/data/acpi/pc/DSDT.numamem
index 6eec385c2ec00544c6eaa7e19d32b2ccd5a51915..88070659ad48a4ed5a6019b8234abfdd29dd4703 100644
GIT binary patch
delta 304
zcmX@3HeH>|CD<iox-bI+qsvCFEo@A_){_sgt!8pCoSe)4m&sXpat?<~J%_WOYq$^-
zV*x{A0b@b|L-Hago(Yo^7^fx!g%S#qWAs_#gPr07oIMQ!f?R{0gI#?J7|;cseO(ra
zPem7XaSTabT7XS-fy!j4a6Q~$PrqQsg5(a6a}pU!L5^8yzQ7cw4z4W7H;mCa#4R$J
ti@AUi-E5#FP+w_s0YlOvjj2hAAcf6fBa;{yF_i<YWGYSCY|F{d1pwj@SiArL

delta 172
zcmbQPenySUCD<jzN0@<uF>@o=7B(g)^T`L;Rx`QkOwMKh%jCf~Ifp|=rGPPEkt6ry
z1jYh}gaU>beU|uOr}zM8PlJFU*I;L7UzY{$ER+9ph>AOhxJ9B%yEukSF5nb11sbx@
bn`MCq%VcyFLB3&(xO6&jN^S1o<mUnatOhXO

diff --git a/tests/data/acpi/q35/DSDT b/tests/data/acpi/q35/DSDT
index e63676d7a63afec714debeb465ee478ea4714337..27515d30b233e0eb4563f30c324e1cb538e5c761 100644
GIT binary patch
delta 230
zcmexoebR=@CD<jzQ;vawamq%n2@*{1)|2N*tY-2unCvO}m)%*|IoR2cWAb}RaRm-%
zKi6;}CdLAW!~({I0*2&8PCOGPCooP;1_~t<Bu}0%DLT1GN`y&#>g0t|!pzA_3qZ6>
z@&c8~G5Rd=!A|i3&YlJVL9W5ho_@iM1<4&C6B8LqLFO$qUto%%EXX&E(K*B|GI{cU
pDJi|u<N}7IMH*9+5<z0kVBJX!j0KEXOfOBEY#=4JSzr1*69AQCMsolF

delta 214
zcmX?U^Us>gCD<k8pDY6d<LZrE6C{{?%qGu~Sk2_GJ=s(8FS`eybFi}?$K*z7iF(F_
zMULE)6Br8^5(*e%^jYGAo#F$WJq-eaT!WpReO(r~vrI-8_Vf#8bPjQgL>G5)3}Gx_
nL>C3BE?`Vp=*_ag1Jfw!Am1=tW=)onmYQrJCAPUr`aBZ=mR>#8

diff --git a/tests/data/acpi/q35/DSDT.acpihmat b/tests/data/acpi/q35/DSDT.acpihmat
index cd97b819824e4140d087e465d179b71775d6a494..1ebd77e15912c54d5d6ff2d6c23475b283dd3555 100644
GIT binary patch
delta 252
zcmZ4G_RWpUCD<jTOqqd!F>oW-1PLZL$H{XfRx^2;ZT6JpU}Sd@b`Ey-<Cr{AQoNqS
z+0Qjxh>59yA+dllp@1QIku%SP$q9^8levIm2?fb9`YiFmPVoWGo(2IyuEEa1u090}
z=z`9^E(^q`qKmpXh9oa7z$UstWimuq0b#JGUoc}qatFvgi43J6*DN$&U^@Aplq6&F
pWG-nbvC`xMhNMLrQ<D;%L);>p!77s&ChwOLV=7JBtRl_E0RVL(NvHq-

delta 183
zcmez7w#tpmCD<iIOPPUzv0@|F1PLZDo5^z|Rx|k;ZuXSqU}X2;a}IX)<Cr{AQo@EY
zVUZ*E<OIe7hJ*r!7=4!bV5j&1XHSEGAlG1LXJ3~E?ktnhg+2X(8J$DiA}3#z5|(Ey
mV8kL{z?iVmn`MCq%Va)jNsu}zE@n)HLB3%?g_{ec**E|&IWjK*

diff --git a/tests/data/acpi/q35/DSDT.bridge b/tests/data/acpi/q35/DSDT.bridge
index 8b0fb497dbbaeba18e9d0e1503de4396f1c230b0..0f5531792789f7874382477c100504d1c5940ed1 100644
GIT binary patch
delta 230
zcmeCTxn;xU66_KZCC9+PXtI%Of&`Ph_2fActC_qECVNW$Wp@^K4tDnAnEYN+T!F*c
z&ox|#iLrnov4An5fFXI26VHUn35-*dfkFud$&=?xicT()5@8abI(ea#Fmv+K0ub$z
zyg+4gj6O?zuv2`1v!_8okZZ8Br(ZB*L2?Jk#6*Ttka-Ku7nouw3-S$PbPjQgOrHE-
pN=mOZxqu;Qk;c@dM37iBSa%WwV*w);(@T>k8%T+5)|Y<31OWeXMc4oU

delta 214
zcmca*({ID&66_MfFUP>Z=(Uk+f&`O~+2lDAtC{?@Cwof%W%uB74tDnAnA|8WQO}sL
z$dP+;0%HL~LIFdJK1+PCQ+$B4r$IoFYp}Dkugd~=mdWVCo_@iM&LM7*=;AJpA&do#
n=%PT?1&j#`y;&A`U>YSI<Qs;|tjRLcQj-m&#5Pw+KVSj?KQBBw

diff --git a/tests/data/acpi/q35/DSDT.cphp b/tests/data/acpi/q35/DSDT.cphp
index d9bb414e9bf15d9b9149f38c9bb5d8b993f88650..e5e7ee11b38e42cb97000ec5fd38b51fcd38d34b 100644
GIT binary patch
delta 270
zcmX?WKhuHBCD<iIQh|Yi@ykZ82@*{15tHXgtY-4^-Rvo8$yo0q>>TXu#}Ta@qt6l_
z>=Ym1>}e1X<QnW8;N$)OKZmoQYq$^-TLD920b@b|L-HbLo(Yo^7^fz40mTvulF@Yq
zyZRI`pbI+tx-1Z%iZ1Hn7?Qlyt^k|x0+q?=!k&J?j0MRZAonCPl!9Ed(0qaEWPWK$
r#^lM?(o$lj$ps8ai!`PtB|3+=MK*&~CNWI@ASK3BnzT7ox`G7&2#ZkB

delta 188
zcmbQ~aMqs7CD<k8tULn)qsm6E2@*`+!IS4mtY-4_*z753$;j!!=N#<p#}TbO*-=K=
z{{R01#)L(V+>;X+3m6g#7-IBU;)9*y1Drh#0)kwFot=GM7PzxaMi=(<3ubf<af_VH
rC?hP-Sip!y9%$}DZ<YlfER*e}B|++>xR@~&2Kj~o6>eTAUBLnX$bvLy

diff --git a/tests/data/acpi/q35/DSDT.dimmpxm b/tests/data/acpi/q35/DSDT.dimmpxm
index 29f19b22a38f9d8e7dc9870f0c1aa3d4470643ff..68859b7c9ff5ed9566650d75924d8ca8868c22fc 100644
GIT binary patch
delta 306
zcmezDvEP%+CD<iozX}5b<DrdQ6C{`%d?(M5Sk2_@wAoWqfsx5YcyhLsOg)FQpKG`f
z6H5U@VgX}90Yma4XPya@6Bwr^a{<K?3X)^=S>l78;scyL4FZB(gPnt2eF_-R1)Y6e
z7Kl$p7j<zANnTojO>}|EWQcG*!eCFoV8(*v4v>2i8A?H}S!lk%6siuPEXX&E(K*B|
wGMS6HfDzqnpd?UVX>tKW(jtwiNr@nZ&0r&w7#J~?d-^d4mnLntkv8W90J=_Di2wiq

delta 173
zcmdn*`PqZZCD<jTScQRs@$E*g2@*^$9+T%ttY&hz-Rvo;z{upmH#u8MMx}r;VUZ*E
z<OIe7hJ*r!7=4!bV5j&1XHSEGAlG1LXJ3~E?kto4ONoj*hqy(eOS?FROfHZXGX)y5
c(3@p}2g_u16+ymXjJR|<NK0+*kT&N805Y91;s5{u

diff --git a/tests/data/acpi/q35/DSDT.ipmibt b/tests/data/acpi/q35/DSDT.ipmibt
index e8dea1ea42af765babcb747af998b0d912abdcbd..a34df87fddbe85a83f713913de58f9dd8c66ffa4 100644
GIT binary patch
delta 250
zcmX?UGsTw6CD<ioiW~z2<B5%2w<Va|ttUU1Sk2^RFnNmPUv_6<=U`_)j>#7##p^ko
z{anL^m>3Hf5(^j;3K)_XIq^)GoWM9W87P!ckQ}4W5+CdoAK>h15D?@V>>TXsQ^0^O
z=<MsVKzu5?sEcDr^3noqq6<_eLxttx27CGiGZrLwfSi-aPzrL)Lh}WtljWo(8Ivb_
nNlS^9CKoUyEz+2pl;|Ad7TF9|nZz*pzmynLY0~Bt>8DHp6X;Bs

delta 228
zcmbPYd(wu>CD<jzQ;vaw@!m$R+Y(GZW|N;wtY-4po;*eJFS`eybFi}?$K;EW67`G;
ziyXNpComQ;Bor{j=(EHJJH-b$dm01;xduBs`?@S}XPJyH?CBTG=p5n}i7xKq7{XY<
rh%O3LUBH;I(3@p}2c}Vz<D@xs(RBdL;bO)#D9ASqXwc^M(odNHC~!hJ

diff --git a/tests/data/acpi/q35/DSDT.memhp b/tests/data/acpi/q35/DSDT.memhp
index dca76db15b943122efd5c200cb54ce3dbc97a55f..8ceeada582a57f7217ebcdc572a6599e8dd798fd 100644
GIT binary patch
delta 230
zcmX@>Hp89ECD<iohB5;KWBEp|2@*`c)|2N*tY&gBoa`z2m)%*|IoR2cWAb}RaRm-%
zKi6;}CdLAW!~({I0*2&8PCOGPCooP;1_~t<Bu}0%DLT1GN`y&#>g0t|!pzA_3qZ6>
z@&c8~G5Rd=!A|i3&YlJVL9W5ho_@iM1<4&C6B8LqLFO$qUto%%EXX&E(K*B|GI{cU
pDJi|u<N}7IMH*9+5<z0kVBJX!j0KEXOfOBEY#=4JSzlU?0|0%*MX&$>

delta 214
zcmbQ?e%6i4CD<jzSDAr<an44r2@*_B=9A}0tY&i6nd~X~m)(QUIoR2cV{)UkL_K4|
zB1i7Y35*2{2?Y!>`YiFmPVoWGo(2IyuEEaEzAg*gStg?kd-?@4I)}JLqKmsYhA<W|
nqKg7m7ceF)^k!M$foYU<kZ%|+vnI<(OHDSA65CuQEyn=>vyD6w

diff --git a/tests/data/acpi/q35/DSDT.mmio64 b/tests/data/acpi/q35/DSDT.mmio64
index 6d8facd9e179140682ad5d4302f3dad14dbec342..318d5de996d97aaf175e232157e48a443ef7bbbc 100644
GIT binary patch
delta 230
zcmaFive}i(CD<iovl0UXqwz+r2@*`c)|2N*tY&gBoa`z2m)%*|IoR2cWAb}RaRm-%
zKi6;}CdLAW!~({I0*2&8PCOGPCooP;1_~t<Bu}0%DLT1GN`y&#>g0t|!pzA_3qZ6>
z@&c8~G5Rd=!A|i3&YlJVL9W5ho_@iM1<4&C6B8LqLFO$qUto%%EXX&E(K*B|GI{cU
pDJi|u<N}7IMH*9+5<z0kVBJX!j0KEXOfOBEY#=4JSzp?c9RP>QMbZEO

delta 214
zcmdn&`oe|FCD<h-Ly3WbF=8Xv1PLZ5^T~50Rx`QkO!k!g%kIJF9PI4JF}YD%qMk8f
zkt6ry1jYh}gaU>beU|uOr}zM8PlJFU*I;L7UzY{$ER)fNJ^g|iokQFr(ZyXHLl_Gf
n(M5r(3m6j?db2F>z%)ua$Ttj^S(9a?r6wCliEXZuwqyqYy%Rh%

diff --git a/tests/data/acpi/q35/DSDT.numamem b/tests/data/acpi/q35/DSDT.numamem
index 737325dc3082fdf06283857811f6f5174e0ff2a9..a964d7c6a4b2a781f8e8791d32e23eadf994b502 100644
GIT binary patch
delta 230
zcmZp%Id8+|66_M<FUP>ZsK1eGf&`PV_2fActC<`OCwof%Wp@^K4tDnAnEYN+T!F*c
z&ox|#iLrnov4An5fFXI26VHUn35-*dfkFud$&=?xicT()5@8abI(ea#Fmv+K0ub$z
zyg+4gj6O?zuv2`1v!_8okZZ8Br(ZB*L2?Jk#6*Ttka-Ku7nouw3-S$PbPjQgOrHE-
pN=mOZxqu;Qk;c@dM37iBSa%WwV*w);(@T>k8%T+5)|bA@1OVH=MWg@#

delta 214
zcmX?a(_+Kr66_MfBFDhM7_yOTf&`P3`Q$kgtC?JNCVNW$W%uB74tDnAnA|8WQO}sL
z$dP+;0%HL~LIFdJK1+PCQ+$B4r$IoFYp}Dkugd~=mdWVCo_@iM&LM7*=;AJpA&do#
n=%PT?1&j#`y;&A`U>YSI<Qs;|tjRLcQj-m&#5Pw+Uu6OS9%VcR

diff --git a/tests/data/acpi/q35/DSDT.tis b/tests/data/acpi/q35/DSDT.tis
index 27ee927fc5ac05b89724c154197304c39e653269..e644f94958f61b174abf6bc05cafc4f4340f70eb 100644
GIT binary patch
delta 230
zcmccZu*{LmCD<ionF0d?W9~+-2@*{1)|2N*tY-2unCvO}m)%*|IoR2cWAb}RaRm-%
zKi6;}CdLAW!~({I0*2&8PCOGPCooP;1_~t<Bu}0%DLT1GN`y&#>g0t|!pzA_3qZ6>
z@&c8~G5Rd=!A|i3&YlJVL9W5ho_@iM1<4&C6B8LqLFO$qUto%%EXX&E(K*B|GI{cU
pDJi|u<N}7IMH*9+5<z0kVBJX!j0KEXOfOBEY#=4JSzlU*6#$QeMb7{L

delta 214
zcmZ4Hc-w)?CD<h-T7iLqv3Voc1PLY|v&nNLRx|l)Pxh4j%kIJF9PI4JF}YD%qMk8f
zkt6ry1jYh}gaU>beU|uOr}zM8PlJFU*I;L7UzY{$ER)fNJ^g|iokQFr(ZyXHLl_Gf
n(M5r(3m6j?db2F>z%)ua$Ttj^S(9a?r6wCliEXZu)?ozz!?Qdw

-- 
2.26.2


