Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 305BBC433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 12:06:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE02C22D0B
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 12:06:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="iN+gbERK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE02C22D0B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52400 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3YDN-0004i4-D3
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 01:13:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50700)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1k3YBC-0001Cf-23; Thu, 06 Aug 2020 01:11:02 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:37343)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1k3YB7-0001co-JR; Thu, 06 Aug 2020 01:11:01 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4BMc5M68V4z9sTC; Thu,  6 Aug 2020 15:10:47 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1596690647;
 bh=G3AM0gX6ZJSimohEw+nhxLaaoGsD8r3DtaCIdDY11Ko=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=iN+gbERKSBh44Oj4k1isC5Hri8hVz7K90wUNPFb6p2dr/X9Y/Z7LdALxz2ZGdbePx
 GcBX+juGfKXoqmBl9/rAx3ofZmjBvE23NAJNqn7u/gyqZEkSZ0NlHGxepsGUOIXGSX
 WMCgEHhje+C5dzWeiCeDUCk+LnbKbEum+njUJTPs=
Date: Thu, 6 Aug 2020 15:05:32 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH for-5.2 1/5] spapr/xive: Fix xive->fd if
 kvm_create_device() fails
Message-ID: <20200806050532.GA100968@yekko.fritz.box>
References: <159664891296.638781.18417631893299150932.stgit@bahia.lan>
 <159664892278.638781.2910775856690967369.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="5vNYLRcllDrimb99"
Content-Disposition: inline
In-Reply-To: <159664892278.638781.2910775856690967369.stgit@bahia.lan>
Received-SPF: pass client-ip=2401:3900:2:1::2; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
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
Cc: Daniel Henrique Barboza <danielhb@linux.ibm.com>, qemu-ppc@nongnu.org,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--5vNYLRcllDrimb99
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 05, 2020 at 07:35:22PM +0200, Greg Kurz wrote:
> If the creation of the KVM XIVE device fails for some reasons, the
> negative errno ends up in xive->fd, but the rest of the code assumes
> that xive->fd either contains an open fd, ie. positive value, or -1.
>=20
> This doesn't cause any misbehavior except kvmppc_xive_disconnect()
> that will try to close(xive->fd) during rollback and likely be
> rewarded with an EBADF.
>=20
> Only set xive->fd with a open fd.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>

Applied to ppc-for-5.2.

> ---
>  hw/intc/spapr_xive_kvm.c |    8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>=20
> diff --git a/hw/intc/spapr_xive_kvm.c b/hw/intc/spapr_xive_kvm.c
> index edb7ee0e74f1..d55ea4670e0e 100644
> --- a/hw/intc/spapr_xive_kvm.c
> +++ b/hw/intc/spapr_xive_kvm.c
> @@ -745,6 +745,7 @@ int kvmppc_xive_connect(SpaprInterruptController *int=
c, uint32_t nr_servers,
>      size_t esb_len =3D (1ull << xsrc->esb_shift) * xsrc->nr_irqs;
>      size_t tima_len =3D 4ull << TM_SHIFT;
>      CPUState *cs;
> +    int fd;
> =20
>      /*
>       * The KVM XIVE device already in use. This is the case when
> @@ -760,11 +761,12 @@ int kvmppc_xive_connect(SpaprInterruptController *i=
ntc, uint32_t nr_servers,
>      }
> =20
>      /* First, create the KVM XIVE device */
> -    xive->fd =3D kvm_create_device(kvm_state, KVM_DEV_TYPE_XIVE, false);
> -    if (xive->fd < 0) {
> -        error_setg_errno(errp, -xive->fd, "XIVE: error creating KVM devi=
ce");
> +    fd =3D kvm_create_device(kvm_state, KVM_DEV_TYPE_XIVE, false);
> +    if (fd < 0) {
> +        error_setg_errno(errp, -fd, "XIVE: error creating KVM device");
>          return -1;
>      }
> +    xive->fd =3D fd;
> =20
>      /* Tell KVM about the # of VCPUs we may have */
>      if (kvm_device_check_attr(xive->fd, KVM_DEV_XIVE_GRP_CTRL,
>=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--5vNYLRcllDrimb99
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl8rj5oACgkQbDjKyiDZ
s5K26w/+MuuyGIsTb/9o3UpaM9e3+K7ktotORBr0isIWnpsyafU8R0TtUlbZpeGv
ODyUURbzXnugih6ySEqjMFzzCJ4QTofd+QcL9jwiAa3ebZMxs8YOl+ETUxrA1MaI
3Q9MFtX+KYAMZfm1ZiZrAsxWG+hpSFKrnnoJN3eerK9myA9DPxCT+wl/2AJzAwAG
oKQDKM1nrcRjdK9NeecjLNmkn6CzZuY+UNfRcdZki5WKT8t/tHT429d1BHDghlKa
Fv8nqJvyAEomhe4xKGuyJ269QqVNvkB1ZyhOZgX0PnpAis+quPgwm/ezgfzF30Cc
doCDV+qX2s42EMhFtN1Snm8BoC2Pgv+PKU3ezazycrS5/ddy/dZonnGPIvvQoJf7
AjgOnzt1eqxIWpd9chYBqnBkwCbj7ifqExWFd8CEeT+olASJW7fiN6nFb8P1ScaZ
Bi8ed7k8fnvCbUUj/743FDFxmCTjG5/jN7HBdNGi9VHe45ifH8nn+pnrl+z92IeX
FEpUl2ejX9RmBEAcFbkQwmJ2ty0EkwbhDGoadEB9YoA/UcBTpGJL3MI7Gxo5Elaj
TOzinwXvSDnkrkxnpovEyyTUx7j0tYUY20jekPJzrGMR1NtQjMlaJTJIXSc4MVc6
6n9rF+y6YUGubSCYzfRL2aBzjaOimOL6gdEl9aIIvNF8v7XKJvc=
=fVHd
-----END PGP SIGNATURE-----

--5vNYLRcllDrimb99--

