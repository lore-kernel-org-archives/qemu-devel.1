Received: from eggs.gnu.org ([2001:4830:134:3::10]:54704)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fEVtJ-0006xb-VU
	for qemu-devel@nongnu.org; Fri, 04 May 2018 04:16:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fEVtJ-0006QG-18
	for qemu-devel@nongnu.org; Fri, 04 May 2018 04:16:33 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39348 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1fEVtI-0006Pi-RD
	for qemu-devel@nongnu.org; Fri, 04 May 2018 04:16:32 -0400
Date: Fri, 4 May 2018 09:16:28 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180504081628.GC18897@stefanha-x1.localdomain>
References: <d50e3a40-d7f3-4c9b-e930-4c2f4d6c8a53@redhat.com>
	<CAFEAcA8wJuJ9464LadgjJOo-7ttdGYcfDQWALbkxBRJCr_knkg@mail.gmail.com>
	<062deb2a-35fc-319f-b159-3b58cbf910df@redhat.com>
	<20180502115844.GO3308@redhat.com>
	<CAFEAcA-e_=08658O8E3CAmYXvBbNWmznnhfMLUW+MXnxb_vKfQ@mail.gmail.com>
	<20180503093329.GF11382@redhat.com>
	<8af696b5-3985-ffd6-43fb-2bcbfe0d0493@redhat.com>
	<222ee475-9eb5-8887-819a-7b093fc269b1@kaod.org>
	<20180503180240.GC13789@stefanha-x1.localdomain>
	<87in84c7kf.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wxDdMuZNg1r63Hyj"
Content-Disposition: inline
In-Reply-To: <87in84c7kf.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] release retrospective, next release timing,
 numbering
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Greg Kurz <groug@kaod.org>, QEMU Developers <qemu-devel@nongnu.org>


--wxDdMuZNg1r63Hyj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 04, 2018 at 07:29:20AM +0200, Markus Armbruster wrote:
> Stefan Hajnoczi <stefanha@redhat.com> writes:
> > So to clarify, three separate steps:
> >
> > 1. Get rid of target-specific #ifdefs
>=20
> 1. can be incremental.  Something for
> <https://wiki.qemu.org/Contribute/BiteSizedTasks>?

Some conversions are trivial, others are not.  I think asking newcomers
to figure out how to untangle the #ifdefs without a plan would not
produce good results.

Someone experienced should lay the groundwork and identify common types
of conversions.  Then bite-sized tasks can be defined for trivial
conversions.

Stefan

--wxDdMuZNg1r63Hyj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJa7BbcAAoJEJykq7OBq3PIAksIALgeUWFm0recFGsx+xuXWViI
fwEvFGLYMn5KuBlTzF83S1S1wuPn7v/801QIikEAqlW0sJCD+gJsGffCaqYpgS66
U8t1Ts4GhQaxYb6a1gu1TbGBOaD9VArU6JTznWAjPAIJPIqm3iFfAOxixgh+0V6U
HH88eL3KXKE5ApNFYho4oCadZKVDARGoHYb9zfmk33MuLl2cdSYzu+Z/cYaf8xbB
oNqvsjX6Zi9I+HBSS31k6g71yPEMf3VwyI20KEkiHY0nPN77JpX08JQ7Pi2pRNJV
Xm+kMJ+CMKXFoUizmNbfGeyvudyR4yhP/haIOgWuEkKQko17sY+xw/B6aIIBb5E=
=a3me
-----END PGP SIGNATURE-----

--wxDdMuZNg1r63Hyj--
