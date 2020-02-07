Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A284DC2BA83
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 20:26:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F56521741
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 20:26:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Onpvyfe5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F56521741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34982 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j0ADE-0001VF-N3
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 15:26:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56342)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1j0ACZ-0000ll-Ns
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 15:26:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1j0ACW-0001B4-Sm
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 15:26:09 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:26123
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1j0ACW-00018W-Hx
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 15:26:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581107167;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fX68pnrXCaepJggUv37SrOGhdFndlVqiL1tAnozGtBA=;
 b=Onpvyfe5BFuz/ViPgBCJEOVMbkLGBTvSzjovhLGZj/L42G4b72oqb2GgGp9RkjDF5bAIfo
 /YNqSv/rqcwU4DVakQOIa+kU2muYqO+MK2mTKRm2P8+DcYn6Hut2kuex6GaCr3cvkHQ5ml
 x64MhmZVQyzt/t2MH99E6ladF66gOy8=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-341-VdttOF6PPHS3h7o94lw2KA-1; Fri, 07 Feb 2020 15:26:05 -0500
Received: by mail-qt1-f197.google.com with SMTP id d16so330633qtr.2
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2020 12:26:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=6opY5JAPnTC3deXfh3fnYGt75ABnlBjWVDrm/KM9ZmQ=;
 b=K7nDoXn251fddrzIf3+bu/c0siAzvtVVrtfLQYS+CdsYcnpRqKK0LJct84xOHxpSEi
 C0i4G/8PplYm9zIjb27VWBBR1Wt/wUnNx7RUiF2t9Z2t2LGSpsvyZBzGR4FsFn62qzSK
 coMOqbiOVHAfYFy9T+tS16he3lQhqh6ruH8JXGjawyQ0kE4TOx/qvgnLoug1yEIeJHQX
 DQTB2e7+No9jjDWptHMduPTomSYeLZv+jN85khSYpnoHsgYWkKkWLjd2MbyzW5GofRKz
 qmfen/cbJGlYDEDikLeiaGaX1Pft2PYjv2Cv6V2Gh2oDXJu6EZxOdzdlAR617CsZu9Rb
 BPsA==
X-Gm-Message-State: APjAAAWWyg1pOJOuOBlXG1USuXT+WFi/V/P/tjp+R3mAb2ICEZSr+YAP
 lKuROjFM3PeMAvIAvJJjvJNjuZxoQQfwIU2NMU+V20FXAdGGcrw8JVSKcMi10cKlyqDV8RGdgbZ
 k85pFxoAJWmJJxu8=
X-Received: by 2002:ac8:7501:: with SMTP id u1mr121616qtq.149.1581107164628;
 Fri, 07 Feb 2020 12:26:04 -0800 (PST)
X-Google-Smtp-Source: APXvYqwe/e4yWUCo5sqWEowGD6Dr2h4fjlz48tRUVqTakI1jqSws5al8i9h5KeIpmhNIqUwU7PIKtw==
X-Received: by 2002:ac8:7501:: with SMTP id u1mr121583qtq.149.1581107164225;
 Fri, 07 Feb 2020 12:26:04 -0800 (PST)
Received: from xz-x1 ([2607:9880:19c8:32::2])
 by smtp.gmail.com with ESMTPSA id s67sm1882496qke.1.2020.02.07.12.26.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Feb 2020 12:26:03 -0800 (PST)
Date: Fri, 7 Feb 2020 15:26:01 -0500
From: Peter Xu <peterx@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH v14 03/11] virtio-iommu: Implement attach/detach command
Message-ID: <20200207202601.GD720553@xz-x1>
References: <20200207093203.3788-1-eric.auger@redhat.com>
 <20200207093203.3788-4-eric.auger@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200207093203.3788-4-eric.auger@redhat.com>
X-MC-Unique: VdttOF6PPHS3h7o94lw2KA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: peter.maydell@linaro.org, kevin.tian@intel.com, tnowicki@marvell.com,
 jean-philippe@linaro.org, quintela@redhat.com, qemu-devel@nongnu.org,
 dgilbert@redhat.com, bharatb.linux@gmail.com, qemu-arm@nongnu.org,
 mst@redhat.com, eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Feb 07, 2020 at 10:31:55AM +0100, Eric Auger wrote:

[...]

