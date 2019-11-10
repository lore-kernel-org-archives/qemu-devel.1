Return-Path: <SRS0=zNqU=ZC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94308C43331
	for <qemu-devel@archiver.kernel.org>; Sun, 10 Nov 2019 21:12:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F6F1206C3
	for <qemu-devel@archiver.kernel.org>; Sun, 10 Nov 2019 21:12:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="G+WeiNyy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F6F1206C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46906 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iTuVX-0000Fr-A8
	for qemu-devel@archiver.kernel.org; Sun, 10 Nov 2019 16:12:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55942)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iTuU9-0007FK-I1
 for qemu-devel@nongnu.org; Sun, 10 Nov 2019 16:11:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iTuU7-0004kx-OI
 for qemu-devel@nongnu.org; Sun, 10 Nov 2019 16:11:00 -0500
Received: from ozlabs.org ([2401:3900:2:1::2]:53733)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iTuU6-0004Uz-Nu; Sun, 10 Nov 2019 16:10:59 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47B69g6Srqz9sPc; Mon, 11 Nov 2019 08:10:47 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1573420247;
 bh=Cxi8Y/8RcsyxS3Cbmyx3hq5e3TOtKkWnlndvJ9l7arc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=G+WeiNyydhrGD+Jz3duv6+n58GC9rc19+CyRqPmlcYjX3YWgHD/AxXnrUcvZQXu4u
 bcYiyVFhgxNViyAXaTIXX02l7HuYhE1zR+mmHd6MCiUQm3nsWTXbLS6qyyTisz77g5
 Frz9CRu2yui3OBRsDenoYkqbrvrZbaYhsgcjIYkE=
Date: Sun, 10 Nov 2019 19:44:24 +0000
From: David Gibson <david@gibson.dropbear.id.au>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v2 1/3] device_tree: Add a helper function for string
 arrays
Message-ID: <20191110194424.GR2461@umbus.Home>
References: <20191108194758.17813-1-palmer@dabbelt.com>
 <20191108194758.17813-2-palmer@dabbelt.com>
 <CAFEAcA_3jgn1WrX2wpBd+sCYe=nNaqA2POvaZkj-NsSyT2N9bQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="4ECF1u7dKBoUGhe3"
Content-Disposition: inline
In-Reply-To: <CAFEAcA_3jgn1WrX2wpBd+sCYe=nNaqA2POvaZkj-NsSyT2N9bQ@mail.gmail.com>
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
Cc: Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, QEMU Developers <qemu-devel@nongnu.org>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--4ECF1u7dKBoUGhe3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 09, 2019 at 03:59:24PM +0000, Peter Maydell wrote:
> On Fri, 8 Nov 2019 at 19:48, Palmer Dabbelt <palmer@dabbelt.com> wrote:
> >
> > The device tree format allows for arrays of strings, which are encoded
> > with '\0's inside regular strings.  These are ugly to represent in C, so
> > the helper function represents them as strings with internal '\0's that
> > are terminated with a double '\0'.  In other words, the array
> > ["string1", "string2"] is represeted as "string1\0string2\0".
> >
> > The DTB generated by this function is accepted by DTC and produces an
> > array of strings, but I can't find any explicit line in the DT
> > specification that defines how these are encoded.
>=20
> > +/*
> > + * This uses a particularly odd encoding: "strings" is a list of strin=
gs that
> > + * must be terminated by two back-to-back '\0' characters.
> > + */
> > +int qemu_fdt_setprop_strings(void *fdt, const char *node_path,
> > +                             const char *property, const char *strings=
);
>=20
> The clean API for this would be to use varargs so you could write
>=20
> qemu_fdt_setprop_stringlist(fdt, node, prop, "arm,armv8-timer",
>                             "arm,armv7-timer");
>=20
> and have it do the assembly into the encoding that fdt expects.
> That would require us to do a bit of allocation-and-freeing
> to assemble the string, of course, but then we only do fdt
> creation at startup.

Right, I really don't see the value in this interface.  Using
"foo\0bar" is a little ugly, but not really any uglier than
"foo\0bar\0".  The existing interface would be a drag if you had
dynamically created entries in the list (because getting the size
can't be done with sizeof() then), but I don't think that's actually a
very likely usecase.

> NB: I think that this is a good idea but not-for-4.2 material,
> so if you wanted your sifive board change to go into 4.2 you
> should probably start with the simple approach and leave the
> refactoring for the next release cycle.

I concur.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--4ECF1u7dKBoUGhe3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl3IaJgACgkQbDjKyiDZ
s5LW6xAAk4fPP8yllNJNbVkErUk5Zvv5iEm1EGcV2RnOFbCH4qoouA0ojTtxT25B
io/hESOQv3tOBL4paNkvsSk/f3ucU7WG/HB4b0gnuDdcSSQ3+2jj+tr3StXIYfU1
zHTzIabKqX58x4fVA4qbNVrpybgFPvwF73SkcZ7N6ZNQkHvvDzHUOWP23ekBjzQ4
z5O9WJmmDoDtncN14Y9+of5GIv6GNkr6szftuerp5EyS8gblNf81m/X63t6GbNqg
MPnP5bCkqE/8tBFR2xM6HBryFb3FYGC1AiLTjPh4c9bQbdkh8qMtdj1Z3u0/LS0t
kiKLHCYQiIQ6mLGjqsX6E+nM+7tWe3a7c4mWkacUo2A0hKYFKOpf/IVdcMtKpuc7
zQGQCsfyWB0SMh0SVNwuN5yxa9MS1BFQKNEBBIezpQ0Lhb/M5OQN1Z2ehhs2xnIO
dsplEYxTw2gmFbnftD2ty2BsU6OBvKEG8rK+JmbchPwi8NcPutlSPHs2sNQb0YHG
rEc/Jqam+jbj2Ja1xPc16vN+mxBZNE3DZbWokO7DvmDjEuf2Oy/GkjmV9Ymzp8qv
vCrCUhKRRQsdVvKXTbtv0pEtYMpld/guVDMbCxy96gtqdWiIZoQhJbVTK5fp6Z1e
zc3YFC7LO3XCi8PDTeJPsGgv5bjnxzo0Vq2ooASzbY4TXlYQOdY=
=Cq9U
-----END PGP SIGNATURE-----

--4ECF1u7dKBoUGhe3--

