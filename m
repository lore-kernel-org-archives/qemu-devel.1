Return-Path: <SRS0=LbB6=TD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56BFFC43219
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 15:08:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C61F205ED
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 15:08:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C61F205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:41960 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMZnu-0005xe-DM
	for qemu-devel@archiver.kernel.org; Fri, 03 May 2019 11:08:50 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56004)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hMZml-0005JR-Et
	for qemu-devel@nongnu.org; Fri, 03 May 2019 11:07:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hMZmk-0004BH-3Q
	for qemu-devel@nongnu.org; Fri, 03 May 2019 11:07:39 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51161)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hMZmj-0004Aa-Tn
	for qemu-devel@nongnu.org; Fri, 03 May 2019 11:07:38 -0400
Received: by mail-wm1-f68.google.com with SMTP id p21so7503507wmc.0
	for <qemu-devel@nongnu.org>; Fri, 03 May 2019 08:07:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=c/Bq/wmFbhXlgMLagBN9uIHBBitvjf/WmQ+GZPVo6RY=;
	b=OMNxUxJ4iC+zVXqz5zvtiYwmXu2yNrjb65dr3PudJRx4x9P8ujT5QqZFz4qIXOBrbN
	QzuvKWWhYiZptjrnT1uKmQm5sjD782YJmIuudJwQV4kOHO2K7Ad1DU6QCDQqjnlrVfME
	cCpwTU/9662qDOQ454/nqFefxQNs6h4CZ+h4rGfS+e5g2O5Zzec5IjQHWybtodkrifDc
	Y5zWf2n4Z15zS3PGC4wML9tuy5FSSaW0XABAMggAHzFssqK9rFJU5rXfsTs0GNDOlLHU
	FtK3gO5/TiemSbyGjyHA3yX3NgFgYIS7bp9MiQxHcu6aamvQm0tYZ6k4hLWojFqUPUYW
	Kc1w==
X-Gm-Message-State: APjAAAWPkL+R+8WAt9ulpKPRfanVtu2h9VhMN5BmG9m4dJ8IoTHdfIGm
	t9ew4oetxFOmCfJ0/5Axv6W46/52GfM=
X-Google-Smtp-Source: APXvYqyP0PXA42L5LTlBWJQ394n2G3PP5lftfQgkEDlVDBPvU3uK9h1whb3Va0ON+rr0blQcdL5Isw==
X-Received: by 2002:a1c:9d17:: with SMTP id g23mr2558100wme.100.1556896056610; 
	Fri, 03 May 2019 08:07:36 -0700 (PDT)
Received: from [192.168.1.33] (193.red-88-21-103.staticip.rima-tde.net.
	[88.21.103.193])
	by smtp.gmail.com with ESMTPSA id y6sm4397125wra.24.2019.05.03.08.07.35
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Fri, 03 May 2019 08:07:36 -0700 (PDT)
To: Joel Stanley <joel@jms.id.au>, =?UTF-8?Q?C=c3=a9dric_Le_Goater?=
	<clg@kaod.org>, Peter Maydell <peter.maydell@linaro.org>
References: <20190503022958.1394-1-joel@jms.id.au>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <1f32879b-63ac-5cf2-2f1e-6bcc4da99220@redhat.com>
Date: Fri, 3 May 2019 17:07:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190503022958.1394-1-joel@jms.id.au>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.68
Subject: Re: [Qemu-devel] [PATCH v2] arm: aspeed: Set SDRAM size
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Andrew Jeffery <andrew@aj.id.au>, qemu-arm@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190503150735.tJ4OOGwUNEvVa0eWode7moa6iqZU2LdBxfC9Ec03AFU@z>

On 5/3/19 4:29 AM, Joel Stanley wrote:
> We currently use Qemu's default of 128MB. As we know how much ram each
> machine ships with, make it easier on users by setting a default.
> 
> It can still be overridden with -m on the command line.
> 
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

I did review this patch:
https://lists.gnu.org/archive/html/qemu-devel/2019-05/msg00109.html

So:
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
> v2:
>  - Fix 'if' style issue. Thanks patchew
>  - Use units.h defines
> 
>  hw/arm/aspeed.c         | 8 ++++++++
>  include/hw/arm/aspeed.h | 1 +
>  2 files changed, 9 insertions(+)
> 
> diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
> index 1c23ebd99252..29d225ed1405 100644
> --- a/hw/arm/aspeed.c
> +++ b/hw/arm/aspeed.c
> @@ -25,6 +25,7 @@
>  #include "sysemu/block-backend.h"
>  #include "hw/loader.h"
>  #include "qemu/error-report.h"
> +#include "qemu/units.h"
>  
>  static struct arm_boot_info aspeed_board_binfo = {
>      .board_id = -1, /* device-tree-only board */
> @@ -331,6 +332,9 @@ static void aspeed_machine_class_init(ObjectClass *oc, void *data)
>      mc->no_floppy = 1;
>      mc->no_cdrom = 1;
>      mc->no_parallel = 1;
> +    if (board->ram) {
> +        mc->default_ram_size = board->ram;
> +    }
>      amc->board = board;
>  }
>  
> @@ -352,6 +356,7 @@ static const AspeedBoardConfig aspeed_boards[] = {
>          .spi_model = "mx25l25635e",
>          .num_cs    = 1,
>          .i2c_init  = palmetto_bmc_i2c_init,
> +        .ram       = 256 * MiB,
>      }, {
>          .name      = MACHINE_TYPE_NAME("ast2500-evb"),
>          .desc      = "Aspeed AST2500 EVB (ARM1176)",
> @@ -361,6 +366,7 @@ static const AspeedBoardConfig aspeed_boards[] = {
>          .spi_model = "mx25l25635e",
>          .num_cs    = 1,
>          .i2c_init  = ast2500_evb_i2c_init,
> +        .ram       = 512 * MiB,
>      }, {
>          .name      = MACHINE_TYPE_NAME("romulus-bmc"),
>          .desc      = "OpenPOWER Romulus BMC (ARM1176)",
> @@ -370,6 +376,7 @@ static const AspeedBoardConfig aspeed_boards[] = {
>          .spi_model = "mx66l1g45g",
>          .num_cs    = 2,
>          .i2c_init  = romulus_bmc_i2c_init,
> +        .ram       = 512 * MiB,
>      }, {
>          .name      = MACHINE_TYPE_NAME("witherspoon-bmc"),
>          .desc      = "OpenPOWER Witherspoon BMC (ARM1176)",
> @@ -379,6 +386,7 @@ static const AspeedBoardConfig aspeed_boards[] = {
>          .spi_model = "mx66l1g45g",
>          .num_cs    = 2,
>          .i2c_init  = witherspoon_bmc_i2c_init,
> +        .ram       = 512 * MiB,
>      },
>  };
>  
> diff --git a/include/hw/arm/aspeed.h b/include/hw/arm/aspeed.h
> index 325c091d09e4..02073a6b4d61 100644
> --- a/include/hw/arm/aspeed.h
> +++ b/include/hw/arm/aspeed.h
> @@ -22,6 +22,7 @@ typedef struct AspeedBoardConfig {
>      const char *spi_model;
>      uint32_t num_cs;
>      void (*i2c_init)(AspeedBoardState *bmc);
> +    uint32_t ram;
>  } AspeedBoardConfig;
>  
>  #define TYPE_ASPEED_MACHINE       MACHINE_TYPE_NAME("aspeed")
> 

