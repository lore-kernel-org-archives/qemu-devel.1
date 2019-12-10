Return-Path: <SRS0=2P1T=2A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12441C43603
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 16:45:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0E1C2073D
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 16:45:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Aonj25m5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0E1C2073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59054 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieidF-0003W9-BL
	for qemu-devel@archiver.kernel.org; Tue, 10 Dec 2019 11:45:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58635)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jean-philippe@linaro.org>) id 1ieibo-0002Df-2P
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 11:43:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jean-philippe@linaro.org>) id 1ieibn-00042L-0L
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 11:43:35 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:44377)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jean-philippe@linaro.org>)
 id 1ieibm-000427-QC
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 11:43:34 -0500
Received: by mail-wr1-x441.google.com with SMTP id q10so20870086wrm.11
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2019 08:43:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=WtaxfLDwEq+CPxRUbY/7JAvtoC2bGMlKZ7QdRWbKMnU=;
 b=Aonj25m5O3NG/3YcvFJ7MZMjqL8o4JwlSte53sfRkiPZx+v23ru9AtaLADs4js3iGV
 4MX7HKiQdzzpyYebZIgbHCkIvBrbNiObRbVj6g4cpmsqKvcJCFozuI+bTaMM+M4ZnrfH
 josRRWe4AelRKAVFN5Clv420QFrxzvr5TiXC/Ab8FR/Pnx0URxdbC0cAKMKSnXmSWmcN
 zrrDeMQuXCsJpGxf0P9buODS3QUfo+E7YRMIaLzUNrTBs626ZMqcU8fmzfN+qO52JRHw
 7htGYPYi+5gv3Tuw9edHiSG5EjX9lvBn+dhg6ZtHzZmB/TnA5P5g4cTFnH5R/lMyvjYY
 W7mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=WtaxfLDwEq+CPxRUbY/7JAvtoC2bGMlKZ7QdRWbKMnU=;
 b=NptKKTUfPo/jjpBCX4IEY8JJ4A3WazKGnCk0POeBchnH3PvZmR8FnotqwLX6UzghVD
 kBkCXC/McPdC4B/YPDDFXEYF6uFZSEfw4gHYpOHgzQ6/CnIqMfSMdgNji5NryviuFwEW
 Gjy25hnSzAeMYReqq1VhThdJm5i4lN2mshcSnoDYr2rV1RaRwe9eIqy4Qvsj3jGeeoWM
 YmfFUDMhVj/dMGULQkiGVR28IlUs7S7Us5EHv9d2fkqA5DGHv5ueliJ5W3EjCWSDJHCe
 wyRJQ0ZO6J3PQMBZcatDiv6MgNOlpjI13ClOHCZIEo5JkuQC/LgVT3pgVAO7fWN6DZ1A
 lkAQ==
X-Gm-Message-State: APjAAAWgNlIZZKgi00I8LGIFK6QNZZUOAvCE23R3v6hNYHWxaDElvLUS
 1B1TEzEoQ4jtVeFUKHbseqwXBg==
X-Google-Smtp-Source: APXvYqyPt+8Jwb4gmCEufCkJ6i1T6iyNXkzmBu7FhNUtTYJ2P6ft4BOk8HS6kvcWauPXhDluGd9hOw==
X-Received: by 2002:a5d:6ac5:: with SMTP id u5mr4284808wrw.271.1575996213730; 
 Tue, 10 Dec 2019 08:43:33 -0800 (PST)
Received: from myrica (adsl-84-227-176-239.adslplus.ch. [84.227.176.239])
 by smtp.gmail.com with ESMTPSA id n14sm3689719wmi.26.2019.12.10.08.43.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Dec 2019 08:43:33 -0800 (PST)
Date: Tue, 10 Dec 2019 17:43:28 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH for-5.0 v11 07/20] virtio-iommu: Implement map/unmap
Message-ID: <20191210164328.GF277340@myrica>
References: <20191122182943.4656-1-eric.auger@redhat.com>
 <20191122182943.4656-8-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191122182943.4656-8-eric.auger@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
Cc: yang.zhong@intel.com, peter.maydell@linaro.org, kevin.tian@intel.com,
 tnowicki@marvell.com, mst@redhat.com, jean-philippe.brucker@arm.com,
 quintela@redhat.com, qemu-devel@nongnu.org, peterx@redhat.com,
 armbru@redhat.com, bharatb.linux@gmail.com, qemu-arm@nongnu.org,
 dgilbert@redhat.com, eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Nov 22, 2019 at 07:29:30PM +0100, Eric Auger wrote:
> @@ -238,10 +244,35 @@ static int virtio_iommu_map(VirtIOIOMMU *s,
>      uint64_t virt_start = le64_to_cpu(req->virt_start);
>      uint64_t virt_end = le64_to_cpu(req->virt_end);
>      uint32_t flags = le32_to_cpu(req->flags);
> +    viommu_domain *domain;
> +    viommu_interval *interval;
> +    viommu_mapping *mapping;

Additional checks would be good. Most importantly we need to return
S_INVAL if we don't recognize a bit in flags (a MUST in the spec). It
might be good to check that addresses are aligned on the page granule as
well, and return S_RANGE if they aren't (a SHOULD in the spec), but I
don't care as much.

> +
> +    interval = g_malloc0(sizeof(*interval));
> +
> +    interval->low = virt_start;
> +    interval->high = virt_end;
> +
> +    domain = g_tree_lookup(s->domains, GUINT_TO_POINTER(domain_id));
> +    if (!domain) {
> +        return VIRTIO_IOMMU_S_NOENT;

Leaks interval, I guess you could allocate it after this block.

Thanks,
Jean

> +    }
> +
> +    mapping = g_tree_lookup(domain->mappings, (gpointer)interval);
> +    if (mapping) {
> +        g_free(interval);
> +        return VIRTIO_IOMMU_S_INVAL;
> +    }
>  
>      trace_virtio_iommu_map(domain_id, virt_start, virt_end, phys_start, flags);
>  
> -    return VIRTIO_IOMMU_S_UNSUPP;
> +    mapping = g_malloc0(sizeof(*mapping));
> +    mapping->phys_addr = phys_start;
> +    mapping->flags = flags;
> +
> +    g_tree_insert(domain->mappings, interval, mapping);
> +
> +    return VIRTIO_IOMMU_S_OK;

