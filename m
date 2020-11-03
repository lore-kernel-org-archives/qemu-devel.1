Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B82BC388F9
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 21:09:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE861207BC
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 21:08:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xRSvniba"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE861207BC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57486 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ka3Y2-0005rF-L8
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 16:08:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52218)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ka3X3-00052K-BF
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 16:07:58 -0500
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533]:35961)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ka3X0-0003gc-W5
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 16:07:56 -0500
Received: by mail-ed1-x533.google.com with SMTP id o20so1890596eds.3
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2020 13:07:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=41gyJN7miB9+IYas/AMVopXUI+lg6opWFtS/Hgn+5Mk=;
 b=xRSvnibasYe67oIbvVQu/cIC9A1nDbjB1aTXsl2C3cn/p1R9BZqqNcl38bJ/Mf7ADR
 c9m0lDXEGy4LqDHgC3wAZB5gABDYRD6KjKm3jKzMNTzhzzXjIDpcAxesgAqH6jWwP5ua
 71GfFEWmcn3Q8WyjfZFRwbslLKev4j28EMkxm5p3iQS44X010nvEk1y6YH/c0UcTZc7K
 z3kQhVLMMYBtAtX4Ze2ysQ+F8ep/ehfIyLkh+l73B3NzRCAIB3UTjyYqp6dyzZ9jpV99
 8nBoFuJm2PckVktqYRvXspaqy7DSkH9FWaaijv/DJzHq9ARqSAIcMRfEC0TccELfbOxS
 GY6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=41gyJN7miB9+IYas/AMVopXUI+lg6opWFtS/Hgn+5Mk=;
 b=pJr6p0JA9k2kV1NSHl511B9iYIl6zJ6xgtl7JOtqO1bcaRWFIWe+83C0FWlAgSUky8
 saNzAGxOfeuuRr7blI/T6/jWNqQ3AwC1DTm9GyYNg5Kl2CZV8DgF18da4ZO0d41sFIS3
 f2UWqDaTyd6/BFrlLR3TAw1qz70oE340vx7CxKkEt4bd9KCz0zlQAuhXeIrYObQyjWP4
 Z7oxYjZrjrvPsJ7Lyv5qjV2w9fAPCxLCkF04R3TJLksGr2x/XbCkl3cMCRWeHYRRPVLa
 h3laT/pLedgjKwZTM+ZCz3wyswcai8TvTStYGA+eLOkrJfkrhamuQ6MdDPBWd/XhkHc5
 kCYw==
X-Gm-Message-State: AOAM530dHGCWPc1SCAhmnHgA2JSLBGh7PMaGxpg9w2IlHj/Ly92LqCL5
 lob70OmbBr2VVTEtNNf/MGiFPYHyWTK22Qpcb2eYYA==
X-Google-Smtp-Source: ABdhPJzzwE6tro4MYuh6d26dgSsVTdIYx/9b5NZ5bKjYwsjZbR9ebPF+lrVkKlIQgwlTY+RIjBV+SPASyRdBWQVIfZ4=
X-Received: by 2002:a05:6402:b35:: with SMTP id
 bo21mr24509550edb.52.1604437673034; 
 Tue, 03 Nov 2020 13:07:53 -0800 (PST)
MIME-Version: 1.0
References: <20201103152150.2677566-1-alistair.francis@wdc.com>
In-Reply-To: <20201103152150.2677566-1-alistair.francis@wdc.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 3 Nov 2020 21:07:41 +0000
Message-ID: <CAFEAcA98Ve8i7Up2M=iRo+_KGfUGan9xKU_TKb2882GuVZS6fA@mail.gmail.com>
Subject: Re: [PULL v2 00/19] riscv-to-apply queue
To: Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x533.google.com
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
Cc: Alistair Francis <alistair23@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 3 Nov 2020 at 15:33, Alistair Francis <alistair.francis@wdc.com> wrote:
>
> The following changes since commit 83851c7c60c90e9fb6a23ff48076387a77bc33cd:
>
>   Merge remote-tracking branch 'remotes/mdroth/tags/qga-pull-2020-10-27-v3-tag' into staging (2020-11-03 12:47:58 +0000)
>
> are available in the Git repository at:
>
>   git@github.com:alistair23/qemu.git tags/pull-riscv-to-apply-20201103
>
> for you to fetch changes up to 422819776101520cb56658ee5facf926526cf870:
>
>   target/riscv/csr.c : add space before the open parenthesis '(' (2020-11-03 07:17:23 -0800)
>
> ----------------------------------------------------------------
> This series adds support for migration to RISC-V QEMU and expands the
> Microchip PFSoC to allow unmodified HSS and Linux boots.
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.2
for any user-visible changes.

-- PMM

