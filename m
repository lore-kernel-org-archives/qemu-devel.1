Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB673C4363D
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 18:55:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F74C20758
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 18:55:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EFkE93sD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F74C20758
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60432 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOQD8-0002A5-Cn
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 14:55:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59312)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1kOQB7-0000Mw-Dw
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 14:53:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:30710)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1kOQB5-0003Yw-D5
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 14:53:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601664789;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kETz8z/PNfNAdFKo8qzT79pmjMs6Htr1XZfifdBkzHY=;
 b=EFkE93sDter8g75d1cihJaoCoZS9JwWYF442S5vpN0oCtbOr0r78yUhmDvFYXdnEQ4qAMg
 PuGXTV7JoHyxAR3/fQxcyaMJcYgIpt5VPAL4013lAyjLUhfptZjDEjv606Mln1nv4U9f/+
 L+jDS59ceHuf39zc+J0POPK+EYifQi0=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-78-ZmO6XxPIMrOn6PUOr4ApLw-1; Fri, 02 Oct 2020 14:53:06 -0400
X-MC-Unique: ZmO6XxPIMrOn6PUOr4ApLw-1
Received: by mail-qk1-f197.google.com with SMTP id y17so1734518qky.0
 for <qemu-devel@nongnu.org>; Fri, 02 Oct 2020 11:53:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=kETz8z/PNfNAdFKo8qzT79pmjMs6Htr1XZfifdBkzHY=;
 b=cLSMwpBoKA0sWs8AubdntJPMGcukax97JPxGWFbUKMpCHxr0RgIdZSJY9yCEN2JFjE
 9J2bDwCu47mYbngobZYE2V59R+ipjGx3e8UgKvxtCylepZMAhBBkjejHwDaRvL5q0s1h
 i8zIlTRIqjX7bQkZNdvdU3mu1TkVKoGInqgw3lonee0lWT20KbKb3A48EkQrySofv9Qs
 1ae1BwPBwYjkJLlckx4b75Vtnj8RgmqPuVaptUdsb9xU8fhxNEAS8S8lI2uPpgmgUfVC
 8tPaLFZNoYm+aKSPqGQK7kXnv2/zVlCJe/MTGpJKSu5mtb9BO6xTCn6msaZgf5TkXtOO
 W/4w==
X-Gm-Message-State: AOAM533bAf2eQaVRI9DJyszwnKtD2fYQt2EL2RzSvs0gl68eHYCc0NYr
 D9253Cl4JKGKXvMizxJ8I07sYy7xWq93ok1+QhEAZmHbsT+9bXL504BNDdhL1N5fVAjvzSowkbw
 jY3Q4sxKHwwAR5Fo=
X-Received: by 2002:a37:9142:: with SMTP id t63mr3460344qkd.50.1601664785865; 
 Fri, 02 Oct 2020 11:53:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzw/Xo1xk49Rm14R6K2qx34856SGweej+ospj6Bi+xf28FjEfy1pXrPU5U7HcCVmN2GCOTp3Q==
X-Received: by 2002:a37:9142:: with SMTP id t63mr3460325qkd.50.1601664785578; 
 Fri, 02 Oct 2020 11:53:05 -0700 (PDT)
Received: from xz-x1 (toroon474qw-lp130-09-184-147-14-204.dsl.bell.ca.
 [184.147.14.204])
 by smtp.gmail.com with ESMTPSA id m10sm1671275qti.46.2020.10.02.11.53.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2020 11:53:04 -0700 (PDT)
Date: Fri, 2 Oct 2020 14:53:03 -0400
From: Peter Xu <peterx@redhat.com>
To: Wei Huang <wei.huang2@amd.com>
Subject: Re: [PATCH V2 1/3] amd-iommu: Add address space notifier and replay
 support
Message-ID: <20201002185303.GE5473@xz-x1>
References: <20201002145907.1294353-1-wei.huang2@amd.com>
 <20201002145907.1294353-2-wei.huang2@amd.com>
MIME-Version: 1.0
In-Reply-To: <20201002145907.1294353-2-wei.huang2@amd.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=peterx@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/01 23:37:29
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
Cc: ehabkost@redhat.com, mst@redhat.com, qemu-devel@nongnu.org,
 alex.williamson@redhat.com, pbonzini@redhat.com, Suravee.Suthikulpanit@amd.com,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Oct 02, 2020 at 09:59:05AM -0500, Wei Huang wrote:
> +static void amdvi_address_space_unmap(AMDVIAddressSpace *as, IOMMUNotifier *n)
> +{
> +    IOMMUTLBEntry entry;
> +    hwaddr start = n->start;
> +    hwaddr end = n->end;
> +    hwaddr size = end - start + 1;
> +
> +    entry.target_as = &address_space_memory;
> +    entry.iova = start;
> +    entry.translated_addr = 0;
> +    entry.perm = IOMMU_NONE;
> +    entry.addr_mask = size - 1;

This may race with Eugenio's series:

  https://mail.gnu.org/archive/html/qemu-ppc/2020-09/msg00131.html

IMHO that series should be acceptable for merging already.  Anyway, there's
probably a trivial conflict to solve.

> +
> +    memory_region_notify_one(n, &entry);
> +}
> +
>  static gboolean amdvi_iotlb_remove_by_domid(gpointer key, gpointer value,
>                                              gpointer user_data)
>  {
> @@ -1473,14 +1491,17 @@ static int amdvi_iommu_notify_flag_changed(IOMMUMemoryRegion *iommu,
>                                             Error **errp)
>  {
>      AMDVIAddressSpace *as = container_of(iommu, AMDVIAddressSpace, iommu);
> +    AMDVIState *s = as->iommu_state;
>  
> -    if (new & IOMMU_NOTIFIER_MAP) {
> -        error_setg(errp,
> -                   "device %02x.%02x.%x requires iommu notifier which is not "
> -                   "currently supported", as->bus_num, PCI_SLOT(as->devfn),
> -                   PCI_FUNC(as->devfn));
> -        return -EINVAL;

Ideally, we shouldn't remove this error message until the functionality is
fully implemented.  Otherwise an user could potentially boot such a vm with a
broken assigned device.

Thanks,

> +    /* Update address space notifier flags */
> +    as->notifier_flags = new;
> +
> +    if (old == IOMMU_NOTIFIER_NONE) {
> +        QLIST_INSERT_HEAD(&s->amdvi_as_with_notifiers, as, next);
> +    } else if (new == IOMMU_NOTIFIER_NONE) {
> +        QLIST_REMOVE(as, next);
>      }
> +
>      return 0;
>  }

-- 
Peter Xu


