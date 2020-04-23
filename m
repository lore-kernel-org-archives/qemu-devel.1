Return-Path: <SRS0=5yua=6H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F662C2BA19
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 09:04:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E51242075A
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 09:04:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E51242075A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39260 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRXmo-0004HL-2S
	for qemu-devel@archiver.kernel.org; Thu, 23 Apr 2020 05:04:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36090)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <geert@linux-m68k.org>) id 1jRXjf-0000o4-II
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 05:01:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <geert@linux-m68k.org>) id 1jRXjb-0001Dj-Fv
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 05:01:31 -0400
Received: from xavier.telenet-ops.be ([2a02:1800:120:4::f00:14]:36684)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <geert@linux-m68k.org>)
 id 1jRXja-0001BY-GS
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 05:01:26 -0400
Received: from ramsan ([IPv6:2a02:1810:ac12:ed60:89cc:efc7:85ce:4669])
 by xavier.telenet-ops.be with bizsmtp
 id W91L2200Q1RvcFS0191LFG; Thu, 23 Apr 2020 11:01:21 +0200
Received: from rox.of.borg ([192.168.97.57]) by ramsan with esmtp (Exim 4.90_1)
 (envelope-from <geert@linux-m68k.org>)
 id 1jRXjU-0006kA-Al; Thu, 23 Apr 2020 11:01:20 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
 (envelope-from <geert@linux-m68k.org>)
 id 1jRXjU-0002vS-7c; Thu, 23 Apr 2020 11:01:20 +0200
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <graf@amazon.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Bartosz Golaszewski <bartekgola@gmail.com>,
 Magnus Damm <magnus.damm@gmail.com>
Subject: [PATCH QEMU v2 0/5] Add a GPIO backend
Date: Thu, 23 Apr 2020 11:01:13 +0200
Message-Id: <20200423090118.11199-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Received-SPF: none client-ip=2a02:1800:120:4::f00:14;
 envelope-from=geert@linux-m68k.org; helo=xavier.telenet-ops.be
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a02:1800:120:4::f00:14
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
Cc: linux-renesas-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 Geert Uytterhoeven <geert+renesas@glider.be>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

	Hi all,

This patch series adds a GPIO controller backend, to connect virtual
GPIOs on the guest to physical GPIOs on the host, and enables support
for this using user-creatable PL061 GPIO controller instances.  This
allows the guest to control any external device connected to the
physical GPIOs.

While this can be used with an upstream Linux kernel (e.g. using a
dedicated GPIO controller connected to an external bus), proper
isolation and assignment of GPIOs to virtual machines depends on the
GPIO Aggregator[1], which has not been accepted in Linux upstream yet.
Aggregating GPIOs and exposing them as a new gpiochip was suggested in
response to my proof-of-concept for GPIO virtualization with QEMU[2][3].

Features and limitations:
  - The backend uses libgpiod on Linux,
  - For now only GPIO outputs are supported,
  - The number of GPIO lines mapped is limited to the number of GPIO
    lines available on the virtual GPIO controller (i.e. 8 on PL061).

Future work:
  - GPIO inputs,
  - GPIO line configuration,
  - Optimizations for controlling multiple GPIO lines at once,
  - ...

This series contains 5 patches:
  - The first two patches refactor the existing code for reuse,
  - The third patch adds a gneric GPIO backend using libgpiod,
  - The fourth patch adds gpiodev support to the PL061 driver,
  - The fifth patch adds dynamic PL061 support to ARM virt.

Changes compared to v1[2]:
  - Drop vgpios and gpios parameters, and map the full gpiochip instead,
  - Replace the single hardcoded PL061 instance (created by ARM virt) by
    multiple dynamically created instances, one per imported GPIO
    controller.

For testing, I have pushed this series to the topic/gpio-backend-v2
branch of my git repository at https://github.com/geertu/qemu.git.

Sample session on the Renesas Salvator-XS development board:

  - Unbind keyboard (shared with LEDs) from gpio-keys driver:

        host$ echo keys > /sys/bus/platform/drivers/gpio-keys/unbind

  - Aggregate GPIO lines connected to LEDs into a new virtual GPIO chip:

        host$ echo e6055400.gpio 11-13 \
              > /sys/bus/platform/drivers/gpio-aggregator/new_device

        gpio-aggregator gpio-aggregator.0: 0 => gpio-371
        gpio-aggregator gpio-aggregator.0: 1 => gpio-372
        gpio-aggregator gpio-aggregator.0: 2 => gpio-373
        gpiochip_find_base: found new base at 343
        gpio gpiochip10: (gpio-aggregator.0): added GPIO chardev (254:10)
        gpiochip_setup_dev: registered GPIOs 343 to 345 on device: gpiochip10 (gpio-aggregator.0)

  - Adjust permissions on /dev/gpiochip10 (optional)

  - Launch QEMU:

        host$ aarch64-softmmu/qemu-system-aarch64 -enable-kvm -M virt \
              -cpu cortex-a57 -m 1024 -nographic -kernel /path/to/Image \
              -device pl061,host=gpio-aggregator.0

        ...
        pl061_gpio c000000.gpio: PL061 GPIO chip registered
        ...

  - Control LEDs:

        guest$ gpioset gpiochip0 0=0 1=1 # LED4 OFF, LED5 ON
        guest$ gpioset gpiochip0 0=1 1=0 # LED4 ON, LED5 OFF

Thanks for your comments!

[1] "[PATCH v6 0/8] gpio: Add GPIO Aggregator"
    (https://lore.kernel.org/linux-gpio/20200324135328.5796-1-geert+renesas@glider.be/)
[2] "[PATCH QEMU POC] Add a GPIO backend"
    (https://lore.kernel.org/linux-gpio/20181003152521.23144-1-geert+renesas@glider.be/)
[3] "Getting To Blinky: Virt Edition / Making device pass-through work
     on embedded ARM"
    (https://fosdem.org/2019/schedule/event/vai_getting_to_blinky/)

Geert Uytterhoeven (5):
  ARM: PL061: Move TYPE_PL061 to hw/gpio/pl061.h
  ARM: PL061: Extract pl061_create_fdt()
  Add a GPIO backend using libgpiod
  ARM: PL061: Add gpiodev support
  hw/arm/virt: Add dynamic PL061 GPIO support

 MAINTAINERS              |  7 +++
 backends/Makefile.objs   |  2 +
 backends/gpiodev.c       | 94 ++++++++++++++++++++++++++++++++++++++++
 configure                | 28 ++++++++++++
 hw/arm/sysbus-fdt.c      | 18 ++++++++
 hw/arm/virt.c            | 21 ++-------
 hw/gpio/pl061.c          | 79 ++++++++++++++++++++++++++++++++-
 include/hw/gpio/pl061.h  | 23 ++++++++++
 include/sysemu/gpiodev.h | 12 +++++
 qemu-options.hx          |  9 ++++
 10 files changed, 275 insertions(+), 18 deletions(-)
 create mode 100644 backends/gpiodev.c
 create mode 100644 include/hw/gpio/pl061.h
 create mode 100644 include/sysemu/gpiodev.h

-- 
2.17.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

