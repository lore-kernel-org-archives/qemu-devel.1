Return-Path: <SRS0=NBT7=6W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABAACC38A2A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 11:27:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75BAA206D6
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 11:27:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k81mc9zz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75BAA206D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44068 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jX1A0-0000oi-M3
	for qemu-devel@archiver.kernel.org; Fri, 08 May 2020 07:27:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60154)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1jX18y-0008LQ-7v; Fri, 08 May 2020 07:26:16 -0400
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244]:36238)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1jX18x-0005v3-BE; Fri, 08 May 2020 07:26:15 -0400
Received: by mail-lj1-x244.google.com with SMTP id u15so1291797ljd.3;
 Fri, 08 May 2020 04:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=ttI5KK4hgA95nb8HMd+yUteR0hkZwnjuSGYFdDVU2Ww=;
 b=k81mc9zzA0H9fi2Wj8s9oClqqv8eTjpovc/78sXMuyVSK6VgDTrLIX9Dy3YPgf27Xs
 4Y+l2o826kRlJujjASJgZVcmlWmqed//oN9BPWqwmZmG2YGLtb4X2shsQeH0LxMF0MIU
 3X6x1nz4AiYv2w3uDdpOuOP7ogCiNAKkk04Ydvu8jhpIwCTIGk4SXDGiBxBTKZ+xLE9/
 AH7pyZmUhYHByqAIETBjhP/CDot9ni928ja0mswCJ7D5JYf7u4Sk2KM11THckZHhzY6O
 q5tkxFmpL3el3KqlJrmQ5DFZGmNnyU1JMwEZzNhnGcFWfq5V/0fy0GBJSuwfnta10dnQ
 K+Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=ttI5KK4hgA95nb8HMd+yUteR0hkZwnjuSGYFdDVU2Ww=;
 b=KoxUX7NBHg7GhBk/kuGM6VeCvsBoco2uwhwepDoEuqO3wWdFECvSECL40X+Lix8wo8
 yxbd9B/+WItG6J8QfPTpm+nJyvsqtSM5RpqUSYcBwXKZiU7nxt5216Nli2JNx0wQtxyU
 RDM6N1C24UhzE1N233FEed/lKiRSdjDrtV12s3AxN66XHCKWAnnLRBYD8mCIJFVlBbG8
 S/m8DoudhGLEHFJCDeFgE1PPTv8G4qxcVGzVJw022L5tWDEL6dnbzgkYxQOoIc5bjuxU
 gQCPti7UQmx5P+497OoVYbv04KSV0STsfZTrcEMVmGaMrFaU0PDp9lhj0Ea4A+5FGyYp
 3DeQ==
X-Gm-Message-State: AOAM531XhfrZuofdUHgwWVqzjuSMF+pbdyqPJq8KXtAce5wDffcV4QJo
 rUjkd5V55tKhS3fz5Tt8iuY=
X-Google-Smtp-Source: ABdhPJzYBeVg2uzXiwUvuNCSdTktjTQnaKAWgWlRuKa9aWerv9QAReVFkL8fjk6JVD40i5+Zc/ScOQ==
X-Received: by 2002:a2e:8e68:: with SMTP id t8mr1344709ljk.93.1588937172944;
 Fri, 08 May 2020 04:26:12 -0700 (PDT)
Received: from localhost (81-231-232-130-no39.tbcn.telia.com. [81.231.232.130])
 by smtp.gmail.com with ESMTPSA id d9sm985765lfa.77.2020.05.08.04.26.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2020 04:26:12 -0700 (PDT)
Date: Fri, 8 May 2020 13:25:56 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
Subject: Re: [PATCH v3 02/11] net: cadence_gem: Fix the queue address update
 during wrap around
Message-ID: <20200508112556.GM5519@toto>
References: <1588935645-20351-1-git-send-email-sai.pavan.boddu@xilinx.com>
 <1588935645-20351-3-git-send-email-sai.pavan.boddu@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1588935645-20351-3-git-send-email-sai.pavan.boddu@xilinx.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Received-SPF: pass client-ip=2a00:1450:4864:20::244;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lj1-x244.google.com
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

On Fri, May 08, 2020 at 04:30:36PM +0530, Sai Pavan Boddu wrote:
> During wrap around and reset, queues are pointing to initial base
> address of queue 0, irrespective of what queue we are dealing with.
> Fix it by assigning proper base address every time.

Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>



> 
> Signed-off-by: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
> ---
>  hw/net/cadence_gem.c | 37 +++++++++++++++++++++++++++++++++----
>  1 file changed, 33 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
> index 5476c62..e6dc436 100644
> --- a/hw/net/cadence_gem.c
> +++ b/hw/net/cadence_gem.c
> @@ -845,6 +845,35 @@ static int get_queue_from_screen(CadenceGEMState *s, uint8_t *rxbuf_ptr,
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
> +static uint32_t gem_get_tx_queue_base_addr(CadenceGEMState *s, int q)
> +{
> +    return gem_get_queue_base_addr(s, true, q);
> +}
> +
> +static uint32_t gem_get_rx_queue_base_addr(CadenceGEMState *s, int q)
> +{
> +    return gem_get_queue_base_addr(s, false, q);
> +}
> +
>  static hwaddr gem_get_desc_addr(CadenceGEMState *s, bool tx, int q)
>  {
>      hwaddr desc_addr = 0;
> @@ -1043,7 +1072,7 @@ static ssize_t gem_receive(NetClientState *nc, const uint8_t *buf, size_t size)
>          /* Next descriptor */
>          if (rx_desc_get_wrap(s->rx_desc[q])) {
>              DB_PRINT("wrapping RX descriptor list\n");
> -            s->rx_desc_addr[q] = s->regs[GEM_RXQBASE];
> +            s->rx_desc_addr[q] = gem_get_rx_queue_base_addr(s, q);
>          } else {
>              DB_PRINT("incrementing RX descriptor list\n");
>              s->rx_desc_addr[q] += 4 * gem_get_desc_len(s, true);
> @@ -1199,7 +1228,7 @@ static void gem_transmit(CadenceGEMState *s)
>                                      sizeof(desc_first));
>                  /* Advance the hardware current descriptor past this packet */
>                  if (tx_desc_get_wrap(desc)) {
> -                    s->tx_desc_addr[q] = s->regs[GEM_TXQBASE];
> +                    s->tx_desc_addr[q] = gem_get_tx_queue_base_addr(s, q);
>                  } else {
>                      s->tx_desc_addr[q] = packet_desc_addr +
>                                           4 * gem_get_desc_len(s, false);
> @@ -1251,7 +1280,7 @@ static void gem_transmit(CadenceGEMState *s)
>                  } else {
>                      packet_desc_addr = 0;
>                  }
> -                packet_desc_addr |= s->regs[GEM_TXQBASE];
> +                packet_desc_addr |= gem_get_tx_queue_base_addr(s, q);
>              } else {
>                  packet_desc_addr += 4 * gem_get_desc_len(s, false);
>              }
> @@ -1457,7 +1486,7 @@ static void gem_write(void *opaque, hwaddr offset, uint64_t val,
>          if (!(val & GEM_NWCTRL_TXENA)) {
>              /* Reset to start of Q when transmit disabled. */
>              for (i = 0; i < s->num_priority_queues; i++) {
> -                s->tx_desc_addr[i] = s->regs[GEM_TXQBASE];
> +                s->tx_desc_addr[i] = gem_get_tx_queue_base_addr(s, i);
>              }
>          }
>          if (gem_can_receive(qemu_get_queue(s->nic))) {
> -- 
> 2.7.4
> 

