Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DF8FC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 08:15:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2034420716
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 08:15:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2034420716
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46340 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jne5c-0001oY-EU
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 04:15:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52102)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1jne4z-00019M-Iu
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 04:14:53 -0400
Received: from 7.mo4.mail-out.ovh.net ([178.33.253.54]:53439)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1jne4x-0005uC-IK
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 04:14:53 -0400
Received: from player728.ha.ovh.net (unknown [10.108.57.150])
 by mo4.mail-out.ovh.net (Postfix) with ESMTP id 3A0C023D334
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2020 10:14:49 +0200 (CEST)
Received: from kaod.org (lfbn-tou-1-921-245.w86-210.abo.wanadoo.fr
 [86.210.152.245]) (Authenticated sender: clg@kaod.org)
 by player728.ha.ovh.net (Postfix) with ESMTPSA id 7BB2F138E9B3C;
 Tue, 23 Jun 2020 08:14:40 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-97G002dc86aef1-dfda-4ef9-86ed-df1d4e2690f6,EED1DA90FC9B795DFFB5AB62ED4F19E3D36D96F8)
 smtp.auth=clg@kaod.org
Subject: Re: [PATCH v6 0/9] hw/misc/pca9552: Trace GPIO change events
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200623072723.6324-1-f4bug@amsat.org>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <ff9aec64-419c-330c-bbd3-3b04be70eadd@kaod.org>
Date: Tue, 23 Jun 2020 10:14:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200623072723.6324-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 13400460694721760171
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduhedrudekgedgtdduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepuffvfhfhkffffgggjggtgfesthekredttdefjeenucfhrhhomhepveorughrihgtpgfnvggpifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucggtffrrghtthgvrhhnpeejleduuedvgfefteeftdeikeeutdffgeetvdetgfeuteeghffgueejtdeujeegveenucffohhmrghinhepmhgrihhlqdgrrhgthhhivhgvrdgtohhmnecukfhppedtrddtrddtrddtpdekiedrvddutddrudehvddrvdegheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejvdekrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgh
Received-SPF: pass client-ip=178.33.253.54; envelope-from=clg@kaod.org;
 helo=7.mo4.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/23 04:14:49
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Andrew Jeffery <andrew@aj.id.au>, Corey Minyard <cminyard@mvista.com>,
 qemu-arm@nongnu.org, Joel Stanley <joel@jms.id.au>,
 Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/23/20 9:27 AM, Philippe Mathieu-Daudé wrote:
> This series add trace events to better display GPIO changes.
> We'll continue in the following series by connecting LEDs to
> these GPIOs.
> 
> This helps me to work on a generic LED device, see:
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg711917.html


Tested-by: Cédric Le Goater <clg@kaod.org>

Thanks,

C. 

