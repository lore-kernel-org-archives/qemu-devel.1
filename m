Return-Path: <SRS0=nlPZ=TC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D73E7C43219
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 13:25:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F74B2075E
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 13:25:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bNQGq9QS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F74B2075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51152 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMBij-0001Q2-TY
	for qemu-devel@archiver.kernel.org; Thu, 02 May 2019 09:25:53 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55854)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1hMBhq-0000m6-2C
	for qemu-devel@nongnu.org; Thu, 02 May 2019 09:25:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1hMBhe-0008Ly-Q5
	for qemu-devel@nongnu.org; Thu, 02 May 2019 09:24:58 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:45090)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tcminyard@gmail.com>) id 1hMBhe-0008Lm-LA
	for qemu-devel@nongnu.org; Thu, 02 May 2019 09:24:46 -0400
Received: by mail-ot1-x341.google.com with SMTP id a10so1992072otl.12
	for <qemu-devel@nongnu.org>; Thu, 02 May 2019 06:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=sender:date:from:to:cc:subject:message-id:reply-to:references
	:mime-version:content-disposition:content-transfer-encoding
	:in-reply-to:user-agent;
	bh=+ambnEVN/ny4DJEs50btTtF4CLCAsUiPmDX0DQHB2mE=;
	b=bNQGq9QS5dqo/3S3gv3Nzx2fhutZC6eIYd3L642Qseggvd21Jril1JMa+76YBDUhcu
	hcJPo+Zlej8+6BOVPbFgJ9i92QtOX1FIaa810t4UeyMgXN3e21yvXyR86ZMNlZGgmZkk
	d4yDjmCPZnBVleWQ0hCw4DaJUmNngjnGvmgtSQnB7vJcXrZXwMOnFrLxGXM+OPe7tERQ
	5zn2BPTm1SS0GgXjM5wWugYcyfFiDX+Rkf0NBb8T1jkb9UF/RC0cUVfiNiuI/oH25bsp
	0vhcntr03MNQb4PUq04fSZhs+unhOmhQhAOO5ZmNKEuzoioiQ+fMYM70T1hix4gvTFiH
	GBUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
	:reply-to:references:mime-version:content-disposition
	:content-transfer-encoding:in-reply-to:user-agent;
	bh=+ambnEVN/ny4DJEs50btTtF4CLCAsUiPmDX0DQHB2mE=;
	b=qXJPSKt1x4nziqj2TSZwZUBFNJc/KAIkp4R9WAT7KWJXgZmyFO4v1lF9v6JfCriO6q
	opRUBvAF4573I1cgtjqBi1WVfXUbCDOcB8wJ55BOHBIEsa3f8lCfrD6/RYWOaAPbApDQ
	NVtIbcUiWmtDQuYChxW5nlCHhh+eCKaiPvz2m2LnYrrxn2Bj2e0sg+7av6hBlEXsknWk
	PdtuKCwIT/BL25s1AlEoYYOoFvFBm628avVGKI/ZYYfIJhqWvf9kVri5GzRQ7u7uqA6b
	WMsw9UZr6QM0fpWps/9Eu2lJM2GheiovCl5nIGwKD+zvbabpFX6GMg8tAjWH5KEB6pu5
	P0oQ==
X-Gm-Message-State: APjAAAU1K5tcktk75DWHpXQbUYdm1exEQ/YJxkfvtsW+OGLF2ay6pcyM
	cUe5mMdI9++PggMr1rwrRw==
X-Google-Smtp-Source: APXvYqyrAcKMYcNpu3JSazGdvP+rv9HfwrBLJrfOPpkx51unym0Z47t9LKHw7UnvwiUkt77LJa08KA==
X-Received: by 2002:a05:6830:1115:: with SMTP id
	w21mr2507070otq.179.1556803483820; 
	Thu, 02 May 2019 06:24:43 -0700 (PDT)
