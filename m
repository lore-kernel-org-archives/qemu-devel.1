Return-Path: <SRS0=msIk=TG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43954C04AAA
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 03:53:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E52920675
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 03:53:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="L0h7r9XA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E52920675
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49830 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNUgs-0005qw-6P
	for qemu-devel@archiver.kernel.org; Sun, 05 May 2019 23:53:22 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34969)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hNUg6-0005Y1-FW
	for qemu-devel@nongnu.org; Sun, 05 May 2019 23:52:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hNUg5-0005SS-Dx
	for qemu-devel@nongnu.org; Sun, 05 May 2019 23:52:34 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:35581)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
	id 1hNUg3-0005Iu-OA; Sun, 05 May 2019 23:52:33 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
	id 44y82L2ybZz9s7T; Mon,  6 May 2019 13:52:26 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=gibson.dropbear.id.au; s=201602; t=1557114746;
	bh=DPS2/azZ0lOoZmqGSQ2sydFtQO1oq9bYg1uSSL35l2M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L0h7r9XAtVp4vbBl7GEQ0oqemTuNDhhEb+/GYPuErrcZGVs8oBAEzFBU2+wIRJorO
	x/FQZNoC20vXqrl8dtsExFQ4+KH0dkLdAXKbjdD95Krd6l+1R8YNOfFED+MsyisuzC
	EslPQ9qbRTR6Ibh/X+ePMXJcPmyxVN0WNzJivkH0=
Date: Mon, 6 May 2019 13:39:29 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <20190506033929.GE6790@umbus.fritz.box>
References: <20190501053522.10967-1-sjitindarsingh@gmail.com>
	<20190501053522.10967-2-sjitindarsingh@gmail.com>
	<11cb0515-7a96-99af-f33b-c752603a189d@ozlabs.ru>
	<20190502004346.GC13618@umbus.fritz.box>
	<c0917aef-79cc-f42c-2f4c-6d26da9657d6@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ILuaRSyQpoVaJ1HG"
Content-Disposition: inline
In-Reply-To: <c0917aef-79cc-f42c-2f4c-6d26da9657d6@ozlabs.ru>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2401:3900:2:1::2
Subject: Re: [Qemu-devel] [PATCH 2/2] ppc: Add dump-stack implementation
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: armbru@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
	Suraj Jitindar Singh <sjitindarsingh@gmail.com>, dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--ILuaRSyQpoVaJ1HG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 02, 2019 at 01:47:32PM +1000, Alexey Kardashevskiy wrote:
>=20
>=20
> On 02/05/2019 10:43, David Gibson wrote:
> > On Wed, May 01, 2019 at 07:48:48PM +1000, Alexey Kardashevskiy wrote:
> >>
> >>
> >> On 01/05/2019 15:35, Suraj Jitindar Singh wrote:
> >>> The monitor function dump-stack is used to dump the stack for a cpu.
> >>> This can be useful for debugging purposes when the stack cannot be
> >>> dumped by another means.
> >>>
> >>> Add a ppc implementation ppc_cpu_dump_stack().
> >>> The stack pointer is stored in R1 with the back pointer at offset 0 a=
nd
> >>> the link register at offset 2.
> >>> Also dump the registers from the stack frame if the marker "regshere"=
 is
> >>> found.
> >>
> >> Is this a Linux only marker? ABI does not mentioned this.
> >>
> >>> This only dumps the kernel stack, stopping if a non-kernel address is
> >>> found in the stack.
> >>
> >> Why enforce this limit?
> >=20
> > It's also making a Linux specific assumption about addresses.
>=20
> It does not have to if it used ppc_cpu_get_phys_page_debug(), the only
> linux specific left is that "regshere" marker, otherwise it could work
> for AIX or FreeBSD (obviously without the exception frame).

Sorry, I thought this was relying on the fact that Linux put its
linear mapping at 0xc0..., but I realized I was misreading what was
just the masking of the top two real mode address bits which is in the
hardware.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--ILuaRSyQpoVaJ1HG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlzPrG8ACgkQbDjKyiDZ
s5L2/xAApOtyvaSfFMbugkpli4eqrDtM02e9xf4UU/dWdJ27b9hKdkRVDZ29f3Vd
X8QxnOaXwfC4NUM48nx6ZQ8bqVeO1X47aZBG/bliVxF9BH+4TYN+fVCQXmIcK9pI
5tuEftHqdscdUIphb0CUJIfIocGXM+cpN5AFx9NWg9n7gXGyS1T7M1pNfG+DXody
1890LOnLeHIPlXAhY7gwzomDYCCxfWPnSHFMxXsvR2XAMYeWXHw29pgbMuZ1MJdJ
57li58L7UQQhBpo49jWwZNSjjWDa9vLM19q2jQsomYeiFSfOMBSbbqhrHzNlgeK0
3pmNkWt+FVZbJafSYcwH+NbBJmXZeADc88eu3fvstf39fAR+9RTaZ86duPF19nx8
bttN906WR4FG4N1t50a1bh23DNZ5am3WZ5emHhXLWc8wAHPV5VXxjUdSzPITWVZs
5D42c/7ngOjXRHNrayji6Tp6wNViN9TgQfBxDZuHthtrIat2oMn8aZhn9ul73F6u
zl1tu3OgM1r2HlAB6boHd0C3nxGgTAxvYK3CBtcy6sT6jp+P1LP7JhlC0eiVhP9X
f0m2TeJgXuh7ybBnwVvBi6o3dBpovkPIZ0/tbqJMLX0GpUA+orj893bcyuacaXgI
PjoD/niqCzmjIRyopTP8NKd7Phx013FoYpFTTbRen+IABuOQjY4=
=bRng
-----END PGP SIGNATURE-----

--ILuaRSyQpoVaJ1HG--

