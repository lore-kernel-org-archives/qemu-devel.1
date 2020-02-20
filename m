Return-Path: <SRS0=d4IR=4I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79187C11D0C
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 16:52:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 466E020722
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 16:52:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="a7kHzUFg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 466E020722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45982 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4p3Q-0006vD-FR
	for qemu-devel@archiver.kernel.org; Thu, 20 Feb 2020 11:52:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34044)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j4p2f-0005ry-Je
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 11:51:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j4p2e-0002BG-E8
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 11:51:13 -0500
Received: from mail-oi1-x22b.google.com ([2607:f8b0:4864:20::22b]:40863)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j4p2e-0002Af-9D
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 11:51:12 -0500
Received: by mail-oi1-x22b.google.com with SMTP id a142so28187438oii.7
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2020 08:51:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=5Dns6Pk45xv7rlyxuHgRyWUPWW6VOqNTocyA0XAIkPw=;
 b=a7kHzUFgwvnmQktSd2xaDYEq/TpQOXJ3GsWxLJrhp18W6USAJdDcs4P9KON2hzHWIL
 RPexAD/oEHsMWE1GOKziBWK3g0miAZtgHXQcZgKtW1pSgMABjQlHWOUku934nwNLi6kQ
 I+2K5K9DbTDbgoVJU/ABoxEJYaRTt++j6MFXJtwRDwkahwvXo7bq00D5ig5xZtt1PZkj
 CHe2RlHL//FqxJjxQgeXzBXTRxF0IP2+nSAhB6zr5/WeXlMtkph6hKm/Sjkovs83aVkp
 qH24p30GRNsmHMwswLY0U7lHqFt/ZHMWxpWrGi0ThIkTVkHmEQFKErAy/qxYSpE/POxg
 pdDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=5Dns6Pk45xv7rlyxuHgRyWUPWW6VOqNTocyA0XAIkPw=;
 b=LmwEVF9w1QGV0dptni6BHGImLWqk4zvjZfajvqB24DSAkUFIbwg/7YeadPP4VEDNcv
 X0vgPRhda8O71ZX5gMSDl2U7TAteOfDh6Zz/Gxv+Ja2l8OhXWc7b93vqciROdV5BA4SW
 tkjmOARIHtYXb74ovXKFocsaFbiBZW8KzPjlerZl+P60nHe61korxpQVUgnzFTjeOb9Z
 JfgFfWL9rQPMXmNpQ07DtYOC3f5ucT9LcSfIP5INsJ8I/s0O0JFyP+nQxAw7C9P2b68l
 9r6kCUy7ylQayRIjny8xZ/YhN62Rek1Q8lcAHrHGwQJtD+cefidSGlFHCJ2bUy8GezJ7
 dRBw==
X-Gm-Message-State: APjAAAUkBi+f8IfGTDJAWEnGqIinljyEp9dGPviptoF7zGTANvR5ZFnT
 aj5iLj7Yv/2ng6XgmtW+5pygCsyWvanOGF/e5mapmw==
X-Google-Smtp-Source: APXvYqwUye5cbAO9xZHW8Yusk5P/DAiS4x/LjUNA9Tei59K9/P2wDkcXWZSWeMQtdOZsuKG7uk/nbI29BUQ1MB+QVdM=
X-Received: by 2002:a05:6808:3b2:: with SMTP id
 n18mr2669734oie.146.1582217471019; 
 Thu, 20 Feb 2020 08:51:11 -0800 (PST)
MIME-Version: 1.0
References: <20200218193929.11404-1-richard.henderson@linaro.org>
In-Reply-To: <20200218193929.11404-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 20 Feb 2020 16:51:00 +0000
Message-ID: <CAFEAcA_xt6et=KKVxAJNzL9cQAqDfhWZmN0Ve1jiCD9NfJ9Skw@mail.gmail.com>
Subject: Re: [PULL 0/9] target/hppa patch queue
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::22b
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

On Tue, 18 Feb 2020 at 19:39, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> The following changes since commit 6c599282f8ab382fe59f03a6cae755b89561a7b3:
>
>   Merge remote-tracking branch 'remotes/armbru/tags/pull-monitor-2020-02-15-v2' into staging (2020-02-17 13:32:25 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/rth7680/qemu.git tags/pull-pa-20200218
>
> for you to fetch changes up to 90e94c0591687f7f788fc40ac86b5583f30d9513:
>
>   hw/hppa/dino: Do not accept accesses to registers 0x818 and 0x82c (2020-02-18 11:22:10 -0800)
>
> ----------------------------------------------------------------
> Fixes for Dino and Artist.
>



Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.0
for any user-visible changes.

-- PMM

