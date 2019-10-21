Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C616DCA9EAF
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 16:38:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 920602084B
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 16:38:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XYqhh3UN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 920602084B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45208 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMahf-0000GO-H4
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 12:38:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38763)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iMag2-00076U-Le
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 12:37:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iMag1-0003tl-IG
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 12:37:02 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:38748)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iMag1-0003td-CD
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 12:37:01 -0400
Received: by mail-oi1-x244.google.com with SMTP id d140so7285941oib.5
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2019 09:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=7Vav+SwOXHBU5zAtXkovGAouM8z1xgF6EBGSOMuF3i0=;
 b=XYqhh3UNquRlUaJ4PXeQcl/SiOUPJjuV/TbBG6ijI7mb2JBZwQ9rDVZZG4KgUDY9RV
 8BF8xTZFAOZg3GElQNkSx+oW0q3knQIauqzcEph4tqVmt9+Glof4oXMr/KZUPulHqs/t
 nSmZBiKgdMyPn+cG0AEX8gV7LBY55+lc3FwI9XIOmWuJDpsE+2CWOzQxer/fJ7f2zbRR
 8Irb1vw9HnSIxIFGGt8bA34kKisE9sNWPVN8cD+fZEB2eHDwoUm1mNjjrqqcqRXaKZNg
 hFNOaDmziWt1ycKMiA3O3IFfXCG3DeRYpU9pdlmBb8hzJB/mpdtWq7GK0hJfZVs783T/
 kZJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=7Vav+SwOXHBU5zAtXkovGAouM8z1xgF6EBGSOMuF3i0=;
 b=ARMoFPJzUGnUnhwLYZODiDd2a0DwxaWRLsHWsEXg783yboFLsemcnlfomm6vziZ4JZ
 2ZltkLGncd5BrFctWqjBUXRtsKBvP9jNWkLoqGCFPlgp0+gXekrph5l6qsyc46x5Iaef
 WJPmde08XfqYltRmfXDUf8ZSXfMguOt/khDeLgdYwaNjLOqxaUb1TVhiGzePT4JGX+HR
 qpXzQ1iwbfMwH8OXlpCd5EuU9X/WBbDgmPfGrJyYL2ZwxsxcY4SAvZoFKjpNKkBLImxd
 oQodLlRKc92H/th7XlyfH1H3GIChG8veoGaDGOlo5eL2Wb7AjATuYoPRWlDzwn8r5Oxd
 1Xhw==
X-Gm-Message-State: APjAAAUg13GProE+PO+XmzNe1EZXbaUbJ0EL1hsv0btyXcQq/o/W8hiW
 J22soN6M3vBB7ZkAh3kQqEQRICqlQAeOEzYkTuW/AyO+5lc=
X-Google-Smtp-Source: APXvYqwSAB1FDYa0Xb196YfwH8JatvkpWYMo1PKF1TSb3ZXwdOKb+2jT085LUfSPHC/+iah4A15Ruq0QR2CFh0p41S8=
X-Received: by 2002:aca:49c2:: with SMTP id
 w185mr20196493oia.163.1571675820194; 
 Mon, 21 Oct 2019 09:37:00 -0700 (PDT)
MIME-Version: 1.0
References: <20191021145839.12684-1-peter.maydell@linaro.org>
In-Reply-To: <20191021145839.12684-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 21 Oct 2019 17:36:49 +0100
Message-ID: <CAFEAcA_PO7vaxGVpfW2bqRvB9XtDA8uk_6Tw7SauwrbHfJOjxw@mail.gmail.com>
Subject: Re: [PATCH] tcg/LICENSE: Remove no-longer-true statement that TCG is
 BSD-licensed
To: QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::244
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
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Claudio Fontana <claudio.fontana@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 21 Oct 2019 at 15:58, Peter Maydell <peter.maydell@linaro.org> wrote:
> Since 2008 the tcg/LICENSE file has not changed: it claims that
> everything under tcg/ is BSD-licensed.
>
> This is not true and hasn't been true for years: in 2013 we
> accepted the tcg/aarch64 target code under a GPLv2-or-later
> license statement. We don't really consider the tcg
> subdirectory to be a distinct part of QEMU anyway.

This commit message misses the other not-BSD bits of code in tcg/:
tcg/tci.c is GPL-2-or-later
tcg/tcg-gvec-desc.h, tcg/tcg-op-gvec.[ch], tcg-op-vec.c are LGPL2.1-or-later

Horse has clearly bolted further from the stable than
I had first thought.

thanks
-- PMM

