Return-Path: <SRS0=s7fR=UB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7269BC282DC
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Jun 2019 16:30:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D9A827970
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Jun 2019 16:30:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zrPbwX2F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D9A827970
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50801 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hXTNe-0007YN-56
	for qemu-devel@archiver.kernel.org; Sun, 02 Jun 2019 12:30:46 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40780)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hXTML-0006Zx-2i
	for qemu-devel@nongnu.org; Sun, 02 Jun 2019 12:29:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hXTBn-0004Yo-LX
	for qemu-devel@nongnu.org; Sun, 02 Jun 2019 12:18:33 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:36313)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hXTBn-0004XD-DI
	for qemu-devel@nongnu.org; Sun, 02 Jun 2019 12:18:31 -0400
Received: by mail-wr1-x443.google.com with SMTP id n4so6627381wrs.3
	for <qemu-devel@nongnu.org>; Sun, 02 Jun 2019 09:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=references:user-agent:from:to:subject:in-reply-to:date:message-id
	:mime-version:content-transfer-encoding;
	bh=2IQsbSJJ3IQtK+oBZmdCIiSTODGaRMJ9p/tJJcmn3qQ=;
	b=zrPbwX2FzMoDxwK3yHtNXBglqJvQsVILo7So/Fxouv8jZLY8yAfqxmHNE63sAiNnZQ
	sbY1NjmK67P85PmUtsilVsAvHsfcJA/yTEfohGeNjyNWgXfoOlh4sor43TmwFbUAynek
	gycDnBP6pcDb4JhRRVFo4OMKpR/kQdZFfGnjF6aGTrGi6P4VXtk92C6TyDQD6baqaf+y
	iD+Tefx0vQTGQJTwFiSemjxBSYTuXRqDWPg498w0zL9XRSK7dujrm/+rVMjKekli2fjK
	6RO556FCAm8gTMd1h/WsYAqQS8VJdWQbylUMYuKJ7mCZlwZzWzsWyH7eN1ocSkOL1T7w
	r1hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:references:user-agent:from:to:subject
	:in-reply-to:date:message-id:mime-version:content-transfer-encoding;
	bh=2IQsbSJJ3IQtK+oBZmdCIiSTODGaRMJ9p/tJJcmn3qQ=;
	b=BOALRr0Jyq0lRi4G0Pi/Xe4TyPHuMxjqeKyKJ3L7HrHHxvmntoxRJa2RXi4LIKdQUQ
	GWYykSqjZLC2fJTQrNSWwaQXHiatkD2azc88usuT/0As2JdluaDKvFriVL+OCjYHsTfp
	yIqQXrGfZGF2I8/yd3KlmGNlZh36h+1yjn2Bqc1JhwE4Ykr+iABsnMUGPHwPIXx/kkCM
	VXJRXcgfyIiNSubLkN5QZwM5QUFm+kXIk1fRBFBb5uMed21hZhn8FE2Emm81ZcLyP2a2
	0OG/oVy90XzYOCmt9f4QrRVH9ID/jGddJHKbi5DqC9X+eaRk2rqLygo0uFaUerpWq9Kt
	2BhA==
X-Gm-Message-State: APjAAAX/4OnAmbz2ArbMwaRpk42xAjaD2kjpfcc0r5BXa0UBYBByuyRM
	4f2+ZQarNby6IW4h21Bbj/XDaII5wZI=
X-Google-Smtp-Source: APXvYqwhXyZHEgPz/OFrAinNj6k8WFO4pvABeMCPGxEvBP6ps4yHAwxv9CYgKfHIxQvCw1XrbkmaOQ==
X-Received: by 2002:adf:e711:: with SMTP id c17mr13648084wrm.227.1559492308942;
	Sun, 02 Jun 2019 09:18:28 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id
	f65sm15561976wmg.45.2019.06.02.09.18.27 for <qemu-devel@nongnu.org>
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Sun, 02 Jun 2019 09:18:28 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id 71E211FF87
	for <qemu-devel@nongnu.org>; Sun,  2 Jun 2019 17:18:27 +0100 (BST)
References: <201906010603.23645.randrianasulu@gmail.com>
User-agent: mu4e 1.3.2; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
In-reply-to: <201906010603.23645.randrianasulu@gmail.com>
Date: Sun, 02 Jun 2019 17:18:27 +0100
Message-ID: <874l58dkq4.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: Re: [Qemu-devel] "accel/tcg: demacro cputlb" break
 qemu-system-x86_64
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


Andrew Randrianasulu <randrianasulu@gmail.com> writes:

> Hello!
>
> I was compiling latest qemu git, and was surprized to find qemu-system-x8=
6_64
> (compiled for 32-bit x86 machine) can't boot any 64-bit kernel anymore.
>
> 32-bit kernels and kvm were fine.
> So, I run git bisect
>
> ./configure --target-list=3Dx86_64-softmmu --disable-werror
>
> make -j 5
>
> x86_64-softmmu/qemu-system-x86_64 -kernel /boot/bzImage-4.12.0-x64
> -accel tcg

