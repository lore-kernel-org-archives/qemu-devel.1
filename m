Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45AD7C4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 02:05:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D832F2076B
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 02:05:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="OWDL4fxH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D832F2076B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58528 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXEN0-00083H-0T
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 22:05:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59210)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kXEKw-0005sY-8I; Mon, 26 Oct 2020 22:03:46 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:53867 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kXEKr-0001Vq-A9; Mon, 26 Oct 2020 22:03:45 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4CKw3V4SmLz9sSs; Tue, 27 Oct 2020 13:03:34 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1603764214;
 bh=MuYr8/zNi26+wpk+lM4ZyGbV+mKqF6oVDz9FwbsMJt0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=OWDL4fxHsK4UhEnDdVvwzbMZ7YL7AAElhVnX5hBSAVvGYcvAlBwhEt7xv14t+iE2H
 kOUUqyYzhIs3TtxUmz6pc2OyuU3C4wF4btmi7CIf9M02CPLc3M/5ZTLEKtuO+hnLbi
 s0jYmqKZI6vOKI34rSSH6VHyd6A51r26u1AmcIwI=
Date: Tue, 27 Oct 2020 12:56:40 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH 1/4] spapr: qemu_memalign() doesn't return NULL
Message-ID: <20201027015640.GB4671@yekko.fritz.box>
References: <160371602625.305923.7832478283946753271.stgit@bahia.lan>
 <160371603337.305923.17158585537944509438.stgit@bahia.lan>
 <7b6abe52-c17e-09b8-9239-e0e38d4d0a1f@redhat.com>
 <20201026154647.4a421bc5@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="vGgW1X5XWziG23Ko"
