Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5B0AC433E7
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 12:15:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF71420720
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 12:15:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UjHKBlTh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF71420720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33606 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtrw5-0000MQ-U6
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 08:15:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60538)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jtrvF-0007zK-7P
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 08:14:33 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:45074)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jtrvD-0001Zf-Hu
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 08:14:32 -0400
Received: by mail-oi1-x244.google.com with SMTP id j11so4573760oiw.12
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2020 05:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=fqPDkL6sMNo9s9H36YdDFkIS5atxl03KVsNtT4br1ss=;
 b=UjHKBlThpxO4SFXA7kVdPXlm4KBXhWckZmLFwAg60EeaqBhCtcoV+XzB+036b/lbB7
 hkZgOshuO0aHiMxNQC0M5GfaPbvC0Ul56R2W9LlEAunh6xDsRapGMWZSvTzqoxjnVT/Z
 Z1MZzP88tki8GJ2kUQdOJcLIPSdlLzCvzDKRcPRC036wVID8jaAWRbQBmUCwBU5ipAm/
 HZaAfDMwW1wqKKgN5YE8bGtcdpN51b3lpRLLiWHEOEGEjmvEyWZ5p4wL7yLNajIl36RR
 hds+CERjoEiA2tsSAgDHQETJuf5Ck1AaOkKDDUmb1SJb5pQoOIemz9u37JE2Jfg10hu4
 I6RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=fqPDkL6sMNo9s9H36YdDFkIS5atxl03KVsNtT4br1ss=;
 b=ONCXQLAcDaN5VYVLyg3qghF/u7dWko6wX3vOTDi1Tvwq9c6ZQVWnD7g7luqerlX3bf
 m9jEXxEfF+cMbWbNKE9KPiuHeboxrsryZdBvunryvzSm+owm6Xsp7uVYaeUJPI4Y3lSM
 3evu4W5NKbg0cuKrphWkz+Q8yyLl9iz8xALb4GyqKciSP/aLXiuYQPwkC4FnWNcGRAkN
 3NKgIYmqfrOAzBcxoucKQCZ80QgkeQwxcfGhcIb1EVCFE2NQTgbD4NdDwyK+1J0SjDv3
 jHuZNrnZfqKtFtMpovl9FYuKFZv58wYDVM8o9tafMCwlG4JIoB7Lh3wLkm6/qU7eu3Ug
 CrZA==
X-Gm-Message-State: AOAM533/pKaDZPsnULHpU6UQz/hBhboao8AhqVx4Pdze18V6XgQwzEkj
 ly5iVDcn2m7EnzV0X2cvzzaYldVCpSB4Pu7+girJIA==
X-Google-Smtp-Source: ABdhPJxib+rWnNCZrOaAmTeS+suSArNjj/RykxMw9AKEOOEoIwMZLwajftlBm4LQA/hXlWWtebwifD2SVmFq/fgDAh0=
X-Received: by 2002:aca:2819:: with SMTP id 25mr3692096oix.48.1594383270348;
 Fri, 10 Jul 2020 05:14:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200708172542.25012-1-pbonzini@redhat.com>
In-Reply-To: <20200708172542.25012-1-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 10 Jul 2020 13:14:19 +0100
Message-ID: <CAFEAcA8b6sn8fXOKwqOF6MvsKT5oKqS+4jjYDPAPvnXmVimLiQ@mail.gmail.com>
Subject: Re: [PULL v2 00/52] Misc patches for QEMU 5.1 soft freeze
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::244;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x244.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, 8 Jul 2020 at 22:32, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> The following changes since commit eb2c66b10efd2b914b56b20ae90655914310c925:
>
>   Merge remote-tracking branch 'remotes/maxreitz/tags/pull-block-2020-07-06' into staging (2020-07-07 19:47:26 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/bonzini/qemu.git tags/for-upstream
>
> for you to fetch changes up to 392f34e59755f99d69586a63e0f5d80a7ef67f94:
>
>   apic: Report current_count via 'info lapic' (2020-07-08 10:01:08 -0400)

Hi; this still has the OSX failure, I'm afraid:

/Users/pm215/src/qemu-for-merges/ui/cocoa.m:1478:9: error: implicit
declaration of function 'cpu_throttle_set' is invalid in C99 [-
Werror,-Wimplicit-function-declaration]
        cpu_throttle_set(throttle_pct);
        ^
/Users/pm215/src/qemu-for-merges/ui/cocoa.m:1478:9: error: this
function declaration is not a prototype [-Werror,-Wstrict-prototypes]

(other builds haven't reported back yet)

thanks
-- PMM

