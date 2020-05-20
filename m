Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E642C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 13:44:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C681C207D3
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 13:44:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C681C207D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35754 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbP11-0003Ik-2o
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 09:44:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38144)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andriy.shevchenko@intel.com>)
 id 1jbNcI-0001Rt-BF
 for qemu-devel@nongnu.org; Wed, 20 May 2020 08:14:34 -0400
Received: from mga18.intel.com ([134.134.136.126]:60946)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andriy.shevchenko@intel.com>)
 id 1jbNcG-0003wZ-EZ
 for qemu-devel@nongnu.org; Wed, 20 May 2020 08:14:33 -0400
IronPort-SDR: si5YMHe+LBoEXx42pmN832Giba5jCb9rig6kS3Sh+RBhqsQCNn0/o/v6drcjcc9KFEyLVA0adI
 IEg2DPJUeWBQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 May 2020 05:14:22 -0700
IronPort-SDR: lDMa4IjaXiaO5yuLenq7hmObVwvLlvW7Ra62UtLnUsEjjY2mIF0qAEeS0m13oTAh5q8zO5V6+3
 bIe3XWsVL9Xg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,413,1583222400"; d="scan'208";a="289330311"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
 by fmsmga004.fm.intel.com with ESMTP; 20 May 2020 05:14:18 -0700
Received: from andy by smile with local (Exim 4.93)
 (envelope-from <andriy.shevchenko@intel.com>)
 id 1jbNc4-007pru-GJ; Wed, 20 May 2020 15:14:20 +0300
Date: Wed, 20 May 2020 15:14:20 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PATCH v7 0/6] gpio: Add GPIO Aggregator
Message-ID: <20200520121420.GA1867563@smile.fi.intel.com>
References: <20200511145257.22970-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200511145257.22970-1-geert+renesas@glider.be>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Received-SPF: pass client-ip=134.134.136.126;
 envelope-from=andriy.shevchenko@intel.com; helo=mga18.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/20 08:14:23
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 20 May 2020 09:42:13 -0400
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Phil Reid <preid@electromag.com.au>, Jonathan Corbet <corbet@lwn.net>,
 Marc Zyngier <marc.zyngier@arm.com>, Linus Walleij <linus.walleij@linaro.org>,
 linux-doc@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>,
 Christoffer Dall <christoffer.dall@arm.com>, linux-kernel@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 Harish Jenny K N <harish_kandiga@mentor.com>, linux-gpio@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <graf@amazon.com>,
 Eugeniu Rosca <erosca@de.adit-jv.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, May 11, 2020 at 04:52:51PM +0200, Geert Uytterhoeven wrote:
