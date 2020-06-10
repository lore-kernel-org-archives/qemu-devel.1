Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63755C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 04:37:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BBB120734
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 04:37:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gLQhuJIn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BBB120734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36964 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jisU0-0003eA-Bh
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 00:37:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34006)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jisKR-0007Ij-Kf
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 00:27:07 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:59902
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jisKP-0008EK-Mx
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 00:27:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591763224;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=X1RKlsb6AEJshxT1rDVPojn/FQXyVSb9E/OqRamo79c=;
 b=gLQhuJInZuv1eeO5mtWNJ45BC/S3Ve4Ljwj8yHihPHgWNBVQWB9o/8LC3OxMmdZsHFRNrf
 qayHgeX/mGY+VFQHsXZuM4rxzkIFJjLZo5G8n2mLMIW1g1CHys19YV5IvBHMb9QS3XqnYl
 w2aDgKs+T4Sys4PvqbvzEFx+3qwmFRE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-380-Mv-54MT0OiumPFeQhzQy_g-1; Wed, 10 Jun 2020 00:27:03 -0400
X-MC-Unique: Mv-54MT0OiumPFeQhzQy_g-1
Received: by mail-wm1-f69.google.com with SMTP id v24so88375wmh.3
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2020 21:27:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=X1RKlsb6AEJshxT1rDVPojn/FQXyVSb9E/OqRamo79c=;
 b=eofoB6IQ9BFWB18AzOKjHWMptobtDvZeF6aSZyg1gXWsEeg9f8eTz6KFcEX4ORjiI7
 DuaT0pPeBV5a5AV+WBG1fMmNPpvEu6LhwHuDqlLt1PCshQzkOYlqmnCDeJP8NlZqyR9m
 5G7d4zwAWsyR2DsVHh7w0MxgtMUNR+g6d8ME/g4GI1NeKYkiggh8MGPx4xctpWccOakh
 vR2JvYvSm2TQt/oSCo+LEiqMIExX49Z+5HcBTrxMmWDkYOsT08Tce5I9ccmo9GHSg+6j
 R0KCcjdBlKnJ5ODniyxkLzD+A8Fb83ZX3ntJJRSGflUuuQOixSdQw/qoCqtB6LDGqwF3
 1fHg==
X-Gm-Message-State: AOAM5302SrMpxhzfN+ztTdwuBYf1vMOW0CW9zg2+bxErS6AjSOVcQKC/
 IWtrxwRTM+PrxaF34667XH57QzluPDSyGRmMjRWmm2RYFZ2Z5Djo3cIrpjuxaz4BkofKmMjaKju
 PiVFlqfuqRXFCnzk=
X-Received: by 2002:adf:f74e:: with SMTP id z14mr1356602wrp.338.1591763221750; 
 Tue, 09 Jun 2020 21:27:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJztNxbQjIZucQV5qVj7yisos0DglVyNKOqTGRZGSiayAwvel63KKgN07oqy0jm5wOGL9yubcA==
X-Received: by 2002:adf:f74e:: with SMTP id z14mr1356576wrp.338.1591763221291; 
 Tue, 09 Jun 2020 21:27:01 -0700 (PDT)
Received: from redhat.com (bzq-79-181-55-232.red.bezeqint.net. [79.181.55.232])
 by smtp.gmail.com with ESMTPSA id c6sm5152933wma.15.2020.06.09.21.27.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2020 21:27:00 -0700 (PDT)
Date: Wed, 10 Jun 2020 00:26:59 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 12/56] tests/acpi: update DSDT expected files
Message-ID: <20200610042613.1459309-13-mst@redhat.com>
References: <20200610042613.1459309-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200610042613.1459309-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 23:51:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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

