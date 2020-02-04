Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2173DC35247
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 17:08:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E08F32084E
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 17:08:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eUy7jxY5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E08F32084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34510 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iz1gz-00029P-1u
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 12:08:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52426)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iz1gP-0001ki-KR
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 12:08:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iz1gO-0007Gm-Bb
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 12:08:17 -0500
Received: from mail-ot1-x329.google.com ([2607:f8b0:4864:20::329]:45189)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iz1gO-0007F4-4r
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 12:08:16 -0500
Received: by mail-ot1-x329.google.com with SMTP id 59so17780654otp.12
 for <qemu-devel@nongnu.org>; Tue, 04 Feb 2020 09:08:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=QfbbUvjB52zPIo1FoOSpx6mRcq0uWWNEl76KNI9Cby8=;
 b=eUy7jxY5ARPqONra7A6x06/P8jqHyMNCUOd1RUhESdd/y0RGnBk4Ihb25ABwKWFTyU
 HBCQTFf1qpb+uhLeoH6BniZ6fg6zGZPTYeEigl3qtHnQwdH1NjYCHcymVivVFSJjJuMU
 V3/TTpL09D4iznmvNoTop2Ht/Dz3O8pDHSMGitKnm70YmadF7EvzUs2hk8UUYnPDyeYL
 p8T9gNYo49d04ZzhDQbXtoYX0xz/ZCE7A9dTOiyA5ddMiCi8eHyUhemodnkYMJWJLeuo
 ivIP7cVKQ6kCvQmm4bhPOkPSKbQ4zPgz2YKqg9Zo9dly/m53QXdVa82bwENhKwBK7vwK
 Su6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=QfbbUvjB52zPIo1FoOSpx6mRcq0uWWNEl76KNI9Cby8=;
 b=SnufKid1JXWoIweafHjOwtheeuTs3i/Z70bSqC8WQaKqDxpG2Z1Qtl2Xv0sE7hI++K
 3HZiettzK/M/zTi86aRxZvDSVLCkZx4Yqmr95GZLGmElp5vnvewmd04iKROn73d4ldjD
 U8lhnS+m9d95qpccBpjJK1BLbg95WkByj6oc7Ku4LGIaijyxhQn8SffypgX4yYeSS5Yu
 GxCLq0CQdBcjHI55GNmRkOd/PYYERQoh0Xco6l5E49p6igNcwJnaZQBiVkRShoiCbM5I
 +q/ZG0txr5AYOQRYQlC2CcRZFQfFS6dvT38O/ciuZheJy1dmu3hhE33eSyXDE2z9sEcy
 HMVQ==
X-Gm-Message-State: APjAAAWOsA4C3r+qMvfFOxTJGJssAdh5oCIMZ8nYvzDV3sKt8tfMjDEV
 TL4V6kRIGb1EBR9m3wFGbbgH6GVfPAovzPf8iSLjFg==
X-Google-Smtp-Source: APXvYqxRmycc6DqnWmeaX80yMCP2RuGZUO7LxxBItOFv9uBv8agzAJf6EXmEHopaz+K/2XEudMU96HQ+OUKzPcOI4Pw=
X-Received: by 2002:a05:6830:1184:: with SMTP id
 u4mr21996160otq.221.1580836095109; 
 Tue, 04 Feb 2020 09:08:15 -0800 (PST)
MIME-Version: 1.0
References: <20200204085358.17191-1-thuth@redhat.com>
In-Reply-To: <20200204085358.17191-1-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 4 Feb 2020 17:08:03 +0000
Message-ID: <CAFEAcA_dFJutDDZP4hQJ01BT4+xb+=NZLC01DUGWWFoORJRvwA@mail.gmail.com>
Subject: Re: [PULL v2 00/14] qtests, kconfig and misc patches
To: Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::329
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

On Tue, 4 Feb 2020 at 08:54, Thomas Huth <thuth@redhat.com> wrote:
>
>  Hi Peter,
>
> the following changes since commit f31160c7d1b89cfb4dd4001a23575b42141cb0ec:
>
>   Merge remote-tracking branch 'remotes/pmaydell/tags/pull-docs-20200203' into staging (2020-02-03 11:14:24 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/huth/qemu.git tags/pull-request-2020-02-04
>
> for you to fetch changes up to 4f67366e3bbe6040998be038156486eed264ea58:
>
>   configure: Fix typo of the have_afalg variable (2020-02-04 09:01:31 +0100)
>
> ----------------------------------------------------------------
> * Current qtests queue
> * Some Kconfig updates
> * Some trivial clean-ups here and there
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.0
for any user-visible changes.

-- PMM

