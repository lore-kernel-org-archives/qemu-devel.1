Return-Path: <SRS0=PhvJ=UY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14813C48BD5
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 16:07:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0E392080C
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 16:07:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0E392080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33470 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfnyr-0003vW-As
	for qemu-devel@archiver.kernel.org; Tue, 25 Jun 2019 12:07:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39104)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hfnp2-0000Xj-91
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 11:57:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hfnox-000700-HC
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 11:57:27 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44648)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hfnot-0006o4-C1
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 11:57:21 -0400
Received: by mail-wr1-f66.google.com with SMTP id r16so18453461wrl.11
 for <qemu-devel@nongnu.org>; Tue, 25 Jun 2019 08:57:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=hhQsN+W37ny4w5jzDEau2B6ofWiev4JriTg1PVeUmrU=;
 b=TaUkJfvBXGK1XMSN9F8lWQyQo48X7EEBxJ7sRFqnhyBeslWiDphS8+lricsiUdV6kO
 Xc88t4/S6iQThz9ZqjAjNqdnkbkt4fsc6uYX1FGimrQKmYZwWPCFwNsenMRhNSZrzHVu
 3y7Ojf2ziWKcemk6OrwGQW/0IYc1LUoFJ/q2YTK4oCoV3oLAdjF2IJRh8+plfCHtEOcu
 x8MTLXAZh0l/l+P123US0nbhofNg74s0gs5pEHeIIEm+j4TYm2ucsVl2CO6oPXmiynJd
 hJgQXXvZ6xM7i1qlx2ErubyhUbAV86nQwsiVnyoqdoYlmC9JlKVrnejFG4BC2f2DwOmb
 Qnog==
X-Gm-Message-State: APjAAAWACcsgBnu1Xv09AnK91Qg08S5DqqyXnmHmuDnVyLsAvLq1Ioev
 FoXeOgCLAH3LEDwlAFck0iJlVA==
X-Google-Smtp-Source: APXvYqw4FoREJsbfUQL24oOfoJzGWGnHapOpHigPUxJ/8prWbIWu6lBHM4JQL/h3+S0fG0rUWcOnJg==
X-Received: by 2002:adf:e8c8:: with SMTP id k8mr4535wrn.285.1561478227231;
 Tue, 25 Jun 2019 08:57:07 -0700 (PDT)
Received: from [192.168.1.38] (183.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.183])
 by smtp.gmail.com with ESMTPSA id x16sm1915392wmj.4.2019.06.25.08.57.05
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Tue, 25 Jun 2019 08:57:06 -0700 (PDT)
To: Laurent Vivier <laurent@vivier.eu>, Jason Wang <jasowang@redhat.com>
References: <20190619221933.1981-1-laurent@vivier.eu>
 <20190619221933.1981-4-laurent@vivier.eu>
 <f302ca04-e517-f72a-0067-2ab85ef238f0@vivier.eu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <e9ccdbf4-3703-b6a2-7f58-0739a4cfe7bd@redhat.com>
Date: Tue, 25 Jun 2019 17:57:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <f302ca04-e517-f72a-0067-2ab85ef238f0@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.66
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
 Gerd Hoffmann <kraxel@redhat.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/24/19 10:07 PM, Laurent Vivier wrote:
> Hi,
> 
> Jason, Can I have an Acked-by from you (as network devices maintainer)?

Hmm something seems odd here indeed...

What a stable model! This file has no logical modification since its
introduction, a65f56eeba "Implement sonic netcard (MIPS Jazz)"

Here we had:

static void dp8393x_writeb(void *opaque, hwaddr addr, uint32_t val)
{
    uint16_t old_val = dp8393x_readw(opaque, addr & ~0x1);

    switch (addr & 3) {
    case 0:
        val = val | (old_val & 0xff00);
        break;
    case 1:
        val = (val << 8) | (old_val & 0x00ff);
        break;
    }
    dp8393x_writew(opaque, addr & ~0x1, val);
}

So we had 16-bit endian shifting there.

And few lines below:

    /* XXX: Check byte ordering */
    ...
    /* Calculate the ethernet checksum */
    #ifdef SONIC_CALCULATE_RXCRC
        checksum = cpu_to_le32(crc32(0, buf, rx_len));
    #else
        checksum = 0;
    #endif

After various housekeeping, we get:

84689cbb97 "net/dp8393x: do not use old_mmio accesses"

The MIPS Jazz is known to run in both endianess, but I haven't checked
if at that time both were available.

Have you tried this patch?

