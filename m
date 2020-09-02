Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CD93C433E6
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 01:16:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3B89206F0
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 01:16:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="mKZDE4dZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3B89206F0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40516 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDHNZ-0007je-IH
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 21:16:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44498)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kDHMa-0006z7-Uz; Tue, 01 Sep 2020 21:15:00 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:34845 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kDHMX-0002MD-EU; Tue, 01 Sep 2020 21:15:00 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4Bh5ZV071Rz9sTv; Wed,  2 Sep 2020 11:14:41 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1599009282;
 bh=YgxRl/AYk/8OvoO8rmceCM283PU3TgQ0shXOXy8nqEY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=mKZDE4dZOMKDNeGcePNMoS0gg4VO5YCD9kM3ayvvks8vIsX1Lza2cKkSlVcNwAbIS
 8IklqqafPGX0OYlZzwaEU10rIfB4VU0hvfqCLk5RYfmgJhhuc5a/FA1GETJ5+TdZF+
 4+ynqQmxAhlJvG/FRmmVBtz2yCPFl1ZmSlBnGEYg=
Date: Wed, 2 Sep 2020 10:37:32 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>
Subject: Re: [RFC v8 1/5] memory: Rename memory_region_notify_one to
 memory_region_notify_iommu_one
Message-ID: <20200902003732.GC1897@yekko.fritz.box>
References: <20200901142608.24481-1-eperezma@redhat.com>
 <20200901142608.24481-2-eperezma@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Bu8it7iiRSEf40bY"
Content-Disposition: inline
In-Reply-To: <20200901142608.24481-2-eperezma@redhat.com>
Received-SPF: pass client-ip=2401:3900:2:1::2; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Yan Zhao <yan.y.zhao@intel.com>, Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-ppc@nongnu.org,
 Jason Wang <jasowang@redhat.com>, Juan Quintela <quintela@redhat.com>,
 qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
 Eric Auger <eric.auger@redhat.com>, qemu-arm@nongnu.org,
 =?iso-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>,
 Avi Kivity <avi@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--Bu8it7iiRSEf40bY
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 01, 2020 at 04:26:04PM +0200, Eugenio P=E9rez wrote:
> Previous name didn't reflect the iommu operation.
>=20
> Signed-off-by: Eugenio P=E9rez <eperezma@redhat.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  hw/arm/smmu-common.c  | 2 +-
>  hw/arm/smmuv3.c       | 2 +-
>  hw/i386/intel_iommu.c | 4 ++--
>  include/exec/memory.h | 6 +++---
>  softmmu/memory.c      | 6 +++---
>  5 files changed, 10 insertions(+), 10 deletions(-)
>=20
> diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
> index 3838db1395..88d2c454f0 100644
> --- a/hw/arm/smmu-common.c
> +++ b/hw/arm/smmu-common.c
> @@ -472,7 +472,7 @@ static void smmu_unmap_notifier_range(IOMMUNotifier *=
n)
>      entry.perm =3D IOMMU_NONE;
>      entry.addr_mask =3D n->end - n->start;
> =20
> -    memory_region_notify_one(n, &entry);
> +    memory_region_notify_iommu_one(n, &entry);
>  }
> =20
>  /* Unmap all notifiers attached to @mr */
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index 0122700e72..0a893ae918 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -827,7 +827,7 @@ static void smmuv3_notify_iova(IOMMUMemoryRegion *mr,
>      entry.addr_mask =3D num_pages * (1 << granule) - 1;
>      entry.perm =3D IOMMU_NONE;
> =20
> -    memory_region_notify_one(n, &entry);
> +    memory_region_notify_iommu_one(n, &entry);
>  }
> =20
>  /* invalidate an asid/iova range tuple in all mr's */
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index 5284bb68b6..2ad6b9d796 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -3498,7 +3498,7 @@ static void vtd_address_space_unmap(VTDAddressSpace=
 *as, IOMMUNotifier *n)