> 	Hi all,
> 
> GPIO controllers are exported to userspace using /dev/gpiochip*
> character devices.  Access control to these devices is provided by
> standard UNIX file system permissions, on an all-or-nothing basis:
> either a GPIO controller is accessible for a user, or it is not.
> Currently no mechanism exists to control access to individual GPIOs.
> 
> Hence this adds a GPIO driver to aggregate existing GPIOs, and expose
> them as a new gpiochip.  This is useful for implementing access control,
> and assigning a set of GPIOs to a specific user.  Furthermore, this
> simplifies and hardens exporting GPIOs to a virtual machine, as the VM
> can just grab the full GPIO controller, and no longer needs to care
> about which GPIOs to grab and which not, reducing the attack surface.
> This has been implemented for ARM virt in QEMU[1].
> 
> Recently, other use cases have been discovered[2], like describing
> simple GPIO-operated devices in DT, and using the GPIO Aggregator as a
> generic GPIO driver for userspace, which is useful for industrial
> control.
> 
> Note that the first patch of this series ("i2c: i801: Use GPIO_LOOKUP()
> helper macro") has been applied to i2c/for-next.

Sorry for late reply, recently noticed this nice idea.
The comment I have is, please, can we reuse bitmap parse algorithm and syntax?
We have too many different formats and parsers in the kernel and bitmap's one
seems suitable here.

(Despite other small clean ups, like strstrip() use)

> Changes compared to v6[3]:
>   - Document non-uniqueness of line names,
>   - Rebase on top of commit a0b66a73785ccc8f ("gpio: Rename variable in
>     core APIs"),
>   - Maintained => Supported,
>   - Add Reviewed-by, Acked-by,
>   - Drop applied patches:
>       - "ARM: integrator: impd1: Use GPIO_LOOKUP() helper macro",
>       - "gpiolib: Introduce gpiod_set_config()".
> 
> Changes compared to v5[4]:
>   - Convert raw gpiod_lookup users to GPIO_LOOKUP*(),
>   - Update Documentation/driver-api/gpio/board.rst for gpiod_lookup
>     changes,
>   - Reword rationale behing looking up GPIOs by line name,
>   - Introduce gpiod_set_config(),
>   - Use gpiod_to_chip() instead of open-coding,
>   - Drop debug print of gpio_desc.label, as it usually points to the
>     GPIO Aggregator itself,
>   - Drop no longer needed #include "gpiolib.h",
>   - Fix missing offset translation in gpio_fwd_set_config(),
>   - Fix "allows" without object,
>   - Drop "gpiochipN" support,
>   - Extend example.
> 
> Changes compared to v4[5]:
>   - Add Reviewed-by, Tested-by,
>   - Fix inconsistent indentation in documentation.
> 
> Changes compared to v3[6] (more details in the individual patches):
>   - Drop controversial GPIO repeater,
>   - Drop support for legacy sysfs interface based name matching,
>   - Drop applied "gpiolib: Add GPIOCHIP_NAME definition",
>   - Documentation improvements,
>   - Lots of small cleanups.
> 
> Changes compared to v2[7] (more details in the individual patches):
>   - Integrate GPIO Repeater functionality,
>   - Absorb GPIO forwarder library, as the Aggregator and Repeater are
>     now a single driver,
>   - Use the aggregator parameters to create a GPIO lookup table instead
>     of an array of GPIO descriptors,
>   - Add documentation,
>   - New patches:
>       - "gpiolib: Add GPIOCHIP_NAME definition",
>       - "gpiolib: Add support for gpiochipN-based table lookup",
>       - "gpiolib: Add support for GPIO line table lookup",
>       - "dt-bindings: gpio: Add gpio-repeater bindings",
>       - "docs: gpio: Add GPIO Aggregator/Repeater documentation",
>       - "MAINTAINERS: Add GPIO Aggregator/Repeater section".
>   - Dropped patches:
>       - "gpio: Export gpiod_{request,free}() to modular GPIO code",
>       - "gpio: Export gpiochip_get_desc() to modular GPIO code",
>       - "gpio: Export gpio_name_to_desc() to modular GPIO code",
>       - "gpio: Add GPIO Forwarder Helper".
> 
> Changes compared to v1[8]:
>   - Drop "virtual", rename to gpio-aggregator,
>   - Create and use new GPIO Forwarder Helper, to allow sharing code with
>     the GPIO inverter,
>   - Lift limit on the maximum number of GPIOs,
>   - Improve parsing of GPIO specifiers,
>   - Fix modular build.
> 
> Aggregating GPIOs and exposing them as a new gpiochip was suggested in
> response to my proof-of-concept for GPIO virtualization with QEMU[9][10].
> 
> For the first use case, aggregated GPIO controllers are instantiated and
> destroyed by writing to atribute files in sysfs.
> Sample session on the Renesas Koelsch development board:
> 
>   - Unbind LEDs from leds-gpio driver:
> 
>         echo leds > /sys/bus/platform/drivers/leds-gpio/unbind
> 
>   - Create aggregators:
> 
>     $ echo e6052000.gpio 19,20 \
>         > /sys/bus/platform/drivers/gpio-aggregator/new_device
> 
>     gpio-aggregator gpio-aggregator.0: gpio 0 => gpio-953
>     gpio-aggregator gpio-aggregator.0: gpio 1 => gpio-954
>     gpiochip_find_base: found new base at 758
>     gpio gpiochip12: (gpio-aggregator.0): added GPIO chardev (254:13)
>     gpiochip_setup_dev: registered GPIOs 758 to 759 on device: gpiochip12 (gpio-aggregator.0)
> 
>     $ echo e6052000.gpio 21 e6050000.gpio 20-22 \
>         > /sys/bus/platform/drivers/gpio-aggregator/new_device
> 
>     gpio-aggregator gpio-aggregator.1: gpio 0 => gpio-955
>     gpio-aggregator gpio-aggregator.1: gpio 1 => gpio-1012
>     gpio-aggregator gpio-aggregator.1: gpio 2 => gpio-1013
>     gpio-aggregator gpio-aggregator.1: gpio 3 => gpio-1014
>     gpiochip_find_base: found new base at 754
>     gpio gpiochip13: (gpio-aggregator.1): added GPIO chardev (254:13)
>     gpiochip_setup_dev: registered GPIOs 754 to 757 on device: gpiochip13 (gpio-aggregator.1)
> 
>   - Adjust permissions on /dev/gpiochip1[23] (optional)
> 
>   - Control LEDs:
> 
>     $ gpioset gpiochip12 0=0 1=1 # LED6 OFF, LED7 ON
>     $ gpioset gpiochip12 0=1 1=0 # LED6 ON, LED7 OFF
>     $ gpioset gpiochip13 0=1     # LED8 ON
>     $ gpioset gpiochip13 0=0     # LED8 OFF
> 
>   - Destroy aggregators:
> 
>     $ echo gpio-aggregator.0 \
>             > /sys/bus/platform/drivers/gpio-aggregator/delete_device
>     $ echo gpio-aggregator.1 \
>             > /sys/bus/platform/drivers/gpio-aggregator/delete_device
> 
> To ease testing, I have pushed this series to the
> topic/gpio-aggregator-v7 branch of my renesas-drivers repository at
> git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers.git.
> 
> Thanks!
> 
> References:
>   [1] "[PATCH QEMU v2 0/5] Add a GPIO backend"
>       (https://lore.kernel.org/linux-gpio/20200423090118.11199-1-geert+renesas@glider.be/)
>   [2] "[PATCH V4 2/2] gpio: inverter: document the inverter bindings"
>       (https://lore.kernel.org/r/1561699236-18620-3-git-send-email-harish_kandiga@mentor.com/)
>   [3] "[PATCH v6 0/8] gpio: Add GPIO Aggregator"
>       (https://lore.kernel.org/linux-doc/20200324135328.5796-1-geert+renesas@glider.be/)
>   [4] "[PATCH v5 0/5] gpio: Add GPIO Aggregator"
>       (https://lore.kernel.org/r/20200218151812.7816-1-geert+renesas@glider.be/)
>   [5] "[PATCH v4 0/5] gpio: Add GPIO Aggregator"
>       (https://lore.kernel.org/r/20200115181523.23556-1-geert+renesas@glider.be)
>   [6] "[PATCH v3 0/7] gpio: Add GPIO Aggregator/Repeater"
>       (https://lore.kernel.org/r/20191127084253.16356-1-geert+renesas@glider.be/)
>   [7] "[PATCH/RFC v2 0/5] gpio: Add GPIO Aggregator Driver"
>       (https://lore.kernel.org/r/20190911143858.13024-1-geert+renesas@glider.be/)
>   [8] "[PATCH RFC] gpio: Add Virtual Aggregator GPIO Driver"
>       (https://lore.kernel.org/r/20190705160536.12047-1-geert+renesas@glider.be/)
>   [9] "[PATCH QEMU POC] Add a GPIO backend"
>       (https://lore.kernel.org/r/20181003152521.23144-1-geert+renesas@glider.be/)
>  [10] "Getting To Blinky: Virt Edition / Making device pass-through
>        work on embedded ARM"
>       (https://fosdem.org/2019/schedule/event/vai_getting_to_blinky/)
> 
> Geert Uytterhoeven (6):
>   i2c: i801: Use GPIO_LOOKUP() helper macro
>   mfd: sm501: Use GPIO_LOOKUP_IDX() helper macro
>   gpiolib: Add support for GPIO lookup by line name
>   gpio: Add GPIO Aggregator
>   docs: gpio: Add GPIO Aggregator documentation
>   MAINTAINERS: Add GPIO Aggregator section
> 
>  .../admin-guide/gpio/gpio-aggregator.rst      | 111 ++++
>  Documentation/admin-guide/gpio/index.rst      |   1 +
>  Documentation/driver-api/gpio/board.rst       |  15 +-
>  MAINTAINERS                                   |   7 +
>  drivers/gpio/Kconfig                          |  12 +
>  drivers/gpio/Makefile                         |   1 +
>  drivers/gpio/gpio-aggregator.c                | 568 ++++++++++++++++++
>  drivers/gpio/gpiolib.c                        |  22 +-
>  drivers/i2c/busses/i2c-i801.c                 |   6 +-
>  drivers/mfd/sm501.c                           |  24 +-
>  include/linux/gpio/machine.h                  |  17 +-
>  11 files changed, 748 insertions(+), 36 deletions(-)
>  create mode 100644 Documentation/admin-guide/gpio/gpio-aggregator.rst
>  create mode 100644 drivers/gpio/gpio-aggregator.c
> 
> -- 
> 2.17.1
> 
> Gr{oetje,eeting}s,
> 
> 						Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
> 							    -- Linus Torvalds

-- 
With Best Regards,
Andy Shevchenko



