Return-Path: <SRS0=NBT7=6W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18DF5C47254
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 11:31:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA2CC208E4
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 11:31:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zg44ct2v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA2CC208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46754 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jX1Dg-00035F-22
	for qemu-devel@archiver.kernel.org; Fri, 08 May 2020 07:31:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32796)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1jX1Ch-0002RX-1T; Fri, 08 May 2020 07:30:07 -0400
Received: from mail-lf1-x143.google.com ([2a00:1450:4864:20::143]:37222)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1jX1Cg-0005L9-15; Fri, 08 May 2020 07:30:06 -0400
Received: by mail-lf1-x143.google.com with SMTP id t11so1140462lfe.4;
 Fri, 08 May 2020 04:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=9qo89ZBDPvbx5XzA56F/vtCd71kZmWqz536FwRQK3ek=;
 b=Zg44ct2volCR8XxvSzlCg2ef38YnHlHmHwgDLYRYMYqOa/kqh122P6AAfVkkm0vKLB
 UtpX7OgL84qbV3kmC7TkADkCaLDQK+6iTwUoHJe2bZ7D8nOXE8POcfZ+dZuH+vz4wkwl
 LJ1KDw02MvowQWnQe9Thw+MLDqS160qsw5EA2FjkFzhR5xEStVsnS6MMgOg2CovaeVws
 l3ffQJgAYvJxUGcgCKB+xGGrVGzKSDw4lOpBBjqj5YrysY5mkIpGi5zmnNfSpSRCU99s
 dG7VWoIkZ1ZZB7eiGWiLD46qKkrNdNT9PfDCEbgDaOk7vQreDvrwaNaKoBKnPWAzYH1P
 q64Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=9qo89ZBDPvbx5XzA56F/vtCd71kZmWqz536FwRQK3ek=;
 b=LKh/cI0/nAu90ARo/ofO4kfMoE62QWhr1D45Q5zokpxnMxydT9m4QbEY5wyUncEtqE
 1bXExYA8HX8UN6R4TNLvCGgdMhAhSIytPEDhsS5m/n7Br+spe+POhySZHXe1GhdWBzgR
 UnzskZv3gcnfQb0VPy9sd9iFrH2s1kb0x+cksJHOyXFmy9DLV/rnjlekOfFfwAjdOJyw
 YEUfP/M6BL1iHizeOVDdjgq57ZfVymqFW7wJ602WjqNQBcZLGAfwbZEAHFyIwqNSJWtp
 ywRUg+W7Web3tf5o1+NodBMEa/W+cPDtMzFFirHO1jKQCddEzxlIcPIkDSTMqELw/lkr
 TxzQ==
X-Gm-Message-State: AOAM532ujoWL0gfG4Z0mRaqKh+1v3hdGq1ou5D/FseXLd2ASqCih9HQ7
 OjjVnVej0exmnifTkhS7jsw=
X-Google-Smtp-Source: ABdhPJwEA45kIyFqqT9+Me/fXS1toXlSQu769DRG29tn1968CEUukC2UUEfXN0n5PULz8BWTfJr9Jg==
X-Received: by 2002:ac2:4145:: with SMTP id c5mr1600325lfi.91.1588937403954;
 Fri, 08 May 2020 04:30:03 -0700 (PDT)
Received: from localhost (81-231-232-130-no39.tbcn.telia.com. [81.231.232.130])
 by smtp.gmail.com with ESMTPSA id a24sm1026750ljk.10.2020.05.08.04.30.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2020 04:30:03 -0700 (PDT)
Date: Fri, 8 May 2020 13:29:47 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
Subject: Re: [PATCH v3 06/11] net: cadence_gem: Move tx/rx packet buffert to
 CadenceGEMState
Message-ID: <20200508112947.GN5519@toto>
References: <1588935645-20351-1-git-send-email-sai.pavan.boddu@xilinx.com>
 <1588935645-20351-7-git-send-email-sai.pavan.boddu@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1588935645-20351-7-git-send-email-sai.pavan.boddu@xilinx.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Received-SPF: pass client-ip=2a00:1450:4864:20::143;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lf1-x143.google.com
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

