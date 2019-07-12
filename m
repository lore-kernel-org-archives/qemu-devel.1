Return-Path: <SRS0=r3/N=VJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B69DAC742BD
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 13:34:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82A3B206B8
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 13:34:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Itkr6NKp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82A3B206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49444 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlvhP-0007zT-Ft
	for qemu-devel@archiver.kernel.org; Fri, 12 Jul 2019 09:34:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56038)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hlvhE-0007aw-Qc
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 09:34:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hlvhA-0000QC-UA
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 09:34:42 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:52958)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hlvh8-0000NE-2R
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 09:34:38 -0400
Received: by mail-wm1-x342.google.com with SMTP id s3so8972767wms.2
 for <qemu-devel@nongnu.org>; Fri, 12 Jul 2019 06:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=JQI622zWoNUOkkgeCO+n7KDF7m0CTTwFldQO013t+js=;
 b=Itkr6NKptisEvD27C3IRpz3hJRc92BvVVBGjHunLo+ug/vmbqLI3DNTBC+NIkLHe9o
 1XpQUFuiGo/EJbIQHgKoKWGX1gDTNzp9YdgZ0W34cXyj67jFsH+iC2TSMVTGC2vdQkQb
 InpfU07B6O6lcTJ9bnKWivuiWVnCY42WJrSnaOv1eWdExJ0qfCIp14MGYccjYPrMaulS
 t+alDen3uM4ey9ruOmqk5Ukyn/VN61oEkwx8fbIK6mJ+0IuyZYgFM0qY2enMAMD1bWrM
 CFmwV2e4GKmfx2+0hkoPYn6/wb3TC/IHqecwqGnEhQdGnOKQ7N/SAaiN/9DOeK5E2v+O
 js5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=JQI622zWoNUOkkgeCO+n7KDF7m0CTTwFldQO013t+js=;
 b=GeMQoJbMnqy5AmPFYS00kwsrsFdzZa5b09/ltXfY7xQ6aBeoa45YJpnFPaD1Qx2xib
 aM8jMOsD0EsMTaEL01qlfdyYLnBBwtOijggzAvO7KKZe83vpknz2MiNsgEWB8tVIMA71
 +dDECmm0dshb846YFqumsiAfqwtqE9NRNWk0wU9ovtwfxpwVHeiTmc5jJziHCOshl/id
 oJ79CTMUAJoixgWMoPnvViTRmtDjlj93CPWPsEpL5M6jOqm7dZ236DOeBj9VyOJDlTzQ
 puHjn828oJBvvTXtByHvXr+shbMuVGeBeeNGZp+eXQwvRPQKU/3q9bZ+P4WmabFRJgEz
 7Bdw==
X-Gm-Message-State: APjAAAURwTsnUTsn6DqP3L//3zdEq9kLqaGeu59b1937utwTGS7/TAcQ
 wFINVD72vfS8e7JriotV6OHjtw==
X-Google-Smtp-Source: APXvYqyXg3MZS3A+uqSXdr7U8O5IwTuLsSA9ARtKfWmIOk9tJb6bstBs48dMMpLT1zZ2B626uOHJSA==
X-Received: by 2002:a1c:200a:: with SMTP id g10mr9304777wmg.160.1562938476512; 
 Fri, 12 Jul 2019 06:34:36 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id l8sm14976194wrg.40.2019.07.12.06.34.35
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 12 Jul 2019 06:34:35 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 9667A1FF87;
 Fri, 12 Jul 2019 14:34:35 +0100 (BST)
References: <20190711223300.6061-1-jan.bobek@gmail.com>
User-agent: mu4e 1.3.2; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Jan Bobek <jan.bobek@gmail.com>
In-reply-to: <20190711223300.6061-1-jan.bobek@gmail.com>
Date: Fri, 12 Jul 2019 14:34:35 +0100
Message-ID: <87zhljcr6c.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: Re: [Qemu-devel] [RISU PATCH v3 00/18] Support for generating x86
 SIMD test images
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
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Jan Bobek <jan.bobek@gmail.com> writes:

> This is v3 of the patch series posted in [1] and [2]. Note that this
> is the first fully-featured patch series implementing all desired
> functionality, including (V)LDMXCSR and VSIB-based instructions like
> VGATHER*.
>
> While implementing the last bits required in order to support VGATHERx
> instructions, I ran into problems which required a larger redesign;
> namely, there are no more !emit blocks as their functionality is now
> implemented in regular !constraints blocks. Also, memory constraints
> are specified in !memory blocks, similarly to other architectures.
>
> I tested these changes on my machine; both master and slave modes work
> in both 32-bit and 64-bit modes.

Two things I've noticed:

  ./contrib/generate_all.sh -n 1 x86.risu testcases.x86

takes a very long time. I wonder if this is a consequence of constantly
needing to re-query the random number generator?

The other is:

  set -x RISU ./build/i686-linux-gnu/risu
  ./contrib/record_traces.sh testcases.x86/*.risu.bin

fails on the first trace when validating the playback. Might want to
check why that is.

>
> Cheers,
>  -Jan
>
> Changes since v2:
>   Too many to be listed individually; this patch series might be
>   better reviewed on its own.
>
> References:
>   1. https://lists.nongnu.org/archive/html/qemu-devel/2019-06/msg04123.ht=
ml
>   2. https://lists.nongnu.org/archive/html/qemu-devel/2019-07/msg00001.ht=
ml
>
> Jan Bobek (18):
>   risugen_common: add helper functions insnv, randint
>   risugen_common: split eval_with_fields into extract_fields and
>     eval_block
>   risugen_x86_asm: add module
>   risugen_x86_constraints: add module
>   risugen_x86_memory: add module
>   risugen_x86: add module
>   risugen: allow all byte-aligned instructions
>   risugen: add command-line flag --x86_64
>   risugen: add --xfeatures option for x86
>   x86.risu: add MMX instructions
>   x86.risu: add SSE instructions
>   x86.risu: add SSE2 instructions
>   x86.risu: add SSE3 instructions
>   x86.risu: add SSSE3 instructions
>   x86.risu: add SSE4.1 and SSE4.2 instructions
>   x86.risu: add AES and PCLMULQDQ instructions
>   x86.risu: add AVX instructions
>   x86.risu: add AVX2 instructions
>
>  risugen                    |   27 +-
>  risugen_arm.pm             |    6 +-
>  risugen_common.pm          |  117 +-
>  risugen_m68k.pm            |    3 +-
>  risugen_ppc64.pm           |    6 +-
>  risugen_x86.pm             |  518 +++++
>  risugen_x86_asm.pm         |  918 ++++++++
>  risugen_x86_constraints.pm |  154 ++
>  risugen_x86_memory.pm      |   87 +
>  x86.risu                   | 4499 ++++++++++++++++++++++++++++++++++++
>  10 files changed, 6293 insertions(+), 42 deletions(-)
>  create mode 100644 risugen_x86.pm
>  create mode 100644 risugen_x86_asm.pm
>  create mode 100644 risugen_x86_constraints.pm
>  create mode 100644 risugen_x86_memory.pm
>  create mode 100644 x86.risu


--
Alex Benn=C3=A9e

