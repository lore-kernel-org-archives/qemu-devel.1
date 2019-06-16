Return-Path: <SRS0=kfsH=UP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5DE7C31E50
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Jun 2019 21:48:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7479F20679
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Jun 2019 21:48:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7479F20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43100 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcd11-0000Xq-5Y
	for qemu-devel@archiver.kernel.org; Sun, 16 Jun 2019 17:48:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41068)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mst@redhat.com>) id 1hccpN-0006tc-RE
 for qemu-devel@nongnu.org; Sun, 16 Jun 2019 17:36:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1hccpM-000793-0p
 for qemu-devel@nongnu.org; Sun, 16 Jun 2019 17:36:41 -0400
Received: from mail-qt1-f170.google.com ([209.85.160.170]:38321)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1hccpE-0006ki-Kk
 for qemu-devel@nongnu.org; Sun, 16 Jun 2019 17:36:35 -0400
Received: by mail-qt1-f170.google.com with SMTP id n11so8573842qtl.5
 for <qemu-devel@nongnu.org>; Sun, 16 Jun 2019 14:36:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=eiyt+vtfptfMpWebrp4HCZ2wlK7fqLsGNbSz8bg/yHY=;
 b=uC7Zubs56o400lYBISuHUA4ALt2vCoT3jHazMXtxK2BIUbCaClNcnZAfIuFjDpNDE4
 XarcHSFuzZAuvGsYrqRoDIRY9kDD/TFghn8O24vc7r2K7f41uOv0c6IT+uhNg8ptrsLI
 pPZGWTXeC0DI73MbsvquK7xiditdKt5PE3fFh+TDtme/ZhBv3YdifupG4kZdluRHwuVU
 1rWRvWwSsP7l8hjRt8KWWuUyCMsRT5s7sE8XWGFgG39oqqjhLUAThF7hfn5ugTbHgk/Q
 Rq7jJRPkFRjzOXULZITSFhj8X35GQm3fTodME7+wQS2SpiirwgP6331LdZJjgCtkNb10
 lR4A==
X-Gm-Message-State: APjAAAXePdnlBMom4w9bRTeDwp1LQY2K9PSutWmwMHx9opmRHLo0vJtZ
 UvEHzuATw4D70pHm7w/EnNsxqiQF0fk=
X-Google-Smtp-Source: APXvYqzfybwGOHocU/DmObpKtkDeAteHYcvMKVQUzWk/9Vh5dLMk+ASPEDBEXTcVaCfwNdADAIzp/A==
X-Received: by 2002:ac8:2ed6:: with SMTP id i22mr85913633qta.321.1560720983764; 
 Sun, 16 Jun 2019 14:36:23 -0700 (PDT)
Received: from redhat.com (pool-100-0-197-103.bstnma.fios.verizon.net.
 [100.0.197.103])
 by smtp.gmail.com with ESMTPSA id x35sm313574qta.11.2019.06.16.14.36.22
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Sun, 16 Jun 2019 14:36:23 -0700 (PDT)
Date: Sun, 16 Jun 2019 17:36:22 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Message-ID: <20190616213540.20430-11-mst@redhat.com>
References: <20190616213540.20430-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190616213540.20430-1-mst@redhat.com>
X-Mailer: git-send-email 2.17.1.1206.gb667731e2e.dirty
X-Mutt-Fcc: =sent
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.160.170
Subject: [Qemu-devel] [PULL 10/11] q35: update DSDT
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
 Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

update expected files and drop them from allowed diff list.

Fixes: 4a4418369d6 ("q35: fix mmconfig and PCI0._CRS")
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/bios-tables-test-allowed-diff.h |   8 --------
 tests/data/acpi/q35/DSDT              | Bin 7815 -> 7841 bytes
 tests/data/acpi/q35/DSDT.bridge       | Bin 7832 -> 7858 bytes
 tests/data/acpi/q35/DSDT.cphp         | Bin 8278 -> 8304 bytes
 tests/data/acpi/q35/DSDT.dimmpxm      | Bin 9468 -> 9494 bytes
 tests/data/acpi/q35/DSDT.ipmibt       | Bin 7890 -> 7916 bytes
 tests/data/acpi/q35/DSDT.memhp        | Bin 9174 -> 9200 bytes
 tests/data/acpi/q35/DSDT.mmio64       | Bin 8945 -> 8971 bytes
 tests/data/acpi/q35/DSDT.numamem      | Bin 7821 -> 7847 bytes
 9 files changed, 8 deletions(-)

diff --git a/tests/bios-tables-test-allowed-diff.h b/tests/bios-tables-test-allowed-diff.h
index 3bbd22c62a..dfb8523c8b 100644
--- a/tests/bios-tables-test-allowed-diff.h
+++ b/tests/bios-tables-test-allowed-diff.h
@@ -1,9 +1 @@
 /* List of comma-separated changed AML files to ignore */
-"tests/data/acpi/q35/DSDT",
-"tests/data/acpi/q35/DSDT.bridge",
-"tests/data/acpi/q35/DSDT.mmio64",
-"tests/data/acpi/q35/DSDT.ipmibt",
-"tests/data/acpi/q35/DSDT.cphp",
-"tests/data/acpi/q35/DSDT.memhp",
-"tests/data/acpi/q35/DSDT.numamem",
-"tests/data/acpi/q35/DSDT.dimmpxm",
diff --git a/tests/data/acpi/q35/DSDT b/tests/data/acpi/q35/DSDT
index 7576ffcd05991ad5a3901c0f7698a52fffc6d6e2..f9f36d1645c9b57aea38350d67dfaa143845697d 100644
GIT binary patch
delta 65
zcmZp-U1-bY66_MPP>z9t(QYHxMHw+i!5F>xV5j&1XHNr;c;}#CK`(BuZIeIB#Pf3e
R|NnnI0|czt>@4fT2mo%L69@nR

