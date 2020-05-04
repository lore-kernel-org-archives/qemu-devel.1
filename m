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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30436C3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 14:47:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0A4F206D9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 14:47:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fMa0qpfa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0A4F206D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37390 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVcNQ-0002aV-PK
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 10:47:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49638)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1jVcJr-0005S6-1z; Mon, 04 May 2020 10:43:43 -0400
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242]:35400)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1jVcJn-0006rw-Jd; Mon, 04 May 2020 10:43:41 -0400
Received: by mail-lj1-x242.google.com with SMTP id g4so9940008ljl.2;
 Mon, 04 May 2020 07:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=OfKvkccqu1FZg1raEspi36fatxXhkuXGlT7Uesj0f10=;
 b=fMa0qpfappe7P5ER0d5byeF0JkfoGvmgtcaHZXsvvHVBjGESnmvI3fyiVFQbvd+5SU
 AsuMojNIws33PhExnkPDocWy5V2011hcMEuWhBOfImZA2FsWkckBMPF+NvswYY/2Vq/F
 xhAECbArZm4N8MWYcsihWIWeFkgRsSKbE0zNkU5yTaH4Nk84mwImAUYFIRscig6H63lY
 VocoNWry4UnrePezv8HRYVKx6A38Y/1SjHj1e97w21fr2fH6WSmpdv0XvjnNq5s9dvq6
 dvKLrxMxyfHNMJLwv2itNIwry2levx2se9cix9BMwHo2wemUmMK3oC9TqHNhIMg+y1i7
 ymSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=OfKvkccqu1FZg1raEspi36fatxXhkuXGlT7Uesj0f10=;
 b=iFPREr0GakYKtvYgi+GtBvVYvyvYb/A0nckSQ/KVcCOrwOZdx6EsiqVazzn2sggtYd
 tAQp3AG6HX4JiDuk7d7Lq84hobBk+l+QrGojJ3UZUen3D6ZrbhvOoSxNk9Cx8TUAzOLf
 TT3jpdzrVZwQJC2A5R/XuA+iJcTzJJF97VAPuPEtYy+a+7nVyJY78DIqHx+QyhJ248oF
 bTcjFAZrBVYrfVMrFRG5JwWs5sDUsiikZdvATOHtCr2awcKBi2wggEqk7jxn+utp294R
 pWjozEhtCtTtYMMbiFm3Ep1rZEdfZkFZqjdvUGrr5x32MUUxhYsKb8adwMB1m7aT+ql9
 cDHg==
X-Gm-Message-State: AGi0PuZYqyUGTWqLXzWTZwmlcryZ9zEC8Ja0v5V8da7V0Z8bHQ8BxjYu
 s7X3qjixipkl2X5PSweH81M=
X-Google-Smtp-Source: APiQypIAFExYSaIFGwQaycYJ3k3RUxTQauyAVerT4m9uD0Yrn2hB+C8VKnE65u1uFEmSnfSZc3YKzA==
X-Received: by 2002:a2e:7815:: with SMTP id t21mr10691773ljc.146.1588603417346; 
 Mon, 04 May 2020 07:43:37 -0700 (PDT)
Received: from localhost (81-231-232-130-no39.tbcn.telia.com. [81.231.232.130])
 by smtp.gmail.com with ESMTPSA id l25sm9927746lfh.71.2020.05.04.07.43.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2020 07:43:36 -0700 (PDT)
Date: Mon, 4 May 2020 16:43:35 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
Subject: Re: [PATCH v2 02/10] net: cadence_gem: Fix the queue address update
 during wrap around
Message-ID: <20200504144335.GC5519@toto>
References: <1588601168-27576-1-git-send-email-sai.pavan.boddu@xilinx.com>
 <1588601168-27576-3-git-send-email-sai.pavan.boddu@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1588601168-27576-3-git-send-email-sai.pavan.boddu@xilinx.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Received-SPF: pass client-ip=2a00:1450:4864:20::242;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lj1-x242.google.com
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

On Mon, May 04, 2020 at 07:36:00PM +0530, Sai Pavan Boddu wrote:
> During wrap around and reset, queues are pointing to initial base
> address of queue 0, irrespective of what queue we are dealing with.
> Fix it by assigning proper base address every time.

