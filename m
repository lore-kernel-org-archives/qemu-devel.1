Received: from eggs.gnu.org ([2001:4830:134:3::10]:35692)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cUEVz-00029j-SO
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 10:20:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cUEVy-0000DL-Ky
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 10:20:39 -0500
Date: Thu, 19 Jan 2017 16:20:29 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170119152029.GA5443@noname.redhat.com>
References: <1477926350-15869-1-git-send-email-ashijeetacharya@gmail.com>
	<20161031172022.GD12558@noname.redhat.com>
	<50472f2d-4a71-5f6b-1037-bbefd2d8f4f4@kamp.de>
	<20170118095952.GA5258@noname.str.redhat.com>
	<566d163c-eb70-718f-b04b-a86d6370a007@kamp.de>
	<43209b10-7760-8df6-d5a9-d6b66bebc292@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tKW2IUtsqtDRztdT"
Content-Disposition: inline
In-Reply-To: <43209b10-7760-8df6-d5a9-d6b66bebc292@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v6 0/2] allow blockdev-add for NFS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Peter Lieven <pl@kamp.de>, Ashijeet Acharya <ashijeetacharya@gmail.com>, jcody@redhat.com, mreitz@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org


--tKW2IUtsqtDRztdT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 19.01.2017 um 15:59 hat Eric Blake geschrieben:
> On 01/19/2017 08:30 AM, Peter Lieven wrote:
> >>> qemu-img: Could not open
> >>> 'nfs://172.21.200.61/vcore-dev-cdrom/templates/VC_debian8-20170116.qc=
ow2,linux?readahead=3D131072':
> >>> Block protocol 'nfs' doesn't support the option 'readahead-size'
> >>>
> >>> Please let me know if the below fix would be correct:
> >> No, this needs to be fixed the other way round: runtime_opts must use
> >> the names as specified in the schema, and nfs_client_open() must access
> >> them as such. Without that, blockdev-add can't work (and the command
> >> line only with the "wrong" old option names from the URL, whereas it
> >> should be using the same names as the QAPI schema).
> >=20
> > Shouldn't we support both for backwards compatiblity.?
>=20
> blockdev-add only needs to support the modern naming.  But yes,
> preserving back-compat spelling of the command-line spellings, as well
> as matching blockdev-add spellings, is desirable.

We only just added the individual command line options, previously it
only supported the URL.

It's true that we have the messed up version of the options in 2.8, so
strictly speaking we would break compatibility with a release, but it's
only one release, it's only the nfs driver, and the documentation of the
options is the schema, which had the right option names even in 2.8
(they just didn't work).

So I wouldn't feel bad about removing the wrong names in this specific
case.

Kevin

--tKW2IUtsqtDRztdT
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJYgNk9AAoJEH8JsnLIjy/W16UP/RdPunLp8UxDDPXCo7/ybPu7
PzNs8tnmXkL3DnfSby6h3wxN9cRbsMnE9QmLQZQjumDDpR9oewnmwBLItvysNDOi
mEPdi4pJY67OdqdxEtauLqejBVENcnLCjyFe1A+dwv/1TZsGz0QM3yjnoOaa4GEz
zHXdsGG0PjEbkWazcJGP4IhacXcCg1sw9NnCtwCR7jnNb8Yp2qPPMUKEIBjni+p/
NJecXmlLewaAGPOMj2RI9NRxFY9M0qHGG3V+5MQCkB3lHWMJ2TyexdFjM9XPm7iv
8FgLtbTvTs51m1FVXhenvdW8Dg+gruoYQ0IaE0FZ9v4prXe3D2XayNnPWlzmc1kg
NxX+8+iPepkjQtJA6WxHPazBHo6NFr1DY/CyRQfa9RQg05/3Rw3c8rXjnpzqBC54
zOIdZNzG0hK0odzk6yEdiZ9Knjn42JRTwhTngK9CQHSoh5RMQYvLo5yLQeD6XquV
7UMtl6tkGhkRYWOyTQ2jGxuvQ7xQ4zsa7kfTJvSamGBjcBpyWOPWGH27+ow+ccu0
U5pDkD+jcfc1FleqcuvLFf3hWdacASDUJIbqW9bxowQGQjSE5UDtiLTZtGxUlN7H
jW1MJYHRZZC4ROQM/YSzesV3deFve8cwo6WdVW1N1oBLY0A/RXHR7AefTkvn8bef
5axKPIVEkVrl2nZwCdmp
=B7It
-----END PGP SIGNATURE-----

--tKW2IUtsqtDRztdT--
