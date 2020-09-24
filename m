Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F13EC4346E
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 07:07:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E386235F7
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 07:07:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zse2KV81"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E386235F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34068 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLLLu-0007zT-B5
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 03:07:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34652)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jusual@redhat.com>) id 1kLLFZ-00010J-5B
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 03:01:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:33951)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jusual@redhat.com>) id 1kLLFW-0005KK-Jn
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 03:01:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600930860;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pdqhR8jPoPpkc4zaJxiwGvpN0edVpcLRY9C9ZvE0TjQ=;
 b=Zse2KV81bbG+JJo+lohHTScBfBN2dc6ewSUNzLaeDwupWs1MPB+B3gP+Nxaz2l42HCQ3Hz
 7csRB6AjlUdU5+NCuYcVlG2fmwIOGFPReE6sclPRaMeAZ3EMhCmKpHBRydXh5FPN2yw3aS
 egkgpJVNvcDagbX8+AHsfQoz/l6Vh6I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-154-2fNT0GN3OAujE9YUgPfNTw-1; Thu, 24 Sep 2020 03:00:56 -0400
X-MC-Unique: 2fNT0GN3OAujE9YUgPfNTw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BB9BC10082EA;
 Thu, 24 Sep 2020 07:00:55 +0000 (UTC)
Received: from pc-72.home.com (unknown [10.40.194.10])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C884D73662;
 Thu, 24 Sep 2020 07:00:53 +0000 (UTC)
From: Julia Suvorova <jusual@redhat.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH v3 7/7] bios-tables-test: Update golden binaries
Date: Thu, 24 Sep 2020 09:00:13 +0200
Message-Id: <20200924070013.165026-8-jusual@redhat.com>
In-Reply-To: <20200924070013.165026-1-jusual@redhat.com>
References: <20200924070013.165026-1-jusual@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jusual@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=jusual@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/24 01:10:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.228,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Ani Sinha <ani@anisinha.ca>, Igor Mammedov <imammedo@redhat.com>,
 Julia Suvorova <jusual@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add ACPI hot-plug registers to DSDT Q35 tables.
Changes in the tables:

+    Scope (_SB.PCI0)
+    {
+        OperationRegion (PCST, SystemIO, 0x0CC4, 0x08)
+        Field (PCST, DWordAcc, NoLock, WriteAsZeros)
+        {
+            PCIU,   32,
+            PCID,   32
+        }
+
+        OperationRegion (SEJ, SystemIO, 0x0CCC, 0x04)
+        Field (SEJ, DWordAcc, NoLock, WriteAsZeros)
+        {
+            B0EJ,   32
+        }
+
+        OperationRegion (BNMR, SystemIO, 0x0CD4, 0x04)
+        Field (BNMR, DWordAcc, NoLock, WriteAsZeros)
+        {
+            BNUM,   32
+        }
+
+        Mutex (BLCK, 0x00)
+        Method (PCEJ, 2, NotSerialized)
+        {
+            Acquire (BLCK, 0xFFFF)
+            BNUM = Arg0
+            B0EJ = (One << Arg1)
+            Release (BLCK)
+            Return (Zero)
+        }
+    }
+
...

     Scope (_GPE)
     {
         Name (_HID, "ACPI0006" /* GPE Block Device */)  // _HID: Hardware ID
+        Method (_E01, 0, NotSerialized)  // _Exx: Edge-Triggered GPE, xx=0x00-0xFF
+        {
+            Acquire (\_SB.PCI0.BLCK, 0xFFFF)
+            \_SB.PCI0.PCNT ()
+            Release (\_SB.PCI0.BLCK)
+        }
     }
...

+
+        Device (PHPR)
+        {
+            Name (_HID, "PNP0A06" /* Generic Container Device */)  // _HID: Hardware ID
+            Name (_UID, "PCI Hotplug resources")  // _UID: Unique ID
+            Name (_STA, 0x0B)  // _STA: Status
+            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
+            {
+                IO (Decode16,
+                    0x0CC4,             // Range Minimum
+                    0x0CC4,             // Range Maximum
+                    0x01,               // Alignment
+                    0x14,               // Length
+                    )
+            })
+        }
     }

