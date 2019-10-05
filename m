Return-Path: <SRS0=HB7V=X6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B28C8C4740A
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Oct 2019 22:22:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77E2C20862
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Oct 2019 22:22:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77E2C20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59188 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iGsRJ-0000zP-Ps
	for qemu-devel@archiver.kernel.org; Sat, 05 Oct 2019 18:22:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48051)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iGs5w-0005kX-Ss
 for qemu-devel@nongnu.org; Sat, 05 Oct 2019 18:00:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iGs5u-0004b1-7D
 for qemu-devel@nongnu.org; Sat, 05 Oct 2019 18:00:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48784)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iGs5t-0004ao-UK
 for qemu-devel@nongnu.org; Sat, 05 Oct 2019 18:00:06 -0400
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id F3D13C057EC6
 for <qemu-devel@nongnu.org>; Sat,  5 Oct 2019 22:00:04 +0000 (UTC)
Received: by mail-qt1-f200.google.com with SMTP id c8so10912077qtd.20
 for <qemu-devel@nongnu.org>; Sat, 05 Oct 2019 15:00:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=MHoXc5/8x6GPr2dG8VbzGlhILReWlNpHdrJkVQkdq28=;
 b=YDCSbVurNaIqh5G9qvFP34+AEoHSbXOKKGdiFLjGZytS5HvAoZ7Y1uIDFw+EmKdRBq
 jC7WI8N80hdK1i97d/IyjeGsK1VbnAe7JJH+cPU3JYl7QNcLbiQA6mVX22iOVGTFAipu
 GVUCLyakgFwSE18ARmmD65Kr/aZFmfKin17VR3/DWFujIoo0HqZDG81lO/QIxmm09RCj
 44M6YhDEkdGiYXnnsOiuBhDo1WsgaBQBUhsVa+rhOvKlFJeCfRhwQuf3nQhKWK66OPDV
 Mli2bC75QdFageoYG9wQnsjMihwQc49cm89PizcXDDNIjyxSGqFxFgwyvqEAWHc3sSLR
 psHA==
X-Gm-Message-State: APjAAAWxACfoErGcoFvHgxzKErqkXgltH0eSPw2B/4zpblYT4vEUkkUH
 eZr7lTMct8KCxpB0PLDiVQaEHNn6Dk7VAwezdPK9LmBjVbboFgL7kDxzrqG73FjeqTtZGOSXraO
 DnGUK8G+fHD1dvR8=
X-Received: by 2002:ac8:4619:: with SMTP id p25mr23007234qtn.250.1570312803509; 
 Sat, 05 Oct 2019 15:00:03 -0700 (PDT)
X-Google-Smtp-Source: APXvYqy5ivIWgHdcPYGitssTKjfJqL3WzLayQNKByWubyIW5SSNZqAprXkgaiJcAqp83h7zarN4A7Q==
X-Received: by 2002:ac8:4619:: with SMTP id p25mr23007200qtn.250.1570312802813; 
 Sat, 05 Oct 2019 15:00:02 -0700 (PDT)
Received: from redhat.com (bzq-79-176-10-77.red.bezeqint.net. [79.176.10.77])
 by smtp.gmail.com with ESMTPSA id
 m186sm5387007qkd.119.2019.10.05.15.00.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Oct 2019 15:00:02 -0700 (PDT)
