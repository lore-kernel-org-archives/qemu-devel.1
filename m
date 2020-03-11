Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 582C3C4CC9E
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 17:29:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC65920739
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 17:29:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC65920739
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56348 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jC5At-00068m-D3
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 13:29:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58255)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1jC55S-0002wH-QB
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 13:24:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1jC55R-0004ZB-FW
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 13:24:06 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3199 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1jC55O-0004RS-Ge; Wed, 11 Mar 2020 13:24:02 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 00894C60DA5574D4BE24;
 Thu, 12 Mar 2020 01:24:00 +0800 (CST)
Received: from S00345302A-PC.china.huawei.com (10.202.227.237) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.487.0; Thu, 12 Mar 2020 01:23:48 +0800
From: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>, <eric.auger@redhat.com>,
 <imammedo@redhat.com>
Subject: [PATCH v3 10/10] tests/acpi: add expected tables for bios-tables-test
Date: Wed, 11 Mar 2020 17:20:14 +0000
Message-ID: <20200311172014.33052-11-shameerali.kolothum.thodi@huawei.com>
X-Mailer: git-send-email 2.12.0.windows.1
In-Reply-To: <20200311172014.33052-1-shameerali.kolothum.thodi@huawei.com>
References: <20200311172014.33052-1-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.202.227.237]
X-CFilter-Loop: Reflected
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
Cc: peter.maydell@linaro.org, xiaoguangrong.eric@gmail.com, david@redhat.com,
 mst@redhat.com, linuxarm@huawei.com, xuwei5@hisilicon.com,
 shannon.zhaosl@gmail.com, lersek@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Because of the following changes, the expeacted tables for bios-tables-test
needs to be updated.

1. Changed NVDIM DSM output buffer AML code.
2. Updated arm/virt test_acpi_virt_tcg_memhp() to add pc-dimm/nvdimm

Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
---
 tests/data/acpi/pc/SSDT.dimmpxm             | Bin 685 -> 734 bytes
 tests/data/acpi/q35/SSDT.dimmpxm            | Bin 685 -> 734 bytes
 tests/data/acpi/virt/DSDT.memhp             | Bin 6644 -> 6668 bytes
 tests/data/acpi/virt/NFIT.memhp             | Bin 0 -> 224 bytes
 tests/data/acpi/virt/SSDT.memhp             | Bin 0 -> 736 bytes
 tests/qtest/bios-tables-test-allowed-diff.h |   5 -----
 6 files changed, 5 deletions(-)

