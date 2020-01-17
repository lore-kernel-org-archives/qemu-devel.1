Return-Path: <SRS0=+Hf+=3G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42E8BC33CB1
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 05:48:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0ED0120748
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 05:48:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="cW9sGGAQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0ED0120748
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52722 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isKUg-0000q3-6a
	for qemu-devel@archiver.kernel.org; Fri, 17 Jan 2020 00:48:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46820)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1isKTP-000090-NB
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 00:47:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1isKTO-0004sL-5u
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 00:47:11 -0500
Received: from ozlabs.org ([2401:3900:2:1::2]:33155)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1isKTN-0004mD-7N; Fri, 17 Jan 2020 00:47:10 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47zVSS0ZmWz9sRR; Fri, 17 Jan 2020 16:47:03 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1579240024;
 bh=I/eLh7l0NFJavOY50ErHLah7pS93v/wyfNnJ0kQ5HYU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=cW9sGGAQ9RzBrvv1/O3FRuwADijU7UUtijQOw0ch8xyPlriov/lE4COmQEuHVH3qx
 vU3NhTKU2cZQd22oBwZ+mXqCIMgwWMzx+UU78CTqWfn5VZSa1WD/O7dyZIO+dl25IV
 CNXefvOYhH7Nhw5jFjG/8IQw/N6TYeXr7hNEi0GE=
Date: Fri, 17 Jan 2020 15:46:57 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH] spapr: Fail CAS if option vector table cannot be parsed
Message-ID: <20200117054657.GT54439@umbus>
References: <157918715618.376249.7891210201270364781.stgit@bahia.lan>
 <ee5bcc16-2e86-a9b2-423d-bc82d327f581@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="UsbkURXZxe2ekgES"
Content-Disposition: inline
In-Reply-To: <ee5bcc16-2e86-a9b2-423d-bc82d327f581@redhat.com>
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
Cc: qemu-ppc@nongnu.org, Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--UsbkURXZxe2ekgES
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 16, 2020 at 04:34:06PM +0100, Philippe Mathieu-Daud=E9 wrote:
> Hi Greg,
>=20
> On 1/16/20 4:05 PM, Greg Kurz wrote:
> > Most of the option vector helpers have assertions to check their
> > arguments aren't null. The guest can provide an arbitrary address
> > for the CAS structure that would result in such null arguments.
> > Fail CAS with H_PARAMETER instead of aborting QEMU.
> >=20
> > Signed-off-by: Greg Kurz <groug@kaod.org>
> > ---
> >   hw/ppc/spapr_hcall.c |    9 +++++++++
> >   1 file changed, 9 insertions(+)
> >=20
> > diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> > index 84e1612595bb..051869ae20ec 100644
> > --- a/hw/ppc/spapr_hcall.c
> > +++ b/hw/ppc/spapr_hcall.c
> > @@ -1701,9 +1701,18 @@ static target_ulong h_client_architecture_suppor=
t(PowerPCCPU *cpu,
> >       /* For the future use: here @ov_table points to the first option =
vector */
> >       ov_table =3D addr;
> > +    if (!ov_table) {
> > +        return H_PARAMETER;
> > +    }
>=20
> This doesn't look right to check ov_table, I'd check addr directly instea=
d:
>=20
> -- >8 --
> @@ -1679,12 +1679,16 @@ static target_ulong
> h_client_architecture_support(PowerPCCPU *cpu,
>=20
>      cas_pvr =3D cas_check_pvr(spapr, cpu, &addr, &raw_mode_supported,
> &local_err);
>      if (local_err) {
>          error_report_err(local_err);
>          return H_HARDWARE;
>      }
> +    if (!addr) {
> +        // error_report*()
> +        return H_PARAMETER;
> +    }
>=20
>      /* Update CPUs */
>      if (cpu->compat_pvr !=3D cas_pvr) {
> ---
>=20
> Still I'm not sure it makes sense, because the guest can also set other
> invalid addresses such addr=3D0x69.

Neither is correct.  As you point out this filters at most one of many
bad addresses.  And, in fact it's not even a bad address - there's no
inherent reason the CAS information couldn't be put at guest address
0.


>=20
> >       ov1_guest =3D spapr_ovec_parse_vector(ov_table, 1);
> > +    if (!ov1_guest) {
> > +        return H_PARAMETER;
> > +    }
>=20
> This one is OK (unlikely case where vector 1 isn't present).
>=20
> >       ov5_guest =3D spapr_ovec_parse_vector(ov_table, 5);
> > +    if (!ov5_guest) {
> > +        return H_PARAMETER;
> > +    }
>=20
> This one is OK too (unlikely case where vector 5 isn't present).
>=20
> >       if (spapr_ovec_test(ov5_guest, OV5_MMU_BOTH)) {
> >           error_report("guest requested hash and radix MMU, which is in=
valid.");
> >           exit(EXIT_FAILURE);
> >=20
> >=20
>=20

I agree these ones are ok, though.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--UsbkURXZxe2ekgES
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl4hSk4ACgkQbDjKyiDZ
s5KQOQ/8DroeGIVUGbvl1y9lf29Auy2H13CUT80GmBENwkZAmcS6eCLAHb8Kv87S
uf6CDHCQ2WPbtj6s1rHq0nLsFNuo+OaBoqQEVW+ulkFdY62YaS/PN1Y6fM9ZfdWE
B8sOwBpvg+qhx7mBUtu7eUDKNSBFiemM4PuVrQFT3bQTPdWs9VH9E0DIvsq7KpXz
TeDxRl3e02cvsf5lsgX9ChIZE+oMTbYFVpfOwiF1uN22FEKCs7O3DZVMjOMYE0H9
mFHRjfmmYZa4L0XPQx4LFWzDqHM9YpTVoelx2Jh9dC68RvIGWC0AM3ZJDwL91h38
vzpxZKFyTK5kvp3vrv5+xCQEJ4GQh88Q0yFspS7PWWfsxfg34knA3pltEw+woiAA
6RciKCOEQolaEV7qWnCDT7+oqaaUAEYxZJ5agfP7yiylmi0FZR4NqBX2x7P614wF
FKbu0UwW3mcKD6PCAriTu7G3ytZksPPhS0KSSUGcDFiNjwJco14BD+Anauf/2TC9
E7r2mCFIjvCxvjcoELoj8G84SpNMN2f9au3V/YVj9jj7ZUEN0fYGhrMZTMMLxbSp
x8yhQLOpHqau8UBBur3saRZJK6buch0ur6vVn+zQfHfR0kApCgVdpc7Au5zeRpoo
IbrnYn/Nt1KiaIrMnQi8rQyCyHXcXGVsFoXfeQU50ZgX6hyxIPI=
=Jb8z
-----END PGP SIGNATURE-----

--UsbkURXZxe2ekgES--

