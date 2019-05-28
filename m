Return-Path: <SRS0=2W3W=T4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC46BC04AB6
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 12:39:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9780020883
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 12:39:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uIxzMIX9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9780020883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:34093 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVbOX-0001Mh-7N
	for qemu-devel@archiver.kernel.org; Tue, 28 May 2019 08:39:57 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53473)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hVbNk-00013m-9w
	for qemu-devel@nongnu.org; Tue, 28 May 2019 08:39:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hVbNj-0006sH-3g
	for qemu-devel@nongnu.org; Tue, 28 May 2019 08:39:08 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:33923)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hVbNi-0006rj-Q4
	for qemu-devel@nongnu.org; Tue, 28 May 2019 08:39:07 -0400
Received: by mail-ot1-x341.google.com with SMTP id l17so17605811otq.1
	for <qemu-devel@nongnu.org>; Tue, 28 May 2019 05:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=UN4nmfB6xzSqB3xy1WTIHPoOYrayTbg2dhx+E6kLkgg=;
	b=uIxzMIX9iWZacCu7WeRdBIonx80MCgg+4+qGmNIWw72O1wuStCV2QDFAN6AvCHWSc4
	mlEIs4KCw/JjxBqzmhx3W3vEViPsSvmjzgN0+32oljblOcs2oKLPgArKfO6jEXIlQfxo
	fSNJZ3nSAHzW4VeWWPK1+T4ygm2u/OpqiJt5jI3GdTn7yYVLeI0SO6abbHn5H/sQFzyJ
	9lidARZIeZ3W8V5dFsg4xC9nIYV1RnHfxKS4TxKiMefZNj2uaZbKxwfLQRBKJoNLbZcG
	dHRM0OcGbZnublDZDps9SJ1VH5thYGToq4S9IO8pR35B1OcVQYo9Duu/7IsgnkOycY+i
	Y4Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=UN4nmfB6xzSqB3xy1WTIHPoOYrayTbg2dhx+E6kLkgg=;
	b=FaBWqs/Iul05sYhSsuJ3QBSaV2tAHAX7pcy9Gf+hObOl/bTns8djaqRenIb4Xbe3//
	fMAfAwB7AQAWTaHUEJ22CJS/L5h3/LE4TtXQ8BCtWZroJEsFBizSmWxhvTf3D+JR2WUT
	1p1Rx6h4l/MGuDUwL98H4EioHKvdOc+cpec00M81yoncLVZEYvYDOdv02B0fo5f9Wt+6
	mdGGrigkKio9qJCv+QVZhqlPhmPFPHJYR2j1lFSzla94gF1CK9oLbXN+2kyYqwy0clUQ
	itmMtvVQdHiB1RgjOahkzj38emvKBPchVZPylo7gPVXVFQA0quFtsDKEut+VQUQSvqBl
	JIdA==
X-Gm-Message-State: APjAAAXYJm48EJ3hukdUGL4OmWumlHN0yNaHLwiEIm8e/Cw9F17yCXpG
	6pgbPhB/snNhRxwhhhNjgjk3JzAYqYJN7/5AprHmUg==
X-Google-Smtp-Source: APXvYqwTi/ZpyC42gB3zspsniJN0vj561sg+XvfRIAG9kn6hHwE6zYNs1g2N9gdc3RMkX5oDx1M2JVku9gr3RSircz8=
X-Received: by 2002:a05:6830:209a:: with SMTP id
	y26mr46491354otq.232.1559047145700; 
	Tue, 28 May 2019 05:39:05 -0700 (PDT)
MIME-Version: 1.0
References: <1558887551-32137-1-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1558887551-32137-1-git-send-email-aleksandar.markovic@rt-rk.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 May 2019 13:38:54 +0100
Message-ID: <CAFEAcA9JkjrcNBx=NSbtkktCPQzxf6JLddix-cHQKe3ud==Svg@mail.gmail.com>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::341
Subject: Re: [Qemu-devel] [PULL 00/12] MIPS queue for May 19th, 2019 - v3
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
Cc: QEMU Developers <qemu-devel@nongnu.org>,
	Aleksandar Markovic <amarkovic@wavecomp.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, 26 May 2019 at 17:19, Aleksandar Markovic
<aleksandar.markovic@rt-rk.com> wrote:
>
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
>
> The following changes since commit a7b21f6762a2d6ec08106d8a7ccb11829914523f:
>
>   Merge remote-tracking branch 'remotes/vivier2/tags/linux-user-for-4.1-pull-request' into staging (2019-05-24 12:47:49 +0100)
>
> are available in the git repository at:
>
>   https://github.com/AMarkovic/qemu tags/mips-queue-may-19-2019-v3
>
> for you to fetch changes up to c47c336e870585307f1e2371ea85a6256a05022e:
>
>   BootLinuxSshTest: Test some userspace commands on Malta (2019-05-26 17:45:02 +0200)
>
> ----------------------------------------------------------------
>
> MIPS queue for May 19th, 2019 - v3
>
>
> v2->v3:
>    - removed two patches on object_initialize_child(), since they
>      became part of another pull 1-pull-request
>    - added two cleanup patches
>    - added a patch on fixing handling of semtimedop()
>    - amended patch on acceptance test
> v1->v2:
>    - fixed missing invocations in patch on ST.<B|H|W|D> that caused
>      clang build error
>    - added a patch on acceptance test for Malta
>
> highlights:
>
>    * Fix semtimedop() issue that appeared after kernel headers update
>    * Added an acceptance test for Malta board
>    * Better handling of memory pages (flag PAGE_EXEC)
>    * A set of fixes for emulation of MSA ASE on big endian hosts
>    * Better handling of 'div by zero' cases of MSA ASE instructions
>    * Clean up MIPS' cpu.h
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.1
for any user-visible changes.

-- PMM

