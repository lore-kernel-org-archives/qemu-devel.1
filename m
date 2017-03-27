Received: from eggs.gnu.org ([2001:4830:134:3::10]:38975)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1csTLR-0005yy-R7
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 08:01:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1csTLM-0001yU-Tw
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 08:01:57 -0400
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:33618)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1csTLM-0001xo-O4
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 08:01:52 -0400
Received: by mail-wr0-x241.google.com with SMTP id 20so12510318wrx.0
	for <qemu-devel@nongnu.org>; Mon, 27 Mar 2017 05:01:52 -0700 (PDT)
Date: Mon, 27 Mar 2017 13:01:48 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170327120148.GC26900@stefanha-x1.localdomain>
References: <3d1c16a1-ec05-0367-e569-64a63b34f2e3@redhat.com>
	<4a56f716-3528-ddd4-f8c4-f3f6b23c469a@redhat.com>
	<bbc2671a-42dd-aa2a-0f03-6a4a487cb8f5@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OBd5C1Lgu00Gd/Tn"
Content-Disposition: inline
In-Reply-To: <bbc2671a-42dd-aa2a-0f03-6a4a487cb8f5@redhat.com>
Subject: Re: [Qemu-devel] What's the next QEMU version after 2.9 ? (or: when
 is a good point in time to get rid of old interfaces)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, jasowang@redhat.com


--OBd5C1Lgu00Gd/Tn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 27, 2017 at 10:06:09AM +0200, Thomas Huth wrote:
> On 24.03.2017 23:10, John Snow wrote:
> >=20
> >=20
> > On 03/08/2017 03:26 AM, Thomas Huth wrote:
> >>
> >>  Hi everybody,
> >>
> >> what will be the next version of QEMU after 2.9? Will we go for a 2.10
> >> (as I've seen it mentioned a couple of times on the mailing list
> >> already), or do we dare to switch to 3.0 instead?
> >>
> >> I personally dislike two-digit minor version numbers like 2.10 since t=
he
> >> non-experienced users sometimes mix it up with 2.1 ... and there have
> >> been a couple of new cool features in the past releases that would
> >> justify a 3.0 now, too, I think.
> >>
> >> But anyway, the more important thing that keeps me concerned is: Someo=
ne
> >>  once told me that we should get rid of old parameters and interfaces
> >> (like HMP commands) primarily only when we're changing to a new major
> >> version number. As you all know, QEMU has a lot of legacy options, whi=
ch
> >> are likely rather confusing than helpful for the new users nowadays,
> >> e.g. things like the "-net channel" option (which is fortunately even
> >> hardly documented), but maybe also even the whole vlan/hub concept in
> >> the net code, or legacy parameters like "-usbdevice". If we switch to
> >> version 3.0, could we agree to remove at least some of them?
> >>
> >>  Thomas
> >>
> >=20
> > As others have stated, we need a few releases to deprecate things first.
> >=20
> > Maybe we should develop a serious plan to develop some of our legacy
> > interfaces first.
> >=20
> > Maybe 2.10 can introduce a list of things we want to deprecate,
> > 2.11 can be the transition release,
> > and then 3.0 can cut the cord and free of us our terrible burden?
> >=20
> > I have a list of things I want to axe...
>=20
> I've started a Wiki page with such a list here:
>=20
> http://wiki.qemu-project.org/Features/LegacyRemoval

It would be nice to get rid of the legacy -net option in 3.0.0.  I have
added it and included pointers to loose ends.  I think this is doable
but will require some time to achieve.

Stefan

--OBd5C1Lgu00Gd/Tn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJY2P8sAAoJEJykq7OBq3PInuQH/jvlA/MN/BQvm55cl3zozoku
62y8dcAJ8TTarAAAIxYLzY8AcNR7wcm/PTuIfgRKZovKU5Z3xWN+ZjMbLLsZENLs
2xjUcUaeVdZy8n8uDPH8Vf0O6eWCOJiuy/pPgNga9fVjOjZR13BG3m1QG1y9DFPh
o7HceRmRjvjMQRT/bjRAttSHkf23uH+nAZnkf6Ug1XFHgAoja/IJmUzVMtZiEsOm
xXlKU7/ds5VgwIJsyfMPmACBxZXK0gvTof2AP5MCrRPHOYLtzQbCMeakEnBEndzz
s+OGFWNO3bVp9Mec/Sjycoi4vpQHBjZq1oo6kOm1MDV9NXDBuDuFCmYbUivDYgU=
=cSP1
-----END PGP SIGNATURE-----

--OBd5C1Lgu00Gd/Tn--
