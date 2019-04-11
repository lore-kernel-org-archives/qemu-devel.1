Return-Path: <SRS0=7PPA=SN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BF2CC10F13
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 15:48:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0EB9620818
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 15:48:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xHnKzDwL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EB9620818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51057 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEbvr-0007zt-6m
	for qemu-devel@archiver.kernel.org; Thu, 11 Apr 2019 11:48:07 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49397)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hEbd9-0000Pd-De
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 11:28:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hEbd8-0000qs-Eg
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 11:28:47 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:34000)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hEbd8-0000pn-5e
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 11:28:46 -0400
Received: by mail-ot1-x342.google.com with SMTP id k21so5613919otf.1
	for <qemu-devel@nongnu.org>; Thu, 11 Apr 2019 08:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=XYYsrFHGswDJzCTPuKo+xM5aht6kUZN06zVl0UdRDwk=;
	b=xHnKzDwLKfAS0xebJ1gwBuFO2YYe0dy0LBxnGJhj45/cQOGNz6+Mt0iQ3TtLX1/XFQ
	KC0rdsTibG8xRzVipQpQmZz+BMvCJ5uqW8j2YYSQjk8VOIJztv3b1OtlvAAzY6qWbf1o
	YWnwjM6XpQaVX4KNkMlG6WMH+4Ko/NFczCQKfiL+l8+6ONwlZaEMcWW0nVMlfQM5fiTq
	Ufh7P4qq8JkaB+iP6sP+KpoymmPScHnJxzqaJR1llfCDs0HYcAFiqwiiqRUSEtxaAEcs
	0EA80P1lmH+khvNdPIoODOTxmNy5QxlL8SC7dD3jOBnvkPrAysbood4Ewmg9q6OCDyAj
	HSBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=XYYsrFHGswDJzCTPuKo+xM5aht6kUZN06zVl0UdRDwk=;
	b=ErhEfkoFe22pq4eQzr5cgdCfnkWE1v7aNUFJmePFIJY3/wx7ZuwdytGg/6EgiOR5dS
	JF141Lu93S40L7SxzZbF9hKKAmRtWaIgsmn0TDGmhhhTk5x34ECZTIoAVQg+Yhbnm6CV
	lIYLNXFLje7YieWtAggcHypyB17Fxm6Dcp/SqvIDZ4MME6mXvieiyCSXXta3gZdCQkB8
	yFKEzbewxVVsZHWe3hd5NVECvPXf6PZH9zDi2nadecz6qM5WMMHV00l+j0JR/8EBJqNB
	0qzRB9kBumn5KkQ3e08LAy7CkVblnrpad+AUSwbqMAUpQllT7Ru88wzcvNPC9g+6hKuN
	C8Gw==
X-Gm-Message-State: APjAAAXXiUsMth7SHd68VxVLsj70NhllsSwA39Vx8cm3Bj2+BhVkfwKP
	vgoe5zYc2ihm9YuApQkXHWSSQV2/YG+r8bz29vdDkw==
X-Google-Smtp-Source: APXvYqz/toKaGMbhtZrV6VwvL+ldYydbtioztAl1A0EAN12foMFvWOZN4yUIYljNDiVNVDcT0ALXcqvuQ85GIkkfrIM=
X-Received: by 2002:a05:6830:1cb:: with SMTP id
	r11mr27768250ota.302.1554996525415; 
	Thu, 11 Apr 2019 08:28:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190328062222.8409-1-joel@jms.id.au>
	<20190328062222.8409-3-joel@jms.id.au>
In-Reply-To: <20190328062222.8409-3-joel@jms.id.au>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 11 Apr 2019 16:28:34 +0100
Message-ID:
 <CAFEAcA9G9Xrt5nDRJrSCC1SdeR987YzK+etRLTSyokLE+yyJSw@mail.gmail.com>
To: Joel Stanley <joel@jms.id.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::342
Subject: Re: [Qemu-devel] [PATCH 2/2] hw/arm/aspeed: Add RTC to SoC
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
Cc: Andrew Jeffery <andrew@aj.id.au>, qemu-arm <qemu-arm@nongnu.org>,
	=?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
	QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190411152834._ZNHagyD_62yB3XTsZY5P7ooo1uKQqtfHAg0UFonji0@z>

On Thu, 28 Mar 2019 at 06:22, Joel Stanley <joel@jms.id.au> wrote:
>
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> ---
>  hw/arm/aspeed_soc.c         | 15 +++++++++++++++
>  include/hw/arm/aspeed_soc.h |  2 ++
>  2 files changed, 17 insertions(+)
>
> diff --git a/hw/arm/aspeed_soc.c b/hw/arm/aspeed_soc.c
> index a27233d4876b..628ec633c91a 100644
> --- a/hw/arm/aspeed_soc.c
> +++ b/hw/arm/aspeed_soc.c
> @@ -32,6 +32,7 @@
>  #define ASPEED_SOC_SDMC_BASE        0x1E6E0000
>  #define ASPEED_SOC_SCU_BASE         0x1E6E2000
>  #define ASPEED_SOC_SRAM_BASE        0x1E720000
> +#define ASPEED_SOC_RTC_BASE         0x1E781000
>  #define ASPEED_SOC_TIMER_BASE       0x1E782000
>  #define ASPEED_SOC_WDT_BASE         0x1E785000
>  #define ASPEED_SOC_I2C_BASE         0x1E78A000
> @@ -135,6 +136,10 @@ static void aspeed_soc_init(Object *obj)
>      object_property_add_child(obj, "i2c", OBJECT(&s->i2c), NULL);
>      qdev_set_parent_bus(DEVICE(&s->i2c), sysbus_get_default());
>
> +    object_initialize(&s->rtc, sizeof(s->rtc), TYPE_ASPEED_RTC);
> +    object_property_add_child(obj, "rtc", OBJECT(&s->rtc), NULL);
> +    qdev_set_parent_bus(DEVICE(&s->rtc), sysbus_get_default());

These three lines should be written
       sysbus_init_child_obj(obj, "rtc", &s->rtc, sizeof(s->rtc),
                             TYPE_ASPEED_RTC);

which is both shorter and also avoids leaking a reference to
the child object.

(We should also at some point fix the existing uses of this
pattern in this file.)


thanks
-- PMM

