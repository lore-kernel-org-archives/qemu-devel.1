Return-Path: <SRS0=V8KP=YZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DAD9CA9ECF
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2019 14:56:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 707A820650
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2019 14:56:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 707A820650
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39922 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iQYLl-0004Ab-JA
	for qemu-devel@archiver.kernel.org; Fri, 01 Nov 2019 10:56:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43919)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1iQYKa-0003BB-Ol
 for qemu-devel@nongnu.org; Fri, 01 Nov 2019 10:55:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1iQYKW-0003rn-4h
 for qemu-devel@nongnu.org; Fri, 01 Nov 2019 10:55:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39810)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1iQYKV-0003aa-Mt
 for qemu-devel@nongnu.org; Fri, 01 Nov 2019 10:55:11 -0400
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C60B2C05A1D0
 for <qemu-devel@nongnu.org>; Fri,  1 Nov 2019 14:55:07 +0000 (UTC)
Received: by mail-wr1-f71.google.com with SMTP id h4so5636311wrx.15
 for <qemu-devel@nongnu.org>; Fri, 01 Nov 2019 07:55:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=k15X9zqJVfW3oC0HT7dnDU0xGIS3I2u3p6fKi7ClOn0=;
 b=DIw0qWW7BIbuEi729OpBR2BsVcVsMeTshot016HzY182tUETAj3P7LY8+JbYGu1jbG
 Em8HJbtyUAZ16e9YFN1iTORMwrEuQGPgB2dP+udd8goRsshiZUxpC433A5O157xdwvp6
 CPSa2UC04uygdV7tI4D8pjLMDXRV0LmtCIi/wKLqqkB3JL6BfI3ehfPX6f8/ZMHcglG/
 Pl6zpgj3pwumXrn0tdJGg9TZNR4+f7ep1ZHPUfuAmUbxIz1DXXX6ZQGf6mr8RMy6qCj0
 mfWAyqQTpWO0wHoBjjNSt2D/j63G8r4Jb3goIJG9PqmpnMsFscndlXbnkg+ctTHntftO
 PN4A==
X-Gm-Message-State: APjAAAXILHPlNtcZaDesOC8eIocue+t6E0iVvUKuIy2n4GR0+Skq2sIu
 8se80JaG16pe1pN/BKXjsXn7LtaIEi4UlsrPGZ39E0qG2sJjc6u2KjzwAcXKRFt0CdAw4S38ah2
 2IYEfi78Zgs7t9rk=
X-Received: by 2002:a7b:c747:: with SMTP id w7mr11206526wmk.62.1572620106484; 
 Fri, 01 Nov 2019 07:55:06 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwSAkwj4/WJI+mK4RnP3iTmSlwbqfZTGcpQ6d11+q5qMJ/2ycB4ozpO4qLetVrQ6gMGRzVoeQ==
X-Received: by 2002:a7b:c747:: with SMTP id w7mr11206506wmk.62.1572620106261; 
 Fri, 01 Nov 2019 07:55:06 -0700 (PDT)
Received: from xz-x1.metropole.lan ([91.217.168.176])
 by smtp.gmail.com with ESMTPSA id l18sm8252323wrn.48.2019.11.01.07.55.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Nov 2019 07:55:05 -0700 (PDT)
Date: Fri, 1 Nov 2019 15:55:03 +0100
From: Peter Xu <peterx@redhat.com>
To: Liu Yi L <yi.l.liu@intel.com>
Subject: Re: [RFC v2 08/22] intel_iommu: provide get_iommu_context() callback
Message-ID: <20191101145503.GB8888@xz-x1.metropole.lan>
References: <1571920483-3382-1-git-send-email-yi.l.liu@intel.com>
 <1571920483-3382-9-git-send-email-yi.l.liu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1571920483-3382-9-git-send-email-yi.l.liu@intel.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: tianyu.lan@intel.com, kevin.tian@intel.com, jacob.jun.pan@linux.intel.com,
 Yi Sun <yi.y.sun@linux.intel.com>, kvm@vger.kernel.org, mst@redhat.com,
 jun.j.tian@intel.com, qemu-devel@nongnu.org, eric.auger@redhat.com,
 alex.williamson@redhat.com, pbonzini@redhat.com, yi.y.sun@intel.com,
 david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Oct 24, 2019 at 08:34:29AM -0400, Liu Yi L wrote:
