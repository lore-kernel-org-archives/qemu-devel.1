Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15EEEC433E7
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 03:19:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7AA94222E9
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 03:19:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="utJ2mBjK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AA94222E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58024 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUiAx-0000bS-HT
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 23:19:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42630)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1kUi9z-0007S1-91; Mon, 19 Oct 2020 23:18:03 -0400
Received: from mail-yb1-xb41.google.com ([2607:f8b0:4864:20::b41]:35660)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1kUi9v-0007Cb-1o; Mon, 19 Oct 2020 23:18:02 -0400
Received: by mail-yb1-xb41.google.com with SMTP id l15so604601ybp.2;
 Mon, 19 Oct 2020 20:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=zSQ5eLj04XGsu1kDXocj1UWnLkPAauUYxO5Ja/WMNr8=;
 b=utJ2mBjKD2TiRuYZt5VZ4/KDIlEOR7Hj5090YgpyOVf0gYELuGdDXNVPwasZd6dByA
 DYM5KGgReAjGfeN6PHV8VlXQ2ziFvzIQ1zvWVMKjgvst4nnYEvgDdyq8GaoV2ufH4R3L
 OTnU/pzImzDpurvhUpYbaZNvkp9iLs1SK/Wpk0h4ryF8dS8WhuZ0E2sUjAqyog9j+PCY
 QWsSKx/bMwxqtJ3uEg9CDcm9Va3R2bCewTZyJBYbVUgWScrp1zsvEYHX9UWoKcjBzBOZ
 dlllwhJpkStvh9Jy4RaT4NSWuH5hkNvtcwr0F3jBBCy6OV89VwpT8wkSfXlra0VzLXnB
 okqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=zSQ5eLj04XGsu1kDXocj1UWnLkPAauUYxO5Ja/WMNr8=;
 b=Wjk5IDFzPhVRWkRBVatD8vd19hu8/HR65IwGGcdpoe8uIqExoUe987kphaJla+xlHy
 IN5MfH9D+9AC1hDS0UnV5XhAIf/ulkGWFog4trc0ggMDo6RVYMnnBf4BowTC3H0J85GZ
 j2+Uy+ncj1reBCymaaOcLo3ZqaP71xoFwZaVX3ELPexOpRbmKIIzkL/DqjjxUfUWFins
 T/DdaC9ErpVheaLW9u2DXA9kQTENPUwADdVB/0OzxFhlNwwyipUISkOR7nuVQ7nG+aWD
 OaTsLudGFfnDBJlBdZCuJYZ4SFUOZ/tSl1ZjegrbNxDAwZQmP+8UGZf/cS+RQQDntBtJ
 zd0Q==
X-Gm-Message-State: AOAM5335O3tufjJzj8UwrUoAfJsOnYz/6mD/PPGHxa5n6aQmNLy4THX4
 yju7qef2MmcLa6bswQaFMKMFbhp7q33PW1DaEwI=
X-Google-Smtp-Source: ABdhPJyyDapP0EFc6KVnnbZ6KuI6YJ9NUNJ6GezeafkrGVrLkmf/BNDR/KiDOlGB/ItqIeqELyEtcoG9LEF7H7ibrXU=
X-Received: by 2002:a25:520a:: with SMTP id g10mr1353413ybb.152.1603163876352; 
 Mon, 19 Oct 2020 20:17:56 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1602634524.git.alistair.francis@wdc.com>
 <b8412086c8aea0eff30fb7a17f0acf2943381b6a.1602634524.git.alistair.francis@wdc.com>
In-Reply-To: <b8412086c8aea0eff30fb7a17f0acf2943381b6a.1602634524.git.alistair.francis@wdc.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Tue, 20 Oct 2020 11:17:44 +0800
Message-ID: <CAEUhbmVmr7KO+oPYiqbo58M1h8ibzhEjujbc34B9u+w0QjNLXQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] hw/riscv: sifive_u: Allow specifying the CPU
To: Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b41;
 envelope-from=bmeng.cn@gmail.com; helo=mail-yb1-xb41.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <alistair23@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Oct 14, 2020 at 8:28 AM Alistair Francis
<alistair.francis@wdc.com> wrote:
>
> Allow the user to specify the main application CPU for the sifive_u
> machine.
>
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> Reviewed-by: Bin Meng <bin.meng@windriver.com>
> ---
>  include/hw/riscv/sifive_u.h |  1 +
>  hw/riscv/sifive_u.c         | 18 +++++++++++++-----
>  2 files changed, 14 insertions(+), 5 deletions(-)
>

Tested-by: Bin Meng <bin.meng@windriver.com>

