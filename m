Return-Path: <SRS0=mHy3=VQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43EBEC76195
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 13:27:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 203CF21849
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 13:27:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 203CF21849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45232 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hoSup-0008KX-1i
	for qemu-devel@archiver.kernel.org; Fri, 19 Jul 2019 09:27:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35398)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hoSuG-00063F-Qb
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 09:26:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hoSuF-0008Om-BV
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 09:26:40 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43425)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hoSuF-0008OB-4Q
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 09:26:39 -0400
Received: by mail-wr1-f66.google.com with SMTP id p13so32237518wru.10
 for <qemu-devel@nongnu.org>; Fri, 19 Jul 2019 06:26:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=zpvdhbcgNmMV6O50ezlXk3Iu7JYFRd/WhriA3rDTGwo=;
 b=TBISELE9sUSkllg1fWe3nlYGzrUd94AMRUM5c7HsIm3gbmHqDhNEdl1i0oQ/F+nDaN
 q+UwRsTkswqYmbQgqF3ukcjffKSf6yiWtuvHNd6kW1yKgKy+4OVLiAnYIo8O8mvigN9n
 iwbSeHVHNh7M0OsdZcbOdwQTcxG7b3giShihhymjMwAnnvtrGtEzfKcK/BCxbcYvqYb7
 LUdoVlQsnItBJVHFZjv72CbrSyV+0OYHdA33wyUl7qCmAcpnfXuFxkdL2qZ/oKMsopu0
 6xtJSR9mLJLcqRTjjDxCS8k/urPzptdbin0Os1Q2HlFQzFmOj1p4PRIyjrnfUoQHW+NW
 45wQ==
X-Gm-Message-State: APjAAAVfty3Gd4f+0dHhJx+g4OMjee5xSISnGy6B/Hn4SaBc9NGmspK6
 JjK5xK50w5zNMBii++DwtvNHwQ==
X-Google-Smtp-Source: APXvYqxxvBON0ACltwoueT8Crerwxbr2LS9ZY3yBe9R3G8uo6+Yiaz8L2Y9reSn84h6aBZznGEMIhw==
X-Received: by 2002:a5d:6a84:: with SMTP id s4mr55658805wru.125.1563542798043; 
 Fri, 19 Jul 2019 06:26:38 -0700 (PDT)
Received: from [192.168.1.37] (62.red-83-42-61.dynamicip.rima-tde.net.
 [83.42.61.62])
 by smtp.gmail.com with ESMTPSA id p12sm24587087wrt.13.2019.07.19.06.26.37
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Fri, 19 Jul 2019 06:26:37 -0700 (PDT)
To: Michael Rolnik <mrolnik@gmail.com>, qemu-devel@nongnu.org
References: <20190719082647.18113-1-mrolnik@gmail.com>
 <20190719082647.18113-9-mrolnik@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <da64fd46-c0f0-b6b6-3b8f-d3da9041605d@redhat.com>
Date: Fri, 19 Jul 2019 15:26:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190719082647.18113-9-mrolnik@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.66
Subject: Re: [Qemu-devel] [PATCH v27 8/8] target/avr: Add tests
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
Cc: Thomas Huth <thuth@redhat.com>, richard.henderson@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/19/19 10:26 AM, Michael Rolnik wrote:
> 1. Avocado test
>     The test is based on
>     https://github.com/seharris/qemu-avr-tests/tree/master/free-rtos/Demo
>     demo which, If working correctly, prints 'ABCDEFGHIJKLMNOPQRSTUVWX' out

Note, that test also demonstrates the timer and irq are working :)

Enabling DB_PRINT:

avr_timer16_interrupt: CTC OCRA overflow
avr_timer16_interrupt: interrupt, cnt = 253
avr_timer16_interrupt: CTC OCRA overflow
avr_timer16_interrupt: interrupt, cnt = 269
avr_timer16_interrupt: CTC OCRA overflow
avr_timer16_interrupt: interrupt, cnt = 269

