Return-Path: <SRS0=vd3Y=BW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F31C0C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 16:39:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B712F20771
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 16:39:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CG8bWKRi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B712F20771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51204 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5tmw-0006MC-Vd
	for qemu-devel@archiver.kernel.org; Wed, 12 Aug 2020 12:39:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44536)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1k5tmN-0005uC-LH; Wed, 12 Aug 2020 12:39:07 -0400
Received: from mail-io1-xd42.google.com ([2607:f8b0:4864:20::d42]:38701)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1k5tmM-0003l8-7W; Wed, 12 Aug 2020 12:39:07 -0400
Received: by mail-io1-xd42.google.com with SMTP id h4so3487910ioe.5;
 Wed, 12 Aug 2020 09:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=cEjBd6G7a2BHohI8yL5wJQUDHtTDpxO4klmIrW1xBf0=;
 b=CG8bWKRiDGmNyWVstdP1vDlA35piXq5ra9kd/BCf4ukpMYQv2R5hxV6P0PvYj7XdqV
 63jAIex9FAcCpG4wvlSL55/cRyXvNSb81vpQpGl2cX/jJKCxGpIJyzdM75HhWJYVfZfE
 8dQC82MVQbWovcixIgLHqU+Oka1WV3OCc49VnCQgsUbi1jyXA27HoXN65N30zV5p8iRi
 c4QUyKVgI5uLIj8Hepunb36uyEMdePIdBbrA2QWaYsS5R/VKgBYAN+FqK8kfaaK4JdZn
 cJx0SjmC21I/1a0AeZZAuQImybwueol5v6nTecdYojL39nePiOd5vaNE+p0twU3DN9yJ
 mT2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=cEjBd6G7a2BHohI8yL5wJQUDHtTDpxO4klmIrW1xBf0=;
 b=d8uGqfFGkqe/dz7edljNx4I0HoCQkz7j55LHRYlhZEj8q6+nSPULbauaiLM+vWJSfY
 JyjZvN9GXFcW6c8+fbRpLDvyJraazmN0HpEVmYCeD/WEoaWlcAfuxJUBSZ004jgpwMzm
 xbs74tE0lPek88eMILnA8ouvRhmivqqfoESLY23LyT4yKO+1oCfNA+5SvbLxP9EYGTOH
 u3Ybu80/mPvljZfjodctD2a7c6ui7bN+NJe9tsEmI5WY4ZKJxSh9Q6ayc8BuaIMcMshy
 GwFxNS5H6fs0JnkqhhnZRrDr46GyMhkktYJ4Cc9mdZ6W+wCOSBO29AJh9wNVh7qnOnA+
 uwDg==
X-Gm-Message-State: AOAM531NODuvQKQhA2asF8poTWHGcsFHcquhQrcv/fNdX6gKXZyjn2Mg
 8sr2ur5GWv+QtTl19mm/y8OnLEBN0HfZMJTx6Uk=
X-Google-Smtp-Source: ABdhPJwMZdyRA9BvbJKJkdMNXCJFqhlLTUT93CZqYGWvLIetKopa32C9eXusC7hx7pBdsLi0/pTjt81xiNxDGPHY5SE=
X-Received: by 2002:a5d:995a:: with SMTP id v26mr637442ios.176.1597250344800; 
 Wed, 12 Aug 2020 09:39:04 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1595655188.git.alistair.francis@wdc.com>
In-Reply-To: <cover.1595655188.git.alistair.francis@wdc.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 12 Aug 2020 09:28:38 -0700
Message-ID: <CAKmqyKPdWaPAK7A1O_DtjwonNpG=+duLZ77JjhgYGk6sjPfYVw@mail.gmail.com>
Subject: Re: [PATCH v1 0/3] hw/intc: A few fixes for the Ibex PLIC
To: Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d42;
 envelope-from=alistair23@gmail.com; helo=mail-io1-xd42.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jul 24, 2020 at 10:44 PM Alistair Francis
<alistair.francis@wdc.com> wrote:
>
> Recently some SiFive PLIC fixes have been merged into QEMU, this applies
> those fixes to the Ibex PLIC as well as an update on how claiming
> interrupts works.
>
> Alistair Francis (3):
>   hw/intc: ibex_plic: Update the pending irqs
>   hw/intc: ibex_plic: Don't allow repeat interrupts on claimed lines
>   hw/intc: ibex_plic: Honour source priorities

Applied to riscv-to-apply.next

Alistair

>
>  include/hw/intc/ibex_plic.h |  1 +
>  hw/intc/ibex_plic.c         | 36 +++++++++++++++++++++++++++++++-----
>  2 files changed, 32 insertions(+), 5 deletions(-)
>
> --
> 2.27.0
>

