Return-Path: <SRS0=g8gL=WD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2706DC32751
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 14:51:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0165F2199C
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 14:51:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0165F2199C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42068 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvNHf-0002Gx-A4
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 10:51:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45041)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hvNH7-0001Ow-GE
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 10:50:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hvNH6-00004r-A4
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 10:50:49 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46232)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hvNH6-0008Vy-3c
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 10:50:48 -0400
Received: by mail-wr1-f68.google.com with SMTP id z1so91684398wru.13
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2019 07:50:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=RdqHwScRhw95LfvXmU//8zSUZ8i8q/WqcJAuHFAhHOU=;
 b=IfFkQ8YD8XI/kidFLyApIfBCSe9o1Oqdr35cJigHKsHxGog0fpPn1Wl0BizPY03AhF
 +EaiQxva6PDsFQ3yQ9BCzY1XgE3AzFyUYJSzqX77FvqrpgXp6SuCY64GZw3suDL4pGnH
 b6YxeY38lgMvSeqFFM4DLu+viv2KGfp2yCRdbyabd1t27ywSCD/9eHAhho0ajBxzOPIp
 d180ZDg5TPjUuj0fkZiBhQkOqCHFW3QT+/zNy8EnFMzfxwlH2OtjLyeOAprV1UG1Vvsr
 XBnpYgK0T/ZzM3DuG92tZMSToPkhRlnPH5tucQAd4FDXv9SnRkkYqxpPSK2P67DOBizp
 /9XQ==
X-Gm-Message-State: APjAAAXPNNQYr/6M5vhjzsAKCcYm6Ke3h6ebISsjPe6VcG26wzOhFjmI
 drsBxQFZ4In4BCCZpwEBmjobNQ8l3zA=
X-Google-Smtp-Source: APXvYqzOIzRUM607YRO5wGzqYUyP2wehta7W5VRKw9doQ4QCwJ7CAqNhHBK5J6O0Oeu3bf4Zw13fSg==
X-Received: by 2002:a5d:4742:: with SMTP id o2mr5012505wrs.235.1565189446428; 
 Wed, 07 Aug 2019 07:50:46 -0700 (PDT)
Received: from [192.168.1.39] (214.red-83-51-160.dynamicip.rima-tde.net.
 [83.51.160.214])
 by smtp.gmail.com with ESMTPSA id b203sm277777wmd.41.2019.08.07.07.50.45
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Wed, 07 Aug 2019 07:50:45 -0700 (PDT)
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20190806151435.10740-1-armbru@redhat.com>
 <20190806151435.10740-17-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <2739ad81-5e97-a7a6-8888-587224032a80@redhat.com>
Date: Wed, 7 Aug 2019 16:50:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190806151435.10740-17-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.68
Subject: Re: [Qemu-devel] [PATCH v2 16/29] Include exec/memory.h slightly
 less
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/6/19 5:14 PM, Markus Armbruster wrote:
> Drop unnecessary inclusions from headers.  Downgrade a few more to
> exec/hwaddr.h.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  hw/audio/lm4549.h                   | 1 +
>  hw/display/edid-region.c            | 1 +
>  hw/display/tc6393xb.c               | 1 +
>  hw/net/can/can_sja1000.h            | 1 +
>  hw/net/ne2000.c                     | 1 +
>  hw/xtensa/xtensa_memory.h           | 1 -
>  include/hw/arm/boot.h               | 1 -
>  include/hw/arm/fsl-imx7.h           | 1 -
>  include/hw/arm/soc_dma.h            | 2 +-
>  include/hw/block/flash.h            | 2 +-
>  include/hw/boards.h                 | 1 +
>  include/hw/char/parallel.h          | 1 -
>  include/hw/display/milkymist_tmu2.h | 1 +
>  include/hw/display/tc6393xb.h       | 2 --
>  include/hw/display/vga.h            | 2 +-
>  include/hw/hw.h                     | 1 -
>  include/hw/i2c/pm_smbus.h           | 1 +
>  include/hw/i2c/smbus_eeprom.h       | 1 +
>  include/hw/misc/auxbus.h            | 1 +
>  include/hw/ppc/xics.h               | 1 +
>  include/hw/usb.h                    | 1 +
>  include/hw/virtio/virtio.h          | 1 +
>  migration/colo.c                    | 1 +
>  migration/migration.h               | 1 +
>  migration/postcopy-ram.c            | 1 +
>  migration/rdma.c                    | 1 +
>  26 files changed, 20 insertions(+), 10 deletions(-)
> 
[...]> diff --git a/migration/colo.c b/migration/colo.c
> index 9f84b1fa3c..0b5b620391 100644
> --- a/migration/colo.c
> +++ b/migration/colo.c
> @@ -23,6 +23,7 @@
>  #include "io/channel-buffer.h"
>  #include "trace.h"
>  #include "qemu/error-report.h"
> +#include "qemu/rcu.h"
>  #include "migration/failover.h"
>  #ifdef CONFIG_REPLICATION
>  #include "replication.h"
> diff --git a/migration/migration.h b/migration/migration.h
> index 26f01d00f6..a7882af67a 100644
> --- a/migration/migration.h
> +++ b/migration/migration.h
> @@ -14,6 +14,7 @@
>  #ifndef QEMU_MIGRATION_H
>  #define QEMU_MIGRATION_H
>  
> +#include "exec/cpu-common.h"
>  #include "qapi/qapi-types-migration.h"
>  #include "qemu/thread.h"
>  #include "qemu/coroutine_int.h"
> diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
> index 9faacacc9e..56054d0a73 100644
> --- a/migration/postcopy-ram.c
> +++ b/migration/postcopy-ram.c
> @@ -25,6 +25,7 @@
>  #include "ram.h"
>  #include "qapi/error.h"
>  #include "qemu/notify.h"
> +#include "qemu/rcu.h"
>  #include "sysemu/sysemu.h"
>  #include "sysemu/balloon.h"
>  #include "qemu/error-report.h"
> diff --git a/migration/rdma.c b/migration/rdma.c
> index 3036221ee8..b0e27b6174 100644
> --- a/migration/rdma.c
> +++ b/migration/rdma.c
> @@ -25,6 +25,7 @@
>  #include "qemu/error-report.h"
>  #include "qemu/main-loop.h"
>  #include "qemu/module.h"
> +#include "qemu/rcu.h"
>  #include "qemu/sockets.h"
>  #include "qemu/bitmap.h"
>  #include "qemu/coroutine.h"
> 

To keep this patch cleaner, can you use a preparatory patch adding the
various "qemu/rcu.h"?

