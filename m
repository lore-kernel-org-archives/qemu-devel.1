Return-Path: <SRS0=SLMP=AQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5AC6C433E0
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2020 08:44:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80E49206B6
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2020 08:44:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="ZHjQh853"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80E49206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57696 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1js0G8-0005ur-Nz
	for qemu-devel@archiver.kernel.org; Sun, 05 Jul 2020 04:44:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36356)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1js0FV-0005FB-Sk; Sun, 05 Jul 2020 04:43:45 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:52939)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1js0FS-0006l3-3D; Sun, 05 Jul 2020 04:43:45 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4B02Kd4FfGz9sSJ; Sun,  5 Jul 2020 18:43:33 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1593938613;
 bh=Vdr+C7jMOZTKTqw46GAUMPvW/tZdesx/v+gEu7dJuEQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ZHjQh853bTzNSvfYDaziPwYJS1IQPGALZv7i+dVWeBQ8FinyZVlHyaL1g/sye2AEU
 K79+tWeFm9GYBnKDg29usaH2o/g9KGkeXbK6/KR+DxlTQyZ5FqGLchIzi4WWcJgJmo
 kpcSL1YOXuxR4mtCCebUeGn50c39fHseTOtH7Ie4=
Date: Sun, 5 Jul 2020 17:38:13 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH v3 8/9] spapr: PEF: block migration
Message-ID: <20200705073813.GA12576@umbus.fritz.box>
References: <20200619020602.118306-1-david@gibson.dropbear.id.au>
 <20200619020602.118306-9-david@gibson.dropbear.id.au>
 <20200626103303.GE3087@work-vm>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="YiEDa0DAkWCtVeE4"
Content-Disposition: inline
In-Reply-To: <20200626103303.GE3087@work-vm>
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
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: pair@us.ibm.com, brijesh.singh@amd.com, frankja@linux.ibm.com,
 kvm@vger.kernel.org, mst@redhat.com, cohuck@redhat.com, david@redhat.com,
 qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>,
 mdroth@linux.vnet.ibm.com, pasic@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-ppc@nongnu.org, pbonzini@redhat.com, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--YiEDa0DAkWCtVeE4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 26, 2020 at 11:33:03AM +0100, Dr. David Alan Gilbert wrote:
> * David Gibson (david@gibson.dropbear.id.au) wrote:
> > We haven't yet implemented the fairly involved handshaking that will be
> > needed to migrate PEF protected guests.  For now, just use a migration
> > blocker so we get a meaningful error if someone attempts this (this is =
the
> > same approach used by AMD SEV).
> >=20
> > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
>=20
> Do you expect this to happen if people run with -cpu host ?

Uh.. I don't really understand the question.  What's the connection
between cpu model and migration blocking?

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--YiEDa0DAkWCtVeE4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl8Bg2UACgkQbDjKyiDZ
s5LH7hAA5EZmRNXj1yivkiYNc1GtXGso5xsJ2GrV/CElKHDYr2mGDqCzzatQybF4
8obKns+u40a5L+QlnxwSo2HbH1svQ7/3y/mmUmgMIVqFaLDooWjjR0sp4GQnob83
AhhaSGD0HdwMH4sOvfKLTZzNoJ+GdIr3RWXArVRWxNG6DeWvdHKIzHE920Aj72dF
Mktk9hnrX2SIFgm0UJhIK5HP9U3gLaCHjsfO/asxjP5LbC4ZslVPZQrV1pD5Jehb
vDaFSkXKhlVdbnrfELub532PTJ5FRfDZb2OdKbO1AJyuZk4hbCinbc075PuOrmPB
sX/yW/Ho66UEhj5zZd7IxZ8NHMrbwBgXqh8I0pMKZ3Ml1tvoNtCMyJrH3lOR+RE6
yH4no8xbq/TF2NYKGQAwF9W1VZNeQYVBdaNpvr2F5ZMYIVDYFkOsmnS0XVZf9Qqx
qZmcpmvDdf4hiTE45eV9+mGPatvWbLcMCpvWEftOfOrGNbmsW8lF317GqXg4lAFo
mC04DVZczr5rFtEiX4RIYpF2QSh+SkESzqpXZgnSFTqT447X1ZDoXxBUx91q6EJX
ZlaacuLtRpl2wMasuvbqmjbnnAyoq/UEgH5BfA7LKptY0gOM74i7wgWsC+e3vuuf
L6GS4ETEKTen3kMjgW+o3NLRdFpgF5stP7mzdv5dsZhXtxEAWL0=
=kDum
-----END PGP SIGNATURE-----

--YiEDa0DAkWCtVeE4--

