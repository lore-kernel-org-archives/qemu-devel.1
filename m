Return-Path: <SRS0=ZEKs=WJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C680C433FF
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 10:23:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42D9120679
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 10:23:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42D9120679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50888 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxTxV-0001CA-K6
	for qemu-devel@archiver.kernel.org; Tue, 13 Aug 2019 06:23:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33458)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hxTvn-00072m-Rl
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 06:21:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hxTvm-00037V-KO
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 06:21:31 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46963)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hxTvm-000378-EW
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 06:21:30 -0400
Received: by mail-wr1-f65.google.com with SMTP id z1so107235755wru.13
 for <qemu-devel@nongnu.org>; Tue, 13 Aug 2019 03:21:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=1YkOJiU1IongVCAyEAwwFy9wuL2HdWzMKJZHf9p/xcI=;
 b=TzICq91h7mxX3sSc83ZY0tLe/29gWZQCGCeurU81VqsRAaMphSois5v//BeV2VgCmS
 vgtAlzxwOJIi6XwOzVJq/sphEEdTnvbtUCgDqvLRG/fQ5eQ6vG/O+oCOJbjYG2lXQDsN
 eaHWHcYwIaDP9tk5xo8E94lvaAp0Z1YD7kKeTz6IDCF0OzV6SKz5D3SasK9F7UTb/bS1
 MouwKbkAEHP/2A57N1QcWp4IqmEJoESl37XFWLR4QkGWB6HQXA7wzNuOviC4hHK8q6Iv
 FQrDX8WvqUEdg3RlN8nkUt2KKCQc32PEkva9yr5AjmLYpOmWTF0jtokK93cLWNhb7Bw1
 kFJQ==
X-Gm-Message-State: APjAAAUOJ6+32UUzYzfDJJXeHE/yI2qg6IOjtFonXEZULUc6+2CMoJd0
 tackfY6DgTPoCt0TGH/p8qP1hA==
X-Google-Smtp-Source: APXvYqzjWbSyM1SQLC8JTDUE1V/iiJJbR2MJwAO7ADJ+jqrfF5KNjZ9B/M6lnfS1OCA1A5YUuplPlg==
X-Received: by 2002:adf:c508:: with SMTP id q8mr18252610wrf.287.1565691689428; 
 Tue, 13 Aug 2019 03:21:29 -0700 (PDT)
Received: from [192.168.1.35] (251.red-88-10-102.dynamicip.rima-tde.net.
 [88.10.102.251])
 by smtp.gmail.com with ESMTPSA id j9sm5076751wrx.66.2019.08.13.03.21.28
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Tue, 13 Aug 2019 03:21:28 -0700 (PDT)
To: Thomas Huth <huth@tuxfamily.org>, qemu-devel@nongnu.org
References: <20190709073222.26370-1-huth@tuxfamily.org>
 <20190709073222.26370-5-huth@tuxfamily.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <be19c77f-2228-86e4-f852-614420933372@redhat.com>
Date: Tue, 13 Aug 2019 12:21:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190709073222.26370-5-huth@tuxfamily.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.65
Subject: Re: [Qemu-devel] [PATCH v4 4/6] escc: introduce a selector for the
 register bit
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
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/9/19 9:32 AM, Thomas Huth wrote:
> From: Laurent Vivier <laurent@vivier.eu>
> 
> On Sparc and PowerMac, the bit 0 of the address selects the register
> type (control or data) and bit 1 selects the channel (B or A).
> 
> On m68k Macintosh and NeXTcube, the bit 0 selects the channel and
> bit 1 the register type.
> 
> This patch introduces a new parameter (bit_swap) to the device interface
> to indicate bits usage must be swapped between registers and channels.
> 
> For the moment all the machines use the bit 0, but this change will be
> needed to emulate Quadra 800 and the NeXTcube machine.
> 
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> Reviewed-by: Hervé Poussineau <hpoussin@reactos.org>
> [thh: added NeXTcube to the patch description]
> Signed-off-by: Thomas Huth <huth@tuxfamily.org>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

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