Update DSDT after CRS changes and _STA methods dropped.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/qtest/bios-tables-test-allowed-diff.h |  17 -----------------
 tests/data/acpi/pc/DSDT                     | Bin 5125 -> 5014 bytes
 tests/data/acpi/pc/DSDT.acpihmat            | Bin 6449 -> 6338 bytes
 tests/data/acpi/pc/DSDT.bridge              | Bin 6984 -> 6873 bytes
 tests/data/acpi/pc/DSDT.cphp                | Bin 5588 -> 5477 bytes
 tests/data/acpi/pc/DSDT.dimmpxm             | Bin 6778 -> 6667 bytes
 tests/data/acpi/pc/DSDT.ipmikcs             | Bin 5197 -> 5086 bytes
 tests/data/acpi/pc/DSDT.memhp               | Bin 6484 -> 6373 bytes
 tests/data/acpi/pc/DSDT.numamem             | Bin 5131 -> 5020 bytes
 tests/data/acpi/q35/DSDT                    | Bin 7863 -> 7752 bytes
 tests/data/acpi/q35/DSDT.acpihmat           | Bin 9187 -> 9076 bytes
 tests/data/acpi/q35/DSDT.bridge             | Bin 7880 -> 7769 bytes
 tests/data/acpi/q35/DSDT.cphp               | Bin 8326 -> 8215 bytes
 tests/data/acpi/q35/DSDT.dimmpxm            | Bin 9516 -> 9405 bytes
 tests/data/acpi/q35/DSDT.ipmibt             | Bin 7938 -> 7827 bytes
 tests/data/acpi/q35/DSDT.memhp              | Bin 9222 -> 9111 bytes
 tests/data/acpi/q35/DSDT.mmio64             | Bin 8993 -> 8882 bytes
 tests/data/acpi/q35/DSDT.numamem            | Bin 7869 -> 7758 bytes
 18 files changed, 17 deletions(-)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index 6a052c5044..dfb8523c8b 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1,18 +1 @@
 /* List of comma-separated changed AML files to ignore */
-"tests/data/acpi/pc/DSDT",
-"tests/data/acpi/pc/DSDT.acpihmat",
-"tests/data/acpi/pc/DSDT.bridge",
-"tests/data/acpi/pc/DSDT.cphp",
-"tests/data/acpi/pc/DSDT.dimmpxm",
-"tests/data/acpi/pc/DSDT.ipmikcs",
-"tests/data/acpi/pc/DSDT.memhp",
-"tests/data/acpi/pc/DSDT.numamem",
-"tests/data/acpi/q35/DSDT",
-"tests/data/acpi/q35/DSDT.acpihmat",
-"tests/data/acpi/q35/DSDT.bridge",
-"tests/data/acpi/q35/DSDT.cphp",
-"tests/data/acpi/q35/DSDT.dimmpxm",
-"tests/data/acpi/q35/DSDT.ipmibt",
-"tests/data/acpi/q35/DSDT.memhp",
-"tests/data/acpi/q35/DSDT.mmio64",
-"tests/data/acpi/q35/DSDT.numamem",
diff --git a/tests/data/acpi/pc/DSDT b/tests/data/acpi/pc/DSDT
index ad4b2d46cc7865e8bafcca2e4e888a03cc5483b5..384a82dbb3cb0e9f47db6f4d08945631c2b72b56 100644
GIT binary patch
delta 164
zcmZqGn5NF<66_K(O_+g!v27z)FQb5;xIS}yuv2`1v!{V)uw(q>Ym5)2jC=w@3_0RG
zJY9GkFR(Ch#D{viFml8Phd55Y%On+U<m~SYmu3Y@z@@qPIpUpzf&~S*c-<L)F#lj?
n;7}4^sAPz4QVj}mj)xh^4Kxz2tbn0_fssRrfpK#abF%;dyx=Gg

delta 282
zcmbQH-m1an66_MfD#F0PsJ4--mr>YPPM<kG*eO21+0(!?*fBo3Nq6!`CJ_k<E>U;J
z0)_$x0VX8|Mt8;{h9U+gwn~P{%NZZm+xY~9#B;=Zc)IX7USMGmk%$itabzg)32^mG
zSim+pfnf>5LY5_5{2cMlLBWCoT)gg#70eaP92`mw43!MgO|C4?{=SAV16Ub3;zK=M
z7-7aZJK{Fx2lEeR1|JS30kAo4Aajh+%;5sM9^xKnCp-o*{a|9?P~u?NEX>?2004S}
BL(TvI

diff --git a/tests/data/acpi/pc/DSDT.acpihmat b/tests/data/acpi/pc/DSDT.acpihmat
index eff7aadfabe431c3ac2d28e0c6721eb6e322af66..47ddfdb027b06dc2daa46be711c3f4640ce68320 100644
GIT binary patch
delta 164
zcmdmJbjXm)CD<k8kOTt*W5`CXUPb{waee0aV5j&1XHNsqV8{5$*BBp48TkZ+7;?mW
zc)IX7USMJ1h!6F2VdRJp4so1(mq{wz$l2c)F3k#*fJ<}nbHqCb1q%vr@wzkqVE)0(
nz@a3-P{|P8q#6|B91k;+8)zh4Sph=<10#nL1LNi<=Jlcg0#+!i

delta 282
zcmX?PxY3BqCD<jzP?CXx@ykZ8UPfVGIeq5%V5j&1XHNsqV8{6ACf&&&nM5QcxJ2C<
z3m6I*1elZ<7~L6*7>XE}*eV$&FK2vMZ|4&b63-Fu;pxKTc!7mML?S*o#F3%EC&1M&
zVFBCZ1coIH3t5(M@pHsG2L%fXaPhh`RxnpEb8sj%FjO)`H@UJn`}-Qg3}9vCh!6F2
zVT2ju?1<Z#AIv|P8GJaD1i<FFfy^;NGlvW4dWd_Ro$wgM^n;0kLy3c7voP~|Q2_l*
BMQQ*5

