Return-Path: <SRS0=VGOL=SR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27DE6C10F0E
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2019 04:07:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6A0C20825
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2019 04:07:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="PZ5Pjwet"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6A0C20825
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44335 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hFstn-0004SR-MB
	for qemu-devel@archiver.kernel.org; Mon, 15 Apr 2019 00:07:15 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53674)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hFsss-000456-TS
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 00:06:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hFssr-0005T9-G4
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 00:06:18 -0400
Received: from ozlabs.org ([203.11.71.1]:36327)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
	id 1hFsso-0005MP-Ox; Mon, 15 Apr 2019 00:06:17 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
	id 44jFKq6Thcz9s55; Mon, 15 Apr 2019 14:06:07 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=gibson.dropbear.id.au; s=201602; t=1555301167;
	bh=RprUIPcxamsEw+t7nNOxd9VNXohKcjWZ8VWEYOJ00Vc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PZ5PjwetfRrvIow5NyyeXcEJFKo++hyZg5uQOjjm3RkHmeYgBYEjMh6ri0whFofWm
	2sw3uhJ/CRR+LRJCCeMRrFQSkvPhxDxxc7RpksETaPGzxXmjUAHcVGwpteXGhTppqb
	OR5mM+wX3Hz2wKQMqZl1ZBI+Wa+IlQBAKQAvDzsw=
Date: Mon, 15 Apr 2019 13:38:36 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Message-ID: <20190415033836.GD32705@umbus.fritz.box>
References: <20190411080004.8690-1-clg@kaod.org>
	<20190411080004.8690-6-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="T7mxYSe680VjQnyC"
Content-Disposition: inline
In-Reply-To: <20190411080004.8690-6-clg@kaod.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: Re: [Qemu-devel] [PATCH 5/6] memory_ldst: Add atomic ops for PTE
 updates
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
	Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190415033836._11xA7EVZmuwKHqGUZtNPOd7AP4Qm3Q4wnQmymRqezk@z>


--T7mxYSe680VjQnyC
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2019 at 10:00:03AM +0200, C=E9dric Le Goater wrote:
> From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>=20
> On some architectures, PTE updates for dirty and changed bits need
> to be performed atomically. This adds a couple of address_space_cmpxchg*
> helpers for that purpose.
>=20
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

But I think this needs to go past Paolo for review as memory subsystem main=
tainer.