And if there is a port in configuration:

             Device (S10)
             {
                 Name (_ADR, 0x00020000)  // _ADR: Address
+                Name (BSEL, Zero)
+                Device (S00)
+                {
+                    Name (_SUN, Zero)  // _SUN: Slot User Number
+                    Name (_ADR, Zero)  // _ADR: Address
+                    Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device, x=0-9
+                    {
+                        PCEJ (BSEL, _SUN)
+                    }
+                }
+
...

+
+                Method (DVNT, 2, NotSerialized)
+                {
+                    If ((Arg0 & One))
+                    {
+                        Notify (S00, Arg1)
+                    }
+
+                    If ((Arg0 & 0x02))
+                    {
+                        Notify (S08, Arg1)
+                    }
+
...

Signed-off-by: Julia Suvorova <jusual@redhat.com>
---
 tests/qtest/bios-tables-test-allowed-diff.h |  10 ----------
 tests/data/acpi/q35/DSDT                    | Bin 7678 -> 7950 bytes
 tests/data/acpi/q35/DSDT.acpihmat           | Bin 9002 -> 9274 bytes
 tests/data/acpi/q35/DSDT.bridge             | Bin 7695 -> 9865 bytes
 tests/data/acpi/q35/DSDT.cphp               | Bin 8141 -> 8413 bytes
 tests/data/acpi/q35/DSDT.dimmpxm            | Bin 9331 -> 9603 bytes
 tests/data/acpi/q35/DSDT.ipmibt             | Bin 7753 -> 8025 bytes
 tests/data/acpi/q35/DSDT.memhp              | Bin 9037 -> 9309 bytes
 tests/data/acpi/q35/DSDT.mmio64             | Bin 8808 -> 9080 bytes
 tests/data/acpi/q35/DSDT.numamem            | Bin 7684 -> 7956 bytes
 tests/data/acpi/q35/DSDT.tis                | Bin 8283 -> 8555 bytes
 11 files changed, 10 deletions(-)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index 84f56b14db..dfb8523c8b 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1,11 +1 @@
 /* List of comma-separated changed AML files to ignore */
-"tests/data/acpi/q35/DSDT",
-"tests/data/acpi/q35/DSDT.tis",
-"tests/data/acpi/q35/DSDT.bridge",
-"tests/data/acpi/q35/DSDT.mmio64",
-"tests/data/acpi/q35/DSDT.ipmibt",
-"tests/data/acpi/q35/DSDT.cphp",
-"tests/data/acpi/q35/DSDT.memhp",
-"tests/data/acpi/q35/DSDT.acpihmat",
-"tests/data/acpi/q35/DSDT.numamem",
-"tests/data/acpi/q35/DSDT.dimmpxm",
diff --git a/tests/data/acpi/q35/DSDT b/tests/data/acpi/q35/DSDT
index bba8884073a27427b88ac0d733c9c87330a59366..56e5b111f3239ea0af2cfb6dea962e3cd837da80 100644
GIT binary patch
delta 329
zcmexo-Dk(;66_MfC(ppZ*twDGAXB}72ZvsKuv2`1v!_9HLx6K|2qX6q9xjgPMgb7V
z87LmA03=)#q8ox;z2X_U&+u@uL^pDSIL=N6u3kV1CqLgHM(!&R2@uEG$uHDbA)3+2
z$Jv`fL^Z(K)r%=w8N~blzaRr7Sy0KC$>3zb>FO1&4iaCo`4m&6WRO2gynBEvN4$rp
z3$LSdfTw|hff<8{WxT6_Aw#rsj6O5Wtq`-21OlA>LZa1?1VAbTd_^}~$?!9JMK^h|
z1b74lK}-(t3ovj58q5(N3bY64I|YyYl7gJlbcLeS;{4L0<kVuITyTgZ7dJ<|b5O7#
UFBg|P;}M=CJd7ff-DS4}00K@~#Q*>R

delta 57
zcmeCP`)AGN66_N4PnLm!am_}qgG`%4m?I>`MdIB9Tsh)BJY9GlodY}#3=GT|1RMo7
N|C8ZooE#~)6#(|i5Rd=>

diff --git a/tests/data/acpi/q35/DSDT.acpihmat b/tests/data/acpi/q35/DSDT.acpihmat
index 9cac92418b5fcc2767dc74603d599642b59623fe..aff5e7d14fdb5b1a332dcc1866d33bff5247a996 100644
GIT binary patch
delta 305
zcmZ4Gw#$RdCD<jzN`--eF?=J}L8f{E4-UQfV5j&1XHSFZh5+Z_5Jv7JJX{>njRGK!
zGf+HK0Z6zgL^lMxdc`wxpW)$RiEiWuah#nDT)lu2PJX^YjNDfs5+IJVlV7N>LNue3
zkFz&}h-!eds~1zWGKly8e?bOFvY?VNlflV=)72|l9VEVF^C_lQxgdX*c=rHTj(87G
z7hXr_08ax012YB@%Xn7<LxyPO7=31#TOnp42?RL%g+!|(34l}x_=;{$Q{-n<k8bi}
x3GfIAf|wlO7hvEBG?*hk6lf37cM2Z)B?UR9>5~JLWZ91J9N}RUnOv;29RTA-R3QKW

delta 57
zcmdnxvC56hCD<iIOPPUzv2r8VL8i?i%q?=_BJu74t{m|mo-VwO&H<hV1_ovf0*->4
NwUqc7C$}nZ1pvgG4-fzV

diff --git a/tests/data/acpi/q35/DSDT.bridge b/tests/data/acpi/q35/DSDT.bridge
index f08b7245f59aad491fcaa60e2bab1085c369ea1c..355c4462bb414efb83f530aa1eb9073dda899379 100644
GIT binary patch
delta 2280
zcmZ{mO-~a+7{_O~MV4tx7g*jYG(kl#xTrueCenQoTIsUswj^eWdoaY3n9zWjn38Pa
zK*GrbUx0&Oz;N?s!pV5_`{46*_bELvm!|*u|N5KR?(DSRUtd(X<yp0h$BaqlPySmD
z)lFqF@QlDUOS<27O|K@UZqi)wPgM*ijMww<V&(m|XO{yh^*7Cv{%Hz>Y3Ozt3d5;X
zrPRNuz+f6qy^{AOW6ONUv`4OKmt}t*)9r1ufo1cXw9gEEz%Kg>IR4}MkNkeJx}6L*
zTw4h?OID_6x+PuLSD3aI*!mLl=XakaXswZ}XTUX`n!nI9fP`8Zy?!;5mCF8EIq7b?
z)yV8Ru3iMO64YTHxVrr2!I$Re<4^g+y`zKU!;gDM(0R2YPbq;}^@cK>Z%8-ko3x}|
zZshiP>0}odq83jsf92kU+h4sUJy3$8RZTM{GsW=iE#{v+^mH8d>JI3jWZH0Gmvsrh
z4@9u>&z^XCA)+KwNcWRZqiNt%TqaazT6muo*x1Sw#3n@A=kYRmlF+0OC2Jp{eW8eb
zLD~nzJ`kd$?I*NfguW!J5~Cqgge++XNIM`xmr2VB<wBIKusz_mhH%qUB6fweY0{>J
zC}}f<W<=;JSqA|PJKJth$dWco+N=mIkX9vB6{2JvQo?xS4~f_{(hie$ScsB#gwPQY
zS|n?z5vvJV(vA{3Dnbp?juAR0L?dhH@Nr_tMXX8M2|_1?C@pr9&`A+$p*6$<VT#x(
zAxqk6LZ?NjO^cl&bVi64g0OSM@f@)^5&M?3vxLqHQCjRAp>y}4nv=73LZ>EQrCJS%
zo#TPKf0b@ExQw9?ha?0zp`%8@K#d9kPQR$hW1wao0vupb)5d^JrqxI>oCr>#ILRT#
zZi#cjSrV5x*>bnT+2BBkJDhH%+u?lhSjQbsxQbo2)qvwgVvynKq%3!G+~fI^!~uBD
z2v9otPM~6jCx-fbC*Sq!m|^Qv-|pnQzH`m6hpC5OxpU8q`VdzLD>(OHJ9YuQa;ryx
z*ADxt+vhR&^y`pegLL~gX6Us!{Ap)RhJPEZ9jAtWNu>CV#S@yE?EoJZ@fPFT|1AtG
AF#rGn

delta 95
zcmeD5?YH4_33dtLmt$aH^xnvIkZE%WbA+V0NW6Q1D@VMCrwgy6bAYFTfq@x=fTQ5%
ze=_`xlOyHQx%^pU;)9*y1>9LDpOUi|;}148i06oRbP3{NU|?bpVGD5f3t<2NdEgd>

diff --git a/tests/data/acpi/q35/DSDT.cphp b/tests/data/acpi/q35/DSDT.cphp
index 57d859cef9fa16a8f125c4b338611c8472699f38..4d66dc1c564e6b3ff2a5cc1cf9c8447a095ab9a4 100644
GIT binary patch
delta 329
zcmX?Wf7g-ACD<k8t^xxCBlAYCgG}`T9vph{!A|i3&YlL*4FS%<A&lHdc(^#C8wEfd
zXP|hf0+4V~h;9gW^@?ZYKEuPs65YrR;y61QxOxF4ocw%)7`d-NBtRTzC%;f%g=j`6
zA7^g{5!C=^S1+b$Wf1TG|AGvVWI-ikCWDg!r>j@AI!JuU=2J`>(n0<#@$Lbx9Pu8W
zF1(J;0iFg124)N*mhr9zh78flG5X9fw?fQ95(sei3yD@o5&)?X@D<(6DaX&~72V{;
z65tUK1Ti_lFTlVNXfQ{7D9|3D?-V@pOA2yI(-n$Ri}Op1l2eO;a={^vT-+S-&OyO~
Uyj)!Fj7NBm@Gy!@7L(r&0AY4nrvLx|

delta 57
zcmccXc-EfFCD<k8tULn)qv}SkgG`%4nAN4lMdIB9Tsh)BJY9GlodY}#3=GT|1RMo7
NpOxchoUEa+6#&;`4{`ti

diff --git a/tests/data/acpi/q35/DSDT.dimmpxm b/tests/data/acpi/q35/DSDT.dimmpxm
index 9d5bd5744e2ba2e0f6126c3aba0bb36af865e499..050533a0353f38cdb4d23fd52898dd4ce1aef9a9 100644
GIT binary patch
delta 310
zcmezD(d^CT66_MvtjfT^_-Z59L8f{E4-UQfV5j&1XHSFZh5+Z_5Jv7JJX{>njRGK!
zGf+HK0Z6zgL^lMxdc`wxpW)$RiEiWuah#nDT)lu2PJX^YjNDfs5+IJVlV7N>LNue3
zkFz&}h-!eds~1zWGKly8e?bOFvY?VNlflV=)72|l9VEVF^C_lX@@dX&@$Lbx9Pu8W
zF1(J;0iFg124)N*mhr9zh78flG5X9fw?fQ95(sei3yD@o5&)?X5eDisVQ7m1`_V7V
zC5Wp*z*lthdL@2Fj_4*YmH>}{pvjHOBHTbPDtP3V6y%hqPoAkP%XWn42oIyk<UPvU
E0s3xOTmS$7

delta 77
zcmZqn{_Mf!66_LEtir&+_--TDL8i?i%sb_^HR9a^Tsh)BJY9GlodY}#3=GT|M1<pA
h4NMr?V)WvJo#Oq%T!Oe71RMo77c28KPCloy6##DT7A^n)

diff --git a/tests/data/acpi/q35/DSDT.ipmibt b/tests/data/acpi/q35/DSDT.ipmibt
index 5cd11de6a8fe47324e5f922823a22746882f19f5..31eeedfb978aaeb469e442ae9748dd62a5285bd2 100644
GIT binary patch
delta 301
zcmX?UbJLE?CD<h-Ql5c<aqmVh9_D%h4-UQfV5j&1XHSFZh5+Z_5Jv7JJX{>njRGK!
zGf+HK0Z6zgL^lMxdc`wxpW)$RiEiWuah#nDT)lu2PJX^YjNDfs5+IJVlV7N>LNue3
zkFz&}h-!eds~1zWGKly8e?bOFvY?VNlflV=)72|l9VEVFvnX?<WRO2gynBEvN4$rp
z3$LSdfTw|hff<8{WxT6_Aw#rsj6O5Wtq`-21OlA>LZa1?1VAbTd__06%J4JFM>lz~
t1b74lK}-(t3ovj58q5(N3bY64yUBu*!jr3Hh1ibp9N}RUnLJ5$I{*hoQAGd%

delta 57
zcmca<chZK-CD<jzQ;vaw@%~0G9_G#SnIj~{MdIB9Tsh)BJY9GlodY}#3=GT|1RMo7
Nd&=@NPF^Cn6#&f^4^#jE

diff --git a/tests/data/acpi/q35/DSDT.memhp b/tests/data/acpi/q35/DSDT.memhp
index 05a7a73ec43130d5c3018bb462fd84981bfb151c..798a12399399ebb163b8231ef54d5e566d8dfc88 100644
GIT binary patch
delta 329
zcmX@>cGrW;CD<h-R)v9qv3eudL8f{E4-UQfV5j&1XHSFZh5+Z_5Jv7JJX{>njRGK!
zGf+HK0Z6zgL^lMxdc`wxpW)$RiEiWuah#nDT)lu2PJX^YjNDfs5+IJVlV7N>LNue3
zkFz&}h-!eds~1zWGKly8e?bOFvY?VNlflV=)72|l9VEVF^C_kkazXwq@$Lbx9Pu8W
zF1(J;0iFg124)N*mhr9zh78flG5X9fw?fQ95(sei3yD@o5&)?X@D<(MsmRah72V{;
z65tUK1Ti_lFTlVNXfQ{7D9|3D?-V@pOA2yI(-n$Ri}Op1l2eO;a={^vT-+S-&OyO~
Uyj)!Fj7NBm@Gy!@o~E=N0Pb*GIsgCw

delta 57
zcmccXan_B?CD<jzSDAr<aqdR0gG`%4n3v0mi^RJJxN^jMc)IX9ItO?f7#Nr_2sjFE
N_Eq9%oV-GLD*)!v5C#AM

diff --git a/tests/data/acpi/q35/DSDT.mmio64 b/tests/data/acpi/q35/DSDT.mmio64
index efd3f1188f2b55da1514212d4be081a61c2a96e9..61e0515c6007ec2d16db57e8f6052376c6467359 100644
GIT binary patch
delta 305
zcmaFi^23eGCD<jTLYaYq(R?G<L8f{E4-UQfV5j&1XHSFZh5+Z_5Jv7JJX{>njRGK!
zGf+HK0Z6zgL^lMxdc`wxpW)$RiEiWuah#nDT)lu2PJX^YjNDfs5+IJVlV7N>LNue3
zkFz&}h-!eds~1zWGKly8e?bOFvY?VNlflV=)72|l9VEVF^C_lHvO)eV@$Lbx9Pu8W
zF1(J;0iFg124)N*mhr9zh78flG5X9fw?fQ95(sei3yD@o5&)?X@D<%WS%IHXJ-W$@
xCBP#f2x4-8Ux0xl&|r@EP@p|P-zj+HmlWibrcbU_lw~`@bA*RcWby*V69BpsRd)aY

delta 57
zcmez2_QHkBCD<h-Ly3WbF>)i<L8i?i%o}CJMdIB9Tsh)BJY9GlodY}#3=GT|1RMo7
Nhb!_kPTr(+3;^ux5IO(=

diff --git a/tests/data/acpi/q35/DSDT.numamem b/tests/data/acpi/q35/DSDT.numamem
index 1978b55f1255402bf9bade0b91150b5cb49789a4..5ae686dd818d1427dfe4c3e73cc0342cc4e578a7 100644
GIT binary patch
delta 305
zcmZp%nPSJ~66_KpBG16UXuOf@AXB}72ZvsKuv2`1v!_9HLx6K|2qX6q9xjgPMgb7V
z87LmA03=)#q8ox;z2X_U&+u@uL^pDSIL=N6u3kV1CqLgHM(!&R2@uEG$uHDbA)3+2
z$Jv`fL^Z(K)r%=w8N~blzaRr7Sy0KC$>3zb>FO1&4iaCo`4m&UWRO2gynBEvN4$rp
z3$LSdfTw|hff<8{WxT6_Aw#rsj6O5Wtq`-21OlA>LZa1?1VAbTd_^}q$nZ0&M>lz~
x1b74lK}-(t3ovj58q5(N3bY64I|YyYl7gJl^vPPXvTR3qj_@#wO!k%C4gm3?QpNxP

delta 57
zcmbPY*J8uv66_MfBFDhM7`l<`Ak*d$<~T`lk$Cq2SB`iOPZwTC=KxOw0|PS#0Y|~j
NEVBHJljG&K0sxuq4d4I(

diff --git a/tests/data/acpi/q35/DSDT.tis b/tests/data/acpi/q35/DSDT.tis
index 638de3872673d17b1958497d0e62c83653de1602..dd712090ee9c09ed98f3b658951ac8a62b31a7d4 100644
GIT binary patch
delta 306
zcmccZ@Y;#XCD<h-Takf*v2Y{TL8f{E4-UQfV5j&1XHSFZh5+Z_5Jv7JJX{>njRGK!
zGf+HK0Z6zgL^lMxdc`wxpW)$RiEiWuah#nDT)lu2PJX^YjNDfs5+IJVlV7N>LNue3
zkFz&}h-!eds~1zWGKly8e?bOFvY?VNlflV=)72|l9VEVF^C_lC$sm80c=rHTj(87G
z7hXr_08ax012YB@%Xn7<LxyPO7=31#TOnp42?RL%g+!|(34l}xc#3Vdl96Uqk8bi}
y3GfIAf|wlO7hvEBG?*hk6lf37cM2Z)B?UR9>5~m)W!aAK9N}RU*&Hm(!3+S%CsU9B

delta 58
zcmaFublZW;CD<h-T7iLqv1KFIL8i?i%n_2}BJu74t{m|mo-VwO&H<hV1_ovf0=|Nq
O|H()*ZcdeBV+H{6kq@H)

-- 
2.25.4