Content-Disposition: inline
In-Reply-To: <20201026154647.4a421bc5@bahia.lan>
Received-SPF: pass client-ip=203.11.71.1; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/26 22:03:34
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: qemu-ppc@nongnu.org,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--vGgW1X5XWziG23Ko
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 26, 2020 at 03:46:47PM +0100, Greg Kurz wrote:
> On Mon, 26 Oct 2020 14:43:08 +0100
> Philippe Mathieu-Daud=E9 <philmd@redhat.com> wrote:
>=20
> > On 10/26/20 1:40 PM, Greg Kurz wrote:
> > > qemu_memalign() aborts if OOM. Drop some dead code.
> > >=20
> > > Signed-off-by: Greg Kurz <groug@kaod.org>
> > > ---
> > >   hw/ppc/spapr.c       |    6 ------
> > >   hw/ppc/spapr_hcall.c |    8 ++------
> > >   2 files changed, 2 insertions(+), 12 deletions(-)
> > >=20
> > > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > > index 0cc19b5863a4..f098d0ee6d98 100644
> > > --- a/hw/ppc/spapr.c
> > > +++ b/hw/ppc/spapr.c
> > > @@ -1521,12 +1521,6 @@ void spapr_reallocate_hpt(SpaprMachineState *s=
papr, int shift,
> > >           int i;
> > >  =20
> > >           spapr->htab =3D qemu_memalign(size, size);
> > > -        if (!spapr->htab) {
> > > -            error_setg_errno(errp, errno,
> > > -                             "Could not allocate HPT of order %d", s=
hift);
> > > -            return;
> >=20
> > Wasn't the idea to use qemu_try_memalign() here?
> >=20
>=20
> Well... I have mixed feeling around this. The HTAB was first
> introduced by commit:
>=20
> commit f43e35255cffb6ac6230dd09d308f7909f823f96
> Author: David Gibson <david@gibson.dropbear.id.au>
> Date:   Fri Apr 1 15:15:22 2011 +1100
>=20
>     Virtual hash page table handling on pSeries machine
>=20
> using qemu_mallocz(), which was aborting on OOM. It then got
> replaced by g_malloc0() when qemu_mallocz() got deprecated
> and eventually by qemu_memalign() when KVM support was added.
>=20
> Surviving OOM when allocating the HTAB never seemed to be an
> option until this commit that introduced the check:
>=20
> commit c5f54f3e31bf693f70a98d4d73ea5dbe05689857
> Author: David Gibson <david@gibson.dropbear.id.au>
> Date:   Tue Feb 9 10:21:56 2016 +1000
>=20
>     pseries: Move hash page table allocation to reset time
>=20
> I don't really see in the patch and in the changelog an obvious
> desire to try to handle OOM.


This one is probably ok.  AFAICT all failures returned here would be
more or less fatal in the caller, one way or another (&error_fatal in
two cases, and failure to load an incoming migration stream in the
other).

> > > -        }
> > > -
> > >           memset(spapr->htab, 0, size);
> > >           spapr->htab_shift =3D shift;
> > >  =20
> > > diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> > > index 607740150fa2..34e146f628fb 100644
> > > --- a/hw/ppc/spapr_hcall.c
> > > +++ b/hw/ppc/spapr_hcall.c
> > > @@ -361,12 +361,8 @@ static void *hpt_prepare_thread(void *opaque)
> > >       size_t size =3D 1ULL << pending->shift;
> > >  =20
> > >       pending->hpt =3D qemu_memalign(size, size);
> > > -    if (pending->hpt) {
> > > -        memset(pending->hpt, 0, size);
> > > -        pending->ret =3D H_SUCCESS;
> > > -    } else {
> > > -        pending->ret =3D H_NO_MEM;
> >=20
> > Ditto.
> >=20
>=20
> This one was introduced by commit:
>=20
> commit 0b0b831016ae93bc14698a5d7202eb77feafea75
> Author: David Gibson <david@gibson.dropbear.id.au>
> Date:   Fri May 12 15:46:49 2017 +1000
>=20
>     pseries: Implement HPT resizing
>=20
> I agree that maybe the intent here could have been to use qemu_try_memali=
gn(),
> but again I don't quite see any strong justification to handle OOM in the
> changelog.
>=20
> David,
>=20
> Any insight to share ?

Aborting on an HPT resize failure is definitely not ok, though.  This
one needs to be a qemu_try_memalign().

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--vGgW1X5XWziG23Ko
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl+XflcACgkQbDjKyiDZ
s5KJMw/+PDOkKdpdjECoP42xhuMy0VJQPDB1Z8Z5wvZ+HATiiKhr2a24HyeGux+3
lXlF8wM2jdZ6/SMxKAyUU2CJVTQka1+hsJ1ae6sNjbLVuxMWeKa2TFOg0eDCu1Gz
KeHyH3fFkhHSqDO/cXUTurJ08wkLzsgFSknz6whK7sUzo12trYnjSLxkSMCJxeA1
5gOhjUor9B/vC6yYDgG841bNPybRIOj/gr5TKh2PcJKipEp5Kbu48r4GAjoH+4Xl
oqpDuS1g1xH+3/7bULPpV3U0OKK2aA2gGnyuYQYheSI8yM9WevuIgbteiccZ3Xvt
Wh5oVP56U80as3WTju5Y1jz7LenQpwmM2xUbFpiF/7xthIcHRLGZoDjdITc873wT
mpVIEPiNO+2lu8ppeOTMEr9CmAPt4ydccs2r13bxLaBigTRmXZHjU8m4WbBvQfMz
Y+CJrdvoj0tVsZIzN/N0G5ArcRrJH4JUcjgu7fC1LPyyx4OY9kNHY0asr/tMM4Tu
wgS/umK7HdroZR95DoZ/XAqswfVCXB/7MOne0id3ffZfVj4ekH3PwfZ62RJ4U5u5
eGHzyey+qR2dnGC9Y4AESgmKxzFE1qaKA5UxrKRGhKN2709B218uPxaoPRBaGakT
Ftww89MhqPs0oNLwKOuBS4OhDVhFyZQaUlngDUOYFoTiUaLpcdw=
=kRh/
-----END PGP SIGNATURE-----

--vGgW1X5XWziG23Ko--

