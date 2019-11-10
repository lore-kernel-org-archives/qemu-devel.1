Return-Path: <SRS0=zNqU=ZC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74D1FC43331
	for <qemu-devel@archiver.kernel.org>; Sun, 10 Nov 2019 21:12:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3862C206C3
	for <qemu-devel@archiver.kernel.org>; Sun, 10 Nov 2019 21:12:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="k6iGp5/8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3862C206C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46902 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iTuVS-00007w-3b
	for qemu-devel@archiver.kernel.org; Sun, 10 Nov 2019 16:12:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55944)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iTuU9-0007FL-Ad
 for qemu-devel@nongnu.org; Sun, 10 Nov 2019 16:11:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iTuU7-0004l3-RB
 for qemu-devel@nongnu.org; Sun, 10 Nov 2019 16:11:01 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:35799 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iTuU6-0004VK-J2; Sun, 10 Nov 2019 16:10:59 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47B69h2wSwz9sPn; Mon, 11 Nov 2019 08:10:47 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1573420248;
 bh=27jGD5TWiQBF/fV8akQUfTkbtCwRFj5H7+m3ZwUM12I=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=k6iGp5/8N3/qasUlgALVNnOr6owFfjG7iNRu9FcSxOPRFCesbPUijha2rRdiGE3zS
 moZPPpKE4AS+/GkS7W47AhzZKpmcLcaeYm3mXQNGBjL4q7dmb6zipbUv2+TpnzIWx+
 A2p8HrnyXJ+TGQKFW11JkcIElWRzBClb/4iAEeMM=
Date: Sun, 10 Nov 2019 21:09:36 +0000
From: David Gibson <david@gibson.dropbear.id.au>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH] RISC-V: virt: This is a "sifive,test1" test finisher
Message-ID: <20191110210936.GT2461@umbus.Home>
References: <20191107222500.8018-1-palmer@sifive.com>
 <CAKmqyKOodh3tPUGBM92ZRWFLoeo9E=kcaqO9F9dHz1wBMP9ywA@mail.gmail.com>
 <CAFEAcA8k+t2qKCSvMjENitvCXyc-qwiG2qbg6gQFKR_+v_zihg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="ZXzThk3vFZecBD04"