Date: Sat, 5 Oct 2019 17:59:58 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 16/19] tests/acpi: add expected tables for arm/virt
Message-ID: <20191005215508.28754-17-mst@redhat.com>
References: <20191005215508.28754-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191005215508.28754-1-mst@redhat.com>
X-Mailer: git-send-email 2.22.0.678.g13338e74b8
X-Mutt-Fcc: =sent
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/bios-tables-test-allowed-diff.h |  16 ----------------
 tests/data/acpi/virt/APIC.memhp       | Bin 0 -> 168 bytes
 tests/data/acpi/virt/APIC.numamem     | Bin 0 -> 168 bytes
 tests/data/acpi/virt/DSDT             | Bin 18476 -> 18470 bytes
 tests/data/acpi/virt/DSDT.memhp       | Bin 0 -> 19807 bytes
 tests/data/acpi/virt/DSDT.numamem     | Bin 0 -> 18470 bytes
 tests/data/acpi/virt/FACP.memhp       | Bin 0 -> 268 bytes
 tests/data/acpi/virt/FACP.numamem     | Bin 0 -> 268 bytes
 tests/data/acpi/virt/GTDT.memhp       | Bin 0 -> 96 bytes
 tests/data/acpi/virt/GTDT.numamem     | Bin 0 -> 96 bytes
 tests/data/acpi/virt/MCFG.memhp       | Bin 0 -> 60 bytes
 tests/data/acpi/virt/MCFG.numamem     | Bin 0 -> 60 bytes
 tests/data/acpi/virt/SLIT.memhp       | Bin 0 -> 48 bytes
 tests/data/acpi/virt/SPCR.memhp       | Bin 0 -> 80 bytes
 tests/data/acpi/virt/SPCR.numamem     | Bin 0 -> 80 bytes
 tests/data/acpi/virt/SRAT.memhp       | Bin 0 -> 186 bytes
 tests/data/acpi/virt/SRAT.numamem     | Bin 0 -> 106 bytes
 17 files changed, 16 deletions(-)

diff --git a/tests/bios-tables-test-allowed-diff.h b/tests/bios-tables-test-allowed-diff.h
index 3776dd2f3d..dfb8523c8b 100644
--- a/tests/bios-tables-test-allowed-diff.h
+++ b/tests/bios-tables-test-allowed-diff.h
@@ -1,17 +1 @@
 /* List of comma-separated changed AML files to ignore */
