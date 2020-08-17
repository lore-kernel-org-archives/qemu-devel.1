Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B79FC433E4
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 16:27:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8EF6205CB
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 16:27:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OaJZcGdZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8EF6205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45022 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7hyf-0001DY-8U
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 12:27:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43254)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1k7htf-0008GA-Fd; Mon, 17 Aug 2020 12:22:07 -0400
Received: from mail-io1-xd44.google.com ([2607:f8b0:4864:20::d44]:40934)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1k7htd-0005TR-Ke; Mon, 17 Aug 2020 12:22:07 -0400
Received: by mail-io1-xd44.google.com with SMTP id b17so18177541ion.7;
 Mon, 17 Aug 2020 09:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=6KIZ6JfOxYuwBpB4xSx5INRXqVKVkmQ/oSHbpTyBmM4=;
 b=OaJZcGdZ788/Q2U2bqCzTlBo2FZ3T8JXWRy6vKz7nSgiwxp8UKllDaLlXIIpOXJNwT
 xbWD73p8KIm8E/SGWrAM6lUqURd37mxNw3zyBFkTYV5LyhOi6RbLX7zeEW/nAIAsdo8i
 OQdSA91xx4jQMKz5/kCjakojqlX2R7Iq/xzQSqPrPrxeXj62l+X64Ev/dRHiX8dTg2mT
 DbynK5ekFYrzafMZoFFe790yv14Azbo2Hf19yv7/xTl8+Md4fF5pOBMq1utCjBEayw26
 Rb7a8RoTTKNv54lhuU1dRbzsNdpChtLIqn6utNRw9itazKkfvN5oEEMq4qFIN8dePC6x
 +CmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=6KIZ6JfOxYuwBpB4xSx5INRXqVKVkmQ/oSHbpTyBmM4=;
 b=MMHQa63pF6N0TZ4iGlovzKvv66I4dCOrKQ7QSMztOXRfT6lVW5JR4Vom53t0sZcXbi
 W8lwjhLLZ6f1+6iYiD8JJ+R+hizIZlFxSzK+gsoxGVvDlQ23b6NkY8mWDFD96DYS79YY
 hwCNNULYtQ4yVrYBaMGnWggj2qBUQCYmz3XEk9y2ixB1b1VLssuGD5qN7p3/BUS+9rQ/
 ePx2YAUIDYfiVW51L17cJOtBISKQ7cpysSVhjA4FZvpn3Imb6usa12i7ABR69qJS/4Mt
 7NWwQFRPAlxAq3z1+0+ogEhlZjLwhSCyOU5PsIZNdyCmjtVGoaki9kxWfMFztjmwNJxf
 cDaQ==
X-Gm-Message-State: AOAM530KaMVhQRfEXX11gc52nNmKw+Q2il1JhnHsrWwvxNKCk/x/O1CY
 2O+J5+uwJLycbZQv2AZbOBjd+6jxmkfdBVhQUPo=
X-Google-Smtp-Source: ABdhPJz/dkJ/x811rr1PkmhC127A+06hflCLL+0TP3V3J+GnbheBL8rvk7/IY4bO/LFV4p+BKkTDtOwhSu+MfUh9eyg=
X-Received: by 2002:a6b:6016:: with SMTP id r22mr12978647iog.42.1597681323948; 
 Mon, 17 Aug 2020 09:22:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200817140144.373403-1-edgar.iglesias@gmail.com>
 <20200817140144.373403-5-edgar.iglesias@gmail.com>
In-Reply-To: <20200817140144.373403-5-edgar.iglesias@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 17 Aug 2020 09:11:32 -0700
Message-ID: <CAKmqyKMDKY3moMwpd56VYzPuQtR91qZV=oaoqdLbq1RnZzyuSg@mail.gmail.com>
Subject: Re: [PATCH v1 4/5] target/microblaze: swx: Use atomic_cmpxchg
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d44;
 envelope-from=alistair23@gmail.com; helo=mail-io1-xd44.google.com
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
Cc: figlesia@xilinx.com, Peter Maydell <peter.maydell@linaro.org>,
 Edgar Iglesias <edgar.iglesias@xilinx.com>,
 Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>,
 Francisco Iglesias <frasse.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 Richard Henderson <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 Stefano Stabellini <sstabellini@kernel.org>, qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Luc Michel <luc.michel@greensocs.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Aug 17, 2020 at 7:04 AM Edgar E. Iglesias
<edgar.iglesias@gmail.com> wrote:
>
> From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
>
> Use atomic_cmpxchg to implement the atomic cmpxchg sequence.
>
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/microblaze/translate.c | 21 +++++++++++++--------
>  1 file changed, 13 insertions(+), 8 deletions(-)
>
> diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
> index c58f334a0f..530c15e5ad 100644
> --- a/target/microblaze/translate.c
> +++ b/target/microblaze/translate.c
> @@ -1075,14 +1075,16 @@ static void dec_store(DisasContext *dc)
>          swx_skip = gen_new_label();
>          tcg_gen_brcond_tl(TCG_COND_NE, env_res_addr, addr, swx_skip);
>
> -        /* Compare the value loaded at lwx with current contents of
> -           the reserved location.
> -           FIXME: This only works for system emulation where we can expect
> -           this compare and the following write to be atomic. For user
> -           emulation we need to add atomicity between threads.  */
> +        /*
> +         * Compare the value loaded at lwx with current contents of
> +         * the reserved location.
> +         */
>          tval = tcg_temp_new_i32();
> -        tcg_gen_qemu_ld_i32(tval, addr, cpu_mmu_index(&dc->cpu->env, false),
> -                            MO_TEUL);
> +
> +        tcg_gen_atomic_cmpxchg_i32(tval, addr, env_res_val,
> +                                   cpu_R[dc->rd], mem_index,
> +                                   mop);
> +
>          tcg_gen_brcond_i32(TCG_COND_NE, env_res_val, tval, swx_skip);
>          write_carryi(dc, 0);
>          tcg_temp_free_i32(tval);
> @@ -1108,7 +1110,10 @@ static void dec_store(DisasContext *dc)
>                  break;
>          }
>      }
> -    tcg_gen_qemu_st_i32(cpu_R[dc->rd], addr, mem_index, mop);
> +
> +    if (!ex) {
> +        tcg_gen_qemu_st_i32(cpu_R[dc->rd], addr, mem_index, mop);
> +    }
>
>      /* Verify alignment if needed.  */
>      if (dc->cpu->cfg.unaligned_exceptions && size > 1) {
> --
> 2.25.1
>
>

