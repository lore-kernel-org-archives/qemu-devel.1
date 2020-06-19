Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49996C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 21:29:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 123C221941
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 21:29:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SUygVtgP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 123C221941
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42918 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmOZf-0004it-CQ
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 17:29:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35486)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jmOYt-0004G9-Mt; Fri, 19 Jun 2020 17:28:35 -0400
Received: from mail-il1-x141.google.com ([2607:f8b0:4864:20::141]:39719)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jmOYs-0006aq-7H; Fri, 19 Jun 2020 17:28:35 -0400
Received: by mail-il1-x141.google.com with SMTP id p5so10673642ile.6;
 Fri, 19 Jun 2020 14:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=FQ60atYdbCpKWcd5W7Al0DMKGjezBEjbtwl+C00qbmo=;
 b=SUygVtgPZBygkiaZJkBtOSIkR5fL/wz+nzmNOpvku2FBKzeI6kogdYRP3uJL2/C6b0
 OPI9xqXHbmHPjhQnYnZuZ5gP0xuvEifMQFQRG4nG9fJMka1wnoGZsUAHve4EFSqMMOCc
 /HramkYZdw1f87VcMEWhiMFc2BzBzMbl8wedbrhSD9pfzkXq8iMebpbV35a1W+/1rCmL
 DEHGLxcTlNOJNLf44NYOzPVpZSgh/GmBJUzcGqL2/UqOd+EdeWf5A15S+j0cJ7TMdwf1
 2Wn/NyorucJ21Eh9inNDRIFMcCzg/8mL+ZtmwtpP5pY4l85nDtGwD+bariNZt0AdiaHQ
 cfkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=FQ60atYdbCpKWcd5W7Al0DMKGjezBEjbtwl+C00qbmo=;
 b=kRL4PX58Pom9CEV0nJa4CRGeA8+a5K7emSVJio3q+bgWwjEVXTvnYBoY0VtQr6HlmY
 gfzzY5h1p462oy43YfPV+E07V6bLZ4hz1DM1sCVkkoxMSwJzmOsQyE+7v+9vanEQ/yLl
 6JMsKYd/SRA7Gh+taeRKB0clkRTFuP5RF+uU22Z18IalTYsCjwww+qNMq0KjHgYgddXO
 Pps/KtelgHc1DJv76LNY66Fnyxlx4lWdbSrBPyp651Ahx/gne/PhKag0I4Jw0Eshbof8
 G1cw8Xls+54Yy+lh4IrV5iY2PY7xJnewqhvOafKRhMS5hxCWPWY9B22PyjzWVaYO65sr
 pgZA==
X-Gm-Message-State: AOAM5303tDMwkelQ+rKXiq0b3RNjcN1mWuoAQelbzwB0UyMNQHwoK31e
 XgJDV5AGpMUwXEWkYc2ATleqfp8Cu92SY+zzg5Y=
X-Google-Smtp-Source: ABdhPJwTQXBHfpbH6cjK+1vwlQOZm+AVbN5/m0sT50HAogwHHkpHFKXF+tzIWRr/ObVfbwKzLMgw6S9FY4pFRdnNJUg=
X-Received: by 2002:a92:d647:: with SMTP id x7mr5578284ilp.267.1592602112686; 
 Fri, 19 Jun 2020 14:28:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200618210649.22451-1-jrtc27@jrtc27.com>
In-Reply-To: <20200618210649.22451-1-jrtc27@jrtc27.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 19 Jun 2020 14:19:04 -0700
Message-ID: <CAKmqyKMSNiYWZtDRg2V6qCsYHVOAiUPcim_mTNEwY2pKjQ4SZQ@mail.gmail.com>
Subject: Re: [PATCH] riscv: plic: Add a couple of mising sifive_plic_update
 calls
To: Jessica Clarke <jrtc27@jrtc27.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::141;
 envelope-from=alistair23@gmail.com; helo=mail-il1-x141.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jun 18, 2020 at 2:07 PM Jessica Clarke <jrtc27@jrtc27.com> wrote:
>
> Claiming an interrupt and changing the source priority both potentially
> affect whether an interrupt is pending, thus we must re-compute xEIP.
> Note that we don't put the sifive_plic_update inside sifive_plic_claim
> so that the logging of a claim (and the resulting IRQ) happens before
> the state update, making the causal effect clear, and that we drop the
> explicit call to sifive_plic_print_state when claiming since
> sifive_plic_update already does that automatically at the end for us.
>
> This can result in both spurious interrupt storms if you fail to
> complete an IRQ before enabling interrupts (and no other actions occur
> that result in a call to sifive_plic_update), but also more importantly
> lost interrupts if a disabled interrupt is pending and then becomes
> enabled.
>
> Signed-off-by: Jessica Clarke <jrtc27@jrtc27.com>

Looks good to me!

Applied to the RISC-V tree

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/riscv/sifive_plic.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/hw/riscv/sifive_plic.c b/hw/riscv/sifive_plic.c
> index d91e82b8ab..c20c192034 100644
> --- a/hw/riscv/sifive_plic.c
> +++ b/hw/riscv/sifive_plic.c
> @@ -255,8 +255,8 @@ static uint64_t sifive_plic_read(void *opaque, hwaddr addr, unsigned size)
>                      plic->addr_config[addrid].hartid,
>                      mode_to_char(plic->addr_config[addrid].mode),
>                      value);
> -                sifive_plic_print_state(plic);
>              }
> +            sifive_plic_update(plic);
>              return value;
>          }
>      }
> @@ -287,6 +287,7 @@ static void sifive_plic_write(void *opaque, hwaddr addr, uint64_t value,
>              qemu_log("plic: write priority: irq=%d priority=%d\n",
>                  irq, plic->source_priority[irq]);
>          }
> +        sifive_plic_update(plic);
>          return;
>      } else if (addr >= plic->pending_base && /* 1 bit per source */
>                 addr < plic->pending_base + (plic->num_sources >> 3))
> --
> 2.20.1
>
>

