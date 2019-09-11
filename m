Return-Path: <SRS0=l4AY=XG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D50E3C49ED6
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 12:55:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0D46206A1
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 12:55:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QeWcAnaV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0D46206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50628 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i829x-00078B-Lp
	for qemu-devel@archiver.kernel.org; Wed, 11 Sep 2019 08:55:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53919)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i828q-0006XU-Q3
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 08:54:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i828p-00034x-EB
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 08:54:36 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:37678)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i828p-00034V-7Q
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 08:54:35 -0400
Received: by mail-oi1-x241.google.com with SMTP id v7so14007747oib.4
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2019 05:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=pLHpMUClYJTmuSpnccdF1X5C+tQESlni33dS/sKHFIg=;
 b=QeWcAnaVh9RJKQML6U+lWncjQw11IUL957yuS7M4TQXyypGjREjH5JS9SlAqZRiLIt
 m6CUpbuFX39h6xwdSynSDrnqkCT1Qbzxz0ERTRVogULtjmOf2/ub9EO4EOPO625m+XjI
 AWrnk8YQXmnWnE3AM2tniWhJny841+PBMXJSqbINl0CA1qzUGX9h0NaT29Bws7zMNvvP
 z/3NoJPge9cgdOrildl/vVvaPYFkkGQ1+DhLP10SvyvKJ8M1Z8CujCdgK8eAR2uz44vW
 eZxm3czeYyI9T1aN1gU0zovfITwLDnwDZs356RgA/5vgwm7dk1xvAAJ1xdvnISucqsv3
 fX6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=pLHpMUClYJTmuSpnccdF1X5C+tQESlni33dS/sKHFIg=;
 b=FMSnpvOAmJeeBhr6se5dj5aMtt1YaHKn53calfRvAZI3ljIqCwMv/j5uqteU2HOy7r
 rEDO6B/RzSnx5xzUVygNoNrTbVCqXNufCKXJxIxf0ToY8bg/JMnMmfE5nhvoCjrSCgH0
 /qHtjn0nAq3PjS3tQ2U+jSHHQHgszc/1UH0HNzWLCteGs5z3TOZju/vvGR//Ho2QD+Fx
 GRdPC2fip/3ITdXb78yw6Fn1yTbS/pTd8maFdNj72IwK6a05ZBdb4jvyD4XA4W0nrw+q
 kpkHoF9emTIfZjCOSknurl0RI1LNkePcIyLb06EzOdy3a0UWz1Jyq/GuWBxwVigEhZVu
 pt5g==
X-Gm-Message-State: APjAAAUZ9w9aa7WfGQIk3NIRrlpgbdPS5ev8cRP8u4FmHMGMe9doOnNZ
 vwZXYpw6RjcL41tfSjC3ppuZ+UUpABpAGOTxYtlkvg==
X-Google-Smtp-Source: APXvYqx5tI12ZWgaMGozb6jL1ZEkkrrJnsmPmZ4KynDBfvcMnp3wZ0HOztt7NpupJtXvbUMubbMN5CQAg5sM3+KX47I=
X-Received: by 2002:aca:281a:: with SMTP id 26mr3910777oix.163.1568206474199; 
 Wed, 11 Sep 2019 05:54:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190904085629.13872-1-shameerali.kolothum.thodi@huawei.com>
 <20190904085629.13872-10-shameerali.kolothum.thodi@huawei.com>
In-Reply-To: <20190904085629.13872-10-shameerali.kolothum.thodi@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 11 Sep 2019 13:54:23 +0100
Message-ID: <CAFEAcA-0RKq_+wjuJKPUPp0E3=788WSMyBHGUctx2wYaDaWuFQ@mail.gmail.com>
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::241
Subject: Re: [Qemu-devel] [PATCH-for-4.2 v10 09/11] docs/specs: Add ACPI GED
 documentation
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
Cc: Samuel Ortiz <sameo@linux.intel.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Xu Wei <xuwei5@hisilicon.com>,
 Linuxarm <linuxarm@huawei.com>, Eric Auger <eric.auger@redhat.com>,
 qemu-arm <qemu-arm@nongnu.org>, Igor Mammedov <imammedo@redhat.com>,
 sebastien.boeuf@intel.com, Laszlo Ersek <lersek@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 4 Sep 2019 at 09:58, Shameer Kolothum
<shameerali.kolothum.thodi@huawei.com> wrote:
>
> Documents basic concepts of ACPI Generic Event device(GED)
> and interface between QEMU and the ACPI BIOS.
>
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> ---
>  docs/specs/acpi_hw_reduced_hotplug.txt | 60 ++++++++++++++++++++++++++
>  1 file changed, 60 insertions(+)
>  create mode 100644 docs/specs/acpi_hw_reduced_hotplug.txt

New documentation in docs/specs should be in .rst format
and listed in docs/specs/index.rst, please. That way
it gets built into the sphinx manual sets we're transitioning
to. The rst markup should hopefully not be too difficult to add.


Some minor typo/grammar fixes below:

> +GED allows HW reduced platforms to handle interrupts in ACPI ASL
> +statements. It follows a very similar approach like the _EVT method

"similar approach to the"

> +from GPIO events. All interrupts are listed in  _CRS and the handler
> +is written in _EVT method. However, Qemu implementation uses a single

"the QEMU implementation"

>+ interrupt for the GED device, relying on IO memory region to communicate

"on an IO memory region"

> +the type of device affected by the interrupt. This way, we can support
> +up to 32 events with a unique interrupt.

> +    [0x0-0x3] Event selector bit field(32 bit) set by Qemu.

Missing space before '('.
"QEMU" should be all-capitals.

thanks
-- PMM

