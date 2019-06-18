Return-Path: <SRS0=M8fn=UR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C56DFC31E5D
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 08:43:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B5F1206B7
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 08:43:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="ZrwXbbX0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B5F1206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54820 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hd9hm-0002Jh-OL
	for qemu-devel@archiver.kernel.org; Tue, 18 Jun 2019 04:43:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42982)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hd9gl-0001fD-MK
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 04:42:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hd9gk-00005n-MY
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 04:41:59 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:45365 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hd9gk-0008Ts-6C; Tue, 18 Jun 2019 04:41:58 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45ShQV2GL8z9s9y; Tue, 18 Jun 2019 18:41:53 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1560847314;
 bh=Hnc8vXDv3vxk4WvZDauksAGm3UjW4X8h8PTtPFXjVNA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ZrwXbbX0etBuWxg5mjCHeqGGmVhqHGrkUrp4zrrgZgatJ2Ydcg59KyWJ9rDmkoa9L
 1cF9iWHJKZbQLbILC7MyLTNsRNviVnBpHR1aBDGSHsWaDjBCnmBJqoqpbn2vx77utu
 hZTOFJcI7JCQ5YHY3KmXJberkIRSCpt2dGpkj1hA=
Date: Tue, 18 Jun 2019 18:41:48 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Message-ID: <20190618084148.GB3673@umbus.BigPond>
References: <156078063349.435533.12283208810037409702.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Fba/0zbH8Xs+Fj9o"
Content-Disposition: inline
In-Reply-To: <156078063349.435533.12283208810037409702.stgit@bahia.lan>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: Re: [Qemu-devel] [PATCH] xics: Add comment about CPU hotplug
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


--Fba/0zbH8Xs+Fj9o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 17, 2019 at 04:10:33PM +0200, Greg Kurz wrote:
> So that no one is tempted to drop that code, which is never called
> for cold plugged CPUs.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>

Applied, thanks.

> ---
>  hw/intc/xics.c |    1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/hw/intc/xics.c b/hw/intc/xics.c
> index 8535e583dd41..faa976e2f8a8 100644
> --- a/hw/intc/xics.c
> +++ b/hw/intc/xics.c
> @@ -363,6 +363,7 @@ static void icp_realize(DeviceState *dev, Error **err=
p)
>          return;
>      }
> =20
> +    /* Connect the presenter to the VCPU (required for CPU hotplug) */
>      if (kvm_irqchip_in_kernel()) {
>          icp_kvm_realize(dev, &err);
>          if (err) {
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Fba/0zbH8Xs+Fj9o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl0Io8kACgkQbDjKyiDZ
s5KXTxAAv/RwxWV2+bYPvWeiRqJ3QuQfKiA8ALV1tmsj5bRvt66bH22Ly4a3d1KL
GnFSnXjOq/FtKYezb0gb98qobqwfallGuMm0jwXi87P8h5qOolthBFBbx79l3X4s
wirHABoXe7MIs6Zz9QB0hITXJ2dVahtC/JLEsyKr8dsIPrxiOr0FmA9bmcfcrzoZ
Yjf+SCDUr17JhQ3aWruJohoINm7ET3MM5J474oBoV17Oalzrc1+JVrOZAWFDtHJ4
I1z7Zywq8/bymVK0qMPUowHIVbZ7oWfZoeDnCYyk+0967bh2WADr5cAFvE4nz8Fr
QOCkXcldLccSeAFRtTbkxgNV+RAga1wyqWhCWypUjE6oB1rfSA/ap/Wfogn0z+VE
gz20B0qN643sOupqxkUiRymbrkgtjb+rZzXiDRUvHap7DeB+62WiOzH3zzZHBmgc
bv7ZEamxInq2sKq8cVbmziZNX3I1bUWRNYo2DVHACLEVJJdLShbtTZmeXFajiaT/
s4c7sFv/cOjwHlJaT2cVbTmIDvWTADnAEwN4CNdga01N+ZNnx7fBfqcehx4+XejR
D8lCKO7SDqegNwrU44bk5nyWo75jZWCIVP14Av9SsnJask/AvMsgOoEI5etwzmsj
IWYqx0YvCsUxMIr+xc77APxHn0YC8tdaIlWL4Ki2/FoOGJVGI7Y=
=FPy0
-----END PGP SIGNATURE-----

--Fba/0zbH8Xs+Fj9o--