(There is also GPIO accesses but you don't implement them yet).

> 
> 2. Boot serial test
>     Prinit out 'T' through serial port

Excellent!

> 
> Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
> ---
>  tests/Makefile.include           |  2 ++
>  tests/acceptance/machine_avr6.py | 36 ++++++++++++++++++++++++++++++++
>  tests/boot-serial-test.c         | 12 +++++++++++
>  3 files changed, 50 insertions(+)
>  create mode 100644 tests/acceptance/machine_avr6.py
> 
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index fd7fdb8658..8a186dcc23 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -201,6 +201,8 @@ check-qtest-i386-y += tests/test-x86-cpuid-compat$(EXESUF)
>  check-qtest-i386-y += tests/numa-test$(EXESUF)
>  check-qtest-x86_64-y += $(check-qtest-i386-y)
>  
> +check-qtest-avr-y += tests/boot-serial-test$(EXESUF)
> +
>  check-qtest-alpha-y += tests/boot-serial-test$(EXESUF)
>  check-qtest-alpha-$(CONFIG_VGA) += tests/display-vga-test$(EXESUF)
>  
> diff --git a/tests/acceptance/machine_avr6.py b/tests/acceptance/machine_avr6.py
> new file mode 100644
> index 0000000000..0601080b01
> --- /dev/null
> +++ b/tests/acceptance/machine_avr6.py
> @@ -0,0 +1,36 @@
> +import logging
> +import time
> +import distutils.spawn
> +
> +from avocado import skipUnless
> +from avocado_qemu import Test
> +from avocado.utils import process
> +
> +class AVR6Machine(Test):
> +    timeout = 5
> +
> +    def test_freertos(self):
> +        """
> +        :avocado: tags=arch:avr
> +        :avocado: tags=machine:sample
> +        """
> +        """
> +        https://github.com/seharris/qemu-avr-tests/raw/master/free-rtos/Demo/AVR_ATMega2560_GCC/demo.elf
> +        constantly prints out 'ABCDEFGHIJKLMNOPQRSTUVWXABCDEFGHIJKLMNOPQRSTUVWX'
> +        """
> +        rom_url = 'https://github.com/seharris/qemu-avr-tests'
> +        rom_url += '/raw/master/free-rtos/Demo/AVR_ATMega2560_GCC/demo.elf'
> +        rom_hash = '7eb521f511ca8f2622e0a3c5e8dd686efbb911d4'
> +        rom_path = self.fetch_asset(rom_url, asset_hash=rom_hash)
> +
> +        self.vm.set_machine('sample')
> +        self.vm.add_args('-bios', rom_path)
> +        self.vm.add_args('-nographic')
> +        self.vm.launch()
> +
> +        time.sleep(2)
> +        self.vm.shutdown()
> +
> +        match = 'ABCDEFGHIJKLMNOPQRSTUVWXABCDEFGHIJKLMNOPQRSTUVWX'
> +
> +        self.assertIn(match, self.vm.get_log())
> diff --git a/tests/boot-serial-test.c b/tests/boot-serial-test.c
> index 24852d4c7d..73d273b73f 100644
> --- a/tests/boot-serial-test.c
> +++ b/tests/boot-serial-test.c
> @@ -16,6 +16,17 @@
>  #include "qemu/osdep.h"
>  #include "libqtest.h"
>  
> +static const uint8_t bios_avr[] = {
> +    0x89, 0xe1,             /* ldi r24, 0x19   */
> +    0x80, 0x93, 0xc5, 0x00, /* sts 0x00C5, r24 ; set baud rate to 38400 */

FWIW we can remove the previous two lines, we don't care about the
baudrate in this test.

> +    0x88, 0xe0,             /* ldi r24, 0x08   */
> +    0x80, 0x93, 0xc1, 0x00, /* sts 0x00C1, r24 ; Enable tx */
> +    0x86, 0xe0,             /* ldi r24, 0x06   */
> +    0x80, 0x93, 0xc2, 0x00, /* sts 0x00C2, r24 ; Set the data bits to 8 */
> +    0x84, 0xe5,             /* ldi r24, 0x54   */
> +    0x80, 0x93, 0xc6, 0x00, /* sts 0x00C6, r24 ; Output 'T' */
> +};
> +
>  static const uint8_t kernel_mcf5208[] = {
>      0x41, 0xf9, 0xfc, 0x06, 0x00, 0x00,     /* lea 0xfc060000,%a0 */
>      0x10, 0x3c, 0x00, 0x54,                 /* move.b #'T',%d0 */
> @@ -92,6 +103,7 @@ typedef struct testdef {
>  
>  static testdef_t tests[] = {
>      { "alpha", "clipper", "", "PCI:" },
> +    { "avr", "sample", "", "T", sizeof(bios_avr), NULL, bios_avr },
>      { "ppc", "ppce500", "", "U-Boot" },
>      { "ppc", "40p", "-vga none -boot d", "Trying cd:," },
>      { "ppc", "g3beige", "", "PowerPC,750" },
> 

Testing shows:

  TEST    check-qtest-avr: tests/boot-serial-test
qemu-system-avr: Unable to load /tmp/qtest-boot-serial-cOndewD as ELF,
trying again as raw binary

I wonder if this might fail Peter's testing, so Cc'ing Thomas.

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

Regards,

Phil.

