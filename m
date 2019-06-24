Return-Path: <SRS0=7PyC=UX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92526C43613
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 20:11:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 580FD20645
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 20:11:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 580FD20645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54418 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfVJj-0004TW-MM
	for qemu-devel@archiver.kernel.org; Mon, 24 Jun 2019 16:11:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57396)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <laurent@vivier.eu>) id 1hfVG9-0001CS-Aw
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 16:08:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1hfVG7-0001CW-GZ
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 16:08:13 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:45081)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1hfVG7-00019i-33; Mon, 24 Jun 2019 16:08:11 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue107 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MX0TX-1i3T4J0sht-00XPQz; Mon, 24 Jun 2019 22:07:26 +0200
To: Jason Wang <jasowang@redhat.com>
References: <20190619221933.1981-1-laurent@vivier.eu>
 <20190619221933.1981-4-laurent@vivier.eu>
From: Laurent Vivier <laurent@vivier.eu>
Openpgp: preference=signencrypt
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <f302ca04-e517-f72a-0067-2ab85ef238f0@vivier.eu>
Date: Mon, 24 Jun 2019 22:07:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190619221933.1981-4-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:lqUKwbb5LM6ni1JBS1iQwaD4WV1JXDH1E7ggRmGHl9XL8/Eh0CW
 YBJItnc6xMt92a8jVKFvm0NeakKn0nYAbxuKrYbv53yauEiBDTQnaGTfC18xFnZMMJQkbim
 UswXN0gIRJXIhmyqHd9cDIaMEz0TwdjvEhNQnRuw0DiSk70F2BndG2n2vy+jVRmIvKtvFwN
 adWX+AUv/hDWmo5e8C0Eg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:0PzpMmtDiYI=:Tjbg2x3IJK32+fsDreoVsB
 zV+y+PTYrZQgf7T/OhmQ8pp5K/WjIJNtxQaShO11nEH7trGHl4wpWt7Udh9xxhKs18EEl+bwB
 YrSLzoxHPeq0F33cuekb5tqciCsNZU7s41W3pIDxUueAWRAWelLSs5c0qn2a+Pe4LaO67EkS4
 LiEczNjsRyE5eOCGha2vsVYnnBlStysVFkvhUYFgZmMhglPoim1T5Xc9x2S9lPiEt22EFAagT
 +VhSQfXEUN9+RoTQcEfh1St5Mhrtp1hr31bCLkBiIhmRcYShXnmvOtealvfU9ebtmlx2Crqh7
 ZLs5Yiq5BjbfoMVq3IFA0EoHyuytX8zFxmbAcnqFWX65ETD2JYzYoBgVUEl0N/Qc/Jfjx/UKa
 20UsIHqPtGWbx2cHAch3VX1OwzoTuvWrsNX8baHGEn3TmL5AoIhWIfqa3dOnEyaRccmdCtKmf
 HlWCpgqh9dEwm6HaoiRXLYPYQlzCiN+1ZZf2YjAN7vtaYCI4MZM9lbZtrgTCHu2oMWSEltzG/
 ZiwA1vrCWQSKTNtH8ruj6VFeGM3Pdu98Td5701+C2UzpFFg/oW/mncHD81FTRtSFtmpNosyOF
 aCKkabH1UtTOOraNWwvW3m0NgyX2sJzOAPo8QyLnXX5lFL20j9BvmMq6UICQ+zam7SwH087m3
 6dSuZnLS5jSIAlmtXG4M2UJIykYSldTTQJ6TDDQj9u2cPNUGHHGjyM+Z2ykuKMt7Di33ElG0N
 ehGdQPeaXjwLW7Y62701NtrWrRQpATVgabMzjHBwj1rpZzPKKcWj2HHEkzE=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.13
Subject: Re: [Qemu-devel] [PATCH v8 03/10] dp8393x: manage big endian bus
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org, Thomas Huth <huth@tuxfamily.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

Jason, Can I have an Acked-by from you (as network devices maintainer)?

Thanks,
Laurent

