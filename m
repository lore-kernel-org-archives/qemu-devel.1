Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD128C432C1
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 14:17:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77E1A214DA
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 14:17:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="l41aT8/N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77E1A214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46236 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iClch-0002jP-HD
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 10:16:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58300)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iCkqa-00077I-Js
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 09:27:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iCkqZ-0000wG-6W
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 09:27:16 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:36341)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iCkqT-0000sF-Qy; Tue, 24 Sep 2019 09:27:10 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46d26K1yn5z9sDB; Tue, 24 Sep 2019 23:27:05 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1569331625;
 bh=N0ZDgsZkLGVcga+EKDbKms0VcmTN4w3BG0f0b8/5IYg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=l41aT8/N2snuTYIVwofEpt1O1LFMa1dPxP7Ns9wYfpiQVdSGzgmX8rG3Fzx2YzcgM
 CHaZ0FKs0uVugIeSJ4aupy3b/YwROW78oQIq4M4Jt5alUS4iNW4y0jZ6sFxIai9e1s
 2RLDSUK9SySDoyXhAtwauIkbB8hPOmMl+Ar7dz+w=
Date: Tue, 24 Sep 2019 23:26:58 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH v4 0/2] Allow memory_region_register_iommu_notifier() to
 fail
Message-ID: <20190924132658.GE17405@umbus>
References: <20190924082517.13724-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="jKBxcB1XkHIR0Eqt"
Content-Disposition: inline
In-Reply-To: <20190924082517.13724-1-eric.auger@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
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
Cc: peter.maydell@linaro.org, aik@ozlabs.ru, qemu-devel@nongnu.org,
 peterx@redhat.com, alex.williamson@redhat.com, qemu-arm@nongnu.org,
 pbonzini@redhat.com, eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--jKBxcB1XkHIR0Eqt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 24, 2019 at 10:25:15AM +0200, Eric Auger wrote:
> This series allows the memory_region_register_iommu_notifier()
> to fail. As of now, when a MAP notifier is attempted to be
> registered along with SMMUv3 or AMD IOMMU, we exit in the IOMMU
> MR notify_flag_changed() callback.
>=20
> In case of VFIO assigned device hotplug, this could be handled
> more nicely directly within the VFIO code, simply rejecting
> the hotplug without exiting. This is what the series achieves
> by handling the memory_region_register_iommu_notifier() returned
> value and Error object.
>=20
> To propagate errors collected during vfio_listener_region_add()
> we now store the error handle inside the VFIO container instead
> of a returned value.
>=20
> The message now is:
> (QEMU) device_add id=3Dhot0 driver=3Dvfio-pci host=3D0000:89:00.0 bus=3Dp=
cie.1
> {"error": {"class": "GenericError", "desc": "vfio 0000:89:00.0: failed
> to setup container for group 2: memory listener initialization failed:
> Region smmuv3-iommu-memory-region-0-6: device 01.00.0 requires iommu MAP
> notifier which is not currently supported"}}
>=20
> Best Regards

For the series

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

and ppc parts

Acked-by: David Gibson <david@gibson.dropbear.id.au>

>=20
> Eric
>=20
> This series can be found at:
> https://github.com/eauger/qemu/tree/v4.1.0_register_iommu_notifier_fail_v4
>=20
> History:
>=20
> v3 -> v4:
> - added Peter's R-b on 2d patch
> - 1st patch: restore hw_error, remove useless ret assignment, improve
>   DMA host window error message, remove local mr variable
>=20
> v2 -> v3:
> - also pass an Error handle (suggested by Peter)
>=20
> v1 -> v2:
> - Intel IOMMU now handles the problem differently with machine init done
>   notifier and machine hotplug allowed hook.
> - use assert(!ret)
> - message rewording in SMMUv3
>=20
> Follow-up of "VFIO/SMMUv3: Fail on VFIO/HW nested paging detection"
> https://patchew.org/QEMU/20190829090141.21821-1-eric.auger@redhat.com/
>=20
>=20
> Eric Auger (2):
>   vfio: Turn the container error into an Error handle
>   memory: allow memory_region_register_iommu_notifier() to fail
>=20
>  exec.c                        | 10 +++++--
>  hw/arm/smmuv3.c               | 18 ++++++------
>  hw/i386/amd_iommu.c           | 17 +++++++-----
>  hw/i386/intel_iommu.c         |  8 ++++--
>  hw/ppc/spapr_iommu.c          |  8 ++++--
>  hw/vfio/common.c              | 52 +++++++++++++++++++++++------------
>  hw/vfio/spapr.c               |  4 ++-
>  hw/virtio/vhost.c             |  9 ++++--
>  include/exec/memory.h         | 21 ++++++++++----
>  include/hw/vfio/vfio-common.h |  2 +-
>  memory.c                      | 31 +++++++++++++--------
>  11 files changed, 120 insertions(+), 60 deletions(-)
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--jKBxcB1XkHIR0Eqt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl2KGaIACgkQbDjKyiDZ
s5IJsBAA4ByxzmapOytirWyvauRs/FjonxgHXmwuqJqsr/5MIaYmY0zJI1wU+zhb
xnPgWFV82kFfb7MMkB6TDKGU86N9pGWhI/OfgF7nFru4Bpq14IoScIOiv7wNfURO
i0PK94kGk8Xi6IgphlcN8SKnOBc5YhLsdqLrIdWOb6aLuaPm6OhWNcC6i8nB/c4W
etIZQgO6Ynit3RN3u2C0f5pYRp/Un2frhjm8VDdzUzhcb57EJeH7Qmd7AsDl7Ch3
dc5Qjkkt/hDKBwg2W5VQBTe0qGDRFYoaE9HQ0XLLuA1zNP/tvQa+CSqwpMWyOxVR
l9qXQINaiJ4qJXmcPMAOJDz+oWVk7y1MBavOaJKhJF3UoBamdNGExGrmfga8ZxQG
t7F4Khwax9cyPnQ2tn3tNN8A1+HtA7LPAd21j380mkR9Kqw9+QEv+MDF6ClDJpH3
9ONN9dAzLjjciaqPAFd7ZFUHQ1fQcDBJ5Bncn7QIgCJq9igsDMup+pLSjQa9ePvC
p2Mat9LxSzIwFjYy8ZPRDrRfqtVzKXwsvzcQrA22m1BAvSQVE2sCg+tcbobEsCHR
D5C0gHQdX3m16UR261wHuGoOVMW3iCGXP4xLJhdMyks3KaiQVpYZVUASitv41dUO
WC2DdELF/B+KQzwberkA4hvcJyghOckORmm60nQnNRrdpFmblUs=
=wquf
-----END PGP SIGNATURE-----

--jKBxcB1XkHIR0Eqt--

