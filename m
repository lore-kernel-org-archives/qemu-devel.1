Return-Path: <SRS0=Q/S9=2X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14EF1C2D0DE
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2020 02:26:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D498320866
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2020 02:26:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="TBg+TDRU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D498320866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35800 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1imqBb-0006XX-05
	for qemu-devel@archiver.kernel.org; Wed, 01 Jan 2020 21:26:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42644)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1imq6m-0008Mu-HN
 for qemu-devel@nongnu.org; Wed, 01 Jan 2020 21:21:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1imq6l-0005Un-BN
 for qemu-devel@nongnu.org; Wed, 01 Jan 2020 21:21:08 -0500
Received: from ozlabs.org ([203.11.71.1]:56359)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1imq6k-0005TM-Vf
 for qemu-devel@nongnu.org; Wed, 01 Jan 2020 21:21:07 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47pBbc31wnz9sRp; Thu,  2 Jan 2020 13:21:00 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1577931660;
 bh=lcckO8Br3mxw9lPZDlRNQSACAfzbUFAgMI0QmlGurfo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=TBg+TDRUo+v578O0jmFG+gh8SA63Lkp2ntX2WHwESoKfQUhsPI1t7PqokZ7Ny2eFR
 LCNbgKAFTDaPmbodmPIvxsMVuZ/rDIi6XmOGPhbioFmJLr43JT0sDgxvKbzyo1sEwx
 4lRJ0sYebEZSn0THj9LhdeLmfOYg5rhNvp7e54Z8=
Date: Thu, 2 Jan 2020 13:19:55 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH] vfio/pci: Don't remove irqchip notifier if not registered
Message-ID: <20200102021955.GJ2098@umbus>
References: <20191231133915.115363-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="bgQAstJ9X1Eg13Dy"
Content-Disposition: inline
In-Reply-To: <20191231133915.115363-1-peterx@redhat.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 203.11.71.1
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
Cc: yanghliu@redhat.com, Alex Williamson <alex.williamson@redhat.com>,
 qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--bgQAstJ9X1Eg13Dy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 31, 2019 at 08:39:15AM -0500, Peter Xu wrote:
> The kvm irqchip notifier is only registered if the device supports
> INTx, however it's unconditionally removed.  If the assigned device
> does not support INTx, this will cause QEMU to crash when unplugging
> the device from the system.  Change it to conditionally remove the
> notifier only if the notify hook is setup.
>=20
> CC: Eduardo Habkost <ehabkost@redhat.com>
> CC: David Gibson <david@gibson.dropbear.id.au>
> CC: Alex Williamson <alex.williamson@redhat.com>
> Reported-by: yanghliu@redhat.com
> Fixes: c5478fea27 ("vfio/pci: Respond to KVM irqchip change notifier", 20=
19-11-26)
> Bugzilla: https://bugzilla.redhat.com/show_bug.cgi?id=3D1782678
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

Mea culpa.

> ---
>  hw/vfio/pci.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 2d40b396f2..337a173ce7 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -3076,7 +3076,9 @@ static void vfio_exitfn(PCIDevice *pdev)
>      vfio_unregister_req_notifier(vdev);
>      vfio_unregister_err_notifier(vdev);
>      pci_device_set_intx_routing_notifier(&vdev->pdev, NULL);
> -    kvm_irqchip_remove_change_notifier(&vdev->irqchip_change_notifier);
> +    if (vdev->irqchip_change_notifier.notify) {
> +        kvm_irqchip_remove_change_notifier(&vdev->irqchip_change_notifie=
r);
> +    }
>      vfio_disable_interrupts(vdev);
>      if (vdev->intx.mmap_timer) {
>          timer_free(vdev->intx.mmap_timer);

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--bgQAstJ9X1Eg13Dy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl4NU0kACgkQbDjKyiDZ
s5L8vg/9Fk8vxtqyn/Up4u050Ne0DH2XMgCKVQGHP67qPkMY5Ij2L9XXMJ+UUwX6
6kSQOB/9su4k9hBcr9/LW/gtDUU7H5xGlq+NONtWMFJozNAFTqCFTjEf/6NAT0zH
V4w3NnqOTojpccJsnT5x0b0+R5XGTeklyo41YBEHh0fiY/eHbAmcGNBbnGrOdYRo
REmhIKbmk9/y+VfSmHn+E/KJUpPQNqCXt45Cp6yMh4aW+RI1mlyBa8ggPU9qhVdi
yOS/8ft4bmq8IN/mZZTmZNa7RTDADrf8BbV2xOlyvd4OaXbeXSclSeQIR7nb9g/d
gGXaT67vKXSxGyeVbQ8ll9I6U5BlTjQJr1pFPPcULj8seexPSeRZeT7z4VRpJwW3
197LPOlb1Bi2AboOnTd3rPCedKf7cxKiUHA7AZEALUqw7YGQxpLvUx204wDamPHt
xxbvJpX9GX490pDV4j8WMv6GG349X5a9lL5U52pb1rMz2xJQ1qSyaodFEGRkt38r
yDfyIlq9Z1MVpw4hAOsogpn+shXv0YDh9vCioYT+Z0hcTRlqLqi+nicwCdL+297k
NRKRj1uCCMIS5z/yE0vxlFhR9ul5g6jAy32Mmn3SZQapxDJpyTcKS5ZeIJRZi+JQ
RjwYEruYkzzXUKpLV0UQdhiZLMVQnuMqW8HXay+x1DDlvkXbj2g=
=zylT
-----END PGP SIGNATURE-----

--bgQAstJ9X1Eg13Dy--

