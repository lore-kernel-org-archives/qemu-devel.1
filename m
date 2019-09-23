Return-Path: <SRS0=aFsj=XS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF9A7C3A5A6
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 07:53:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8751820882
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 07:53:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8751820882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53194 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCJ9f-0006DN-Na
	for qemu-devel@archiver.kernel.org; Mon, 23 Sep 2019 03:53:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40352)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1iCJ8f-0005fu-8J
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 03:52:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1iCJ8b-0004b9-Ua
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 03:52:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44896)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1iCJ8b-0004a7-K6
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 03:52:01 -0400
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 49CC35859E
 for <qemu-devel@nongnu.org>; Mon, 23 Sep 2019 07:51:59 +0000 (UTC)
Received: by mail-pg1-f199.google.com with SMTP id 135so3541476pgc.23
 for <qemu-devel@nongnu.org>; Mon, 23 Sep 2019 00:51:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=2KHR6grQZPL+uRIV+RciTzr2SmWByfcvlOMO4fzlyeE=;
 b=EjPZn5eWdQeBPqsbuXgUcFoHqHha9Vhhe1eT6PgIGBFfo1HZWVUMV/Alc5bNNEzjnd
 NGxK09sX4ww3azU6qqN8J+7+hNAVrlgu1D0FweVdK3zWGPq87Hs4PeQ/zqjG78r2tLwd
 +CRAkDB89+uBhsjWWo+Eg9T5hRiaBl066meWjpP8NeKRxm7DNqyCDp+o8wsPEHdS7D9f
 ZqjFahQXf1wNlFLKlZ7rRPK1zJiTOz2MLwl0he+sDPjuBAACjYRrCUhZWGWLhaYlhKuY
 uqXqWsPQIIYBiFlYeF4iQHeJLasyhZxk0ccgIV70ZabJYG9NHO9npjq3VonSKLAjXxNO
 2Fdw==
X-Gm-Message-State: APjAAAWy9VnVtar3zdXeNJ8S+IGkNzZp+yIwr41nAetuOKyNqm0J3X5K
 NfkgS5oxoYbIxf+unIXzsE1PMfp/qF+juK/wTcu5/yYvGwEUukmdOiudpZg8eiYaiZ6M8W19PFf
 l+e+JgTdUth16i9U=
X-Received: by 2002:a17:902:ab90:: with SMTP id
 f16mr14983928plr.191.1569225118825; 
 Mon, 23 Sep 2019 00:51:58 -0700 (PDT)
X-Google-Smtp-Source: APXvYqw5/3pjRNedVxxVlcuj8mWWL14M50F5sXKJtgirNS8QBETLl5VZbnE91wlG9/DbyxklVHjReA==
X-Received: by 2002:a17:902:ab90:: with SMTP id
 f16mr14983902plr.191.1569225118478; 
 Mon, 23 Sep 2019 00:51:58 -0700 (PDT)
Received: from xz-x1 ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id s18sm6157170pji.30.2019.09.23.00.51.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Sep 2019 00:51:57 -0700 (PDT)
Date: Mon, 23 Sep 2019 15:51:45 +0800
From: Peter Xu <peterx@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH v3 1/2] vfio: Turn the container error into an Error handle
Message-ID: <20190923075145.GA12806@xz-x1>
References: <20190923065552.10602-1-eric.auger@redhat.com>
 <20190923065552.10602-2-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190923065552.10602-2-eric.auger@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: peter.maydell@linaro.org, mst@redhat.com, aik@ozlabs.ru,
 qemu-devel@nongnu.org, alex.williamson@redhat.com, qemu-arm@nongnu.org,
 pbonzini@redhat.com, david@gibson.dropbear.id.au, eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Sep 23, 2019 at 08:55:51AM +0200, Eric Auger wrote:
> The container error integer field is currently used to store
> the first error potentially encountered during any
> vfio_listener_region_add() call. However this fails to propagate
> detailed error messages up to the vfio_connect_container caller.
> Instead of using an integer, let's use an Error handle.
> 
> Messages are slightly reworded to accomodate the propagation.

