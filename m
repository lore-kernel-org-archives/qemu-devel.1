Return-Path: <SRS0=YAkC=B2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F5EAC433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Aug 2020 16:28:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26E75206C0
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Aug 2020 16:28:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G6a6jZs2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26E75206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55762 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7LVq-0004lj-CS
	for qemu-devel@archiver.kernel.org; Sun, 16 Aug 2020 12:28:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36680)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k7LVH-0004Mv-8U
 for qemu-devel@nongnu.org; Sun, 16 Aug 2020 12:27:27 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:32821)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k7LVF-0001wi-LY
 for qemu-devel@nongnu.org; Sun, 16 Aug 2020 12:27:26 -0400
Received: by mail-wm1-x342.google.com with SMTP id f18so11740346wmc.0
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2020 09:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=DRZzmS38XU9sVJQ45IE5a8yuuVxarrcFpZP5xfCz6z0=;
 b=G6a6jZs2iyFZdUuGPtdaK6AN2MdiySv5SM7E+AHDIyCwW76LTHj1mI9KYrwmb83lYF
 Gn7K72D31dpgA7gCp8SSRiqAtAajrnpg4I1Cti+ITlW083ozP+T65R///3qRUjHaejTF
 ziOY/WuywYEWEbYu/N6mged5o0cjOB0VDWPS0dce+e7055svTH9AYo/J3s0p+T93k706
 0d3NjzQXoeFDEUe7BLLFHMZimse1/OsDdI3EbHREu0abaPnrseOxqn0Pwak1BI94UHDR
 aqZy/ADbaPQ0oF7qj6e3z6jR6U9VOXIt9BbMXojZKGqfGxgVGQPaXo206cLTUuACdNbT
 eWJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=DRZzmS38XU9sVJQ45IE5a8yuuVxarrcFpZP5xfCz6z0=;
 b=p9jglBGNB/0l+567HuD101cbpw3ScpP8oAtlcraLqKEoUEfD2jSl8DTnE9zQNIjNo4
 Fkcd+vKYpMxR0X6hx+Zs1kICcZWv8e1x4khkJ6PNXhdg/cIHl8EQe1PAgFuTGF7yXnWl
 bKVPx1bCO6D7pNZBbVBjUuSO4Ji79WiAyBIemKESBX3QhvDzryOhTzXnYfT4/u3SqRRa
 mbv0VhN9WmOsQ49NGf+lPZpSIqqCeh28pqh0JsxeOHwegzJFueg5KfRVcrWD2YoPIz+2
 Vl6jZB4RJd1NOXe+XfKjVpilQ14xZ7IS5fp1D/NHO2UG/qLgI5ztjabJSwQQ0w9nidFi
 j7Qg==
X-Gm-Message-State: AOAM532VWJ8haEEqE4E2Fk7TIw69t+zoV6R8UY4jT8Uw27S3EzD42UMb
 TRJEWX21QTl1fIbWL9LNgbs=
X-Google-Smtp-Source: ABdhPJwDoGIeKSzSeK7qgmG3H6MOryamimLxBeQelXplx/t5Wx1bv4BpRj7T5NuGQtMth63Xz7PXDw==
X-Received: by 2002:a1c:9a02:: with SMTP id c2mr12262020wme.16.1597595243284; 
 Sun, 16 Aug 2020 09:27:23 -0700 (PDT)
Received: from [192.168.1.36] (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id b139sm28472331wmd.19.2020.08.16.09.27.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 16 Aug 2020 09:27:22 -0700 (PDT)
Subject: Re: [PATCH v4 0/9] memory: assert and define MemoryRegionOps callbacks
To: P J P <ppandit@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20200811114133.672647-1-ppandit@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <c43dbd57-f22f-27f0-d6b3-77734be76631@amsat.org>
Date: Sun, 16 Aug 2020 18:27:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200811114133.672647-1-ppandit@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Prasad J Pandit <pjp@fedoraproject.org>, Li Qiang <liq3ea@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Lei Sun <slei.casper@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/11/20 1:41 PM, P J P wrote:
> From: Prasad J Pandit <pjp@fedoraproject.org>
> 
> Hello,
> 
> * This series asserts that MemoryRegionOps objects define read/write
>   callback methods. Thus avoids potential NULL pointer dereference.
>   ex. -> https://git.qemu.org/?p=qemu.git;a=commit;h=bb15013ef34617eb1344f5276292cadd326c21b2
> 
> * Also adds various undefined MemoryRegionOps read/write functions
>   to avoid potential assert failure.

What about read_with_attrs()/write_with_attrs()?
It seems they are part of the same problem.

> 
> Thank you.
> --
> Prasad J Pandit (9):
>   hw/pci-host: add pci-intack write method
>   pci-host: designware: add pcie-msi read method
>   vfio: add quirk device write method
>   prep: add ppc-parity write method
>   nvram: add nrf51_soc flash read method
>   spapr_pci: add spapr msi read method
>   tz-ppc: add dummy read/write methods
>   imx7-ccm: add digprog mmio write method
>   memory: assert MemoryRegionOps callbacks are defined
> 
>  hw/misc/imx7_ccm.c       |  8 ++++++++
>  hw/misc/tz-ppc.c         | 14 ++++++++++++++
>  hw/nvram/nrf51_nvm.c     | 10 ++++++++++
>  hw/pci-host/designware.c | 19 +++++++++++++++++++
>  hw/pci-host/prep.c       |  8 ++++++++
>  hw/ppc/prep_systemio.c   |  8 ++++++++
>  hw/ppc/spapr_pci.c       | 14 ++++++++++++--
>  hw/vfio/pci-quirks.c     |  8 ++++++++
>  softmmu/memory.c         | 10 +++++++++-
>  9 files changed, 96 insertions(+), 3 deletions(-)
> 
> --
> 2.26.2
> 


