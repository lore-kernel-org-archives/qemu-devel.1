Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 526E5C4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 17:06:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90C2620795
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 17:06:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FSvJjOPA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90C2620795
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37244 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kW0W1-0007iZ-Bq
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 13:06:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53250)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1kW0Df-0004i4-Ch
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 12:47:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:26040)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1kW0Dc-0003ez-NI
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 12:47:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603471626;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UrttzmvHmF79uLtAEn1jGxXIZ0AP46F13fIMggVntOs=;
 b=FSvJjOPA6OhxuhFgi/WCfDnRn/JS219haze+AjZYF4PQkVugJgBr8P/mAWdMJC0Mf2afLX
 1d0z1kGsSId1j2BZYFRLt45NPE6K0sfdfPQ3YwU5kGxfUTMdFaoVFCOUnbD8TAcp0A/XRp
 FhlInS8r8o7+ZSZHhx50qBhDNPw23Os=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-560-EGDrV68tOQCnpuciAexLbA-1; Fri, 23 Oct 2020 12:47:05 -0400
X-MC-Unique: EGDrV68tOQCnpuciAexLbA-1
Received: by mail-qv1-f72.google.com with SMTP id d41so1330185qvc.23
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2020 09:47:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=UrttzmvHmF79uLtAEn1jGxXIZ0AP46F13fIMggVntOs=;
 b=Fn0+l0ft1A4oO9MMTHTR1JjnOPWh1utxK1sLsLkCyfdf/AcB47F41pbE07QLaksfei
 TBp51gaALz8eDDcJuUvQ6h7hbszRVKxF0Zn2HAm7Wpuj+HaZr7rJ2efCo+m1LGJOZfFd
 hSDTlZwVD9cr5ZYEkJYlZIob3ZBO2Hk6JS9pk35zzzJrGF1qZ19pnCBj09YuhKhBGbYl
 diRMQMnYJdGSbcd5D0LukdsEU+96NWwtzsJhIQ/ZcuOXJOP/myelhGaYoMZYgTiyKB7q
 4oMBKVVzlVlssoXsnKXlFWO66LRbCgtFzoyiC8N/PG8Bn6qyeEk10Kzq51met2wnZ5vK
 WBVQ==
X-Gm-Message-State: AOAM532KbKtrm005VlE3HojxjXDQat6Ear/Cvmjox/L4CKdKaCHVBYod
 LAR/HDfW3uEtB86vhHclq9kUj+azWfTRHcPkOVVdoc4jUq0lriTGLi+ySUnjWa/i1XAzpdPGPJS
 M+aiVjeQDKnYy8l4=
X-Received: by 2002:a0c:9021:: with SMTP id o30mr3146909qvo.1.1603471624661;
 Fri, 23 Oct 2020 09:47:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyeaW9XBBQmxIMcxy+M3qIo4gfsRBG7hGp63DnvoQ1Tjn0HvSYn9Shv0q5AbjbIyDfPtO4b1g==
X-Received: by 2002:a0c:9021:: with SMTP id o30mr3146887qvo.1.1603471624386;
 Fri, 23 Oct 2020 09:47:04 -0700 (PDT)
Received: from xz-x1 (toroon474qw-lp140-04-174-95-215-133.dsl.bell.ca.
 [174.95.215.133])
 by smtp.gmail.com with ESMTPSA id v5sm1245968qtd.28.2020.10.23.09.47.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2020 09:47:03 -0700 (PDT)
Date: Fri, 23 Oct 2020 12:47:02 -0400
From: Peter Xu <peterx@redhat.com>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH v10 09/10] virtio-iommu: Set supported page size mask
Message-ID: <20201023164702.GF3208@xz-x1>
References: <20201008171558.410886-1-jean-philippe@linaro.org>
 <20201008171558.410886-10-jean-philippe@linaro.org>
 <20201019213539.GC3203@xz-x1> <20201022163937.GB1808268@myrica>
 <20201022205616.GD3208@xz-x1> <20201023074858.GA2265982@myrica>
MIME-Version: 1.0
In-Reply-To: <20201023074858.GA2265982@myrica>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=peterx@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/23 02:46:25
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

On Fri, Oct 23, 2020 at 09:48:58AM +0200, Jean-Philippe Brucker wrote:
> Arm CPUs and SMMU support 4k, 16k and 64k page sizes. I don't think 16k is
> used anywhere but some distributions chose 64k (RHEL, I think?), others
> 4k, so we need to support both.
> 
> Unfortunately as noted above host64k-guest4k is not possible without
> adding a negotiation mechanism to virtio-iommu, host VFIO and IOMMU
> driver.

I see.  Then it seems we would still need to support host4k-guest64k.

Maybe for assigned case, we can simply AND all the psize_masks of all the vfio
containers that supported to replace the default psize mask (TARGET_PAGE_SIZE)
without caring about whether it's shrinking or not?  Note that current patch
only update config.psize_mask to the new one, but I think we need to calculate
the subset of all containers rather than a simply update.  Then with the help
of 39b3b3c9cac1 imho we'll gracefully fail the probe if the psize is not
suitable anyway, e.g., host64k-guest4k.

Thanks,

-- 
Peter Xu


