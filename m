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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7499C47254
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 14:22:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9206520838
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 14:22:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mtQkwWP7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9206520838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33840 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVySx-0007TR-NT
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 10:22:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58340)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frasse.iglesias@gmail.com>)
 id 1jVyR4-0004gm-Fw; Tue, 05 May 2020 10:20:38 -0400
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243]:45424)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frasse.iglesias@gmail.com>)
 id 1jVyR3-0008QX-C3; Tue, 05 May 2020 10:20:38 -0400
Received: by mail-lj1-x243.google.com with SMTP id h4so1785495ljg.12;
 Tue, 05 May 2020 07:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=O5IYLb/GECU4jv4t9QZ3dvCDGBJ13r9xQkJk3e4hnmc=;
 b=mtQkwWP7m9TMTU67FUq0CiqUA+Lb875Dm4R1nmPEPz5J+XsE0Y1/KVP28I+0fcLPEV
 YOX61Qu6PzvOlcJo6KnciMDYXCO7SLs2n5mz45bJMtf/evmjoGrvyCuCRqnQKiZmMTHH
 NyKUKSCuwHifkn9tD5Z721OSOJK0jZ94XxdMT42LKlTp/+xI+cxeaGMtKMN1a34msKjB
 goy3q2AalYQoYEWW4NzmcFC4+/6NzqlWSffNCGEqKbUbT8D7oe9Ql0JjUphrC7kypU/x
 yE13mATcsnt7f+YwzHK6ORps6sl9nTrRjM2Ws9aTRFZSTboKu98saXo3HbBLZLTgra7i
 ePEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=O5IYLb/GECU4jv4t9QZ3dvCDGBJ13r9xQkJk3e4hnmc=;
 b=TpHrpc5QL6YnllEwyIExK7/LdqGtoIvGBLeu6KlGqgEYbFTucSn6sAz5CQpC/1wCA4
 uMMBZcYZq2+vzP9xE/7GnbMMa/Yt9HYIWSnNhFIJqHBEBUovkcCjLxFRCtnm8yoWiVvT
 WIzVfBlChWb98qKbRMDtMWpBLcZDI8y3/gs2hPUB992ovdMMp32fFwLY8jO0yIKr5Im2
 oxC0w9HMJNA2bAzJJw13cOejkTdpDXUSx/R/roXocyWLme+EhfKmaLs1y2H+tIHnjTMD
 Vl/bkxh18HRSprh42KguaEAMCb2MRci9HmolieGv5LKbcpuuudn0biYZjtk0SElSKtkw
 eH3Q==
X-Gm-Message-State: AGi0PuY8/SQLY0GtY7jTkcBTA0wMbgi9zm491lSzN5QqJoAk4X8C32BW
 oMpG0EEhZB6vjXJ3kiwfr/b2Bcl72PE=
X-Google-Smtp-Source: APiQypLIWbwecxM5LTfaWcZ0vXqhg+e0MtGM480b3wjw9EIyG1MWLHyleoIj5ZP0frpAdYy1cQfCwg==
X-Received: by 2002:a2e:9d83:: with SMTP id c3mr1986243ljj.90.1588688435163;
 Tue, 05 May 2020 07:20:35 -0700 (PDT)
Received: from fralle-msi (31-208-27-151.cust.bredband2.com. [31.208.27.151])
 by smtp.gmail.com with ESMTPSA id
 125sm1994112lfc.75.2020.05.05.07.20.34
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 05 May 2020 07:20:34 -0700 (PDT)
Date: Tue, 5 May 2020 16:20:32 +0200
From: Francisco Iglesias <frasse.iglesias@gmail.com>
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Subject: Re: [PATCH v1 5/9] hw/core: stream: Add an end-of-packet flag
Message-ID: <20200505142032.n2gvierijhuppkxy@fralle-msi>
References: <20200430162439.2659-1-edgar.iglesias@gmail.com>
 <20200430162439.2659-6-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200430162439.2659-6-edgar.iglesias@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Received-SPF: pass client-ip=2a00:1450:4864:20::243;
 envelope-from=frasse.iglesias@gmail.com; helo=mail-lj1-x243.google.com
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