Could you run:

  make check-tcg

And report which tests (if any) fail?


>
> git bisect log
> git bisect start
> # bad: [60905286cb5150de854e08279bca7dfc4b549e91] Merge remote-tracking b=
ranch 'remotes/dgibson/tags/ppc-for-4.1-20190529' into staging
> git bisect bad 60905286cb5150de854e08279bca7dfc4b549e91
> # good: [32a1a94dd324d33578dca1dc96d7896a0244d768] Update version for v3.=
1.0 release
> git bisect good 32a1a94dd324d33578dca1dc96d7896a0244d768
> # good: [32a1a94dd324d33578dca1dc96d7896a0244d768] Update version for v3.=
1.0 release
> git bisect good 32a1a94dd324d33578dca1dc96d7896a0244d768
> # good: [9403bccfe3e271f04e12c8c64d306e0cff589009] Merge remote-tracking =
branch 'remotes/pmaydell/tags/pull-target-arm-20190228-1' into staging
> git bisect good 9403bccfe3e271f04e12c8c64d306e0cff589009
> # good: [9403bccfe3e271f04e12c8c64d306e0cff589009] Merge remote-tracking =
branch 'remotes/pmaydell/tags/pull-target-arm-20190228-1' into staging
> git bisect good 9403bccfe3e271f04e12c8c64d306e0cff589009
> # good: [a39286dd61e455014694cb6aa44cfa9e5c86d101] nbd: Tolerate some ser=
ver non-compliance in NBD_CMD_BLOCK_STATUS
> git bisect good a39286dd61e455014694cb6aa44cfa9e5c86d101
> # bad: [bab1671f0fa928fd678a22f934739f06fd5fd035] tcg: Manually expand IN=
DEX_op_dup_vec
> git bisect bad bab1671f0fa928fd678a22f934739f06fd5fd035
> # bad: [bab1671f0fa928fd678a22f934739f06fd5fd035] tcg: Manually expand IN=
DEX_op_dup_vec
> git bisect bad bab1671f0fa928fd678a22f934739f06fd5fd035
> # good: [956fe143b4f254356496a0a1c479fa632376dfec] target/arm: Implement =
VLLDM for v7M CPUs with an FPU
> git bisect good 956fe143b4f254356496a0a1c479fa632376dfec
> # good: [df06df4f412a67341de0fbb075e74c4dde3c8972] Merge remote-tracking =
branch 'remotes/ericb/tags/pull-nbd-2019-05-07' into staging
> git bisect good df06df4f412a67341de0fbb075e74c4dde3c8972
> # good: [e5a0a6784a63a15d5b1221326fe5c258be6b5561] vvfat: Replace bdrv_{r=
ead,write}() with bdrv_{pread,pwrite}()
> git bisect good e5a0a6784a63a15d5b1221326fe5c258be6b5561
> # bad: [01807c8b0e9f5da6981c2e62a3c1d8f661fb178e] Merge remote-tracking b=
ranch 'remotes/armbru/tags/pull-misc-2019-05-13' into staging
> git bisect bad 01807c8b0e9f5da6981c2e62a3c1d8f661fb178e
> # bad: [04d6556c5c91d6b00c70df7b85e1715a7c7870df] Merge remote-tracking b=
ranch 'remotes/stsquad/tags/pull-demacro-softmmu-100519-1' into staging
> git bisect bad 04d6556c5c91d6b00c70df7b85e1715a7c7870df
> # good: [c9ba36ff2f56a95dec0ee47f4dab0b22a0a01f86] Merge remote-tracking =
branch 'remotes/kevin/tags/for-upstream' into staging
> git bisect good c9ba36ff2f56a95dec0ee47f4dab0b22a0a01f86
> # bad: [fc1bc777910dc14a3db4e2ad66f3e536effc297d] cputlb: Drop attribute =
flatten
> git bisect bad fc1bc777910dc14a3db4e2ad66f3e536effc297d
> # bad: [f1be36969de2fb9b6b64397db1098f115210fcd9] cputlb: Move TLB_RECHEC=
K handling into load/store_helper
> git bisect bad f1be36969de2fb9b6b64397db1098f115210fcd9
> # bad: [eed5664238ea5317689cf32426d9318686b2b75c] accel/tcg: demacro cput=
lb
> git bisect bad eed5664238ea5317689cf32426d9318686b2b75c
> # first bad commit: [eed5664238ea5317689cf32426d9318686b2b75c] accel/tcg:=
 demacro cputlb
>
> Not sure how many people test qemu-system-x86_64 on 32-bit x86 hosts....
>
>  gcc --version
> gcc (GCC) 5.5.0
>
> commit log says
>
> -------------
> accel/tcg: demacro cputlb
>
>     Instead of expanding a series of macros to generate the load/store
>     helpers we move stuff into common functions and rely on the compiler
>     to eliminate the dead code for each variant.
> --------------
>
> May be gcc 5.5.0 was not really good in this case ...


--
Alex Benn=C3=A9e