Might want to add wrappers e.g:
static inline uint32_t gem_get_rx_queue_base_addr(CadenceGEMState *s, int q) {
    gem_get_queue_base_addr(s, false, q); 
}

static inline uint32_t gem_get_tx_queue_base_addr(CadenceGEMState *s, int q) {
    gem_get_queue_base_addr(s, true, q); 
}

It makes the packet processing logic a little easier to read, e.g:

s->rx_desc_addr[q] = gem_get_rx_queue_base_addr(s, q);
vs
s->rx_desc_addr[q] = gem_get_queue_base_addr(s, false, q);

Anyway, this looks good to me:
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>



> 
> Signed-off-by: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
> ---
>  hw/net/cadence_gem.c | 29 +++++++++++++++++++++++++----
>  1 file changed, 25 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
> index 2f244eb..6cb2f64 100644
> --- a/hw/net/cadence_gem.c
> +++ b/hw/net/cadence_gem.c
> @@ -845,6 +845,25 @@ static int get_queue_from_screen(CadenceGEMState *s, uint8_t *rxbuf_ptr,
>      return 0;
>  }
>  
> +static uint32_t gem_get_queue_base_addr(CadenceGEMState *s, bool tx, int q)
> +{
> +    uint32_t base_addr = 0;
> +
> +    switch (q) {
> +    case 0:
> +        base_addr = s->regs[tx ? GEM_TXQBASE : GEM_RXQBASE];
> +        break;
> +    case 1 ... (MAX_PRIORITY_QUEUES - 1):
> +        base_addr = s->regs[(tx ? GEM_TRANSMIT_Q1_PTR :
> +                                 GEM_RECEIVE_Q1_PTR) + q - 1];
> +        break;
> +    default:
> +        g_assert_not_reached();
> +    };
> +
> +    return base_addr;
> +}
> +
>  static hwaddr gem_get_desc_addr(CadenceGEMState *s, bool tx, int q)
>  {
>      hwaddr desc_addr = 0;
> @@ -1044,7 +1063,7 @@ static ssize_t gem_receive(NetClientState *nc, const uint8_t *buf, size_t size)
>          /* Next descriptor */
>          if (rx_desc_get_wrap(s->rx_desc[q])) {
>              DB_PRINT("wrapping RX descriptor list\n");
> -            s->rx_desc_addr[q] = s->regs[GEM_RXQBASE];
> +            s->rx_desc_addr[q] = gem_get_queue_base_addr(s, false, q);
>          } else {
>              DB_PRINT("incrementing RX descriptor list\n");
>              s->rx_desc_addr[q] += 4 * gem_get_desc_len(s, true);
> @@ -1200,7 +1219,8 @@ static void gem_transmit(CadenceGEMState *s)
>                                      sizeof(desc_first));
>                  /* Advance the hardware current descriptor past this packet */
>                  if (tx_desc_get_wrap(desc)) {
> -                    s->tx_desc_addr[q] = s->regs[GEM_TXQBASE];
> +                    s->tx_desc_addr[q] = gem_get_queue_base_addr(s,
> +                                         true, q);
>                  } else {
>                      s->tx_desc_addr[q] = packet_desc_addr +
>                                           4 * gem_get_desc_len(s, false);
> @@ -1252,7 +1272,8 @@ static void gem_transmit(CadenceGEMState *s)
>                  } else {
>                      packet_desc_addr = 0;
>                  }
> -                packet_desc_addr |= s->regs[GEM_TXQBASE];
> +                packet_desc_addr |= gem_get_queue_base_addr(s,
> +                                    true, q);
>              } else {
>                  packet_desc_addr += 4 * gem_get_desc_len(s, false);
>              }
> @@ -1458,7 +1479,7 @@ static void gem_write(void *opaque, hwaddr offset, uint64_t val,
>          if (!(val & GEM_NWCTRL_TXENA)) {
>              /* Reset to start of Q when transmit disabled. */
>              for (i = 0; i < s->num_priority_queues; i++) {
> -                s->tx_desc_addr[i] = s->regs[GEM_TXQBASE];
> +                s->tx_desc_addr[i] = gem_get_queue_base_addr(s, true, i);
>              }
>          }
>          if (gem_can_receive(qemu_get_queue(s->nic))) {
> -- 
> 2.7.4
> 

