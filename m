Received: from eggs.gnu.org ([209.51.188.92]:35755)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1giyUe-0000nb-6E
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 04:25:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1giyUY-0002u9-Qx
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 04:25:13 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329]:51140)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1giyUW-0002rw-RS
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 04:25:10 -0500
Received: by mail-wm1-x329.google.com with SMTP id n190so8107789wmd.0
	for <qemu-devel@nongnu.org>; Mon, 14 Jan 2019 01:25:06 -0800 (PST)
Date: Mon, 14 Jan 2019 09:24:59 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20190114092459.GA7038@stefanha-x1.localdomain>
References: <CAJSP0QUV39fK4L8MwQ-rGiR0ejUm0HCyKFqARh-SKRTuDPKOXg@mail.gmail.com>
	<jpgsgy0aaw6.fsf@linux.bootlegged.copy>
	<CACT4Y+YWVfg_PVh0=CTCgM9BRyCmKZB9N+_DBimaNKPE=y6r5Q@mail.gmail.com>
	<CABiizEQ-O-Ro9cH3xqzZUB=c5k+oYJ-gdR7ssfbbn5kU_8GcAA@mail.gmail.com>
	<e4af7025-fa8c-1078-62de-f77a11a79fc0@redhat.com>
	<CAJSP0QUFrs=rPvcSdNzwjk2Zyc2Sfu81SM_KZsO9djSGK1beUA@mail.gmail.com>
	<CABiizES5O1zGF_7CxnSCfVQL39=Ov0Bf61-U2XwvoS1_xDi2ew@mail.gmail.com>
	<8ebdfb3b-f99b-4dbc-0389-b96b3f9fb633@redhat.com>
	<CABiizERPJa06YNEyUxEAgDaSgjJny4bTa4qpTDCwKzKMn5Ji=Q@mail.gmail.com>
	<0387b8e9-2b4f-ce1a-05df-b508851b84f0@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lrZ03NoBR/3+SXJZ"
Content-Disposition: inline
In-Reply-To: <0387b8e9-2b4f-ce1a-05df-b508851b84f0@redhat.com>
Subject: Re: [Qemu-devel] Internship idea: virtio-blk oss-fuzz support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Max Moroz <mmoroz@google.com>, Dmitry Vyukov <dvyukov@google.com>, Oliver Chang <ochang@google.com>, Jonathan Metzman <metzman@google.com>, Bandan Das <bsd@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Andrey Konovalov <andreyknvl@google.com>, Kostya Serebryany <kcc@google.com>


--lrZ03NoBR/3+SXJZ
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 11, 2019 at 05:16:40PM +0100, Paolo Bonzini wrote:
> On 11/01/19 16:41, Max Moroz wrote:
> > On Fri, Jan 11, 2019 at 7:34 AM Paolo Bonzini <pbonzini@redhat.com
> > <mailto:pbonzini@redhat.com>> wrote:
> >=20
> >     On 11/01/19 16:04, Max Moroz wrote:
> >     > We usually have a single fuzzing process, it starts with a fuzzing
> >     > engine's main function and is calling=A0LLVMFuzzerTestOneInput wi=
th
> >     > various inputs and keep mutating them based on the coverage feedb=
ack.
> >     > Running a second process which you don't care too much about migh=
t be
> >     > fine, but the fuzzing process should be "replacing" or should I s=
ay
> >     > "imitating" the process whose coverage you're interested in.
> >=20
> >     What do you mean by replacing or imitating?
> >=20
> > To give you an example, when we fuzz ffmpeg, we do not run ffmpeg's main
> > function. We write=A0LLVMFuzzerTestOneInput that would do the necessary
> > initialization, reset the state, etc, and then would pass (data, size)
> > provided by a fuzzing engine to the API(s) we're trying to fuzz. So, in
> > your case, there should not be a regular QEMU process, and instead the
> > fuzz target (i.e. LLVMFuzzerTestOneInput) should be doing certain
> > initialization (which is usually done by the QEMU process) and then call
> > the API you want to fuzz.
>=20
> The main issue is that we are not really testing an API and QEMU has a
> lot of global state.

With regards to the GSoC/Outreachy project, I think the mentors (me?)
need to figure this out beforehand by experimentation.  The QEMU folks
don't know the details of oss-fuzz and vice versa.  But with a weekend
or two's worth of playing around we could figure out a reasonable way of
integrating qtest/oss-fuzz.

Then the intern has a clear direction to follow this summer and won't be
demotivated by failed attempts at working with two codebases they are
unfamiliar with :).

Stefan

--lrZ03NoBR/3+SXJZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcPFVrAAoJEJykq7OBq3PIv+sH+gLx7jcUVoCnIlL1Ac+XAIAg
j/KxkxCXTvrCUFK+HMFZKOsAQEMolZJVE9CzaYHrtiRaif6FkDRIbt5TR0onYMvc
+LJ2PEDdN8+mmu/+mVkgnUy8H2DoXuNSmbT9xQ9G5zV6aSzRvAegm0OW6e/GTESi
kajItEXpHHb6VYBBmYF7HrNNeBIDitX7FQNKwfAlPl7w7HDvVLftUaxjIZC60AIO
l5f4L076M8kHuJ5pKEiNaHdPuBxQFX6oO/HJAlviL+9psoxENV3WI/bwYlbYYIel
HxzYPCXQsDsJxKD61sFE0x4FSKybxZduquVohuE9pfFzvunetgDnbWV6Bi2zxOk=
=Qx73
-----END PGP SIGNATURE-----

--lrZ03NoBR/3+SXJZ--
