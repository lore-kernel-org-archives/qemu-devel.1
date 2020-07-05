Return-Path: <SRS0=SLMP=AQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0167EC433DF
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2020 17:09:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1351206DF
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2020 17:09:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QqXg4TqD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1351206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41466 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1js88k-0000SS-UN
	for qemu-devel@archiver.kernel.org; Sun, 05 Jul 2020 13:09:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34864)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1js88A-0008Ma-Lq
 for qemu-devel@nongnu.org; Sun, 05 Jul 2020 13:08:42 -0400
Received: from mail-oo1-xc43.google.com ([2607:f8b0:4864:20::c43]:43572)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1js889-0006vf-3v
 for qemu-devel@nongnu.org; Sun, 05 Jul 2020 13:08:42 -0400
Received: by mail-oo1-xc43.google.com with SMTP id t12so198416ooc.10
 for <qemu-devel@nongnu.org>; Sun, 05 Jul 2020 10:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=wGYzV59vme40syEGC5eDxUkPe3o472q55eMhraZGah4=;
 b=QqXg4TqDavrpd92pq40EWW8T/JB5rwtx0WCwdRCCysJtsVnUvF3+PFUD/0oAFC/6Wm
 lU1BabkQodnbFzzSJp71sAprXtf78yq+p/UjvHq3VmGjwj8iEBL0CtzruJSXzunNmXOR
 Mdy2/7FQLgGXn15rBa1vs4wRRknBF9BUShkSPmTM2kPKpa83UbKFc2TbZpJ57DQeBaib
 nWE5686DH1NYNXbL74UZYCPcnSWvkCHQlLvPRZguIw489TJ8MMY8WELgnjsW3A7W2sGJ
 zTUgbTLLjisywKOWuqz1ds5lfFqsP4y3VnL1EElxoxU4WAi4uB9Z4bDiTF7sGDVdlIg0
 geNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=wGYzV59vme40syEGC5eDxUkPe3o472q55eMhraZGah4=;
 b=WcaRecMNDpTw5o6Hq/JRzCiFAi2AXcFoOMytveuIsAHz4xhx7i4GNl6+ySl9nwPpaS
 J8HN6JR3HmG2uwpV1Ky+p5M45CuB2uJkPQ5VEgML2vrvTi1aWiKhR05X8uTvVGTX01nO
 ArlVzx80GoSgaPhbQV0uEkOzT1Q1mlpsOc96zibapRjdttU6KPwZX663/HeY5W/vq5zg
 ScBjX+Y/RNcc+DRfo/eTiMs4/jECwHASQGuPA9MqXIBBmUqNMarh9Jb22M5r8rRugWbx
 PcMn2YgYNmXvDCvzt0j/Rr3W6cCsrspo1NYRkCXerRw95o77UTSE3teRy9SVwhqLZMIC
 WZXw==
X-Gm-Message-State: AOAM531Mt0Qq1Bhx2Xa9jM2ferCQCga43v/92u0dITQCCjnpRsMX3ATm
 cmpENEB0VOu/XrWgPlmY7qRQ8TZeZS2QqEgzcGgXtw==
X-Google-Smtp-Source: ABdhPJw6mrmhpHxvCu8uaPKTSYmGxhA9st27SGjuEGjgFVt3M/eIo2prnukoaDf8WwqQncaFJFj0Y6PT4OyrjSNrWKo=
X-Received: by 2002:a05:6820:172:: with SMTP id
 k18mr31107564ood.69.1593968919369; 
 Sun, 05 Jul 2020 10:08:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200629160535.3910-1-wentong.wu@intel.com>
 <20200629160535.3910-3-wentong.wu@intel.com>
 <3260735e-05ab-2d42-f7e4-914ad804f543@linaro.org>
In-Reply-To: <3260735e-05ab-2d42-f7e4-914ad804f543@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 5 Jul 2020 18:08:28 +0100
Message-ID: <CAFEAcA_+e7hrA5GRGb=gv3GxJRL77ARP34vyudRbiqhdsNVKwg@mail.gmail.com>
Subject: Re: [PATCH 3/3] target/nios2: Use gen_io_start around wrctl
 instruction
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::c43;
 envelope-from=peter.maydell@linaro.org; helo=mail-oo1-xc43.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, Marek Vasut <marex@denx.de>,
 Wentong Wu <wentong.wu@intel.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Chris Wulff <crwulff@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 2 Jul 2020 at 19:53, Richard Henderson
<richard.henderson@linaro.org> wrote:
> This isn't right.  Not so much the gen_io_start portion, but the entire
> existence of helper_check_interrupt.

I agree that it looks bogus (xtensa has a similar helper as well, incidentally),
but fixing all that stuff up is more effort than the relatively small job
of getting the icount handling right for the code we have today, which
is why I suggested to Wentong that we could just do this bit for now.

thanks
-- PMM

