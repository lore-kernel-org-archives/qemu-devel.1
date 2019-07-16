Return-Path: <SRS0=+QfZ=VN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E92BC76188
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 10:51:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CC372053B
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 10:51:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qmYUCaQl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CC372053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47142 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnL30-0000Mo-En
	for qemu-devel@archiver.kernel.org; Tue, 16 Jul 2019 06:51:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55192)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hnL2p-0008Pl-G9
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 06:50:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hnL2o-00062e-EV
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 06:50:51 -0400
Received: from mail-oi1-x22f.google.com ([2607:f8b0:4864:20::22f]:40873)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hnL2o-00061d-5q
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 06:50:50 -0400
Received: by mail-oi1-x22f.google.com with SMTP id w196so15172394oie.7
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2019 03:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=dEKFRHZejZhRAEulMlcp1C11W1rB+G3tV/OZCo9DDKI=;
 b=qmYUCaQlkWJJxNEB78hw9A/PW4b1b+1rDdmRZjBxxLPKNF5U8ehYU+CPi+gysOrNOh
 eAp0LmMX00mnU09GLptZSQyO89yHMC3LPjG4EKnvp7gM3UGFgF32eQLnkK3rhdyM2Ntt
 uj4xHlSIoh6KUyZFcWfbosijHAQkOlk524iYU9IQPiZ7xMTrkugBir6RD3knUTtn154A
 vWkL3+2TJJCjVgwH/E4HEjy/AcIFc+jKX/WB/MZ8Vf/x/Zb96t+ys2ShwRL5wfpcwuXD
 j5XfgOe9dGERz2jkpSUhipqGGdZZ8O8fGWZmvksWd9acpNYlYLgGCTtVK/Tq/71V2Uce
 jfQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=dEKFRHZejZhRAEulMlcp1C11W1rB+G3tV/OZCo9DDKI=;
 b=GLwbesrmP3AuBl/Ka0svWkj1mCyPPSYkOZI1RRwKEbbA2vg54ljOJi4ibC9sSusRJ1
 KnyOlMuNAyPXzcohoLbCWvEFSiptAJyO4uLMkjn3U+UDtVBRPoITYVbar9/v9pXfI+ZD
 cnNE77i1OsQKqEKWrFm19+1rJ874DAi0RjTYUziM0akahgAEXg2rrtteMZsJxGPs7kD2
 Fn8e8M/no6a+Uei4NK1jq0PgnkZ6UFU0O0tHDgohKq9XUwmJqQHds2M1kA3o+XHsQ3iR
 v5yH+4PlcvFL4r5SbVkJJQOb3WFBS0+86vBAriLbzf+atCNxgvOoO7dEFsZWgkKPrPPN
 SWig==
X-Gm-Message-State: APjAAAXbYcdjtsGbE5/voWo7xBFK2B004gCDsxqQsze6Fu+B4tvAogRY
 oYr+jfzbASWgHi3Yqjd4KT+Wkr5R2eRpY5jpHLqEjg==
X-Google-Smtp-Source: APXvYqwnvbNCAq2QhZJjd9M0jo8L/8LLt6Ps7/SUkjqZ4OrSWE/k6YosQmFy12FaEfx4GZ+gxeSCOeMcO4XRZVSfdBw=
X-Received: by 2002:aca:ac48:: with SMTP id v69mr15497448oie.48.1563274247996; 
 Tue, 16 Jul 2019 03:50:47 -0700 (PDT)
MIME-Version: 1.0
References: <1563222562-2755-1-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1563222562-2755-1-git-send-email-aleksandar.markovic@rt-rk.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Jul 2019 11:50:37 +0100
Message-ID: <CAFEAcA_XSZmXuABG1Jq6Rx0TaUtY9c_6xPkUHmDdtZU+nkZnFg@mail.gmail.com>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::22f
Subject: Re: [Qemu-devel] [PULL 0/3] MIPS queue for July 15th, 2019
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
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 15 Jul 2019 at 21:29, Aleksandar Markovic
<aleksandar.markovic@rt-rk.com> wrote:
>
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
>
> The following changes since commit 5ea8ec2fcf57cb9af24ad2cf17b4d64adb03afdf:
>
>   Merge remote-tracking branch 'remotes/maxreitz/tags/pull-block-2019-07-15' into staging (2019-07-15 16:11:47 +0100)
>
> are available in the git repository at:
>
>   https://github.com/AMarkovic/qemu tags/mips-queue-jul-15-2019
>
> for you to fetch changes up to 0d0304f2c4967c892a3216638fc4cb078afa2b44:
>
>   target/mips: Add missing 'break' for certain cases of MTTR handling (2019-07-15 22:22:05 +0200)
>
> ----------------------------------------------------------------
>
> MIPS queue for July 15th, 2019
>
> Notes:
>
>   - two patches from the serieas 'MIPS fixes for 4.1' did not get
>   reviewed on time to be included for 4.1 rc1, so they are left
>   possibly for 4.1 rc2
>
> Highlights:
>
>   - fixes for missing 'break' in switch statements


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.1
for any user-visible changes.

-- PMM