>          /* This field is meaningless for unmap */
>          entry.translated_addr =3D 0;
> =20
> -        memory_region_notify_one(n, &entry);
> +        memory_region_notify_iommu_one(n, &entry);
> =20
>          start +=3D mask;
>          remain -=3D mask;
> @@ -3536,7 +3536,7 @@ static void vtd_address_space_refresh_all(IntelIOMM=
UState *s)
> =20
>  static int vtd_replay_hook(IOMMUTLBEntry *entry, void *private)
>  {
> -    memory_region_notify_one((IOMMUNotifier *)private, entry);
> +    memory_region_notify_iommu_one((IOMMUNotifier *)private, entry);
>      return 0;
>  }
> =20
> diff --git a/include/exec/memory.h b/include/exec/memory.h
> index 0cfe987ab4..22c5f564d1 100644
> --- a/include/exec/memory.h
> +++ b/include/exec/memory.h
> @@ -226,7 +226,7 @@ enum IOMMUMemoryRegionAttr {
>   * The IOMMU implementation must use the IOMMU notifier infrastructure
>   * to report whenever mappings are changed, by calling
>   * memory_region_notify_iommu() (or, if necessary, by calling
> - * memory_region_notify_one() for each registered notifier).
> + * memory_region_notify_iommu_one() for each registered notifier).
>   *
>   * Conceptually an IOMMU provides a mapping from input address
>   * to an output TLB entry. If the IOMMU is aware of memory transaction
> @@ -1274,7 +1274,7 @@ void memory_region_notify_iommu(IOMMUMemoryRegion *=
iommu_mr,
>                                  IOMMUTLBEntry entry);
> =20
>  /**
> - * memory_region_notify_one: notify a change in an IOMMU translation
> + * memory_region_notify_iommu_one: notify a change in an IOMMU translati=
on
>   *                           entry to a single notifier
>   *
>   * This works just like memory_region_notify_iommu(), but it only
> @@ -1285,7 +1285,7 @@ void memory_region_notify_iommu(IOMMUMemoryRegion *=
iommu_mr,
>   *         replaces all old entries for the same virtual I/O address ran=
ge.
>   *         Deleted entries have .@perm =3D=3D 0.
>   */
> -void memory_region_notify_one(IOMMUNotifier *notifier,
> +void memory_region_notify_iommu_one(IOMMUNotifier *notifier,
>                                IOMMUTLBEntry *entry);
> =20
>  /**
> diff --git a/softmmu/memory.c b/softmmu/memory.c
> index 70b93104e8..961c25b42f 100644
> --- a/softmmu/memory.c
> +++ b/softmmu/memory.c
> @@ -1890,8 +1890,8 @@ void memory_region_unregister_iommu_notifier(Memory=
Region *mr,
>      memory_region_update_iommu_notify_flags(iommu_mr, NULL);
>  }
> =20
> -void memory_region_notify_one(IOMMUNotifier *notifier,
> -                              IOMMUTLBEntry *entry)
> +void memory_region_notify_iommu_one(IOMMUNotifier *notifier,
> +                                    IOMMUTLBEntry *entry)
>  {
>      IOMMUNotifierFlag request_flags;
>      hwaddr entry_end =3D entry->iova + entry->addr_mask;
> @@ -1927,7 +1927,7 @@ void memory_region_notify_iommu(IOMMUMemoryRegion *=
iommu_mr,
> =20
>      IOMMU_NOTIFIER_FOREACH(iommu_notifier, iommu_mr) {
>          if (iommu_notifier->iommu_idx =3D=3D iommu_idx) {
> -            memory_region_notify_one(iommu_notifier, &entry);
> +            memory_region_notify_iommu_one(iommu_notifier, &entry);
>          }
>      }
>  }

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Bu8it7iiRSEf40bY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl9O6UoACgkQbDjKyiDZ
s5Lc6RAAv4Xd0TWg2QyC/Sdc+4vmh3zrTWUpBabGPowVSr8JDouC+payLRR18dmM
nfWkyYIIqBUYGpLaiA/M6KE2X+5FbK3J+s4h1zW6RlBf+zCep2VQ5Krbzk7uOnrB
xBFuK2bKNLMl4ewE8WwFYyiaiJguEyz6GMpr5UIKKI9jv76SrYLMfGcFuYw374Uu
/8eR6F3C9Ila5Mzz+ylzHp+pRPuXEY8sux3/dC+ktx9uyy9z23mCZgTRCBDKqbXD
i2p0u6QHj36hc9SxMwoL0Vt694kdn3+LsTweDnN56w6znPvjmZiLoKJVMTfZLQ60
nJwqwgHFyqCFGz66nAzRNJukdHygkNtmFnJaHYXIm/a3BS8jH3Q93GDpgTXsqntS
3q3AYniDAFkCfg/KsGvHdJ1xvyosl3y7Pf3tmKot5D7FnZrs/wVC8zGSgqkJtZIn
eC9PEvuet9WkTc+I+Ib4KC770Alw334PCPLNWnbFtJe57qiwb2W2S8HqcmQgO+uy
vFCdn0NRZ4gwTq1NqAab6uIenj81I30Dz0vISBnRvOlUWRgJACiGXNSgOjPOj3Ia
DFOQvYIwYDHQYorJeLYzGSFlVt7IEw7uZ+i41oNY2RO4HK6vM66PG+seu19w4M2S
ZoCc0QuBL2lMBNm4oPaLTZ9OCu6l846EzlwY9sPwfc6iQNWKVqE=
=9iok
-----END PGP SIGNATURE-----

--Bu8it7iiRSEf40bY--

