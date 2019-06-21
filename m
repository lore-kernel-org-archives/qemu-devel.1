Return-Path: <SRS0=2JTU=UU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EF32C43613
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 14:22:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03F6120679
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 14:22:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03F6120679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35546 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1heKQR-0005Nz-6M
	for qemu-devel@archiver.kernel.org; Fri, 21 Jun 2019 10:21:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37521)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1heKKb-0000uE-Es
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 10:15:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1heKEU-0003Xd-Sm
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 10:09:41 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36344)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1heKES-0003Kf-L5
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 10:09:37 -0400
Received: by mail-wr1-f67.google.com with SMTP id n4so5541142wrs.3
 for <qemu-devel@nongnu.org>; Fri, 21 Jun 2019 07:09:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=sV6byMKl59G7ev8i5/GIEY2b5DQTQK4llf8DLy5qge4=;
 b=WjNuU9OI1GjCfOTNUADSlr8Y1TIY7cIiGWIgxdGsxEQoCjLodka/gifmylPi5VyOi7
 Z9j2D31YP0JMenJBQl9OYCWfPlqkF3qJgtYbDb2P/tQFw81wwcBI30PTFwvhNK6zLI3C
 genSvu2XYgo5cJSEGw0pdPe067nu+/uq8kFB7IoDtE9rBkhiFRbYpLfspXL7AC3qQaMV
 fnZZQPXY3419/3Ubz7mBw1LshgmmB0EwGuS9mBPoDc0x9jIjOGmeUmxzHL/uBsyiUvXf
 vohpGflryo0KRzMXmBVewRG5RZx3MPqNjydD2iFzd4B17LALAJolsBGHZh59b4LvuIPk
 P8mg==
X-Gm-Message-State: APjAAAUeEDHRB8hy9THIgp/lHGk4hNbY9zbl5ruFCX9qI67aYdKGJGFR
 80KjDopMIpQwnv250Hpv/nQVXA==
X-Google-Smtp-Source: APXvYqyN8XANqg2Z/LyO/2GkVwytATvBLBGohkglnG7ZlJQVGQFhKZz0aTPsUNKHJvquWcALA9Q/bg==
X-Received: by 2002:adf:b1ca:: with SMTP id r10mr19579563wra.156.1561126174204; 
 Fri, 21 Jun 2019 07:09:34 -0700 (PDT)
Received: from [192.168.1.38] (183.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.183])
 by smtp.gmail.com with ESMTPSA id o13sm2884994wra.92.2019.06.21.07.09.32
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Fri, 21 Jun 2019 07:09:33 -0700 (PDT)
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
References: <20190619221933.1981-1-laurent@vivier.eu>
 <20190619221933.1981-2-laurent@vivier.eu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <1de4d92a-4176-6584-0363-6f624ecb5af3@redhat.com>
Date: Fri, 21 Jun 2019 16:09:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190619221933.1981-2-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.67
Subject: Re: [Qemu-devel] [PATCH v8 01/10] escc: introduce a selector for
 the register bit
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
 Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/20/19 12:19 AM, Laurent Vivier wrote:
> On Sparc and PowerMac, the bit 0 of the address
> selects the register type (control or data) and
> bit 1 selects the channel (B or A).
> 
> On m68k Macintosh, the bit 0 selects the channel and
> bit 1 the register type.
> 
> This patch introduces a new parameter (bit_swap) to
> the device interface to indicate bits usage must
> be swapped between registers and channels.
> 
> For the moment all the machines use the bit 0,
> but this change will be needed to emulate Quadra 800.

I feel we are missing something and this model slowly becomes another
Frankenstein. The SCC core is a monster anyway.
I'm glad you could resolve your issue with this easy fix.


> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> Reviewed-by: Hervé Poussineau <hpoussin@reactos.org>
> Reviewed-by: Thomas Huth <huth@tuxfamily.org>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  hw/char/escc.c         | 30 ++++++++++++++++++++++++------
>  include/hw/char/escc.h |  1 +
>  2 files changed, 25 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/char/escc.c b/hw/char/escc.c
> index 8ddbb4be4f..2748bd62c3 100644
> --- a/hw/char/escc.c
> +++ b/hw/char/escc.c
> @@ -43,14 +43,21 @@
>   * mouse and keyboard ports don't implement all functions and they are
>   * only asynchronous. There is no DMA.
>   *
> - * Z85C30 is also used on PowerMacs. There are some small differences
> - * between Sparc version (sunzilog) and PowerMac (pmac):
> + * Z85C30 is also used on PowerMacs and m68k Macs.
> + *
> + * There are some small differences between Sparc version (sunzilog)
> + * and PowerMac (pmac):
>   *  Offset between control and data registers
>   *  There is some kind of lockup bug, but we can ignore it
>   *  CTS is inverted
>   *  DMA on pmac using DBDMA chip
>   *  pmac can do IRDA and faster rates, sunzilog can only do 38400
>   *  pmac baud rate generator clock is 3.6864 MHz, sunzilog 4.9152 MHz
> + *
> + * Linux driver for m68k Macs is the same as for PowerMac (pmac_zilog),
> + * but registers are grouped by type and not by channel:
> + * channel is selected by bit 0 of the address (instead of bit 1)
> + * and register is selected by bit 1 of the address (instead of bit 0).
>   */
>  
>  /*
> @@ -170,6 +177,16 @@ static void handle_kbd_command(ESCCChannelState *s, int val);
>  static int serial_can_receive(void *opaque);
>  static void serial_receive_byte(ESCCChannelState *s, int ch);
>  
> +static int reg_shift(ESCCState *s)
> +{
> +    return s->bit_swap ? s->it_shift + 1 : s->it_shift;
> +}
> +
> +static int chn_shift(ESCCState *s)
> +{
> +    return s->bit_swap ? s->it_shift : s->it_shift + 1;
> +}
> +
>  static void clear_queue(void *opaque)
>  {
>      ESCCChannelState *s = opaque;
> @@ -434,8 +451,8 @@ static void escc_mem_write(void *opaque, hwaddr addr,
>      int newreg, channel;
>  
>      val &= 0xff;
> -    saddr = (addr >> serial->it_shift) & 1;
> -    channel = (addr >> (serial->it_shift + 1)) & 1;
> +    saddr = (addr >> reg_shift(serial)) & 1;
> +    channel = (addr >> chn_shift(serial)) & 1;
>      s = &serial->chn[channel];
>      switch (saddr) {
>      case SERIAL_CTRL:
> @@ -545,8 +562,8 @@ static uint64_t escc_mem_read(void *opaque, hwaddr addr,
>      uint32_t ret;
>      int channel;
>  
> -    saddr = (addr >> serial->it_shift) & 1;
> -    channel = (addr >> (serial->it_shift + 1)) & 1;
> +    saddr = (addr >> reg_shift(serial)) & 1;
> +    channel = (addr >> chn_shift(serial)) & 1;
>      s = &serial->chn[channel];
>      switch (saddr) {
>      case SERIAL_CTRL:
> @@ -830,6 +847,7 @@ static void escc_realize(DeviceState *dev, Error **errp)
>  static Property escc_properties[] = {
>      DEFINE_PROP_UINT32("frequency", ESCCState, frequency,   0),
>      DEFINE_PROP_UINT32("it_shift",  ESCCState, it_shift,    0),
> +    DEFINE_PROP_BOOL("bit_swap",    ESCCState, bit_swap,    false),
>      DEFINE_PROP_UINT32("disabled",  ESCCState, disabled,    0),
>      DEFINE_PROP_UINT32("chnBtype",  ESCCState, chn[0].type, 0),
>      DEFINE_PROP_UINT32("chnAtype",  ESCCState, chn[1].type, 0),
> diff --git a/include/hw/char/escc.h b/include/hw/char/escc.h
> index 42aca83611..8762f61c14 100644
> --- a/include/hw/char/escc.h
> +++ b/include/hw/char/escc.h
> @@ -50,6 +50,7 @@ typedef struct ESCCState {
>  
>      struct ESCCChannelState chn[2];
>      uint32_t it_shift;
> +    bool bit_swap;
>      MemoryRegion mmio;
>      uint32_t disabled;
>      uint32_t frequency;
> 