Le 20/06/2019 à 00:19, Laurent Vivier a écrit :
> This is needed by Quadra 800, this card can run on little-endian
> or big-endian bus.
> 
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> Tested-by: Hervé Poussineau <hpoussin@reactos.org>
> Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> Reviewed-by: Hervé Poussineau <hpoussin@reactos.org>
> ---
>  hw/net/dp8393x.c | 88 +++++++++++++++++++++++++++++++-----------------
>  1 file changed, 57 insertions(+), 31 deletions(-)
> 
> diff --git a/hw/net/dp8393x.c b/hw/net/dp8393x.c
> index bdb0b3b2c2..b014c015c6 100644
> --- a/hw/net/dp8393x.c
> +++ b/hw/net/dp8393x.c
> @@ -150,6 +150,7 @@ typedef struct dp8393xState {
>  
>      /* Hardware */
>      uint8_t it_shift;
> +    bool big_endian;
>      qemu_irq irq;
>  #ifdef DEBUG_SONIC
>      int irq_level;
> @@ -220,6 +221,29 @@ static uint32_t dp8393x_wt(dp8393xState *s)
>      return s->regs[SONIC_WT1] << 16 | s->regs[SONIC_WT0];
>  }
>  
> +static uint16_t dp8393x_get(dp8393xState *s, int width, uint16_t *base,
> +                            int offset)
> +{
> +    uint16_t val;
> +
> +    if (s->big_endian) {
> +        val = be16_to_cpu(base[offset * width + width - 1]);
> +    } else {
> +        val = le16_to_cpu(base[offset * width]);
> +    }
> +    return val;
> +}
> +
> +static void dp8393x_put(dp8393xState *s, int width, uint16_t *base, int offset,
> +                        uint16_t val)
> +{
> +    if (s->big_endian) {
> +        base[offset * width + width - 1] = cpu_to_be16(val);
> +    } else {
> +        base[offset * width] = cpu_to_le16(val);
> +    }
> +}
> +
>  static void dp8393x_update_irq(dp8393xState *s)
>  {
>      int level = (s->regs[SONIC_IMR] & s->regs[SONIC_ISR]) ? 1 : 0;
> @@ -251,12 +275,12 @@ static void dp8393x_do_load_cam(dp8393xState *s)
>          /* Fill current entry */
>          address_space_rw(&s->as, dp8393x_cdp(s),
>              MEMTXATTRS_UNSPECIFIED, (uint8_t *)data, size, 0);
> -        s->cam[index][0] = data[1 * width] & 0xff;
> -        s->cam[index][1] = data[1 * width] >> 8;
> -        s->cam[index][2] = data[2 * width] & 0xff;
> -        s->cam[index][3] = data[2 * width] >> 8;
> -        s->cam[index][4] = data[3 * width] & 0xff;
> -        s->cam[index][5] = data[3 * width] >> 8;
> +        s->cam[index][0] = dp8393x_get(s, width, data, 1) & 0xff;
> +        s->cam[index][1] = dp8393x_get(s, width, data, 1) >> 8;
> +        s->cam[index][2] = dp8393x_get(s, width, data, 2) & 0xff;
> +        s->cam[index][3] = dp8393x_get(s, width, data, 2) >> 8;
> +        s->cam[index][4] = dp8393x_get(s, width, data, 3) & 0xff;
> +        s->cam[index][5] = dp8393x_get(s, width, data, 3) >> 8;
>          DPRINTF("load cam[%d] with %02x%02x%02x%02x%02x%02x\n", index,
>              s->cam[index][0], s->cam[index][1], s->cam[index][2],
>              s->cam[index][3], s->cam[index][4], s->cam[index][5]);
> @@ -269,7 +293,7 @@ static void dp8393x_do_load_cam(dp8393xState *s)
>      /* Read CAM enable */
>      address_space_rw(&s->as, dp8393x_cdp(s),
>          MEMTXATTRS_UNSPECIFIED, (uint8_t *)data, size, 0);
> -    s->regs[SONIC_CE] = data[0 * width];
> +    s->regs[SONIC_CE] = dp8393x_get(s, width, data, 0);
>      DPRINTF("load cam done. cam enable mask 0x%04x\n", s->regs[SONIC_CE]);
>  
>      /* Done */
> @@ -290,10 +314,10 @@ static void dp8393x_do_read_rra(dp8393xState *s)
>          MEMTXATTRS_UNSPECIFIED, (uint8_t *)data, size, 0);
>  
>      /* Update SONIC registers */
> -    s->regs[SONIC_CRBA0] = data[0 * width];
> -    s->regs[SONIC_CRBA1] = data[1 * width];
> -    s->regs[SONIC_RBWC0] = data[2 * width];
> -    s->regs[SONIC_RBWC1] = data[3 * width];
> +    s->regs[SONIC_CRBA0] = dp8393x_get(s, width, data, 0);
> +    s->regs[SONIC_CRBA1] = dp8393x_get(s, width, data, 1);
> +    s->regs[SONIC_RBWC0] = dp8393x_get(s, width, data, 2);
> +    s->regs[SONIC_RBWC1] = dp8393x_get(s, width, data, 3);
>      DPRINTF("CRBA0/1: 0x%04x/0x%04x, RBWC0/1: 0x%04x/0x%04x\n",
>          s->regs[SONIC_CRBA0], s->regs[SONIC_CRBA1],
>          s->regs[SONIC_RBWC0], s->regs[SONIC_RBWC1]);
> @@ -408,12 +432,12 @@ static void dp8393x_do_transmit_packets(dp8393xState *s)
>          tx_len = 0;
>  
>          /* Update registers */
> -        s->regs[SONIC_TCR] = data[0 * width] & 0xf000;
> -        s->regs[SONIC_TPS] = data[1 * width];
> -        s->regs[SONIC_TFC] = data[2 * width];
> -        s->regs[SONIC_TSA0] = data[3 * width];
> -        s->regs[SONIC_TSA1] = data[4 * width];
> -        s->regs[SONIC_TFS] = data[5 * width];
> +        s->regs[SONIC_TCR] = dp8393x_get(s, width, data, 0) & 0xf000;
> +        s->regs[SONIC_TPS] = dp8393x_get(s, width, data, 1);
> +        s->regs[SONIC_TFC] = dp8393x_get(s, width, data, 2);
> +        s->regs[SONIC_TSA0] = dp8393x_get(s, width, data, 3);
> +        s->regs[SONIC_TSA1] = dp8393x_get(s, width, data, 4);
> +        s->regs[SONIC_TFS] = dp8393x_get(s, width, data, 5);
>  
>          /* Handle programmable interrupt */
>          if (s->regs[SONIC_TCR] & SONIC_TCR_PINT) {
> @@ -439,9 +463,9 @@ static void dp8393x_do_transmit_packets(dp8393xState *s)
>                  address_space_rw(&s->as,
>                      dp8393x_ttda(s) + sizeof(uint16_t) * (4 + 3 * i) * width,
>                      MEMTXATTRS_UNSPECIFIED, (uint8_t *)data, size, 0);
> -                s->regs[SONIC_TSA0] = data[0 * width];
> -                s->regs[SONIC_TSA1] = data[1 * width];
> -                s->regs[SONIC_TFS] = data[2 * width];
> +                s->regs[SONIC_TSA0] = dp8393x_get(s, width, data, 0);
> +                s->regs[SONIC_TSA1] = dp8393x_get(s, width, data, 1);
> +                s->regs[SONIC_TFS] = dp8393x_get(s, width, data, 2);
>              }
>          }
>  
> @@ -468,7 +492,8 @@ static void dp8393x_do_transmit_packets(dp8393xState *s)
>          s->regs[SONIC_TCR] |= SONIC_TCR_PTX;
>  
>          /* Write status */
> -        data[0 * width] = s->regs[SONIC_TCR] & 0x0fff; /* status */
> +        dp8393x_put(s, width, data, 0,
> +                    s->regs[SONIC_TCR] & 0x0fff); /* status */
>          size = sizeof(uint16_t) * width;
>          address_space_rw(&s->as,
>              dp8393x_ttda(s),
> @@ -482,8 +507,8 @@ static void dp8393x_do_transmit_packets(dp8393xState *s)
>                               sizeof(uint16_t) *
>                               (4 + 3 * s->regs[SONIC_TFC]) * width,
>                  MEMTXATTRS_UNSPECIFIED, (uint8_t *)data, size, 0);
> -            s->regs[SONIC_CTDA] = data[0 * width] & ~0x1;
> -            if (data[0 * width] & 0x1) {
> +            s->regs[SONIC_CTDA] = dp8393x_get(s, width, data, 0) & ~0x1;
> +            if (dp8393x_get(s, width, data, 0) & 0x1) {
>                  /* EOL detected */
>                  break;
>              }
> @@ -746,7 +771,7 @@ static ssize_t dp8393x_receive(NetClientState *nc, const uint8_t * buf,
>          address = dp8393x_crda(s) + sizeof(uint16_t) * 5 * width;
>          address_space_rw(&s->as, address, MEMTXATTRS_UNSPECIFIED,
>                           (uint8_t *)data, size, 0);
> -        if (data[0 * width] & 0x1) {
> +        if (dp8393x_get(s, width, data, 0) & 0x1) {
>              /* Still EOL ; stop reception */
>              return -1;
>          } else {
> @@ -790,11 +815,11 @@ static ssize_t dp8393x_receive(NetClientState *nc, const uint8_t * buf,
>  
>      /* Write status to memory */
>      DPRINTF("Write status at %08x\n", dp8393x_crda(s));
> -    data[0 * width] = s->regs[SONIC_RCR]; /* status */
> -    data[1 * width] = rx_len; /* byte count */
> -    data[2 * width] = s->regs[SONIC_TRBA0]; /* pkt_ptr0 */
> -    data[3 * width] = s->regs[SONIC_TRBA1]; /* pkt_ptr1 */
> -    data[4 * width] = s->regs[SONIC_RSC]; /* seq_no */
> +    dp8393x_put(s, width, data, 0, s->regs[SONIC_RCR]); /* status */
> +    dp8393x_put(s, width, data, 1, rx_len); /* byte count */
> +    dp8393x_put(s, width, data, 2, s->regs[SONIC_TRBA0]); /* pkt_ptr0 */
> +    dp8393x_put(s, width, data, 3, s->regs[SONIC_TRBA1]); /* pkt_ptr1 */
> +    dp8393x_put(s, width, data, 4, s->regs[SONIC_RSC]); /* seq_no */
>      size = sizeof(uint16_t) * 5 * width;
>      address_space_rw(&s->as, dp8393x_crda(s),
>          MEMTXATTRS_UNSPECIFIED, (uint8_t *)data, size, 1);
> @@ -803,12 +828,12 @@ static ssize_t dp8393x_receive(NetClientState *nc, const uint8_t * buf,
>      size = sizeof(uint16_t) * width;
>      address_space_rw(&s->as, dp8393x_crda(s) + sizeof(uint16_t) * 5 * width,
>          MEMTXATTRS_UNSPECIFIED, (uint8_t *)data, size, 0);
> -    s->regs[SONIC_LLFA] = data[0 * width];
> +    s->regs[SONIC_LLFA] = dp8393x_get(s, width, data, 0);
>      if (s->regs[SONIC_LLFA] & 0x1) {
>          /* EOL detected */
>          s->regs[SONIC_ISR] |= SONIC_ISR_RDE;
>      } else {
> -        data[0 * width] = 0; /* in_use */
> +        dp8393x_put(s, width, data, 0, 0); /* in_use */
>          address_space_rw(&s->as, dp8393x_crda(s) + sizeof(uint16_t) * 6 * width,
>              MEMTXATTRS_UNSPECIFIED, (uint8_t *)data, sizeof(uint16_t), 1);
>          s->regs[SONIC_CRDA] = s->regs[SONIC_LLFA];
> @@ -921,6 +946,7 @@ static Property dp8393x_properties[] = {
>      DEFINE_NIC_PROPERTIES(dp8393xState, conf),
>      DEFINE_PROP_PTR("dma_mr", dp8393xState, dma_mr),
>      DEFINE_PROP_UINT8("it_shift", dp8393xState, it_shift, 0),
> +    DEFINE_PROP_BOOL("big_endian", dp8393xState, big_endian, false),
>      DEFINE_PROP_END_OF_LIST(),
>  };
>  
> 


