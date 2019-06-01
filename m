Return-Path: <SRS0=gcBw=UA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CA14C04AB6
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Jun 2019 03:16:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38763270DA
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Jun 2019 03:16:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ds+P6CDA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38763270DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52095 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWuVF-0000Io-DN
	for qemu-devel@archiver.kernel.org; Fri, 31 May 2019 23:16:17 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48716)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <randrianasulu@gmail.com>) id 1hWuUO-00086m-2L
	for qemu-devel@nongnu.org; Fri, 31 May 2019 23:15:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <randrianasulu@gmail.com>) id 1hWuQd-0002yA-7m
	for qemu-devel@nongnu.org; Fri, 31 May 2019 23:11:32 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530]:35650)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <randrianasulu@gmail.com>)
	id 1hWuQc-0002xa-Ow
	for qemu-devel@nongnu.org; Fri, 31 May 2019 23:11:31 -0400
Received: by mail-pg1-x530.google.com with SMTP id t1so1537188pgc.2
	for <qemu-devel@nongnu.org>; Fri, 31 May 2019 20:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:subject:date:user-agent:mime-version
	:content-transfer-encoding:content-disposition:message-id;
	bh=E35KT0VHdn7bbdZnWSlo+v31/fAe02WDJACKXfWg6qY=;
	b=Ds+P6CDAPh/HAzKRjwUKPF1rgMc7j8H51VQ3G0hzG02KM8hLXkSBmeAfBTvf4MSu2h
	d3O+BgIEPCSirR8hEuBtn4fYXNmlnP6wTqbKofbT+73Zq+tQBOflqF7KhNvGQyZYL8nL
	kuSHUQkNpDUKkTk7v8p/ZQnE0+UvCb4mstWgygj0gyyzDUFFij2q0dIVJM4e/MYiywcb
	RCPo3AzrFGcFKpcjkGQUewGOoh+2XjxFo5oft8vXW817VI1EObl1nF3bYILPFDDR8GO3
	SfSz0qNxuHPcnfQ66n1AczFAhosaojJHF4yTRD3mAGFH4KaLTNfeY/NSuHLNWkov34Ps
	u66A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:user-agent:mime-version
	:content-transfer-encoding:content-disposition:message-id;
	bh=E35KT0VHdn7bbdZnWSlo+v31/fAe02WDJACKXfWg6qY=;
	b=ga/ucxJCrqcY82CvKB1LKcJEiSeHrLN/hJ6ud5H/MeApQeeyJ236Xq0rXQ4s5L4E8I
	reJhPpfZrLTkfgVBlVSNrrJMN1goY/e8p614r8aPp2lzIWpe0VzOVBfJm9l1QB5IBNrc
	OKa8ugUQyCJIVfMGAYBjNGvQHB0pahJkTgmDRGWBEk0rIoUM5ExjrWd8KFPrYYUwe9IY
	ojOxTgbBh1a5uzyvFiuasomUWZc5BL2koXA8ylA/4QddVZKHvFFiTOK8J4+DxL2TmT0i
	HOCXJqBrEhuba9zc5wgW32AvW+kYGJ9O17tafHsf2zNOovx7oEqFBL3UhsEPN9261KiF
	aP2A==
X-Gm-Message-State: APjAAAV+G+QtorCxA/XSq4KBZzYmVrqotdFT4BvxCBxrspuhPwHDdV1P
	Z8F7Z3wJ9aPPtfY9cYL7NbNf/67G
X-Google-Smtp-Source: APXvYqx9L3Lq/m1CEdfhvzOtgRVgImEOSE5aP40kF05A06IRUc09qfBlps0NOE28TF8BE0RYGoZdFQ==
X-Received: by 2002:a63:24c1:: with SMTP id
	k184mr10821179pgk.120.1559358688860; 
	Fri, 31 May 2019 20:11:28 -0700 (PDT)
Received: from [192.168.1.100] ([176.116.252.109])
	by smtp.gmail.com with ESMTPSA id 2sm8499385pgl.40.2019.05.31.20.11.27
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 31 May 2019 20:11:28 -0700 (PDT)
From: Andrew Randrianasulu <randrianasulu@gmail.com>
To: qemu-devel@nongnu.org
Date: Sat, 1 Jun 2019 06:03:23 +0300
User-Agent: KMail/1.9.10
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <201906010603.23645.randrianasulu@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::530
Subject: [Qemu-devel] "accel/tcg: demacro cputlb" break qemu-system-x86_64
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello!

I was compiling latest qemu git, and was surprized to find qemu-system-x86_64
(compiled for 32-bit x86 machine) can't boot any 64-bit kernel anymore.

