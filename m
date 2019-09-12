Return-Path: <SRS0=eeqW=XH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22BCBC4CEC5
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 15:21:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DEA4A20644
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 15:20:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mBTPM75w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEA4A20644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35810 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8Qu3-0008OZ-2m
	for qemu-devel@archiver.kernel.org; Thu, 12 Sep 2019 11:20:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39259)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i8QqM-000598-1l
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 11:17:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i8QqK-0005fp-HO
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 11:17:09 -0400
Received: from mail-oi1-x233.google.com ([2607:f8b0:4864:20::233]:40501)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i8QqK-0005f3-Al
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 11:17:08 -0400
Received: by mail-oi1-x233.google.com with SMTP id b80so17399508oii.7
 for <qemu-devel@nongnu.org>; Thu, 12 Sep 2019 08:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=JKeO9rpidL4jtx0iO+kcI9hmsfQrqKZic0Vy5J3kM/c=;
 b=mBTPM75wrIMqgYP/1em8CJauuPdAvoZZK3kOv+ix+TA411R6//J940IujxOEgdfyw0
 CDgZm3+UWyf6KJzgm81e6n0FNYaWxfoIzyE2a/imFNyKlfS1lnWx3aLoMoNIPF7t8/Zt
 0r6yxTME08QDfe+zCfcmrnAN3nDWDBFNs1966ubRFMCxBUQE8HduL2jHor6UkbvouPZQ
 ed4bZhYHj3BB1atCC8kY9paqpNB81aBYQdDFk4O1x13jSHOB2KJbLOyngl282M5tj8vY
 89j9tUjSFSD6o+Go56EmtwgFETCmiup17KxkL6G5j1Idi0SblCArgAGwuhKrSIRa1Q/U
 5g/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=JKeO9rpidL4jtx0iO+kcI9hmsfQrqKZic0Vy5J3kM/c=;
 b=rI9wg2UXBFpGZWKQa922IfBZCW+X3SdH0lm7A7EREo3DpQXHqW9Yv37Mi1TZkgmqwy
 Vs1mBnENLfzCRaYYyQUpgtmPSWraRvUHXbUoqz/SEbnGgY7k9rmI3+T+VjC9PS+xwzDy
 BgdrUOeGcDE/txDQla7nv6SsrEfC0J5GPp5nG2TnbM03/dQUjH4jBlms7DShjFwHN08z
 LkNrBHaJvATZK1D+Wn/5FoYpI6zJBW4C24hDF0gqIhJJ52X6Xj1Kcy5PzSixhc5eOO2G
 tf3vZHWXFj6pqe0fcHDJ96yg7I85oZlufR4Ii7m8fuDHwaiVaInPACLhwJhr97Uny6yd
 sCUQ==
X-Gm-Message-State: APjAAAXNyELqFfha/q6KqBoRIKhgZymdPbM2JhRLrROBjbv1EmrtvCp+
 LGO/yt9kosZoYzVgjfT4Jv55oBQNoebSpwAYvWcXIw==
X-Google-Smtp-Source: APXvYqwl1UFFiJBYBlCxgs/+2sdmX4c7tCWcKuftlAkS/MYZtzkHtIYJ8/kI0MGTsCnCRtzLK64LPg/0+NuT2JbRiHQ=
X-Received: by 2002:aca:f54d:: with SMTP id t74mr580504oih.170.1568301427124; 
 Thu, 12 Sep 2019 08:17:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190910132456.26023-1-alex.bennee@linaro.org>
In-Reply-To: <20190910132456.26023-1-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 12 Sep 2019 16:16:56 +0100
Message-ID: <CAFEAcA_AfRCSkSrnijkz6mN9VHcUp482MG35oVz13SNZ1vVwkQ@mail.gmail.com>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::233
Subject: Re: [Qemu-devel] [PULL v2 00/46] testing updates (fixes, upgrades,
 caching)
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 10 Sep 2019 at 14:24, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> The following changes since commit 89ea03a7dc83ca36b670ba7f787802791fcb04=
b1:
>
>   Merge remote-tracking branch 'remotes/huth-gitlab/tags/m68k-pull-2019-0=
9-07' into staging (2019-09-09 09:48:34 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/stsquad/qemu.git tags/pull-testing-next-100919-2
>
> for you to fetch changes up to dda60da384ddbe4fc75182dd23db7e9aa4a88f46:
>
>   tests/tcg: fix typo when calling clean-tcg (2019-09-10 14:14:32 +0100)
>
> ----------------------------------------------------------------
> Testing fixes:
>
>   - podman cleanups
>   - docker.py python3 fixes (encode)
>   - DEF_TARGET_LIST applied to cross build images
>   - move a bunch to Buster based images
>   - enable Travis caching
>   - more common objs for faster builds
>   - stable URLs for acceptance tests
>   - additional travis dependencies
>   - work around ppc64abi32 linux-test breakage [v2]
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.2
for any user-visible changes.

-- PMM

