Return-Path: <SRS0=GiFh=S6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F57AC43219
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Apr 2019 14:55:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3671C206A3
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Apr 2019 14:55:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="V9bahf7h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3671C206A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45136 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hKlDU-0006en-If
	for qemu-devel@archiver.kernel.org; Sun, 28 Apr 2019 10:55:44 -0400
Received: from eggs.gnu.org ([209.51.188.92]:32855)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hKlBK-0005WD-Gg
	for qemu-devel@nongnu.org; Sun, 28 Apr 2019 10:53:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hKlBJ-0002ZN-AQ
	for qemu-devel@nongnu.org; Sun, 28 Apr 2019 10:53:30 -0400
Received: from mail-ot1-x32c.google.com ([2607:f8b0:4864:20::32c]:39615)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hKlBI-0002Z8-Vx
	for qemu-devel@nongnu.org; Sun, 28 Apr 2019 10:53:29 -0400
Received: by mail-ot1-x32c.google.com with SMTP id o39so6551272ota.6
	for <qemu-devel@nongnu.org>; Sun, 28 Apr 2019 07:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=knfDboze1yL9LZpqRb0mBdEU12Qtwc3mPrS6JgKVUaE=;
	b=V9bahf7hdkAcGUvj9NKKFSSI/TFm4gli8/4HPcCpqVyFjXEo9fXpK2nKX9jt9fQhwQ
	yHKp8oVCACpbz6omE837TrNBqdd31RcgvfXi1glhCpEZ45DjU1R4waYRBnqABbcE6eOc
	7fGsBO5fJdwP/pcio8GdlS9EACUqucoDPL+tY8BytfmPbFWn5AgE8wJ/IstO8Fbpgp/h
	gGXAOTjsl5b4vb+tDR34SZ7COmOsb/v7rVzh2WWtij86ohBATnX/VA5AaRsXvE5OXAfC
	MjtrzEcI185nKAGI45EIB/FDOREEACNHjTD6oP1ieMBeoA3p4qCEAKonfup/yjnySmu5
	fQNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=knfDboze1yL9LZpqRb0mBdEU12Qtwc3mPrS6JgKVUaE=;
	b=Jrljp4j1h+7epJJOm0sfKYyNyDkl3VCVjdX64B4fBDWJNzmhUjKKhFYLnbwD+tRGtt
	03J31T58qCiKO8RIVU8pbm96SRl5J0qKfccdyX/EMesiw/F8yhCqWt3Pw5gxNR72bXdo
	IA6zPO9dvp+pIyyZlIos9gy1dqyEa3PII498B6xPnvzc3WhmpZ2ZvQHK+jGm8zsDsjQ7
	37GCWlRB2/HJC1SVwW5nwaO7m0QQnDTfIY+vfu4XqvhT3NK5FtNffDHojm8wFAg86avW
	I6+anP8i9k7bw8yoEFr7eBkoxSVFBl+wuGGp88QC1+ystrZbzHsIM657tKiJI1Cm3h69
	WZYA==
X-Gm-Message-State: APjAAAVtSzVAMvPWUK55DE/bnc5lbzBLwfrBvrgMDFcqH1/1WFWcFYlH
	BqvV1avjpDvrJ15Dotl24PYuDnf5SPtYPqyZJ0u6kQ==
X-Google-Smtp-Source: APXvYqwkF8Aj5qnKOBilX5llzBsPqPAXSMSvycvhEEq7NDOytJ8PalQP9FlJ80OL2MsiSYo015I5GDbWnoPkh71bDwQ=
X-Received: by 2002:a9d:360b:: with SMTP id w11mr8918401otb.238.1556463207726; 
	Sun, 28 Apr 2019 07:53:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190426172421.27133-1-richard.henderson@linaro.org>
In-Reply-To: <20190426172421.27133-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 28 Apr 2019 15:53:16 +0100
Message-ID:
 <CAFEAcA_iXkJVSgYmkBui0-PXBXqrNFnonaxsRo7gwGNHL1e3yA@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::32c
Subject: Re: [Qemu-devel] [PULL 00/15] tcg patch queue
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
Message-ID: <20190428145316.fGk5kzq3BSK_oG8KrMyMCSBGAPWW5vcxwOO2ELNcLkM@z>

On Fri, 26 Apr 2019 at 18:24, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> The following changes since commit 3284aa128153750f14a61e8a96fd085e6f2999b6:
>
>   Merge remote-tracking branch 'remotes/lersek/tags/edk2-pull-2019-04-22' into staging (2019-04-24 13:19:41 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/rth7680/qemu.git tags/pull-tcg-20190426
>
> for you to fetch changes up to ef5dae6805cce7b59d129d801bdc5db71bcbd60d:
>
>   cputlb: Fix io_readx() to respect the access_type (2019-04-25 10:40:06 -0700)
>
> ----------------------------------------------------------------
> Add tcg_gen_extract2_*.
> Deal with overflow of TranslationBlocks.
> Respect access_type in io_readx.
>
> ----------------------------------------------------------------



Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.1
for any user-visible changes.

-- PMM

