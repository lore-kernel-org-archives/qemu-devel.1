Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 510C7C433E7
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 19:50:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B90A214D8
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 19:50:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wr7OHpjm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B90A214D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44406 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSmnI-00072F-AT
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 15:50:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46834)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kSmks-0005M0-VK; Wed, 14 Oct 2020 15:48:10 -0400
Received: from mail-io1-xd41.google.com ([2607:f8b0:4864:20::d41]:37338)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kSmkl-0004tf-Ho; Wed, 14 Oct 2020 15:48:10 -0400
Received: by mail-io1-xd41.google.com with SMTP id q25so627475ioh.4;
 Wed, 14 Oct 2020 12:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=XN6ijZPXejkaxdNdJPICNMmmBlXfRPkc5WUs9Q07adM=;
 b=Wr7OHpjm87moICIMCmg7gj4isI3jdX8esKwnVRc2v/BqGjd1OrJQxYq7rs8ku5GcML
 Sh4NCgiTkEdYcEYfXDLf8Bc039jPMQXuuBc/5rUpYtg6iO+2uLeFcE9xbXoHn2wTI/wm
 AGvlCP/Ur7c2fdbQFdqCBfZ0wohZUVkvOcVY2J8wPOwjln9m1plCFsghdPnPY27A9cGP
 qUj4cyGebLWyAVSB+tr56dQIFfun5qrr4dLuxEKcc0QlB1cyUDzdhgvQrzxncPbp1NRP
 UZQ5NC1FZsU3qgUB3nRLmF/XpiV8iQnUrSA8lch+Z2dVcwYiqahPakw9QNReP0FPyWbG
 XsFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=XN6ijZPXejkaxdNdJPICNMmmBlXfRPkc5WUs9Q07adM=;
 b=UoBkB5r6gB35b0iHm1WM91QAOWtS6BCK35CQ60cTzBXpKke8SIxi3K5ee2sQCetqUl
 g5uIbFuTOIOOKxuiJ8IBgBbNo0ikGnRIxPvWgbrdAMjFvlIpv5MWq0QRd3nKtCQsQNnq
 kyZeiEE8ve0pygMQFuEancKRhtCPQmPfqY99N67M4r/xZMS1lkZxGXqLRbHa1thTAq0r
 BqUWF6wgbv6G9mWU+Ag94fsLdGW8wmTFU+26QrI23s/IhkcXhMpl2wqwEhau2kOzf6Ff
 pY+Q7bYCoqnGPMAebPzLm+PyexzDLDvyKaCu+83PD6b/jKS+Y2VrDzlz/eXyWDDcONRs
 KzlA==
X-Gm-Message-State: AOAM531i9K2HwCQ3Tn2QSZ/jtt6v//k4cA4flbnVvPWjOJr8MHbEXVOW
 UjFvLYsy/ZnEEnTMOd0FdrPimBUBLILRtGonBKo=
X-Google-Smtp-Source: ABdhPJzifJfOSD+HWKkPbUy+k873XVTEc9CEEDVyVAd8g/jTH75KqRQIOOcS/l+Retn33OUoRBf8dohdMdGh7QYd5gA=
X-Received: by 2002:a5e:9b11:: with SMTP id j17mr807301iok.176.1602704882039; 
 Wed, 14 Oct 2020 12:48:02 -0700 (PDT)
MIME-Version: 1.0
References: <20201013173054.451135-1-georg.kotheimer@kernkonzept.com>
In-Reply-To: <20201013173054.451135-1-georg.kotheimer@kernkonzept.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 14 Oct 2020 12:36:24 -0700
Message-ID: <CAKmqyKOAwkOfPsRX7B_in7bUP8A45TZx9f_GRhVGfyX9H9FN0A@mail.gmail.com>
Subject: Re: [PATCH] target/riscv: Fix update of hstatus.GVA in
 riscv_cpu_do_interrupt
To: Georg Kotheimer <georg.kotheimer@kernkonzept.com>
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
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Oct 13, 2020 at 10:31 AM Georg Kotheimer
<georg.kotheimer@kernkonzept.com> wrote:
>
> The hstatus.GVA bit was not set if the faulting guest virtual address
> was zero.
>
> Signed-off-by: Georg Kotheimer <georg.kotheimer@kernkonzept.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Thanks!

Applied to riscv-to-apply.next

Alistair

> ---
>  target/riscv/cpu_helper.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index 904899054d..c5852ce1b7 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -852,6 +852,7 @@ void riscv_cpu_do_interrupt(CPUState *cs)
>      bool async = !!(cs->exception_index & RISCV_EXCP_INT_FLAG);
>      target_ulong cause = cs->exception_index & RISCV_EXCP_INT_MASK;
>      target_ulong deleg = async ? env->mideleg : env->medeleg;
> +    bool write_tval = false;
>      target_ulong tval = 0;
>      target_ulong htval = 0;
>      target_ulong mtval2 = 0;
> @@ -873,6 +874,7 @@ void riscv_cpu_do_interrupt(CPUState *cs)
>          case RISCV_EXCP_INST_PAGE_FAULT:
>          case RISCV_EXCP_LOAD_PAGE_FAULT:
>          case RISCV_EXCP_STORE_PAGE_FAULT:
> +            write_tval  = true;
>              tval = env->badaddr;
>              break;
>          default:
> @@ -904,7 +906,7 @@ void riscv_cpu_do_interrupt(CPUState *cs)
>              target_ulong hdeleg = async ? env->hideleg : env->hedeleg;
>
>              if ((riscv_cpu_virt_enabled(env) ||
> -                 riscv_cpu_two_stage_lookup(env)) && tval) {
> +                 riscv_cpu_two_stage_lookup(env)) && write_tval) {
>                  /*
>                   * If we are writing a guest virtual address to stval, set
>                   * this to 1. If we are trapping to VS we will set this to 0
> --
> 2.25.1
>
>

