Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F3F1C433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 10:47:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03756206F0
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 10:47:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DD2GlYQN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03756206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40302 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kChLg-0003tE-1v
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 06:47:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42956)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kChKn-00033j-Fg
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 06:46:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57062)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kChKk-0006D3-DO
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 06:46:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598870799;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WggWi+voPbZe+Rd1hOnadW9OVt+clz+6b359Lf5wcUA=;
 b=DD2GlYQNxDSyclvbBKmX3Ty6niPySJx5HqlQYsvfM654FHJDjU727fB4UeTnwmezR1dJim
 aMI1KNPLvraaveCuVPFA+8NR329isn4xmRa3lNNrGtIjFpCop3W3D4nDL3o+2rdGne3Mvn
 AnsBYwaGidS4KhLHDvljY4rSFYtKW7Y=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-545-7cg6vo8SNEGnsbfy4c9K9Q-1; Mon, 31 Aug 2020 06:46:38 -0400
X-MC-Unique: 7cg6vo8SNEGnsbfy4c9K9Q-1
Received: by mail-wr1-f72.google.com with SMTP id z1so3051312wrn.18
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2020 03:46:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=WggWi+voPbZe+Rd1hOnadW9OVt+clz+6b359Lf5wcUA=;
 b=MuWP7mK+lGWyAmtdi2DYe9BB93jIRMPCl81t302RkFiCWQY6ZJ1vKhg8LpVRmoZzWD
 og9vo+5FugDb7REhjWmmoHqMlnN2cP4CdlUyvmk+BF3nXEvbqSaOFuoy4AI/4JyKIAv4
 11Ixox3B8JtynO2DL4v9O8G2/0G6uSU1RiDu8tn2uCsiLkQZxw0UFZIYZvwfFxvxjXJ2
 xchCS41YAGZj7Z3nBp/YJM9LYl8KhW1T1Td/OrRu5Ta2IhCY8GXvqyj6LAxaVI/zs9n7
 AoEOmzH2z9TUoPKrpYxts+uR9WGv97qfTcDGriNfrzXPTxq1x3/zyAoKmO1mKisYgmD0
 RpNA==
X-Gm-Message-State: AOAM532PkCsCbGtVp/pkjfj9W9vqJ0KvvPbIOx82P4gz1NCXqduee7+k
 6MVfEtK+etYeXNtHKErIdPfPJ6HWIzeNcsKkLi7ecRU4GvFWLZpOaUsfCVIozsYnxiTsGqA+SzC
 F1a7oIKVp0PSUm7w=
X-Received: by 2002:adf:a1d6:: with SMTP id v22mr1095686wrv.185.1598870797153; 
 Mon, 31 Aug 2020 03:46:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzD7C4exS0K84INqFc8PwVw9sMNfyOD7vCLFEBFJ+J1ZPIdUTrB2jMZZvhQybSG4EIprKSfaw==
X-Received: by 2002:adf:a1d6:: with SMTP id v22mr1095658wrv.185.1598870796956; 
 Mon, 31 Aug 2020 03:46:36 -0700 (PDT)
Received: from redhat.com (bzq-109-66-64-75.red.bezeqint.net. [109.66.64.75])
 by smtp.gmail.com with ESMTPSA id
 q8sm11607586wrx.79.2020.08.31.03.46.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2020 03:46:36 -0700 (PDT)
Date: Mon, 31 Aug 2020 06:46:32 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Chen Qun <kuhn.chenqun@huawei.com>
Subject: Re: [PATCH 01/11] hw/arm/virt-acpi-build:Remove dead assignment in
 build_madt()
Message-ID: <20200831064614-mutt-send-email-mst@kernel.org>
References: <20200813073712.4001404-1-kuhn.chenqun@huawei.com>
 <20200813073712.4001404-2-kuhn.chenqun@huawei.com>
MIME-Version: 1.0
In-Reply-To: <20200813073712.4001404-2-kuhn.chenqun@huawei.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/31 03:43:46
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>, zhang.zhanghailiang@huawei.com,
 qemu-trivial@nongnu.org, pannengyuan@huawei.com, qemu-devel@nongnu.org,
 Shannon Zhao <shannon.zhaosl@gmail.com>, qemu-arm@nongnu.org,
 Euler Robot <euler.robot@huawei.com>, Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Aug 13, 2020 at 03:37:02PM +0800, Chen Qun wrote:
> Clang static code analyzer show warning:
> hw/arm/virt-acpi-build.c:641:5: warning: Value stored to 'madt' is never read
>     madt = acpi_data_push(table_data, sizeof *madt);
>     ^      ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Reported-by: Euler Robot <euler.robot@huawei.com>
> Signed-off-by: Chen Qun <kuhn.chenqun@huawei.com>

Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

feel free to merge through the trivial tree.

> ---
> Cc: Shannon Zhao <shannon.zhaosl@gmail.com>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Igor Mammedov <imammedo@redhat.com>
> Cc: qemu-arm@nongnu.org
> ---
>  hw/arm/virt-acpi-build.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index 91f0df7b13..f830f9b779 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -633,12 +633,11 @@ build_madt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>      int madt_start = table_data->len;
>      const MemMapEntry *memmap = vms->memmap;
>      const int *irqmap = vms->irqmap;
> -    AcpiMultipleApicTable *madt;
>      AcpiMadtGenericDistributor *gicd;
>      AcpiMadtGenericMsiFrame *gic_msi;
>      int i;
>  
> -    madt = acpi_data_push(table_data, sizeof *madt);
> +    acpi_data_push(table_data, sizeof(AcpiMultipleApicTable));
>  
>      gicd = acpi_data_push(table_data, sizeof *gicd);
>      gicd->type = ACPI_APIC_GENERIC_DISTRIBUTOR;
> -- 
> 2.23.0


