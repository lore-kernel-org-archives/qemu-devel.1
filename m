Return-Path: <SRS0=aVj3=TB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 500AFC43219
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2019 15:29:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CFA2208C3
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2019 15:29:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CFA2208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:32948 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLrAg-0006nY-9o
	for qemu-devel@archiver.kernel.org; Wed, 01 May 2019 11:29:22 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34274)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hLr9b-0006NM-Gm
	for qemu-devel@nongnu.org; Wed, 01 May 2019 11:28:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hLr9Y-0002lU-Er
	for qemu-devel@nongnu.org; Wed, 01 May 2019 11:28:15 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40916)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hLr9Y-0002kv-9P
	for qemu-devel@nongnu.org; Wed, 01 May 2019 11:28:12 -0400
Received: by mail-wr1-f67.google.com with SMTP id h4so24970716wre.7
	for <qemu-devel@nongnu.org>; Wed, 01 May 2019 08:28:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=vYVmVYy7BldxU4o4Q8j6mO0Qc0R9/TpLi5L2SjUSFR0=;
	b=G/GP/ctrMgaYGcfM446YJuAKy35BB12/TVaP6v4YRAKIJZgITKQDyjpCuEkqt96qdP
	kbkkmxgeN7W3207+CWGL9tTW9i7hqGy8uQ2PT8uOPqi97TkKVKMScsOsUC3SzrCiiQ0U
	EgjhcQqfrlM2V9IxROYCbLwqXUn6+i1Hpip0lXWq6butdvkPOmncsvUErfP9cujAEQ/X
	PP61+2pF/HKpMIi2+3bzu+pCS3rxsG6eb94alyxXi2E0xOtpFJK849+fwLeDCkIMVw7R
	JCzq/f/OwIC44osEgO2uDrw5iWoJaqO8kN1S7h8rPjHYPx2gjFLqokwZLb7XryGcxMr6
	AqZg==
X-Gm-Message-State: APjAAAUC7mW1GjxNTCaDBqNW4Mk3L/RrCI1z45ON9dGwnZY2NBLiXNIo
	YplmtmvCXieTgH6DeksPbJl6TVLV/aU=
X-Google-Smtp-Source: APXvYqz2U5x25AkTwQMd3aGnniv+QRGADLAVI25emOU7yGjVU3VvSj1omRXrBV4WE2lSW1IuLWI9Jg==
X-Received: by 2002:adf:a318:: with SMTP id c24mr2879129wrb.138.1556724490988; 
	Wed, 01 May 2019 08:28:10 -0700 (PDT)
Received: from [192.168.1.37] (193.red-88-21-103.staticip.rima-tde.net.
	[88.21.103.193])
	by smtp.gmail.com with ESMTPSA id f6sm2011856wmh.13.2019.05.01.08.28.09
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Wed, 01 May 2019 08:28:10 -0700 (PDT)
To: Joel Stanley <joel@jms.id.au>, Peter Maydell <peter.maydell@linaro.org>,
	=?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
References: <20190501061827.23080-1-joel@jms.id.au>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <2f92e14a-28f7-3c03-8fb8-ca2a0c407cc0@redhat.com>
Date: Wed, 1 May 2019 17:28:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190501061827.23080-1-joel@jms.id.au>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.67
Subject: Re: [Qemu-devel] [PATCH] arm: aspeed: Set SDRAM size
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
	qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190501152809.XMvvTizTB9ZfRfyuJ-O6LP0RIwkf9vIkki3wGWpEcfE@z>

On 5/1/19 8:18 AM, Joel Stanley wrote:
> We currently use Qemu's default of 128MB. As we know how much ram each
> machine ships with, make it easier on users by setting a default.
> 
> It can still be overridden with -m on the command line.
> 
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
>  hw/arm/aspeed.c         | 6 ++++++
>  include/hw/arm/aspeed.h | 1 +
>  2 files changed, 7 insertions(+)
> 
> diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
> index 1c23ebd99252..3f3d4162b3c5 100644
> --- a/hw/arm/aspeed.c
> +++ b/hw/arm/aspeed.c
> @@ -331,6 +331,8 @@ static void aspeed_machine_class_init(ObjectClass *oc, void *data)
>      mc->no_floppy = 1;
>      mc->no_cdrom = 1;
>      mc->no_parallel = 1;
> +    if (board->ram)
> +        mc->default_ram_size = board->ram;
>      amc->board = board;
>  }
>  
> @@ -352,6 +354,7 @@ static const AspeedBoardConfig aspeed_boards[] = {
>          .spi_model = "mx25l25635e",
>          .num_cs    = 1,
>          .i2c_init  = palmetto_bmc_i2c_init,
> +        .ram       = 256 << 20,
>      }, {
>          .name      = MACHINE_TYPE_NAME("ast2500-evb"),
>          .desc      = "Aspeed AST2500 EVB (ARM1176)",
> @@ -361,6 +364,7 @@ static const AspeedBoardConfig aspeed_boards[] = {
>          .spi_model = "mx25l25635e",
>          .num_cs    = 1,
>          .i2c_init  = ast2500_evb_i2c_init,
> +        .ram       = 512 << 20,
>      }, {
>          .name      = MACHINE_TYPE_NAME("romulus-bmc"),
>          .desc      = "OpenPOWER Romulus BMC (ARM1176)",
> @@ -370,6 +374,7 @@ static const AspeedBoardConfig aspeed_boards[] = {
>          .spi_model = "mx66l1g45g",
>          .num_cs    = 2,
>          .i2c_init  = romulus_bmc_i2c_init,
> +        .ram       = 512 << 20,
>      }, {
>          .name      = MACHINE_TYPE_NAME("witherspoon-bmc"),
>          .desc      = "OpenPOWER Witherspoon BMC (ARM1176)",
> @@ -379,6 +384,7 @@ static const AspeedBoardConfig aspeed_boards[] = {
>          .spi_model = "mx66l1g45g",
>          .num_cs    = 2,
>          .i2c_init  = witherspoon_bmc_i2c_init,
> +        .ram       = 512 << 20,
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

default_ram_size is of type 'const ram_addr_t', can you use the same
type here?

>  } AspeedBoardConfig;
>  
>  #define TYPE_ASPEED_MACHINE       MACHINE_TYPE_NAME("aspeed")
> 

Using macros from "qemu/units.h" as suggested by Richard:
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

