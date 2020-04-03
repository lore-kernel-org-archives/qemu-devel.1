Return-Path: <SRS0=URa6=5T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 413EFC43331
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 15:19:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 091772077D
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 15:19:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WL/rGE9G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 091772077D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56938 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jKO6n-0002i6-0w
	for qemu-devel@archiver.kernel.org; Fri, 03 Apr 2020 11:19:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51602)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jKO60-0002B2-NY
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 11:19:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jKO5z-0002Bv-8D
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 11:19:00 -0400
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335]:34665)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jKO5z-0002Ah-2I
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 11:18:59 -0400
Received: by mail-ot1-x335.google.com with SMTP id m2so7642190otr.1
 for <qemu-devel@nongnu.org>; Fri, 03 Apr 2020 08:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=8ZojjBTYrOCSgzPJKFsg3b9AiIVioMScHBWdCBtfOTY=;
 b=WL/rGE9GZy4k1cJcnRrLHkqM+SuUE26DP2xSVxgwxFm/+CSuYPUx8vimwDz/onMT8Q
 lWa5BSBT5OLG0dXzrkdzE2fuLbx1PhhbsL3u3nbG3+tYXRGflNpu+Et3MwH50/r/qflZ
 AN7A40nPFK7spllxSAixq28rD8VxQkEb/7jSmqswUBWWoL/sxwzLqAvimWoMImzcg+fH
 p6JmTrHYDEHtXyQu6razlKT8dNrm+IsRELuBifLFyu7QSennR0vH7R8Sb5/wAfZoWl5s
 msA9uy7c4OO5YJKYRtJ8Ei/OhU99JKcCiKByT4jcgiaKjny2tSMRMrvJQfyRcwCI49UD
 fh5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=8ZojjBTYrOCSgzPJKFsg3b9AiIVioMScHBWdCBtfOTY=;
 b=ob2kSR1yR+VBF41WP64Xcvjofet8rJuxJymfTxSkqXDitWKJXKvMMhsTsDwGBTMxnR
 zKwT9VTrT0PIA7zB6Yb6WbbNpMHV/nVXZdyvmfw04QKmMcuzOggxzS9fwOXD8GQb5wcK
 9V8d3eKexNNBryVbUmi0kVASAECxyKs3FDUKYVbjw+VRakx9Zw7D7Wy6yEhcAUZO2c/k
 CqF4BgPiWsvTI9RIYvFcLu37c30ON+62n9T7mhxk0o/ghrdng+zRxadRxGHI75ffBHgq
 KXXU2eZCcyXZPctoqr/bnPbods+p/57iAxlZGx5Ots3yADzeLf8ZOZcddT+elj9XBLts
 rLew==
X-Gm-Message-State: AGi0PuZ2+7uDMuzPEFHFsP1SzjMq4n3t9LBSXbPEsmwZlArhEagZa4Zr
 X2DZJZFZKlFXPvHt5S7mM2kDP1RFUOJGziOfuTSvyA==
X-Google-Smtp-Source: APiQypKU4bSpofjB746SvjZQh3YzxREuxDLSJBNWV8j+U9PNmed3gyWvHbHNEgBVudut7xxG4x/kp5j59oKkwQxTlOI=
X-Received: by 2002:a4a:d1a5:: with SMTP id z5mr7112913oor.63.1585927137887;
 Fri, 03 Apr 2020 08:18:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200403115209.145810-1-stefanha@redhat.com>
In-Reply-To: <20200403115209.145810-1-stefanha@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 3 Apr 2020 16:18:46 +0100
Message-ID: <CAFEAcA-cX7_9uVqNtJ34bRmbk9eM2_zR5yGZAv3DVFN34Uya2A@mail.gmail.com>
Subject: Re: [PULL for-5.0 0/1] Block patches
To: Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::335
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 3 Apr 2020 at 12:52, Stefan Hajnoczi <stefanha@redhat.com> wrote:
>
> The following changes since commit 5142ca078d1cbc0f77b0f385d28cdb3e504e62bd:
>
>   Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into staging (2020-04-02 20:18:25 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/stefanha/qemu.git tags/block-pull-request
>
> for you to fetch changes up to ae60ab7eb20715fa63cca1b0bb4493e160da51ce:
>
>   aio-posix: fix test-aio /aio/event/wait with fdmon-io_uring (2020-04-03 12:42:40 +0100)
>
> ----------------------------------------------------------------
> Pull request
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.0
for any user-visible changes.

-- PMM