diff --git a/tests/data/acpi/pc/DSDT.bridge b/tests/data/acpi/pc/DSDT.bridge
index 92ae808e2e071e367f0b68b3553239bd56b4b766..d1e2fa9fb8c75160fc1fa46deed6a6a9cb515559 100644
GIT binary patch
delta 164
zcmX?McGHy0CD<k8rW6AM<N1wTy^I2W;`+?-!A|i3&YlLI!H)5huQ5K9GV%!sG31E%
z@O0sEyuiZ15g+R5!pIRH9O5|nE|XNak+Z)qT$&Xq0hi|D=ZJR>3KkUL;&o^I!Tf`n
nfkR1vp^_oGNi`_MIUZ&tH_%A9vI2$z21X7g2FA@z%*Vt5d=n{-

delta 282
zcmca<dcus$CD<jzLz;nsF@GahFQc%poIZ1Wuv2`1v!{V)uw#65lkVh?Od=8zT%zub
z1q=lY0!&H_jP8s@3`Gn~Y?Ta?moq-BxAO@IiRXy-@O0sEyuiXBA`u@P;>b|o6X5EX
zuz+oH0>cu9g)B?B_&MU8gMtMGxOm+eE0`;oIXILW7%CZ}n_O9({e2B#2Cy=6#D{vi
zFv5&+cEoMW59S}t3_cu60$_98K;{^snZpHiJ;XiEPIwGr`oYA&p~S(kS(y2lH~`2b
BMNI$z

diff --git a/tests/data/acpi/pc/DSDT.cphp b/tests/data/acpi/pc/DSDT.cphp
index f3572358510f3fbb3d966047274f7aa7835e7bef..54f481faf1e336c0bbf5e774cd67220fe06e951b 100644
GIT binary patch
delta 164
zcmcbj{Zxy~CD<h-Rg{5&@&87yUPb{waee0aV5j&1XHNsqV8{5$*BBp48TkZ+7;?mW
zc)IX7USMJ1h!6F2VdRJp4so1(mq{wz$l2c)F3k#*fJ<}nbHqCb1q%vr@wzkqVE)0(
nz@a3-P{|P8q#6|B91k;+8)zh4Sph=<10#nL1LNi<<{%*ePh=?0

delta 282
zcmaE=bw!)YCD<k8iYNmE<ARM`y^O-Xa{A2i!A|i3&YlLI!H)6KO}djmGKok?aEZDz
z7BCbr2rwxzFuF4qF%&T{u~jlmUe5Ti-p(f=B%UMQ!_$Sw@d68jh(vsFh$BORPk^gm
z!UDF*2@FdZ7P2hi;^&BW4hj|&;No>>tYEHS=HO6jV5nq>ZgORD_V+b}8NkZO5g+R5
z!U!|Q*%7xfKbU_oGx%^Q34qOU1DRulW)2t7^$_<sJK-^i=?4=7hY|<FW?|+aApncU
BMU4Oe

diff --git a/tests/data/acpi/pc/DSDT.dimmpxm b/tests/data/acpi/pc/DSDT.dimmpxm
index 7fa09463c16c2f6b60114591785918b9d96b4f17..5d98016ae571cde04ff96d58212e0faf9aaf50e6 100644
GIT binary patch
delta 164
zcmexm(rv=!66_MfEycjV_-rFrFQb5;xIS}yuv2`1v!{V)uw(q>Ym5)2jC=w@3_0RG
zJY9GkFR(Ch#D{viFml8Phd55Y%On+U<m~SYmu3Y@z@@qPIpUpzf&~S*c-<L)F#lj?
n;7}4^sAPz4QVj}mj)xh^4Kxz2tbn0_fssRrfpK#a^A9lq`Rpj^

delta 282
zcmeA+`DMc866_LECB?wN*uIggmr>YPPM<kG*eO21+0(!?*fBo3Nq6!`CJ_k<E>U;J
z0)_$x0VX8|Mt8;{h9U+gwn~P{%NZZm+xY~9#B;=Zc)IX7USMGmk%$itabzg)32^mG
zSim+pfnf>5LY5_5{2cMlLBWCoT)gg#70eaP92`mw43!MgO|C4?{=SAV16Ub3;zK=M
z7-7aZJK{Fx2lEeR1|JS30kAo4Aajh+%;5sM9^xKnCp-o*{a|9?P~u?NEX@2v3;^?H
BMW_G(

diff --git a/tests/data/acpi/pc/DSDT.ipmikcs b/tests/data/acpi/pc/DSDT.ipmikcs
index 469d13e1f6b873bb9cfa0b3af32d1a3bc58e8f77..57b78358744a5bb13639ccddb887be2721240807 100644
GIT binary patch
delta 172
zcmX@BaZjDgCD<k8o-hLgqtr&OUPb{o8GYvXV5j&1XHNsqV8{5$*BBp8Zew<niEc9T
z2?#Odi1+Yx;c>jc!oU$9>gmGB5g#1lIQcG<RHTu!zb{;x6(|9h=HlmwcMb{`6yV}@
vXZ*qZgPDOtNr0h}A-YL5D8xA)W+XSzNVu{Bh5`mg4kZT0N`}p6m>UHE!Nn_l

delta 259
zcmcboepZ9aCD<jzSA>Cqao0w!UPgOYWqs!OV5j&1XHNsqV8{6ACf%SA=Xj2I4^I~!
z#|zvH9P!RU!GaQ8qV9|Z3<V4VOiB!l?u<nYMGQ=Al?;=YGd@(a^9cxn>tJCJk%$it
zabzg)32^mGSim+pfnf>5LY5_yUolDPy0SR?`x?SbXJzDw5A}3mgz0d0MAae3EamD3
t(qV+AgNq5S#R)|V7eB<k0$jZAj6axuFfni_aWGU)Ze{Y^9LwA&008daLcst4

diff --git a/tests/data/acpi/pc/DSDT.memhp b/tests/data/acpi/pc/DSDT.memhp
index aee75bea272cc9983202cceb747aecc297b5104e..8cb90ef14e13be85995c6fe3d3f6d12f4d939504 100644
GIT binary patch
delta 164
zcmca&^wf~cCD<k8sRRQ9W5q_UUPb{waee0aV5j&1XHNsqV8{5$*BBp48TkZ+7;?mW
zc)IX7USMJ1h!6F2VdRJp4so1(mq{wz$l2c)F3k#*fJ<}nbHqCb1q%vr@wzkqVE)0(
nz@a3-P{|P8q#6|B91k;+8)zh4Sph=<10#nL1LNi<=1ZagS$8R0

delta 282
zcmaEAc*TgzCD<h-M3RAlQDP%kFQc%poIZ1Wuv2`1v!{V)uw#65lkVh?Od=8zT%zub
z1q=lY0!&H_jP8s@3`Gn~Y?Ta?moq-BxAO@IiRXy-@O0sEyuiXBA`u@P;>b|o6X5EX
zuz+oH0>cu9g)B?B_&MU8gMtMGxOm+eE0`;oIXILW7%CZ}n_O9({e2B#2Cy=6#D{vi
zFv5&+cEoMW59S}t3_cu60$_98K;{^snZpHiJ;XiEPIwGr`oYA&p~S(kS(y2fC;*9S
BMH&DA

diff --git a/tests/data/acpi/pc/DSDT.numamem b/tests/data/acpi/pc/DSDT.numamem
index 9a747f6f08f61c73b891d8f91db01521e635f811..f194bc639482eb839a875d493857526f85f1a9e0 100644
GIT binary patch
delta 164
zcmeCyn4`|+66_K(N0@<u(O@H2FQb5;xIS}yuv2`1v!{V)uw(q>Ym5)2jC=w@3_0RG
zJY9GkFR(Ch#D{viFml8Phd55Y%On+U<m~SYmu3Y@z@@qPIpUpzf&~S*c-<L)F#lj?
n;7}4^sAPz4QVj}mj)xh^4Kxz2tbn0_fssRrfpK#abEg0RmCh&8

delta 282
zcmbQE-mSsq66_MfEyBRScwr+~FQc%poIZ1Wuv2`1v!{V)uw#65lkVh?Od=8zT%zub
z1q=lY0!&H_jP8s@3`Gn~Y?Ta?moq-BxAO@IiRXy-@O0sEyuiXBA`u@P;>b|o6X5EX
zuz+oH0>cu9g)B?B_&MU8gMtMGxOm+eE0`;oIXILW7%CZ}n_O9({e2B#2Cy=6#D{vi
zFv5&+cEoMW59S}t3_cu60$_98K;{^snZpHiJ;XiEPIwGr`oYA&p~S(kS(v#~002NJ
BM34Xg

diff --git a/tests/data/acpi/q35/DSDT b/tests/data/acpi/q35/DSDT
index 9fa4d5a405c2bcd9313b13894917622bf156013e..6a5e4dd85a7d9a95f7ad0fb95e6a4fa7a8d91adb 100644
GIT binary patch
delta 164
zcmdmPd%}jxCD<jzLym!g@ybRn0VV-&etqWnV5j&1XHNsqV8{5$kxX$?Mm_-{h8*!8
zo-RC&7g!iL;zK=M7&+pDLmVgHWs(Xva`yLyOS1wc;L=?D9P!RU!GZ!@yzY!Yn13)c
na3~2dR5C<2sRo5O$HR=|1{w)hR=`lez{sJ*z__`I*;E<;P|hab

delta 282
zcmX?Mv)z`<CD<ioyBq@pW9ddN0VZKDF@5IvV5j&1XHNsqV8{6ACf&&&nM5QcxJ2C<
z3m6I*1elZ<7~L6*7>XE}*eV$&Yca*u+xY~9#B;=Zc)IX7USMGmk%$itabzg)32^mG
zSim+pfnf>5LY5_5{2cMlLBWCoT)gg#70eaP92`mw43!MgO|C4?{=SAV16Ub3;zK=M
z7-7aZJK{Fx2lEeR1|JS30kAo4Aajh+%;5sM9^xKnCp-o*{a|9?P~u?NEX-^w4FJ*)
BL!JNt

diff --git a/tests/data/acpi/q35/DSDT.acpihmat b/tests/data/acpi/q35/DSDT.acpihmat
index 2d834a854ccddc17afd0bc4b4a9e0886feff8e65..c1dd7773f3386a946fcb4a9a3bf9ad3a33ddbbe9 100644
GIT binary patch
delta 164
zcmaFt{>6>UCD<jTM45qsanVLD0VV-&etqWnV5j&1XHNsqV8{5$kxX$?Mm_-{h8*!8
zo-RC&7g!iL;zK=M7&+pDLmVgHWs(Xva`yLyOS1wc;L=?D9P!RU!GZ!@yzY!Yn13)c
na3~2dR5C<2sRo5O$HR=|1{w)hR=`lez{sJ*z__`IIZ*)smNh4P

delta 282
zcmez3_Sl`vCD<k8u`&Y#qw_{C0VZKDF@5IvV5j&1XHNsqV8{6ACf&&&nM5QcxJ2C<
z3m6I*1elZ<7~L6*7>XE}*eV$&Yca*u+xY~9#B;=Zc)IX7USMGmk%$itabzg)32^mG
zSim+pfnf>5LY5_5{2cMlLBWCoT)gg#70eaP92`mw43!MgO|C4?{=SAV16Ub3;zK=M
z7-7aZJK{Fx2lEeR1|JS30kAo4Aajh+%;5sM9^xKnCp-o*{a|9?P~u?NEX<s!002nW
BL^=Qf

diff --git a/tests/data/acpi/q35/DSDT.bridge b/tests/data/acpi/q35/DSDT.bridge
index b75122b24a41b8fd58b9e7071032298e0fc2284b..2ef1e894a35b9e85fe07e2678bd2456f5ec40dc6 100644
GIT binary patch
delta 164
zcmX?Md((!?CD<h-QjURvv1B8c0F!_>zdmz(uv2`1v!{V)uw(q>NTxU`BcFf}LymY4
zPZu7?3oHyA@u8kBj2!X7A&!&pGD(FSIs5y<rCEUzaA_`nj(F#wU_k*cUU$YH%s-eJ
nIFtk!DjA}iRD(jC<6%Z}1C4|$D_|&KVB}C@VBFlq>?REWIH4xP

delta 282
zcmca<bHbL(CD<k8gd76{qv%F10VZKDF@5IvV5j&1XHNsqV8{6ACf&&&nM5QcxJ2C<
z3m6I*1elZ<7~L6*7>XE}*eV$&Yca*u+xY~9#B;=Zc)IX7USMGmk%$itabzg)32^mG
zSim+pfnf>5LY5_5{2cMlLBWCoT)gg#70eaP92`mw43!MgO|C4?{=SAV16Ub3;zK=M
z7-7aZJK{Fx2lEeR1|JS30kAo4Aajh+%;5sM9^xKnCp-o*{a|9?P~u?NEX?dC4FIJi
BLxKPR

diff --git a/tests/data/acpi/q35/DSDT.cphp b/tests/data/acpi/q35/DSDT.cphp
index c59c19ff46b9bb4fa3e06e9ffbcbeba308a80cd0..74e86176e5fec46e660c567acf8fbcf08a14bdfb 100644
GIT binary patch
delta 164
zcmZp3obJHo66_KpuE4;+=(~|ifJwlcU!OTX*eO21+0(!?*fD-`BvYJ}kxxK~AxFH2
zrwfnc1r`R5_)t$5MvnO45XZ@PnWVyvoc(>_(yTxUxHK0(N4#@Tu%G}JuRG%p<{!)q
n97+NVl?>5MszD*n@h~H~fkwiW6)+SqFmfm{Fm7&QW|0K|t9T`#

delta 282
zcmbR4(B{bH66_Mvroh0!_--SY0F$tnm_BoSuv2`1v!{V)uw#65lkVh?Od=8zT%zub
z1q=lY0!&H_jP8s@3`Gn~Y?Ta?wV2}S?R)}4;yL0yJY9GkFR(C(NW=$+I5HIY1i1Po
zEMS|Qz_5g2A<GgjevWwOpkP4(E?#%W3g!xC4i2RThDwI$CRY|`e_unG0j!K1@u8kB
zj4)%I9dR4;gZT$DgAa$20N5NikU2(Z=5PUB4{?vP6CQ(@elRg`C~+`s7G`FV1pvEf
BLtg*@

diff --git a/tests/data/acpi/q35/DSDT.dimmpxm b/tests/data/acpi/q35/DSDT.dimmpxm
index 9edc104ee6b06dd9d909b65b83c99494d03a137d..4bf8e9d64b04f9f805047d6850c2dd0086970445 100644
GIT binary patch
delta 164
zcmZ4Ewbzr&CD<iouL=VLqxeQH0VV-&etqWnV5j&1XHNsqV8{5$kxX$?Mm_-{h8*!8
zo-RC&7g!iL;zK=M7&+pDLmVgHWs(Xva`yLyOS1wc;L=?D9P!RU!GZ!@yzY!Yn13)c
na3~2dR5C<2sRo5O$HR=|1{w)hR=`lez{sJ*z__`Id6gmnFXbm3

delta 282
zcmdn%xyFmjCD<iIN0otrar;It0VZKDF@5IvV5j&1XHNsqV8{6ACf&&&nM5QcxJ2C<
z3m6I*1elZ<7~L6*7>XE}*eV$&Yca*u+xY~9#B;=Zc)IX7USMGmk%$itabzg)32^mG
zSim+pfnf>5LY5_5{2cMlLBWCoT)gg#70eaP92`mw43!MgO|C4?{=SAV16Ub3;zK=M
z7-7aZJK{Fx2lEeR1|JS30kAo4Aajh+%;5sM9^xKnCp-o*{a|9?P~u?NEX=%05de>t
BL)!oV

diff --git a/tests/data/acpi/q35/DSDT.ipmibt b/tests/data/acpi/q35/DSDT.ipmibt
index 3910e9b767808962b46501da51945229359e3d1d..38723daef80421ea528b2ad2d411e7357df43956 100644
GIT binary patch
delta 172
zcmZp&n{3PF66_K(S&o5$kz*s50F!{5h(2?Cuv2`1v!{V)uw(q>NT#^SZOooB(M?7^
z0U?GQ@gANoJdPJw7&ziXJzW?%;)6pRC*Ng~iZpWe_k~Nd0wv(mT>KpI&OyO~0$jZA
uj6axvFf(u{2{2SLL^r7hg*eB<jN}Fy30GFYPylq25(8r;!{+nM#?k<Ck|_WH

delta 258
zcmbPi+hoV(66_MfB+tOWxMCxh0F%9|v_5luuv2`1v!{V)uw#65lWtImb38}9ho=jV
z;{|R8j(F#wU_l8kQFq1yh5`lwCM5<&cg7-yA_gY5N`}c=OmS*<J^>+c9V`qY67j(y
zjtm7p0j_=t3)m(nFf3tM$g*VeTP7)8R~Bb~UqhJbtc)D-p`I>`Fdfd0s5%sxrCi)V
rI*ibCa52HPIH73a;)l3bfQ#3i@dwinCI${A4u;7sOum~Fn2n_Y$^<{r

diff --git a/tests/data/acpi/q35/DSDT.memhp b/tests/data/acpi/q35/DSDT.memhp
index 8461e984c965da916d828884f6629422e83e429c..98328d1c4197ab19a71de7f3f18e2985f4910f45 100644
GIT binary patch
delta 164
zcmZqknC{Ny66_K(U73M_@z_Q#0VV-&etqWnV5j&1XHNsqV8{5$kxX$?Mm_-{h8*!8
zo-RC&7g!iL;zK=M7&+pDLmVgHWs(Xva`yLyOS1wc;L=?D9P!RU!GZ!@yzY!Yn13)c
na3~2dR5C<2sRo5O$HR=|1{w)hR=`lez{sJ*z__`IxkUj0OPVJw

delta 282
zcmbR4-sZvO66_MfrozC$n6{BifJxX(OrJSE*eO21+0(!?*fBo3Nq6!`CJ_k<E>U;J
z0)_$x0VX8|Mt8;{h9U+gwn~P{T1;{Ec0K_i@f`6Uo-RC&7g!iXB;tcZ92p9H0$lwP
z7O+iDU|7PikYx!MKS#WCP_Uo?7q2^G1#<;62ZvGvLnT9WlPim}zpo+809Hnh_)t$5
zMwl_qj<}8a!Tf`n!G}Xh0BnvM$Q&aybGU%6hq%Yt36DWcKbROelsFhR3p2MU006lR
BLhJwl

diff --git a/tests/data/acpi/q35/DSDT.mmio64 b/tests/data/acpi/q35/DSDT.mmio64
index fc0cc096baf8aedc0a526978ff796025d7380453..5916c0e9ce0a9607c6230f9dfebe2c1be70b2495 100644
GIT binary patch
delta 164
zcmZ4Jw#k*tCD<iolM(|1W79@10VV-&etqWnV5j&1XHNsqV8{5$kxX$?Mm_-{h8*!8
zo-RC&7g!iL;zK=M7&+pDLmVgHWs(Xva`yLyOS1wc;L=?D9P!RU!GZ!@yzY!Yn13)c
na3~2dR5C<2sRo5O$HR=|1{w)hR=`lez{sJ*z__`IdA>XVQ;;W5

delta 282
zcmdnwy3mcwCD<iIQJH~(QE4NW0F$tnm_BoSuv2`1v!{V)uw#65lkVh?Od=8zT%zub
z1q=lY0!&H_jP8s@3`Gn~Y?Ta?wV2}S?R)}4;yL0yJY9GkFR(C(NW=$+I5HIY1i1Po
zEMS|Qz_5g2A<GgjevWwOpkP4(E?#%W3g!xC4i2RThDwI$CRY|`e_unG0j!K1@u8kB
zj4)%I9dR4;gZT$DgAa$20N5NikU2(Z=5PUB4{?vP6CQ(@elRg`C~+`s7G|C=4*<ln
BLk<7{

diff --git a/tests/data/acpi/q35/DSDT.numamem b/tests/data/acpi/q35/DSDT.numamem
index 498c843be1695a0fe1d31d88873b57206d17d758..cf3fde3449bc8e9bbe683b936cf9866590b0ef82 100644
GIT binary patch
delta 164
zcmdmMd(MW-CD<jzPmY0sv2G)m0F!_>zdmz(uv2`1v!{V)uw(q>NTxU`BcFf}LymY4
zPZu7?3oHyA@u8kBj2!X7A&!&pGD(FSIs5y<rCEUzaA_`nj(F#wU_k*cUU$YH%s-eJ
nIFtk!DjA}iRD(jC<6%Z}1C4|$D_|&KVB}C@VBFlqY%L7{DZD13

delta 282
zcmX?Sv)7i(CD<iouN(sdqx?oL0VZKDF@5IvV5j&1XHNsqV8{6ACf&&&nM5QcxJ2C<
z3m6I*1elZ<7~L6*7>XE}*eV$&Yca*u+xY~9#B;=Zc)IX7USMGmk%$itabzg)32^mG
zSim+pfnf>5LY5_5{2cMlLBWCoT)gg#70eaP92`mw43!MgO|C4?{=SAV16Ub3;zK=M
z7-7aZJK{Fx2lEeR1|JS30kAo4Aajh+%;5sM9^xKnCp-o*{a|9?P~u?NEX-^z4FHR!
BLtp>^

-- 
MST


