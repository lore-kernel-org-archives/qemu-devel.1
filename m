Return-Path: <SRS0=I8Mx=26=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50BD2C33CA1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 04:28:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D843206ED
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 04:28:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="kLMpn67P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D843206ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55150 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipPQS-0004Wl-Qt
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 23:28:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37823)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1ipPOq-0003AJ-Lz
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 23:26:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1ipPOp-0000m1-8c
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 23:26:24 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:40861 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1ipPOn-0000cA-6D; Wed, 08 Jan 2020 23:26:23 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47tY2x5ff7z9sRf; Thu,  9 Jan 2020 15:26:17 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1578543977;
 bh=EXQm814lr0Y99/MtN92NerWNV6fM7OebiNW3uD1LPoc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=kLMpn67PjMNRQKyWUBj/2EeZnR7Yat1e2n/Mp52gy2c6FdMy+TnfuK/BqIbLEr8gx
 83O8nhH31O5i4MP3nu/QFi8kErSDXMuIZ1AU6q8ShG83dfc/e2Hne1dEkPa3p/dhxx
 guYBkggISdPK/8n6+tFgHkmyBz30gSP3ceiOep1c=
Date: Thu, 9 Jan 2020 15:25:13 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH qemu v2] spapr: Kill SLOF
Message-ID: <20200109042513.GO8586@umbus.fritz.box>
References: <20200105234242.78897-1-aik@ozlabs.ru>
 <20200106041940.GV2098@umbus>
 <835b2928-aff9-c2d1-dfdf-60d915706404@ozlabs.ru>
 <20200107055436.GI2098@umbus>
 <cf5bb030-167e-b073-f423-ea2f6c620b1f@ozlabs.ru>
 <90bb7907-5b81-45e4-b227-e037f41af67e@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="2VXyA7JGja7B50zs"
Content-Disposition: inline
In-Reply-To: <90bb7907-5b81-45e4-b227-e037f41af67e@ozlabs.ru>
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--2VXyA7JGja7B50zs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 08, 2020 at 04:53:06PM +1100, Alexey Kardashevskiy wrote:
>=20
>=20
> On 08/01/2020 15:20, Alexey Kardashevskiy wrote:
> >=20
> >=20
> > On 07/01/2020 16:54, David Gibson wrote:
> >> On Tue, Jan 07, 2020 at 03:44:35PM +1100, Alexey Kardashevskiy wrote:
> >>>
> >>>
> >>> On 06/01/2020 15:19, David Gibson wrote:
> >>>>> +
> >>>>> +static uint32_t client_package_to_path(const void *fdt, uint32_t p=
handle,
> >>>>> +                                       uint32_t buf, uint32_t len)
> >>>>> +{
> >>>>> +    char tmp[256];
> >>>>
> >>>> Fixed sized buffers are icky.  You could either dynamically allocate
> >>>> this based on the size the client gives, or you could use
> >>>> memory_region_get_ram_ptr() to read the data from the tree directly
> >>>> into guest memory.
> >>>
> >>> @len comes from the guest, I am really not comfortable with allocating
> >>> whatever (broken) guest requested. And if I limit @len by 1024 or
> >>> similar, then a fixed size buffer will do too, no?
> >>
> >> I see your point.  Does this call have a way to report failure?  In
> >> that case you could outright fail the call if it requests too long a
> >> length.
> >=20
> > It returns length which can be 0 to signal an error.
> >=20
> > but with this particular method the bigger problem is that I cannot know
> > in advance the actual path length from fdt_get_path(). I could double
> > the size until fdt_get_path() succeeded, just seems overkill here.
> >=20
> > Property names seem to be limited by 32:
>=20
>=20
> >>> len("ibm,query-interrupt-source-number")
> 33
>=20
> Awesome. Oh well :(

Yeah, as I suspected.  Also 'ibm,associativity-reference-points'.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--2VXyA7JGja7B50zs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl4WqykACgkQbDjKyiDZ
s5IyiA//Su9TCXAjHSLEe+oARhXuP+ctYu+IY5rz3bnm2/OBoz+beW7dwLXYD6Jr
EgwEsUw30oP/G9WCcE8pTNOYHgQFTPWbDhROw5WUEjnbWgLQ8tHiPj2NtAyJBiKC
V/bSDPKfXFQ8OtwqVHvwe8C33xGoPJVexeTlBjZ7eIHGK0p9RWKK0VR0iBQn3uCE
GwvR78N2xwjnmEKbl1nMpCySw+T6HezXhzlEMcm8XCXmK2vecwu5S6ulFbKWSDbd
mRXYJUi5T3o1D09dFnrO/p8KUVSMnMEspAMYrPIUYcCpRATTw7R/1z9qB9IrFeWu
bzt561aVjpA1M5fv7gTOU1JcSxW8HICET7xCPMAujRlAjB/BM+xEIMKXe5IfH8rL
lcEmVR9nOofdpaYZ9F2YabygAnXZ8ILjTwmGuok+e6cYaXLhd1aRBoIDWNWKh75D
nODADTVnFZAzllTG6Z+wd6E0AX+qGI8EL19MzNC13ivevHLiDRwfd99bE1Jq6xFf
UDq9rvK+0WsILI9bL6GrAhUKXYRG+CV6RYrrMDDS3HUMmA8qANyxYDq5UYClhJWf
5Af6Fb1UTqaY0Gz4fBqpC2o+carKxc9sLnxNnbU4NgGZoqzZSQYECdlSrXJH0tAw
wz4TxpOwMJ+GQcFoREPPkyokRMOSqTYJboY7ahPesTS758HzIhY=
=iRmw
-----END PGP SIGNATURE-----

--2VXyA7JGja7B50zs--