Received: from serve.minyard.net ([47.184.134.43])
	by smtp.gmail.com with ESMTPSA id
	k16sm3796153oic.43.2019.05.02.06.24.43
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 02 May 2019 06:24:43 -0700 (PDT)
Received: from minyard.net (unknown [IPv6:2001:470:b8f6:1b:d5e:aa5a:44d8:6907])
	by serve.minyard.net (Postfix) with ESMTPSA id 9B83A1818F3;
	Thu,  2 May 2019 13:24:42 +0000 (UTC)
Date: Thu, 2 May 2019 08:24:37 -0500
From: Corey Minyard <minyard@acm.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Message-ID: <20190502132437.GI6623@minyard.net>
References: <20190428064731.29913-1-philmd@redhat.com>
	<20190428064731.29913-2-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190428064731.29913-2-philmd@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::341
Subject: Re: [Qemu-devel] [PATCH v2 1/6] hw/acpi: Move the IPMI stub to the
 stubs/ directory
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
Reply-To: minyard@acm.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Aleksandar Rikalo <arikalo@wavecomp.com>, qemu-devel@nongnu.org,
	Aleksandar Markovic <amarkovic@wavecomp.com>,
	Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
	Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190502132437.Dps6MlXkVcua3l88wOz2WmcAVwWUQMp-CUUSGm6SUZE@z>

On Sun, Apr 28, 2019 at 08:47:26AM +0200, Philippe Mathieu-Daudé wrote:
> Move the IPMI stub file to the stubs/ directory to simplify the
> hw/acpi Makefile.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>

I'm not sure of the overall view of this, but this is ok from an
IPMI point of view in my view.

Acked-by: Corey Minyard <cminyard@mvista.com>

> ---
>  MAINTAINERS                         | 1 +
>  hw/acpi/Makefile.objs               | 3 +--
>  stubs/Makefile.objs                 | 1 +
>  hw/acpi/ipmi-stub.c => stubs/ipmi.c | 0
>  4 files changed, 3 insertions(+), 2 deletions(-)
>  rename hw/acpi/ipmi-stub.c => stubs/ipmi.c (100%)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 23db6f8408a..e1681eca5cb 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1309,6 +1309,7 @@ S: Maintained
>  F: include/hw/ipmi/*
>  F: hw/ipmi/*
>  F: hw/smbios/smbios_type_38.c
> +F: stubs/ipmi.c
>  F: tests/ipmi*
>  T: git https://github.com/cminyard/qemu.git master-ipmi-rebase
>  
> diff --git a/hw/acpi/Makefile.objs b/hw/acpi/Makefile.objs
> index 2d46e3789ae..4e302feb885 100644
> --- a/hw/acpi/Makefile.objs
> +++ b/hw/acpi/Makefile.objs
> @@ -14,8 +14,7 @@ common-obj-y += aml-build.o
>  common-obj-$(CONFIG_TPM) += tpm.o
>  
>  common-obj-$(CONFIG_IPMI) += ipmi.o
> -common-obj-$(call lnot,$(CONFIG_IPMI)) += ipmi-stub.o
>  else
>  common-obj-y += acpi-stub.o
>  endif
> -common-obj-$(CONFIG_ALL) += acpi-stub.o ipmi-stub.o
> +common-obj-$(CONFIG_ALL) += acpi-stub.o
> diff --git a/stubs/Makefile.objs b/stubs/Makefile.objs
> index 269dfa58326..36bb9ff0b1d 100644
> --- a/stubs/Makefile.objs
> +++ b/stubs/Makefile.objs
> @@ -9,6 +9,7 @@ stub-obj-y += error-printf.o
>  stub-obj-y += fdset.o
>  stub-obj-y += gdbstub.o
>  stub-obj-y += get-vm-name.o
> +stub-obj-y += ipmi.o
>  stub-obj-y += iothread.o
>  stub-obj-y += iothread-lock.o
>  stub-obj-y += is-daemonized.o
> diff --git a/hw/acpi/ipmi-stub.c b/stubs/ipmi.c
> similarity index 100%
> rename from hw/acpi/ipmi-stub.c
> rename to stubs/ipmi.c
> -- 
> 2.20.1
> 

