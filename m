Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 200FFC2D0F6
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 15:43:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE28B206B8
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 15:43:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pVq8Cqa2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE28B206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49680 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYX4G-0000rf-1X
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 11:43:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37854)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1jYWhe-0008Jn-50; Tue, 12 May 2020 11:20:18 -0400
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241]:35963)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1jYWhc-00073C-U7; Tue, 12 May 2020 11:20:17 -0400
Received: by mail-lj1-x241.google.com with SMTP id u15so14125099ljd.3;
 Tue, 12 May 2020 08:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=tWrK18LUs2ZEDV4D0HtSYOtlHOYDGB4rGn0OlVTepBc=;
 b=pVq8Cqa24lHODoZdVZeHSJPj7sUfbUXFtJ3MZHG/Z1zQrwSvJyhWwz7UeXmwdhTHwC
 pkGM2WNBgsvEULaTpXDp+nurv5dA/0DnStfWbnyWIm5wlCEhPGTRD6mlbHIjLc3wUTB0
 X+Gp0iGLG5q6J9iZAO9x3NeuRod0FT4wbeZm1dirZ77a3YlB6ElaDVSxZveqcyCADPcR
 rLJ3r/Lgjp+zbw87gNaAKFqE8dj+EU8vgyz0swZ96QMUBUDWbIkJHURzRiMn5fMtbFMc
 avs8LR9y4e7djPfZk8C5nWwrYzG20zjzYozjxxXTmM+4G6URAykzRIKEDidpOij0xTzk
 wTNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=tWrK18LUs2ZEDV4D0HtSYOtlHOYDGB4rGn0OlVTepBc=;
 b=IXV7tEivvCwFN8UnFvhjsDWP8p6B3xCXPrUsPQhLXPXPd3RM28GF1QeVPL+nHFBctg
 VtWfoZYyZw4rzZedLq2FKr3yrjJmMv0fmF6XqhOR15XzgPPGKbAOuWLPIUc7lH4fJoVi
 9DxUkrY2phDmIuvs687d0PliKfC5iIsTFlrxpeBUSymGRXwnBGQtJ0zG+qbc2Lxla90m
 XeqwiMrzeHb/eRNouLUagEoXBvTj398xktAd/1VxC4DwWf5qRXgfMZqDHa9k3t/0lpvW
 w3jkGNI1D7KXy8ATChf2LGjYDH8xeyIIz+fHLGIbhdq53YfkTBWABC9bFFQkRinhVv3x
 ZmxA==
X-Gm-Message-State: AOAM532nrbB+p1/SfFES85P4VQ92CtDaZ2c/xkSY2r0a7RJxSnu3sBNG
 KdnTjMEnE+NPaymNig17PTs=
X-Google-Smtp-Source: ABdhPJxJTTqdu3y33vIFZH4WjG1O8gySE5ZRokb+VOr5O549gnmc23t0oyv14Xh0crF3P8P5y5D1Bg==
X-Received: by 2002:a2e:9843:: with SMTP id e3mr14223568ljj.249.1589296814076; 
 Tue, 12 May 2020 08:20:14 -0700 (PDT)
Received: from localhost (81-231-232-130-no39.tbcn.telia.com. [81.231.232.130])
 by smtp.gmail.com with ESMTPSA id w29sm14519454lfc.4.2020.05.12.08.20.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2020 08:20:13 -0700 (PDT)
Date: Tue, 12 May 2020 17:19:56 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
Subject: Re: [PATCH v5 08/12] net: cadence_gem: Add support for jumbo frames
Message-ID: <20200512151956.GU5519@toto>
References: <1589295294-26466-1-git-send-email-sai.pavan.boddu@xilinx.com>
 <1589295294-26466-9-git-send-email-sai.pavan.boddu@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1589295294-26466-9-git-send-email-sai.pavan.boddu@xilinx.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Received-SPF: pass client-ip=2a00:1450:4864:20::241;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lj1-x241.google.com
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

On Tue, May 12, 2020 at 08:24:50PM +0530, Sai Pavan Boddu wrote:
> Add a property "jumbo-max-len", which sets default value of jumbo frames
> up to 16,383 bytes. Add Frame length checks for standard and jumbo
> frames.

Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>



