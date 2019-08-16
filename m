Return-Path: <SRS0=pVGd=WM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A2ECC3A59C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 16:22:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11E562063F
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 16:22:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11E562063F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58404 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyf09-0006PH-6c
	for qemu-devel@archiver.kernel.org; Fri, 16 Aug 2019 12:22:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39478)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1hyez3-0005Iu-TB
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 12:21:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1hyez2-0000Zk-Gh
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 12:21:45 -0400
Received: from 6.mo69.mail-out.ovh.net ([46.105.50.107]:36387)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1hyez2-0000Xv-Am
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 12:21:44 -0400
Received: from player728.ha.ovh.net (unknown [10.109.146.122])
 by mo69.mail-out.ovh.net (Postfix) with ESMTP id CBDB066B00
 for <qemu-devel@nongnu.org>; Fri, 16 Aug 2019 18:21:41 +0200 (CEST)
Received: from kaod.org (lfbn-1-2240-157.w90-76.abo.wanadoo.fr [90.76.60.157])
 (Authenticated sender: clg@kaod.org)
 by player728.ha.ovh.net (Postfix) with ESMTPSA id D4EDD8D05A76;
 Fri, 16 Aug 2019 16:21:34 +0000 (UTC)
To: Rashmica Gupta <rashmica.g@gmail.com>, peter.maydell@linaro.org,
 qemu-arm@nongnu.org
References: <20190816073229.22787-1-rashmica.g@gmail.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <120fa848-808f-b918-14f3-ab9d1f06532e@kaod.org>
Date: Fri, 16 Aug 2019 18:21:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190816073229.22787-1-rashmica.g@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 15570351288807361525
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduvddrudeffedgleejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.50.107
Subject: Re: [Qemu-devel] [PATCH v4 0/3] Add Aspeed GPIO controller model
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
Cc: andrew@aj.id.au, aik@ozlabs.ru, qemu-devel@nongnu.org, joel@jms.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 16/08/2019 09:32, Rashmica Gupta wrote:
> v5:
> - integrated AspeedGPIOController fields into AspeedGPIOClass
> - separated ast2600_3_6v and ast2600_1_8v into two classes

Rashmica,

This looks much nicer !  

Please take a look at branch aspeed-4.2 in which I have merged your
v5 and modified slightly the ast2600 part. 

  https://github.com/legoater/qemu/commit/02b3df3f1a380eec4df7c49e88fa7ba27f75a610

I introduced a gpio_1_8v controller with its specific MMIO and IRQ
definitions. Tell me what you think of it. The principal motivation
behind these adjustments is that I don't know yet how we are going 
to instantiate/realize the specific models of the AST2600 SoC. the 
GPIO 1.8v is one of these extra controllers. 

Thanks,

C.

> v4:
> - proper interupt handling thanks to Andrew
> - switch statements for reading and writing suggested by Peter
> - some small cleanups suggested by Alexey
> 
> v3:
> - didn't have each gpio set up as an irq 
> - now can't access set AC on ast2400 (only exists on ast2500)
> - added ast2600 implementation (patch 3)
> - renamed a couple of variables for clarity
> 
> v2: Addressed Andrew's feedback, added debounce regs, renamed get/set to
> read/write to minimise confusion with a 'set' of registers.
> 
> Rashmica Gupta (3):
>   hw/gpio: Add basic Aspeed GPIO model for AST2400 and AST2500
>   aspeed: add a GPIO controller to the SoC
>   hw/gpio: Add in AST2600 specific implementation
> 
>  include/hw/arm/aspeed_soc.h   |    3 +
>  include/hw/gpio/aspeed_gpio.h |  100 ++++
>  hw/arm/aspeed_soc.c           |   17 +
>  hw/gpio/aspeed_gpio.c         | 1006 +++++++++++++++++++++++++++++++++
>  hw/gpio/Makefile.objs         |    1 +
>  5 files changed, 1127 insertions(+)
>  create mode 100644 include/hw/gpio/aspeed_gpio.h
>  create mode 100644 hw/gpio/aspeed_gpio.c
> 


