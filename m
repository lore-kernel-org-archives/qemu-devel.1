Received: from eggs.gnu.org ([2001:4830:134:3::10]:38564)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eBkwp-0004em-0m
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 12:12:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eBkwl-00020X-6a
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 12:12:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35438)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1eBkwk-0001zW-Tx
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 12:12:27 -0500
Date: Mon, 6 Nov 2017 17:12:24 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20171106171224.GH4557@stefanha-x1.localdomain>
References: <1476435656-3100-1-git-send-email-stefanha@redhat.com>
	<1476435656-3100-4-git-send-email-stefanha@redhat.com>
	<f142a70a-dd03-76e3-52a7-79277c51928a@redhat.com>
	<20161016133526.GA13844@stefanha-x1.localdomain>
	<bb54ed67-1839-4527-13e1-45009b6d4adf@redhat.com>
	<20161018102123.GF19457@stefanha-x1.localdomain>
	<20171105185959.fi5xvniqicg7rtiq@eukaryote>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ISKrrfpKsPiF35CV"
Content-Disposition: inline
In-Reply-To: <20171105185959.fi5xvniqicg7rtiq@eukaryote>
Subject: Re: [Qemu-devel] [PATCH v2 3/4] sockets: add AF_VSOCK support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kashyap Chamarthy <kchamart@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>


--ISKrrfpKsPiF35CV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 05, 2017 at 07:59:59PM +0100, Kashyap Chamarthy wrote:
> [Reviving a more than 1-year old thread.  I randomly noticed this (refer
> below) while browsing through AF_VSOCK changes in my 'qemu-devel'
> maildir.]
>=20
> On Tue, Oct 18, 2016 at 11:21:23AM +0100, Stefan Hajnoczi wrote:
> > On Mon, Oct 17, 2016 at 09:25:46AM -0500, Eric Blake wrote:
> > > On 10/16/2016 08:35 AM, Stefan Hajnoczi wrote:
> > >=20
> > > >>> +
> > > >>> +    if (sscanf(str, "%32[^:]:%32[^,]%n", cid, port, &n) !=3D 2) {
> > > >>
> > > >> This says stop at the first comma after the colon...
> > > >>
> > > >>> +        error_setg(errp, "error parsing address '%s'", str);
> > > >>> +        return NULL;
> > > >>> +    }
> > > >>> +    if (str[n] !=3D '\0') {
> > > >>> +        error_setg(errp, "trailing characters in address '%s'", =
str);
> > > >>
> > > >> ...but this rejects a trailing comma.  Is a trailing comma possibl=
e base
> > > >> on how QemuOpts work? If so, do you need to handle it here?
> > > >=20
> > > > Actually I just wanted to grab characters up until the end of strin=
g.
> > > > It wasn't clear from the sscanf(3) man page what the best way to do=
 that
> > > > was, so I kept the comma which is also used in tcp addresses (becau=
se
> > > > they support additional comma-separated options).
> > >=20
> > > %32s instead of %32[^,] should grab up to all 32 remaining characters=
 in
> > > the string; your %n trick then ensures there is no garbage.  I guess
> > > it's still a question of whether we want to always treat a comma as
> > > trailing garbage.
> >=20
> > No comma options are currently accepted.  Treating comma as garbage
> > seems okay.
> >=20
> > Mike: Please change %32[^,] to %32s when merging.  Thanks!
>=20
> The above change didn't take place while merging at that time as part of
> v2.7.0-1720-g6a02c80.
>=20
> I still see %32[^,] in all the sscanf(3) calls in
> util/util/qemu-sockets.c
>=20
> Is it still important to change?

Thanks for noticing.  I don't think it's necessary to make this change
now.

Stefan

--ISKrrfpKsPiF35CV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaAJf3AAoJEJykq7OBq3PIV80IAIp0IOI8KaPDPtm3FAuiz/+a
UdpAMy4aNRHCOXQ86e/NuEVUcUHiMXOc3QGxY14fFi78sexCeNR8DRbKh6lniRM2
VyUYduNq2wsJuX6Rz77hp7jxeuzL3ccTa+0Fs4xDn9qrBfOKDhXbjnDYcKggTc5N
7SdxvNnblo7A8iNZsS6GJXNzrJdPMtcGM1iQkbf1WKvzoQVJDoqGuPAlPLEw3qjf
VK18VYy96PbA3lhEX/ms3Q/EQWXUnxyqeQqfeGTa7W/hInmWvRHXSe4sIvrKUeXj
/+3H1K0YJvwI3VQVQHhE9Vw/ETbX7ZH7cW0wBpcdAsekTTvEHZS03ZA0cLXBPIw=
=Ix+z
-----END PGP SIGNATURE-----

--ISKrrfpKsPiF35CV--
