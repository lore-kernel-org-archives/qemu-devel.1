Return-Path: <SRS0=ZEKs=WJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACC0BC433FF
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 10:27:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FE9320679
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 10:27:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FE9320679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50926 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxU1e-0002fp-Pb
	for qemu-devel@archiver.kernel.org; Tue, 13 Aug 2019 06:27:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34584)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hxU14-0002Fl-9g
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 06:26:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hxU13-0005xW-5Q
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 06:26:58 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40527)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hxU12-0005wz-Vu
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 06:26:57 -0400
Received: by mail-wr1-f65.google.com with SMTP id r1so8158234wrl.7
 for <qemu-devel@nongnu.org>; Tue, 13 Aug 2019 03:26:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=uV+6cVnuHpEDwnr1SkJlDKXAqzsiWgVbxVCTDpxv5hQ=;
 b=ufCLEBOV3IZEPNJNLF3Hq9S7q0m5b4yDqtW+GH09NpukDUgOucPiLE7ZNlbaz6JjVr
 Aty1gC41r+cefMHCiZQcMK9wQp6nhisxMNg4T16UWV+PNoeBoe5cUi/d7FYlmGqfRWDQ
 rB2zwNdTlvjjVCyY5lQtZ6gdKrdGpUi4niK/UnAvJHOz9WrMrtpONPiR5pB52yU2mSLZ
 m3mZXhcTK0VEoHy1mzSbtsXT4NNcd1k93mCjeOaPGyPYOJfrRM3B+G4yjV9sCIaIaDW3
 m78mGd6HGe2uVaQu0rJTAMy422XscV8xGcsoV8pKO6fxLVjyHdj18MhmbBL8qU7efP37
 PErg==
X-Gm-Message-State: APjAAAVoL1+4MjX/+Z1E4rB7/+rcR0WgbBbYUmQVCGyZGAtoBLCsSouG
 AlWyXACTE4M8aeQx/E9hspT6+Q==
X-Google-Smtp-Source: APXvYqwIWuhbEcUdj9jqbvou1LPtoeJfOmm9k7lEQuXSiY6Ck8VOVG3iAwAI2icysYJhsq+tpL+zmg==
X-Received: by 2002:a05:6000:110f:: with SMTP id
 z15mr33038639wrw.162.1565692015863; 
 Tue, 13 Aug 2019 03:26:55 -0700 (PDT)
Received: from [192.168.1.35] (251.red-88-10-102.dynamicip.rima-tde.net.
 [88.10.102.251])
 by smtp.gmail.com with ESMTPSA id b136sm1644088wme.18.2019.08.13.03.26.54
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Tue, 13 Aug 2019 03:26:54 -0700 (PDT)
To: Thomas Huth <huth@tuxfamily.org>, qemu-devel@nongnu.org
References: <20190709073222.26370-1-huth@tuxfamily.org>
 <20190709073222.26370-6-huth@tuxfamily.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <86168d6b-739e-d638-2141-b0c0e971b42d@redhat.com>
