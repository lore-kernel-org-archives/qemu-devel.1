Return-Path: <SRS0=g8gL=WD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15D35C433FF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 10:11:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E39E221E6C
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 10:11:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E39E221E6C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39366 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvIuw-00041x-6k
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 06:11:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39510)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hvIuQ-000387-Dj
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 06:11:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hvIuP-00020y-8q
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 06:11:06 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38467)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hvIuO-0001zw-WE
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 06:11:05 -0400
Received: by mail-wr1-f67.google.com with SMTP id g17so90743449wrr.5
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2019 03:11:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=fV4g7mbDZHsCPADbAoRhrxSei5JcIFUCEAuLE1zzvlc=;
 b=TK5O0JyQH06vkEhFKxzqnp0WK/li+G5piKRBsr5OLNh1kGXYCJIrl6O8j5jysSNWsg
 7TvGUY0CeLM7WZeOYksTSoh67LkJs987N0ogrkV/In9dMVVzoMA9qyfFPQYoP/oKSgr9
 +7C9s+QRtxWfilddpYdyTJnGXEh1ftOXWWG22JRysIx3/8cIcpyTiUzuQYG8Rtx4bvEA
 Wb0kcqXGDBnksXMzkNw6yNTjHWpq9CPYf+msBv7bDOhaTapVttj6QSzy1hD56vdUKNrL
 xR5a738Y2gYhdDLP/JG2Avzp2EHzywZhxWGD57l+UkgcHlEm9Lq+6mEXkTqsJYgQTMhA
 NjYw==
X-Gm-Message-State: APjAAAV//XqtYFUvO4amhXKkhz9DkIUo45Nbt7CkGVHYYoQcOEzyfss4
 S+MpMG0f9HWHtWU4QvHhYZ2+SA==
X-Google-Smtp-Source: APXvYqzzpQEp0qvvhGOadsl6h0hTGq93+xWZf7bQl9Aktl2k6WEDZ0gR71M34BLURSH+55hqA03GLQ==
X-Received: by 2002:adf:de10:: with SMTP id b16mr9448205wrm.296.1565172663957; 
 Wed, 07 Aug 2019 03:11:03 -0700 (PDT)
Received: from [192.168.1.39] (214.red-83-51-160.dynamicip.rima-tde.net.
 [83.51.160.214])
 by smtp.gmail.com with ESMTPSA id y12sm65839909wru.30.2019.08.07.03.11.03
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Wed, 07 Aug 2019 03:11:03 -0700 (PDT)
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20190806151435.10740-1-armbru@redhat.com>
 <20190806151435.10740-5-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <4c43b5ba-4204-6a28-d3f1-348d8d25c6d5@redhat.com>
Date: Wed, 7 Aug 2019 12:11:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190806151435.10740-5-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.67
Subject: Re: [Qemu-devel] [PATCH v2 04/29] memory: Fix type of
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

On 8/6/19 5:14 PM, Markus Armbruster wrote:
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
> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

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
> index 5d8c9a9234..09d9b254fd 100644
> --- a/memory.c
> +++ b/memory.c
> @@ -3245,6 +3245,7 @@ void memory_region_init_rom_device(MemoryRegion *mr,
>  static const TypeInfo memory_region_info = {
>      .parent             = TYPE_OBJECT,
>      .name               = TYPE_MEMORY_REGION,
> +    .class_size         = sizeof(MemoryRegionClass),
>      .instance_size      = sizeof(MemoryRegion),
>      .instance_init      = memory_region_initfn,
>      .instance_finalize  = memory_region_finalize,
> 