> This patch adds get_iommu_context() callback to return an iommu_context
> Intel VT-d platform.
> 
> Cc: Kevin Tian <kevin.tian@intel.com>
> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: Yi Sun <yi.y.sun@linux.intel.com>
> Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> ---
>  hw/i386/intel_iommu.c         | 57 ++++++++++++++++++++++++++++++++++++++-----
>  include/hw/i386/intel_iommu.h | 14 ++++++++++-
>  2 files changed, 64 insertions(+), 7 deletions(-)
> 
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index 67a7836..e9f8692 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -3288,22 +3288,33 @@ static const MemoryRegionOps vtd_mem_ir_ops = {
>      },
>  };
>  
> -VTDAddressSpace *vtd_find_add_as(IntelIOMMUState *s, PCIBus *bus, int devfn)
> +static VTDBus *vtd_find_add_bus(IntelIOMMUState *s, PCIBus *bus)
>  {
>      uintptr_t key = (uintptr_t)bus;
> -    VTDBus *vtd_bus = g_hash_table_lookup(s->vtd_as_by_busptr, &key);
> -    VTDAddressSpace *vtd_dev_as;
> -    char name[128];
> +    VTDBus *vtd_bus;
>  
> +    vtd_iommu_lock(s);

Why explicitly take the IOMMU lock here?  I mean, it's fine to take
it, but if so why not take it to cover the whole vtd_find_add_as()?

For now it'll be fine in either way because I believe iommu_lock is
not really functioning when we're still with BQL here, however if you
add that explicitly then I don't see why it's not covering that.

> +    vtd_bus = g_hash_table_lookup(s->vtd_as_by_busptr, &key);
>      if (!vtd_bus) {
>          uintptr_t *new_key = g_malloc(sizeof(*new_key));
>          *new_key = (uintptr_t)bus;
>          /* No corresponding free() */
> -        vtd_bus = g_malloc0(sizeof(VTDBus) + sizeof(VTDAddressSpace *) * \
> -                            PCI_DEVFN_MAX);
> +        vtd_bus = g_malloc0(sizeof(VTDBus) + PCI_DEVFN_MAX * \
> +                    (sizeof(VTDAddressSpace *) + sizeof(VTDIOMMUContext *)));

Should this be as simple as g_malloc0(sizeof(VTDBus) since [1]?

Otherwise the patch looks sane to me.

>          vtd_bus->bus = bus;
>          g_hash_table_insert(s->vtd_as_by_busptr, new_key, vtd_bus);
>      }
> +    vtd_iommu_unlock(s);
> +    return vtd_bus;
> +}

[...]

>  struct VTDBus {
>      PCIBus* bus;		/* A reference to the bus to provide translation for */
> -    VTDAddressSpace *dev_as[0];	/* A table of VTDAddressSpace objects indexed by devfn */
> +    /* A table of VTDAddressSpace objects indexed by devfn */
> +    VTDAddressSpace *dev_as[PCI_DEVFN_MAX];
> +    /* A table of VTDIOMMUContext objects indexed by devfn */
> +    VTDIOMMUContext *dev_ic[PCI_DEVFN_MAX];

[1]

>  };
>  
>  struct VTDIOTLBEntry {
> @@ -282,5 +293,6 @@ struct IntelIOMMUState {
>   * create a new one if none exists
>   */
>  VTDAddressSpace *vtd_find_add_as(IntelIOMMUState *s, PCIBus *bus, int devfn);
> +VTDIOMMUContext *vtd_find_add_ic(IntelIOMMUState *s, PCIBus *bus, int devfn);
>  
>  #endif
> -- 
> 2.7.4
> 

Regards,

-- 
Peter Xu