Content-Disposition: inline
In-Reply-To: <CAFEAcA8k+t2qKCSvMjENitvCXyc-qwiG2qbg6gQFKR_+v_zihg@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Palmer Dabbelt <palmer@sifive.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Christoph Hellwig <hch@infradead.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair23@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--ZXzThk3vFZecBD04
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 08, 2019 at 06:04:47PM +0000, Peter Maydell wrote:
> On Fri, 8 Nov 2019 at 17:15, Alistair Francis <alistair23@gmail.com> wrot=
e:
> >
> > On Fri, Nov 8, 2019 at 9:05 AM Palmer Dabbelt <palmer@sifive.com> wrote:
> > >
> > > The test finisher implements the reset command, which means it's a
> > > "sifive,test1" device.  This is a backwards compatible change, so it's
> > > also a "sifive,test0" device.  I copied the odd idiom for adding a
> > > two-string compatible field from the ARM virt board.
> > >
> > > Fixes: 9a2551ed6f ("riscv: sifive_test: Add reset functionality")
> > > Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
> > > Signed-off-by: Palmer Dabbelt <palmer@dabbelt.com>
> > > ---
> > >  hw/riscv/virt.c | 5 ++++-
> > >  1 file changed, 4 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> > > index 23f340df19..74f2dce81c 100644
> > > --- a/hw/riscv/virt.c
> > > +++ b/hw/riscv/virt.c
> > > @@ -359,7 +359,10 @@ static void create_fdt(RISCVVirtState *s, const =
struct MemmapEntry *memmap,
> > >      nodename =3D g_strdup_printf("/test@%lx",
> > >          (long)memmap[VIRT_TEST].base);
> > >      qemu_fdt_add_subnode(fdt, nodename);
> > > -    qemu_fdt_setprop_string(fdt, nodename, "compatible", "sifive,tes=
t0");
> > > +    {
> > > +        const char compat[] =3D "sifive,test1\0sifive,test0";
> >
> > Does this really work? Why not use qemu_fdt_setprop_cells()?
> >
> > Alistair
> >
> > > +        qemu_fdt_setprop(fdt, nodename, "compatible", compat, sizeof=
(compat));
> > > +    }
>=20
> qemu_fdt_setprop_cells() is for "set this property to
> contain this list of 32-bit integers" (and it does a byteswap
> of each 32-bit value from host to BE). That's not what
> you want for a string (or a string list, which is what
> we have here).

Yes.

> Cc'ing David Gibson who's our device tree expert to see if there's
> a nicer way to write this.

Not amongst the qemu wrappers AFAIK.  With raw libfdt you could build
it up in stages using fdt_setprop_string() followed by
fdt_appendprop_string(), although that would require additional
memmove()s to complete.

A stringlist setprop function using varargs might be a useful addition
to libfdt.  The tricky bit is that libfdt can be used in environments
with no allocator, which makes implementation tricky.

> Oddly, given that it's used in the
> ubiquitous 'compatible' prop, the dtc Documentation/manual.txt
> doesn't say anything about properties being able to be
> 'string lists', only 'strings', '32 bit numbers', 'lists of
> 32-bit numbers' and 'byte sequences'.

Oof, yeah that manual hasn't really been updated for ages.  That
really only describes the pieces from which a property can be mode.
You can then concatenate those together using ,.  So in .dts you can
make a string list as:
	compatible =3D "foo", "bar";

The , is effectively a bytestring append operator.

> You have to dig through
> the header file comments to deduce that a string list is
> represented by a string with embedded NULs separating
> each list item.

Well, you can do that as well, but using commas is more common in
modern dts files.  The two are equivalent by construction (in .dtb
properties are simply bytestrings).

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--ZXzThk3vFZecBD04
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl3IfI0ACgkQbDjKyiDZ
s5IcwQ//R3PuqO0pSG0oTfDVlyla+E8fYEgocz5dy9uRa9yWllj7gIKlNTpe73PE
wA6yXpStCvQdu4nGXEvUEG6wxEB8eYXTTFhkWMVlFsmeK3Un7IaWvOBFvXn667gF
gC8YQg/z2wEWVqrOUyUw+tZkXZhw7849MZ0TB9j8Gl96wq5XwkCMGq7ytFvru6bO
ymMheyyf4Ku6fsE6P3BWe+LTlognGAhfCaq5RJIChEmmuNKrIRSMdcAz40zpbmeJ
PGjpDEzS+SlmWNOPOPT+vFZtroZuQvGmnukcczj0i1vQ0Tt9nEBnwadgk9t9gb7o
EgRkO1rrN5OqTtVPeMx0Xmsi4K1BBhfJC7g5cCyfZpyZseWAthFqe4fm2+6zQaIn
luIB2JmIJ9jCpXG8/Tio/5vcL3Kc6VDlBlN3xSEAu2lrVH7HZsUmC1VmSgKp1EtT
fWUmsx73yTKEw+MgMWqnG+n+0QvQPZttsKnTZFlOwo7OjKov8BEsI7+mERPK6bJ5
Z0tI+5OqyYBzHhQMJLn/GQofcJLfYDxhCrrffgmAwlm4X902VUy9hGXIXxmQI140
q8xKTg8Xn7hpBSVDm0XOMbpZeY6drMpyEGSMlEOTeiTK1mrnbvZIoR7mwzbo9gkF
8A+K+2ogBxHXGE/OFZYvkwKl5AIYbqHw5Z7sqoAg3Xslz37tpVM=
=UNVY
-----END PGP SIGNATURE-----

--ZXzThk3vFZecBD04--

