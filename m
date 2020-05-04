Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6C76C3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 14:52:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AEDAB206B9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 14:52:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oEug5XuW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEDAB206B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60602 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVcSW-0004R3-3g
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 10:52:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48020)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1jVc98-0002hf-IF; Mon, 04 May 2020 10:32:39 -0400
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243]:42856)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1jVc96-0008K3-9H; Mon, 04 May 2020 10:32:38 -0400
Received: by mail-lj1-x243.google.com with SMTP id a21so9845294ljb.9;
 Mon, 04 May 2020 07:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=lgE9Ulxxtdf3kth7r5oCrNYZHgo7jqyXNAQuogxxTJ8=;
 b=oEug5XuW0C7yWbAyBqvFgEJFWiaPg8jLgEQHdolBnR1p3RvKd7JeTdjB4+acF+Viwu
 pghzziz5U9lY6b7rmJpvGSuKqWrWJS7jim5tFpDqvj84Af0WTDpF1LRtfQq+QUP8A7H7
 Jk5gztflFnV7C7i6bHg6rkaf12qZV7AsbgxEnVYA3lq2Uvfgtco1R9Vm89qrsPgHHL0K
 gg4ZLRIe3LcE121u+lYzAwBzpy07Inuvzqmg4oMzyTd9ne+2Kj3wUP1CQxff8cyy7SIS
 Zt3DlRH/pxIm/Lxw7d/yGW9II0AVV80mJITXf2ARlfj3ES7Ti3qBgkD9Yh9i30j3oq+I
 WIYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=lgE9Ulxxtdf3kth7r5oCrNYZHgo7jqyXNAQuogxxTJ8=;
 b=RH/pxGo4Bauiw3X/pJqbTowVmqgZ3Dqa4CQtF1IBUOlPgrle2ZSH7SY2tLT3AR15qi
 93aBvXs4MARQ5/Ljx1R8D0jKz+GZ1EpYID8JMyr1NAgxu0aRCWx9TMco+ZTTm2Ynh4xH
 M4NvPUB7R1pdQ0xfa9JBlVvFfzTyBMdYGv/MLbSAHvMgRhdKBzipjLvFDhix0olK+TrI
 sNW8y7gThCyE5UK5GwsMqPcBNjd5bqNaKvma68J+/8SELT4qv2yYFrrvnJvUAvYM7Re2
 8ETphlp9AD5v0Y0Rjoj5Ywk06X/nG8fbsiSNn5sbqt14EQ6YSurQhH7gTe0lShA7NvV0
 jNuw==
X-Gm-Message-State: AGi0PuYMR6gJEmqWlgw0jK/ec5PJgbWGmDyIRuu+MENgQUWfOfGo1pS4
 jBJzd+4isaNpX1bg17QBQ5k=
X-Google-Smtp-Source: APiQypIW5QuHFOnzXPjmNuubLusre6mX4yekPhrnCbupZ8GtR2RyXdHbujyLDj0FfEcCQBtfgWr2ZQ==
X-Received: by 2002:a2e:9055:: with SMTP id n21mr10678833ljg.46.1588602753918; 
 Mon, 04 May 2020 07:32:33 -0700 (PDT)
Received: from localhost (81-231-232-130-no39.tbcn.telia.com. [81.231.232.130])
 by smtp.gmail.com with ESMTPSA id h28sm9950916lfe.80.2020.05.04.07.32.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2020 07:32:33 -0700 (PDT)
Date: Mon, 4 May 2020 16:32:32 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
Subject: Re: [PATCH v2 03/10] net: cadence_gem: Fix irq update w.r.t queue
Message-ID: <20200504143232.GA5519@toto>
References: <1588601168-27576-1-git-send-email-sai.pavan.boddu@xilinx.com>
 <1588601168-27576-4-git-send-email-sai.pavan.boddu@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1588601168-27576-4-git-send-email-sai.pavan.boddu@xilinx.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Received-SPF: pass client-ip=2a00:1450:4864:20::243;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lj1-x243.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, Tong Ho <tong.ho@xilinx.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 Ramon Fried <rfried.dev@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, May 04, 2020 at 07:36:01PM +0530, Sai Pavan Boddu wrote:
> Set irq's specific to a queue, present implementation is setting q1 irq
> based on q0 status.


Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>



> 
> Signed-off-by: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
> ---
>  hw/net/cadence_gem.c | 25 +++----------------------
>  1 file changed, 3 insertions(+), 22 deletions(-)
> 
> diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
> index 6cb2f64..a930bf1 100644
> --- a/hw/net/cadence_gem.c
> +++ b/hw/net/cadence_gem.c
> @@ -554,29 +554,10 @@ static void gem_update_int_status(CadenceGEMState *s)
>  {
>      int i;
>  
> -    if (!s->regs[GEM_ISR]) {
> -        /* ISR isn't set, clear all the interrupts */
> -        for (i = 0; i < s->num_priority_queues; ++i) {
> -            qemu_set_irq(s->irq[i], 0);
> -        }
> -        return;
> -    }
> +    qemu_set_irq(s->irq[0], !!s->regs[GEM_ISR]);
>  
> -    /* If we get here we know s->regs[GEM_ISR] is set, so we don't need to
> -     * check it again.
> -     */
> -    if (s->num_priority_queues == 1) {
> -        /* No priority queues, just trigger the interrupt */
> -        DB_PRINT("asserting int.\n");
> -        qemu_set_irq(s->irq[0], 1);
> -        return;
> -    }
> -
> -    for (i = 0; i < s->num_priority_queues; ++i) {
> -        if (s->regs[GEM_INT_Q1_STATUS + i]) {
> -            DB_PRINT("asserting int. (q=%d)\n", i);
> -            qemu_set_irq(s->irq[i], 1);
> -        }
> +    for (i = 1; i < s->num_priority_queues; ++i) {
> +        qemu_set_irq(s->irq[i], !!s->regs[GEM_INT_Q1_STATUS + i - 1]);
>      }
>  }
>  
> -- 
> 2.7.4
> 

