Return-Path: <SRS0=ZVNi=XW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B590C4360C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 16:46:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE4B6207E0
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 16:46:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rSj3u1df"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE4B6207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53532 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDtNw-0002VT-Jv
	for qemu-devel@archiver.kernel.org; Fri, 27 Sep 2019 12:46:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51340)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iDrT0-0002nx-4q
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 10:43:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iDrSy-0008Cn-S4
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 10:43:29 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:39269)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iDrSy-0008Cj-MI
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 10:43:28 -0400
Received: by mail-oi1-x241.google.com with SMTP id w144so5400392oia.6
 for <qemu-devel@nongnu.org>; Fri, 27 Sep 2019 07:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=PR/cuSkpFNsE9HTjNaJ/eiyMiny+wW2GXOgwyGaTx+M=;
 b=rSj3u1dfqWtremJEcWt5E5dgGjPVQIoZ7+I2/yiWOGgWo7gBwhwqJPpSq0gs2pj1/w
 3xigTc2Hm7keA2DJDNcsaC5eOLWw/fvOsHA0pbdMCoB2h0t1ZBRCSr/O12cqu0+aSWQ7
 o6OuNqlVXcM8jq1/mphsPT5Vbpp0m7HL4oWDlf/7U59Vxs7sg3gV74ra6wlkEOxoBE5Y
 6sEptp57C5TNssyIotgLYUWuh6Q+G8GIN5sY1yAco69Yq+pDjZtvd0ioZ4H0i7UM9322
 lSi6Dd1oOOVdwUsOZCLDzVTuV2+ol2wwW0vOxALt/xas4WHbKvSIv5CPWPzTLRAGtfmh
 yDdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=PR/cuSkpFNsE9HTjNaJ/eiyMiny+wW2GXOgwyGaTx+M=;
 b=NdZUHeKvBiGBBGgaogf0yOFRoD/gko85z/FrFo+ieAQnshBX9wdVtHXOfrCCPvr9eX
 vw8Y0GsjOTpaE/LKvbKzNp5/cpDPNc9eAAaFaq5b7fJdkHG5ZYOHoG1D0DUHOY56poKB
 nXWB5GyEqqpemT0+s0JfHQmbRiRZqR+Q0Tp8zQmjnA/3XLVp6WGNYgZQOlrlsWRVOvUZ
 j/qUzg13uYEPyIXJ8dZSInCfdCwgLShV0/sDOLJb53p/Nwxx0sA/QxKv7aekUJ93JOVI
 pz28YF1sJRFw3zeGFnNQhyvHAs4aHjyQp+uhVOvH22DICB+GXKPFZ0ePQLO1sj5uljqa
 uJiA==
X-Gm-Message-State: APjAAAWAFY2fHQqWbyDbCHaHHfZZxigutYNnWcQyaIGqq4xdFKQCNs99
 MLFAkI9MLTzOsUOUIlH30VTgWGLRfruxw1jx4tkwww==
X-Google-Smtp-Source: APXvYqwPfjfwp8lFiPyV8HmPX/KvR/R5h7aSTGG52TWcyGoZYMCaEhWeB/ND8+AS2TipCP0L72d7D+vgw1kqIbI687c=
X-Received: by 2002:aca:50d8:: with SMTP id e207mr6948460oib.48.1569595407816; 
 Fri, 27 Sep 2019 07:43:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190925184548.30673-1-richard.henderson@linaro.org>
In-Reply-To: <20190925184548.30673-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 27 Sep 2019 15:43:16 +0100
Message-ID: <CAFEAcA_=uCTL5jSJFMvALKRSy2rrNq00ighm6z1zD8jxwUFMUw@mail.gmail.com>
Subject: Re: [PULL 00/16] tcg patch queue
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::241
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

On Wed, 25 Sep 2019 at 19:45, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> This is v4 of my notdirty + rom patch set with two suggested name
> changes (qemu_build_not_reached, TLB_DISCARD_WRITE) from David and Alex.
>
>
> r~
>
>
> The following changes since commit 240ab11fb72049d6373cbbec8d788f8e411a00bc:
>
>   Merge remote-tracking branch 'remotes/aperard/tags/pull-xen-20190924' into staging (2019-09-24 15:36:31 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/rth7680/qemu.git tags/pull-tcg-20190925
>
> for you to fetch changes up to ae57db63acf5a0399232f852acc5c1d83ef63400:
>
>   cputlb: Pass retaddr to tb_check_watchpoint (2019-09-25 10:56:28 -0700)
>
> ----------------------------------------------------------------
> Fixes for TLB_BSWAP
> Coversion of NOTDIRTY and ROM handling to cputlb
> Followup cleanups to cputlb
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.2
for any user-visible changes.

-- PMM

