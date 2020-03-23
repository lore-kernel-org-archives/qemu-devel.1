Return-Path: <SRS0=WkHy=5I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7F57C4332B
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 22:07:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AEEA120753
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 22:07:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OMpqQ1Gk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEEA120753
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40182 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGVEZ-0001Po-RG
	for qemu-devel@archiver.kernel.org; Mon, 23 Mar 2020 18:07:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41563)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1jGVDu-0000eO-U6
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 18:07:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1jGVDt-0002lj-61
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 18:07:06 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:51204)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1jGVDt-0002lN-0S
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 18:07:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585001224;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/WR+nqyRZxY1QRgiWV685vKFvPPm/obyGQsWrQN/1kI=;
 b=OMpqQ1GkNVGUpABvXgKtIyA4CtYXP9vp7j3ywsxszu6UfOlhrgGOg0etGbHX/ekIEFfj+4
 sxKzYKLV/bO6eykteV6NgJaPmqzLG+j/ZJLWCbpe9fiMuPtqmTgCZvcZyEGlHtNlr1PEjR
 IB/2mTXD8GlivaFimBslCJawtVmDzlc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-265-NKg7Vh3CMEOYR2f59HKFHA-1; Mon, 23 Mar 2020 18:07:00 -0400
X-MC-Unique: NKg7Vh3CMEOYR2f59HKFHA-1
Received: by mail-wm1-f69.google.com with SMTP id g26so514310wmk.6
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2020 15:06:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=dlnnCp+CN7Ddgykcpr9TWFrMI6YSlr7ZIhIFOrJ+XbA=;
 b=FtnipvTuDr+6kr3EsavJyYztvd3V+O4yaeC/wjyyPighWhs0esYOUgkWHR0A2ZjmQr
 MGbaCbP6ntjCCUVg1W4bQHyjWMOmKvL0D1E8vz3SXquQNelOzjXvBPcMThE7mfOf7xe/
 Ya8aeXiexeVxrlRou4v0gqHZg39D5Gifl3IhMmA9IbU9sySGSUKSkuLKCm3HfixvaG23
 U8BnU5+1N9A953s8TdR/WNQpuRd1ENf4umYs+5v9gtl8o/X3KPmRttkEVHrSw4NW47VC
 GJBA5I9KI13c2YquKDYUxzEUnVgugJdr2Bo4UTXtp4mAcU3+Ly/l1NFgeZqO7OgrVKiV
 y+4g==
X-Gm-Message-State: ANhLgQ3bWSfz4uBKzT2+XNmJijM2ImiUpZd4xbHFoFaXjlYXj0nxw0xz
 O0HahQJG5RNKFIBdYBwnGYK7BbJAkbsFL0jKa6hqaoBJihCvMxhnmGehQ9V8nM+enRHQ7+KmJUg
 8snnhV6IzAzbAXoQ=
X-Received: by 2002:a1c:4645:: with SMTP id t66mr1700173wma.6.1585001218952;
 Mon, 23 Mar 2020 15:06:58 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vsAyyZRneAjCk4wKljM0NG4hzHtL55UEQ6TzSXls1zwplL0INr7A6Q09TsiongDtXfBzX+pGg==
X-Received: by 2002:a1c:4645:: with SMTP id t66mr1700142wma.6.1585001218695;
 Mon, 23 Mar 2020 15:06:58 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::2])
 by smtp.gmail.com with ESMTPSA id s131sm1271901wmf.35.2020.03.23.15.06.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Mar 2020 15:06:57 -0700 (PDT)
Date: Mon, 23 Mar 2020 18:06:53 -0400
From: Peter Xu <peterx@redhat.com>
To: Liu Yi L <yi.l.liu@intel.com>
Subject: Re: [PATCH v1 09/22] vfio/common: check PASID alloc/free availability
Message-ID: <20200323220653.GT127076@xz-x1>
References: <1584880579-12178-1-git-send-email-yi.l.liu@intel.com>
 <1584880579-12178-10-git-send-email-yi.l.liu@intel.com>
MIME-Version: 1.0
In-Reply-To: <1584880579-12178-10-git-send-email-yi.l.liu@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: jean-philippe@linaro.org, kevin.tian@intel.com,
 Jacob Pan <jacob.jun.pan@linux.intel.com>, Yi Sun <yi.y.sun@linux.intel.com>,
 kvm@vger.kernel.org, mst@redhat.com, jun.j.tian@intel.com,
 qemu-devel@nongnu.org, eric.auger@redhat.com, alex.williamson@redhat.com,
 pbonzini@redhat.com, hao.wu@intel.com, yi.y.sun@intel.com,
 david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, Mar 22, 2020 at 05:36:06AM -0700, Liu Yi L wrote:

[...]

> @@ -1256,11 +1334,19 @@ static int vfio_init_container(VFIOContainer *con=
tainer, int group_fd,
>      }
> =20
>      if (iommu_type =3D=3D VFIO_TYPE1_NESTING_IOMMU) {
> -        /*
> -         * TODO: config flags per host IOMMU nesting capability
> -         * e.g. check if VFIO_TYPE1_NESTING_IOMMU supports PASID
> -         * alloc/free
> -         */
> +        struct vfio_iommu_type1_info_cap_nesting nesting =3D {
> +                                         .nesting_capabilities =3D 0x0,
> +                                         .stage1_formats =3D 0, };
> +
> +        ret =3D vfio_get_nesting_iommu_cap(container, &nesting);
> +        if (ret) {
> +            error_setg_errno(errp, -ret,
> +                             "Failed to get nesting iommu cap");
> +            return ret;
> +        }
> +
> +        flags |=3D (nesting.nesting_capabilities & VFIO_IOMMU_PASID_REQS=
) ?
> +                 HOST_IOMMU_PASID_REQUEST : 0;

I replied in the previous patch but I forgot to use reply-all...

Anyway I'll comment again here - I think it'll be slightly better we
use the previous patch to only offer the vfio specific hooks, and this
patch to do all the rest including host_iommu_ctx_init() below, which
will avoid creating the host_iommu_ctx_init().

Thanks,

>          host_iommu_ctx_init(&container->host_icx,
>                              sizeof(container->host_icx),
>                              TYPE_VFIO_HOST_IOMMU_CONTEXT,
> --=20
> 2.7.4
>=20

--=20
Peter Xu


