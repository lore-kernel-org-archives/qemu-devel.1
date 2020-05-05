Return-Path: <SRS0=1jZz=6T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDD57C47247
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 14:22:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9DDF206FA
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 14:22:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZR1S50kv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9DDF206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33008 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVySn-00077j-Pl
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 10:22:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58426)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frasse.iglesias@gmail.com>)
 id 1jVyRV-0005Xb-Bk; Tue, 05 May 2020 10:21:05 -0400
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241]:39446)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frasse.iglesias@gmail.com>)
 id 1jVyRU-0000IW-Cf; Tue, 05 May 2020 10:21:04 -0400
Received: by mail-lj1-x241.google.com with SMTP id u6so1803692ljl.6;
 Tue, 05 May 2020 07:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=KZyJQW59bcZv/Ekdhw0v6AowibzpULuUp7paHvVY9Ms=;
 b=ZR1S50kvTG/G0OhfBGTB91cPhggzPtzaYGpgMK8mFsS8KaPO0uAy4q8p3WtR1vkRF5
 ze4f6X4PAzVrO9PRjjOxv+yfCMeCw/d5txi0iI1hFXIwK07ripF+k6I+7A+WawibjcuY
 PNF2fZWFSBWY14EFJJe0z7OT0axHMseMQo4tSA3dsiQ+CBrHoMqusltUMT/GhmcEWFwD
 93JN8p+RPJCQUctYieiTSn4+SAiZCPuiV8L+rNKEF4fGyL4ZZ4xPvkvL/m9asKKtBW2e
 731+7RuGY39ANNSxXne0GAw9DvrLuzGIoWm9+wt1zXytRWMSbxmMJ4VqFgtYXVBGcmuE
 Bacg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=KZyJQW59bcZv/Ekdhw0v6AowibzpULuUp7paHvVY9Ms=;
 b=ffBIx7kMtdhxG/1RrB9CoQsJPN9mriTf41FepENFCSQ/LatqTx4eiNpYg0REBznUDH
 21m6wM/bNOHGrcOGEiRDckxCeRLXcCnzMGgHKrvOAuNaLA8ULRR1mg78pnBPEmOo8mTa
 HgFGixc/PEK2FLpHjb9WN84JcpCbJJTpbSZmegECVpo5J3QcNQJwO/yfLwnfttkGXe+t
 s5zjj4BFI2CkL9xw0J3d3OYXyUvG9XhxOCtONJLO4DM0xVHrxs5WlOMc985NpSDT/cAU
 iNzmKNRjT9/51q86u6CXf1B6sqnzUxjj69uQb71m53cQdIMJy7ttnG18wDqqRrnBo2Rk
 ANFw==
X-Gm-Message-State: AGi0PuZtGnSpm9x2i94XgRE996xuZW2ypulhW/NSyMbLCIkAA2AEXM6K
 8nrm7AWx2axR2GhSaTBfoUY=
X-Google-Smtp-Source: APiQypKC+NQkfva7K+4hUTsP3EQnvUtiAYmXdZ76XiaN3m8+qXS3Ap9N8YrCGUly+PPYksFfImfeuQ==
X-Received: by 2002:a2e:82c7:: with SMTP id n7mr2046595ljh.47.1588688462329;
 Tue, 05 May 2020 07:21:02 -0700 (PDT)
Received: from fralle-msi (31-208-27-151.cust.bredband2.com. [31.208.27.151])
 by smtp.gmail.com with ESMTPSA id
 j2sm1936938lfm.68.2020.05.05.07.21.01
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 05 May 2020 07:21:01 -0700 (PDT)
Date: Tue, 5 May 2020 16:20:59 +0200
From: Francisco Iglesias <frasse.iglesias@gmail.com>
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Subject: Re: [PATCH v1 6/9] hw/net/xilinx_axienet: Handle fragmented packets
 from DMA
Message-ID: <20200505142059.x2r5f6uxc22ttobu@fralle-msi>
References: <20200430162439.2659-1-edgar.iglesias@gmail.com>
 <20200430162439.2659-7-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200430162439.2659-7-edgar.iglesias@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Received-SPF: pass client-ip=2a00:1450:4864:20::241;
 envelope-from=frasse.iglesias@gmail.com; helo=mail-lj1-x241.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -1020
