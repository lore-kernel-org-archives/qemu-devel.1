Return-Path: <SRS0=d4IR=4I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99D8BC7619D
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 03:24:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6864924658
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 03:24:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="QgiXPc0b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6864924658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35228 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4cS0-0006LO-I2
	for qemu-devel@archiver.kernel.org; Wed, 19 Feb 2020 22:24:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41173)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1j4cR3-0004ag-QM
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 22:23:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1j4cR2-0008HX-Cr
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 22:23:33 -0500
Received: from ozlabs.org ([2401:3900:2:1::2]:50637)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1j4cR1-0008Dh-Oy; Wed, 19 Feb 2020 22:23:32 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48NKg00jgfz9sSH; Thu, 20 Feb 2020 14:23:23 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1582169004;
 bh=0XtAOj+IPH/LQ0YgUYFF29i4CjYf+GIk9oJOXyBM6Mg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=QgiXPc0b84gdiJQz/sKvEyfB7ma50mtKcuuDjKqfVZLGX0Gp/ICmlXKTfDPUf5OqT
 LG6ARof5T/IKrfBzh88C/IZQHo1JPDH6khGvfvVWqRPoNTd5zJKKBfLd12z12xts5v
 vljAzlEIzlYH+xlLvvxxKe6fW33gwTWC3G1F3iXE=
Date: Thu, 20 Feb 2020 14:13:26 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Fabiano Rosas <farosas@linux.ibm.com>
Subject: Re: [PATCH v3 11/12] target/ppc: Streamline construction of VRMA SLB
 entry
Message-ID: <20200220031326.GN1764@umbus.fritz.box>
References: <20200219005414.15635-1-david@gibson.dropbear.id.au>
 <20200219005414.15635-12-david@gibson.dropbear.id.au>
 <875zg2d4sx.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="mkHYMT4O8DyWoHkb"
Content-Disposition: inline
In-Reply-To: <875zg2d4sx.fsf@linux.ibm.com>
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
Cc: lvivier@redhat.com, groug@kaod.org, qemu-devel@nongnu.org, paulus@samba.org,
 clg@kaod.org, qemu-ppc@nongnu.org, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--mkHYMT4O8DyWoHkb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 19, 2020 at 11:34:22AM -0300, Fabiano Rosas wrote:
> David Gibson <david@gibson.dropbear.id.au> writes:
>=20
>=20
> Hi, just a nitpick, feel free to ignore.
>=20
> > When in VRMA mode (i.e. a guest thinks it has the MMU off, but the
> > hypervisor is still applying translation) we use a special SLB entry,
> > rather than looking up an SLBE by address as we do when guest translati=
on
> > is on.
> >
> > We build that special entry in ppc_hash64_update_vrma() along with some
> > logic for handling some non-VRMA cases.  Split the actual build of the
> > VRMA SLBE into a separate helper and streamline it a bit.
> >
> > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > ---
> >  target/ppc/mmu-hash64.c | 79 ++++++++++++++++++++---------------------
> >  1 file changed, 38 insertions(+), 41 deletions(-)
> >
> > diff --git a/target/ppc/mmu-hash64.c b/target/ppc/mmu-hash64.c
> > index 170a78bd2e..06cfff9860 100644
> > --- a/target/ppc/mmu-hash64.c
> > +++ b/target/ppc/mmu-hash64.c
> > @@ -789,6 +789,39 @@ static target_ulong rmls_limit(PowerPCCPU *cpu)
> >      }
> >  }
> > =20
> > +static int build_vrma_slbe(PowerPCCPU *cpu, ppc_slb_t *slb)
> > +{
> > +    CPUPPCState *env =3D &cpu->env;
> > +    target_ulong lpcr =3D env->spr[SPR_LPCR];
> > +    uint32_t vrmasd =3D (lpcr & LPCR_VRMASD) >> LPCR_VRMASD_SHIFT;
> > +    target_ulong vsid =3D SLB_VSID_VRMA | ((vrmasd << 4) & SLB_VSID_LL=
P_MASK);
> > +    int i;
> > +
> > +    /*
> > +     * Make one up. Mostly ignore the ESID which will not be needed
> > +     * for translation
> > +     */
>=20
> I find this comment a bit vague. I suggest we either leave it behind or
> make it more precise. The ISA says:
>=20
> "translation of effective addresses to virtual addresses use the SLBE
> values in Figure 18 instead of the entry in the SLB corresponding to the
> ESID"

Yeah, it wasn't very helpful in its initial location, and it's even
less helpful here.  I've dropped it.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--mkHYMT4O8DyWoHkb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl5N+VYACgkQbDjKyiDZ
s5InRQ//QX1vIePut03v3ID0pZe50WKC6yET8toa9D4SBqQPGvUsMLr1b4b1aqAC
rR741dovzZX2/aEtqIwA1z6+a+3JDd0wwE3kG7dtmG5Du3Jw+YCGCFIu1FNmU3il
IukuzgrKlABfp9O2mqHRcgOZ4f/JgX8Z2sfZYH18FzvOXy18mThIzqnfJ0ponG2a
oRC2k5b1usjh/IlwzQVrbvZPfUQKcFTDH504GRSwbw2hlrR7EQbzO330YMqqyMUr
OW765eRtrTgqVG5/gF351IGTxAPPfrnaaEQVKxxDzuE3FGSQEoY+obGF1HUYfUxx
0vSZfKLjM9IXvAwViIWANt8NK8yM0E/tGUFe4CMQigTwMwLP8sJj0xM6KhA6MBMm
3YtYIqydA73z6+tu52EIQhTQx3Qt5W3VcHVcY+hktfQqErNj3N+D5i2b8tYIHExh
pWzul67901Ivu5f4llJm+sVfwj9RlpyNuHQSMU24zuDLDI2dqdvRCnPc8Q9a5TVz
C0rlIhxOinMT2Pf674wnj3q2SVGa3V3P5rJTUkVY4FwWBtE9YK8gOeiuJ4sN7Nog
KRW7TXa8MDQOVnrWbrac8BGIF3WHimmmHfnYP15jAF+lDAtom2+FqsT1AGa3DDyz
5icwyBR8Aws3TCF1S+tTavkDJaFKoSxMjclpm70JqnrqrUnUq1M=
=3UqX
-----END PGP SIGNATURE-----

--mkHYMT4O8DyWoHkb--

