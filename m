Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68CB3C2D0CD
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 03:33:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 368DE206EE
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 03:33:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="CUHCqvr9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 368DE206EE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49080 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihQ5A-0005XR-0G
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 22:33:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37418)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1ihQ3d-000474-Hh
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 22:31:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1ihQ3c-0005R1-59
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 22:31:29 -0500
Received: from ozlabs.org ([2401:3900:2:1::2]:48519)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1ihQ3b-0005N0-Kv; Tue, 17 Dec 2019 22:31:28 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47d0sl09Lpz9sS6; Wed, 18 Dec 2019 14:31:22 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1576639883;
 bh=Gss6K6ltp6AQ4fparrvxWMr2b7gq/MsAJysRiya3ZsM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=CUHCqvr9q3afxbZTU+VGi9mK5kcW14Agl7B1S3mdKpooKg8IRM2bKgv50sQe6ikI3
 IynPHSbHzcQ45vhvGDQcnVZyt0ZG7mUWw8+oK5q++eIkAzJoIMY8oUEYVSnjVwa9Gq
 1nCaGjxyhQVQVOUj5378fGPrnPZ4rYCQUWFvJsv8=
Date: Wed, 18 Dec 2019 14:12:48 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PULL 51/88] ppc: well form kvmppc_hint_smt_possible error hint
 helper
Message-ID: <20191218031248.GQ6242@umbus.fritz.box>
References: <20191217044322.351838-1-david@gibson.dropbear.id.au>
 <20191217044322.351838-52-david@gibson.dropbear.id.au>
 <877e2vpimo.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="OwXh6gFRjCd3qPCM"
Content-Disposition: inline
In-Reply-To: <877e2vpimo.fsf@dusky.pond.sub.org>
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
Cc: lvivier@redhat.com, peter.maydell@linaro.org,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, aik@ozlabs.ru,
 qemu-devel@nongnu.org, groug@kaod.org, qemu-ppc@nongnu.org, clg@kaod.org,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--OwXh6gFRjCd3qPCM
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 17, 2019 at 07:32:15AM +0100, Markus Armbruster wrote:
> David Gibson <david@gibson.dropbear.id.au> writes:
>=20
> > From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> >
> > Make kvmppc_hint_smt_possible hint append helper well formed:
> > rename errp to errp_in, as it is IN-parameter here (which is unusual
> > for errp), rename function to be kvmppc_error_append_*_hint.
> >
> > Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> > Reviewed-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
> > Message-Id: <20191127191434.20945-1-vsementsov@virtuozzo.com>
> > Reviewed-by: Greg Kurz <groug@kaod.org>
> > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
>=20
> Review led to the commit message to be replaced for this and related
> patches.  It's in my "[PULL 00/34] Error reporting patches for
> 2019-12-16".  No big deal, but if you respin, either steal that message
> or drop this patch.

Uh, sorry.  I realized moments before sending this that this patch had
been updated.  I didn't want to re-do all my pre-pull testing, though
and it's not actually harmful, so I left it.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--OwXh6gFRjCd3qPCM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl35mTAACgkQbDjKyiDZ
s5KILA//el4VU4R1/43j+4M7ZKoK3IdrQd5kAlmaDa/Qnu3v4QawucngpIbPJyTz
21IVoATfnfl/TIHGMPLUvh9NbWTH0QjVuOEVWTwQj+MLOCcs/UdWFCQDX3nrKK8i
nfWblsdpftG2hsEtFwATa+CyLrZ9lwvQSY1ankkL9F45ufmBn+UOke+ofdvPBQ7w
sjFypEpUvVP3wULalnOIdxVBZPtzKdKEsEYtfQEfKi5ROkoqAznqbUzFpM7jWes3
naSxRrEFzLqpfSfgAhhRqlo6n3P7HucgpsJX+e0RtiP2Lio0TOnU5OLYLbrAbv2f
kYZVbAf6xUR1CNcsSjOSRtVCCYpYm/xvjsqcBLFY+gUiZU9I8Aq0jFk0/S9LcONh
BtZzWPJTj1M+iWEmop61XI8zTFo9ma2XYxmLFTioKWQC4qpU0z7j7vOz8nWF0hEJ
tHr7vQTjBfHoqBOSD1x6keToMU0tKipTzzQUArKMRSZbe8vB3/QQNwJQQxY/Nn1W
hegox8/ck99iJ37FwOOQ1rbY+yiiWEr8o4I1p1vDNNO39Xz6GQIFy38aSIbYhILt
8lCz3ygCtyHW5yIpI672SzXHAR/gW/Be9vAHAtMkfu89+o75BKKmNuu+IbdlkPp1
stLKp0Gh8a4IvNHydlZmeZxB0WjQtCrqw5NJ68TGYIN6Kh1qW+I=
=55vT
-----END PGP SIGNATURE-----

--OwXh6gFRjCd3qPCM--

