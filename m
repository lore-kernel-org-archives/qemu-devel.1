Return-Path: <SRS0=KBml=XB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73729C43331
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 10:05:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41DBC2082C
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 10:05:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nG6RWgE/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41DBC2082C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54054 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i6B7T-000680-FQ
	for qemu-devel@archiver.kernel.org; Fri, 06 Sep 2019 06:05:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43262)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i6B6m-0005Tl-Tz
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 06:04:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i6B6l-00012m-O8
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 06:04:48 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:33448)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i6B6l-000124-If
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 06:04:47 -0400
Received: by mail-oi1-x242.google.com with SMTP id e12so4201490oie.0
 for <qemu-devel@nongnu.org>; Fri, 06 Sep 2019 03:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=qi9gD9gku4qKxIxAaWTeVq4DOn1k/s0z8YyfHHT7VhE=;
 b=nG6RWgE/FYUhvLo5x9Dd3UZIWNmGNrs+wEH/gDm/4uMl3FsnSmZOylW8jw/Env5gk3
 lHC+LTyMu3xRZuoInvEdeNA72OuyzR9yJrGI41JDoOuKuDVLBNxQIaF0Q1NMCe9IulD0
 fVRjq5dr0cn8pVhSqPrRUyvurjwQvRrxruaNBDY3xhkkfeWga1gLW1LLyW7kG9CHJYyS
 VwKuPQZA8cTj3dEeauthB5B+gqwiqX6U38wBIVa+oNncHIAgs8CMPnUGKVz3UaHOBloB
 NLScG1xrgc/D8W0ZqDrcDN84HdufsKzCnWIeMCL6PVsxWE6dZHSKp16AWVM5vgM+uWMT
 5h/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=qi9gD9gku4qKxIxAaWTeVq4DOn1k/s0z8YyfHHT7VhE=;
 b=KANgVkm5YYMxtrKkhIRjrUSvf/cyDL6tK5ZgXJAvlS9dT07EcHVbT/mfpDuS29S+09
 hcZKRQ0OqzbrNi84vodVWf27YfqYw/SrQy7rCLcDSwa9IS5LTmxIjyCgbcIXnjMByYU8
 e7g3pmXd6aNCyJd+eZPIp8DR3xIFZ7f3FOVO9PnQ+TTyE1hXsy/qzrxdBjkqg9agz9a+
 Lo0epQh7H02rIeSFadfe4m6VaA0UyRBG+a9gFobR7M8DolafZsuLqUEMBIVx+Lu9Ol4d
 EaJWwyxp3tGfw034/Xlg1ZoMWrnDOID/huxyUgMyOb8VP+cCO43QLbZLOXK3GRqKaC1R
 2NIA==
X-Gm-Message-State: APjAAAV1/0Gz7r2HHCCs1NwSQ5Mmw/XZJ4I6kJkGBkcuBrCjBYh1F5/E
 AAXEsWWRwS++gUDz9NgmTNPvW5xIex02Qda3oQ+o6Q==
X-Google-Smtp-Source: APXvYqwRRPZQChF7Ygn5qHx/YmxcEK25swlM8HG7t+2ttx1ZAaa0yE5bNXoBDVN9zyE71Jp3lMFCaDcpMAPJj4szpXA=
X-Received: by 2002:aca:50d8:: with SMTP id e207mr5962101oib.48.1567764286680; 
 Fri, 06 Sep 2019 03:04:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190823143249.8096-1-philmd@redhat.com>
In-Reply-To: <20190823143249.8096-1-philmd@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Sep 2019 11:04:35 +0100
Message-ID: <CAFEAcA8DVw8gei9MLbkTExXaSRY5EnSDGXkbCZ1i+mBBR6_6Ng@mail.gmail.com>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::242
Subject: Re: [Qemu-devel] [PATCH v2 0/6] hw/arm: Use ARM_CPU_TYPE_NAME() and
 object_initialize_child()
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
Cc: Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Andrey Smirnov <andrew.smirnov@gmail.com>, Jason Wang <jasowang@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Beniamino Galvani <b.galvani@gmail.com>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>, qemu-arm <qemu-arm@nongnu.org>,
 Peter Chubb <peter.chubb@nicta.com.au>,
 Antony Pavlov <antonynpavlov@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 23 Aug 2019 at 15:33, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.co=
m> wrote:
>
> First we use ARM_CPU_TYPE_NAME() when we should.
>
> Then is follow up of [1]:
>
>   This series looks at Eduardo suggestions from [2]
>   and Thomas commit aff39be0ed97 to replace various
>   object_initialize + qdev_set_parent_bus calls by
>   sysbus_init_child_obj().
>
> Finally, some devices are declared orphean while they have a parent,
> let them be together again.
>
> Since v1 [3]:
> - addressed Peter Maydell review comments
>
> [1] https://lists.gnu.org/archive/html/qemu-devel/2019-05/msg01492.html
> [2] https://patchwork.ozlabs.org/patch/943333/#1953608
> [3] https://lists.gnu.org/archive/html/qemu-devel/2019-07/msg00135.html
>
> Philippe Mathieu-Daud=C3=A9 (6):
>   hw/arm: Use ARM_CPU_TYPE_NAME() macro when appropriate
>   hw/arm: Use object_initialize_child for correct reference counting
>   hw/arm: Use sysbus_init_child_obj for correct reference counting
>   hw/arm/fsl-imx: Add the cpu as child of the SoC object
>   hw/dma/xilinx_axi: Use object_initialize_child for correct ref.
>     counting
>   hw/net/xilinx_axi: Use object_initialize_child for correct ref.
>     counting

This series is now in master (but I forgot to mention that I'd
applied it to target-arm.next when I did that).

thanks
-- PMM

