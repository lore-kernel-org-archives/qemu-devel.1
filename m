Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A08BC433EA
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 16:32:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BBB9206F5
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 16:32:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a1nCGy60"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BBB9206F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45160 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jv1Nh-00076t-LO
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 12:32:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60742)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jv1Md-0005vK-AG
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 12:31:35 -0400
Received: from mail-io1-xd43.google.com ([2607:f8b0:4864:20::d43]:37480)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jv1MZ-0004Cs-LJ
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 12:31:35 -0400
Received: by mail-io1-xd43.google.com with SMTP id v6so14153539iob.4
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2020 09:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=XeGJ68ALK9v739cvfUbNwsv9r3rIlEAGhnpN7R5veLI=;
 b=a1nCGy60t7HQcvuEj41Pxx8ScXAngKhdoKbr490KgTEpCmLWyu1Jabsa93RqC/AnRy
 alIV2FoKt5mxdvV0rH8M2DQQiZATLigCpINeRiDr4R2zbzzvJBz4JLH0zX2LYe6B95te
 Hi0h/mP82xMv04kPh+aFKdTRzAIk+UfwPwpdJFJltErDpWpMy9f1wB+UnqVn1L+mqOHM
 wBwRxKyYTF+EdZwUNXqH9G6G2OqXl/ZN6ZwRRBXzXma1XXnsngtl6f38AZ/2FTAgmSN4
 zYRb4dx/phluP3pJFU+99vfe0ysEAkhw9PNyATc4j6izmLmh57UE8vXmZOYWEalu48rc
 YFdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=XeGJ68ALK9v739cvfUbNwsv9r3rIlEAGhnpN7R5veLI=;
 b=uMXgOFQqzAyb/eP0kUxhqmDNhMuYGWWlH/xQ+GmTlezpJptLGkqlSYn5VZKwrQI47Z
 sT3acm7dMZvevnXCYr/AGF3FubxC/s9IWBC+9DPtM1MCiwqN4HATOn/GYccpYegUu04Q
 LhtxbutLfySVkXkdCbyYBVLLwXiiHl0cKraUHiPzp0L9+401UL66how2+pU4EhA8OAg0
 lNiii6EiljoMCLBP/p1BAokZKoYGlPYvPVPuEGa/24PvsBZMjk+3CPJxsvoWxCLvRIur
 z+b6grFQRa8QOB7SMy4hjxdc4szZU0wXSOieWAC+miiWnPVwxUMFacSqXqMVm4wPf466
 wzGQ==
X-Gm-Message-State: AOAM531eXVVEu/Wu+Uf6epafe6Czn+MVRubemPX2TJAeX0sP3W7SHqnw
 RF6qhqX+gDhGyQB0aNZpTKJo8jigHzyQFmYa4XE=
X-Google-Smtp-Source: ABdhPJxKAEJMeXO0Qj/AfrzOBO2SszpK8dJi6OuiewTA1IuoDqg5f8r0Nycz9xX1XeaVrnfYK35GOpA+nZ/1nbC+jpk=
X-Received: by 2002:a02:878b:: with SMTP id t11mr1008506jai.106.1594657889823; 
 Mon, 13 Jul 2020 09:31:29 -0700 (PDT)
MIME-Version: 1.0
References: <1594600421-22942-1-git-send-email-wang.yi59@zte.com.cn>
In-Reply-To: <1594600421-22942-1-git-send-email-wang.yi59@zte.com.cn>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 13 Jul 2020 09:21:32 -0700
Message-ID: <CAKmqyKOyiEbaW0-cwK3dK=FxguDxABGKWRafnbCt3C0d1xmycQ@mail.gmail.com>
Subject: Re: [PATCH] tcg/riscv: Remove superfluous breaks
To: Yi Wang <wang.yi59@zte.com.cn>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d43;
 envelope-from=alistair23@gmail.com; helo=mail-io1-xd43.google.com
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
Cc: xue.zhihong@zte.com.cn, wang.liang82@zte.com.cn,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Liao Pingfang <liao.pingfang@zte.com.cn>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, Jul 12, 2020 at 5:30 PM Yi Wang <wang.yi59@zte.com.cn> wrote:
>
> From: Liao Pingfang <liao.pingfang@zte.com.cn>
>
> Remove superfluous breaks, as there is a "return" before them.
>
> Signed-off-by: Liao Pingfang <liao.pingfang@zte.com.cn>

Thanks!

Applied to riscv-to-apply.next

Alistair

> ---
>  tcg/riscv/tcg-target.inc.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/tcg/riscv/tcg-target.inc.c b/tcg/riscv/tcg-target.inc.c
> index 2bc0ba7..3c11ab8 100644
> --- a/tcg/riscv/tcg-target.inc.c
> +++ b/tcg/riscv/tcg-target.inc.c
> @@ -502,10 +502,8 @@ static bool patch_reloc(tcg_insn_unit *code_ptr, int type,
>          break;
>      case R_RISCV_JAL:
>          return reloc_jimm20(code_ptr, (tcg_insn_unit *)value);
> -        break;
>      case R_RISCV_CALL:
>          return reloc_call(code_ptr, (tcg_insn_unit *)value);
> -        break;
>      default:
>          tcg_abort();
>      }
> --
> 2.9.5
>
>

