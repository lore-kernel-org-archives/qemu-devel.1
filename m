Return-Path: <SRS0=9x1+=D5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63DD9C55179
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 16:44:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0EFF22267
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 16:44:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L21vttSz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0EFF22267
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50778 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVdh3-0005ap-PC
	for qemu-devel@archiver.kernel.org; Thu, 22 Oct 2020 12:44:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57250)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1kVdfA-0003qy-24
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 12:42:04 -0400
Received: from mail-ej1-x643.google.com ([2a00:1450:4864:20::643]:42746)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1kVdf5-0006v0-6F
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 12:42:03 -0400
Received: by mail-ej1-x643.google.com with SMTP id h24so3238955ejg.9
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2020 09:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=e8Q+b+DQpGDx9jLTMEX7U+5d3ur3f5M/g5L9+KehmHE=;
 b=L21vttSz+KFCHDEexIh+QoeuWN+tD6emoZYdvSsubkDaZVaQig+dzz/9OYbLod1C3I
 V0rbiQsmIF4xQoC63Wr700Z7tAJt5z2WeEJl+DIerBUM+cLPCufmchWLSODyjHQ9X7jR
 LhA4riK4xrr4m84jK881Q/fVLl0SsHP70W89YF4u4Sqj5TkjoEvRGuxtPEQtel95Jup7
 7Td4eOcDFom04dOLehLmooqYCaEyZlN2weMVZdIk6/KNOsl4+Co3mJAOZKtkxxsmJzyD
 oCxRo9tOHPieVys+6pcJemf7JAukbx2pGsjF82XBYYVpVgpTFU5p+xg5xDwOT0tGv+o9
 pJTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=e8Q+b+DQpGDx9jLTMEX7U+5d3ur3f5M/g5L9+KehmHE=;
 b=NASvkFkuKmi0DBNWiVnX0SbujDhJ8xuQ3Xek3yqStN+d/CJk2jpO0tzEEo8gFLUi6O
 LX1gnvAcvfVtXgEleFUJQNoMbPWkjd3fKGxBxeMtWS/MTocxR4X1BqlixowlVks+J/5N
 N2RBwzQbkAibNi2KZYyzmP4lJfLarihNKHoNmschG0i6M0SQsh3asXuJup332/zR9tJl
 asCEhqXWuXanQ7gkXb4JMDGOg6MtXNx/T5hXqCOuifBoQjUgYYLM4bToC8uRi4XagBwr
 lRRol9L6E+IJWHtBUE/ChQYovgLS4tXKudWpvhW/PeuZGWyrC6/T4p3q/tZpFlHpDOxz
 kBxw==
X-Gm-Message-State: AOAM531EDx/RdEjacPtvxyP9HSRLuC/om1p2APDeGdUBO3ipFYWImc1W
 R1MhJeyvm+em2Sq4RDgtyntDwA==
X-Google-Smtp-Source: ABdhPJxKTFdtwGPwd/Osoe7cqVy0Qop1yYNeM46jkU58iGEyiOmEt0x2yuCXgDmQ4ZB6wHYFd2NaeQ==
X-Received: by 2002:a17:906:444:: with SMTP id
 e4mr3369665eja.218.1603384914687; 
 Thu, 22 Oct 2020 09:41:54 -0700 (PDT)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id s12sm1150881ejy.25.2020.10.22.09.41.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2020 09:41:53 -0700 (PDT)
Date: Thu, 22 Oct 2020 18:41:34 +0200
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Auger Eric <eric.auger@redhat.com>
Subject: Re: [PATCH v10 03/10] virtio-iommu: Add memory notifiers for map/unmap
Message-ID: <20201022164134.GC1808268@myrica>
References: <20201008171558.410886-1-jean-philippe@linaro.org>
 <20201008171558.410886-4-jean-philippe@linaro.org>
 <bacbb642-ba18-77b7-3776-617b0e577540@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bacbb642-ba18-77b7-3776-617b0e577540@redhat.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::643;
 envelope-from=jean-philippe@linaro.org; helo=mail-ej1-x643.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: mst@redhat.com, qemu-devel@nongnu.org, peterx@redhat.com,
 alex.williamson@redhat.com, pbonzini@redhat.com, bbhushan2@marvell.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Oct 16, 2020 at 09:58:28AM +0200, Auger Eric wrote:
> > +static void virtio_iommu_notify_map(IOMMUMemoryRegion *mr, hwaddr virt_start,
> > +                                    hwaddr virt_end, hwaddr paddr)
> > +{
> > +    IOMMUTLBEntry entry;
> > +    IOMMUNotifierFlag flags = mr->iommu_notify_flags;
> > +
> > +    if (!(flags & IOMMU_NOTIFIER_MAP)) {
> > +        return;
> > +    }
> > +
> > +    trace_virtio_iommu_notify_map(mr->parent_obj.name, virt_start, virt_end,
> > +                                  paddr);
> > +
> > +    entry.target_as = &address_space_memory;
> > +    entry.addr_mask = virt_end - virt_start;
> > +    entry.iova = virt_start;
> > +    entry.perm = IOMMU_RW;
> logically you should be able to cascade the struct virtio_iommu_req_map
> *req flags field instead.

Agreed.

I'm also thinking of adding a check for VIRTIO_IOMMU_MAP_F_MMIO, to avoid
going further into the notifier and maybe do the same for unmap.

Thanks,
Jean