diff --git a/tests/data/acpi/pc/SSDT.dimmpxm b/tests/data/acpi/pc/SSDT.dimmpxm
index 8ba0e67cb72daa81a65da4906d37a5e0f4af1fd4..ac55387d57e48adb99eb738a102308688a262fb8 100644
GIT binary patch
delta 125
zcmZ3>dXJSWIM^lR9uortW7tG4X>Nb5nD}6)_~<4#t%(LAOunKU-FO)N7nn^=<l-n`
zNa6@_3Uw1?W@IQ3WMW8PBs(=Jv7oub-^DQ`iJ=1|$G}jW4x-abla{0xR3>sUGbBa}
TgA_0%`UAz6fQZcnjJAvbW$GgJ

delta 76
zcmcb|x|WqIIM^j*EfWI+W57f%X>LFDnD}6)_~<5A^@#=|Og=&z-FO(~3Mv!1m>CkI
dh5cO|Ll_eMokHD;1(_H?bo!F?%?lZA83Fei6ZHT9

diff --git a/tests/data/acpi/q35/SSDT.dimmpxm b/tests/data/acpi/q35/SSDT.dimmpxm
index 2d5b721bcf9c398feb6d005761f898015042e8a4..98e6f0e3f3bb02dd419e36bdd1db9b94c728c406 100644
GIT binary patch
delta 125
zcmZ3>dXJSWIM^lR9uortquWF-X>Nb5nD}6)_~<4#t%(LAOunKU-FO)N7nn^=<l-n`
zNa6@_3Uw1?W@IQ3WMW8PBs(=Jv7oub-^DQ`iJ=1|$G}jW4x-abla{0xR3>sUGbBa}
TgA_0%`UAz6fQZcnjJAvbUiu>C

delta 76
zcmcb|x|WqIIM^j*EfWI+qr*flX>LFDnD}6)_~<5A^@#=|Og=&z-FO(~3Mv!1m>CkI
dh5cO|Ll_eMokHD;1(_H?bo!F?%?lZA83FS;6XgH^

diff --git a/tests/data/acpi/virt/DSDT.memhp b/tests/data/acpi/virt/DSDT.memhp
index c527ac4739af3df3c3e042bf91c412033a2b73c3..730e95a46d2cce0af011ffc051d7342beb8f1328 100644
GIT binary patch
delta 66
zcmexj++)J!66_MfBgMeL^l>7WG*kP$jq2<oOpaWW4Mc*Od{`#8h!~455Sv_`z{SGA
W#nKj|7a!~t?-%A0w0WzDJu3iIl@a3r

delta 43
zcmeA%`C`oF66_N4MUsJmsc|BgG*kbajq2<oOr9K*4Mc(&O(wUB7;io=V#^8u9B2%1

diff --git a/tests/data/acpi/virt/NFIT.memhp b/tests/data/acpi/virt/NFIT.memhp
index e69de29bb2d1d6434b8b29ae775ad8c2e48c5391..738c6f74c0ce7dc329cc72cc7b930460ceb9b6a0 100644
GIT binary patch
literal 224
zcmeZs^9*^wz`($G(aGQ0BUr&HBEZ=XD8>jB1F=Cg1XwVzFffCeAhF8JAJRT=DREfi
z%xf&Mz2`Pir~{&ofdfQyG(dQa3<eBL5GGJRD~JV_hYBH45Sv&S0)VR88W<T6HiHy}
Pn+P#5Laay9LzoEwN>da8

literal 0
HcmV?d00001

diff --git a/tests/data/acpi/virt/SSDT.memhp b/tests/data/acpi/virt/SSDT.memhp
index e69de29bb2d1d6434b8b29ae775ad8c2e48c5391..db61d6733284c90153e0e2c1d6c2ac25c22b1d84 100644
GIT binary patch
literal 736
zcmZWnJ&4m_7=F{1Ynryuv=ve6ky!_O6-025G-+(0NlTIzAqUNmw7s^&hj$JlLfadz
zo*?wXEh3U083lL2&DF`tL2x*5cM%-K?@e*=T;7-Od*1JPpXcE-P1*XE0AOy_+fvgM
z^q#D08a)F*{Xs{<UJ!5W_RV_VUNo;$++h1nRnCi2N3B+OYEW)p(j~E#Ct5=j2lh<w
zsBOprWHMZeo(xfgK^6-3Jc~$Dw-i;d=M@B!O}W(&j7HBCl&&rbifG)Q{Yu;OVvHKC
zhAy;a(VG2EhgX9s5Wd6}qVI*9t2gKT^UuY*!Oz|I&iYQc9Zcy)W;5{P^^1q=PetkY
zi~8|h?Stp6FUJq7Z!;2~Kj&8~7KGfZffHVN77XAd7&#DTf-yvVl8FmLrl^eUp)@i^
zZDHkU@N&YXf};stvz!2U<k0hpkDAE<T^*oaF6D-|PhE~B;IUS{s~{)g6EHlxcIvt0
zaEXRISRw|nKg2$K>_tQJ#O0FU+9ezSw@vROEagI9HnmiQA&>UP6JQO~5}~Z64Mnvw
zY+ErcAR}x9XE39S5im?~i@}LFCFj@yO3@`)kSxrd1o2Hog_0x3J#f(n8@M!%1lT2q
z6Jm8#juK%h-|N%mEE@9&_-9pypc>!7*C8JuYZjQl__`2oA({8ccl~|O@$5xK?^Ua8
nUz82zqC>`BY*Tb6M!7_p|2F_GvB7H_Joz7<WbrFft6!x*uUOFm

literal 0
HcmV?d00001

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index 862c49e675..dfb8523c8b 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1,6 +1 @@
 /* List of comma-separated changed AML files to ignore */
-"tests/data/acpi/pc/SSDT.dimmpxm",
-"tests/data/acpi/q35/SSDT.dimmpxm",
-"tests/data/acpi/virt/DSDT.memhp",
-"tests/data/acpi/virt/SSDT.memhp",
-"tests/data/acpi/virt/NFIT.memhp",
-- 
2.17.1



