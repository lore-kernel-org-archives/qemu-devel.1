Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14347C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 09:41:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D45C8206F0
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 09:41:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hNrH+j0q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D45C8206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37528 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juuxh-0001NQ-4j
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 05:41:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33034)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1juuuO-0005tM-Rm
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 05:38:00 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:33602
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1juuuM-0007lK-Rj
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 05:38:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594633078;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=v86aU8XqbHXcIIzLG8TLy8tG8wHXKvW11QApg3NyroY=;
 b=hNrH+j0qNsGz+2Zzahd79JAFxc0+cHoFF9ymgVm3tE535vZ/z0WtyNdmWigkw8J8ZuOsR9
 Q8H6nd4jVg3McdhlrltE6cU6WB11t804YYulztdogm0+Mofoh0aB3PjqgTGoxM1z06Vxv2
 pMADBa3nNKBgY2jWVH8tMTaCJakK0F0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-60-HRvFzwjXN-aOzmuJXagTWQ-1; Mon, 13 Jul 2020 05:37:54 -0400
X-MC-Unique: HRvFzwjXN-aOzmuJXagTWQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3C14D107ACCA;
 Mon, 13 Jul 2020 09:37:53 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-125.ams2.redhat.com [10.36.112.125])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B58E227CC6;
 Mon, 13 Jul 2020 09:37:51 +0000 (UTC)
Subject: Re: [PATCH 09/12] hw: Remove superfluous breaks
To: Yi Wang <wang.yi59@zte.com.cn>, qemu-devel@nongnu.org
References: <1594631126-36631-1-git-send-email-wang.yi59@zte.com.cn>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <728da22b-18db-cec9-1cb8-b17202a62846@redhat.com>
Date: Mon, 13 Jul 2020 11:37:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1594631126-36631-1-git-send-email-wang.yi59@zte.com.cn>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/13 01:36:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: xue.zhihong@zte.com.cn, QEMU Trivial <qemu-trivial@nongnu.org>,
 wang.liang82@zte.com.cn, Liao Pingfang <liao.pingfang@zte.com.cn>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 13/07/2020 11.05, Yi Wang wrote:
