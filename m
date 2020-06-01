Return-Path: <SRS0=dyow=7O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CBFCC433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 13:34:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67DBE20738
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 13:34:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rONyzkL1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67DBE20738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39486 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfkaD-0008Cq-Lc
	for qemu-devel@archiver.kernel.org; Mon, 01 Jun 2020 09:34:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59768)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jfkZY-0007UY-CK
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 09:33:48 -0400
Received: from mail-oi1-x231.google.com ([2607:f8b0:4864:20::231]:46420)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jfkZW-0006Ha-Ly
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 09:33:47 -0400
Received: by mail-oi1-x231.google.com with SMTP id b3so8820850oib.13
 for <qemu-devel@nongnu.org>; Mon, 01 Jun 2020 06:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=jIwRVaSlTQZNp4dIrhW5HnjtET1AnbtrzIJg71h8Rfw=;
 b=rONyzkL1BtO6IfKGnwrAt8HlED0SezWF8vvb/6Yok3g6iBhm0XU153Q4yBnZBW21jd
 OU85VmASvveViGJs2GNRScpEALuvwzQIfyCXzO1Mff1Gfvg31Bg6zwfvwv/EDb+Hdci2
 g/+Jv1XWXz1y4uNk+n4C2CJwJaUEjv1hs1NndWpvohYu+Y9iqz7WR50ZrRwArW91ShqE
 /t+u7ZEiI9ybJGkX4HYI3czWTZORxGGnA04u+Jz3VeU2bZ6M4gun7EJNWtWHu5EtigPg
 O74HsVjUA6m7+aeh7Sxy5YdttCGJ5pIdIYegInh7Mw1tW3W+CsnWg5+KMO4/ZeQDnhVd
 BdMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=jIwRVaSlTQZNp4dIrhW5HnjtET1AnbtrzIJg71h8Rfw=;
 b=BJcqEEIiGYvQVuEf5QaOTAuI7fVB1zcmYk8N16l5XuJCa/r6FJlsOvIul/5qkMOJDr
 Qo9Z/I2v8VheRiFRy+Aj7hnAWy6sHlXHKOsrfFDGsog1mqGnkM04SWCl9ZY6WGnr1toe
 hfIPZOAx69Wbhwn714DmWwYkUwgl+RPmUlnfHalCNkGbXYuoCSRb5QwBDZFzx9VruPeW
 OSdnmf/K48Xi3YJ6P/R1X28JJS5ZHktB+P4ZQcStp1/2WnRZa9d+GxUK/szRoCQL7xDf
 hWhIRqbqnJzasWDO8uy2d50p0GLko9iLV3OlOJsdfHrpAU1px1C9oAPNJYEOV/NVdXIm
 98wg==
X-Gm-Message-State: AOAM530gLzt5/k4NQSvbnO7SQfbPDQbrvl5id9k9Asv/8bpLoAX7QRBp
 K2BhU6GBJ6dQ7SiEWtrMOWLRzomxEetcCVmTufnP+A==
X-Google-Smtp-Source: ABdhPJxCFArEmO/h8qkOX37cTOW3C2ioNZIxObh2mHCJPpddvGPcMFIMKSAdyHc1JUvYuVIFQWpzX5LL61xoM19t8Jw=
X-Received: by 2002:aca:5152:: with SMTP id f79mr3861838oib.146.1591018425083; 
 Mon, 01 Jun 2020 06:33:45 -0700 (PDT)
MIME-Version: 1.0
References: <1591015405-19651-1-git-send-email-aleksandar.qemu.devel@gmail.com>
In-Reply-To: <1591015405-19651-1-git-send-email-aleksandar.qemu.devel@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 1 Jun 2020 14:33:34 +0100
Message-ID: <CAFEAcA-LpX0XA25m3gx0swkRXf8_v0=9oHuNucFNVnGXAfmt=g@mail.gmail.com>
Subject: Re: [PULL 0/6] MIPS queue for June 1st, 2020
To: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::231;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x231.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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

On Mon, 1 Jun 2020 at 13:43, Aleksandar Markovic
<aleksandar.qemu.devel@gmail.com> wrote:
>
> The following changes since commit 4ec2a1f53e8aaa22924614b64dde97321126943e:
>
>   Merge remote-tracking branch 'remotes/huth-gitlab/tags/pull-request-2020-05-30' into staging (2020-05-31 20:43:45 +0100)
>
> are available in the git repository at:
>
>   https://github.com/AMarkovic/qemu tags/mips-queue-june-01-2020
>
> for you to fetch changes up to a08d60bc6c2b6469368fff3d38dd5ddd16dd36be:
>
>   hw/mips: fuloong2e: Set preferred page size to 16KB (2020-06-01 13:28:21 +0200)
>
> ----------------------------------------------------------------
>
> MIPS queue for June 1st, 2020
>
>   Highlights:
>
>   - setting Fuloong 2E preffered page size to a different value
>   - preparation for adding KVM support for Longsoon 3
>   - other minor changes
>   - a checkpatch warning is known and should be ignored
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.1
for any user-visible changes.

-- PMM

