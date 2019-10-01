Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CB27C388F3
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 09:12:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6041F21920
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 09:12:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6041F21920
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39290 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFECl-0003KO-Hm
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 05:12:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33112)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iFEBU-0002JV-Tb
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 05:11:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iFEBS-0001iJ-Lo
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 05:11:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55602)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iFEBS-0001hM-DV
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 05:11:02 -0400
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 572DF4E83E
 for <qemu-devel@nongnu.org>; Tue,  1 Oct 2019 09:11:01 +0000 (UTC)
Received: by mail-wm1-f71.google.com with SMTP id 124so660597wmz.1
 for <qemu-devel@nongnu.org>; Tue, 01 Oct 2019 02:11:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=cNX6CzKY6UI6bxi8es/quSNCTr9n0cikcVRKiLTZ/9s=;
 b=KR6MxYC1br30erebH1Og3EOSv7/5w/+P1wU0hdW/NvaaCKEM1dTHxAJ9wWc+59GSDt
 nzCOoS65PZaDdA9xLM/wIojb9wX2m9PnhYADcDYT3Wflxvj7gH4AD0wMwJ0PXNXrTQSR
 n67NPgdN+Xkx6p5ODy/Z+016+YuUf7B58RvCA8AVHRpXksvtPyWk4gv1l639ozyK2uXk
 qtdkN7rRcqUv4lCoubT2jL2eBnAYvctHk5gGk3sGmLBQYit8EEFVHS6se6Czy/XtB1YO
 DGkrz3tGJxuUfGTvu/xrB5VN3lLH09ub8GQyUZehbPLveRAniZ3QKvjGuBwbRypsUvFg
 UTUg==
X-Gm-Message-State: APjAAAVTR7y/lX/a0VXwmSbRQ0qV59OfeW0ta65zKQm3lpb2Dxep/ERD
 QZMLUYugDbdWkmN8KTudnD3+K1jyQJySrR1R1b35+bPeMfDP2bF0CwUjMkBaI23OQ5iaXpKQXfa
 BimQdzmTvju0w/QI=
X-Received: by 2002:a5d:52c8:: with SMTP id r8mr17797161wrv.256.1569921059871; 
 Tue, 01 Oct 2019 02:10:59 -0700 (PDT)
X-Google-Smtp-Source: APXvYqw24miDcosAukjkV7esurXFYlolpTSpLZx9q9776KzJiyyJbDYzZvqYHe56uU9Pu+An8mrMvw==
X-Received: by 2002:a5d:52c8:: with SMTP id r8mr17797142wrv.256.1569921059691; 
 Tue, 01 Oct 2019 02:10:59 -0700 (PDT)
Received: from [192.168.1.35] (240.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.240])
 by smtp.gmail.com with ESMTPSA id u83sm3326270wme.0.2019.10.01.02.10.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Oct 2019 02:10:59 -0700 (PDT)
Subject: Re: [PATCH] hw/isa: Introduce a CONFIG_ISA_SUPERIO switch for
 isa-superio.c
To: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>
References: <20190930150436.18162-1-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <cecc59f4-d2b9-7b3b-b750-b86ac202da2c@redhat.com>
Date: Tue, 1 Oct 2019 11:10:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20190930150436.18162-1-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: qemu-trivial@nongnu.org, Aleksandar Rikalo <arikalo@wavecomp.com>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/30/19 5:04 PM, Thomas Huth wrote:
> Currently, isa-superio.c is always compiled as soon as CONFIG_ISA_BUS
> is enabled. But there are also machines that have an ISA BUS without
> any of the superio chips attached to it, so we should not compile
> isa-superio.c in case we only compile a QEMU for such a machine.
> Thus add a proper CONFIG_ISA_SUPERIO switch so that this file only gets
> compiled when we really, really need it.
>=20
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> ---
>   hw/isa/Kconfig       | 10 +++++++---
>   hw/isa/Makefile.objs |  2 +-
>   hw/mips/Kconfig      |  1 +
>   3 files changed, 9 insertions(+), 4 deletions(-)
>=20
> diff --git a/hw/isa/Kconfig b/hw/isa/Kconfig
> index 6db0d7970c..98a289957e 100644
> --- a/hw/isa/Kconfig
> +++ b/hw/isa/Kconfig
> @@ -13,9 +13,13 @@ config I82378
>       select MC146818RTC
>       select PCSPK
>  =20
> -config PC87312
> +config ISA_SUPERIO
>       bool
>       select ISA_BUS
> +
> +config PC87312
> +    bool
> +    select ISA_SUPERIO
>       select I8259
>       select I8254
>       select I8257
> @@ -34,14 +38,14 @@ config PIIX4
>  =20
>   config VT82C686
>       bool
> -    select ISA_BUS
> +    select ISA_SUPERIO
>       select ACPI_SMBUS
>       select SERIAL_ISA
>       select FDC
>  =20
>   config SMC37C669
>       bool
> -    select ISA_BUS
> +    select ISA_SUPERIO
>       select SERIAL_ISA
>       select PARALLEL
>       select FDC
> diff --git a/hw/isa/Makefile.objs b/hw/isa/Makefile.objs
> index 9e106df186..ff97485504 100644
> --- a/hw/isa/Makefile.objs
> +++ b/hw/isa/Makefile.objs
> @@ -1,5 +1,5 @@
>   common-obj-$(CONFIG_ISA_BUS) +=3D isa-bus.o
> -common-obj-$(CONFIG_ISA_BUS) +=3D isa-superio.o
> +common-obj-$(CONFIG_ISA_SUPERIO) +=3D isa-superio.o
>   common-obj-$(CONFIG_APM) +=3D apm.o
>   common-obj-$(CONFIG_I82378) +=3D i82378.o
>   common-obj-$(CONFIG_PC87312) +=3D pc87312.o
> diff --git a/hw/mips/Kconfig b/hw/mips/Kconfig
> index 62aa01b29e..2c2adbc42a 100644
> --- a/hw/mips/Kconfig
> +++ b/hw/mips/Kconfig
> @@ -13,6 +13,7 @@ config R4K
>  =20
>   config MALTA
>       bool
> +    select ISA_SUPERIO
>  =20
>   config MIPSSIM
>       bool
>=20