On [2020 Apr 30] Thu 18:24:35, Edgar E. Iglesias wrote:
> From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
> 
> Some stream clients stream an endless stream of data while
> other clients stream data in packets. Stream interfaces
> usually have a way to signal the end of a packet or the
> last beat of a transfer.
> 
> This adds an end-of-packet flag to the push interface.
> 
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>

Reviewed-by: Francisco Iglesias <frasse.iglesias@gmail.com>

> ---
>  include/hw/stream.h     |  5 +++--
>  hw/core/stream.c        |  4 ++--
>  hw/dma/xilinx_axidma.c  | 10 ++++++----
>  hw/net/xilinx_axienet.c | 14 ++++++++++----
>  hw/ssi/xilinx_spips.c   |  2 +-
>  5 files changed, 22 insertions(+), 13 deletions(-)
> 
> diff --git a/include/hw/stream.h b/include/hw/stream.h
> index d02f62ca89..ed09e83683 100644
> --- a/include/hw/stream.h
> +++ b/include/hw/stream.h
> @@ -39,12 +39,13 @@ typedef struct StreamSlaveClass {
>       * @obj: Stream slave to push to
>       * @buf: Data to write
>       * @len: Maximum number of bytes to write
> +     * @eop: End of packet flag
>       */
> -    size_t (*push)(StreamSlave *obj, unsigned char *buf, size_t len);
> +    size_t (*push)(StreamSlave *obj, unsigned char *buf, size_t len, bool eop);
>  } StreamSlaveClass;
>  
>  size_t
> -stream_push(StreamSlave *sink, uint8_t *buf, size_t len);
> +stream_push(StreamSlave *sink, uint8_t *buf, size_t len, bool eop);
>  
>  bool
>  stream_can_push(StreamSlave *sink, StreamCanPushNotifyFn notify,
> diff --git a/hw/core/stream.c b/hw/core/stream.c
> index 39b1e595cd..a65ad1208d 100644
> --- a/hw/core/stream.c
> +++ b/hw/core/stream.c
> @@ -3,11 +3,11 @@
>  #include "qemu/module.h"
>  
>  size_t
> -stream_push(StreamSlave *sink, uint8_t *buf, size_t len)
> +stream_push(StreamSlave *sink, uint8_t *buf, size_t len, bool eop)
>  {
>      StreamSlaveClass *k =  STREAM_SLAVE_GET_CLASS(sink);
>  
> -    return k->push(sink, buf, len);
> +    return k->push(sink, buf, len, eop);
>  }
>  
>  bool
> diff --git a/hw/dma/xilinx_axidma.c b/hw/dma/xilinx_axidma.c
> index 4540051448..a770e12c96 100644
> --- a/hw/dma/xilinx_axidma.c
> +++ b/hw/dma/xilinx_axidma.c
> @@ -283,7 +283,7 @@ static void stream_process_mem2s(struct Stream *s, StreamSlave *tx_data_dev,
>  
>          if (stream_desc_sof(&s->desc)) {
>              s->pos = 0;
> -            stream_push(tx_control_dev, s->desc.app, sizeof(s->desc.app));
> +            stream_push(tx_control_dev, s->desc.app, sizeof(s->desc.app), true);
>          }
>  
>          txlen = s->desc.control & SDESC_CTRL_LEN_MASK;
> @@ -298,7 +298,7 @@ static void stream_process_mem2s(struct Stream *s, StreamSlave *tx_data_dev,
>          s->pos += txlen;
>  
>          if (stream_desc_eof(&s->desc)) {
> -            stream_push(tx_data_dev, s->txbuf, s->pos);
> +            stream_push(tx_data_dev, s->txbuf, s->pos, true);
>              s->pos = 0;
>              stream_complete(s);
>          }
> @@ -384,7 +384,7 @@ static void xilinx_axidma_reset(DeviceState *dev)
>  
>  static size_t
>  xilinx_axidma_control_stream_push(StreamSlave *obj, unsigned char *buf,
> -                                  size_t len)
> +                                  size_t len, bool eop)
>  {
>      XilinxAXIDMAStreamSlave *cs = XILINX_AXI_DMA_CONTROL_STREAM(obj);
>      struct Stream *s = &cs->dma->streams[1];
> @@ -416,12 +416,14 @@ xilinx_axidma_data_stream_can_push(StreamSlave *obj,
>  }
>  
>  static size_t
> -xilinx_axidma_data_stream_push(StreamSlave *obj, unsigned char *buf, size_t len)
> +xilinx_axidma_data_stream_push(StreamSlave *obj, unsigned char *buf, size_t len,
> +                               bool eop)
>  {
>      XilinxAXIDMAStreamSlave *ds = XILINX_AXI_DMA_DATA_STREAM(obj);
>      struct Stream *s = &ds->dma->streams[1];
>      size_t ret;
>  
> +    assert(eop);
>      ret = stream_process_s2mem(s, buf, len);
>      stream_update_irq(s);
>      return ret;
> diff --git a/hw/net/xilinx_axienet.c b/hw/net/xilinx_axienet.c
> index c8dfcda3ee..bd48305577 100644
> --- a/hw/net/xilinx_axienet.c
> +++ b/hw/net/xilinx_axienet.c
> @@ -697,14 +697,14 @@ static void axienet_eth_rx_notify(void *opaque)
>                                             axienet_eth_rx_notify, s)) {
>          size_t ret = stream_push(s->tx_control_dev,
>                                   (void *)s->rxapp + CONTROL_PAYLOAD_SIZE
> -                                 - s->rxappsize, s->rxappsize);
> +                                 - s->rxappsize, s->rxappsize, true);
>          s->rxappsize -= ret;
>      }
>  
>      while (s->rxsize && stream_can_push(s->tx_data_dev,
>                                          axienet_eth_rx_notify, s)) {
>          size_t ret = stream_push(s->tx_data_dev, (void *)s->rxmem + s->rxpos,
> -                                 s->rxsize);
> +                                 s->rxsize, true);
>          s->rxsize -= ret;
>          s->rxpos += ret;
>          if (!s->rxsize) {
> @@ -874,12 +874,14 @@ static ssize_t eth_rx(NetClientState *nc, const uint8_t *buf, size_t size)
>  }
>  
>  static size_t
> -xilinx_axienet_control_stream_push(StreamSlave *obj, uint8_t *buf, size_t len)
> +xilinx_axienet_control_stream_push(StreamSlave *obj, uint8_t *buf, size_t len,
> +                                   bool eop)
>  {
>      int i;
>      XilinxAXIEnetStreamSlave *cs = XILINX_AXI_ENET_CONTROL_STREAM(obj);
>      XilinxAXIEnet *s = cs->enet;
>  
> +    assert(eop);
>      if (len != CONTROL_PAYLOAD_SIZE) {
>          hw_error("AXI Enet requires %d byte control stream payload\n",
>                   (int)CONTROL_PAYLOAD_SIZE);
> @@ -894,11 +896,15 @@ xilinx_axienet_control_stream_push(StreamSlave *obj, uint8_t *buf, size_t len)
>  }
>  
>  static size_t
> -xilinx_axienet_data_stream_push(StreamSlave *obj, uint8_t *buf, size_t size)
> +xilinx_axienet_data_stream_push(StreamSlave *obj, uint8_t *buf, size_t size,
> +                                bool eop)
>  {
>      XilinxAXIEnetStreamSlave *ds = XILINX_AXI_ENET_DATA_STREAM(obj);
>      XilinxAXIEnet *s = ds->enet;
>  
> +    /* We don't support fragmented packets yet.  */
> +    assert(eop);
> +
>      /* TX enable ?  */
>      if (!(s->tc & TC_TX)) {
>          return size;
> diff --git a/hw/ssi/xilinx_spips.c b/hw/ssi/xilinx_spips.c
> index c57850a505..4cfce882ab 100644
> --- a/hw/ssi/xilinx_spips.c
> +++ b/hw/ssi/xilinx_spips.c
> @@ -868,7 +868,7 @@ static void xlnx_zynqmp_qspips_notify(void *opaque)
>  
>          memcpy(rq->dma_buf, rxd, num);
>  
> -        ret = stream_push(rq->dma, rq->dma_buf, num);
> +        ret = stream_push(rq->dma, rq->dma_buf, num, false);
>          assert(ret == num);
>          xlnx_zynqmp_qspips_check_flush(rq);
>      }
> -- 
> 2.20.1
> 