32-bit kernels and kvm were fine.
So, I run git bisect

./configure --target-list=x86_64-softmmu --disable-werror 

make -j 5

x86_64-softmmu/qemu-system-x86_64 -kernel /boot/bzImage-4.12.0-x64 -accel tcg

git bisect log
git bisect start
# bad: [60905286cb5150de854e08279bca7dfc4b549e91] Merge remote-tracking branch 'remotes/dgibson/tags/ppc-for-4.1-20190529' into staging
git bisect bad 60905286cb5150de854e08279bca7dfc4b549e91
# good: [32a1a94dd324d33578dca1dc96d7896a0244d768] Update version for v3.1.0 release
git bisect good 32a1a94dd324d33578dca1dc96d7896a0244d768
# good: [32a1a94dd324d33578dca1dc96d7896a0244d768] Update version for v3.1.0 release
git bisect good 32a1a94dd324d33578dca1dc96d7896a0244d768
# good: [9403bccfe3e271f04e12c8c64d306e0cff589009] Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20190228-1' into staging
git bisect good 9403bccfe3e271f04e12c8c64d306e0cff589009
# good: [9403bccfe3e271f04e12c8c64d306e0cff589009] Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20190228-1' into staging
git bisect good 9403bccfe3e271f04e12c8c64d306e0cff589009
# good: [a39286dd61e455014694cb6aa44cfa9e5c86d101] nbd: Tolerate some server non-compliance in NBD_CMD_BLOCK_STATUS
git bisect good a39286dd61e455014694cb6aa44cfa9e5c86d101
# bad: [bab1671f0fa928fd678a22f934739f06fd5fd035] tcg: Manually expand INDEX_op_dup_vec
git bisect bad bab1671f0fa928fd678a22f934739f06fd5fd035
# bad: [bab1671f0fa928fd678a22f934739f06fd5fd035] tcg: Manually expand INDEX_op_dup_vec
git bisect bad bab1671f0fa928fd678a22f934739f06fd5fd035
# good: [956fe143b4f254356496a0a1c479fa632376dfec] target/arm: Implement VLLDM for v7M CPUs with an FPU
git bisect good 956fe143b4f254356496a0a1c479fa632376dfec
# good: [df06df4f412a67341de0fbb075e74c4dde3c8972] Merge remote-tracking branch 'remotes/ericb/tags/pull-nbd-2019-05-07' into staging
git bisect good df06df4f412a67341de0fbb075e74c4dde3c8972
# good: [e5a0a6784a63a15d5b1221326fe5c258be6b5561] vvfat: Replace bdrv_{read,write}() with bdrv_{pread,pwrite}()
git bisect good e5a0a6784a63a15d5b1221326fe5c258be6b5561
# bad: [01807c8b0e9f5da6981c2e62a3c1d8f661fb178e] Merge remote-tracking branch 'remotes/armbru/tags/pull-misc-2019-05-13' into staging
git bisect bad 01807c8b0e9f5da6981c2e62a3c1d8f661fb178e
# bad: [04d6556c5c91d6b00c70df7b85e1715a7c7870df] Merge remote-tracking branch 'remotes/stsquad/tags/pull-demacro-softmmu-100519-1' into staging
git bisect bad 04d6556c5c91d6b00c70df7b85e1715a7c7870df
# good: [c9ba36ff2f56a95dec0ee47f4dab0b22a0a01f86] Merge remote-tracking branch 'remotes/kevin/tags/for-upstream' into staging
git bisect good c9ba36ff2f56a95dec0ee47f4dab0b22a0a01f86
# bad: [fc1bc777910dc14a3db4e2ad66f3e536effc297d] cputlb: Drop attribute flatten
git bisect bad fc1bc777910dc14a3db4e2ad66f3e536effc297d
# bad: [f1be36969de2fb9b6b64397db1098f115210fcd9] cputlb: Move TLB_RECHECK handling into load/store_helper
git bisect bad f1be36969de2fb9b6b64397db1098f115210fcd9
# bad: [eed5664238ea5317689cf32426d9318686b2b75c] accel/tcg: demacro cputlb
git bisect bad eed5664238ea5317689cf32426d9318686b2b75c
# first bad commit: [eed5664238ea5317689cf32426d9318686b2b75c] accel/tcg: demacro cputlb

Not sure how many people test qemu-system-x86_64 on 32-bit x86 hosts....

 gcc --version
gcc (GCC) 5.5.0

commit log says

-------------
accel/tcg: demacro cputlb

    Instead of expanding a series of macros to generate the load/store
    helpers we move stuff into common functions and rely on the compiler
    to eliminate the dead code for each variant.
--------------

May be gcc 5.5.0 was not really good in this case ...

