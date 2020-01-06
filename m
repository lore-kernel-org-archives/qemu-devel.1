Return-Path: <SRS0=kvq2=23=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56839C33C9B
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 16:57:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2341820848
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 16:57:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DZsECNW6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2341820848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54972 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioVhG-0000bs-9h
	for qemu-devel@archiver.kernel.org; Mon, 06 Jan 2020 11:57:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34866)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1ioVgc-0008Un-OO
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 11:57:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1ioVga-00075x-Js
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 11:57:01 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:45613
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1ioVga-00074g-4g
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 11:57:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578329819;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=02TUdWYuGZFoP948H3QA+6CQ6nzlskfpSUT1h3iutTA=;
 b=DZsECNW6i411VwnE9IJT0Qd5jgV64noYDfg1IVmbK72chfkgxhuuZeFUYoZaaCSuKiO/VN
 zoQcH1bEbZHH/vobxUEJHzrozxyW4+3Ybc1hYDvdhJoJdEqkuVkMxjxXTkNKhKlwWFVsRj
 WNNmBaU+nQ6lxCUIDDxgZT8UNt+iplI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-320-NwXBIvPPM9KVPYO7qywHXw-1; Mon, 06 Jan 2020 11:56:58 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 53ED71005502;
 Mon,  6 Jan 2020 16:56:56 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0DB2C10840F1;
 Mon,  6 Jan 2020 16:56:51 +0000 (UTC)
Date: Mon, 6 Jan 2020 17:56:50 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Alistair Francis <alistair@alistair23.me>
Subject: Re: [PATCH v7 4/4] hw/arm: Add the Netduino Plus 2
Message-ID: <20200106175650.0ddc9bf2@redhat.com>
In-Reply-To: <dad8d8d47f7625913e35e27a1c00f603a6b08f9a.1576658572.git.alistair@alistair23.me>
References: <cover.1576658572.git.alistair@alistair23.me>
 <dad8d8d47f7625913e35e27a1c00f603a6b08f9a.1576658572.git.alistair@alistair23.me>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: NwXBIvPPM9KVPYO7qywHXw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 alistair23@gmail.com, Paolo Bonzini <pbonzini@redhat.com>, philmd@redhat.com,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 18 Dec 2019 21:22:55 -0800
Alistair Francis <alistair@alistair23.me> wrote:

> Signed-off-by: Alistair Francis <alistair@alistair23.me>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  MAINTAINERS            |  6 +++++
>  hw/arm/Makefile.objs   |  1 +
>  hw/arm/netduinoplus2.c | 52 ++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 59 insertions(+)
>  create mode 100644 hw/arm/netduinoplus2.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index bda53628a5..203ced66e0 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -829,6 +829,12 @@ M: Peter Maydell <peter.maydell@linaro.org>
>  S: Maintained
>  F: hw/arm/netduino2.c
>  
> +Netduino Plus 2
> +M: Alistair Francis <alistair@alistair23.me>
> +M: Peter Maydell <peter.maydell@linaro.org>
> +S: Maintained
> +F: hw/arm/netduinoplus2.c
> +
>  SmartFusion2
>  M: Subbaraya Sundeep <sundeep.lkml@gmail.com>
>  M: Peter Maydell <peter.maydell@linaro.org>
> diff --git a/hw/arm/Makefile.objs b/hw/arm/Makefile.objs
> index d9d54da7cf..336f6dd374 100644
> --- a/hw/arm/Makefile.objs
> +++ b/hw/arm/Makefile.objs
> @@ -11,6 +11,7 @@ obj-$(CONFIG_MAINSTONE) += mainstone.o
>  obj-$(CONFIG_MICROBIT) += microbit.o
>  obj-$(CONFIG_MUSICPAL) += musicpal.o
>  obj-$(CONFIG_NETDUINO2) += netduino2.o
> +obj-$(CONFIG_NETDUINOPLUS2) += netduinoplus2.o
>  obj-$(CONFIG_NSERIES) += nseries.o
>  obj-$(CONFIG_SX1) += omap_sx1.o
>  obj-$(CONFIG_CHEETAH) += palm.o
> diff --git a/hw/arm/netduinoplus2.c b/hw/arm/netduinoplus2.c
> new file mode 100644
> index 0000000000..e5e247edbe
> --- /dev/null
> +++ b/hw/arm/netduinoplus2.c
> @@ -0,0 +1,52 @@
> +/*
> + * Netduino Plus 2 Machine Model
> + *
> + * Copyright (c) 2014 Alistair Francis <alistair@alistair23.me>
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a copy
> + * of this software and associated documentation files (the "Software"), to deal
> + * in the Software without restriction, including without limitation the rights
> + * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
> + * copies of the Software, and to permit persons to whom the Software is
> + * furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
> + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
> + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
> + * THE SOFTWARE.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qapi/error.h"
> +#include "hw/boards.h"
> +#include "hw/qdev-properties.h"
> +#include "qemu/error-report.h"
> +#include "hw/arm/stm32f405_soc.h"
> +#include "hw/arm/boot.h"
> +
> +static void netduinoplus2_init(MachineState *machine)
> +{
> +    DeviceState *dev;
> +
> +    dev = qdev_create(NULL, TYPE_STM32F405_SOC);
> +    qdev_prop_set_string(dev, "cpu-type", ARM_CPU_TYPE_NAME("cortex-m4"));
> +    object_property_set_bool(OBJECT(dev), true, "realized", &error_fatal);
> +
> +    armv7m_load_kernel(ARM_CPU(first_cpu),
> +                       machine->kernel_filename,
> +                       FLASH_SIZE);
> +}

I wonder if we should make user provided '-m' a hard error
for boards that have fixed RAM size. And make '-m' or forthcoming
"-machine memdev" optin feature for boards that explicitly ask for it?

PS:
(I suspect that the most boards with fixed RAM size do not really
care about numa, mempath/prealloc and other features memdev provides)

> +
> +static void netduinoplus2_machine_init(MachineClass *mc)
> +{
> +    mc->desc = "Netduino Plus 2 Machine";
> +    mc->init = netduinoplus2_init;
> +}
> +
> +DEFINE_MACHINE("netduinoplus2", netduinoplus2_machine_init)


