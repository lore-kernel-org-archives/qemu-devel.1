Received: from eggs.gnu.org ([209.51.188.92]:46522)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gnZIp-0005aD-St
	for qemu-devel@nongnu.org; Sat, 26 Jan 2019 20:32:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gnZIo-00020T-Rx
	for qemu-devel@nongnu.org; Sat, 26 Jan 2019 20:32:03 -0500
Date: Sat, 26 Jan 2019 14:53:57 +1300
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190126015357.GD22942@umbus>
References: <20181228135235.6859-1-mark.cave-ayland@ilande.co.uk>
	<20190102025904.GH27457@umbus.fritz.box>
	<41c0bc74-a976-93e1-1104-99b191934d89@ilande.co.uk>
	<20190120202824.GA2423@umbus>
	<38f72c0d-a64b-1ac5-d4cd-70c1a6087226@ilande.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="jL2BoiuKMElzg3CS"
Content-Disposition: inline
In-Reply-To: <38f72c0d-a64b-1ac5-d4cd-70c1a6087226@ilande.co.uk>
Subject: Re: [Qemu-devel] [PATCH v2 0/8] target/ppc: remove various endian
 hacks from int_helper.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-ppc@nongnu.org, richard.henderson@linaro.org, qemu-devel@nongnu.org


--jL2BoiuKMElzg3CS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 21, 2019 at 05:15:20AM +0000, Mark Cave-Ayland wrote:
> On 20/01/2019 20:28, David Gibson wrote:
> > On Fri, Jan 18, 2019 at 01:25:37PM +0000, Mark Cave-Ayland wrote:
> >> On 02/01/2019 02:59, David Gibson wrote:
> >>
> >>> On Fri, Dec 28, 2018 at 01:52:27PM +0000, Mark Cave-Ayland wrote:
> >>>> >From working on the TCG vector operations patchset, it is apparent =
that there
> >>>> are a large number of endian-based hacks in int_helper.c which can b=
e removed by
> >>>> making use of the various Vsr* macros.
> >>>>
> >>>> Patch 1 is simple enough, and implements the complete set of Vsr* ma=
cros for
> >>>> both big endian and little endian hosts.
> >>>>
> >>>> Patches 2 and 3 rework the vector merge and multiply algorithms so t=
hat they
> >>>> no longer require the endian-dependent HI_IDX and LO_IDX macros.
> >>>>
> >>>> Patches 4 and 5 then completely remove the HI_IDX/LO_IDX and EL_IDX =
macros by
> >>>> replacing the element accesses with their equivalent Vsr* macro inst=
ead.
> >>>>
> >>>> Patches 6 and 7 tidy up the VEXT_SIGNED macro and fix a potential sh=
ift bug
> >>>> in the ROTRu32 and ROTRu64 macros pointed out by Richard during the =
review of
> >>>> v1.
> >>>>
> >>>> Finally patch 8 is an inspection-based removal of other HOST_WORDS_B=
IGENDIAN
> >>>> hacks in int_helper.c, again replacing accesses with the relevant Vs=
r* macro
> >>>> instead.
> >>>>
> >>>> Note that there are still some endian hacks left in int_helper.c aft=
er this
> >>>> patchset: in particular the delightfully evil VECTOR_FOR_INORDER_I m=
acro still
> >>>> remains in places where the index variable was used for purposes oth=
er than
> >>>> accessing elements within the vector.
> >>>>
> >>>> There were also some parts where additional conversion could be done=
, but I
> >>>> wasn't confident enough to make the change without access to PPC64 t=
est images
> >>>> or real big-endian host hardware.
> >>>
> >>> Applied to ppc-for-4.0, thanks.
> >>
> >> Just checking your ppc-for-4.0 branch on github, I can't see where thi=
s has been
> >> applied? Is it queued in a local branch still?
> >=20
> > Yeah, probably.  I've pushed it out now.
>=20
> Thanks David. I've just had another quick look, and whilst I can see newe=
r commits in
> the branch, I think these ones belonging to this patchset are still
> missing?

Um.. hrm.. in that case I think I've lost track of these ones :/
--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--jL2BoiuKMElzg3CS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlxLvbQACgkQbDjKyiDZ
s5KLTA/9GGXmSVKgNNenIGexk7in9kn1FDAykBlaEAbEBex41eXVl75oL3GLOdAn
Jpkse1wEkbUWIViPkvt88ZYEdYA2qE7S9VQr4wDbmPVJFplL3SOTNCL3o1Q8XuH9
qFwensdx0RdQv+HSm8nSdl+LSjEkD1y/7q8gwB2CKpY0ryS5WHSyUN27znPK8oV3
gWxTUXPw/Wq5pz9w5fNdwYpACitugt/PMQBw9hXYnCN5WIu+4oa7ZOF3ZJgytIwN
mRMNDYouzX7B+P+lk05oynN1ctigcFU4MteniBmy7pqZu8lWOHBmTwfYWTfzpN8L
vkkv919cC9uRW/PY4Bkst499V9VBZgUm1kym712vkQpzBW1dpcKiTsEmGCLvCWZZ
PKFQ6nKDhpJuBiFNZw5AiPfZf6Jx0i/1PN6gUhtILzstWiMT9rcj5Yo2juNlUiWM
dj6hu0PugbXVsYcEBQyI6qguozDqOlgEL0OoaF9x/0eQa4RdKpaNDT5/OlNDtQLg
+Jwej0H1uj1/WJCMLCZ4kFuk9zP9Swf2ue0YvydMCMaL9oStCda0MxT0TGCDOlDi
cTIFD2bCUCqNGHV8mKJXrnLA7gWTl0fW99+Gz/ypgfAprA98AiNTGxiJ/gC4xzGS
n2Dd3YB/XV9GLMgFi8t6zM8r5yw2Yso3ABI1JWMGfd4jEgyrnBM=
=lPkS
-----END PGP SIGNATURE-----

--jL2BoiuKMElzg3CS--
