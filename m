Return-Path: <SRS0=mi2X=WI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80103C31E40
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2019 16:04:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5515420665
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2019 16:04:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5515420665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47004 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxCnx-0006Dq-Jv
	for qemu-devel@archiver.kernel.org; Mon, 12 Aug 2019 12:04:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50293)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hxCmi-0004OX-BP
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 12:03:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hxCmh-0001X5-99
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 12:03:00 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55341)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hxCmh-0001Wv-29
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 12:02:59 -0400
Received: by mail-wm1-f65.google.com with SMTP id f72so33746wmf.5
 for <qemu-devel@nongnu.org>; Mon, 12 Aug 2019 09:02:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=BsYxBgaegzfBPq4bAX5l9R5jyvQmAastNPfVth29MXw=;
 b=axtvjYsMuZPEs5mHNKk0iC8+JVgVPe7VLTRhT6KoBLdT/Xww3sv4Zxtf8NZ57/cDiv
 EVvPyl46a6FvYKbrJeWqrV2q67hzBtRvN4OTRnOGvt5ILw3/mCxXiXAUGppEpg/9EX10
 eHU8PFaYG7cr+TELmNJpSrFdGJeXHtU/hhQ5otuTtTplBKugGen9fUYAv1DRYnl6LWaI
 hulj1WELi1SIuhAC2IK7otXNRZSCcwt2ZdwN9+sa3ZhDmaM9Dkjumd9XykP2gbiySv08
 QTxlCW2MSSqD9J8tRl8wbx0EPg9TxisibeOJnOi03AJXVWEtn4ja1Ddk1WIbkjhj/X3C
 0GZw==
X-Gm-Message-State: APjAAAUy67j0soN5oJY1sfhIJY4yivSUlRuVMeiGhjSSrVQDqUz7+nNM
 yNz4O022vVs4tPbt0SguVmWQNA==
X-Google-Smtp-Source: APXvYqzkoGD0+fOAsGz5FMChBR5Vs9kMxtGN9jDGBhNDdyYLkpkbdxxl88GKiXs2r0gtsb7a8KYKlw==
X-Received: by 2002:a1c:760b:: with SMTP id r11mr1208wmc.41.1565625778074;
 Mon, 12 Aug 2019 09:02:58 -0700 (PDT)
Received: from [192.168.1.34] (59.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.59])
 by smtp.gmail.com with ESMTPSA id a64sm413006wmf.1.2019.08.12.09.02.57
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Mon, 12 Aug 2019 09:02:57 -0700 (PDT)
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20190812052359.30071-1-armbru@redhat.com>
 <20190812052359.30071-23-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <d2f77b14-2123-dd77-0d90-f2a99248a68f@redhat.com>
Date: Mon, 12 Aug 2019 18:02:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190812052359.30071-23-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.65
Subject: Re: [Qemu-devel] [PATCH v4 22/29] Include hw/boards.h a bit less
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
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/12/19 7:23 AM, Markus Armbruster wrote:
> hw/boards.h pulls in almost 60 headers.  The less we include it into
> headers, the better.  As a first step, drop superfluous inclusions,
> and downgrade some more to what's actually needed.  Gets rid of just
> one inclusion into a header.
> 
> Cc: Eduardo Habkost <ehabkost@redhat.com>
> Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  include/hw/mem/pc-dimm.h        | 1 -
>  backends/cryptodev-builtin.c    | 1 -
>  backends/cryptodev-vhost-user.c | 1 -
>  backends/cryptodev.c            | 1 -
>  hw/acpi/ich9.c                  | 1 +
>  hw/alpha/dp264.c                | 1 -
>  hw/alpha/typhoon.c              | 1 +
>  hw/arm/boot.c                   | 1 -
>  hw/arm/exynos4210.c             | 2 +-
>  hw/arm/fsl-imx25.c              | 1 -
>  hw/arm/fsl-imx31.c              | 1 -
>  hw/arm/msf2-soc.c               | 1 -
>  hw/arm/nrf51_soc.c              | 1 -
>  hw/arm/omap1.c                  | 1 +
>  hw/arm/omap2.c                  | 1 +
>  hw/arm/smmuv3.c                 | 1 -
>  hw/arm/virt.c                   | 1 +
>  hw/core/numa.c                  | 2 ++
>  hw/i386/pc_piix.c               | 1 -
>  hw/i386/pc_q35.c                | 1 -
>  hw/i386/pc_sysfw.c              | 1 -
>  hw/ppc/e500plat.c               | 1 -
>  hw/ppc/mpc8544ds.c              | 1 -
>  hw/ppc/pnv.c                    | 1 +
>  hw/ppc/ppc405_uc.c              | 1 -
>  hw/ppc/spapr_cpu_core.c         | 1 -
>  hw/ppc/spapr_vio.c              | 1 -
>  hw/riscv/boot.c                 | 2 +-
>  hw/s390x/s390-stattrib.c        | 1 -
>  hw/xtensa/xtensa_memory.c       | 1 -
>  monitor/qmp-cmds.c              | 1 -
>  target/alpha/machine.c          | 1 -
>  target/arm/machine.c            | 1 -
>  target/arm/monitor.c            | 1 -
>  target/hppa/machine.c           | 1 -
>  target/i386/hvf/hvf.c           | 1 -
>  target/i386/hvf/x86_task.c      | 1 -
>  target/i386/machine.c           | 1 -
>  target/i386/whpx-all.c          | 1 -
>  target/lm32/machine.c           | 1 -
>  target/moxie/machine.c          | 1 -
>  target/openrisc/machine.c       | 1 -
>  target/ppc/machine.c            | 1 -
>  target/sparc/machine.c          | 1 -
>  44 files changed, 10 insertions(+), 37 deletions(-)