> v13 -> v14:
> - in virtio_iommu_put_endpoint, if the EP is attached to a
>   domain, call virtio_iommu_detach_endpoint_from_domain()
> - remove domain ref counting and simply delete the mappings
>   gtree when the last EP is detached from the domain

Yeh this looks a good optimization!  Ref counting protects the domain
from being gone when there's still EP in the domain, but since we've
got the ep_list in domain after all so it seems to be safe and clearer.

> - in virtio_iommu_detach_endpoint_from_domain(), return if the
>   ep's domain is unset.

[...]

> +static void virtio_iommu_put_domain(gpointer data)
> +{
> +    VirtIOIOMMUDomain *domain =3D (VirtIOIOMMUDomain *)data;
> +    VirtIOIOMMUEndpoint *iter, *tmp;
> +
> +    QLIST_FOREACH_SAFE(iter, &domain->endpoint_list, next, tmp) {
> +        virtio_iommu_detach_endpoint_from_domain(iter);
> +    }
> +    trace_virtio_iommu_put_domain(domain->id);

[1]

> +    g_free(domain);
> +}

[...]

>  static int virtio_iommu_attach(VirtIOIOMMU *s,
>                                 struct virtio_iommu_req_attach *req)
>  {
>      uint32_t domain_id =3D le32_to_cpu(req->domain);
>      uint32_t ep_id =3D le32_to_cpu(req->endpoint);
> +    VirtIOIOMMUDomain *domain;
> +    VirtIOIOMMUEndpoint *ep;
> =20
>      trace_virtio_iommu_attach(domain_id, ep_id);
> =20
> -    return VIRTIO_IOMMU_S_UNSUPP;
> +    ep =3D virtio_iommu_get_endpoint(s, ep_id);
> +    if (!ep) {
> +        return VIRTIO_IOMMU_S_NOENT;
> +    }
> +
> +    if (ep->domain) {
> +        VirtIOIOMMUDomain *previous_domain =3D ep->domain;
> +        /*
> +         * the device is already attached to a domain,
> +         * detach it first
> +         */
> +        virtio_iommu_detach_endpoint_from_domain(ep);
> +        if (QLIST_EMPTY(&previous_domain->endpoint_list)) {

I feel like we still need:

               g_tree_destroy(previous_domain->mappings);

Or the mappings will be leaked.

To make this simpler, maybe we can destroy the mappings at [1] above.
Then we can remove line [2] below too.

> +            g_tree_remove(s->domains, GUINT_TO_POINTER(previous_domain->=
id));
> +        }
> +    }
> +
> +    domain =3D virtio_iommu_get_domain(s, domain_id);
> +    QLIST_INSERT_HEAD(&domain->endpoint_list, ep, next);
> +
> +    ep->domain =3D domain;
> +
> +    return VIRTIO_IOMMU_S_OK;
>  }
> =20
>  static int virtio_iommu_detach(VirtIOIOMMU *s,
> @@ -50,10 +268,29 @@ static int virtio_iommu_detach(VirtIOIOMMU *s,
>  {
>      uint32_t domain_id =3D le32_to_cpu(req->domain);
>      uint32_t ep_id =3D le32_to_cpu(req->endpoint);
> +    VirtIOIOMMUDomain *domain;
> +    VirtIOIOMMUEndpoint *ep;
> =20
>      trace_virtio_iommu_detach(domain_id, ep_id);
> =20
> -    return VIRTIO_IOMMU_S_UNSUPP;
> +    ep =3D g_tree_lookup(s->endpoints, GUINT_TO_POINTER(ep_id));
> +    if (!ep) {
> +        return VIRTIO_IOMMU_S_NOENT;
> +    }
> +
> +    domain =3D ep->domain;
> +
> +    if (!domain || domain->id !=3D domain_id) {
> +        return VIRTIO_IOMMU_S_INVAL;
> +    }
> +
> +    virtio_iommu_detach_endpoint_from_domain(ep);
> +
> +    if (QLIST_EMPTY(&domain->endpoint_list)) {
> +        g_tree_destroy(domain->mappings);

[2]

> +        g_tree_remove(s->domains, GUINT_TO_POINTER(domain->id));
> +    }
> +    return VIRTIO_IOMMU_S_OK;
>  }
> =20
>  static int virtio_iommu_map(VirtIOIOMMU *s,
> @@ -172,6 +409,27 @@ out:
>      }
>  }

Other than that, the whole patch looks good to me.

Thanks,

--=20
Peter Xu