X-Spam_score: -102.1
X-Spam_bar: ---------------------------------------------------
X-Spam_report: (-102.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001,
 USER_IN_WHITELIST=-100 autolearn=_AUTOLEARN
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
Cc: damien.hedde@greensocs.com, peter.maydell@linaro.org,
 sstabellini@kernel.org, edgar.iglesias@xilinx.com, sai.pavan.boddu@xilinx.com,
 jasowang@redhat.com, alistair@alistair23.me, qemu-devel@nongnu.org,
 frederic.konrad@adacore.com, qemu-arm@nongnu.org, philmd@redhat.com,
 luc.michel@greensocs.com, figlesia@xilinx.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On [2020 Apr 30] Thu 18:24:36, Edgar E. Iglesias wrote:
> From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
> 
> Add support for fragmented packets from the DMA.
> 
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>

Reviewed-by: Francisco Iglesias <frasse.iglesias@gmail.com>

> ---
>  hw/net/xilinx_axienet.c | 31 ++++++++++++++++++++++++-------
>  1 file changed, 24 insertions(+), 7 deletions(-)
> 
> diff --git a/hw/net/xilinx_axienet.c b/hw/net/xilinx_axienet.c
> index bd48305577..e3826cf3fc 100644
> --- a/hw/net/xilinx_axienet.c
> +++ b/hw/net/xilinx_axienet.c
> @@ -402,6 +402,9 @@ struct XilinxAXIEnet {
>  
>      uint32_t hdr[CONTROL_PAYLOAD_WORDS];
>  
> +    uint8_t *txmem;
> +    uint32_t txpos;
> +
>      uint8_t *rxmem;
>      uint32_t rxsize;
>      uint32_t rxpos;
> @@ -421,6 +424,7 @@ static void axienet_rx_reset(XilinxAXIEnet *s)
>  static void axienet_tx_reset(XilinxAXIEnet *s)
>  {
>      s->tc = TC_JUM | TC_TX | TC_VLAN;
> +    s->txpos = 0;
>  }
>  
>  static inline int axienet_rx_resetting(XilinxAXIEnet *s)
> @@ -902,17 +906,28 @@ xilinx_axienet_data_stream_push(StreamSlave *obj, uint8_t *buf, size_t size,
>      XilinxAXIEnetStreamSlave *ds = XILINX_AXI_ENET_DATA_STREAM(obj);
>      XilinxAXIEnet *s = ds->enet;
>  
> -    /* We don't support fragmented packets yet.  */
> -    assert(eop);
> -
>      /* TX enable ?  */
>      if (!(s->tc & TC_TX)) {
>          return size;
>      }
>  
> +    if (s->txpos == 0 && eop) {
> +        /* Fast path single fragment.  */
> +        s->txpos = size;
> +    } else {
> +        memcpy(s->txmem + s->txpos, buf, size);
> +        buf = s->txmem;
> +        s->txpos += size;
> +
> +        if (!eop) {
> +            return size;
> +        }
> +    }
> +
>      /* Jumbo or vlan sizes ?  */
>      if (!(s->tc & TC_JUM)) {
> -        if (size > 1518 && size <= 1522 && !(s->tc & TC_VLAN)) {
> +        if (s->txpos > 1518 && s->txpos <= 1522 && !(s->tc & TC_VLAN)) {
> +            s->txpos = 0;
>              return size;
>          }
>      }
> @@ -923,7 +938,7 @@ xilinx_axienet_data_stream_push(StreamSlave *obj, uint8_t *buf, size_t size,
>          uint32_t tmp_csum;
>          uint16_t csum;
>  
> -        tmp_csum = net_checksum_add(size - start_off,
> +        tmp_csum = net_checksum_add(s->txpos - start_off,
>                                      buf + start_off);
>          /* Accumulate the seed.  */
>          tmp_csum += s->hdr[2] & 0xffff;
> @@ -936,12 +951,13 @@ xilinx_axienet_data_stream_push(StreamSlave *obj, uint8_t *buf, size_t size,
>          buf[write_off + 1] = csum & 0xff;
>      }
>  
> -    qemu_send_packet(qemu_get_queue(s->nic), buf, size);
> +    qemu_send_packet(qemu_get_queue(s->nic), buf, s->txpos);
>  
> -    s->stats.tx_bytes += size;
> +    s->stats.tx_bytes += s->txpos;
>      s->regs[R_IS] |= IS_TX_COMPLETE;
>      enet_update_irq(s);
>  
> +    s->txpos = 0;
>      return size;
>  }
>  
> @@ -989,6 +1005,7 @@ static void xilinx_enet_realize(DeviceState *dev, Error **errp)
>      s->TEMAC.parent = s;
>  
>      s->rxmem = g_malloc(s->c_rxmem);
> +    s->txmem = g_malloc(s->c_txmem);
>      return;
>  
>  xilinx_enet_realize_fail:
> -- 
> 2.20.1
> 

