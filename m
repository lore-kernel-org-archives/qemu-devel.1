Return-Path: <SRS0=a9ZG=U6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8392C5B578
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 05:52:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B60972089F
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 05:52:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="UaR01ucf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B60972089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47946 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hhpEy-0005pf-2e
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 01:52:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37350)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hhpAg-0000dt-5V
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 01:48:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hhpAe-0005pp-T8
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 01:48:10 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:49375 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hhpAe-0005o0-8w; Mon, 01 Jul 2019 01:48:08 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45cbxs1Ttgz9sPB; Mon,  1 Jul 2019 15:48:01 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1561960081;
 bh=wArsJ2g+QXz7I+S+0+7xd3m0DxewLLWkl54pYpy0zyA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=UaR01ucf2LXsrb7vOHYqOAhM8As6gmx14dAa2I4d/I+FVwzVzctq36Jqjso0soczy
 ddnc7Kj0xfcYXA/N/4U6tPe1pnb9otuQS13Am/osYAe+OZ8X4hZ+xgIDwQukGzbkrJ
 FPHnk3NMoaNPyGWiBpKvdyvhNVs6+nbI10Mib7no=
Date: Mon, 1 Jul 2019 15:11:11 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Message-ID: <20190701051111.GK2138@umbus.fritz.box>
References: <156110925375.92514.11649846071216864570.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Xsn3knLL3qrmRbVI"
Content-Disposition: inline
In-Reply-To: <156110925375.92514.11649846071216864570.stgit@bahia.lan>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: Re: [Qemu-devel] [PATCH] spapr_pci: Unregister listeners before
 destroying the IOMMU address space
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
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Paolo Bonzini <pbonzini@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--Xsn3knLL3qrmRbVI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 21, 2019 at 11:27:33AM +0200, Greg Kurz wrote:
> Hot-unplugging a PHB with a VFIO device connected to it crashes QEMU:
>=20
> -device spapr-pci-host-bridge,index=3D1,id=3Dphb1 \
> -device vfio-pci,host=3D0034:01:00.3,id=3Dvfio0
>=20
> (qemu) device_del phb1
> [  357.207183] iommu: Removing device 0001:00:00.0 from group 1
> [  360.375523] rpadlpar_io: slot PHB 1 removed
> qemu-system-ppc64: memory.c:2742:
>  do_address_space_destroy: Assertion `QTAILQ_EMPTY(&as->listeners)' faile=
d.
>=20
> 'as' is the IOMMU address space, which indeed has a listener registered
> to by vfio_connect_container() when the VFIO device is realized. This
> listener is supposed to be unregistered by vfio_disconnect_container()
> when the VFIO device is finalized. Unfortunately, the VFIO device hasn't
> reached finalize yet at the time the PHB unrealize function is called,
> and address_space_destroy() gets called with the VFIO listener still
> being registered.
>=20
> All regions have just been unmapped from the address space. Listeners
> aren't needed anymore at this point. Remove them before destroying the
> address space.
>=20
> The VFIO code will try to remove them _again_ at device finalize,
> but it is okay since memory_listener_unregister() is idempotent.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>

LGTM, applied.

> ---
>  hw/ppc/spapr_pci.c    |    6 ++++++
>  include/exec/memory.h |   10 ++++++++++
>  memory.c              |    7 +++++++
>  3 files changed, 23 insertions(+)
>=20
> diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
> index 2dca1e57f36c..eee92b102d5c 100644
> --- a/hw/ppc/spapr_pci.c
> +++ b/hw/ppc/spapr_pci.c
> @@ -1788,6 +1788,12 @@ static void spapr_phb_unrealize(DeviceState *dev, =
Error **errp)
> =20
>      memory_region_del_subregion(&sphb->iommu_root, &sphb->msiwindow);
> =20
> +    /*
> +     * An attached PCI device may have memory listeners, eg. VFIO PCI. W=
e have
> +     * unmapped all sections. Remove the listeners now, before destroyin=
g the
> +     * address space.
> +     */
> +    address_space_remove_listeners(&sphb->iommu_as);
>      address_space_destroy(&sphb->iommu_as);
> =20
>      qbus_set_hotplug_handler(BUS(phb->bus), NULL, &error_abort);
> diff --git a/include/exec/memory.h b/include/exec/memory.h
> index e6140e8a0489..1ba2e89aa8ce 100644
> --- a/include/exec/memory.h
> +++ b/include/exec/memory.h
> @@ -1757,6 +1757,16 @@ void address_space_init(AddressSpace *as, MemoryRe=
gion *root, const char *name);
>   */
>  void address_space_destroy(AddressSpace *as);
> =20
> +/**
> + * address_space_remove_listeners: unregister all listerners of an addre=
ss space
> + *
> + * Removes all callbacks previously registered with memory_listener_regi=
ster()
> + * for @as.
> + *
> + * @as: an initialized #AddressSpace
> + */
> +void address_space_remove_listeners(AddressSpace *as);
> +
>  /**
>   * address_space_rw: read from or write to an address space.
>   *
> diff --git a/memory.c b/memory.c
> index 0a089a73ae1a..480f3d989b4f 100644
> --- a/memory.c
> +++ b/memory.c
> @@ -2723,6 +2723,13 @@ void memory_listener_unregister(MemoryListener *li=
stener)
>      listener->address_space =3D NULL;
>  }
> =20
> +void address_space_remove_listeners(AddressSpace *as)
> +{
> +    while (!QTAILQ_EMPTY(&as->listeners)) {
> +        memory_listener_unregister(QTAILQ_FIRST(&as->listeners));
> +    }
> +}
> +
>  void address_space_init(AddressSpace *as, MemoryRegion *root, const char=
 *name)
>  {
>      memory_region_ref(root);
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Xsn3knLL3qrmRbVI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl0Zle8ACgkQbDjKyiDZ
s5LJfRAA1VZQS3o1TpvNFoC1VJjrCyxnVuarxhcGzCL+yja20rVq0oJFhJQI2wkT
JSIzwerw0nxuhTtkmF3P06haZQ0AA5ouIN6vuo1qzm7OOiwlKx/pnqQ+1qvK2Bei
YIfm1kwYDRiXrgmy8gakuB5UtiBYC14qNvwZtdUSeBQvBxv5iNflpCnIm/CBy/qp
tZncOxJlrknxkMNLpTD1iJM7mUftv0TgUN2ALWKQntHSua1C97xyb9HCTKBW27tF
4x+ii/SK6D/ed/NaVM6v+koJvITCHrRZ43sKuhEnIHuAu/XIxV09ysN58J2MwzzI
77AjiK6YcZBwHkbmEcq3tWUGIvhwk6ffEgDhrm10zxmbW+/fTUsxne8lMp/Ww+IU
vVC/CnaOTzz7gCRJOz7ktMKOHvnl99mv8dChUMO6pqQsZdNf0HWC7gLJ4QtK4GUw
iSb0m6ZEXOYL5xYHouH1qm4GG6aJifBdlaqDSzTw4NFIqo+oWYjOWVV2+RCoWf4I
jq5HtatVMs4lqP5YbTs7hNq94LgxyvuBZHmr9Iqmx5/5yksr0euKRWd2UpFLCvxt
55i954GGo/sCuA/FKxmvbDRf3un30Uz90+I3jWWrg9JulSyf16H/5Idl94LgJSg2
YPVazvuRRsRW0ogTlXI5nDsArj0+IPbCDaSltzFdW3WV/BdP+hc=
=XaEc
-----END PGP SIGNATURE-----

--Xsn3knLL3qrmRbVI--

