Return-Path: <SRS0=axyf=VH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 217B3C73C7C
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 09:28:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED05A2084B
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 09:28:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED05A2084B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59304 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hl8ta-0003RW-5q
	for qemu-devel@archiver.kernel.org; Wed, 10 Jul 2019 05:28:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47705)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hl8qg-0000rN-Bi
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 05:25:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hl8qe-0000Rt-Nv
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 05:25:14 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44198)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hl8qe-0000Kc-EN
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 05:25:12 -0400
Received: by mail-wr1-f65.google.com with SMTP id p17so1615255wrf.11
 for <qemu-devel@nongnu.org>; Wed, 10 Jul 2019 02:25:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=y8X0q8JkQpXHnegDLoHI+R1uM+Iea5X+qbInC9hVKMM=;
 b=oNq6P2UJTBl6KYu6h4nwzUKpsUtXKDdptJLvkedXONUaz4GtqHyXKd34Wo1oIhvZ1x
 JQuBrhImgBej9Nm8mYW8Ud1rKUnhpH7ALUHQctgQRfMm5499d9XCWxYSO5tRY7eALyWT
 AS/jA6UFKhE2f+vFZaGxi8G6dlhfv3YfvYox35W1vCkL0329b1eEwasfwlc69VmPuspo
 5A8/YmZcT0Re9ktyEWiBNGiTrJbmzsb35DJs4lGV7LLjWFpSxwwQjDuUvqhvoViSCXPS
 yBPNg1BMC98G00aaAvs0BBZV5z4BcscPLY+OiyvYz9BED3sDLaEx60VSsali7jr+QV/n
 mfYA==
X-Gm-Message-State: APjAAAVEo8qlrWkdAF+v6KOyIYDES+T9oRoZydKh1zZre93vrk9BBnwo
 yjtMev5kAoWlIHZqOioVht52Tg==
X-Google-Smtp-Source: APXvYqw9ChRmJNTXNH0fhz7uDKgJ2177oBZguFUQXqC4kDnFchlGyEszUobtPFO5xHHBqoiaUMIQeA==
X-Received: by 2002:adf:ff84:: with SMTP id j4mr28800651wrr.71.1562750706505; 
 Wed, 10 Jul 2019 02:25:06 -0700 (PDT)
Received: from [10.32.224.100] (red-hat-inc.vlan560.asr1.mad1.gblx.net.
 [159.63.51.90])
 by smtp.gmail.com with ESMTPSA id b203sm1638790wmd.41.2019.07.10.02.25.05
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Wed, 10 Jul 2019 02:25:05 -0700 (PDT)
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20190709185936.31335-1-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <501e0780-21cf-b1f1-1a93-1f8a9f1cf8e1@redhat.com>
Date: Wed, 10 Jul 2019 11:25:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190709185936.31335-1-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.65
Subject: Re: [Qemu-devel] [PATCH] qdev: Collect HMP handlers command
 handlers in qdev-monitor.c
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
Cc: pbonzini@redhat.com, berrange@redhat.com, ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/9/19 8:59 PM, Markus Armbruster wrote:
> Move hmp_device_add(), hmp_device_del() from monitor/hmp-cmds.c to
> qdev-monitor.c, where they are covered by MAINTAINERS section "QOM",
> just like qapi/qdev.json.  hmp_info_qtree() and hmp_info_qdm() are
> already there.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
> This is a follow-up to my "Move QOM, qdev, machine core and dump code"
> series, merged in commit 374f63f6810.
> 
>  monitor/hmp-cmds.c | 19 -------------------
>  qdev-monitor.c     | 18 ++++++++++++++++++
>  2 files changed, 18 insertions(+), 19 deletions(-)
> 
> diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
> index 99ceb0846b..550d363374 100644
> --- a/monitor/hmp-cmds.c
> +++ b/monitor/hmp-cmds.c
> @@ -25,7 +25,6 @@
>  #include "qemu/timer.h"
>  #include "qemu/sockets.h"
>  #include "monitor/monitor-internal.h"
> -#include "monitor/qdev.h"
>  #include "qapi/error.h"
>  #include "qapi/clone-visitor.h"
>  #include "qapi/opts-visitor.h"
> @@ -35,7 +34,6 @@
>  #include "qapi/qapi-commands-migration.h"
>  #include "qapi/qapi-commands-misc.h"
>  #include "qapi/qapi-commands-net.h"
> -#include "qapi/qapi-commands-qdev.h"
>  #include "qapi/qapi-commands-rocker.h"
>  #include "qapi/qapi-commands-run-state.h"
>  #include "qapi/qapi-commands-tpm.h"
> @@ -2181,23 +2179,6 @@ void hmp_migrate(Monitor *mon, const QDict *qdict)
>      }
>  }
>  
> -void hmp_device_add(Monitor *mon, const QDict *qdict)
> -{
> -    Error *err = NULL;
> -
> -    qmp_device_add((QDict *)qdict, NULL, &err);
> -    hmp_handle_error(mon, &err);
> -}
> -
> -void hmp_device_del(Monitor *mon, const QDict *qdict)
> -{
> -    const char *id = qdict_get_str(qdict, "id");
> -    Error *err = NULL;
> -
> -    qmp_device_del(id, &err);
> -    hmp_handle_error(mon, &err);
> -}
> -
>  void hmp_netdev_add(Monitor *mon, const QDict *qdict)
>  {
>      Error *err = NULL;
> diff --git a/qdev-monitor.c b/qdev-monitor.c
> index 58222c2211..cd6299e92b 100644
> --- a/qdev-monitor.c
> +++ b/qdev-monitor.c
> @@ -20,6 +20,7 @@
>  #include "qemu/osdep.h"
>  #include "hw/qdev.h"
>  #include "hw/sysbus.h"
> +#include "monitor/hmp.h"
>  #include "monitor/monitor.h"
>  #include "monitor/qdev.h"
>  #include "sysemu/arch_init.h"
> @@ -844,6 +845,23 @@ void qmp_device_del(const char *id, Error **errp)
>      }
>  }
>  
> +void hmp_device_add(Monitor *mon, const QDict *qdict)
> +{
> +    Error *err = NULL;
> +
> +    qmp_device_add((QDict *)qdict, NULL, &err);
> +    hmp_handle_error(mon, &err);
> +}
> +
> +void hmp_device_del(Monitor *mon, const QDict *qdict)
> +{
> +    const char *id = qdict_get_str(qdict, "id");
> +    Error *err = NULL;
> +
> +    qmp_device_del(id, &err);
> +    hmp_handle_error(mon, &err);
> +}
> +
>  BlockBackend *blk_by_qdev_id(const char *id, Error **errp)
>  {
>      DeviceState *dev;
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

