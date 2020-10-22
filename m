Return-Path: <SRS0=9x1+=D5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA407C388F7
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 20:57:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D5D42080C
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 20:57:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dCXBVmWa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D5D42080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54592 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVhdr-0004dF-TC
	for qemu-devel@archiver.kernel.org; Thu, 22 Oct 2020 16:56:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53664)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1kVhdJ-0004ET-U0
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 16:56:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:39589)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1kVhdH-0005G7-Mt
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 16:56:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603400180;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5EPP1u2O3tLG864rfIApHeIvmfJbw0a7Bt0n5TLEVZw=;
 b=dCXBVmWa7uMGgHdbMUUq5CKsTCjSWlZRyDWewTTSQD+YBMo77nUdeH8BJlwsxOJGpHisQQ
 C7Jevim7qouPvP/w+yGlCyhGqCBLYmEG8MMeDJfwEVS7wQ+QMGbw3s7B2Ss6Yw/x+wdV09
 xvnroqEvoj1HqKi259rl1tzzm6pb4+0=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-104-hUejBIO-P-aMoO4rNqsFgw-1; Thu, 22 Oct 2020 16:56:16 -0400
X-MC-Unique: hUejBIO-P-aMoO4rNqsFgw-1
Received: by mail-qt1-f199.google.com with SMTP id b41so1894085qtk.21
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2020 13:56:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=5EPP1u2O3tLG864rfIApHeIvmfJbw0a7Bt0n5TLEVZw=;
 b=gQdEXdFmCy8gOfc1axBAAizml/Hf03qJaw6i6c+vPNUnpGnKtX1JJmCnyXxQAChQQi
 /QqwkpuS6Ij2cq+9+9bhttQHiLnzxSw4dbIeWssUMDrzwPKd76xFC7UrbULnWLnECUwB
 x1A19aG0sjeJJ40YkWdXj7YC6RYnRV7IhRjNOudrcjPdwl4+BbbFXQUQrFcGw4w5Im+q
 7tYA35qzEB8lCVVnF0J6bb1LJeYlE6eJC87p+p16XLEuZeJ6iK8/3EQODF1J6X0UjY0o
 LRq1wxsZl+I5Zj8ehoSoOsumq9eSK211zbwWOv+y5+59DqCROfKzZk5Nt2UUOA+gXXKv
 uR4A==
X-Gm-Message-State: AOAM533uuTQP3Ul77QFD9Zv6hyFIRL7FKByxYkzCm+3YghQB5bH9WAkE
 7xnP7E+OYQ4JMt9hh7oi0ApkDM+fWTY8L4MwD5rBeLzhf1IsCUCHlnySWFzRuOtjMKZ/NkUePBR
 4VFn1PJH5Aqwhbcs=
X-Received: by 2002:aed:23f1:: with SMTP id k46mr4106681qtc.377.1603400176180; 
 Thu, 22 Oct 2020 13:56:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyVmIoalUKrE2rZPGty5TyX2UV2EWUhBZzUP5JhOQiy+EffspyahcCvj7RQ3VAgidlec4uDaw==
X-Received: by 2002:aed:23f1:: with SMTP id k46mr4106655qtc.377.1603400175899; 
 Thu, 22 Oct 2020 13:56:15 -0700 (PDT)
Received: from xz-x1 (toroon474qw-lp140-04-174-95-215-133.dsl.bell.ca.
 [174.95.215.133])
 by smtp.gmail.com with ESMTPSA id s17sm1758345qta.26.2020.10.22.13.56.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2020 13:56:15 -0700 (PDT)
Date: Thu, 22 Oct 2020 16:56:16 -0400
From: Peter Xu <peterx@redhat.com>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH v10 09/10] virtio-iommu: Set supported page size mask
Message-ID: <20201022205616.GD3208@xz-x1>
References: <20201008171558.410886-1-jean-philippe@linaro.org>
 <20201008171558.410886-10-jean-philippe@linaro.org>
 <20201019213539.GC3203@xz-x1> <20201022163937.GB1808268@myrica>
MIME-Version: 1.0
In-Reply-To: <20201022163937.GB1808268@myrica>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=peterx@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/22 08:09:01
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

On Thu, Oct 22, 2020 at 06:39:37PM +0200, Jean-Philippe Brucker wrote:
> So what I'd like to do for next version:
> 
> * Set qemu_real_host_page_mask as the default page mask, instead of the
>   rather arbitrary TARGET_PAGE_MASK.

Oh, I thought TARGET_PAGE_MASK was intended - kernel committ 39b3b3c9cac1
("iommu/virtio: Reject IOMMU page granule larger than PAGE_SIZE", 2020-03-27)
explicitly introduced a check that virtio-iommu kernel driver will fail
directly if this psize is bigger than PAGE_SIZE in the guest.  So it sounds
reasonable to have the default value as PAGE_SIZE (if it's the same as
TARGET_PAGE_SIZE in QEMU, which seems true?).

For example, I'm thinking whether qemu_real_host_page_mask could be bigger than
PAGE_SIZE in the guest in some environments, then it seems virtio-iommu won't
boot anymore without assigned devices, because that extra check above will
always fail.

>   Otherwise we cannot hotplug assigned
>   devices on a 64kB host, since TARGET_PAGE_MASK is pretty much always
>   4kB.
> 
> * Disallow changing the page size. It's simpler and works in
>   practice if we default to qemu_real_host_page_mask.
> 
> * For non-hotplug devices, allow changing the rest of the mask. For
>   hotplug devices, only warn about it.

Could I ask what's "the rest of the mask"?  On the driver side, I see that
viommu_domain_finalise() will pick the largest supported page size to use, if
so then we seem to be quite restricted on what page size we can use.

I'm also a bit curious about what scenario we plan to support in this initial
version, especially for ARM.  For x86, I think it's probably always 4k
everywhere so it's fairly simple.  Know little on ARM side...

Thanks,

-- 
Peter Xu