On Fri, May 08, 2020 at 04:30:40PM +0530, Sai Pavan Boddu wrote:
> Moving this buffers to CadenceGEMState, as their size will be increased
> more when JUMBO frames support is added.
> 
> Signed-off-by: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
> ---
>  hw/net/cadence_gem.c         | 52 ++++++++++++++++++++++++++------------------
>  include/hw/net/cadence_gem.h |  2 ++
>  2 files changed, 33 insertions(+), 21 deletions(-)
> 
> diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
> index 77a0588..5ccec1a 100644
> --- a/hw/net/cadence_gem.c
> +++ b/hw/net/cadence_gem.c
> @@ -314,6 +314,8 @@
>  
>  #define GEM_MODID_VALUE 0x00020118
>  
> +#define MAX_FRAME_SIZE 2048
> +
>  static inline uint64_t tx_desc_get_buffer(CadenceGEMState *s, uint32_t *desc)
>  {
>      uint64_t ret = desc[0];
> @@ -928,17 +930,14 @@ static void gem_get_rx_desc(CadenceGEMState *s, int q)
>   */
>  static ssize_t gem_receive(NetClientState *nc, const uint8_t *buf, size_t size)
>  {
> -    CadenceGEMState *s;
> +    CadenceGEMState *s = qemu_get_nic_opaque(nc);
>      unsigned   rxbufsize, bytes_to_copy;
>      unsigned   rxbuf_offset;
> -    uint8_t    rxbuf[2048];
>      uint8_t   *rxbuf_ptr;
>      bool first_desc = true;
>      int maf;
>      int q = 0;
>  
> -    s = qemu_get_nic_opaque(nc);
> -
>      /* Is this destination MAC address "for us" ? */
>      maf = gem_mac_address_filter(s, buf);
>      if (maf == GEM_RX_REJECT) {
> @@ -994,19 +993,19 @@ static ssize_t gem_receive(NetClientState *nc, const uint8_t *buf, size_t size)
>      } else {
>          unsigned crc_val;
>  
> -        if (size > sizeof(rxbuf) - sizeof(crc_val)) {
> -            size = sizeof(rxbuf) - sizeof(crc_val);
> +        if (size > MAX_FRAME_SIZE - sizeof(crc_val)) {
> +            size = MAX_FRAME_SIZE - sizeof(crc_val);
>          }
>          bytes_to_copy = size;
>          /* The application wants the FCS field, which QEMU does not provide.
>           * We must try and calculate one.
>           */
>  
> -        memcpy(rxbuf, buf, size);
> -        memset(rxbuf + size, 0, sizeof(rxbuf) - size);
> -        rxbuf_ptr = rxbuf;
> -        crc_val = cpu_to_le32(crc32(0, rxbuf, MAX(size, 60)));
> -        memcpy(rxbuf + size, &crc_val, sizeof(crc_val));
> +        memcpy(s->rx_packet, buf, size);
> +        memset(s->rx_packet + size, 0, MAX_FRAME_SIZE - size);
> +        rxbuf_ptr = s->rx_packet;
> +        crc_val = cpu_to_le32(crc32(0, s->rx_packet, MAX(size, 60)));
> +        memcpy(s->rx_packet + size, &crc_val, sizeof(crc_val));
>  
>          bytes_to_copy += 4;
>          size += 4;
> @@ -1152,7 +1151,6 @@ static void gem_transmit(CadenceGEMState *s)
>  {
>      uint32_t desc[DESC_MAX_NUM_WORDS];
>      hwaddr packet_desc_addr;
> -    uint8_t     tx_packet[2048];
>      uint8_t     *p;
>      unsigned    total_bytes;
>      int q = 0;
> @@ -1168,7 +1166,7 @@ static void gem_transmit(CadenceGEMState *s)
>       * Packets scattered across multiple descriptors are gathered to this
>       * one contiguous buffer first.
>       */
> -    p = tx_packet;
> +    p = s->tx_packet;
>      total_bytes = 0;
>  
>      for (q = s->num_priority_queues - 1; q >= 0; q--) {
> @@ -1198,12 +1196,12 @@ static void gem_transmit(CadenceGEMState *s)
>                  break;
>              }
>  
> -            if (tx_desc_get_length(desc) > sizeof(tx_packet) -
> -                                               (p - tx_packet)) {
> +            if (tx_desc_get_length(desc) > MAX_FRAME_SIZE -
> +                                               (p - s->tx_packet)) {
>                  DB_PRINT("TX descriptor @ 0x%" HWADDR_PRIx \
>                           " too large: size 0x%x space 0x%zx\n",
>                           packet_desc_addr, tx_desc_get_length(desc),
> -                         sizeof(tx_packet) - (p - tx_packet));
> +                         MAX_FRAME_SIZE - (p - s->tx_packet));
>                  break;
>              }
>  
> @@ -1248,24 +1246,24 @@ static void gem_transmit(CadenceGEMState *s)
>  
>                  /* Is checksum offload enabled? */
>                  if (s->regs[GEM_DMACFG] & GEM_DMACFG_TXCSUM_OFFL) {
> -                    net_checksum_calculate(tx_packet, total_bytes);
> +                    net_checksum_calculate(s->tx_packet, total_bytes);
>                  }
>  
>                  /* Update MAC statistics */
> -                gem_transmit_updatestats(s, tx_packet, total_bytes);
> +                gem_transmit_updatestats(s, s->tx_packet, total_bytes);
>  
>                  /* Send the packet somewhere */
>                  if (s->phy_loop || (s->regs[GEM_NWCTRL] &
>                                      GEM_NWCTRL_LOCALLOOP)) {
> -                    gem_receive(qemu_get_queue(s->nic), tx_packet,
> +                    gem_receive(qemu_get_queue(s->nic), s->tx_packet,
>                                  total_bytes);
>                  } else {
> -                    qemu_send_packet(qemu_get_queue(s->nic), tx_packet,
> +                    qemu_send_packet(qemu_get_queue(s->nic), s->tx_packet,
>                                       total_bytes);
>                  }
>  
>                  /* Prepare for next packet */
> -                p = tx_packet;
> +                p = s->tx_packet;
>                  total_bytes = 0;
>              }
>  
> @@ -1612,6 +1610,17 @@ static void gem_realize(DeviceState *dev, Error **errp)
>  
>      s->nic = qemu_new_nic(&net_gem_info, &s->conf,
>                            object_get_typename(OBJECT(dev)), dev->id, s);
> +
> +    s->tx_packet = g_new0(uint8_t, MAX_FRAME_SIZE);
> +    s->rx_packet = g_new0(uint8_t, MAX_FRAME_SIZE);

Hi Sai,

Since you're only using MAX_FRAME_SIZE these could be arrays
in CadenceGEMState.

With that change:
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>

