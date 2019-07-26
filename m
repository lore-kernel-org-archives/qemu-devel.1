Return-Path: <SRS0=FTQm=VX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83C96C7618B
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 15:57:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BAB62080C
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 15:57:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BAB62080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41360 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hr2ap-0001C1-Ki
	for qemu-devel@archiver.kernel.org; Fri, 26 Jul 2019 11:57:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44169)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hr2ae-0000i5-RD
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 11:57:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hr2ad-0007sS-LA
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 11:57:04 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51631)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hr2ad-0007qB-Dz
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 11:57:03 -0400
Received: by mail-wm1-f66.google.com with SMTP id 207so48440771wma.1
 for <qemu-devel@nongnu.org>; Fri, 26 Jul 2019 08:57:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=DfGRCXBUxlLCg8i6vgEx3pUe+nqoQTAtu2NyWz/bLTU=;
 b=CRva5LeRkpLM6d5L6b7OciSrzgdHbWGPOMmFUKPmiA0ZVtnwZ04XAKoCTq+UQuXpck
 XL7FCVtgQKwsUAxNq5Goi8g0qs2EnmLFKJlttjXww/R3ovesLzjyPeaTjWsyYvYqojRx
 qjJeGoKb/xmOlA2hWvnxXgBWkMIQn5abhAfC4LqtcEycpX1VWo2wqWsc4MRXh6PH0P7C
 dROk9ixevXKkWjVkk0De+XeUOfMZCl+NFrEzVFZiQ9UPjnMnPZU2QofXfr+HTjxF2rLC
 dynt9PhkDvUIFhSTVhUJEXC8fRmGgg1Gazo2ma1BhKy7HnwzaqUr60R4EYnoSKRk8G0N
 VP+w==
X-Gm-Message-State: APjAAAW3jFMJw19BQ54Yt4J+kEv+0OBtLw6pJk8woRxx/fYbcky3lE72
 nM54GALQYeKFNB+ijaLrfZNmPw==
X-Google-Smtp-Source: APXvYqwwu4lzSVQ+hEPgqx3z3w4Sv8mXV3cxs/5WCQ9JUrtUSF0dC2TaNgOPnPZRmMcdaY9mKsWNoQ==
X-Received: by 2002:a1c:9d53:: with SMTP id g80mr80963719wme.103.1564156622448; 
 Fri, 26 Jul 2019 08:57:02 -0700 (PDT)
Received: from [192.168.1.37] (190.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.190])
 by smtp.gmail.com with ESMTPSA id t24sm47818375wmj.14.2019.07.26.08.57.01
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Fri, 26 Jul 2019 08:57:01 -0700 (PDT)
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20190726120542.9894-1-armbru@redhat.com>
 <20190726120542.9894-25-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <f1edc09e-a2f8-cd02-7448-ac44abc448e1@redhat.com>
Date: Fri, 26 Jul 2019 17:57:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190726120542.9894-25-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.66
Subject: Re: [Qemu-devel] [PATCH 24/28] Include sysemu/hostmem.h less
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
Cc: Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/26/19 2:05 PM, Markus Armbruster wrote:
> Move the HostMemoryBackend typedef from sysemu/hostmem.h to
> qemu/typedefs.h.  This renders a few inclusions of sysemu/hostmem.h
> superflouous; drop them.
> 
> Cc: Eduardo Habkost <ehabkost@redhat.com>
> Cc: Igor Mammedov <imammedo@redhat.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  hw/mem/nvdimm.c                 | 1 +
>  hw/virtio/virtio-pmem.c         | 1 +
>  include/hw/mem/pc-dimm.h        | 1 -
>  include/hw/virtio/virtio-pmem.h | 1 -
>  include/qemu/typedefs.h         | 1 +
>  include/sysemu/hostmem.h        | 1 -
>  6 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/mem/nvdimm.c b/hw/mem/nvdimm.c
> index 6fefd65092..375f9a588a 100644
> --- a/hw/mem/nvdimm.c
> +++ b/hw/mem/nvdimm.c
> @@ -30,6 +30,7 @@
>  #include "hw/mem/nvdimm.h"
>  #include "hw/qdev-properties.h"
>  #include "hw/mem/memory-device.h"
> +#include "sysemu/hostmem.h"
>  
>  static void nvdimm_get_label_size(Object *obj, Visitor *v, const char *name,
>                                    void *opaque, Error **errp)
> diff --git a/hw/virtio/virtio-pmem.c b/hw/virtio/virtio-pmem.c
> index ff1a2ddb36..c0c9395e55 100644
> --- a/hw/virtio/virtio-pmem.c
> +++ b/hw/virtio/virtio-pmem.c
> @@ -21,6 +21,7 @@
>  #include "hw/virtio/virtio-access.h"
>  #include "standard-headers/linux/virtio_ids.h"
>  #include "standard-headers/linux/virtio_pmem.h"
> +#include "sysemu/hostmem.h"
>  #include "block/aio.h"
>  #include "block/thread-pool.h"
>  
> diff --git a/include/hw/mem/pc-dimm.h b/include/hw/mem/pc-dimm.h
> index 47b246f95c..289edc0f3d 100644
> --- a/include/hw/mem/pc-dimm.h
> +++ b/include/hw/mem/pc-dimm.h
> @@ -17,7 +17,6 @@
>  #define QEMU_PC_DIMM_H
>  
>  #include "exec/memory.h"
> -#include "sysemu/hostmem.h"
>  #include "hw/qdev-core.h"
>  
>  #define TYPE_PC_DIMM "pc-dimm"
> diff --git a/include/hw/virtio/virtio-pmem.h b/include/hw/virtio/virtio-pmem.h
> index 8bf2ae780f..33f1999320 100644
> --- a/include/hw/virtio/virtio-pmem.h
> +++ b/include/hw/virtio/virtio-pmem.h
> @@ -16,7 +16,6 @@
>  
>  #include "hw/virtio/virtio.h"
>  #include "qapi/qapi-types-misc.h"
> -#include "sysemu/hostmem.h"
>  
>  #define TYPE_VIRTIO_PMEM "virtio-pmem"
>  
> diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
> index 9e1283aacf..f569f5f270 100644
> --- a/include/qemu/typedefs.h
> +++ b/include/qemu/typedefs.h
> @@ -33,6 +33,7 @@ typedef struct FWCfgEntry FWCfgEntry;
>  typedef struct FWCfgIoState FWCfgIoState;
>  typedef struct FWCfgMemState FWCfgMemState;
>  typedef struct FWCfgState FWCfgState;
> +typedef struct HostMemoryBackend HostMemoryBackend;
>  typedef struct HVFX86EmulatorState HVFX86EmulatorState;
>  typedef struct I2CBus I2CBus;
>  typedef struct I2SCodec I2SCodec;
> diff --git a/include/sysemu/hostmem.h b/include/sysemu/hostmem.h
> index 92fa0e458c..afeb5db1b1 100644
> --- a/include/sysemu/hostmem.h
> +++ b/include/sysemu/hostmem.h
> @@ -27,7 +27,6 @@
>  #define MEMORY_BACKEND_CLASS(klass) \
>      OBJECT_CLASS_CHECK(HostMemoryBackendClass, (klass), TYPE_MEMORY_BACKEND)
>  
> -typedef struct HostMemoryBackend HostMemoryBackend;
>  typedef struct HostMemoryBackendClass HostMemoryBackendClass;
>  
>  /**
> 