> 
> Since v5, addressed Cédric review comment:
> - Move pin_count check from realize() to instance_init()
> 
> Since v4: Addressed Cédric review comments
> - Extract PCA955xClass
> - Add/use pca955x_pins_get_status() method instead of keeping
>   cached value in PCA955xState
> 
> Example when booting an obmc-phosphor-image, we can see the LED #14
> (front-power LED) starting to blink.
> 
> - ASCII LED bar view:
> 
>   $ qemu-system-arm -M witherspoon-bmc -trace pca955x_gpio_status
>   1592689902.327837:pca955x_gpio_status pca-unspecified GPIOs 0-15 [*...............]
>   1592689902.329934:pca955x_gpio_status pca-unspecified GPIOs 0-15 [**..............]
>   1592689902.330717:pca955x_gpio_status pca-unspecified GPIOs 0-15 [***.............]
>   1592689902.331431:pca955x_gpio_status pca-unspecified GPIOs 0-15 [****............]
>   1592689902.332163:pca955x_gpio_status pca-unspecified GPIOs 0-15 [****.........*..]
>   1592689902.332888:pca955x_gpio_status pca-unspecified GPIOs 0-15 [****.........**.]
>   1592689902.333629:pca955x_gpio_status pca-unspecified GPIOs 0-15 [****.........***]
>   1592690032.793289:pca955x_gpio_status pca-unspecified GPIOs 0-15 [****.........*.*]
>   1592690033.303163:pca955x_gpio_status pca-unspecified GPIOs 0-15 [****.........***]
>   1592690033.812962:pca955x_gpio_status pca-unspecified GPIOs 0-15 [****.........*.*]
>   1592690034.323234:pca955x_gpio_status pca-unspecified GPIOs 0-15 [****.........***]
>   1592690034.832922:pca955x_gpio_status pca-unspecified GPIOs 0-15 [****.........*.*]
> 
> - Only display GPIOs which status changes:
> 
>   $ qemu-system-arm -M witherspoon-bmc -trace pca955x_gpio_change
>   1592690552.687372:pca955x_gpio_change pca1 GPIO id:0 status: 0 -> 1
>   1592690552.690169:pca955x_gpio_change pca1 GPIO id:1 status: 0 -> 1
>   1592690552.691673:pca955x_gpio_change pca1 GPIO id:2 status: 0 -> 1
>   1592690552.696886:pca955x_gpio_change pca1 GPIO id:3 status: 0 -> 1
>   1592690552.698614:pca955x_gpio_change pca1 GPIO id:13 status: 0 -> 1
>   1592690552.699833:pca955x_gpio_change pca1 GPIO id:14 status: 0 -> 1
>   1592690552.700842:pca955x_gpio_change pca1 GPIO id:15 status: 0 -> 1
>   1592690683.841921:pca955x_gpio_change pca1 GPIO id:14 status: 1 -> 0
>   1592690683.861660:pca955x_gpio_change pca1 GPIO id:14 status: 0 -> 1
>   1592690684.371460:pca955x_gpio_change pca1 GPIO id:14 status: 1 -> 0
>   1592690684.882115:pca955x_gpio_change pca1 GPIO id:14 status: 0 -> 1
>   1592690685.391411:pca955x_gpio_change pca1 GPIO id:14 status: 1 -> 0
>   1592690685.901391:pca955x_gpio_change pca1 GPIO id:14 status: 0 -> 1
> 
> For information about how to test the obmc-phosphor-image, see:
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg712911.html
> 
> $ git backport-diff -u v5
> Key:
> [----] : patches are identical
> [####] : number of functional differences between upstream/downstream patch
> [down] : patch is downstream-only
> The flags [FC] indicate (F)unctional and (C)ontextual differences, respectively
> 
> 001/9:[----] [--] 'hw/i2c/core: Add i2c_try_create_slave() and i2c_realize_and_unref()'
> 002/9:[----] [--] 'hw/misc/pca9552: Rename 'nr_leds' as 'pin_count''
> 003/9:[----] [--] 'hw/misc/pca9552: Rename generic code as pca955x'
> 004/9:[0010] [FC] 'hw/misc/pca9552: Add generic PCA955xClass, parent of TYPE_PCA9552'
> 005/9:[0007] [FC] 'hw/misc/pca9552: Add a 'description' property for debugging purpose'
> 006/9:[----] [--] 'hw/misc/pca9552: Trace GPIO High/Low events'
> 007/9:[----] [-C] 'hw/arm/aspeed: Describe each PCA9552 device'
> 008/9:[----] [--] 'hw/misc/pca9552: Trace GPIO change events'
> 009/9:[0003] [FC] 'hw/misc/pca9552: Model qdev output GPIOs'
> 
> Based-on: <20200623072132.2868-1-f4bug@amsat.org>
> 
> Philippe Mathieu-Daudé (9):
>   hw/i2c/core: Add i2c_try_create_slave() and i2c_realize_and_unref()
>   hw/misc/pca9552: Rename 'nr_leds' as 'pin_count'
>   hw/misc/pca9552: Rename generic code as pca955x
>   hw/misc/pca9552: Add generic PCA955xClass, parent of TYPE_PCA9552
>   hw/misc/pca9552: Add a 'description' property for debugging purpose
>   hw/misc/pca9552: Trace GPIO High/Low events
>   hw/arm/aspeed: Describe each PCA9552 device
>   hw/misc/pca9552: Trace GPIO change events
>   hw/misc/pca9552: Model qdev output GPIOs
> 
>  include/hw/i2c/i2c.h      |   2 +
>  include/hw/misc/pca9552.h |  16 +--
>  hw/arm/aspeed.c           |  13 ++-
>  hw/i2c/core.c             |  18 +++-
>  hw/misc/pca9552.c         | 216 ++++++++++++++++++++++++++++----------
>  hw/misc/trace-events      |   4 +
>  6 files changed, 202 insertions(+), 67 deletions(-)
> 


