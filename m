Return-Path: <SRS0=e4Up=WP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEF0CC3A59B
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 08:25:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9075A2082C
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 08:25:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9075A2082C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46306 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzcyb-0001VY-P1
	for qemu-devel@archiver.kernel.org; Mon, 19 Aug 2019 04:25:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46072)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1hzcxy-0000zk-Bb
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 04:24:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1hzcxw-0005au-VY
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 04:24:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:19312)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1hzcxw-0005aQ-NS
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 04:24:36 -0400
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E2EBF3CA21
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2019 08:24:35 +0000 (UTC)
Received: by mail-pf1-f200.google.com with SMTP id r130so2062619pfc.0
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2019 01:24:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=V8Qq6gIj/7UHNtF3Q/nrDQz402eJnQlcpzE+48iOFgs=;
 b=t48C0MHPFY37VRturSEPDhEr+KgA+DCRhJ8jsNh5ub1Dh1wUvgE2G/xIh7caUhYGc4
 lhUaNhpcFQe83lA0sVnq7N2RsIFT6XXkWdGzZOHSa3vVnrldRmNm3yFB5plHMJiTQMAx
 AljZr61dO9ufa/rJ6SeA4oXmO2mOa2r5NQeajjYXIDwL3oBM41vmJDtsfT+2nuaThTF2
 P4+i2b56dZoNN4DDAedbjbaWq1e+HmAJ1WF5Fby2ET8aJT5FoHGHXB4HcDEoDnL02zmN
 IaF98goAO+ecT3eJGl+gscuMJF4/SaQ0bi6C2ZNaSrBTh5ys9Uoknto/i1eAYNYtnrav
 F+Qw==
X-Gm-Message-State: APjAAAWhA5MWCPewjXSMdrHvZmySk/0SD6XZPWxtrMMah5SdWnc6ckIw
 OPcYuBOPhddzXOQ5Lkbo/add7c3PTRX+94NPSjhGJVnUMcKye8DDVqZvDij8JsJE8ISGrrVpMEh
 FunLzG3TzBPL80zU=
X-Received: by 2002:a63:221f:: with SMTP id i31mr19194646pgi.251.1566203075340; 
 Mon, 19 Aug 2019 01:24:35 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyh/Bmh+mw5AoOXm8i9cZ4p+ZihA7kT2RLpoc7gDgK9w9qspecm3LHXn97N9Vm3lpgNihaU+g==
X-Received: by 2002:a63:221f:: with SMTP id i31mr19194625pgi.251.1566203075064; 
 Mon, 19 Aug 2019 01:24:35 -0700 (PDT)
Received: from xz-x1 ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id 136sm20597897pfz.123.2019.08.19.01.24.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Aug 2019 01:24:34 -0700 (PDT)
Date: Mon, 19 Aug 2019 16:24:24 +0800
From: Peter Xu <peterx@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Message-ID: <20190819082424.GB13560@xz-x1>
References: <20190730172137.23114-1-eric.auger@redhat.com>
 <20190730172137.23114-10-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190730172137.23114-10-eric.auger@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH for-4.2 v10 09/15] virtio-iommu: Implement
 translate
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
Cc: peter.maydell@linaro.org, kevin.tian@intel.com, mst@redhat.com,
 tn@semihalf.com, qemu-devel@nongnu.org, alex.williamson@redhat.com,
 qemu-arm@nongnu.org, jean-philippe@linaro.org, bharat.bhushan@nxp.com,
 eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jul 30, 2019 at 07:21:31PM +0200, Eric Auger wrote:
> @@ -464,19 +464,75 @@ static IOMMUTLBEntry virtio_iommu_translate(IOMMUMemoryRegion *mr, hwaddr addr,
>                                              int iommu_idx)
>  {
>      IOMMUDevice *sdev = container_of(mr, IOMMUDevice, iommu_mr);
> +    VirtIOIOMMU *s = sdev->viommu;
>      uint32_t sid;
> +    viommu_endpoint *ep;
> +    viommu_mapping *mapping;
> +    viommu_interval interval;
> +    bool bypass_allowed;
> +
> +    interval.low = addr;
> +    interval.high = addr + 1;
>  
>      IOMMUTLBEntry entry = {
>          .target_as = &address_space_memory,
>          .iova = addr,
>          .translated_addr = addr,
> -        .addr_mask = ~(hwaddr)0,
> +        .addr_mask = (1 << ctz32(s->config.page_size_mask)) - 1,
>          .perm = IOMMU_NONE,
>      };
>  
> +    bypass_allowed = virtio_has_feature(s->acked_features,
> +                                        VIRTIO_IOMMU_F_BYPASS);
> +
>      sid = virtio_iommu_get_sid(sdev);
>  
>      trace_virtio_iommu_translate(mr->parent_obj.name, sid, addr, flag);
> +    qemu_mutex_lock(&s->mutex);
> +
> +    ep = g_tree_lookup(s->endpoints, GUINT_TO_POINTER(sid));
> +    if (!ep) {
> +        if (!bypass_allowed) {
> +            error_report("%s sid=%d is not known!!", __func__, sid);

Maybe use error_report_once() to avoid DOS attack?  Also would it be
good to unify the debug prints?  I see both error_report() and
qemu_log_mask() are used in the whole patchset.  Or is that attempted?

> +        } else {
> +            entry.perm = flag;
> +        }
> +        goto unlock;
> +    }
> +
> +    if (!ep->domain) {
> +        if (!bypass_allowed) {
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                          "%s %02x:%02x.%01x not attached to any domain\n",
> +                          __func__, PCI_BUS_NUM(sid),
> +                          PCI_SLOT(sid), PCI_FUNC(sid));
> +        } else {
> +            entry.perm = flag;
> +        }
> +        goto unlock;
> +    }
> +
> +    mapping = g_tree_lookup(ep->domain->mappings, (gpointer)(&interval));
> +    if (!mapping) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s no mapping for 0x%"PRIx64" for sid=%d\n",
> +                      __func__, addr, sid);
> +        goto unlock;
> +    }
> +
> +    if (((flag & IOMMU_RO) && !(mapping->flags & VIRTIO_IOMMU_MAP_F_READ)) ||
> +        ((flag & IOMMU_WO) && !(mapping->flags & VIRTIO_IOMMU_MAP_F_WRITE))) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "Permission error on 0x%"PRIx64"(%d): allowed=%d\n",
> +                      addr, flag, mapping->flags);
> +        goto unlock;
> +    }
> +    entry.translated_addr = addr - mapping->virt_addr + mapping->phys_addr;
> +    entry.perm = flag;
> +    trace_virtio_iommu_translate_out(addr, entry.translated_addr, sid);
> +
> +unlock:
> +    qemu_mutex_unlock(&s->mutex);
>      return entry;
>  }
>  
> -- 
> 2.20.1
> 

Regards,

-- 
Peter Xu

