Return-Path: <SRS0=U3m5=5X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53B3DC2BA80
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 19:55:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14B4D20730
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 19:55:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hS/YKWtZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14B4D20730
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52686 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLuJp-0004s2-6W
	for qemu-devel@archiver.kernel.org; Tue, 07 Apr 2020 15:55:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53057)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jLuJC-0004JR-My
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 15:54:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jLuJB-00086u-En
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 15:54:54 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:34924)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jLuJB-00086j-9e
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 15:54:53 -0400
Received: by mail-ot1-x344.google.com with SMTP id v2so4478262oto.2
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2020 12:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=+cMyA6Gct0CvWZdUNp+nw9dwzd1U2yl925v646NhQ5Y=;
 b=hS/YKWtZlEMQdgm3MimJ2inieiAkSG05cFiuGfs5DYq/zsiB0AIi0S1SVBqnvkKpUx
 XvHi6yY3PxFKIRfEzvGSD1XTg3gOXvM/fcoEGepg5V71Re+OefbyeWCAhryut2sIGUMQ
 My39vV42qXGc+8nLRzNCcNMJao0TxeXNGeqwLQvATfGLOGZS3OLY85IgLyi1NvPL4Tar
 NNRkWh0QH4+iChDdq6nzAmaX2Fbhc25qP31JFV4L8DLJfk5KiZVawqeMNnplSfrp7Vwy
 jJOEPic4unKM53ttdaNg2/Sx60Rx1GH3ENAdkkwvMgtkvYC1RGFDKKnj6laT+nUxddsZ
 FOfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=+cMyA6Gct0CvWZdUNp+nw9dwzd1U2yl925v646NhQ5Y=;
 b=UX8uG/NHmOb50dUVXNSwREFBsOGmUGWwtSBzCQOgQF6tOj4jATC/Zjp9R/unEp/BXr
 qN7EfIA/dwbWpleavjWYwjhCGxTV02Vrdj5HlENfORTDibkdgVj6KNCRuIu6w9H4lp7/
 KqVrBYW8kWK4ZxkGQrdnSIGWTz0mXEuwSKiqSyBVD4HrimGqjTbUioH7Crs45MwA9UFb
 yI2XbE1ZHtNaARgrxYb37lCkPYN+LLbbsS8abuQBaCc6Q0NS4HBlqs/buc4thqMJZShG
 ZFP9GTvjchfnNfL31jZoeT1N2akhjS7wKjssWkeUQ7AvAsabzY9JjI1d7EheaJmpzJSJ
 xVVg==
X-Gm-Message-State: AGi0PuZoCExrbDYLCw4guk7lbREbZBckngyHMix2Q4T+18FPMv2o5Sw+
 qkiwJ8xmLyeBGltdjWQu3rdMAQzDx1V8wTVrd0W5GA==
X-Google-Smtp-Source: APiQypJ6ApckKDWQbw5CXptp7t/Wg6j7g6tUd1VjvQgyBVX9MI+QMBG7xq7U3qGndCP14+KlZ9qvumsHb/QCdPzF/rg=
X-Received: by 2002:a05:6830:11d5:: with SMTP id
 v21mr3043832otq.91.1586289292395; 
 Tue, 07 Apr 2020 12:54:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200407142616.7961-1-kwolf@redhat.com>
In-Reply-To: <20200407142616.7961-1-kwolf@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 7 Apr 2020 20:54:40 +0100
Message-ID: <CAFEAcA8S00kRhEBrHKRNc9Yd-ptZuz_usepdScOGW3x3X_RdqA@mail.gmail.com>
Subject: Re: [PULL 0/7] Block layer patches
To: Kevin Wolf <kwolf@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 7 Apr 2020 at 15:26, Kevin Wolf <kwolf@redhat.com> wrote:
>
> The following changes since commit 53ef8a92eb04ee19640f5aad3bff36cd4a36c250:
>
>   Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20200406' into staging (2020-04-06 12:36:45 +0100)
>
> are available in the Git repository at:
>
>   git://repo.or.cz/qemu/kevin.git tags/for-upstream
>
> for you to fetch changes up to 3f6de653b946fe849330208becf79d6af7e876cb:
>
>   vpc: Don't round up already aligned BAT sizes (2020-04-07 15:42:08 +0200)
>
> ----------------------------------------------------------------
> Block layer patches:
>
> - Fix crashes and hangs related to iothreads, bdrv_drain and block jobs:
>     - Fix some AIO context locking in jobs
>     - Fix blk->in_flight during blk_wait_while_drained()
> - vpc: Don't round up already aligned BAT sizes
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.0
for any user-visible changes.

-- PMM

