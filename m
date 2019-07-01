Return-Path: <SRS0=a9ZG=U6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12087C0650E
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 15:26:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD7A1208CA
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 15:26:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HyQDFToD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD7A1208CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59994 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hhyCh-0003Xe-3d
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 11:26:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33313)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hhxiU-00088k-Qp
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 10:55:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hhxiS-0004QO-Vy
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 10:55:38 -0400
Received: from mail-ot1-x332.google.com ([2607:f8b0:4864:20::332]:36428)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hhxiS-0004O7-Pn
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 10:55:36 -0400
Received: by mail-ot1-x332.google.com with SMTP id r6so13784676oti.3
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2019 07:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Z/otzHT33VhOaGIOyJ54BREa7L+FexIFfj+UQBsJHW0=;
 b=HyQDFToDG8+FcoH9pH915aR607kHIx862+m78SqHRvBTyZeCfwVZnws43FOAJMm5jy
 nOvnzO9BfwqfMA291J/mxt9KLJPPDIVAbVdvdeTPtNbuRZJaVJb/vJHZGaWZ/zI6iQT2
 LYZQbwj8X/TTgI3evLG5J+VjdruvRH4ZOZKOESJmqod+2sgVC2SPkoN928Gd7hSq6atF
 4wCxdDHChVR/odkzZEW4tazgn9wXIMd3E4Lz0cwk7t4mMhHDRSQWe6KQ5k+c4PlXipIu
 i9DAP90FhuKmcrQ4Ce1hEJeW5nnE8sZ9a3nLtEhf4G30tX1t464a+L4/ld3UPiBOsx7C
 prdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Z/otzHT33VhOaGIOyJ54BREa7L+FexIFfj+UQBsJHW0=;
 b=W4bwpKGtRzw1+H7R8FY4SLOBlaRJiQr1KOxo0wKJhNhUiE1zby8GQUarWpQ10BtLTV
 dhi8RRUGtLwCJrWNJb0KretpyI4M/fA6FWSV/XzyDtiDZvxaRmZhP+x5j6/pzK6qpnOD
 fuxJjf9ePmI6jYnSgAqTbEur3oAPLHAULNXaHwIYXUwP5jHN36AHDuK42CwqD+gzIpMp
 kdGoD7N0EWTThPu0YCjDTEe2MDZzptihWbuuHzXWU31dvpzfTkTxEtTsBesyb642k7a1
 D1PPzNFCQPdrsfV/VefkxjdGSZJgBhjkbS3CZ53oqybN9hjjmH2jfrHaOCgW54xA+8cS
 Gthg==
X-Gm-Message-State: APjAAAXW5DAmdzhIDEuFqQCCi4T8GNklD7+01c/1XqN7PVcyRM4dapKw
 CVwGABRO2G553cL/7o3t5C/dvOe5hx1EGjQe+n5MqA==
X-Google-Smtp-Source: APXvYqzTtkXL2Ndv9xWnQP9huItJTbYQ60DpEzphRJ9TkRIYkJxLptIF7r6vNAui/GAllT2Wh8VYt1QXUJppQKdcfxg=
X-Received: by 2002:a9d:6a0f:: with SMTP id g15mr20879599otn.135.1561992933324; 
 Mon, 01 Jul 2019 07:55:33 -0700 (PDT)
MIME-Version: 1.0
References: <1561549550-3501-1-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1561549550-3501-1-git-send-email-aleksandar.markovic@rt-rk.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 1 Jul 2019 15:55:22 +0100
Message-ID: <CAFEAcA-9Jo0Txvuxtry-DtAHrY=gW=7YpkSpwctCJoZb990iYg@mail.gmail.com>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::332
Subject: Re: [Qemu-devel] [PULL 00/17] MIPS queue for June 2016th, 2019
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

On Wed, 26 Jun 2019 at 12:45, Aleksandar Markovic
<aleksandar.markovic@rt-rk.com> wrote:
>
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
>
> The following changes since commit 474f3938d79ab36b9231c9ad3b5a9314c2aeacde:
>
>   Merge remote-tracking branch 'remotes/amarkovic/tags/mips-queue-jun-21-2019' into staging (2019-06-21 15:40:50 +0100)
>
> are available in the git repository at:
>
>   https://github.com/AMarkovic/qemu tags/mips-queue-jun-26-2019
>
> for you to fetch changes up to 5a6a1fabfcbbdf7808aaa8e906fee86ed6eb37e7:
>
>   target/mips: Fix big endian host behavior for interleave MSA instructions (2019-06-26 13:25:56 +0200)
>
> ----------------------------------------------------------------
>
> MIPS queue for June 2016th, 2019
>
> Note:
>
>   - seven checkpatch warnings on updating MAINTAINERS can be ignored
>
> Highlights:
>
>   - cleanups and fixes for Malta's gt64xxx PCI controller
>   - cleanups and fixes for Jazz'src4030 DMA controller
>   - improvements of MSA TCG tests
>   - fix for big endian host interleave instructions behavior
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.1
for any user-visible changes.

-- PMM

