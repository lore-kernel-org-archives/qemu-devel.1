Return-Path: <SRS0=S/IU=TU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1461DC04AAC
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 10:38:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8AB22081C
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 10:38:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XJ4yyR7+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8AB22081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33128 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSfgy-0000Mv-4K
	for qemu-devel@archiver.kernel.org; Mon, 20 May 2019 06:38:52 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41095)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hSffn-0008Js-F7
	for qemu-devel@nongnu.org; Mon, 20 May 2019 06:37:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hSffm-0003e0-BD
	for qemu-devel@nongnu.org; Mon, 20 May 2019 06:37:39 -0400
Received: from mail-oi1-x236.google.com ([2607:f8b0:4864:20::236]:40545)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hSffm-0003dU-1V
	for qemu-devel@nongnu.org; Mon, 20 May 2019 06:37:38 -0400
Received: by mail-oi1-x236.google.com with SMTP id r136so9587727oie.7
	for <qemu-devel@nongnu.org>; Mon, 20 May 2019 03:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=y6ww3BpOqAFjA5HT8Sb2H4u/K8a7afEpCYZW/QtnIyw=;
	b=XJ4yyR7+QjTfVR2mnZIQaANopBrDZ791DVNWnnxXiXIA6fkrkLYWJJPj/G0sJQZvVL
	JYZ57zrGAGfgGwy7LsnonwYLNTqZ9tgszPa8OM1mh4B43sP4zdirGTGd7tmljVZV1tmR
	BWlaKYyybm3vFQc0NsXePAe1JcPw2aww0criI1kAAtLMDppg8SwIPoOSqo1GNFmgm9PY
	0p5gef62NR13CuxHT9Ubo0CMZn59bS/IAcoAZj8XoB/2mg1z6c+mkET1Z/eriQe99Mz5
	AOz5Yf/jSsaZrRcHeRgOOu8GJAeq1VV45dNSJ+3nbFma0rH7POPK4UjGATdQUq6p9X+u
	JjHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=y6ww3BpOqAFjA5HT8Sb2H4u/K8a7afEpCYZW/QtnIyw=;
	b=Mq0Z4kaFZ5DtH7ncxaPYXC2jVFidcapywoseRgiIuqz525UVHeWd/urq51q9qqDOUy
	fbRQJlndJPjrKMbLPIghFo1xG0HULQBMmfFY+gAYaJNC4dLlqPHyYH0UBGAd2cJVZBzb
	QnqSCrftcjmfcCCGlMfUUJSSkMSUa7Zic/2gxXWVBJ0xoyySJMJP0k0yo51rTzqOKK5Q
	OeQVSwmbj6pM6dLeWzi8DYXVbiAHyxBxXmc0Pa05XPXq6rv+JRfV/cxOZtwGeKWoO2z2
	Y79s6LZ3CqkQQaoDLH+A65lZsmFV37DAD9UGL5rDfxDg/M29CrOZ4IsJwq5yLfyMBe7H
	dWCQ==
X-Gm-Message-State: APjAAAWx2sKZZXnrduKhuN/oq35mAa4HvqA9WPmCjy176YENzIjSCpLX
	KpyJyQjqznTXnxvEWASMF9i2Y2ztcnxO71RSNf8Aqw==
X-Google-Smtp-Source: APXvYqynb8ZZwlZ4mY+fJStrlooKNCNM3RAA2yQyEJs7wZbRiya804mMIJ0HN15ijIEAs2wSOSmMluGSqcYfx6XjXhc=
X-Received: by 2002:aca:4e42:: with SMTP id c63mr22703967oib.170.1558348655903;
	Mon, 20 May 2019 03:37:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190517183240.689188-1-groug@kaod.org>
In-Reply-To: <20190517183240.689188-1-groug@kaod.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 May 2019 11:37:24 +0100
Message-ID: <CAFEAcA8Xy5mTtBXdj71TMeTeipNVyzG5pX+VuU3NRYncVc7fwA@mail.gmail.com>
To: Greg Kurz <groug@kaod.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::236
Subject: Re: [Qemu-devel] [PULL 0/6] 9p patches 2019-05-17
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 17 May 2019 at 19:32, Greg Kurz <groug@kaod.org> wrote:
>
> The following changes since commit f2a930ad8c433c5583e28ec803c8ca7cb2f31ab5:
>
>   Merge remote-tracking branch 'remotes/mcayland/tags/qemu-sparc-20190517' into staging (2019-05-17 15:46:37 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/gkurz/qemu.git tags/for-upstream
>
> for you to fetch changes up to b44a6b09705e9e8a3005229b58de36d176020548:
>
>   virtfs: Fix documentation of -fsdev and -virtfs (2019-05-17 17:34:49 +0200)
>
> ----------------------------------------------------------------
> This fixes the virtfs documentation (LP 1581976), deprecates the
> -virtfs_synth command line option, along with some assorted cleanups.
>
> ----------------------------------------------------------------
> Greg Kurz (6):
>       fsdev: Drop unused extern declaration
>       fsdev: Drop unused opaque field
>       fsdev: Move some types definition to qemu-fsdev.c
>       fsdev: Error out when unsupported option is passed
>       vl: Deprecate -virtfs_synth
>       virtfs: Fix documentation of -fsdev and -virtfs


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.1
for any user-visible changes.

-- PMM

