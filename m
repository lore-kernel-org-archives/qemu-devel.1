Return-Path: <SRS0=SOuJ=D7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88EE5C388F9
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2020 00:38:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E90BD2085B
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2020 00:38:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GCdRe5b6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E90BD2085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41044 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kW7ZK-0007KU-Ud
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 20:38:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58682)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kW7XF-0006Ak-4r; Fri, 23 Oct 2020 20:35:53 -0400
Received: from mail-io1-xd41.google.com ([2607:f8b0:4864:20::d41]:36755)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kW7XD-0001c5-H7; Fri, 23 Oct 2020 20:35:52 -0400
Received: by mail-io1-xd41.google.com with SMTP id u19so4083522ion.3;
 Fri, 23 Oct 2020 17:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=jTRrNQ8GuY9hswnit9eVygwBNp0eOhKRGWm+2uOnA5g=;
 b=GCdRe5b6afXIqEQQ85ahxSnE7o4mUSMJG67xf2IahHwoyvgK/drPTgx3S/ibpRS7AS
 1Arc+u/iIj6aESwv/HtYD41nkNS7WeEpZEFfdU6cIUbpe1Em34EsbZCTcV/8piUPnklH
 vYvVXjN79VD9afpQ2A2el1JdKhBSZO/42ijWg5TpwWxI9Kx5aiFcenr/nrYyAMfBCT6A
 LuQ7J8pQzXwc2fWPbvv16fU21k2eU+0GREDOnDqZhd2oc6zwKChf+B85+1uO2lkMwVtv
 xynfoVPTl2sMsbKodPutW6AJYr/MRFzRYGXvHfej5mq2bwHE24ghS4QLE5bObwTNjq01
 /+2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=jTRrNQ8GuY9hswnit9eVygwBNp0eOhKRGWm+2uOnA5g=;
 b=hZYDUlU4cwJjH0qwzFc6s/TCyFEaFtx8f2at/KJMvsEO6z8jM0cCX+NlxZamGbznE8
 1dB1hXqztCmlKVfbais+jKi5Sac6rhVBw+Os3YM1Ibfh301SoY5il6iTyX/vF+wrA0Cu
 kAtGfGrJ8UliusN3oEhhWXLXFxyRfd7RWvhC1puwC+uTRLN/Ni6orZkOjhj9/4VzZGJK
 9pK/Pn9upzzq0YXUMRfPAvKrVmdKK3jq0DyQTK5QhQfgGlVnABywB7Vm80ALGv/aoBlT
 RL+h305DWzk8Rkpx25L1LD+P+b2T7bYiRqlV94Jr/S+Ke1fJaLgPRyCySEAEX84yjMjo
 1UUA==
X-Gm-Message-State: AOAM532ZWBD7KTTc6XJUFymvNQd3Piqisu4bcQOC6rrU8ZaiKokizl1o
 wGz2OZ5DIP42hmPJjXl80DhHh7CxGfFbKW6XQv4=
X-Google-Smtp-Source: ABdhPJzgOCwfNJejl86WtwSnegNRyUizbdWIEk/cu4LDXjcFQ8hnVWKfcZb9ZLqJ+aoVqXoL6kxv6+DR5i/OACnlOi0=
X-Received: by 2002:a02:b113:: with SMTP id r19mr160491jah.106.1603499749249; 
 Fri, 23 Oct 2020 17:35:49 -0700 (PDT)
MIME-Version: 1.0
References: <20201022080440.10069-1-space.monkey.delivers@gmail.com>
 <20201022080440.10069-2-space.monkey.delivers@gmail.com>
In-Reply-To: <20201022080440.10069-2-space.monkey.delivers@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 23 Oct 2020 17:24:02 -0700
Message-ID: <CAKmqyKNZ171sSrCA6YHjFAbBGYkD=RTv5+rESYFJKvwxrdeKDQ@mail.gmail.com>
Subject: Re: [PATCH v6 1/6] [RISCV_PM] Add J-extension into RISC-V
To: Alexey Baturo <baturo.alexey@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d41;
 envelope-from=alistair23@gmail.com; helo=mail-io1-xd41.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 space.monkey.delivers@gmail.com, Alistair Francis <Alistair.Francis@wdc.com>,
 kupokupokupopo@gmail.com, Palmer Dabbelt <palmer@dabbelt.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Oct 22, 2020 at 1:05 AM Alexey Baturo <baturo.alexey@gmail.com> wrote:
>
> Signed-off-by: Alexey Baturo <space.monkey.delivers@gmail.com>
> ---
>  target/riscv/cpu.c | 1 +
>  target/riscv/cpu.h | 2 ++
>  2 files changed, 3 insertions(+)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 0bbfd7f457..4e305249b3 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -516,6 +516,7 @@ static Property riscv_cpu_properties[] = {
>      DEFINE_PROP_BOOL("u", RISCVCPU, cfg.ext_u, true),
>      /* This is experimental so mark with 'x-' */
>      DEFINE_PROP_BOOL("x-h", RISCVCPU, cfg.ext_h, false),
> +    DEFINE_PROP_BOOL("x-j", RISCVCPU, cfg.ext_j, false),

This line should be in the last commit. It shouldn't be exposed to
users until the very end.

Alistair

>      DEFINE_PROP_BOOL("x-v", RISCVCPU, cfg.ext_v, false),
>      DEFINE_PROP_BOOL("Counters", RISCVCPU, cfg.ext_counters, true),
>      DEFINE_PROP_BOOL("Zifencei", RISCVCPU, cfg.ext_ifencei, true),
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index de275782e6..eca611a367 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -66,6 +66,7 @@
>  #define RVS RV('S')
>  #define RVU RV('U')
>  #define RVH RV('H')
> +#define RVJ RV('J')
>
>  /* S extension denotes that Supervisor mode exists, however it is possible
>     to have a core that support S mode but does not have an MMU and there
> @@ -277,6 +278,7 @@ struct RISCVCPU {
>          bool ext_s;
>          bool ext_u;
>          bool ext_h;
> +        bool ext_j;
>          bool ext_v;
>          bool ext_counters;
>          bool ext_ifencei;
> --
> 2.20.1
>
>

