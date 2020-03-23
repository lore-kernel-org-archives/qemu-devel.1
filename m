Return-Path: <SRS0=WkHy=5I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC374C4332B
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 09:36:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85E35206F8
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 09:36:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p6uAKWnp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85E35206F8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59262 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGJVQ-0004sr-Me
	for qemu-devel@archiver.kernel.org; Mon, 23 Mar 2020 05:36:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54781)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jGJUm-0004FG-3E
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 05:35:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jGJUl-00057d-2k
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 05:35:43 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:37506)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jGJUk-00055X-Ne
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 05:35:43 -0400
Received: by mail-oi1-x241.google.com with SMTP id w13so14105030oih.4
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2020 02:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=O+YkPzOa4hWYpyxmrZjqWbRMhH8PmQAPR7ip4o4KW+s=;
 b=p6uAKWnpVSvz5nwX/P7zC1WYU1u7uqEuYTw4CyrMWd+aZYnkuTKr1r6N3i/slnQvdQ
 /oWRWIX+KqGWF9Rk40vayIwhP9zgpxuv7AWouWWtAedwzck7KOxuuliHT8Rcgd2IxKuh
 vhQQGTxRoC0M8vp4hN18FLwuXPxquhDeSbMYLfAAdEjpGU1JcVA0DjAJWybPIppb1k5p
 mCynZSwCkudheoti5jEPhtljaVv9XzPk/DmRQSLvMR+YQCn/PxHb7TuKR/i8khtzkNSQ
 hoHvBaDhN4orFfrkQN/7bcjz7wl/bVEQh7ElFA+LuKRIYQsmHwPtT71geMetQcK0vy8r
 We8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=O+YkPzOa4hWYpyxmrZjqWbRMhH8PmQAPR7ip4o4KW+s=;
 b=R8+RePChqz0fzHqp4iS5rETAh/a9ch6x8CgLsjrKLSv5UbfvqmS54bDyXsb9iix15S
 +VcS2Jhm5/1HgcEapUkWAV76/DtDD5WTOkiIZRR+F1zvOm205ZbWPNyoF+4MnMNwbyZY
 z46xeDMmnXMVy0vS5TW16Jk6kx4iCNOHwVA86ELkwbjIFwgVcRrtIo41OdU8wonlWmYt
 NeSOE2x66EThfUNI+3DxKPNQLb9McZH3cZNOxFjL7RN7dlZM89g4YL6l6nyj09jj0VOy
 4BuEo7g/EDJJkm1HfB+xgDzK/BzrhRSfNteWHTod1f4Dzp4HY/FZt1ypSzkn5U1mbuRI
 wDaQ==
X-Gm-Message-State: ANhLgQ3LFRgOs+eQBo79ZuI8K3n2jPb1rIeT40Eg7HBhxuMNB45HPnHB
 0XoasUKd6cAyQ55lYsLX8DdDz13wQ6yJ5fm7/kvM3A==
X-Google-Smtp-Source: ADFU+vtyJ2eOzJSwOwj8lVvfEteZWvMU9JDEZjQv9LCFwlc3dWshFzWe93mfaW5h4FjJAqotZ5Y1iXa0bA4a+Ohk+4E=
X-Received: by 2002:a05:6808:64c:: with SMTP id
 z12mr5594319oih.146.1584956141839; 
 Mon, 23 Mar 2020 02:35:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200320160622.8040-1-richard.henderson@linaro.org>
In-Reply-To: <20200320160622.8040-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 23 Mar 2020 09:35:30 +0000
Message-ID: <CAFEAcA9PNLJyHewNAo2JiXQOzs6ajcwcWzHP7Q6xgiOgbRb7fQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] target/arm: Coverity tweaks
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 20 Mar 2020 at 16:06, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Only the first of these appears to be a real bug.
> The other two are adjustments to help satisfy Coverity.
>
>
> r~
>
>
> Richard Henderson (3):
>   target/arm: Rearrange disabled check for watchpoints
>   target/arm: Assert immh != 0 in disas_simd_shift_imm
>   target/arm: Move computation of index in handle_simd_dupe



Applied to target-arm.next, thanks.

-- PMM

