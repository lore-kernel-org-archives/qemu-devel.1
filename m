Return-Path: <SRS0=oHhb=TY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47A59C072B5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 09:43:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 137B720645
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 09:43:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SA8AzsfL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 137B720645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51740 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hU6jR-0005Ue-D9
	for qemu-devel@archiver.kernel.org; Fri, 24 May 2019 05:43:21 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52098)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hU6ii-0005CB-JQ
	for qemu-devel@nongnu.org; Fri, 24 May 2019 05:42:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hU6ih-0003lI-Dl
	for qemu-devel@nongnu.org; Fri, 24 May 2019 05:42:36 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332]:51184)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hU6ih-0003kg-6b
	for qemu-devel@nongnu.org; Fri, 24 May 2019 05:42:35 -0400
Received: by mail-wm1-x332.google.com with SMTP id f204so8668638wme.0
	for <qemu-devel@nongnu.org>; Fri, 24 May 2019 02:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=references:user-agent:from:to:cc:subject:in-reply-to:date
	:message-id:mime-version:content-transfer-encoding;
	bh=87UVlqHRelfcNWXT3JdLqhYWn4DoNQaTwoM/bIGHYL8=;
	b=SA8AzsfLgDOsyk+ULsSTkcpvUgZuNQCnJilKL7/OHTKJPAWB4CTbwCbqC3kr4+hy+M
	pR0oa1TRMT4jAAQIm454jhiYbfkEhmpGDKVMiXG3OuXeGTgRdBBHeNL8ClEGRjG/WEwh
	sFF3acWPk7G7/nCl4yRPu9Y8TNxF9bu+SEKnzrWZq3PfzIRzxHc4sVKIzjUJfxUfyYJC
	KaoURXlvPhSso4vynuUILT1/krORIm+TxLox1Ea6reObMbJDANdGVX3sQkSxUq9qpZGY
	HquRGRRzZjY6eqmEzt5LsQ61ESfeN0CFlS6oQ6jft8pbns1j+3Zqkkjq2/Ui27FPfIVy
	N65A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:references:user-agent:from:to:cc:subject
	:in-reply-to:date:message-id:mime-version:content-transfer-encoding;
	bh=87UVlqHRelfcNWXT3JdLqhYWn4DoNQaTwoM/bIGHYL8=;
	b=prfnCRwNcvZnEszK9wF+X0iPWhZ74hCQpa00aCw2mXSKGuG0kb/BCktOyoBzhQ6Rhp
	fc3Iiu0PfshlifNBDtUfB1hC5FENt+kY/5cLPoOmzf03lhTEzgIHWvi/MfueTvSw8+mx
	Ycy5ZXfVnorur6UnL5Fnuk80sgBVu9H+uSiZwVomU4ErlY2eHuYn9Ii4Of4c4yr5QH0/
	shmEzDgpUCHuJ1Wa0c7q+vdSnUSGq1zqezD2cynGXqANC6AjCZH06YGpoQK9KAm0+U+Z
	+H9NxE6TmmwYOzlAFzHfSJTXUs65PLIEsnJbSoiODirP0ZpWSOC3BSfkQBoXeIhBKnGb
	0sqw==
X-Gm-Message-State: APjAAAXaacg9v0ITj4cYndl21Zi2/d2VSTmSrnabF/5BwYAKg9DWgcw0
	u4ZRvxzMRBVSFtjpHnXmXzfTWw==
X-Google-Smtp-Source: APXvYqxEypnfIuI/y8BIjwxsvMh7oifDDqtMhTqJE3tIwnQIFzUdlpESEg6vpSK/CLcezEoK3EZAyg==
X-Received: by 2002:a1c:b789:: with SMTP id h131mr15024703wmf.71.1558690952296;
	Fri, 24 May 2019 02:42:32 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id 19sm2136412wmi.10.2019.05.24.02.42.31
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Fri, 24 May 2019 02:42:31 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id 5CD591FF87;
	Fri, 24 May 2019 10:42:31 +0100 (BST)
References: <20190523204409.21068-1-jan.bobek@gmail.com>
User-agent: mu4e 1.3.2; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Jan Bobek <jan.bobek@gmail.com>
In-reply-to: <20190523204409.21068-1-jan.bobek@gmail.com>
Date: Fri, 24 May 2019 10:42:31 +0100
Message-ID: <878suw194o.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::332
Subject: Re: [Qemu-devel] [RISU v3 00/11] Support for i386/x86_64 with
 vector extensions
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
	Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Jan Bobek <jan.bobek@gmail.com> writes:

> This patch series adds support for i386 and x86_64 architectures to
> RISU. Notably, vector registers (SSE, AVX, AVX-512) are supported for
> verification of the apprentice. This is V3 of the series posted in [1]
> and [2].

I've sent a patch to enable x86 in the build-all-arches tests script but
otherwise I think this series looks good to merge.

>
> Changes is V3:
>   - fix a matching bug caused by misplaced index multiplication [3]
>   - print an error and exit when parse of the --xfeatures option fails [4]
>
> References:
>   1. https://lists.nongnu.org/archive/html/qemu-devel/2019-04/msg01294.ht=
ml
>   2. https://lists.nongnu.org/archive/html/qemu-devel/2019-05/msg04089.ht=
ml
>   3. https://lists.nongnu.org/archive/html/qemu-devel/2019-05/msg04922.ht=
ml
>   4. https://lists.nongnu.org/archive/html/qemu-devel/2019-05/msg04903.ht=
ml
>
> Jan Bobek (10):
>   Makefile: undefine the arch name symbol
>   risu_i386: move reginfo_t and related defines to risu_reginfo_i386.h
>   risu_i386: move reginfo-related code to risu_reginfo_i386.c
>   risu_reginfo_i386: implement arch-specific reginfo interface
>   risu_i386: implement missing CPU-specific functions
>   risu_i386: remove old unused code
>   test_i386: change syntax from nasm to gas
>   configure: add i386/x86_64 architectures
>   risu_reginfo_i386: replace xfeature constants with symbolic names
>   risu_reginfo_i386: rework --xfeatures value parsing
>
> Richard Henderson (1):
>   i386: Add avx512 state to reginfo_t
>
>  configure           |  10 +-
>  Makefile            |   5 +-
>  risu_reginfo_i386.h |  49 ++++++
>  risu_i386.c         | 142 ++--------------
>  risu_reginfo_i386.c | 400 ++++++++++++++++++++++++++++++++++++++++++++
>  test_i386.S         |  80 +++++++++
>  test_i386.s         |  27 ---
>  7 files changed, 556 insertions(+), 157 deletions(-)
>  create mode 100644 risu_reginfo_i386.h
>  create mode 100644 risu_reginfo_i386.c
>  create mode 100644 test_i386.S
>  delete mode 100644 test_i386.s


--
Alex Benn=C3=A9e

