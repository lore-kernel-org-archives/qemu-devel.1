Received: from eggs.gnu.org ([2001:4830:134:3::10]:44566)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d0Pn2-0004Ua-HN
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 05:51:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d0Pmx-0004tD-Cp
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 05:51:16 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:33911)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1d0Pmx-0004t0-67
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 05:51:11 -0400
Received: by mail-wm0-x242.google.com with SMTP id z129so10985013wmb.1
	for <qemu-devel@nongnu.org>; Tue, 18 Apr 2017 02:51:10 -0700 (PDT)
Date: Tue, 18 Apr 2017 10:51:03 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170418095103.GF21261@stefanha-x1.localdomain>
References: <3d1c16a1-ec05-0367-e569-64a63b34f2e3@redhat.com>
	<4a56f716-3528-ddd4-f8c4-f3f6b23c469a@redhat.com>
	<bbc2671a-42dd-aa2a-0f03-6a4a487cb8f5@redhat.com>
	<20170327120148.GC26900@stefanha-x1.localdomain>
	<CAFEAcA_YVJKobjJ2WeEquxUdXVYeaCvA-K0+zumCc-Rm4Tk5nQ@mail.gmail.com>
	<20170403141912.GA3539@stefanha-x1.localdomain>
	<87fuhf9kcz.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NGIwU0kFl1Z1A3An"
Content-Disposition: inline
In-Reply-To: <87fuhf9kcz.fsf@dusky.pond.sub.org>
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
To: Markus Armbruster <armbru@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, John Snow <jsnow@redhat.com>, Jason Wang <jasowang@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>


--NGIwU0kFl1Z1A3An
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 11, 2017 at 02:53:00PM +0200, Markus Armbruster wrote:
> Stefan Hajnoczi <stefanha@gmail.com> writes:
>=20
> > On Mon, Mar 27, 2017 at 01:49:44PM +0100, Peter Maydell wrote:
> >> On 27 March 2017 at 13:01, Stefan Hajnoczi <stefanha@gmail.com> wrote:
> >> > It would be nice to get rid of the legacy -net option in 3.0.0.  I h=
ave
> >> > added it and included pointers to loose ends.  I think this is doable
> >> > but will require some time to achieve.
> >>=20
> >> What's the syntax for using -netdev with embedded network
> >> devices that you can't create with -device ?
> >> (We should document this at
> >> http://wiki.qemu-project.org/Documentation/Networking)
> >
> > I mentioned that on the wiki.  This isn't an option we can drop easily.
> > Work is necessary to make -netdev a complete replacement or to remove
> > the legacy stuff from -net.
>=20
> Just like -device is a general way to plug in devices, replacing
> multiple special ways (-net, -drive, -usb, ...), we could use a general
> way to configure onboard devices.

I looked at the -device implementation to see if the bus=3D parameter
could be used to specify onboard device addresses, but I think you may
be right that we need a separate command-line argument for onboard
devices.

--NGIwU0kFl1Z1A3An
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJY9eGHAAoJEJykq7OBq3PIYf0IAKKpu07PsWbcl/p3JuUt2pYY
oat31IU7DuEPTiEckHW95Mp3TLVQ1VyB+SsxE4cQaxokPQLzhnN6jOEYK8gdq8MZ
4m+Qjns+tWgT+K71Vlwl7kWakrXruyemqrtSJVjynu2wSAHyHHBInNFNjrmCp8CZ
lzjlc/izOpdUPd4ibcCD9FrraNin5olby2+Wd9mDQzApRPbQO/btmLX8XTarPHI8
+ujyI2KNhPnJ8w5fW7HSvOUySAcw8PPPp2osx8xF4LdxgEwYTbbT/sr9pGgm2BQb
yNL2jiJdXay6jIw4X28a+sMYy+jpSK3L4sKE29RyrgJ3em8dQQy10BTfxy9HoZ4=
=/dtq
-----END PGP SIGNATURE-----

--NGIwU0kFl1Z1A3An--
