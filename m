Return-Path: <SRS0=JMAk=UT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55083C43613
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 08:21:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 219482084A
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 08:21:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="JXtHBF6T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 219482084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44764 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdsKF-0004qq-0F
	for qemu-devel@archiver.kernel.org; Thu, 20 Jun 2019 04:21:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57563)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hdsGb-0001oZ-WB
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 04:17:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hds63-0004No-DI
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 04:07:08 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:39071)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hds61-0004E1-8a; Thu, 20 Jun 2019 04:07:03 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45TvY41S1qz9sBr; Thu, 20 Jun 2019 18:06:47 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1561018008;
 bh=pAHxKNQBu0oBz4CWXaUdLCyJ8LWNI1GsGG0P2dBZ2b8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=JXtHBF6TSKrjU+1Xuoc3S0mByRtfrsFrUTGxemyZZwc8+LZwIB6DjcZz0QZlGwAG3
 2uTtpIVdawfqL3yRc2EcMkBc7IBOl7qs0hHAsHmYyfsT44PyDQ8QyXFUr8hG+okMxS
 jIMj7xPKzEYmQT5oLvypReJh3psaC/CXtbx0jjjU=
Date: Thu, 20 Jun 2019 18:05:50 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Message-ID: <20190620080550.GB8232@umbus.BigPond>
References: <156077918969.433243.1416211899441569578.stgit@bahia.lan>
 <156077921212.433243.11716701611944816815.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="2B/JsCI69OhZNC5r"
Content-Disposition: inline
In-Reply-To: <156077921212.433243.11716701611944816815.stgit@bahia.lan>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
Subject: Re: [Qemu-devel] [PATCH 4/6] xics/kvm: Always use local_err in
 xics_kvm_init()
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
Cc: qemu-ppc@nongnu.org, =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--2B/JsCI69OhZNC5r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 17, 2019 at 03:46:52PM +0200, Greg Kurz wrote:
> Passing both errp and &local_err to functions is a recipe for messing
> things up.
>=20
> Since we must use &local_err for icp_kvm_realize(), use &local_err
> everywhere where rollback must happen and have a single call to
> error_propagate() them all. While here, add errno to the error
> message.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>

Applied, thanks.

> ---
>  hw/intc/xics_kvm.c |   16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
>=20
> diff --git a/hw/intc/xics_kvm.c b/hw/intc/xics_kvm.c
> index 377ff88701c2..c9e25fb051bb 100644
> --- a/hw/intc/xics_kvm.c
> +++ b/hw/intc/xics_kvm.c
> @@ -353,32 +353,36 @@ int xics_kvm_connect(SpaprMachineState *spapr, Erro=
r **errp)
> =20
>      rc =3D kvmppc_define_rtas_kernel_token(RTAS_IBM_SET_XIVE, "ibm,set-x=
ive");
>      if (rc < 0) {
> -        error_setg(errp, "kvmppc_define_rtas_kernel_token: ibm,set-xive"=
);
> +        error_setg_errno(&local_err, -rc,
> +                         "kvmppc_define_rtas_kernel_token: ibm,set-xive"=
);
>          goto fail;
>      }
> =20
>      rc =3D kvmppc_define_rtas_kernel_token(RTAS_IBM_GET_XIVE, "ibm,get-x=
ive");
>      if (rc < 0) {
> -        error_setg(errp, "kvmppc_define_rtas_kernel_token: ibm,get-xive"=
);
> +        error_setg_errno(&local_err, -rc,
> +                         "kvmppc_define_rtas_kernel_token: ibm,get-xive"=
);
>          goto fail;
>      }
> =20
>      rc =3D kvmppc_define_rtas_kernel_token(RTAS_IBM_INT_ON, "ibm,int-on"=
);
>      if (rc < 0) {
> -        error_setg(errp, "kvmppc_define_rtas_kernel_token: ibm,int-on");
> +        error_setg_errno(&local_err, -rc,
> +                         "kvmppc_define_rtas_kernel_token: ibm,int-on");
>          goto fail;
>      }
> =20
>      rc =3D kvmppc_define_rtas_kernel_token(RTAS_IBM_INT_OFF, "ibm,int-of=
f");
>      if (rc < 0) {
> -        error_setg(errp, "kvmppc_define_rtas_kernel_token: ibm,int-off");
> +        error_setg_errno(&local_err, -rc,
> +                         "kvmppc_define_rtas_kernel_token: ibm,int-off");
>          goto fail;
>      }
> =20
>      /* Create the KVM XICS device */
>      rc =3D kvm_create_device(kvm_state, KVM_DEV_TYPE_XICS, false);
>      if (rc < 0) {
> -        error_setg_errno(errp, -rc, "Error on KVM_CREATE_DEVICE for XICS=
");
> +        error_setg_errno(&local_err, -rc, "Error on KVM_CREATE_DEVICE fo=
r XICS");
>          goto fail;
>      }
> =20
> @@ -393,7 +397,6 @@ int xics_kvm_connect(SpaprMachineState *spapr, Error =
**errp)
> =20
>          icp_kvm_realize(DEVICE(spapr_cpu_state(cpu)->icp), &local_err);
>          if (local_err) {
> -            error_propagate(errp, local_err);
>              goto fail;
>          }
>      }
> @@ -410,6 +413,7 @@ int xics_kvm_connect(SpaprMachineState *spapr, Error =
**errp)
>      return 0;
> =20
>  fail:
> +    error_propagate(errp, local_err);
>      kvmppc_define_rtas_kernel_token(0, "ibm,set-xive");
>      kvmppc_define_rtas_kernel_token(0, "ibm,get-xive");
>      kvmppc_define_rtas_kernel_token(0, "ibm,int-on");
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--2B/JsCI69OhZNC5r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl0LPl4ACgkQbDjKyiDZ
s5I1zBAAsoeEVPsOMzNxSCQ0xarTceTCWbPe9qE5iQ8k0O1BztL3R+YEhm1ZeZ6j
oLiYLSafUG2ouY/EbEKa5H2vdOZH3PmjHEiEoDdqYBKbTgwGCLueefieMUSOWBmg
qmI3rnG5ec+MH90mRCZKLAj1zrV9EMhxKT5cZ67mjrWLpVW5hQCe8atntV6WiqH+
5b0+52tDp3YJUHeLlAyBcpLE+fiWDkFrO7jSBtVrNwDDCIl9WiGZCVsT9FlgdtCp
ioIcWjN2Zn4M1RloNro1fFhEeDb+YxVdmtKhaQf2mxMliqsJfowbcxI58he3bPkV
IxPKcfwAYJdjOuPbcT55mIQYrm6q+jDrxdvmufvxNHc7VyU7Q4VgL++NiFPOSwJu
7GRKvZiIdTSIkc6vjBk8FeqCzXCB8afUzo3qhzkBQe9yLOeVIbK6fKNLvak1Lonj
l4i4ZthK8sEGx0h32SdThXJBpCT5OO05sYqX1hpyo8MylyFlZWRgE/mlXUNtGYM9
fL6C6u8icXT4O0VKReg/q6aqaP+tbPW/3yRDvUJmV1sQR46OfnjjsPJpS+Tht79B
u1x48CXp6sVRCguHFw64YxrqpN8ER+IUR/AGSABhOKdlJKy0RFhxwYgYoXavjiWJ
HiuRcN8Tp32BVvaUV5DP2FLFxxYNOgRhj3e4Cykpeop4/NzpmlQ=
=oHui
-----END PGP SIGNATURE-----

--2B/JsCI69OhZNC5r--

