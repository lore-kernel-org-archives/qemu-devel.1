Received: from eggs.gnu.org ([2001:4830:134:3::10]:36070)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eg9oh-00087I-NP
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 08:49:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eg9oc-0006Hl-Rg
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 08:49:47 -0500
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:42456)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1eg9oc-0006Gd-JI
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 08:49:42 -0500
Received: by mail-wr0-x243.google.com with SMTP id 41so5865592wrc.9
	for <qemu-devel@nongnu.org>; Mon, 29 Jan 2018 05:49:42 -0800 (PST)
Date: Mon, 29 Jan 2018 13:49:39 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180129134939.GI20446@stefanha-x1.localdomain>
References: <CAK-iXgUO7LMZ7+Bvs66_yno_q6ZDEzgKS5baxG7SASVNChYyvw@mail.gmail.com>
	<982e13e4-6591-0f4c-9faa-17e0302ad350@redhat.com>
	<20180125105257.GC27269@stefanha-x1.localdomain>
	<20180125110208.GB1776@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="81JctsDUVPekGcy+"
Content-Disposition: inline
In-Reply-To: <20180125110208.GB1776@redhat.com>
Subject: Re: [Qemu-devel] Prevent overriding the input file with the output
 file when using qemu-img
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, River Chiang <riverchiang@gmail.com>, qemu-devel@nongnu.org


--81JctsDUVPekGcy+
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 25, 2018 at 11:02:08AM +0000, Daniel P. Berrang=E9 wrote:
> On Thu, Jan 25, 2018 at 10:52:57AM +0000, Stefan Hajnoczi wrote:
> > On Tue, Jan 23, 2018 at 08:48:15AM -0600, Eric Blake wrote:
> > > On 01/22/2018 10:40 PM, River Chiang wrote:
> > > >     Signed-off-by: River Chiang <riverchiang@gmail.com>
> > > >=20
> > > > ---------------------------------- qemu-img.c
> > > > ----------------------------------
> > > > index 68b375f998..5ce594ea00 100644
> > > > @@ -2098,6 +2098,9 @@ static int img_convert(int argc, char **argv)
> > > >      if (s.src_num < 1) {
> > > >          error_report("Must specify image file name");
> > > >          goto fail_getopt;
> > > > +    } else if (!strcmp(argv[optind], out_filename)) {
> > > > +        error_report("Override the input file with the output file=
");
> > > > +        goto fail_getopt;
> > >=20
> > > Comparing names is too prone to false negatives.  'foo' and './foo' a=
re
> > > the same file, but your test won't catch it.  Better might be checking
> > > if stat() reports the same dev/inode pair for the two files.
> > >=20
> > > By the way, your patch is not in proper 'git send-email' format, which
> > > makes it hard to test whether it even applies.  More patch submission
> > > hints at http://wiki.qemu.org/Contribute/SubmitAPatch
> >=20
> > stat(2) cannot be used since the "filenames" may not be a local file,
> > (nbd://, iscsi://, etc).
> >=20
> > strcmp(3) is also not a full solution, for the reasons you mentioned.
>=20
> It isn't a full solution, but I does it really need to be ? This check
> is only needed to protect against user accidents. It doesn't trigger
> false reports so won't block valid usage, it merely fails to report
> the problem in some edge cases.  IOW, I think strcmp is good enough
> in absence of any other simple solution - better than nothing IMHO.

I don't think a partial solution to protecting the user is worthwhile.
It gives a false impression.

If we do decide to add the strcmp(3) check, then please add it to all
sub-commmands where it's needed.  qemu-img dd comes to mind and there
are probably others.

Stefan

--81JctsDUVPekGcy+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEbBAEBAgAGBQJabyZzAAoJEJykq7OBq3PIwHAH93hushBoYBP3htypa5rfCAsY
FwfLzM17BI/c8XHQUGaAGILT6M+VnlF1TtPd8OnBXseoFH672mnMZoqHhZraLHDE
nqdpZYX+/4TzEwLEgD8YM8NGr6zATs8G8ZpgwrokAKp5NhiE+ZqqA16qCBj7zjur
YMxQ0MJ2opmOMf1Q604j6lCHap30dHFqsA8nbNCfRrZui2hFcJ7Jk2nfffYK8OCb
FBzvtn8iE72OpDdnagGpczVan/ejNwDcn/Wqf/KXwqhOWNpmCj1rTpyFGHu/QXwy
JDV/ivhHSL4aCQC8tHFe9lGWu/Tc5MjXCM8rA72gXnUAPgVDsbvPwKz9/ixBkg==
=D06a
-----END PGP SIGNATURE-----

--81JctsDUVPekGcy+--