Date: Tue, 13 Aug 2019 12:26:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190709073222.26370-6-huth@tuxfamily.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.65
Subject: Re: [Qemu-devel] [PATCH v4 5/6] m68k: Add serial controller to the
 NeXTcube machine
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
> The NeXTcube uses a normal 8530 serial controller, so we can simply use
> our normal "escc" device here.
> While we're at it, also add a boot-serial-test for the next-cube machine,
> now that the serial output works.
> 
> Signed-off-by: Thomas Huth <huth@tuxfamily.org>

Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  hw/m68k/Kconfig          |  1 +
>  hw/m68k/next-cube.c      | 37 ++++++++++++++++++++++++++++++++++++-
>  tests/boot-serial-test.c | 12 ++++++++++++
>  3 files changed, 49 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/m68k/Kconfig b/hw/m68k/Kconfig
> index ec58a2eb06..a74fac5abd 100644
> --- a/hw/m68k/Kconfig
> +++ b/hw/m68k/Kconfig
> @@ -11,3 +11,4 @@ config MCF5208
>  config NEXTCUBE
>      bool
>      select FRAMEBUFFER
> +    select ESCC
> diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
> index 0737605417..b7f1e9106b 100644
> --- a/hw/m68k/next-cube.c
> +++ b/hw/m68k/next-cube.c
> @@ -846,6 +846,39 @@ void next_irq(void *opaque, int number, int level)
>      }
>  }
>  
> +static void next_serial_irq(void *opaque, int n, int level)
> +{
> +    /* DPRINTF("SCC IRQ NUM %i\n",n); */
> +    if (n) {
> +        next_irq(opaque, NEXT_SCC_DMA_I, level);
> +    } else {
> +        next_irq(opaque, NEXT_SCC_I, level);
> +    }
> +}
> +
> +static void next_escc_init(M68kCPU *cpu)
> +{
> +    qemu_irq *ser_irq = qemu_allocate_irqs(next_serial_irq, cpu, 2);
> +    DeviceState *dev;
> +    SysBusDevice *s;
> +
> +    dev = qdev_create(NULL, TYPE_ESCC);
> +    qdev_prop_set_uint32(dev, "disabled", 0);
> +    qdev_prop_set_uint32(dev, "frequency", 9600 * 384);
> +    qdev_prop_set_uint32(dev, "it_shift", 0);
> +    qdev_prop_set_bit(dev, "bit_swap", true);
> +    qdev_prop_set_chr(dev, "chrB", serial_hd(1));
> +    qdev_prop_set_chr(dev, "chrA", serial_hd(0));
> +    qdev_prop_set_uint32(dev, "chnBtype", escc_serial);
> +    qdev_prop_set_uint32(dev, "chnAtype", escc_serial);
> +    qdev_init_nofail(dev);
> +
> +    s = SYS_BUS_DEVICE(dev);
> +    sysbus_connect_irq(s, 0, ser_irq[0]);
> +    sysbus_connect_irq(s, 1,  ser_irq[1]);
> +    sysbus_mmio_map(s, 0, 0x2118000);
> +}
> +
>  static void next_cube_init(MachineState *machine)
>  {
>      M68kCPU *cpu;
> @@ -937,8 +970,10 @@ static void next_cube_init(MachineState *machine)
>          }
>      }
>  
> -    /* TODO: */
>      /* Serial */
> +    next_escc_init(cpu);
> +
> +    /* TODO: */
>      /* Network */
>      /* SCSI */
>  
> diff --git a/tests/boot-serial-test.c b/tests/boot-serial-test.c
> index 24852d4c7d..c8ded1195e 100644
> --- a/tests/boot-serial-test.c
> +++ b/tests/boot-serial-test.c
> @@ -24,6 +24,17 @@ static const uint8_t kernel_mcf5208[] = {
>      0x60, 0xfa                              /* bra.s  loop */
>  };
>  
> +static const uint8_t bios_nextcube[] = {
> +    0x06, 0x00, 0x00, 0x00,                 /* Initial SP */
> +    0x01, 0x00, 0x00, 0x08,                 /* Initial PC */
> +    0x41, 0xf9, 0x02, 0x11, 0x80, 0x00,     /* lea 0x02118000,%a0 */
> +    0x10, 0x3c, 0x00, 0x54,                 /* move.b #'T',%d0 */
> +    0x11, 0x7c, 0x00, 0x05, 0x00, 0x01,     /* move.b #5,1(%a0)    Sel TXCTRL */
> +    0x11, 0x7c, 0x00, 0x68, 0x00, 0x01,     /* move.b #0x68,1(%a0) Enable TX */
> +    0x11, 0x40, 0x00, 0x03,                 /* move.b %d0,3(%a0)   Print 'T' */
> +    0x60, 0xfa                              /* bra.s  loop */
> +};
> +
>  static const uint8_t kernel_pls3adsp1800[] = {
>      0xb0, 0x00, 0x84, 0x00,                 /* imm   0x8400 */
>      0x30, 0x60, 0x00, 0x04,                 /* addik r3,r0,4 */
> @@ -116,6 +127,7 @@ static testdef_t tests[] = {
>      { "sparc64", "sun4u", "", "UltraSPARC" },
>      { "s390x", "s390-ccw-virtio", "", "device" },
>      { "m68k", "mcf5208evb", "", "TT", sizeof(kernel_mcf5208), kernel_mcf5208 },
> +    { "m68k", "next-cube", "", "TT", sizeof(bios_nextcube), 0, bios_nextcube },
>      { "microblaze", "petalogix-s3adsp1800", "", "TT",
>        sizeof(kernel_pls3adsp1800), kernel_pls3adsp1800 },
>      { "microblazeel", "petalogix-ml605", "", "TT",
> 

