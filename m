Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 274F2C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 01:48:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB4B620748
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 01:48:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="ZKVqEQIs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB4B620748
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56668 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8wAY-0005xP-7n
	for qemu-devel@archiver.kernel.org; Thu, 20 Aug 2020 21:48:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44496)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1k8w9i-0005JE-NM; Thu, 20 Aug 2020 21:47:47 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:36577 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1k8w9f-0004yQ-RQ; Thu, 20 Aug 2020 21:47:46 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4BXksz64TCz9sTR; Fri, 21 Aug 2020 11:47:35 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1597974455;
 bh=vQUkXkB/SIpxnANIoH2n+Xiy57oZhHTZHpRfkLRPKKY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ZKVqEQIsuvJYUrZjYZ4mIZhUXzRZONpnP96F0yxtAfE2Ro0avFLaXwjowBcjrCJ2n
 H8rQBjoV/ZsKcl7mnWf9DVBDtak8Tn67tuMznSrRKHVaj7z7bn1kYPeHSNNs258kbR
 9msXCDymfnlAzeZBa140CiwIS7t41w4TK0O1UdZM=
Date: Fri, 21 Aug 2020 11:47:32 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Eduardo Habkost <ehabkost@redhat.com>
Subject: Re: Suspicious QOM types without instance/class size
Message-ID: <20200821014732.GW271315@yekko.fritz.box>
References: <20200820215529.GH642093@habkost.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="XaepPZQT0uxAV0NY"
Content-Disposition: inline
In-Reply-To: <20200820215529.GH642093@habkost.net>
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>, qemu-block@nongnu.org,
 David Hildenbrand <david@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 =?iso-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>,
 Thomas Huth <thuth@redhat.com>, Alistair Francis <alistair@alistair23.me>,
 Cameron Esfahani <dirty@apple.com>, qemu-s390x@nongnu.org, qemu-arm@nongnu.org,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
 Richard Henderson <rth@twiddle.net>,
 "Daniel P. Berrange" <berrange@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Roman Bolshakov <r.bolshakov@yadro.com>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--XaepPZQT0uxAV0NY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 20, 2020 at 05:55:29PM -0400, Eduardo Habkost wrote:
> While trying to convert TypeInfo declarations to the new
> OBJECT_DECLARE* macros, I've stumbled on a few suspicious cases
> where instance_size or class_size is not set, despite having type
> checker macros that use a specific type.
>=20
> The ones with "WARNING" are abstract types (maybe not serious if
> subclasses set the appropriate sizes).  The ones with "ERROR"
> don't seem to be abstract types.


Comment on the ones within my area:
>=20
> WARNING: hw/input/adb.c:310:1: class_size should be set to sizeof(ADBDevi=
ceClass)?

Yeah, that looks like a bug (though we'll get away with it because
it's abstract).

> WARNING: hw/ppc/pnv_lpc.c:771:1: instance_size should be set to sizeof(Pn=
vLpcController)?

Ditto.

Should I make fixes for these, or will you?

> ERROR: hw/ppc/spapr_drc.c:771:1: instance_size should be set to sizeof(Sp=
aprDrc)?

I'm confused by this one.  I'm not exactly sure which definition is
tripping the error, and AFAICT they should all be correctly inheriting
instance_size from either TYPE_SPAPR_DR_CONNECTOR or
TYPE_SPAPR_DRC_PHSYICAL.  If anything, it looks like
TYPE_SPAPR_DRC_PHB could drop it's explicit override of instance_size.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--XaepPZQT0uxAV0NY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl8/J7QACgkQbDjKyiDZ
s5JTyRAAjB3I/c66lz1Uoq9AztTNzW16B3DDj7OZc22ILH3IqKkXWPAxaeiQG1CR
Ei3XqjFDX5i9o0xlh5PrkeRsR7qUQ2ULognYZw/5je+M8Lp0saTnwLcnFbIVWLg2
vnvP8whNThplc62cMilXtU3qSPE7aKTZDdBr4wJmdH9lvNiZHU4pPy0DZ/N6Rn/R
JSuYPYA7JwCGLul5GpagxaV0A+lvn6xV/UayacrlZz0WwDATSCDxREMIMPdvw+ZR
uyb2Leybmf5kMwTHtdji5PYg6Pxhq1ach1Eb3GopAX6ADpCZdTasaFSlpT3ejKf7
uLHsSRk6z8RYM6xlv/QePSf4DHip3/YQ7078NQO0WjpzqbealqcYP2/Z0xZGEPQf
lnfNVkg5MXY+MgwY56+gjhWDmc5C8dVeqc7bKkoDDb5VE6bWVBTUj+o8ck+M7tOg
xMVDmndJRZFYsP6/aVCPsYqYFl0dclxc3LbWJwB8oU/R9lRYSb+HC3O8Hm2vIO2V
GXPvFEcLTjgId/hKMDMusbx66Y4rIMz+Kwz/SieWSIsrwaE2vCR8DBYhLRkvFVDO
LOBoYCGmiulQWkyUE4J8KSVirvEfeuQqN44DlQ0SLTKjpehkLsf5pyWG/pTynLek
jRob8uuDWEols0ic0xGNq8xNbfZCu10opx+zbmmQ1hGfE51IQUQ=
=IFc/
-----END PGP SIGNATURE-----

--XaepPZQT0uxAV0NY--

