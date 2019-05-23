Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ECA0C282DE
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 08:27:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62CEB20868
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 08:27:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mpH3i2CU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62CEB20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59726 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTj4F-0003uc-Af
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 04:27:15 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47638)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.m.mail@gmail.com>) id 1hTj2Q-0002Ef-Gs
	for qemu-devel@nongnu.org; Thu, 23 May 2019 04:25:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.m.mail@gmail.com>) id 1hTivA-0001xA-TO
	for qemu-devel@nongnu.org; Thu, 23 May 2019 04:17:54 -0400
Received: from mail-oi1-x236.google.com ([2607:f8b0:4864:20::236]:45816)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
	id 1hTiv8-0001vD-7u
	for qemu-devel@nongnu.org; Thu, 23 May 2019 04:17:51 -0400
Received: by mail-oi1-x236.google.com with SMTP id w144so3698820oie.12
	for <qemu-devel@nongnu.org>; Thu, 23 May 2019 01:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc; bh=rzEZJyqDmf7xVg8qHLD+pmzPhaiKNsJQgejt++rNI+A=;
	b=mpH3i2CUJFYobNK9q859cRWvSUc0guUbZyydhnP3x7a6i11IFaCKRu/SBiDaTENXB5
	aWCgNMLeVdI5gtVg2wiAGifmGOvnvUYalv+A/QRocObDBcZCM6BoQyBFWbNMfMDt31po
	Wp7SxdFLC9LwdzApCWrxH4YK7KarqfdC47XcrwgCNT3hAtE12bIGYQP8JIfLoIscwP1L
	ku6mhXECzx+Mpl8oZijf9R7n5jC0ipOAxQ+0rJqlw6LjbOrcvZctKHzwE/q8WB8fKQND
	NJ2xj2Cn4xTQmPxFFy7WrwC/MIG8e3XntsAVj8ON1rT/kmVzTIwI1jk13B9eoeHOHKfU
	KDfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc;
	bh=rzEZJyqDmf7xVg8qHLD+pmzPhaiKNsJQgejt++rNI+A=;
	b=p1PWP4+Z6soOdczC9v497Btm/GahOnrZYpDT9Hgo33woJWxsv/CGFI0g9KouPiHLz8
	x+RGnK7OQwNBIPBE72Xo5SihPjmVCm4By0GS3f1Qj0IBgXs6JgQNQzJHIANMTSmytMO5
	dHuJjvyYGZuopFFWVPwYTb9Z26YSYLEcsQXyyDQpZ95WMrIjqicfvjfZXgSF6ot6ddXz
	P8AtoGokkJqIZxtFOq6lETJcdA2dCBmu9dc2HlwbzFrF1/u0Hhje7eTXiKPOXpgOx0dr
	rc1j0z1rboVxm+lXyHj4n6w6a0VeWMtpF9YehihngH1BRXQxCAFW4/MS9bgO8HskN2M1
	DvYw==
X-Gm-Message-State: APjAAAXOEDAFaNmdd42R0vIEv8dCGAet+sLmMUlWSStc6YrCtPg8Qwmb
	TWzxaf2nr72LuHsS+TWbfBuj+kB76iF6AbC6o3g=
X-Google-Smtp-Source: APXvYqwfv9NQWiFz8tsJUbzbvB1hHv6HVfKZBWMm0F8w/+elHmYYYOsPCio3Ci2jvRuesZ9HBxd8xkKdKsctRnDB5C0=
X-Received: by 2002:aca:1916:: with SMTP id l22mr2009152oii.136.1558599468317; 
	Thu, 23 May 2019 01:17:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:410f:0:0:0:0:0 with HTTP; Thu, 23 May 2019 01:17:47
	-0700 (PDT)
Received: by 2002:a9d:410f:0:0:0:0:0 with HTTP; Thu, 23 May 2019 01:17:47
	-0700 (PDT)
In-Reply-To: <20190522222821.23850-1-richard.henderson@linaro.org>
References: <20190522222821.23850-1-richard.henderson@linaro.org>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Thu, 23 May 2019 10:17:47 +0200
Message-ID: <CAL1e-=jzbtrbu6OnoAJ2Z7QyTGXfek4wFN-pzhQn9GJpXxLaMw@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::236
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PULL 00/16] tcg queued patches
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
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On May 23, 2019 12:32 AM, "Richard Henderson" <richard.henderson@linaro.org=
>
wrote:
>
> The following changes since commit
a4f667b6714916683408b983cfe0a615a725775f:
>
>   Merge remote-tracking branch 'remotes/cohuck/tags/s390x-20190521-3'
into staging (2019-05-21 16:30:13 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/rth7680/qemu.git tags/pull-tcg-20190522
>
> for you to fetch changes up to 11e2bfef799024be4a08fcf6797fe0b22fb16b58:
>
>   tcg/i386: Use MOVDQA for TCG_TYPE_V128 load/store (2019-05-22 15:09:43
-0400)
>
> ----------------------------------------------------------------
> Misc gvec improvements
>
> ----------------------------------------------------------------

Why are =E2=80=9CReviewed-by:=E2=80=9D lines missing from all patches of th=
is pull request?

Regerds,
Aleksandar

> Richard Henderson (16):
>       tcg/i386: Fix dupi/dupm for avx1 and 32-bit hosts
>       tcg: Fix missing checks and clears in tcg_gen_gvec_dup_mem
>       tcg: Add support for vector bitwise select
>       tcg: Add support for vector compare select
>       tcg: Introduce do_op3_nofail for vector expansion
>       tcg: Expand vector minmax using cmp+cmpsel
>       tcg: Add TCG_OPF_NOT_PRESENT if TCG_TARGET_HAS_foo is negative
>       tcg/i386: Support vector comparison select value
>       tcg/i386: Remove expansion for missing minmax
>       tcg/i386: Use umin/umax in expanding unsigned compare
>       tcg/aarch64: Support vector bitwise select value
>       tcg/aarch64: Split up is_fimm
>       tcg/aarch64: Use MVNI in tcg_out_dupi_vec
>       tcg/aarch64: Build vector immediates with two insns
>       tcg/aarch64: Allow immediates for vector ORR and BIC
>       tcg/i386: Use MOVDQA for TCG_TYPE_V128 load/store
>
>  accel/tcg/tcg-runtime.h      |   2 +
>  tcg/aarch64/tcg-target.h     |   2 +
>  tcg/i386/tcg-target.h        |   2 +
>  tcg/tcg-op-gvec.h            |   7 +
>  tcg/tcg-op.h                 |   5 +
>  tcg/tcg-opc.h                |   5 +-
>  tcg/tcg.h                    |   2 +
>  accel/tcg/tcg-runtime-gvec.c |  14 ++
>  tcg/aarch64/tcg-target.inc.c | 371
++++++++++++++++++++++++++++++++-----------
>  tcg/i386/tcg-target.inc.c    | 169 +++++++++++++-------
>  tcg/tcg-op-gvec.c            |  71 ++++++---
>  tcg/tcg-op-vec.c             | 142 ++++++++++++++---
>  tcg/tcg.c                    |   5 +
>  tcg/README                   |  11 ++
>  14 files changed, 620 insertions(+), 188 deletions(-)
>