delta 51
zcmZ2z+iuI{66_MvF2}&Y*szi7qKue3e~eyyuv2`1v!?+^ymL^npaU1zoXH<$;x}i>
Hnll0bdb|$6

diff --git a/tests/data/acpi/q35/DSDT.bridge b/tests/data/acpi/q35/DSDT.bridge
index c623cc5d72a2e346793fa9128e7e88b6781241b2..29176832ca9842c6654273ae1246321aa38b2821 100644
GIT binary patch
delta 65
zcmbPXyUCWzCD<iolN<vB<Gqbs7iGj81!MH$gPr07oIMRV;+=zn1--brwoU#h6VJ=>
R|NsB>3=ptlv$Jd{BLJG%6YKy0

delta 51
zcmdmFJHwXCCD<ioh8zO}qryh6i!x&F{4sj*!A|i3&YlJw@y<cPf(~3<b0&Y3iQk+h
H>%j;Bc5Du$

diff --git a/tests/data/acpi/q35/DSDT.cphp b/tests/data/acpi/q35/DSDT.cphp
index 7ac526e4669fd84048b2d8ec6af8661503e1a9fa..19bdb5d21050f24aaacbafb1f84d6e1d541876c6 100644
GIT binary patch
delta 65
zcmccS@WFx0CD<jTK!JgQar;KD1#)7Jf-!pW!A|i3&YlJw@y<cPf?nKQ+a@27i|6I|
R|NsAb1_)TOSxDZ65dfFX6KMbd

delta 51
zcmez1aLs|sCD<h-Oo4%c@#jXa1#)8U{4sj*!A|i3&YlJw@y<cPf(~3<b0!~<i{ET1
HZ_Wq+oC^;j

diff --git a/tests/data/acpi/q35/DSDT.dimmpxm b/tests/data/acpi/q35/DSDT.dimmpxm
index 7177116a21969fa3649053ec83a8704b0d84b9c5..727fe489b4c8cdd39476ff61e7d7664c816f5291 100644
GIT binary patch
delta 65
zcmez4In9g9CD<iIOqGFwv0)>Zo3farV2oaTuv2`1v!?+^ymL^npcgmSw#jMA@w^=W
R|Nmdl00ApD?@)GO1OQ#b61)Ha

delta 51
zcmbQ{^~aOTCD<k8j|u|=<Kc~5Zpvcr{4sj*!A|i3&YlJw@y<cPf(~3<b0()L$8Wx`
HY|aP(oxu-u

diff --git a/tests/data/acpi/q35/DSDT.ipmibt b/tests/data/acpi/q35/DSDT.ipmibt
index c7f431f058bcb54e364be4edfd9d4609bc9bb602..9634930e6125de4375d87a56a353f636985599d4 100644
GIT binary patch
delta 65
zcmca)`^J{bCD<k8jT{35WAa8W8Cfw$!5F>xV5j&1XHNr;c;}#CK`(BuZIf+e<9Rv$
R|Np<90RmQR?vr(41OR*267c{4

delta 51
zcmaE3d&!o|CD<k8k{kmA<I;^>GO}Xs{4sj*!A|i3&YlJw@y<cPf(~3<b0*u!#&6y#
HYt9G&jZqG%

diff --git a/tests/data/acpi/q35/DSDT.memhp b/tests/data/acpi/q35/DSDT.memhp
index 0235461391c90d577c3d533c2fd29ce50f1e2981..dad5dc8db2f13bdb0de001da42c13b18286c3061 100644
GIT binary patch
delta 65
zcmccS{=uEgCD<k8gE9jHqrpZl1tl>@!5F>xV5j&1XHNr;c;}#CK`(BuZId08;(0m#
R|Np<90RmQRo}}c$2mpN;68-=H

delta 51
zcmez1e$AcBCD<k8nlb|eW6?$~1tl?e{usUZV5j&1XHNr;c;}#CK?g3bIg=ff;y3S9
HGG_z;j#>`3

diff --git a/tests/data/acpi/q35/DSDT.mmio64 b/tests/data/acpi/q35/DSDT.mmio64
index f60ee77fb4d655e77c7ef1e8c205d741cc288939..20f627ed08a0cae4e144f3e4dd7dd5f1d8d0318c 100644
GIT binary patch
delta 65
zcmez9+U>^W66_Mft<1o{_<AFkmZF%WV2oaTuv2`1v!?+^ymL^npcgmSw#i<K@w^=W
R|Nmdl00ApD&ru9z1OQ+{60-mR

delta 51
zcmeBn`{>H$66_N4QHg<pQEwxcmZF$De~eyyuv2`1v!?+^ymL^npaU1zoXK8_@tY4T
HdN2Y2dk79|

diff --git a/tests/data/acpi/q35/DSDT.numamem b/tests/data/acpi/q35/DSDT.numamem
index 6c0d4f2bcb384cc3f3919b7472021ed51b93cbf5..7b96a972804e95e191d9d3bf9a965e90f6f7e555 100644
GIT binary patch
delta 65
zcmeCRU2e<e66_MPT#kW(@x?~2>oQ`Ff-!pW!A|i3&YlJw@y<cPf?nKQ+a`aPiRb0`
R|NsAb1_)TO*;Ceq5dfBm6V?C#

delta 51
zcmZ2(+iT0^66_MvE62dVsI`&nx{R1Re~eyyuv2`1v!?+^ymL^npaU1zoXOv1;x`w_
Hnll0ba<&eR

-- 
MST


