Return-Path: <SRS0=FTQm=VX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A99B8C76190
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 15:58:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85DA42080C
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 15:58:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85DA42080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41368 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hr2bf-0002Co-PU
	for qemu-devel@archiver.kernel.org; Fri, 26 Jul 2019 11:58:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45023)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hr2bT-0001ob-0o
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 11:57:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hr2bR-0001NM-Pe
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 11:57:54 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35181)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hr2bR-0001LX-Jm
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 11:57:53 -0400
Received: by mail-wm1-f67.google.com with SMTP id l2so48092737wmg.0
 for <qemu-devel@nongnu.org>; Fri, 26 Jul 2019 08:57:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=54eX5Ea85jOV7pZGe73lXjymCiI17O+DS2ckwxoOync=;
 b=MyH3fh6Mnln85Fyg+iuAdQPyLXtynUPFANMygLbp4TKRgZ//nctVRCtv2KtyxwTFg4
 SQu16DrZ5TStyAi8h2T6rUe55zghXz1wtupXyuMAf/ZjnGzbnkqs5CwTExQDbB7Bc6Jz
 4yr73WwnYBk/kHIJwLPXrQEf5nV8Swa/F2pHxeU7Qn1K7r2oQQI9HLMsdSMX0IAVlaVp
 sxfd/Zvjq4FrdqY6cl2VZv+Z+6vq82uISre5QPqvqV7JnQv9qyBxIecm4waNt4xl6dEF
 stfeNX9ivaQhKky6tE7Gv75x0SUb0DlgnBXExZrpKdpOQ+7jW5xZJzL4d6fcYw2nQ8At
 Z5BA==
X-Gm-Message-State: APjAAAUIyXjVl3EdE3lgiYRIpLiTksVVtn4gnIK+h7vrfdC8ds2U5cPy
 +ENOSBzmn6vpMJj5PvUnT3NT5w==
X-Google-Smtp-Source: APXvYqwHJ8v8IsIT87swIn/ZGBSJCPh+qOSi/MBPBjqOu/hv/FMUyPU9R55B36NEd16Kdf+YfFfm5A==
X-Received: by 2002:a05:600c:c4:: with SMTP id
 u4mr85964899wmm.96.1564156672665; 
 Fri, 26 Jul 2019 08:57:52 -0700 (PDT)
Received: from [192.168.1.37] (190.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.190])
 by smtp.gmail.com with ESMTPSA id n12sm57108320wmc.24.2019.07.26.08.57.51
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Fri, 26 Jul 2019 08:57:52 -0700 (PDT)
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20190726120542.9894-1-armbru@redhat.com>
 <20190726120542.9894-26-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <75e50dde-da97-0f56-b959-cfee21bd9389@redhat.com>
Date: Fri, 26 Jul 2019 17:57:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190726120542.9894-26-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.67
Subject: Re: [Qemu-devel] [PATCH 25/28] numa: Move remaining NUMA
 declarations from sysemu.h to numa.h
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

On 7/26/19 2:05 PM, Markus Armbruster wrote:
> Commit e35704ba9c "numa: Move NUMA declarations from sysemu.h to
> numa.h" left a few NUMA-related macros behind.  Move them now.
> 
> Cc: Eduardo Habkost <ehabkost@redhat.com>
> Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