Thanks for working on this.  Mostly good at least to me, though I
still have a few nitpickings below.

> @@ -543,6 +545,9 @@ static void vfio_listener_region_add(MemoryListener *listener,
>                                 hostwin->max_iova - hostwin->min_iova + 1,
>                                 section->offset_within_address_space,
>                                 int128_get64(section->size))) {
> +                error_setg(&err, "Overlap with existing IOMMU range "
> +                                 "[0x%"PRIx64",0x%"PRIx64"]", hostwin->min_iova,
> +                                 hostwin->max_iova - hostwin->min_iova + 1);
>                  ret = -1;

This line seems to be useless now after we dropped the integer version
of container->error and start to use Error*.

>                  goto fail;
>              }
> @@ -550,6 +555,7 @@ static void vfio_listener_region_add(MemoryListener *listener,
>  
>          ret = vfio_spapr_create_window(container, section, &pgsize);
>          if (ret) {
> +            error_setg_errno(&err, -ret, "Failed to create SPAPR window");
>              goto fail;
>          }
>  
> @@ -559,7 +565,7 @@ static void vfio_listener_region_add(MemoryListener *listener,
>  #ifdef CONFIG_KVM
>          if (kvm_enabled()) {
>              VFIOGroup *group;
> -            IOMMUMemoryRegion *iommu_mr = IOMMU_MEMORY_REGION(section->mr);
> +            IOMMUMemoryRegion *iommu_mr = IOMMU_MEMORY_REGION(mr);
>              struct kvm_vfio_spapr_tce param;
>              struct kvm_device_attr attr = {
>                  .group = KVM_DEV_VFIO_GROUP,
> @@ -594,18 +600,17 @@ static void vfio_listener_region_add(MemoryListener *listener,
>      }
>  
>      if (!hostwin_found) {
> -        error_report("vfio: IOMMU container %p can't map guest IOVA region"
> -                     " 0x%"HWADDR_PRIx"..0x%"HWADDR_PRIx,
> -                     container, iova, end);
> +        error_setg(&err, "Container %p can't map guest IOVA region"
> +                   " 0x%"HWADDR_PRIx"..0x%"HWADDR_PRIx, container, iova, end);
>          ret = -EFAULT;

Same here.

>          goto fail;
>      }

[...]

> @@ -688,10 +694,14 @@ fail:
>       */
>      if (!container->initialized) {
>          if (!container->error) {
> -            container->error = ret;
> +            error_propagate_prepend(&container->error, err,
> +                                    "Region %s: ", memory_region_name(mr));
> +        } else {
> +            error_free(err);
>          }
>      } else {
> -        hw_error("vfio: DMA mapping failed, unable to continue");
> +        error_reportf_err(err,
> +                          "vfio: DMA mapping failed, unable to continue: ");

Probably need to keep hw_error() because it asserts inside.  Maybe an
error_report_err() before hw_error()?

>      }
>  }
>  
> @@ -1251,6 +1261,7 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
>      container = g_malloc0(sizeof(*container));
>      container->space = space;
>      container->fd = fd;
> +    container->error = NULL;
>      QLIST_INIT(&container->giommu_list);
>      QLIST_INIT(&container->hostwin_list);
>  
> @@ -1308,9 +1319,9 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
>                                       &address_space_memory);
>              if (container->error) {
>                  memory_listener_unregister(&container->prereg_listener);
> -                ret = container->error;
> -                error_setg(errp,
> -                    "RAM memory listener initialization failed for container");
> +                ret = -1;
> +                error_propagate_prepend(errp, container->error,
> +                    "RAM memory listener initialization failed: ");

(I saw that we've got plenty of prepended prefixes for an error
 messages.  For me I'll disgard quite a few of them because the errors
 will directly be delivered to the top level user, but this might be
 too personal as a comment)

Thanks,

>                  goto free_container_exit;
>              }
>          }

-- 
Peter Xu