> ---
>  include/exec/memory_ldst.inc.h |  6 +++
>  memory_ldst.inc.c              | 80 ++++++++++++++++++++++++++++++++++
>  2 files changed, 86 insertions(+)
>=20
> diff --git a/include/exec/memory_ldst.inc.h b/include/exec/memory_ldst.in=
c.h
> index 272c20f02eae..f3cfa7e9a622 100644
> --- a/include/exec/memory_ldst.inc.h
> +++ b/include/exec/memory_ldst.inc.h
> @@ -28,6 +28,12 @@ extern uint64_t glue(address_space_ldq, SUFFIX)(ARG1_D=
ECL,
>      hwaddr addr, MemTxAttrs attrs, MemTxResult *result);
>  extern void glue(address_space_stl_notdirty, SUFFIX)(ARG1_DECL,
>      hwaddr addr, uint32_t val, MemTxAttrs attrs, MemTxResult *result);
> +extern uint32_t glue(address_space_cmpxchgl_notdirty, SUFFIX)(ARG1_DECL,
> +    hwaddr addr, uint32_t old, uint32_t new, MemTxAttrs attrs,
> +    MemTxResult *result);
> +extern uint32_t glue(address_space_cmpxchgq_notdirty, SUFFIX)(ARG1_DECL,
> +    hwaddr addr, uint64_t old, uint64_t new, MemTxAttrs attrs,
> +    MemTxResult *result);
>  extern void glue(address_space_stw, SUFFIX)(ARG1_DECL,
>      hwaddr addr, uint32_t val, MemTxAttrs attrs, MemTxResult *result);
>  extern void glue(address_space_stl, SUFFIX)(ARG1_DECL,
> diff --git a/memory_ldst.inc.c b/memory_ldst.inc.c
> index acf865b900d7..1d58d2fea67d 100644
> --- a/memory_ldst.inc.c
> +++ b/memory_ldst.inc.c
> @@ -320,6 +320,86 @@ void glue(address_space_stl_notdirty, SUFFIX)(ARG1_D=
ECL,
>      RCU_READ_UNLOCK();
>  }
> =20
> +/* This is meant to be used for atomic PTE updates under MT-TCG */
> +uint32_t glue(address_space_cmpxchgl_notdirty, SUFFIX)(ARG1_DECL,
> +    hwaddr addr, uint32_t old, uint32_t new, MemTxAttrs attrs,
> +    MemTxResult *result)
> +{
> +    uint8_t *ptr;
> +    MemoryRegion *mr;
> +    hwaddr l =3D 4;
> +    hwaddr addr1;
> +    MemTxResult r;
> +    uint8_t dirty_log_mask;
> +
> +    /* Must test result */
> +    assert(result);
> +
> +    RCU_READ_LOCK();
> +    mr =3D TRANSLATE(addr, &addr1, &l, true, attrs);
> +    if (l < 4 || !memory_access_is_direct(mr, true)) {
> +        r =3D MEMTX_ERROR;
> +    } else {
> +        uint32_t orig =3D old;
> +
> +        ptr =3D qemu_map_ram_ptr(mr->ram_block, addr1);
> +        old =3D atomic_cmpxchg(ptr, orig, new);
> +
> +        if (old =3D=3D orig) {
> +            dirty_log_mask =3D memory_region_get_dirty_log_mask(mr);
> +            dirty_log_mask &=3D ~(1 << DIRTY_MEMORY_CODE);
> +            cpu_physical_memory_set_dirty_range(memory_region_get_ram_ad=
dr(mr) +
> +                                                addr, 4, dirty_log_mask);
> +        }
> +        r =3D MEMTX_OK;
> +    }
> +    *result =3D r;
> +    RCU_READ_UNLOCK();
> +
> +    return old;
> +}
> +
> +#ifdef CONFIG_ATOMIC64
> +/* This is meant to be used for atomic PTE updates under MT-TCG */
> +uint32_t glue(address_space_cmpxchgq_notdirty, SUFFIX)(ARG1_DECL,
> +    hwaddr addr, uint64_t old, uint64_t new, MemTxAttrs attrs,
> +    MemTxResult *result)
> +{
> +    uint8_t *ptr;
> +    MemoryRegion *mr;
> +    hwaddr l =3D 8;
> +    hwaddr addr1;
> +    MemTxResult r;
> +    uint8_t dirty_log_mask;
> +
> +    /* Must test result */
> +    assert(result);
> +
> +    RCU_READ_LOCK();
> +    mr =3D TRANSLATE(addr, &addr1, &l, true, attrs);
> +    if (l < 8 || !memory_access_is_direct(mr, true)) {
> +        r =3D MEMTX_ERROR;
> +    } else {
> +        uint32_t orig =3D old;
> +
> +        ptr =3D qemu_map_ram_ptr(mr->ram_block, addr1);
> +        old =3D atomic_cmpxchg(ptr, orig, new);
> +
> +        if (old =3D=3D orig) {
> +            dirty_log_mask =3D memory_region_get_dirty_log_mask(mr);
> +            dirty_log_mask &=3D ~(1 << DIRTY_MEMORY_CODE);
> +            cpu_physical_memory_set_dirty_range(memory_region_get_ram_ad=
dr(mr) +
> +                                                addr, 8, dirty_log_mask);
> +        }
> +        r =3D MEMTX_OK;
> +    }
> +    *result =3D r;
> +    RCU_READ_UNLOCK();
> +
> +    return old;
> +}
> +#endif /* CONFIG_ATOMIC64 */
> +
>  /* warning: addr must be aligned */
>  static inline void glue(address_space_stl_internal, SUFFIX)(ARG1_DECL,
>      hwaddr addr, uint32_t val, MemTxAttrs attrs,

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--T7mxYSe680VjQnyC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlyz/LwACgkQbDjKyiDZ
s5ITBA/7B++rfNXGxzMdEhVzEBjQwvOB3B10U55zNF2cbvSZrC68mNpTQCMq2Czj
RtuXOAnB6PPJER4k+apLfj+jOnsoTEXNWi8uoXgEacO+3uEQygAaClys/aEP9yN0
ZQwvZwn9Vwwn44SMKj9haxyrP+Sxr0pNxH8IIMlREdWilo1TA+f5AxeHVybgMMcI
2o452hdpXPGvFrc2zSgfbNErAdJcXp+KtiSQ9UvJwau85/Ep4njPF5fbLAAl0m0l
NVL12qXhx6hJMTMyh36NNaurIKWvw/b44Ibnr7+gMsygVVm/rZYON4K6rq9Qf70R
YD54M9UeIzXI709DD7jMlYi43dQ6R0+GIORSDWxX11t4gdPVlhVIERa8MItQfzHJ
JAtCHcS5JeUH6rd5Xd6EaAwMZHYkKS9tQurP3K38yhJAss93dlzpx2JrmH1R7Paq
Jb+qCXMSzgBfQupAOK3W6lw9iardk3DesmIS/uSCUeMlkGXXjxWZ0cNuknkMjUUU
zLSo/lswNLKCQcYhJEZ1HI7DxlcQqA/rLh74nPQywVBBtEQSPKY1YpPUkJ7Ri5QH
qFpNJDt1cV0L+1U1agMtMCtdJMV8FouBHIs1L2DDfvcFUIt3GJOK3/q++Xt6i/qE
4x/n1Cz3YYUhvi3Y6T1XIemrXZE13NUq63h+OZyZ/iXzBlkJr2U=
=PRW1
-----END PGP SIGNATURE-----

--T7mxYSe680VjQnyC--

