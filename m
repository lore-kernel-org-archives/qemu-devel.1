Return-Path: <SRS0=FTQm=VX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38255C76191
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 16:07:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CB8721852
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 16:07:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CB8721852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41650 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hr2kL-0002EV-8L
	for qemu-devel@archiver.kernel.org; Fri, 26 Jul 2019 12:07:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52916)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hr2kA-0001qT-9J
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 12:06:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hr2k9-0002im-2X
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 12:06:54 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43031)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hr2k5-0002a2-7m
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 12:06:50 -0400
Received: by mail-wr1-f66.google.com with SMTP id p13so54949547wru.10
 for <qemu-devel@nongnu.org>; Fri, 26 Jul 2019 09:06:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=zJp80MIjtF/+M6t+gwJWbVpXZkmatZkqR+o4H07SCAQ=;
 b=i6Maha50IYSvk+d19OpQFHgQrxM1T6PutuL2SMn8QyMN1/G1OH8xoNuhrgQ0acRY1U
 0u2wDfeCkwHV7iaJghVtDsNxGbQq2utSL+Mmp4uITiewOIqg3ThQwme8WUTt6lMDF62I
 5qB+uYq/h+WPx8v+q4FXowj1uJQfa7wwtYm89rtxX41aI/OgT6Whh2Z+CTl4Azlej+Jh
 f65BVbr82Yu6A+ZK9N03MXYgrk4P0DhgEtFJySP7MCQqGGbh5wHzty2U8wjD1iDgKu+y
 c86331vIFwm9mn1SNnw4OKyw4My5h7jRaJIlJfNiizsQHVL9gCMB9RyzBDz9BB3Jexxf
 +fvA==
X-Gm-Message-State: APjAAAVLvAb1Ew2Bwh+8VY8wjejj0X8rvf6bMvUopFIwWtsyJPLLbiya
 yil/lVuHM1MbmHNapfdLfZkAEw==
X-Google-Smtp-Source: APXvYqz2OX72weLI8cUBss4JAcmKZjHVMsbe7L9x8Eakb7T072r308NXOIzlyPrWreuUS7Doo/EUvA==
X-Received: by 2002:adf:a344:: with SMTP id d4mr26587106wrb.237.1564157206189; 
 Fri, 26 Jul 2019 09:06:46 -0700 (PDT)
Received: from [192.168.1.37] (190.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.190])
 by smtp.gmail.com with ESMTPSA id e7sm48724309wmd.0.2019.07.26.09.06.45
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Fri, 26 Jul 2019 09:06:45 -0700 (PDT)
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20190726120542.9894-1-armbru@redhat.com>
 <20190726120542.9894-5-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <9f0af600-736c-2f6b-9aa8-1113f9fdf02a@redhat.com>
Date: Fri, 26 Jul 2019 18:06:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190726120542.9894-5-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.66
Subject: Re: [Qemu-devel] [PATCH 04/28] memory: Fix type of
 IOMMUMemoryRegionClass member @parent_class
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
Cc: Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/26/19 2:05 PM, Markus Armbruster wrote:
> TYPE_IOMMU_MEMORY_REGION is a direct subtype of TYPE_MEMORY_REGION.
> Its instance struct is IOMMUMemoryRegion, and its first member is a
> MemoryRegion.  Correct.  Its class struct is IOMMUMemoryRegionClass,
> and its first member is a DeviceClass.  Wrong.  Messed up when commit
> 1221a474676 introduced the QOM type.  It even included hw/qdev-core.h
> just for that.
> 
> TYPE_MEMORY_REGION doesn't bother to define a class struct.  This is
> fine, it simply defaults to its super-type TYPE_OBJECT's class struct
> ObjectClass.  Changing IOMMUMemoryRegionClass's first member's type to
> ObjectClass would be a minimal fix, if a bit brittle: if
> TYPE_MEMORY_REGION ever acquired own class struct, we'd have to update
> IOMMUMemoryRegionClass to use it.
> 
> Fix it the clean and robust way instead: give TYPE_MEMORY_REGION its
> own class struct MemoryRegionClass now, and use it for
> IOMMUMemoryRegionClass's first member.
> 
> Revert the include of hw/qdev-core.h, and fix the few files that have
> come to rely on it.
> 
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  hw/display/vga-isa-mm.c | 1 +
>  hw/net/pcnet.h          | 1 +
>  include/exec/memory.h   | 9 +++++++--
>  memory.c                | 1 +
>  4 files changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/display/vga-isa-mm.c b/hw/display/vga-isa-mm.c
> index 215e649719..a790f69b6d 100644
> --- a/hw/display/vga-isa-mm.c
> +++ b/hw/display/vga-isa-mm.c
> @@ -22,6 +22,7 @@
>   * THE SOFTWARE.
>   */
>  #include "qemu/osdep.h"
> +#include "qemu/bitops.h"
>  #include "qemu/units.h"
>  #include "hw/hw.h"
>  #include "hw/display/vga.h"
> diff --git a/hw/net/pcnet.h b/hw/net/pcnet.h
> index 40831a7845..28d19a5c6f 100644
> --- a/hw/net/pcnet.h
> +++ b/hw/net/pcnet.h
> @@ -8,6 +8,7 @@
>  #define PCNET_LOOPTEST_NOCRC	2
>  
>  #include "exec/memory.h"
> +#include "hw/irq.h"
>  
>  /* BUS CONFIGURATION REGISTERS */
>  #define BCR_MSRDA    0
> diff --git a/include/exec/memory.h b/include/exec/memory.h
> index bb0961ddb9..238370a2ff 100644
> --- a/include/exec/memory.h
> +++ b/include/exec/memory.h
> @@ -25,7 +25,6 @@
>  #include "qemu/notify.h"
>  #include "qom/object.h"
>  #include "qemu/rcu.h"
> -#include "hw/qdev-core.h"
>  
>  #define RAM_ADDR_INVALID (~(ram_addr_t)0)
>  
> @@ -205,6 +204,12 @@ struct MemoryRegionOps {
>      } impl;
>  };
>  
> +typedef struct MemoryRegionClass {
> +    /* private */
> +    ObjectClass parent_class;
> +} MemoryRegionClass;
> +
> +
>  enum IOMMUMemoryRegionAttr {
>      IOMMU_ATTR_SPAPR_TCE_FD
>  };
> @@ -237,7 +242,7 @@ enum IOMMUMemoryRegionAttr {
>   */
>  typedef struct IOMMUMemoryRegionClass {
>      /* private */
> -    struct DeviceClass parent_class;
> +    MemoryRegionClass parent_class;
>  
>      /*
>       * Return a TLB entry that contains a given address.
> diff --git a/memory.c b/memory.c
> index d4579bbaec..bf108b596e 100644
> --- a/memory.c
> +++ b/memory.c
> @@ -3223,6 +3223,7 @@ void memory_region_init_rom_device(MemoryRegion *mr,
>  static const TypeInfo memory_region_info = {
>      .parent             = TYPE_OBJECT,
>      .name               = TYPE_MEMORY_REGION,
> +    .class_size         = sizeof(MemoryRegionClass),
>      .instance_size      = sizeof(MemoryRegion),
>      .instance_init      = memory_region_initfn,
>      .instance_finalize  = memory_region_finalize,
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

