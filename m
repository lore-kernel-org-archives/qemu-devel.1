Return-Path: <SRS0=7PyC=UX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83C01C43613
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 20:05:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58BD920663
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 20:05:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58BD920663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54348 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfVDf-0007Fu-CU
	for qemu-devel@archiver.kernel.org; Mon, 24 Jun 2019 16:05:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55577)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <laurent@vivier.eu>) id 1hfV9i-0005A9-0l
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 16:01:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1hfV9f-0002pc-VS
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 16:01:33 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:40721)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1hfV9W-0002Yb-RQ; Mon, 24 Jun 2019 16:01:23 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue109 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MPooP-1ht3du0jyN-00MuyG; Mon, 24 Jun 2019 22:00:29 +0200
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
References: <20190619221933.1981-1-laurent@vivier.eu>
 <20190619221933.1981-2-laurent@vivier.eu>
From: Laurent Vivier <laurent@vivier.eu>
Openpgp: preference=signencrypt
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <aa14134d-be95-5c36-4b92-ed7c17935941@vivier.eu>
Date: Mon, 24 Jun 2019 22:00:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190619221933.1981-2-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:AOdMzcFfftHj4+NP0sgQu1PZkfQFAzuVVHTbXhQd+B5Smx6GIWf
 DHatjnehJhk64Lac4DHzpvDH9lSdfWuaVuJS94KnXFrE14Ju14YinlaC+T19tmnBPFx/9lg
 p+xJoa40j2NJWeUBrxnGKD1+tmz8dLBGBgKlP2fng/wCswquUn0b/LcIzsXAdPjaPHsdgei
 goL/zPmvDVTPqF4ydVkbA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:7QcUr9L0X+4=:UpvzBEm73n3up0QNk8DXh/
 cHOJkvx+yyfCmDsQorOrxqrqlc6lXmwtisi+zazd7hJNw000crIl5/Ckpwf2UszOOfWRp9Yad
 0JFk8qWvuFZvhkvlIkSqFohGTVO+MTvmCVqXptsqWy9FFdDvdIb10lT95jjyVx+0peSLGJhWs
 xM8iWvLFwjb6MWAg4+97sJxOCc0IFsGDgapfDGiqT8C7md+LNekVW/tI+e1j0Q06oCU3JKRMW
 1ZnUtuwIoHQR27c51tkj/k3o640IRNKwaj9YfrhpNqN6IC8R6+BJs9QFkW9Vn5fc6yS/+19vR
 pOYGuPc3nyacp4WBg3ohRw9BGGiqmOXFwgrxvL9Xtxjijd5P00j+EZ/ckYnvmYGXMTKyFQHug
 bnc0xW20mKOBVbY3hMElgARj+taUEiE0HJb7bjQniab6d501aVosrGYmj6ZwwOfPNU0T0mJzi
 2Kr3rd1pXkAfA54wI7MEaEkNGyvkLJXmA6KyVOu2yQru0c3fgyEUf1CWW62RON4wmsroAUVeY
 kiodTqy8U3PToVggImeG8jN5T9aOQUTgaRnofB5fLSpSEHbJ0TM+sT5xWD6mhS9+twb8Ox5e1
 +bJuNFcpv0o0qAG4uUrdqRn/y/8V8+TrNwWnG4m7PvVOfkfE3/S35wt2NcqBMhYijzxV8Co+4
 2jFlresEQYeua0VbwGA2DSUFrKeJYNcoLSddAWSPk+If2ah0IC9uVSnL7NTTFcihTb6ldMx70
 6MfTq85WDV1nYlJc3pxiSzup1GvDT08pQVKYZQElDKySGuu6sqqQZ3nwsd0=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.13
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
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

Marc-André, can I have an Acked-by from you (as character devices
maintainer)?

Thanks,
Laurent

Le 20/06/2019 à 00:19, Laurent Vivier a écrit :
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
> 
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> Reviewed-by: Hervé Poussineau <hpoussin@reactos.org>
> Reviewed-by: Thomas Huth <huth@tuxfamily.org>
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


