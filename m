Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C087C4346E
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 08:09:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAC4320897
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 08:09:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i47nfE7d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAC4320897
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55834 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNAh5-0007US-Nj
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 04:09:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58934)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kNA0a-0007WA-Al
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 03:25:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:29995)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kNA0V-0002B4-Hb
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 03:25:07 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601364302;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HYZ0rmq0i9bDam+W7wYCu1belyKaPs0MGFjUPQLNfBw=;
 b=i47nfE7dyWDpLbkZbDRjsuj/7ocb90f0Attcs+OKKs12YVqtDvbqkr3BN5BciLZSIqQNlW
 TvwG9B2OMNCWlEoOUnM7Blulv6l4mO5gltvzHFBz06sXjkKjDw6rY4eZ5eaM3lgLbFpZ38
 x26oIDBjczA9sqitdlcURVRZ9F1FWFo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-379-UEbAT3g6NjOJefomrmX57A-1; Tue, 29 Sep 2020 03:22:17 -0400
X-MC-Unique: UEbAT3g6NjOJefomrmX57A-1
Received: by mail-wr1-f70.google.com with SMTP id o6so1364779wrp.1
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2020 00:22:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=HYZ0rmq0i9bDam+W7wYCu1belyKaPs0MGFjUPQLNfBw=;
 b=h/Z/3gmkY2UH3PJpRhXThach6stJMkwTIopseHdNDhhStdEdhSsciAxXnJ3SDFzb7N
 0/RcrphX0rUbElZuoOnBIF4WZWBx9b6Q6SjYimG4ZtO0AUBfEszpgmCbX9+xferyOznq
 WfmC6rLv1qcd8IDA1waJgLrQEVxbi14f8WCejnyih45yrFvtGrJZhOMwTG665vRJ+Rqm
 QMREcDQD3NxrCEPfS8Gd1jFSK4Y2zdHNvV0iHvt6keUkVBv82l9No3zNocv0XB8VmFfo
 LSypQ1Qv29zRQO63k9AO9OtM551wvGzB2/gFhAZKI9VF4rF5H6Sq0tsgNyTNQFnInkKn
 nx4Q==
X-Gm-Message-State: AOAM532DkSxbws5K8ObMZXLcP+5M57hhJo01R3dhMuov5hf8d3Nm9FAO
 Peqj5Laj7gWtihioKMKBFRev+ieaSuNcn7GiYAFx/PbfGleU3Eu5NshRB6djeQMIqLP6gc9/Y9J
 VPqTaE2h8PLeLZ8c=
X-Received: by 2002:a7b:c1d9:: with SMTP id a25mr3096042wmj.4.1601364135639;
 Tue, 29 Sep 2020 00:22:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyhxQ8wmpGFJhHzoqGySFn4HUkZuBaOD6hF3nVSorebhIFaVKh38BNWKJJ8FNfUOYrndG6yLw==
X-Received: by 2002:a7b:c1d9:: with SMTP id a25mr3096019wmj.4.1601364135350;
 Tue, 29 Sep 2020 00:22:15 -0700 (PDT)
Received: from redhat.com (bzq-79-179-71-128.red.bezeqint.net. [79.179.71.128])
 by smtp.gmail.com with ESMTPSA id u66sm4143845wmg.44.2020.09.29.00.22.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2020 00:22:14 -0700 (PDT)
Date: Tue, 29 Sep 2020 03:22:13 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v4 30/48] tests: acpi: update acpi blobs with new AML
Message-ID: <20200929071948.281157-31-mst@redhat.com>
References: <20200929071948.281157-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200929071948.281157-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/28 22:47:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Igor Mammedov <imammedo@redhat.com>

