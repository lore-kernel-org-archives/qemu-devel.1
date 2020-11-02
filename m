Return-Path: <SRS0=N3Ri=EI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FFA0C00A89
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 22:49:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7AE2822280
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 22:49:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S/EYYqko"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AE2822280
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49502 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZidk-0001Qt-K5
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 17:49:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47400)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1kZibv-0000Wg-Vm
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 17:47:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:21326)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1kZibs-0005S0-UF
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 17:47:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604357250;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Jc9ciWgIUZhrFLDgLlchIjIo04Cy6lJvrxwb8GBwFzc=;
 b=S/EYYqkokGXbjNvmPAe0HPzQXZVa+anNcenvM3828TwR20GaB/nVh8OIgxvvlGo4EqgekJ
 3rW4pnkdikr0eMAyIkkFfzy/2O5wJznhRAjIQIXD35FNyEX6EGUlgKX7wiWckcEXgw5Dfu
 te3EBOuAS+5Z3P9hWsTT2Ah4xwJ6L2o=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-576-woO7lxqkO_2ppOxL-SAVdA-1; Mon, 02 Nov 2020 17:47:28 -0500
X-MC-Unique: woO7lxqkO_2ppOxL-SAVdA-1
Received: by mail-qv1-f72.google.com with SMTP id b13so9272804qvz.2
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2020 14:47:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Jc9ciWgIUZhrFLDgLlchIjIo04Cy6lJvrxwb8GBwFzc=;
 b=IHxysVpUKoXZnxmMMg3RNyYhURkBZeE+EdJcvzXiMeAj8sAtXFT/tw+lbkkALG4Dla
 mb1FWQJHtLlwHqwSp7c5+z1cWAC4oP4/jhEO6dl3gVPSTgeTSfqe89YCLordqYvfGzMd
 O3YmL1B5IPxsyJRlO3ItWnBBtrQ3FxXJav7R/oOc9GtWl631EXsC/PIWwZP8qx4L65m7
 HrDuM0IOj3L8auLlqB80BulIOUtsKegG4DvqCDM0V2omwHyoMEnfRmMiftFIicMWx/71
 GFH/PmApPOqJY3fUn2BXSl3YunC13DQp9WrOOJP826lwQYiWQ0h2be1MXS+BEIrF+B1O
 y0Cg==
X-Gm-Message-State: AOAM530YNzhU94qon9v7FhHHZVRoNn4dE2CBIJAJmMvXMvZtHO6UAeH2
 I0oiZtE4kQ9EwvlKRjw/ZFsNiPeEtqa+MaB0OGcWsyM8EvQFi0e4e8mNE15LEGisEdmTaedoiFd
 Kby7XopzKt0G+wyU=
X-Received: by 2002:ac8:2ab4:: with SMTP id b49mr5978017qta.20.1604357248070; 
 Mon, 02 Nov 2020 14:47:28 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw0JitK39J7EK/jiPi/PSbhtyaxCXnNUu9OFtbb8sUR6BGOPS6iuJRS2kvFfxCTWWH2Ovps8w==
X-Received: by 2002:ac8:2ab4:: with SMTP id b49mr5977998qta.20.1604357247842; 
 Mon, 02 Nov 2020 14:47:27 -0800 (PST)
Received: from xz-x1
 (bras-vprn-toroon474qw-lp130-20-174-93-89-196.dsl.bell.ca. [174.93.89.196])
 by smtp.gmail.com with ESMTPSA id p5sm9148994qtu.13.2020.11.02.14.47.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2020 14:47:27 -0800 (PST)
Date: Mon, 2 Nov 2020 17:47:25 -0500
From: Peter Xu <peterx@redhat.com>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH v11 09/10] virtio-iommu: Set supported page size mask
Message-ID: <20201102224725.GF20600@xz-x1>
References: <20201030180510.747225-1-jean-philippe@linaro.org>
 <20201030180510.747225-10-jean-philippe@linaro.org>
MIME-Version: 1.0
In-Reply-To: <20201030180510.747225-10-jean-philippe@linaro.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=peterx@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/02 17:47:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: mst@redhat.com, qemu-devel@nongnu.org, eric.auger@redhat.com,
 alex.williamson@redhat.com, pbonzini@redhat.com, bbhushan2@marvell.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Oct 30, 2020 at 07:05:09PM +0100, Jean-Philippe Brucker wrote:
> From: Bharat Bhushan <bbhushan2@marvell.com>
> 
> The virtio-iommu device can deal with arbitrary page sizes for virtual
> endpoints, but for endpoints assigned with VFIO it must follow the page
> granule used by the host IOMMU driver.
> 
> Implement the interface to set the vIOMMU page size mask, called by VFIO
> for each endpoint. We assume that all host IOMMU drivers use the same
> page granule (the host page granule). Override the page_size_mask field
> in the virtio config space.

(Nit: Seems slightly mismatched with the code below)

[...]

> +    /*
> +     * After the machine is finalized, we can't change the mask anymore. If by
> +     * chance the hotplugged device supports the same granule, we can still
> +     * accept it. Having a different masks is possible but the guest will use
> +     * sub-optimal block sizes, so warn about it.
> +     */
> +    if (qdev_hotplug) {
> +        int new_granule = ctz64(new_mask);
> +        int cur_granule = ctz64(cur_mask);
> +
> +        if (new_granule != cur_granule) {
> +            error_setg(errp, "virtio-iommu page mask 0x%"PRIx64
> +                       " is incompatible with mask 0x%"PRIx64, cur_mask,
> +                       new_mask);
> +            return -1;
> +        } else if (new_mask != cur_mask) {
> +            warn_report("virtio-iommu page mask 0x%"PRIx64
> +                        " does not match 0x%"PRIx64, cur_mask, new_mask);

IMHO, new_mask!=cur_mask is ok, as long as it's a superset of reported
cur_mask, then it'll still guarantee to work.

Meanwhile, checking against granule seems not safe enough if the guest driver
started to use huge pages in iommu pgtables...

In summary:

    if (qdev_hotplug) {
        if ((new_mask & cur_mask) == cur_mask) {
            /* Superset of old mask; we're good.  Keep the old mask since same */
            return 0;
        } else {
            /* Guest driver can use any psize in cur_mask, not safe to continue */
            error_setg(...);
            return -1;
        }
    }

Maybe we can also work on top too (if this is the only reason to repost,
especially if Michael would like to pick this up sooner), so I just raise this
up.

Thanks,

-- 
Peter Xu