-"tests/data/acpi/virt/DSDT",
-"tests/data/acpi/virt/APIC.memhp",
-"tests/data/acpi/virt/APIC.numamem",
-"tests/data/acpi/virt/DSDT.memhp",
-"tests/data/acpi/virt/DSDT.numamem",
-"tests/data/acpi/virt/FACP.memhp",
-"tests/data/acpi/virt/FACP.numamem",
-"tests/data/acpi/virt/GTDT.memhp",
-"tests/data/acpi/virt/GTDT.numamem",
-"tests/data/acpi/virt/MCFG.memhp",
-"tests/data/acpi/virt/MCFG.numamem",
-"tests/data/acpi/virt/SLIT.memhp",
-"tests/data/acpi/virt/SPCR.memhp",
-"tests/data/acpi/virt/SPCR.numamem",
-"tests/data/acpi/virt/SRAT.memhp",
-"tests/data/acpi/virt/SRAT.numamem",
diff --git a/tests/data/acpi/virt/APIC.memhp b/tests/data/acpi/virt/APIC.memhp
index e69de29bb2d1d6434b8b29ae775ad8c2e48c5391..797dfde2841c51b7e72065602e99ce1714347f0d 100644
GIT binary patch
literal 168
zcmZ<^@N{0mz`($~*~#D8BUr&HBEZ=ZD8>jB1F=Cg4Dd+6SPUF6788)c?E~X6Fu>G{
hBZPn~MyPrgD9sGlkD?67;f3451Xcqw&w(L;0RYV=2>}2A

literal 0
HcmV?d00001

diff --git a/tests/data/acpi/virt/APIC.numamem b/tests/data/acpi/virt/APIC.numamem
index e69de29bb2d1d6434b8b29ae775ad8c2e48c5391..797dfde2841c51b7e72065602e99ce1714347f0d 100644
GIT binary patch
literal 168
zcmZ<^@N{0mz`($~*~#D8BUr&HBEZ=ZD8>jB1F=Cg4Dd+6SPUF6788)c?E~X6Fu>G{
hBZPn~MyPrgD9sGlkD?67;f3451Xcqw&w(L;0RYV=2>}2A

literal 0
HcmV?d00001

diff --git a/tests/data/acpi/virt/DSDT b/tests/data/acpi/virt/DSDT
index 20e85c7f89f645c69935c615c07084e221419960..bce76e3d23e99e6c5ef64c94c770282dd30ecdd0 100644
GIT binary patch
delta 158
zcmZ28fpOUcMlP3Nmk>1%1_q`n6S<@r8#k)uy4O3g$LPfeJH@-Zy2NwDdw9C=Iywh<
z8W<QFGjPO*0=Ym5Aj>%@Sdfp4yOWK9nNgF0fuWKiy1_Nb)t!Ndfq{dQizT{|8^m>X
w4R-ZW5Rr{{4GZBc0C5r)2u!X{;9_FnVrmNr4|3vah;EVxF(8&rmhcb(0N5-gnE(I)

delta 126
zcmZ2BfpN_QMlP3Nmk=Ef1_q{ziCof*?Hko{-K9L(-2?m$IO07#U3eXXd_4>d%nTVg
z;vHRrCdP|7GIKHrFfeqoF)%W!GcYhzf@EAh1(mrJdZZZ`p%5q`&cGnaAO~bHGk}Z(
RDiq<3cQr6(nEcOO0|1l~7c~F?

diff --git a/tests/data/acpi/virt/DSDT.memhp b/tests/data/acpi/virt/DSDT.memhp
index e69de29bb2d1d6434b8b29ae775ad8c2e48c5391..b4b153fcdc30d211237fced6be1e99d3500bd276 100644
GIT binary patch
literal 19807
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
F{{gI8IvxN3

literal 0
HcmV?d00001

diff --git a/tests/data/acpi/virt/DSDT.numamem b/tests/data/acpi/virt/DSDT.numamem
index e69de29bb2d1d6434b8b29ae775ad8c2e48c5391..bce76e3d23e99e6c5ef64c94c770282dd30ecdd0 100644
GIT binary patch
literal 18470
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
By8r+H

literal 0
HcmV?d00001

diff --git a/tests/data/acpi/virt/FACP.memhp b/tests/data/acpi/virt/FACP.memhp
index e69de29bb2d1d6434b8b29ae775ad8c2e48c5391..27de99f51bfe846b1f8796ace49d83f5b33a1aed 100644
GIT binary patch
literal 268
ycmZ>BbPnKQWME+3?d0$55v<@85#a0w6axw|fY>0Kx<CNcIA#XwTY+i=(L4a*H3tCz

literal 0
HcmV?d00001

diff --git a/tests/data/acpi/virt/FACP.numamem b/tests/data/acpi/virt/FACP.numamem
index e69de29bb2d1d6434b8b29ae775ad8c2e48c5391..27de99f51bfe846b1f8796ace49d83f5b33a1aed 100644
GIT binary patch
literal 268
ycmZ>BbPnKQWME+3?d0$55v<@85#a0w6axw|fY>0Kx<CNcIA#XwTY+i=(L4a*H3tCz

literal 0
HcmV?d00001

diff --git a/tests/data/acpi/virt/GTDT.memhp b/tests/data/acpi/virt/GTDT.memhp
index e69de29bb2d1d6434b8b29ae775ad8c2e48c5391..10107a65e958ff6495bb8c17d63d0539690f59f6 100644
GIT binary patch
literal 96
zcmZ<{aS2IaU|?Xn>E!S15v<@85#a0&6k`O6f!H7#8OTC8azL5|h^3)?DJYFj0RVOU
B2mt^9

literal 0
HcmV?d00001

diff --git a/tests/data/acpi/virt/GTDT.numamem b/tests/data/acpi/virt/GTDT.numamem
index e69de29bb2d1d6434b8b29ae775ad8c2e48c5391..10107a65e958ff6495bb8c17d63d0539690f59f6 100644
GIT binary patch
literal 96
zcmZ<{aS2IaU|?Xn>E!S15v<@85#a0&6k`O6f!H7#8OTC8azL5|h^3)?DJYFj0RVOU
B2mt^9

literal 0
HcmV?d00001

diff --git a/tests/data/acpi/virt/MCFG.memhp b/tests/data/acpi/virt/MCFG.memhp
index e69de29bb2d1d6434b8b29ae775ad8c2e48c5391..e8987e1af0ec3829770bf4fe11fab02b06160dd2 100644
GIT binary patch
literal 60
scmeZuc5}C3U|?YMck*}k2v%^42ypfViZKGkKx`0=1Oyx)oc|yS05YNo0RR91

literal 0
HcmV?d00001

diff --git a/tests/data/acpi/virt/MCFG.numamem b/tests/data/acpi/virt/MCFG.numamem
index e69de29bb2d1d6434b8b29ae775ad8c2e48c5391..e8987e1af0ec3829770bf4fe11fab02b06160dd2 100644
GIT binary patch
literal 60
scmeZuc5}C3U|?YMck*}k2v%^42ypfViZKGkKx`0=1Oyx)oc|yS05YNo0RR91

