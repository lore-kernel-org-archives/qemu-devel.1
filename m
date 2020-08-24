Return-Path: <SRS0=JPH5=CC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE2C8C433E3
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 15:33:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D00020838
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 15:33:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Lx2YosqM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D00020838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32864 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAETe-0003v8-Rq
	for qemu-devel@archiver.kernel.org; Mon, 24 Aug 2020 11:33:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37174)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kAESs-000325-Ci
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 11:32:54 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d]:43935)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kAESq-000596-Gf
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 11:32:54 -0400
Received: by mail-ej1-x62d.google.com with SMTP id m22so12449751eje.10
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2020 08:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=HgOdKWgILwGYJ5cHAD1wB8pNaatEHZiOjk///tvJ9NE=;
 b=Lx2YosqMBe+oaWZfocxhp2P8ChB+Nso5/ECljHcabmNM7A3rUZaJT7UwRNRGVJYzv/
 LXq0doEtyPJg9owaJC8WAA0Wv597gSqMRnCyW1+nEgWJPkJRvUtOJMc1yHMVrYNAJqJD
 KwqdEXUnrhi89cRQZri/v3bSN6ZpoxHu1hBv4wIMc1t7pD4aSJZAk4euhWkEiK+GrePQ
 OeIb43uvU9F7g5cqNDdmBCLc3u3wjcQyNOEfuEFB8/rYi0RwaqJPv8DMN0bwDuvCn1mZ
 sw2LNi4M+hJeqYz+y3VyUYcaF5GDEEWcVuTPARmdkVvZPE/4I6kZdPJ9EaOcaPzYUf/m
 b2zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=HgOdKWgILwGYJ5cHAD1wB8pNaatEHZiOjk///tvJ9NE=;
 b=UG+E8f1BUJGAN1RhUbikJ+0y7GLHluntwchxe8JlCENH81+WSyidnNXyBvtsUZiUQh
 N6hE+JgJzQ3bSbXdiBm72Jd8z96wbHLFe8DwoHBcdYMRl0yQ1IlConHU93bOvE28CHh/
 MkgYuPyEcmL98EuwD6L3OuVKWFSljYiyrMrOnhEPByHMfHdaVeNhzcoMDt/pQ+8VvzPP
 ZY6vLmf9gF+NWKrH0H+VtxKKV+GeF0i3XygualJ6qt67odEhLqVvAHGTbVOrr0ep5KD4
 4EC5BtKLT01+5TVGFwJPmtIgHw4OMPjpkjaxaV+QK2u5ToAzhc3szJfHSvkYlvc5ar4b
 XKoQ==
X-Gm-Message-State: AOAM530yxx3CJh3vi8P4I4iyjgoDN1/TKnrN3V508eTsb94PBN0LhADt
 h8kVEiKRodQTW6Y7OCZIz3JnerSM5XJIXt7b4ZOedw==
X-Google-Smtp-Source: ABdhPJzwHJ+a5BT9YeLPmVjhGwbJRq19RM5s3akpieY0HePgn87AX/G7UIeh4+apPryfn45eNYF3LmoeSzki9q12ANA=
X-Received: by 2002:a17:906:59b:: with SMTP id 27mr6443813ejn.56.1598283171214; 
 Mon, 24 Aug 2020 08:32:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200824100041.1864420-1-edgar.iglesias@gmail.com>
In-Reply-To: <20200824100041.1864420-1-edgar.iglesias@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 24 Aug 2020 16:32:40 +0100
Message-ID: <CAFEAcA9mT7jahhLYDC5r5VMQ=bG71sU4-tSgHytjv7wz0SuQ0A@mail.gmail.com>
Subject: Re: [PULL v1 0/8] Xilinx queue 2020-08-14
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x62d.google.com
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
Cc: Edgar Iglesias <edgar.iglesias@xilinx.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 24 Aug 2020 at 11:00, Edgar E. Iglesias
<edgar.iglesias@gmail.com> wrote:
>
> From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
>
> The following changes since commit 8367a77c4d3f6e1e60890f5510304feb2c621611:
>
>   Merge remote-tracking branch 'remotes/vivier2/tags/linux-user-for-5.2-pull-request' into staging (2020-08-23 16:34:43 +0100)
>
> are available in the Git repository at:
>
>   git@github.com:edgarigl/qemu.git tags/edgar/xilinx-next-2020-08-24.for-upstream
>
> for you to fetch changes up to 43f4e3d4fa2f9dba6bd68452a3380864ad9453c1:
>
>   microblaze: petalogix-s3adsp1800: Add device-tree source (2020-08-24 10:47:27 +0200)
>
> ----------------------------------------------------------------
> For upstream.
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.2
for any user-visible changes.

-- PMM