here is diff against tests/data/acpi/q35/DSDT
for currently shipped ovmf binary.
(once firmware blob is updated, it will negotiate CPU hotplug
feature which will ad extra hunk sending SMI and Q35 tests will
need to be updated), but otherwise diff shows new CPU hotplug
AML that is shared between q35 and pc machines.

             Method (CSCN, 0, Serialized)
             {
                 Acquire (\_SB.PCI0.PRES.CPLK, 0xFFFF)
-                Local0 = One
-                While ((Local0 == One))
-                {
-                    Local0 = Zero
-                    \_SB.PCI0.PRES.CCMD = Zero
-                    If ((\_SB.PCI0.PRES.CINS == One))
+                Name (CNEW, Package (0xFF){})
+                Local3 = Zero
+                Local4 = One
+                While ((Local4 == One))
+                {
+                    Local4 = Zero
+                    Local0 = One
+                    Local1 = Zero
+                    While (((Local0 == One) && (Local3 < One)))
                     {
-                        CTFY (\_SB.PCI0.PRES.CDAT, One)
-                        \_SB.PCI0.PRES.CINS = One
-                        Local0 = One
+                        Local0 = Zero
+                        \_SB.PCI0.PRES.CSEL = Local3
+                        \_SB.PCI0.PRES.CCMD = Zero
+                        If ((\_SB.PCI0.PRES.CDAT < Local3))
+                        {
+                            Break
+                        }
+
+                        If ((Local1 == 0xFF))
+                        {
+                            Local4 = One
+                            Break
+                        }
+
+                        Local3 = \_SB.PCI0.PRES.CDAT
+                        If ((\_SB.PCI0.PRES.CINS == One))
+                        {
+                            CNEW [Local1] = Local3
+                            Local1++
+                            Local0 = One
+                        }
+                        ElseIf ((\_SB.PCI0.PRES.CRMV == One))
+                        {
+                            CTFY (Local3, 0x03)
+                            \_SB.PCI0.PRES.CRMV = One
+                            Local0 = One
+                        }
+
+                        Local3++
                     }
-                    ElseIf ((\_SB.PCI0.PRES.CRMV == One))
+
+                    Local2 = Zero
+                    While ((Local2 < Local1))
                     {
-                        CTFY (\_SB.PCI0.PRES.CDAT, 0x03)
-                        \_SB.PCI0.PRES.CRMV = One
-                        Local0 = One
+                        Local3 = DerefOf (CNEW [Local2])
+                        CTFY (Local3, One)
+                        Debug = Local3
+                        \_SB.PCI0.PRES.CSEL = Local3
+                        \_SB.PCI0.PRES.CINS = One
+                        Local2++
                     }
                 }

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <20200923094650.1301166-11-imammedo@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/qtest/bios-tables-test-allowed-diff.h |  19 -------------------
 tests/data/acpi/pc/DSDT                     | Bin 4934 -> 5060 bytes
 tests/data/acpi/pc/DSDT.acpihmat            | Bin 6258 -> 6385 bytes
 tests/data/acpi/pc/DSDT.bridge              | Bin 6793 -> 6919 bytes
 tests/data/acpi/pc/DSDT.cphp                | Bin 5397 -> 5524 bytes
 tests/data/acpi/pc/DSDT.dimmpxm             | Bin 6587 -> 6714 bytes
 tests/data/acpi/pc/DSDT.ipmikcs             | Bin 5006 -> 5132 bytes
 tests/data/acpi/pc/DSDT.memhp               | Bin 6293 -> 6419 bytes
 tests/data/acpi/pc/DSDT.numamem             | Bin 4940 -> 5066 bytes
 tests/data/acpi/q35/DSDT                    | Bin 7678 -> 7804 bytes
 tests/data/acpi/q35/DSDT.acpihmat           | Bin 9002 -> 9129 bytes
 tests/data/acpi/q35/DSDT.bridge             | Bin 7695 -> 7821 bytes
 tests/data/acpi/q35/DSDT.cphp               | Bin 8141 -> 8268 bytes
 tests/data/acpi/q35/DSDT.dimmpxm            | Bin 9331 -> 9458 bytes
 tests/data/acpi/q35/DSDT.ipmibt             | Bin 7753 -> 7879 bytes
 tests/data/acpi/q35/DSDT.memhp              | Bin 9037 -> 9163 bytes
 tests/data/acpi/q35/DSDT.mmio64             | Bin 8808 -> 8934 bytes
 tests/data/acpi/q35/DSDT.numamem            | Bin 7684 -> 7810 bytes
 tests/data/acpi/q35/DSDT.tis                | Bin 8283 -> 8409 bytes
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
index b121bb5bc124be522e233516efb17cdc94de5a75..4ca46e5a2bdb1dfab79dd8630aeeb9a386d8b30e 100644
GIT binary patch
delta 323
zcmX@6c0`@aCD<k8h%f^K<C%?ITiBSq>?R*zTg~KaJUN&BFO!?t<Qxu}dJbnl*Ki@G
z{{;-m1&k?+T!bd4FcvVR6fh<fFeEPW;h8WwfpKawP$;1wIYyr)KG-Qfz}eFvAjmb?
zIoQ>wfB{|5+1F)(_*8UJ7srs~r3*MGCvyD<TC=nOCSMOT3#4Fy%4C>0OxV*en6V(a
z1LVj=hSEf!vlf~!FvU<7<QvB59O4$4%*9;5h;9Z@5~!~<xqu;Qkt@s8q{M<|uz^Vo
e$<Ev$O+Xu>4GWSd>u{*D0xc{}+HA|o$prw{_+k$L

delta 193
zcmX@2eoT$aCD<jzO_+g!@xVr|Eo@9aW|I%Ft!DDqo}A16m&t=~at?<KUjbvnB1i7Y
z35*2{2?Y$34Y`E<7Pzxaj?rg{4|a+VaP~9^2yzW}_Vf#8bPjQgL>G5)3}Gx_L>C3B
l2AaFjn`MCq%VZl)NnLaWKy6&inEHZz!+`oW@8;y>0szAaHLw5x

diff --git a/tests/data/acpi/pc/DSDT.acpihmat b/tests/data/acpi/pc/DSDT.acpihmat
index b0dbb943f4cea83a5adde23aefa54f1678c560a1..35a74bce8cc152ecb615cb38c4b7f63c7c7d3ab3 100644
GIT binary patch
delta 304
zcmexl@X?UVCD<k8qXYv3W9LS$Eo@AlE|U+it!DDE+?>nK!N}<@<{a$o#}TbOnUO=-
z>HmKYXFu0)A*TNY49NwIDT`c%CZ{kKFr*YPCKNCvF7oA>Fgby7YBCp70YgGTa*RGp
ze6Uk|fU~DTK#*&&bFiz=<oO(8_2N^}Wn3IXl9w*voSew@A872-0&MaNR3@Vfd-?@4
z79@9o+?2>rnh12oLh}Wt7|Mct!x)`I+#-{?m<t$V^e3BeiYS&Q7ce9(a%GvClvvOV
kHX(^28LS9sVzgmF^5i;BRaT${rAd?HIm9-{af<K*0E&TJnE(I)

delta 209
zcmexp_{o6FCD<jTNP>ZZv2P>S7B(g?o5=^*Rx|k;Zq8-rVC3}Ra}IX)<A_$C%*Y|E
z_WyqYW5Oaw?#T&^1q=xV3^DpF@xe~<0nVNV0YR?8&d$Cr3*1>ID{_iTIET1JqD#9t
vhA>Xvz$xkvG-aVT%K{IU$>>Uge8U)VXysxqV8o&vXx8L-4zbO5IYsyZgN-`x

diff --git a/tests/data/acpi/pc/DSDT.bridge b/tests/data/acpi/pc/DSDT.bridge
index 7b6c7a47875fc73b03fbe88807890f3867ddba1a..803d7a8e839ea8b7ac33c4490459ddaede584269 100644
GIT binary patch
delta 323
zcmeA)Z8zg`33dr#mu6sK6xqnNg^kI}Zt?-P)l9y|lXKbsGP#LO&f$=$=WzCO4Hshi
zU%-%Dz?ibgMQCygV*x`-0b@b|L*gPIo(Yo^7^fx!g%S#qWAs_#gPr07oIMQ!f?R{0
zgI#?J7|;cseO(raPem7XaSTabx`1<XBG-SQHA@R%^7SyYKnfP9OooZWggyO&84Hp-
zK#ojgC`|-9YoYl9Qw(K6zF~~cA#Rb$T+9WG=w<*Vf%;053mB3Xxw1@6N-Ssw8<@n9
d?92_)1hgUAupoJ|4u>i$(8AKB&9<CAf&i#*V2}U+

delta 193
zcmZoS>onzZ33dtTlwx3D<lM-$g^kI_Z1MrN)lB}{lXKbsGI{V#&f$>ZD_~4m<j6fa
zfw6!gp@3nsA(yb<0(X|lG5Rd=!A|i3&YlJVL9W5ho_@iM&LM7*=;AJpA&do#=%PT?
kKyw#*vn=pnnQX%;sf(@vsEvymQ(us87*OBl-JCvx05hyLF#rGn

diff --git a/tests/data/acpi/pc/DSDT.cphp b/tests/data/acpi/pc/DSDT.cphp
index c0e8aa5b32d84f39e5d6c9a5024505f818707c12..8bab2f506409f2b025a63d8b91c7bfdaa931e626 100644
GIT binary patch
delta 251
zcmbQLHAS1tCD<ioiYNmEqrpb5Eo@9)(UT9bt!DBK*qqC5$;j?5<{a$o$1&NTLtK}`
z+0Qjxi0OX;LvjIQ$|6^x$tjEl3@HVS2?Y#^i+p(|Oio~&n#{#kz>rXoJo!Jn=;TWr
zB23~_Co^&i^CmA{z&SaQ>pxKE(gKi(OY#Dh$uasY@xe~<0nVNV0YR?8&Yph3j0MRZ
zAd3<iN)v%bFEn3ZilHpXH;mCa#4R#;ay+M$Vrg;#L((EwmZ?dJ1<hc+NeszgX`orr
ZhCsKh=Tv0{8eN(+c>;&n=6=pLZUB`uOrrn*

delta 220
zcmbQDJyna#CD<iIRFr{%(Q+f#7B(jD;K>KrRx|l|Y|dr3WMuc?a}IX)<CyHvArZis
zu*i{nasp!kLqY*Vj6O?zuv2`1v!_8okZZ8Bv#-kncb3WM!k&J?jLso$k?7(sjv<Vb
sA99NN7ceF)^k!M$fvGjfHw>3nF6IJ8bQ6Kffo4sfz#+DokE@Lv0MS-FWdHyG

diff --git a/tests/data/acpi/pc/DSDT.dimmpxm b/tests/data/acpi/pc/DSDT.dimmpxm
index 1649953b6cccb933e4a440dc56507dc9197c4a8a..e015b4594c96a6e0f34c0668e3383b9a91dff38e 100644
GIT binary patch
delta 308
zcmdmOyvu~kCD<jzN{WGjQF0^K7B(j5fXN5gRx`P|Zq8*_U}SO^o7~SKQ_tb-=Nc}=
z^uK^1xqvZck*m<;6vhIElmf<t0*1szzC05qCooP;=3*&eNGM2-(PxPdc8U*h_B03x
zat(G4cJ(P>Ko@lOby*-j6<yTDF(i5E0?x^aT>pXgEG>Y_^TW*oDOjK~`8<bcdO>mr
z$W@69rHMdyEHqzWIvL%#Am1=X=McBZWG?0cMl6y*eWl3-3`vVzS*9i>7BqtmOkzj|
c>tQTNjy5bvp6t(|%IfJCT$;2wfiqeF0OOlnivR!s

delta 210
zcmdmGvfG%;CD<iow<H4tqvA%cEo@9K9+MBSt!8q!-JHv=z{upmH@TlfroMnNVUZ*E
z<OIe7hJ*r!7=4!bV5j&1XHSEGAlG1LXJ3~E?ktnhg+2X(8J$DiBGJWN977lj7|}(6
os)4pF^k!M$fnn6-0!~hGbPYgbxR?tVCns_W1F3|~_c@~l0B9gOg#Z8m

diff --git a/tests/data/acpi/pc/DSDT.ipmikcs b/tests/data/acpi/pc/DSDT.ipmikcs
index 92748d49dcd418e4a734da47e8d5c0268aedfc29..ca6630e39f60ebd5c056f57c4c03fdb9d5467577 100644
GIT binary patch
delta 304
zcmeBE@6q6L33dtL5n*6pjNi!hhmFb0ZZZe^Y9?Rf$y?d~*1L&02Rr+5L@USWv&08G
z#RoWh8UzHn20I7%c>n*;;q2!cF2wY|fFZenF=dg9(Bu@x0)~_V#)JZf#6><l6DB7x
zPE7_1B@`s18xZX3Q^0^O=<MsVKzu4fG#Fx;i(^Rg(gmE86S@8a?O9rYP=JtMpfVX<
z*wZhVu^_nv<j6#Z(nO%M7Md?Goovr3$(TGjn^Q`$G`WBwX^|_-)TG3MX0W;>hGgdu
cw@9FylcNm_k|*!xRAmJkQ<}87m6MYT0IdjJEdT%j

delta 202
zcmeCt=u_u%33dtT6J}sw4B5!_hmFa{Y%&M?Y9@c}$y?d~vU~732Rr+5Ojh8M;ATu%
z<j6fafw6!gVKP6bSiL*T<QRRH_+Y2_0B28wfFRdkXHUOiM&}T>NOW-*#}LK>Ms!i2
n>H@}uh2AU+JTQ$4@(sgf6c;ndtjS9_MJ6xg65TAp^@S4v*7-NU

diff --git a/tests/data/acpi/pc/DSDT.memhp b/tests/data/acpi/pc/DSDT.memhp
index 4026772906e910af514beb76de6e4cca0bc2171b..43f4e114e2cc48c68c35af47303fa87c9255db40 100644
GIT binary patch
delta 323
zcmbPgIN6BHCD<iISdxK(aqmX1Eo@8<_LC2=t!8pInVif1m&r|Rat?<~J%_WOYq${8
z{{n{O0>+d@E<%%27z-Fu3K$a#7!nux@JyJTz&JG-D3nl;9HY+?AM6w#;OuD-5ab%{
z9PH{-z<@63?CY{Xd@8!Ai(^Rg(gmE86S@8atyx+Cldp%F1yZm;Wim`0ChX}K%vg}z
z0diy_Lun$=Sqse<m|`dk@(p8j4snZ2=3*{jL^lH{3Dj4bT)>dD$dzSkQer_f*uW%)
eWM^)WCZG+`h6Tx!bvRU6ffkk~ZMNl%;0FMI?qN#+

delta 193
zcmbPiG}VyHCD<iosssZA<ED*VTiBSK%qJgUTg~LEGdY+2FOvt~<Qxtez5>RCMULE)
z6Br8^5(*e58*&NzEpTU<9HY+?AM6w#;OuD-5ab%{?CBTG=p5n}i7xKq7{XY<h%O3L
l4K#P5H_HMKmdQ4plDg;$fZDj2G4%!ch5_|$-pv`o4*;<`HS7QY

diff --git a/tests/data/acpi/pc/DSDT.numamem b/tests/data/acpi/pc/DSDT.numamem
index 4d9ba337a82954af094e739b8a83467f89a37cc0..ba8f7e6c33f9eb0f7a080144fcb4a27d36aa04ae 100644
GIT binary patch
delta 323
zcmX@3c1oSgCD<k8lrRGWW7$ToEo@8<_LC2=t!8pInVif1m&r|Rat?<~J%_WOYq${8
z{{n{O0>+d@E<%%27z-Fu3K$a#7!nux@JyJTz&JG-D3nl;9HY+?AM6w#;OuD-5ab%{
z9PH{-z<@63?CY{Xd@8!Ai(^Rg(gmE86S@8atyx+Cldp%F1yZm;Wim`0ChX}K%vg}z
z0diy_Lun$=Sqse<m|`dk@(p8j4snZ2=3*{jL^lH{3Dj4bT)>dD$dzSkQer_f*uW%)
eWM^)WCZG+`h6Tx!bvRU6ffkk~ZMNm)=K=t6nPI;G

delta 193
zcmX@5enySUCD<jzN0@<uF>52&7B(g)^T`L;Rx`QkOwMKh%jCf~Ifp}ruYfUOkt6ry
z1jYh}gaU@ihFrpa3*1>I$LO=f2Rp?FIC~ld1i1z~d-?@4I)}JLqKmsYhA<W|qKg7m
l1I=CN&9cCQWwH&Yq%OJwpf)aMOnpJVVL*MGcXRS{0RV_rHDCY$

diff --git a/tests/data/acpi/q35/DSDT b/tests/data/acpi/q35/DSDT
index bba8884073a27427b88ac0d733c9c87330a59366..d6c26940b1a68d4184f6f2335924099aa28b130a 100644
GIT binary patch
delta 249
zcmexo{l|vOCD<jTMvj4jar;KD2@*_Rc9Z8wtY-2xp6n_4m)%XwIoR2cWAb}RaUBk4
zKi6;}rvC*D$pwrli(G^zr!W>Uq!chF6fh(%^5K~<Ie~F%GEgX?AbIk9NzutgQX)*^
zQztK!66Q@_x`1<XBG-SQ#-#-y5trlzDwAXMS>l78;scyL4FZB(gPlG7f*A{vJ3#g%
zGL$9)O<riez!XDSkZ%~HbBJ4H^5p+gQi`R?1q?}xTv?_jB^ES;^(HYSgQbCHMH>R$
W;xDbr3N*SjX|jQo*k*m{^GpEqI!~+s

delta 203
zcmexk^Us>gCD<k8pDY6d<C=|J6C{{?%qGu~Sk2_GJ=s(8FS`eybFi}?$K>~t63UDT
ziyXNpComQ;Bor{j=(EHJJH-b$dm01;xduBs`?@S}XPNv_N>su*#4QqC+Ql)1adLyS
rsDA-t!a{GB1s*Ju(Uk=GhB4yM%Ees3h($TjtjPvaVw=}WpJxI9Z#6rr

diff --git a/tests/data/acpi/q35/DSDT.acpihmat b/tests/data/acpi/q35/DSDT.acpihmat
index 9cac92418b5fcc2767dc74603d599642b59623fe..2b67045d6add69574499b97d938cca01949231b4 100644
GIT binary patch
delta 288
zcmZ4Gw$h!;CD<ior7{BpW64IY2@*`6E|cd-tY-4D-0UgI!N~3|<{a$o$1!=Lq<B4t
zv!83Y5YztxhU5aqltr#WlT#QA7*Yxt6ABm-7y0r`n4G{kHJOX4fFYqEIYyr)KG-Qf
zz}eFvAjmb?IoQ>wfB{|5+1F)(_*8UJ7srs~r3*MGCvyD<+OxC(DsKii3#4Fy%4BqX
zo_@iM1<4&CS0*x)CIa2H(0qaE<a<(*jLDO^q@@%~lM5J<7P+!aO-d|i2CGYANOlf!
bi%bUUi#9Aso*X5u$_g~5G-<PnG#dv1HTG7>

delta 203
zcmZ4KzRHcuCD<iIOPPUzv2r8V1PLZDo5^z|Rx|k;ZuXSqU}X2;a}IX)<Cr{AQi7W?
zVUZ*E<OIe7hJ?xMrNrvpStiHmv&08G#RoWh8UzHn20MHD1v5H_xJ9CiyEuk07BHfV
o0#z3<CM@)3S>S<bRFH2NE~B`ZL1s;MkrtWkC?mRghxA8w05}9VZU6uP

diff --git a/tests/data/acpi/q35/DSDT.bridge b/tests/data/acpi/q35/DSDT.bridge
index f08b7245f59aad491fcaa60e2bab1085c369ea1c..0f6c9c68c81cddd2126eea8a7c336b8667202223 100644
GIT binary patch
delta 249
zcmeCT>9yr@33dtTm1AIF4ByB#L4wK4Zt@(7)l9y|lRYK>vb%{n2Rr+5OnxsZuEXK%
z=Nc}=^uK^1xqvZck&Dpe6vhIElmf<t0*1szK0Fg9CooP;1_~t<Bu}0%DLT1GN`y&#
z>g0t|!o0~#7jRBa<oXZPxU>Ky;*z{TWpa!@OMI|Xe1Nm3K|qjeu(PLMFk?Y-2gsg8
zhSEf!$qUUFm|`dk@(p8j4snZ2p8Q`*O0hJ#fFWs-E6dcR#DZq9-Xw-(ur$!DXhWb|
W{H0Y{fku}mO*W7c+pI7BfC&KA`%aPo

delta 203
zcmeCR?YH4_33dtLmt$aH^xnudL4wK0Z1Nn5)lB}{lRYK>vU~732Rr+5OnxsZq0E@D
z$dP+;0%HL~LIFdJK1+PCQ+$B4r$IoFYp}Dkugd~=mdPKbL?xU<+#=DXT^vIgCpSoo
q`WG-JEc9ks;K4E(T}hB{7$Xj?T+9WGSd;_Jnrt8?wt21e1112)r8$rQ

diff --git a/tests/data/acpi/q35/DSDT.cphp b/tests/data/acpi/q35/DSDT.cphp
index 57d859cef9fa16a8f125c4b338611c8472699f38..d7bedee7ff638f11b3bb84ef960364b409a49cce 100644
GIT binary patch
delta 306
zcmX?Wf5w5!CD<jzM}dKXQF<fS1PLau=*e>=Rx|kqZ1$A2WUO}=a}IX)<A_#{(PxPd
zc8U*h_B03xat(G4@bUitpTpVDHC%}4e*r^s0b|M{SE0!%j0FrS1&j#=42g?;c_vIw
zV4RxF#a6(OP>_snLa?h(0Ry_Av#-kn@u_gp5U6b~jv>iQ7jRBa<oXY^XlVgl0h0Uz
zmC5MBo_@iM1<4&CS0*x)CIa2H(0qaEWPWK$#^lM?(o%}0$ps8ai(FZzCM6a$gViN5
fBs+(=MJ5CFMH?0*PwtjhWd#~jnzT7ox`G7&GO=B7

delta 199
zcmX@(aMqs7CD<k8tULn)qv}Sk2@*`+!IS4mtY-4_*z753$;j@(=N#<p$1(Y%v;;R}
z!XiiR$q9@F3<;ATNQu?EvrLZBXNeDXiVtx1GzbWC4R-eQ3ubf<af?J3cX141EMP<z
k1*$G!Ojzj6vcLn=s36}kTt;y*gUp&-DlM}4igX1F09eU5u>b%7

diff --git a/tests/data/acpi/q35/DSDT.dimmpxm b/tests/data/acpi/q35/DSDT.dimmpxm
index 9d5bd5744e2ba2e0f6126c3aba0bb36af865e499..13e80ae2e5c7606a7260d4cb3ab776488d0697d6 100644
GIT binary patch
delta 325
zcmezD@yV0RCD<k8lL`X^<MWMN6C{|N118UrSk2_-y4h1wfsx5wY;v}gOg)FQpKG`f
z)Bgg7<O0T&MXo}VQy2>vQVJLo3K$X>`SMJdoWM9WnTw@>A)z2SMxP}<*eO21+0!5(
z$TiqG*wv?i0bS79*JXkDRCG}n$B^Wu3pghya{UL|v$OyzUk^76q+o%{WORL=e!+|d
z$sHh9CNh*J0^POHe1R#3vLN3uM&}T>$Yd_&0!DN*fRaFcrO5>hNsC-rrY0p8G=mLH
eVo2rzYXaI3ZCH>zSzAh#6=-2;(q<cJb4~zS_+p&^

delta 194
zcmez5`PqZZCD<jTScQRs@!dwQ2@*^$9+T%ttY&hz-Rvo;z{upmH#u8MhOdAzVUZ*E
z<OIe7hJ*r!$%Zn*ehb`LCdcTr#0NXY2RM5g1O&MTJA3*CGdhR3MWTzlIEFA5FrteB
mRRhgk=*_aggJrUfw4^S&0-!c7W=wrSzF|Opn|Di_a{>Sy^)^ue

diff --git a/tests/data/acpi/q35/DSDT.ipmibt b/tests/data/acpi/q35/DSDT.ipmibt
index 5cd11de6a8fe47324e5f922823a22746882f19f5..9a1b635dab776fb25e378a00e6ca0cadf9902c25 100644
GIT binary patch
delta 286
zcmX?UbKI88CD<k8xEuom<LixFw<Vao>?S{#Sk2^XJb8-bUv@V!=U`_)j>#7##p^ko
z{anL^nEn?qBo{EIEOHT=oWfYZkW#>yP{5G5$cJab<OIg4$v~lmg5(%|miS<&_yA{5
zgMc8{VCP_0p8^JSL1$l=1>#fDMO_?2l9w*voSew@A85_e0+_rh%q)<C1uBza;xJ)P
zzhK6K<PMM{6B$YqfzDcJzQA;{oU|lk@?<Y*DaF#{0*0hTt}IiN5(}Ea>XI0eokQFr
afo@KYHY`Y<JWE=Y6=+Op(&iNDr%V8%Ct5cE

delta 182
zcmX?Zd(wu>CD<jzQ;vaw@%~1x+Y(GZW|N;wtY-4po;*eJFS`eybFi}?$K;EW65Nal
ziyXNpComQ;BusuMCFbYOGC4+{B|g|GKET=2ARx#!*xA!Bn9(`JEfQVa#W94jfDv63
lsJehLVWBt60uPqSlN+UlC2(n;Tq`X#xj{yB^LObBOaQB)Hktqc

diff --git a/tests/data/acpi/q35/DSDT.memhp b/tests/data/acpi/q35/DSDT.memhp
index 05a7a73ec43130d5c3018bb462fd84981bfb151c..55ce4e2293624c2c0725c3bbaaa7ec29acfccfc9 100644
GIT binary patch
delta 249
zcmX@>cG{iGCD<k8v@!z&<I0U(6C{`%>?hBWSk2^YGTBq|FT0zVbFi}?$K>~t;yN78
zey-s{O#cfQk_#A97P$ybPGKxyNGV`UC}2oj<ij&zasuPjWS~$&LGtAJlA@D~q(qp+
zr%qldCCr<=bOGn&M6UlpjY|taA}+}bR3^vhv&08G#RoWh8UzHn20MHD1v3^TcYy3k
zWGGDpn!M0_fhmTvAm1=X=McBZ<jMb~q!de&3mB3Xxw1@6N-Ssw>rG-v21^6YiZ%qg
W#a~*L6=-y6(qscEvCaC@avT8KEKcbF

delta 203
zcmX@@e%6i4CD<jzSDAr<aqdR02@*_B=9A}0tY&i6nd~X~m)(QUIoR2cWAb}R31!BF
zMULE)6Br8^5(*e%^jYGAo#F$WJq-eaT!WpReO(r~vrPUdB`V<@;ueW6?cx~1IJrSu
q)W3i+VWBt60uPqS=t_co!x(XB<zg;i#G)K%)?@=IvCV6x<v0MCY&quu

diff --git a/tests/data/acpi/q35/DSDT.mmio64 b/tests/data/acpi/q35/DSDT.mmio64
index efd3f1188f2b55da1514212d4be081a61c2a96e9..99b7b2ae4ba36b8ca7901626c1561d29100087d2 100644
GIT binary patch
delta 249
zcmaFi^30XXCD<k8nGyp7W9mk(2@*^W_LJvGtY&gHnd~X~m)%XwIoR2cWAb}RaUBk4
zKi6;}rvC*D$pwrli(G^zr!W>Uq!chF6fh(%^5K~<Ie~F%GEgX?AbIk9NzutgQX)*^
zQztK!66Q@_x`1<XBG-SQ#-#-y5trlzDwAXMS>l78;scyL4FZB(gPlG7f*A{vJ3#g%
zGL$9)O<riez!XDSkZ%~HbBJ4H^5p+gQi`R?1q?}xTv?_jB^ES;^(HYSgQbCHMH>R$
W;xDbr3N*SjX|jQo*k*lcOLhR{%1;Xb

delta 203
zcmaFn`oe|FCD<h-Ly3WbF>)i<1PLZ5^T~50Rx`QkO!k!g%kIJF9PI4JG5Niugfe5o
zB1i7Y35*2{2?Y!>`YiFmPVoWGo(2IyuEEaEzAg*gStfs!5|wZcaf?Kkc5w`0oZKKS
q>R-T^u+W=jfd|WEbR|K)VT?GmaxoV$Vo?q>YqEiq*ygp;mh1qbnmP#p

diff --git a/tests/data/acpi/q35/DSDT.numamem b/tests/data/acpi/q35/DSDT.numamem
index 1978b55f1255402bf9bade0b91150b5cb49789a4..2b2433cc13ec3110abbc8440a0b1ad8c487edb6c 100644
GIT binary patch
delta 249
zcmZp%X|m;V33dr-l4D?COx(ydL4wJ_e)1fN)lAMNlRYK>vb%{n2Rr+5OnxsZuEXK%
z=Nc}=^uK^1xqvZck&Dpe6vhIElmf<t0*1szK0Fg9CooP;1_~t<Bu}0%DLT1GN`y&#
z>g0t|!o0~#7jRBa<oXZPxU>Ky;*z{TWpa!@OMI|Xe1Nm3K|qjeu(PLMFk?Y-2gsg8
zhSEf!$qUUFm|`dk@(p8j4snZ2p8Q`*O0hJ#fFWs-E6dcR#DZq9-Xw-(ur$!DXhWb|
W{H0Y{fku}mO*W7c+pI5rl?ec^mQG#(

delta 203
zcmZp&ZL#5U33dr#kz-(B4Bf~zL4wK2eDWNL)l9BBlRYK>vU~732Rr+5OnxsZq0E@D
z$dP+;0%HL~LIFdJK1+PCQ+$B4r$IoFYp}Dkugd~=mdPKbL?xU<+#=DXT^vIgCpSoo
q`WG-JEc9ks;K4E(T}hB{7$Xj?T+9WGSd;_Jnrt8?wt21eRVDzYo;h3q

diff --git a/tests/data/acpi/q35/DSDT.tis b/tests/data/acpi/q35/DSDT.tis
index 638de3872673d17b1958497d0e62c83653de1602..dd06ee4c348930b0684827ca05747b4f65dbd6b2 100644
GIT binary patch
delta 249
zcmccZaMO{?CD<k8rUC;4<AjY|6C{|t>?Y5VSk2^XJlRw7FT0zVbFi}?$K>~t;yN78
zey-s{O#cfQk_#A97P$ybPGKxyNGV`UC}2oj<ij&zasuPjWS~$&LGtAJlA@D~q(qp+
zr%qldCCr<=bOGn&M6UlpjY|taA}+}bR3^vhv&08G#RoWh8UzHn20MHD1v3^TcYy3k
zWGGDpn!M0_fhmTvAm1=X=McBZ<jMb~q!de&3mB3Xxw1@6N-Ssw>rG-v21^6YiZ%qg
W#a~*L6=-y6(qscEvCaC@I;;Tg4o?UG

delta 203
zcmccVc-w)?CD<h-T7iLqv1KFI1PLY|v&nNLRx|l)Pxh4j%kIJF9PI4JG5Niugfe5o
zB1i7Y35*2{2?Y!>`YiFmPVoWGo(2IyuEEaEzAg*gStfs!5|wZcaf?Kkc5w`0oZKKS
q>R-T^u+W=jfd|WEbR|K)VT?GmaxoV$Vo?q>YqEiq*ygp;I;;SvwmJp?

-- 
MST


