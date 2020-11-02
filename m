Return-Path: <SRS0=N3Ri=EI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F04F0C00A89
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 08:21:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65BCD206B7
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 08:21:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OI9EZxVq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65BCD206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51452 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZV5Y-00023p-8B
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 03:21:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55662)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1kZV4k-0001Wc-Fo
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 03:20:26 -0500
Received: from mail-yb1-xb41.google.com ([2607:f8b0:4864:20::b41]:36732)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1kZV4f-00077u-0B
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 03:20:26 -0500
Received: by mail-yb1-xb41.google.com with SMTP id f140so11051019ybg.3
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2020 00:20:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=DbqVb66d+WqD8vzO7ZytnaI+y+NeU/Mv0ZeGlITaOYg=;
 b=OI9EZxVqrAWkX/4Gta+Fx8CJWYS272tEsSZXOrTIcg0eyYdfP+EAibGTzE0mNR8s5H
 Qaa/xTdflhwP08h0uarLdXcZmtfQJN+H0wTIYVF/xcYsdHnxWIrsGuwVloeg4Ns6NCXE
 OnBZC543TGGsZWTbBpWefHWtGRfcaydZPDyNFFWdulKs4BlkZi9WL9NZRgWzaDR9BJMm
 v3XJtenw6ONnhtrH0kHDGUa9206YfRlPUt3ul9Y16hEVON6dcb6fLVC1BzzdyQtyJouu
 qOCxqPVJWsX4uuTeUzhaXopcA2qO9D2C83O6p+mC0m3S/gdQIT6HNZTOy/6ECfjREapb
 IDKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=DbqVb66d+WqD8vzO7ZytnaI+y+NeU/Mv0ZeGlITaOYg=;
 b=OS7TTSlj9NM3yVCWD3VcJEeddq7qma+dZ6UKMoQMueVO4zi79N1yoY7eUHzp4Tkf+l
 cmcTSYJ1lkax4yB7e/ULCBSUjkuv0hUJTNq/qK6DsG6d+mEj+Cm7HQnKBaXP/P/C3h7C
 jwt8GKYcNZi0nLJxHbkBTMHUVpCUyRoRu5bxfoflnwydng2LM938+aKFU0uvbWxkKoiF
 /fmDbD/c3+VvJjiuE82xxgbwuOPsJCnZrMN7zh+prlILyPyKajmolC9ogBrXtPC8DDGL
 YcEdMOvdk2TCO8hGwDHCrfdyfyDvvfts9SoVCXJttTLQlaB2lRLqWThVP/baaaHfsAzd
 r20A==
X-Gm-Message-State: AOAM533Wc27LdHDJcHN+K65xZC2drFE7XjqLFQzIeEe7K7KwmF3BnIp7
 51ta6NF6MvmuwNeK09DRPyl823HXtJq0E7gWQ+o=
X-Google-Smtp-Source: ABdhPJyLF7uFzzgB+lfKM0WdxKa0/vFCQgzI0l2x/IUKd/Fcry55T+/MI1ucHIN0e1qHq7OMZvQxFH2vU8AAsWhoQnc=
X-Received: by 2002:a25:328a:: with SMTP id
 y132mr18842408yby.306.1604305219869; 
 Mon, 02 Nov 2020 00:20:19 -0800 (PST)
MIME-Version: 1.0
References: <1603361762-43062-1-git-send-email-bmeng.cn@gmail.com>
In-Reply-To: <1603361762-43062-1-git-send-email-bmeng.cn@gmail.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Mon, 2 Nov 2020 16:20:08 +0800
Message-ID: <CAEUhbmVs0SdqA_KFK4xiuCqHcKFke5sNBBrwjLTXbyCbew-nxg@mail.gmail.com>
Subject: Re: [PATCH] target/i386: seg_helper: Correct segement selector
 nullification in the RET/IRET helper
To: Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Richard Henderson <richard.henderson@linaro.org>
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
Cc: Bin Meng <bin.meng@windriver.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Oct 22, 2020 at 6:16 PM Bin Meng <bmeng.cn@gmail.com> wrote:
>
> From: Bin Meng <bin.meng@windriver.com>
>
> Per the SDM, when returning to outer privilege level, for segment
> registers (ES, FS, GS, and DS) if the check fails, the segment
> selector becomes null, but QEMU clears the base/limit/flags as well
> as nullifying the segment selector, which should be a spec violation.
>
> Real hardware seems to be compliant with the spec, at least on one
> Coffee Lake board I tested.
>
> Signed-off-by: Bin Meng <bin.meng@windriver.com>
> ---
>
>  target/i386/seg_helper.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>

Ping?