-- >8 --
diff --git a/hw/net/dp8393x.c b/hw/net/dp8393x.c
index bdb0b3b2c2..646e11206f 100644
@@ -651,7 +651,7 @@ static const MemoryRegionOps dp8393x_ops = {
     .write = dp8393x_write,
     .impl.min_access_size = 2,
     .impl.max_access_size = 2,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_LITTLE_ENDIAN,
 };
---

(but then mips64-softmmu Jazz would have networking broken).

Regards,

Phil.

> Le 20/06/2019 à 00:19, Laurent Vivier a écrit :
>> This is needed by Quadra 800, this card can run on little-endian
>> or big-endian bus.
>>
>> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
>> Tested-by: Hervé Poussineau <hpoussin@reactos.org>
>> Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> Reviewed-by: Hervé Poussineau <hpoussin@reactos.org>
>> ---
>>  hw/net/dp8393x.c | 88 +++++++++++++++++++++++++++++++-----------------
>>  1 file changed, 57 insertions(+), 31 deletions(-)
>>
>> diff --git a/hw/net/dp8393x.c b/hw/net/dp8393x.c
>> index bdb0b3b2c2..b014c015c6 100644
>> --- a/hw/net/dp8393x.c
>> +++ b/hw/net/dp8393x.c
>> @@ -150,6 +150,7 @@ typedef struct dp8393xState {
>>  
>>      /* Hardware */
>>      uint8_t it_shift;
>> +    bool big_endian;
>>      qemu_irq irq;
>>  #ifdef DEBUG_SONIC
>>      int irq_level;
>> @@ -220,6 +221,29 @@ static uint32_t dp8393x_wt(dp8393xState *s)
>>      return s->regs[SONIC_WT1] << 16 | s->regs[SONIC_WT0];
>>  }
>>  
>> +static uint16_t dp8393x_get(dp8393xState *s, int width, uint16_t *base,
>> +                            int offset)
>> +{
>> +    uint16_t val;
>> +
>> +    if (s->big_endian) {
>> +        val = be16_to_cpu(base[offset * width + width - 1]);
>> +    } else {
>> +        val = le16_to_cpu(base[offset * width]);
>> +    }
>> +    return val;
>> +}
>> +
>> +static void dp8393x_put(dp8393xState *s, int width, uint16_t *base, int offset,
>> +                        uint16_t val)
>> +{
>> +    if (s->big_endian) {
>> +        base[offset * width + width - 1] = cpu_to_be16(val);
>> +    } else {
>> +        base[offset * width] = cpu_to_le16(val);
>> +    }
>> +}
>> +
>>  static void dp8393x_update_irq(dp8393xState *s)
>>  {
>>      int level = (s->regs[SONIC_IMR] & s->regs[SONIC_ISR]) ? 1 : 0;
>> @@ -251,12 +275,12 @@ static void dp8393x_do_load_cam(dp8393xState *s)
>>          /* Fill current entry */
>>          address_space_rw(&s->as, dp8393x_cdp(s),
>>              MEMTXATTRS_UNSPECIFIED, (uint8_t *)data, size, 0);
>> -        s->cam[index][0] = data[1 * width] & 0xff;
>> -        s->cam[index][1] = data[1 * width] >> 8;
>> -        s->cam[index][2] = data[2 * width] & 0xff;
>> -        s->cam[index][3] = data[2 * width] >> 8;
>> -        s->cam[index][4] = data[3 * width] & 0xff;
>> -        s->cam[index][5] = data[3 * width] >> 8;
>> +        s->cam[index][0] = dp8393x_get(s, width, data, 1) & 0xff;
>> +        s->cam[index][1] = dp8393x_get(s, width, data, 1) >> 8;
>> +        s->cam[index][2] = dp8393x_get(s, width, data, 2) & 0xff;
>> +        s->cam[index][3] = dp8393x_get(s, width, data, 2) >> 8;
>> +        s->cam[index][4] = dp8393x_get(s, width, data, 3) & 0xff;
>> +        s->cam[index][5] = dp8393x_get(s, width, data, 3) >> 8;
>>          DPRINTF("load cam[%d] with %02x%02x%02x%02x%02x%02x\n", index,
>>              s->cam[index][0], s->cam[index][1], s->cam[index][2],
>>              s->cam[index][3], s->cam[index][4], s->cam[index][5]);
>> @@ -269,7 +293,7 @@ static void dp8393x_do_load_cam(dp8393xState *s)
>>      /* Read CAM enable */
>>      address_space_rw(&s->as, dp8393x_cdp(s),
>>          MEMTXATTRS_UNSPECIFIED, (uint8_t *)data, size, 0);
>> -    s->regs[SONIC_CE] = data[0 * width];
>> +    s->regs[SONIC_CE] = dp8393x_get(s, width, data, 0);
>>      DPRINTF("load cam done. cam enable mask 0x%04x\n", s->regs[SONIC_CE]);
>>  
>>      /* Done */
>> @@ -290,10 +314,10 @@ static void dp8393x_do_read_rra(dp8393xState *s)
>>          MEMTXATTRS_UNSPECIFIED, (uint8_t *)data, size, 0);
>>  
>>      /* Update SONIC registers */
>> -    s->regs[SONIC_CRBA0] = data[0 * width];
>> -    s->regs[SONIC_CRBA1] = data[1 * width];
>> -    s->regs[SONIC_RBWC0] = data[2 * width];
>> -    s->regs[SONIC_RBWC1] = data[3 * width];
>> +    s->regs[SONIC_CRBA0] = dp8393x_get(s, width, data, 0);
>> +    s->regs[SONIC_CRBA1] = dp8393x_get(s, width, data, 1);
>> +    s->regs[SONIC_RBWC0] = dp8393x_get(s, width, data, 2);
>> +    s->regs[SONIC_RBWC1] = dp8393x_get(s, width, data, 3);
>>      DPRINTF("CRBA0/1: 0x%04x/0x%04x, RBWC0/1: 0x%04x/0x%04x\n",
>>          s->regs[SONIC_CRBA0], s->regs[SONIC_CRBA1],
>>          s->regs[SONIC_RBWC0], s->regs[SONIC_RBWC1]);
>> @@ -408,12 +432,12 @@ static void dp8393x_do_transmit_packets(dp8393xState *s)
>>          tx_len = 0;
>>  
>>          /* Update registers */
>> -        s->regs[SONIC_TCR] = data[0 * width] & 0xf000;
>> -        s->regs[SONIC_TPS] = data[1 * width];
>> -        s->regs[SONIC_TFC] = data[2 * width];
>> -        s->regs[SONIC_TSA0] = data[3 * width];
>> -        s->regs[SONIC_TSA1] = data[4 * width];
>> -        s->regs[SONIC_TFS] = data[5 * width];
>> +        s->regs[SONIC_TCR] = dp8393x_get(s, width, data, 0) & 0xf000;
>> +        s->regs[SONIC_TPS] = dp8393x_get(s, width, data, 1);
>> +        s->regs[SONIC_TFC] = dp8393x_get(s, width, data, 2);
>> +        s->regs[SONIC_TSA0] = dp8393x_get(s, width, data, 3);
>> +        s->regs[SONIC_TSA1] = dp8393x_get(s, width, data, 4);
>> +        s->regs[SONIC_TFS] = dp8393x_get(s, width, data, 5);
>>  
>>          /* Handle programmable interrupt */
>>          if (s->regs[SONIC_TCR] & SONIC_TCR_PINT) {
>> @@ -439,9 +463,9 @@ static void dp8393x_do_transmit_packets(dp8393xState *s)
>>                  address_space_rw(&s->as,
>>                      dp8393x_ttda(s) + sizeof(uint16_t) * (4 + 3 * i) * width,
>>                      MEMTXATTRS_UNSPECIFIED, (uint8_t *)data, size, 0);
>> -                s->regs[SONIC_TSA0] = data[0 * width];
>> -                s->regs[SONIC_TSA1] = data[1 * width];
>> -                s->regs[SONIC_TFS] = data[2 * width];
>> +                s->regs[SONIC_TSA0] = dp8393x_get(s, width, data, 0);
>> +                s->regs[SONIC_TSA1] = dp8393x_get(s, width, data, 1);
>> +                s->regs[SONIC_TFS] = dp8393x_get(s, width, data, 2);
>>              }
>>          }
>>  
>> @@ -468,7 +492,8 @@ static void dp8393x_do_transmit_packets(dp8393xState *s)
>>          s->regs[SONIC_TCR] |= SONIC_TCR_PTX;
>>  
>>          /* Write status */
>> -        data[0 * width] = s->regs[SONIC_TCR] & 0x0fff; /* status */
>> +        dp8393x_put(s, width, data, 0,
>> +                    s->regs[SONIC_TCR] & 0x0fff); /* status */
>>          size = sizeof(uint16_t) * width;
>>          address_space_rw(&s->as,
>>              dp8393x_ttda(s),
>> @@ -482,8 +507,8 @@ static void dp8393x_do_transmit_packets(dp8393xState *s)
>>                               sizeof(uint16_t) *
>>                               (4 + 3 * s->regs[SONIC_TFC]) * width,
>>                  MEMTXATTRS_UNSPECIFIED, (uint8_t *)data, size, 0);
>> -            s->regs[SONIC_CTDA] = data[0 * width] & ~0x1;
>> -            if (data[0 * width] & 0x1) {
>> +            s->regs[SONIC_CTDA] = dp8393x_get(s, width, data, 0) & ~0x1;
>> +            if (dp8393x_get(s, width, data, 0) & 0x1) {
>>                  /* EOL detected */
>>                  break;
>>              }
>> @@ -746,7 +771,7 @@ static ssize_t dp8393x_receive(NetClientState *nc, const uint8_t * buf,
>>          address = dp8393x_crda(s) + sizeof(uint16_t) * 5 * width;
>>          address_space_rw(&s->as, address, MEMTXATTRS_UNSPECIFIED,
>>                           (uint8_t *)data, size, 0);
>> -        if (data[0 * width] & 0x1) {
>> +        if (dp8393x_get(s, width, data, 0) & 0x1) {
>>              /* Still EOL ; stop reception */
>>              return -1;
>>          } else {
>> @@ -790,11 +815,11 @@ static ssize_t dp8393x_receive(NetClientState *nc, const uint8_t * buf,
>>  
>>      /* Write status to memory */
>>      DPRINTF("Write status at %08x\n", dp8393x_crda(s));
>> -    data[0 * width] = s->regs[SONIC_RCR]; /* status */
>> -    data[1 * width] = rx_len; /* byte count */
>> -    data[2 * width] = s->regs[SONIC_TRBA0]; /* pkt_ptr0 */
>> -    data[3 * width] = s->regs[SONIC_TRBA1]; /* pkt_ptr1 */
>> -    data[4 * width] = s->regs[SONIC_RSC]; /* seq_no */
>> +    dp8393x_put(s, width, data, 0, s->regs[SONIC_RCR]); /* status */
>> +    dp8393x_put(s, width, data, 1, rx_len); /* byte count */
>> +    dp8393x_put(s, width, data, 2, s->regs[SONIC_TRBA0]); /* pkt_ptr0 */
>> +    dp8393x_put(s, width, data, 3, s->regs[SONIC_TRBA1]); /* pkt_ptr1 */
>> +    dp8393x_put(s, width, data, 4, s->regs[SONIC_RSC]); /* seq_no */
>>      size = sizeof(uint16_t) * 5 * width;
>>      address_space_rw(&s->as, dp8393x_crda(s),
>>          MEMTXATTRS_UNSPECIFIED, (uint8_t *)data, size, 1);
>> @@ -803,12 +828,12 @@ static ssize_t dp8393x_receive(NetClientState *nc, const uint8_t * buf,
>>      size = sizeof(uint16_t) * width;
>>      address_space_rw(&s->as, dp8393x_crda(s) + sizeof(uint16_t) * 5 * width,
>>          MEMTXATTRS_UNSPECIFIED, (uint8_t *)data, size, 0);
>> -    s->regs[SONIC_LLFA] = data[0 * width];
>> +    s->regs[SONIC_LLFA] = dp8393x_get(s, width, data, 0);
>>      if (s->regs[SONIC_LLFA] & 0x1) {
>>          /* EOL detected */
>>          s->regs[SONIC_ISR] |= SONIC_ISR_RDE;
>>      } else {
>> -        data[0 * width] = 0; /* in_use */
>> +        dp8393x_put(s, width, data, 0, 0); /* in_use */
>>          address_space_rw(&s->as, dp8393x_crda(s) + sizeof(uint16_t) * 6 * width,
>>              MEMTXATTRS_UNSPECIFIED, (uint8_t *)data, sizeof(uint16_t), 1);
>>          s->regs[SONIC_CRDA] = s->regs[SONIC_LLFA];
>> @@ -921,6 +946,7 @@ static Property dp8393x_properties[] = {
>>      DEFINE_NIC_PROPERTIES(dp8393xState, conf),
>>      DEFINE_PROP_PTR("dma_mr", dp8393xState, dma_mr),
>>      DEFINE_PROP_UINT8("it_shift", dp8393xState, it_shift, 0),
>> +    DEFINE_PROP_BOOL("big_endian", dp8393xState, big_endian, false),
>>      DEFINE_PROP_END_OF_LIST(),
>>  };
>>  
>>
> 
> 