:)

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  exec.c                   | 2 +-
>  hw/core/numa.c           | 1 +
>  hw/mem/pc-dimm.c         | 1 +
>  hw/pci/pci.c             | 2 +-
>  hw/ppc/spapr.c           | 1 +
>  include/sysemu/hostmem.h | 2 +-
>  include/sysemu/numa.h    | 9 +++++++--
>  include/sysemu/sysemu.h  | 7 -------
>  8 files changed, 13 insertions(+), 12 deletions(-)
> 
> diff --git a/exec.c b/exec.c
> index 4d9e146c79..f0ac29aa26 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -45,7 +45,7 @@
>  #include "exec/memory.h"
>  #include "exec/ioport.h"
>  #include "sysemu/dma.h"
> -#include "sysemu/numa.h"
> +#include "sysemu/hostmem.h"
>  #include "sysemu/hw_accel.h"
>  #include "exec/address-spaces.h"
>  #include "sysemu/xen-mapcache.h"
> diff --git a/hw/core/numa.c b/hw/core/numa.c
> index d817f06ead..450c522dd8 100644
> --- a/hw/core/numa.c
> +++ b/hw/core/numa.c
> @@ -23,6 +23,7 @@
>   */
>  
>  #include "qemu/osdep.h"
> +#include "sysemu/hostmem.h"
>  #include "sysemu/numa.h"
>  #include "exec/cpu-common.h"
>  #include "exec/ramlist.h"
> diff --git a/hw/mem/pc-dimm.c b/hw/mem/pc-dimm.c
> index fa90d4fc6c..938706d5a7 100644
> --- a/hw/mem/pc-dimm.c
> +++ b/hw/mem/pc-dimm.c
> @@ -28,6 +28,7 @@
>  #include "qapi/error.h"
>  #include "qapi/visitor.h"
>  #include "qemu/module.h"
> +#include "sysemu/hostmem.h"
>  #include "sysemu/numa.h"
>  #include "trace.h"
>  
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index 9001b81daa..4b6ffab13d 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -34,7 +34,7 @@
>  #include "migration/vmstate.h"
>  #include "monitor/monitor.h"
>  #include "net/net.h"
> -#include "sysemu/sysemu.h"
> +#include "sysemu/numa.h"
>  #include "hw/loader.h"
>  #include "qemu/error-report.h"
>  #include "qemu/range.h"
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 06d23a5004..4044e61a0c 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -29,6 +29,7 @@
>  #include "qapi/error.h"
>  #include "qapi/visitor.h"
>  #include "sysemu/sysemu.h"
> +#include "sysemu/hostmem.h"
>  #include "sysemu/numa.h"
>  #include "sysemu/qtest.h"
>  #include "sysemu/reset.h"
> diff --git a/include/sysemu/hostmem.h b/include/sysemu/hostmem.h
> index afeb5db1b1..4dbdadd39e 100644
> --- a/include/sysemu/hostmem.h
> +++ b/include/sysemu/hostmem.h
> @@ -13,7 +13,7 @@
>  #ifndef SYSEMU_HOSTMEM_H
>  #define SYSEMU_HOSTMEM_H
>  
> -#include "sysemu/sysemu.h" /* for MAX_NODES */
> +#include "sysemu/numa.h"
>  #include "qapi/qapi-types-machine.h"
>  #include "qom/object.h"
>  #include "exec/memory.h"
> diff --git a/include/sysemu/numa.h b/include/sysemu/numa.h
> index 4c4c1dee9b..7a4ce89765 100644
> --- a/include/sysemu/numa.h
> +++ b/include/sysemu/numa.h
> @@ -2,13 +2,18 @@
>  #define SYSEMU_NUMA_H
>  
>  #include "qemu/bitmap.h"
> -#include "sysemu/sysemu.h"
> -#include "sysemu/hostmem.h"
>  #include "qapi/qapi-types-machine.h"
>  #include "exec/cpu-common.h"
>  
>  struct CPUArchId;
>  
> +#define MAX_NODES 128
> +#define NUMA_NODE_UNASSIGNED MAX_NODES
> +#define NUMA_DISTANCE_MIN         10
> +#define NUMA_DISTANCE_DEFAULT     20
> +#define NUMA_DISTANCE_MAX         254
> +#define NUMA_DISTANCE_UNREACHABLE 255
> +
>  extern int nb_numa_nodes;   /* Number of NUMA nodes */
>  extern bool have_numa_distance;
>  
> diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
> index ac18a1184a..227202999d 100644
> --- a/include/sysemu/sysemu.h
> +++ b/include/sysemu/sysemu.h
> @@ -117,13 +117,6 @@ extern QEMUClockType rtc_clock;
>  extern const char *mem_path;
>  extern int mem_prealloc;
>  
> -#define MAX_NODES 128
> -#define NUMA_NODE_UNASSIGNED MAX_NODES
> -#define NUMA_DISTANCE_MIN         10
> -#define NUMA_DISTANCE_DEFAULT     20
> -#define NUMA_DISTANCE_MAX         254
> -#define NUMA_DISTANCE_UNREACHABLE 255
> -
>  #define MAX_OPTION_ROMS 16
>  typedef struct QEMUOptionRom {
>      const char *name;
> 