literal 0
HcmV?d00001

diff --git a/tests/data/acpi/virt/SLIT.memhp b/tests/data/acpi/virt/SLIT.memhp
index e69de29bb2d1d6434b8b29ae775ad8c2e48c5391..74ec3b4b461ffecca36d8537975c202a5f011185 100644
GIT binary patch
literal 48
scmWIc@eDCwU|?X>aq@Te2v%^42yhMtiZKGkKx`1r1jHb~B`V4V0NaKK0RR91

literal 0
HcmV?d00001

diff --git a/tests/data/acpi/virt/SPCR.memhp b/tests/data/acpi/virt/SPCR.memhp
index e69de29bb2d1d6434b8b29ae775ad8c2e48c5391..377271a0e7817cc21a28c02123a89facad63604f 100644
GIT binary patch
literal 80
zcmWFza1IJ!U|?VpcJg=j2v%^42yhMtiZKGkKx`1r48#l^3?L>agsBLmm>C$E7#RKo
I0Z0r60QF4^0RR91

literal 0
HcmV?d00001

diff --git a/tests/data/acpi/virt/SPCR.numamem b/tests/data/acpi/virt/SPCR.numamem
index e69de29bb2d1d6434b8b29ae775ad8c2e48c5391..377271a0e7817cc21a28c02123a89facad63604f 100644
GIT binary patch
literal 80
zcmWFza1IJ!U|?VpcJg=j2v%^42yhMtiZKGkKx`1r48#l^3?L>agsBLmm>C$E7#RKo
I0Z0r60QF4^0RR91

literal 0
HcmV?d00001

diff --git a/tests/data/acpi/virt/SRAT.memhp b/tests/data/acpi/virt/SRAT.memhp
index e69de29bb2d1d6434b8b29ae775ad8c2e48c5391..1b57db2072e7f7e2085c4a427aa31c7383851b71 100644
GIT binary patch
literal 186
zcmWFzatztUz`(%l?Bwt45v<@85#SsQ6k`O6f!H7#gkgYL2*!emGHSp?7#yH14wwi`
Z4T#UE0q1!TsjdO4?gNx&V1_Y(Gyr))3IPBB

literal 0
HcmV?d00001

diff --git a/tests/data/acpi/virt/SRAT.numamem b/tests/data/acpi/virt/SRAT.numamem
index e69de29bb2d1d6434b8b29ae775ad8c2e48c5391..9526e5a28eb2a315d3bc9d9b11852319d5a8898e 100644
GIT binary patch
literal 106
zcmWFzatz60U|?Wg?d0$55v<@85#SsQ6k`O6f!H7#gkgYL2*!emGHSp?7#yH14wwi`
H4Tui_yqE|9

literal 0
HcmV?d00001

-- 
MST


