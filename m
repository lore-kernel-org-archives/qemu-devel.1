Received: from eggs.gnu.org ([2001:4830:134:3::10]:57763)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pkrempa@redhat.com>) id 1fQWWp-0008Vi-EL
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 07:23:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pkrempa@redhat.com>) id 1fQWWo-0006Mm-IM
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 07:22:59 -0400
Date: Wed, 6 Jun 2018 13:22:48 +0200
From: Peter Krempa <pkrempa@redhat.com>
Message-ID: <20180606112248.GE2744@andariel.pipo.sk>
References: <20180524113251.GB4660@redhat.com>
	<d9bb2cb9-d9dc-8fe0-a767-10d9cbbab803@redhat.com>
	<20180528183058.GG2209@redhat.com>
	<20180528183833.GJ4580@localhost.localdomain>
	<20180528212054.GH2209@redhat.com>
	<20180528212510.GC4660@redhat.com>
	<20180529064415.GA4756@localhost.localdomain>
	<2b3eef00-f326-c1e6-0e4b-b7602646eec4@redhat.com>
	<20180605092159.GA2544@work-vm>
	<46ef4200-eccf-7e65-d3a0-69e4a7414b51@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Ns7jmDPpOpCD+GE/"
Content-Disposition: inline
In-Reply-To: <46ef4200-eccf-7e65-d3a0-69e4a7414b51@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] storing machine data in qcow images?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, "Richard W.M. Jones" <rjones@redhat.com>, stefanha@redhat.com


--Ns7jmDPpOpCD+GE/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 06, 2018 at 13:02:56 +0200, Max Reitz wrote:
> On 2018-06-05 11:21, Dr. David Alan Gilbert wrote:

[...]

> >       (I would suggest in layer2 that the keys are sorted, but
> >       that's a pain to do in some json creators)
> >    c) Forcing the registry of keys might avoid silly duplication.
> >       We can but hope.
> >    d) I've not said it's a libvirt XML file since that seems
> >       a bit prescriptive.
> >=20
> > Some initial suggested keys:
> >=20
> >    "qemu.machine-types": [ "q35", "i440fx" ]
> >    "qemu.min-ram-MB": 1024
>=20
> I still don't understand why you'd want to put the configuration into
> qcow2 instead of the other way around.
>=20
> Or why you'd want to use a single file at all, because as this whole
> thread shows, a disk image alone is clearly not sufficient to describe a =
VM.

I concur to many points made here. I think it would be wrong to put
anything besides disk-related data in a disk image.

If we want to have a all-in-one VM image, then it should be something
separate from this.

Some more points against squashing all this irrelevant stuff into qcow2
is that if you use it as a disk image only with any higher level
management you don't care about any stored configuration.

In fact in libvirt we'd need a way to prevent any of the data from the
disk image from  being applied to the configuration as it would create
problems.

Also there is a big difference between storing "suggestions" of
configuration and the actual full configuration itself. The
"suggestions" which storage controller or machine type to use are
sometimes helpful and sometimes not. Users may have their own
preference. And besides this we have the libosinfo project which can
provide suggestions.

I think that if the clear separation between a disk image format and an
all-in-one VM file is not kept it will end up in a big mess.

--Ns7jmDPpOpCD+GE/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEUn7DGLvflazX+2GwHGwCByjY1GoFAlsXxAUACgkQHGwCByjY
1GrNKQ/8D+TIc63KPUtN1jwP0gMiv03WKqbIvMcZSXgJnxeQPaqMF9bRPw3aoazP
HfeGptYZTIGg0qqL1de4mzRjVHynty5goWGM778ftBRac4yPoUM59cl5bja39QBf
dOvlprhibb4ZlTECzaTvV41EZb+B7PSCucWSNtXvfmqAe8kMFb8s6F0A0L7rAcct
He8Xv2Y92LJvhKrzkkGtxpwIX59DoMoI5cL0f+c1utNEbrN9xDHpvJZxyGc5fyco
oksvLrre08opA24XNQr/Zj/yWyIYNFxdY8AhAxX6zP9NxHwGTzJP8FQ3H0fUz1g0
65gCe/2pek6+iHM7zenGIzYD/pYN78J7aT0wuZaEZq7vyZD+x2lBMq9TQ/S/8U7L
YfYhfNT13h4C6n7gwLng5t+9vyhHh1w7RcsAS9UTsT49ixVxLJin4OhynEoOVuN5
eIVKbXJp1kUCvBlxsPlyG3JOKMYIkCfouGkEkONMf5K/26SxSd21gWRC/PvEqWYq
yaK058rwqfEjg4NYIT9s/wlWPmkUP9e1R9VenhhzA6R+7CkqcjhfK+AmS2txcCim
BoiPcgdIjPJ6U6TGSzz4j5QAzyDFPdIaVxlzADmBtqlPIiXHUj4eur6NOcKo5exl
9iCa+eBKHW4jORm/ZB1GP5RTf0XjEq4Ydk5TSvpZ8UiGwrArmMk=
=Zyrc
-----END PGP SIGNATURE-----

--Ns7jmDPpOpCD+GE/--
