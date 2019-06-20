Return-Path: <SRS0=JMAk=UT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D611C43613
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 08:54:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E48902084A
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 08:54:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="anhPzc+l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E48902084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44962 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdsq3-0005fb-BM
	for qemu-devel@archiver.kernel.org; Thu, 20 Jun 2019 04:54:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35916)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hdsjB-0006s7-5j
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 04:47:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hdsai-0000jN-KG
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 04:38:45 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:50269)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hdsah-0000gv-UN; Thu, 20 Jun 2019 04:38:44 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45TwFn0qw1z9s3l; Thu, 20 Jun 2019 18:38:37 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1561019917;
 bh=9NsnpEgppU3+ikl8XqTF8D4NAdjGkbJUVFGxYbZN+G8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=anhPzc+lGzbU+7BnEG2+TuWGP9VmJYvbjK7IWkZbStkI+bSRLJgBiEe4xR2mE41+0
 ifyFkfWmMIMyATGTeNOlty0vFoXDV6cNzGuCkuTVmGutNLuErghV2f1b5FB4YOGtNv
 ajvrSq/agIlbKtlF2tGJLLZbDbf1H2J6v/EGQkTo=
Date: Thu, 20 Jun 2019 18:32:57 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Message-ID: <20190620083257.GD8232@umbus.BigPond>
References: <156077918969.433243.1416211899441569578.stgit@bahia.lan>
 <156077922319.433243.609897156640506891.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="NklN7DEeGtkPCoo3"
Content-Disposition: inline
In-Reply-To: <156077922319.433243.609897156640506891.stgit@bahia.lan>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
Subject: Re: [Qemu-devel] [PATCH 6/6] xics/kvm: Add proper rollback to
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


--NklN7DEeGtkPCoo3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 17, 2019 at 03:47:03PM +0200, Greg Kurz wrote:
> Make xics_kvm_disconnect() able to undo the changes of a partial execution
> of xics_kvm_connect() and use it to perform rollback.
>=20
> Note that kvmppc_define_rtas_kernel_token(0) never fails, no matter the
> RTAS call has been defined or not.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>

Applied, thanks.

> ---
>  hw/intc/xics_kvm.c |   11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
>=20
> diff --git a/hw/intc/xics_kvm.c b/hw/intc/xics_kvm.c
> index 4bfbe1a84092..51433b19b076 100644
> --- a/hw/intc/xics_kvm.c
> +++ b/hw/intc/xics_kvm.c
> @@ -421,10 +421,7 @@ int xics_kvm_connect(SpaprMachineState *spapr, Error=
 **errp)
> =20
>  fail:
>      error_propagate(errp, local_err);
> -    kvmppc_define_rtas_kernel_token(0, "ibm,set-xive");
> -    kvmppc_define_rtas_kernel_token(0, "ibm,get-xive");
> -    kvmppc_define_rtas_kernel_token(0, "ibm,int-on");
> -    kvmppc_define_rtas_kernel_token(0, "ibm,int-off");
> +    xics_kvm_disconnect(spapr, NULL);
>      return -1;
>  }
> =20
> @@ -448,8 +445,10 @@ void xics_kvm_disconnect(SpaprMachineState *spapr, E=
rror **errp)
>       * removed from the list of devices of the VM. The VCPU presenters
>       * are also detached from the device.
>       */
> -    close(kernel_xics_fd);
> -    kernel_xics_fd =3D -1;
> +    if (kernel_xics_fd !=3D -1) {
> +        close(kernel_xics_fd);
> +        kernel_xics_fd =3D -1;
> +    }
> =20
>      kvmppc_define_rtas_kernel_token(0, "ibm,set-xive");
>      kvmppc_define_rtas_kernel_token(0, "ibm,get-xive");
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--NklN7DEeGtkPCoo3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl0LRLgACgkQbDjKyiDZ
s5KCNw//ccbyeQ7hfd1oQtxgYOEKwyWeV9LcW0KZivVHjQeXVdvSrlZEYu/dMgoO
nM9n/ATgM6XQObscQUiMbHaxwzGMzVlyAqIS6ZHNU26y+JRICRiXVK66iUktnDa8
mcqb80PlPceBc26zWaYNtheeXc8sljOqYz0a2ncMLXlsxiUHAfUb1k5YVX5N+b7R
+eNi/41kqw5JwNvtAj7cjrgg8S9ukZCkXi5sdDw8WTQ8Y+ZmP9ijJYXKjUkeZnfG
c6S98oWyfo9uDq93U82dj3pLyzniVw607jbC1FrMBSGOKnqqOMEPh3HXASSGqtze
zXD1GCMfAa4u+BlY3swcsVx3pMXT/h1e9KykNAfSIBlIkfF8KjpZGBUAg5PptsY8
pMMdYN9on028Vqt2aMPcB1dhnnIUFhnsZy+ncneGrp0RV1xBFxAUroGIVhK46uWw
59xpbAPkY2+LA3NMyrUxrNH//ZsIuYKNKE5i7T7zQTuC3ATwvZ2odMdyUj6Uhk59
i0JSfoJxxct4B1EtxSeybo6UM7Ha88KxfO7HOqVYJVQ7AvizgHVyjQRFHJma4T0w
ZY75ytbq+EaKsLdZyoqE8WCzNpPNh0aaL+BAk91ZMpkGtotVGt7i7/9zsscY7JFv
1Wszx1IqNj77OEFRKaRjqEkX7Za2t6dGKjieYoqZcMlsCltgrvE=
=zVmS
-----END PGP SIGNATURE-----

--NklN7DEeGtkPCoo3--

