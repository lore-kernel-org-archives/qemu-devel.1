Return-Path: <SRS0=TwS2=YA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEC3BC47404
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 15:54:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76B2720679
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 15:54:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aaTWjo0y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76B2720679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46580 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHVKy-0007h9-AE
	for qemu-devel@archiver.kernel.org; Mon, 07 Oct 2019 11:54:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49642)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iHV16-0006UN-Fo
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 11:33:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iHV14-0006t3-44
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 11:33:44 -0400
Received: from mail-oi1-x236.google.com ([2607:f8b0:4864:20::236]:43057)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iHV13-0006sg-UI
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 11:33:42 -0400
Received: by mail-oi1-x236.google.com with SMTP id t84so12005773oih.10
 for <qemu-devel@nongnu.org>; Mon, 07 Oct 2019 08:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=z8FexeoxTTHKVSERg5hYydl14PJV/sYXDObhnDThLfc=;
 b=aaTWjo0yjkNpLdNyOFtw1zVNmswEJkBOz0yXZ+63EZrLsZ3VS2A2AYmTjdsicrdDFa
 t2WK5Vphhx96qB/tNhBIQsCi58Vx8pTVlnBpmBtT1k1kA842ezShEloW7tFWXiqLi1m6
 h4zOraOVsbfPbtXDevUlGxcUoS6gfhbGVM0tNiJM13GHYFJ5K4w+U6V8GGAbQ662c3AG
 gk9yisfrwlI9BVDBWTZuY6JbgCadWy/xIe36KNH/b8k/Kr5zqjS9RM6QTvX9RSUfPtOn
 LKs0Vo5IRosDgjXxV4T+iVmiA3rZPxnylYCCR5hM0bbDJDpHtimX0bTG/UkpqkYBSKWv
 wMNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=z8FexeoxTTHKVSERg5hYydl14PJV/sYXDObhnDThLfc=;
 b=ntNyYBnfRTYcqTrhDk9AKCPLYFAd1b3OjtiVaNHZffcEDgCadkPeOn4Pn1FxlJHZI6
 4+VAa5MwcvZbXKmhhtjQih1HCn6Ty3QjW6knOAUQ+KeX2Io7nzopQ1syrNJwoj/Rzszn
 x3yyJhlrsqnQ6BOsLf4rp8YqBwIN8mrINmNSfKFAGRtB/J2UMX7wDGgtTze6XRTOSvWd
 XdOVylc1CdDxaVcl5x2++oc50zupar9LtJQJLI4fNh2v0tLE6EE+TolGs3Vh2OfFswl7
 6CoOk36O6fTzAElJ/zHWAVJyS0HckTqrAv6goVvQKY5EPauWECEjZu+0M5Q43EUo3ilF
 gZuQ==
X-Gm-Message-State: APjAAAXPWeekNRZEpGH/BzTgifZUc5/Fp+eu0tkYDgRvKaHVOuPqOLX+
 fFuTMHdoLZxqQHY5y6rfoltaVN/kpcTg6p8a7ESnUQ==
X-Google-Smtp-Source: APXvYqyB0UUQb8jFO/dTvsspIXZLP/IWGbAR/PgznW3FH9uRJZO207nx5/ctAnW+O2XafbuQl5hlHwsfz36Q28bmWr8=
X-Received: by 2002:aca:f54d:: with SMTP id t74mr19282692oih.170.1570462419974; 
 Mon, 07 Oct 2019 08:33:39 -0700 (PDT)
MIME-Version: 1.0
References: <20191004095959.22891-1-kwolf@redhat.com>
In-Reply-To: <20191004095959.22891-1-kwolf@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 7 Oct 2019 16:33:29 +0100
Message-ID: <CAFEAcA-pr2NV=U_jAj3-MxGZ5Drk+Exk2ADWu5keMDvm=_akCg@mail.gmail.com>
Subject: Re: [PULL v3 0/4] Block layer patches
To: Kevin Wolf <kwolf@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::236
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

On Fri, 4 Oct 2019 at 11:00, Kevin Wolf <kwolf@redhat.com> wrote:
>
> The following changes since commit 4f59102571fce49af180cfc6d4cdd2b5df7bdb14:
>
>   Merge remote-tracking branch 'remotes/amarkovic/tags/mips-queue-oct-01-2019' into staging (2019-10-01 16:21:42 +0100)
>
> are available in the Git repository at:
>
>   git://repo.or.cz/qemu/kevin.git tags/for-upstream
>
> for you to fetch changes up to 7e693a0500455edab21754573c32b7146138cffd:
>
>   iotests: Remove Python 2 compatibility code (2019-10-04 11:59:16 +0200)
>
> ----------------------------------------------------------------
> Block layer patches:
>
> - Fix internal snapshots with typical -blockdev setups
> - iotests: Require Python 3.6 or later
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.2
for any user-visible changes.

-- PMM

