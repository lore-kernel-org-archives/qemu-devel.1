Received: from eggs.gnu.org ([2001:4830:134:3::10]:55358)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cfljx-0005Gg-4I
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 06:02:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cfljr-0000ju-6r
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 06:02:45 -0500
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:32871)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cfljq-0000jp-Vk
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 06:02:39 -0500
Received: by mail-wm0-x243.google.com with SMTP id v77so13687135wmv.0
	for <qemu-devel@nongnu.org>; Mon, 20 Feb 2017 03:02:38 -0800 (PST)
Date: Mon, 20 Feb 2017 11:02:35 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170220110235.GD21255@stefanha-x1.localdomain>
References: <CAAo6VWOAnGQeDwc_bJ4M=FQsu7rOhAv=1Qk6PdzG+0pcVnku=A@mail.gmail.com>
	<20170217214215.GK19045@localhost.localdomain>
	<F23F188C-DAF9-49EA-9C0E-54F57945267A@veritas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZJcv+A0YCCLh2VIg"
Content-Disposition: inline
In-Reply-To: <F23F188C-DAF9-49EA-9C0E-54F57945267A@veritas.com>
Subject: Re: [Qemu-devel] [PATCH v8 1/2] block/vxhs.c: Add support for a new
 block device type called "vxhs"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ketan Nilangekar <Ketan.Nilangekar@veritas.com>
Cc: Jeff Cody <jcody@redhat.com>, ashish mittal <ashmit602@gmail.com>, qemu-devel <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, Fam Zheng <famz@redhat.com>, Ashish Mittal <Ashish.Mittal@veritas.com>, John Ferlan <jferlan@redhat.com>, Buddhi Madhav <Buddhi.Madhav@veritas.com>, Suraj Singh <Suraj.Singh@veritas.com>, Nitin Jerath <Nitin.Jerath@veritas.com>, Peter Maydell <peter.maydell@linaro.org>, Abhijit Dey <Abhijit.Dey@veritas.com>, "Venkatesha M.G." <Venkatesha.Mg@veritas.com>, Rakesh Ranjan <Rakesh.Ranjan@veritas.com>


--ZJcv+A0YCCLh2VIg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 18, 2017 at 12:30:31AM +0000, Ketan Nilangekar wrote:
> On 2/17/17, 1:42 PM, "Jeff Cody" <jcody@redhat.com> wrote:
>=20
>     On Thu, Feb 16, 2017 at 02:24:19PM -0800, ashish mittal wrote:
>     > Hi,
>     >=20
>     > I am getting the following error with checkpatch.pl
>     >=20
>     > ERROR: externs should be avoided in .c files
>     > #78: FILE: block/vxhs.c:28:
>     > +QemuUUID qemu_uuid __attribute__ ((weak));
>     >=20
>     > Is there any way to get around this, or does it mean that I would h=
ave
>     > to add a vxhs.h just for this one entry?
>     >
>    =20
>     I remain skeptical on the use of the qemu_uuid as a way to select the=
 TLS
>     cert.
>=20
> [ketan]
> Is there another identity that can be used for uniquely identifying insta=
nces?
> The requirement was to enforce vdisk access to owner instances.

The qemu_uuid weak attribute looks suspect.  What is going to provide a
strong qemu_uuid symbol?

Why aren't configuration parameters like the UUID coming from the QEMU
command-line?

Stefan

--ZJcv+A0YCCLh2VIg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYqszLAAoJEJykq7OBq3PIckoIAJXtHXuobOW8iSxx1fCxYkkF
/6VmAyAF2jDGKO9+/1TfpV5S9S+ZQil+asU1gfs0hTUVwyqavqt9kCsC94ajrWuF
eiWFPLBNDw7X8YH0XBLCTeT4iFcdSfsmXJplCz/HEgz1ymdVjtIt7/pviVafuKxe
r0vcqgGvZHdox5hWii2NkFkKjxGF4iFZd10CEKcqGXovfTHQoNSXNNYXgb8jllwg
40GhMuy2ghc76IC/OuklMZGr3jmf0DQRgYptk4OjK26TU9oUV2edS5UxhrdlmRHj
udn/UQv+/+tNsNVFfO1dTH7PdfMtceE8f/Bj4W8gljtHqZw9NczDO14Nyb70V+o=
=CFTR
-----END PGP SIGNATURE-----

--ZJcv+A0YCCLh2VIg--