> 
> Signed-off-by: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
> ---
>  hw/net/cadence_gem.c         | 51 +++++++++++++++++++++++++++++++++++++++-----
>  include/hw/net/cadence_gem.h |  4 +++-
>  2 files changed, 49 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
> index f6ff27c..eb02946 100644
> --- a/hw/net/cadence_gem.c
> +++ b/hw/net/cadence_gem.c
> @@ -61,6 +61,7 @@
>  #define GEM_TXPAUSE       (0x0000003C / 4) /* TX Pause Time reg */
>  #define GEM_TXPARTIALSF   (0x00000040 / 4) /* TX Partial Store and Forward */
>  #define GEM_RXPARTIALSF   (0x00000044 / 4) /* RX Partial Store and Forward */
> +#define GEM_JUMBO_MAX_LEN (0x00000048 / 4) /* Max Jumbo Frame Size */
>  #define GEM_HASHLO        (0x00000080 / 4) /* Hash Low address reg */
>  #define GEM_HASHHI        (0x00000084 / 4) /* Hash High address reg */
>  #define GEM_SPADDR1LO     (0x00000088 / 4) /* Specific addr 1 low reg */
> @@ -212,10 +213,12 @@
>  #define GEM_NWCFG_LERR_DISC    0x00010000 /* Discard RX frames with len err */
>  #define GEM_NWCFG_BUFF_OFST_M  0x0000C000 /* Receive buffer offset mask */
>  #define GEM_NWCFG_BUFF_OFST_S  14         /* Receive buffer offset shift */
> +#define GEM_NWCFG_RCV_1538     0x00000100 /* Receive 1538 bytes frame */
>  #define GEM_NWCFG_UCAST_HASH   0x00000080 /* accept unicast if hash match */
>  #define GEM_NWCFG_MCAST_HASH   0x00000040 /* accept multicast if hash match */
>  #define GEM_NWCFG_BCAST_REJ    0x00000020 /* Reject broadcast packets */
>  #define GEM_NWCFG_PROMISC      0x00000010 /* Accept all packets */
> +#define GEM_NWCFG_JUMBO_FRAME  0x00000008 /* Jumbo Frames enable */
>  
>  #define GEM_DMACFG_ADDR_64B    (1U << 30)
>  #define GEM_DMACFG_TX_BD_EXT   (1U << 29)
> @@ -233,6 +236,7 @@
>  
>  /* GEM_ISR GEM_IER GEM_IDR GEM_IMR */
>  #define GEM_INT_TXCMPL        0x00000080 /* Transmit Complete */
> +#define GEM_INT_AMBA_ERR      0x00000040
>  #define GEM_INT_TXUSED         0x00000008
>  #define GEM_INT_RXUSED         0x00000004
>  #define GEM_INT_RXCMPL        0x00000002
> @@ -453,6 +457,24 @@ static inline void rx_desc_set_sar(uint32_t *desc, int sar_idx)
>  /* The broadcast MAC address: 0xFFFFFFFFFFFF */
>  static const uint8_t broadcast_addr[] = { 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF };
>  
> +static uint32_t gem_get_max_buf_len(CadenceGEMState *s, bool tx)
> +{
> +    uint32_t size;
> +    if (s->regs[GEM_NWCFG] & GEM_NWCFG_JUMBO_FRAME) {
> +        size = s->regs[GEM_JUMBO_MAX_LEN];
> +        if (size > s->jumbo_max_len) {
> +            size = s->jumbo_max_len;
> +            qemu_log_mask(LOG_GUEST_ERROR, "GEM_JUMBO_MAX_LEN reg cannot be"
> +                " greater than 0x%" PRIx32 "\n", s->jumbo_max_len);
> +        }
> +    } else if (tx) {
> +        size = 1518;
> +    } else {
> +        size = s->regs[GEM_NWCFG] & GEM_NWCFG_RCV_1538 ? 1538 : 1518;
> +    }
> +    return size;
> +}
> +
>  static void gem_set_isr(CadenceGEMState *s, int q, uint32_t flag)
>  {
>      if (q == 0) {
> @@ -1016,6 +1038,12 @@ static ssize_t gem_receive(NetClientState *nc, const uint8_t *buf, size_t size)
>      /* Find which queue we are targeting */
>      q = get_queue_from_screen(s, rxbuf_ptr, rxbufsize);
>  
> +    if (size > gem_get_max_buf_len(s, false)) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "rx frame too long\n");
> +        gem_set_isr(s, q, GEM_INT_AMBA_ERR);
> +        return -1;
> +    }
> +
>      while (bytes_to_copy) {
>          hwaddr desc_addr;
>  
> @@ -1196,12 +1224,13 @@ static void gem_transmit(CadenceGEMState *s)
>                  break;
>              }
>  
> -            if (tx_desc_get_length(desc) > MAX_FRAME_SIZE -
> +            if (tx_desc_get_length(desc) > gem_get_max_buf_len(s, true) -
>                                                 (p - s->tx_packet)) {
> -                DB_PRINT("TX descriptor @ 0x%" HWADDR_PRIx \
> -                         " too large: size 0x%x space 0x%zx\n",
> +                qemu_log_mask(LOG_GUEST_ERROR, "TX descriptor @ 0x%" \
> +                         HWADDR_PRIx " too large: size 0x%x space 0x%zx\n",
>                           packet_desc_addr, tx_desc_get_length(desc),
> -                         MAX_FRAME_SIZE - (p - s->tx_packet));
> +                         gem_get_max_buf_len(s, true) - (p - s->tx_packet));
> +                gem_set_isr(s, q, GEM_INT_AMBA_ERR);
>                  break;
>              }
>  
> @@ -1343,9 +1372,10 @@ static void gem_reset(DeviceState *d)
>      s->regs[GEM_RXPARTIALSF] = 0x000003ff;
>      s->regs[GEM_MODID] = s->revision;
>      s->regs[GEM_DESCONF] = 0x02500111;
> -    s->regs[GEM_DESCONF2] = 0x2ab13fff;
> +    s->regs[GEM_DESCONF2] = 0x2ab10000 | s->jumbo_max_len;
>      s->regs[GEM_DESCONF5] = 0x002f2045;
>      s->regs[GEM_DESCONF6] = GEM_DESCONF6_64B_MASK;
> +    s->regs[GEM_JUMBO_MAX_LEN] = s->jumbo_max_len;
>  
>      if (s->num_priority_queues > 1) {
>          queues_mask = MAKE_64BIT_MASK(1, s->num_priority_queues - 1);
> @@ -1516,6 +1546,9 @@ static void gem_write(void *opaque, hwaddr offset, uint64_t val,
>          s->regs[GEM_IMR] &= ~val;
>          gem_update_int_status(s);
>          break;
> +    case GEM_JUMBO_MAX_LEN:
> +        s->regs[GEM_JUMBO_MAX_LEN] = val & MAX_JUMBO_FRAME_SIZE_MASK;
> +        break;
>      case GEM_INT_Q1_ENABLE ... GEM_INT_Q7_ENABLE:
>          s->regs[GEM_INT_Q1_MASK + offset - GEM_INT_Q1_ENABLE] &= ~val;
>          gem_update_int_status(s);
> @@ -1610,6 +1643,12 @@ static void gem_realize(DeviceState *dev, Error **errp)
>  
>      s->nic = qemu_new_nic(&net_gem_info, &s->conf,
>                            object_get_typename(OBJECT(dev)), dev->id, s);
> +
> +    if (s->jumbo_max_len > MAX_FRAME_SIZE) {
> +        error_setg(errp, "jumbo-max-len is greater than %d",
> +                  MAX_FRAME_SIZE);
> +        return;
> +    }
>  }
>  
>  static void gem_init(Object *obj)
> @@ -1659,6 +1698,8 @@ static Property gem_properties[] = {
>                        num_type1_screeners, 4),
>      DEFINE_PROP_UINT8("num-type2-screeners", CadenceGEMState,
>                        num_type2_screeners, 4),
> +    DEFINE_PROP_UINT16("jumbo-max-len", CadenceGEMState,
> +                       jumbo_max_len, 10240),
>      DEFINE_PROP_END_OF_LIST(),
>  };
>  
> diff --git a/include/hw/net/cadence_gem.h b/include/hw/net/cadence_gem.h
> index eddac70..54e646f 100644
> --- a/include/hw/net/cadence_gem.h
> +++ b/include/hw/net/cadence_gem.h
> @@ -40,7 +40,8 @@
>  #define MAX_TYPE1_SCREENERS             16
>  #define MAX_TYPE2_SCREENERS             16
>  
> -#define MAX_FRAME_SIZE 2048
> +#define MAX_JUMBO_FRAME_SIZE_MASK 0x3FFF
> +#define MAX_FRAME_SIZE MAX_JUMBO_FRAME_SIZE_MASK
>  
>  typedef struct CadenceGEMState {
>      /*< private >*/
> @@ -59,6 +60,7 @@ typedef struct CadenceGEMState {
>      uint8_t num_type1_screeners;
>      uint8_t num_type2_screeners;
>      uint32_t revision;
> +    uint16_t jumbo_max_len;
>  
>      /* GEM registers backing store */
>      uint32_t regs[CADENCE_GEM_MAXREG];
> -- 
> 2.7.4
> 

