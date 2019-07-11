Return-Path: <SRS0=FHOf=VI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4C52C74A51
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 09:26:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B11BB208E4
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 09:26:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B11BB208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=electromag.com.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39752 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlVLI-0001CZ-Vs
	for qemu-devel@archiver.kernel.org; Thu, 11 Jul 2019 05:26:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43117)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <preid@electromag.com.au>) id 1hlVK0-00009l-Qt
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 05:25:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <preid@electromag.com.au>) id 1hlVJz-0006Vw-P3
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 05:25:00 -0400
Received: from anchovy1.45ru.net.au ([203.30.46.145]:51788)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <preid@electromag.com.au>)
 id 1hlVJx-0006Ok-S0
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 05:24:59 -0400
Received: (qmail 30049 invoked by uid 5089); 11 Jul 2019 09:24:48 -0000
Received: by simscan 1.2.0 ppid: 29900, pid: 29902, t: 0.0630s
 scanners: regex: 1.2.0 attach: 1.2.0 clamav: 0.88.3/m:40/d:1950
Received: from unknown (HELO ?192.168.0.128?)
 (preid@electromag.com.au@203.59.235.95)
 by anchovy1.45ru.net.au with ESMTPA; 11 Jul 2019 09:24:47 -0000
To: Geert Uytterhoeven <geert@linux-m68k.org>
References: <20190705160536.12047-1-geert+renesas@glider.be>
 <8500a069-9e29-d6ad-e5e4-22d5a3eead59@electromag.com.au>
 <CAMuHMdWLcr0pf-ZM3+iWQGwDLB2xoHAZaeCKAjtEVEaiNed63Q@mail.gmail.com>
From: Phil Reid <preid@electromag.com.au>
Message-ID: <1fc3a5ad-6eb6-3356-5fd4-93ce0482bb7e@electromag.com.au>
Date: Thu, 11 Jul 2019 17:24:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <CAMuHMdWLcr0pf-ZM3+iWQGwDLB2xoHAZaeCKAjtEVEaiNed63Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-AU
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.30.46.145
Subject: Re: [Qemu-devel] [PATCH RFC] gpio: Add Virtual Aggregator GPIO
 Driver
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linus Walleij <linus.walleij@linaro.org>, Magnus Damm <magnus.damm@gmail.com>,
 Alexander Graf <agraf@suse.de>, QEMU Developers <qemu-devel@nongnu.org>,
 Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/07/2019 18:21, Geert Uytterhoeven wrote:
> Hi Phil,
> 
> On Wed, Jul 10, 2019 at 4:00 AM Phil Reid <preid@electromag.com.au> wrote:
>> On 6/07/2019 00:05, Geert Uytterhoeven wrote:
>>> GPIO controllers are exported to userspace using /dev/gpiochip*
>>> character devices.  Access control to these devices is provided by
>>> standard UNIX file system permissions, on an all-or-nothing basis:
>>> either a GPIO controller is accessible for a user, or it is not.
>>> Currently no mechanism exists to control access to individual GPIOs.
>>>
>>> Hence add a virtual GPIO driver to aggregate existing GPIOs (up to 32),
>>> and expose them as a new gpiochip.  This is useful for implementing
>>> access control, and assigning a set of GPIOs to a specific user.
>>> Furthermore, it would simplify and harden exporting GPIOs to a virtual
>>> machine, as the VM can just grab the full virtual GPIO controller, and
>>> no longer needs to care about which GPIOs to grab and which not,
>>> reducing the attack surface.
>>>
>>> Virtual GPIO controllers are instantiated by writing to the "new_device"
>>> attribute file in sysfs:
>>>
>>>       $ echo "<gpiochipA> <gpioA1> [<gpioA2> ...]"
>>>              "[, <gpiochipB> <gpioB1> [<gpioB2> ...]] ...]"
>>>               > /sys/bus/platform/drivers/gpio-virt-agg/new_device
>>>
>>> Likewise, virtual GPIO controllers can be destroyed after use:
>>>
>>>       $ echo gpio-virt-agg.<N> \
>>>               > /sys/bus/platform/drivers/gpio-virt-agg/delete_device
>>>
>>
>> Nice.
>> This provides similar functionality to the "gpio inverter" driver currently on the list.
>> Other than being just a buffer.
> 
> Indeed, both drivers forward GPIO calls, but the gpio inverter modifies
> some parameters passed.
> 
> The way the drivers obtain references to GPIOs is different, though: the
> inverter driver obtains a fixed description from DT, while the virtual
> aggregator receives the description at runtime, from sysfs.
> 
> But perhaps both drivers could share some code?
Other than probing they're almost the same, except the inversion.
This one's more complete for set / get multiple etc.

> 
>> Would it be possible to do the lookup via line names?
> 
> Doesn't the fact that a GPIO has a line name means that it is in use, and
> thus cannot be aggregated and exported to another user?
> 

They can be given line names via the dt property gpio-line-names.
Which can be used by user space to find a gpio. Not sure if there's an equivalent api inkerenl.
But it looks like we can find the info via struct gpiochip_info / gpioline_info linfo and work
out the chip name and line offsets. So probably not required.

Find the right gpio always seems tricky.
We have systems with multiple i2c gpio behind muxes that may or may not be present.
So i2c bus numbers are never consistent. And then different board revisions move the
same gpio line to a different pin (or cahnge the gpio chip type completely) to make routing easier etc.




-- 
Regards
Phil Reid