> From: Liao Pingfang <liao.pingfang@zte.com.cn>
> 
> Remove superfluous breaks, as there is a "return" before them.
> 
> Signed-off-by: Liao Pingfang <liao.pingfang@zte.com.cn>
> Signed-off-by: Yi Wang <wang.yi59@zte.com.cn>
> Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  hw/block/pflash_cfi01.c     |  1 -
>  hw/display/cirrus_vga.c     |  1 -
>  hw/display/qxl-logger.c     |  2 --
>  hw/gpio/max7310.c           |  3 ---
>  hw/i386/intel_iommu.c       |  1 -
>  hw/input/pxa2xx_keypad.c    | 10 ----------
>  hw/intc/armv7m_nvic.c       |  1 -
>  hw/net/lan9118.c            |  2 --
>  hw/usb/ccid-card-emulated.c |  1 -
>  9 files changed, 22 deletions(-)
> 
> diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
> index 8ab1d66..f0fcd63 100644
> --- a/hw/block/pflash_cfi01.c
> +++ b/hw/block/pflash_cfi01.c
> @@ -213,7 +213,6 @@ static uint32_t pflash_devid_query(PFlashCFI01 *pfl, hwaddr offset)
>      default:
>          trace_pflash_device_info(offset);
>          return 0;
> -        break;
>      }
>      /* Replicate responses for each device in bank. */
>      if (pfl->device_width < pfl->bank_width) {
> diff --git a/hw/display/cirrus_vga.c b/hw/display/cirrus_vga.c
> index 212d6f5..02d9ed0 100644
> --- a/hw/display/cirrus_vga.c
> +++ b/hw/display/cirrus_vga.c
> @@ -1637,7 +1637,6 @@ static int cirrus_vga_read_cr(CirrusVGAState * s, unsigned reg_index)
>  	return s->vga.cr[s->vga.cr_index];
>      case 0x26:			// Attribute Controller Index Readback (R)
>  	return s->vga.ar_index & 0x3f;
> -	break;
>      default:
>          qemu_log_mask(LOG_GUEST_ERROR,
>                        "cirrus: inport cr_index 0x%02x\n", reg_index);
> diff --git a/hw/display/qxl-logger.c b/hw/display/qxl-logger.c
> index 2ec6d8f..c15175b 100644
> --- a/hw/display/qxl-logger.c
> +++ b/hw/display/qxl-logger.c
> @@ -161,7 +161,6 @@ static int qxl_log_cmd_draw(PCIQXLDevice *qxl, QXLDrawable *draw, int group_id)
>      switch (draw->type) {
>      case QXL_DRAW_COPY:
>          return qxl_log_cmd_draw_copy(qxl, &draw->u.copy, group_id);
> -        break;
>      }
>      return 0;
>  }
> @@ -180,7 +179,6 @@ static int qxl_log_cmd_draw_compat(PCIQXLDevice *qxl, QXLCompatDrawable *draw,
>      switch (draw->type) {
>      case QXL_DRAW_COPY:
>          return qxl_log_cmd_draw_copy(qxl, &draw->u.copy, group_id);
> -        break;
>      }
>      return 0;
>  }
> diff --git a/hw/gpio/max7310.c b/hw/gpio/max7310.c
> index bebb403..4f78774 100644
> --- a/hw/gpio/max7310.c
> +++ b/hw/gpio/max7310.c
> @@ -51,11 +51,9 @@ static uint8_t max7310_rx(I2CSlave *i2c)
>      switch (s->command) {
>      case 0x00:	/* Input port */
>          return s->level ^ s->polarity;
> -        break;
>  
>      case 0x01:	/* Output port */
>          return s->level & ~s->direction;
> -        break;
>  
>      case 0x02:	/* Polarity inversion */
>          return s->polarity;
> @@ -65,7 +63,6 @@ static uint8_t max7310_rx(I2CSlave *i2c)
>  
>      case 0x04:	/* Timeout */
>          return s->status;
> -        break;
>  
>      case 0xff:	/* Reserved */
>          return 0xff;
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index c56398e..7b390ca 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -3163,7 +3163,6 @@ static int vtd_irte_get(IntelIOMMUState *iommu, uint16_t index,
>                                index, entry->irte.sid_vtype);
>              /* Take this as verification failure. */
>              return -VTD_FR_IR_SID_ERR;
> -            break;
>          }
>      }
>  
> diff --git a/hw/input/pxa2xx_keypad.c b/hw/input/pxa2xx_keypad.c
> index 62aa6f6..7f2f739 100644
> --- a/hw/input/pxa2xx_keypad.c
> +++ b/hw/input/pxa2xx_keypad.c
> @@ -192,10 +192,8 @@ static uint64_t pxa2xx_keypad_read(void *opaque, hwaddr offset,
>              s->kpc &= ~(KPC_DI);
>          qemu_irq_lower(s->irq);
>          return tmp;
> -        break;
>      case KPDK:
>          return s->kpdk;
> -        break;
>      case KPREC:
>          tmp = s->kprec;
>          if(tmp & KPREC_OF1)
> @@ -207,31 +205,23 @@ static uint64_t pxa2xx_keypad_read(void *opaque, hwaddr offset,
>          if(tmp & KPREC_UF0)
>              s->kprec &= ~(KPREC_UF0);
>          return tmp;
> -        break;
>      case KPMK:
>          tmp = s->kpmk;
>          if(tmp & KPMK_MKP)
>              s->kpmk &= ~(KPMK_MKP);
>          return tmp;
> -        break;
>      case KPAS:
>          return s->kpas;
> -        break;
>      case KPASMKP0:
>          return s->kpasmkp[0];
> -        break;
>      case KPASMKP1:
>          return s->kpasmkp[1];
> -        break;
>      case KPASMKP2:
>          return s->kpasmkp[2];
> -        break;
>      case KPASMKP3:
>          return s->kpasmkp[3];
> -        break;
>      case KPKDI:
>          return s->kpkdi;
> -        break;
>      default:
>          qemu_log_mask(LOG_GUEST_ERROR,
>                        "%s: Bad read offset 0x%"HWADDR_PRIx"\n",
> diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
> index 3c4b6e6..720ac97 100644
> --- a/hw/intc/armv7m_nvic.c
> +++ b/hw/intc/armv7m_nvic.c
> @@ -1275,7 +1275,6 @@ static uint32_t nvic_readl(NVICState *s, uint32_t offset, MemTxAttrs attrs)
>      case 0xd90: /* MPU_TYPE */
>          /* Unified MPU; if the MPU is not present this value is zero */
>          return cpu->pmsav7_dregion << 8;
> -        break;
>      case 0xd94: /* MPU_CTRL */
>          return cpu->env.v7m.mpu_ctrl[attrs.secure];
>      case 0xd98: /* MPU_RNR */
> diff --git a/hw/net/lan9118.c b/hw/net/lan9118.c
> index 8e2a432..e35f00f 100644
> --- a/hw/net/lan9118.c
> +++ b/hw/net/lan9118.c
> @@ -931,10 +931,8 @@ static uint32_t do_mac_read(lan9118_state *s, int reg)
>                 | (s->conf.macaddr.a[2] << 16) | (s->conf.macaddr.a[3] << 24);
>      case MAC_HASHH:
>          return s->mac_hashh;
> -        break;
>      case MAC_HASHL:
>          return s->mac_hashl;
> -        break;
>      case MAC_MII_ACC:
>          return s->mac_mii_acc;
>      case MAC_MII_DATA:
> diff --git a/hw/usb/ccid-card-emulated.c b/hw/usb/ccid-card-emulated.c
> index 7d6105e..0f1afd6 100644
> --- a/hw/usb/ccid-card-emulated.c
> +++ b/hw/usb/ccid-card-emulated.c
> @@ -350,7 +350,6 @@ static void *event_thread(void *arg)
>          case VEVENT_LAST: /* quit */
>              vevent_delete(event);
>              return NULL;
> -            break;
>          default:
>              break;
>          }
> 

Reviewed-by: Thomas Huth <thuth@redhat.com>


