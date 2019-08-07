Return-Path: <SRS0=g8gL=WD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49A6EC433FF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 17:27:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E3B921E6C
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 17:27:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E3B921E6C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43806 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvPid-0003wk-FP
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 13:27:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54610)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hvPiF-0003Y0-SH
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 13:27:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hvPiE-00021g-PS
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 13:26:59 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42731)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hvPiE-0001zx-Ij
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 13:26:58 -0400
Received: by mail-wr1-f68.google.com with SMTP id x1so42277637wrr.9
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2019 10:26:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=UZz/HWA8TwfVXjmrH4RO+x+EtGs97I0AVipeeNQcUtE=;
 b=dX8k6Vs3Yvga83ytfOiyq8vubinMMdz63xPy2vGAA1U0NMQk5W4wzKAI1O1bTwcJQG
 wwCA50jiEm6in3BVGxBoKChwNf4NmWtNmW+bRPuMpOMVgmOX12TS9KbHnaTeHpDHue3J
 kck456CKhm+yxCbYNSYZENT7ZqFVQO6WHWIjySZbRWSzVm4mGh7uPE5gi9pyyUi30NDS
 6zAMQ0+N8YrHe9klu1JgB6op4ZOOuuAVCArHXKcOV3qeH4VysBSZwHoYWvHWjxFP4HVF
 gXyrxD9vZs0mhYYQ4ZrjmAnOOR1LH4/vIPtf2r8Quk2c06PSCzbMhAAyZfoy/jDIsk+7
 OGyw==
X-Gm-Message-State: APjAAAVFqbiCxixE4xLXDwp0sHK/oI8bkSMxnFBvOfpkGtGGMpeOeJAR
 96v2oHFfNCPWG5pwNXzVka2pRg==
X-Google-Smtp-Source: APXvYqzctKsOlZMw6P+SzMEfd3nwJaVjHKsBrH8mw6CHE3rPLbe67hva4nNgUdnw4xEdpMX+gpsGcA==
X-Received: by 2002:adf:d4c6:: with SMTP id w6mr12314632wrk.98.1565198817535; 
 Wed, 07 Aug 2019 10:26:57 -0700 (PDT)
Received: from [192.168.1.115] (214.red-83-51-160.dynamicip.rima-tde.net.
 [83.51.160.214])
 by smtp.gmail.com with ESMTPSA id 66sm10301201wrc.83.2019.08.07.10.26.56
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Wed, 07 Aug 2019 10:26:56 -0700 (PDT)
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20190806151435.10740-1-armbru@redhat.com>
 <20190806151435.10740-23-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <de7f547d-1c97-135f-654f-3856fa2eec2f@redhat.com>
Date: Wed, 7 Aug 2019 19:26:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190806151435.10740-23-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.68
Subject: Re: [Qemu-devel] [PATCH v2 22/29] Include hw/boards.h a bit less
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
Cc: Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/6/19 5:14 PM, Markus Armbruster wrote:
> hw/boards.h pulls in almost 60 headers.  The less we include it into
> headers, the better.  As a first step, drop superfluous inclusions,
> and downgrade some more to what's actually needed.  Gets rid of just
> one inclusion into a header.
> 
> Cc: Eduardo Habkost <ehabkost@redhat.com>
> Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
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
>  include/hw/mem/pc-dimm.h        | 1 -
>  monitor/qmp-cmds.c              | 1 -
>  target/alpha/machine.c          | 1 -
>  target/arm/machine.c            | 1 -
>  target/arm/monitor.c            | 1 -
>  target/hppa/machine.c           | 1 -
>  target/i386/hax-all.c           | 1 -
>  target/i386/hvf/hvf.c           | 1 -
>  target/i386/hvf/x86_task.c      | 1 -
>  target/i386/machine.c           | 1 -
>  target/i386/whpx-all.c          | 1 -
>  target/lm32/machine.c           | 1 -
>  target/moxie/machine.c          | 1 -
>  target/openrisc/machine.c       | 1 -
>  target/ppc/machine.c            | 1 -
>  target/sparc/machine.c          | 1 -
>  45 files changed, 10 insertions(+), 38 deletions(-)
[...]
> diff --git a/target/i386/hax-all.c b/target/i386/hax-all.c
> index bcacdd1d8f..34a9f6f7a9 100644
> --- a/target/i386/hax-all.c
> +++ b/target/i386/hax-all.c
> @@ -33,7 +33,6 @@
>  #include "sysemu/reset.h"
>  #include "sysemu/sysemu.h"
>  #include "qemu/main-loop.h"
> -#include "hw/boards.h"
>  
>  #define DEBUG_HAX 0

include/sysemu/hax.h misses to include "hw/boards.h":

target/i386/hax-all.c: In function 'hax_accel_init':
target/i386/hax-all.c:354:26: error: dereferencing pointer to incomplete
type 'MachineState {aka struct MachineState}'
     int ret = hax_init(ms->ram_size);
                          ^

