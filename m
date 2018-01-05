Received: from eggs.gnu.org ([2001:4830:134:3::10]:44248)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eXUFP-0006zM-PG
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 10:49:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eXUFL-0005qS-OM
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 10:49:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36862)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1eXUFL-0005pN-Fp
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 10:49:27 -0500
Date: Fri, 5 Jan 2018 15:49:14 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180105154914.GH28322@stefanha-x1.localdomain>
References: <20171219162151.GA10889@stefanha-x1.localdomain>
	<1512291492.2209478.1513854089861.JavaMail.zimbra@redhat.com>
	<20180104104744.GC10106@stefanha-x1.localdomain>
	<5A4E0CDA.4060409@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LZFKeWUZP29EKQNE"
Content-Disposition: inline
In-Reply-To: <5A4E0CDA.4060409@intel.com>
Subject: Re: [Qemu-devel] vhost-user graceful connect/disconnect
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Wang <wei.w.wang@intel.com>
Cc: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org, mukawa@igel.co.jp, "Michael S. Tsirkin" <mst@redhat.com>, Maxime Coquelin <maxime.coquelin@redhat.com>, n nikolaev <n.nikolaev@virtualopensystems.com>


--LZFKeWUZP29EKQNE
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 04, 2018 at 07:15:38PM +0800, Wei Wang wrote:
> On 01/04/2018 06:47 PM, Stefan Hajnoczi wrote:
> > On Thu, Dec 21, 2017 at 06:01:29AM -0500, Marc-Andr=E9 Lureau wrote:
> >=20
> > I'm not going to prototype this yet, I'm working on virtio-vhost-user
> > first, but eventually I might get back to -object vhost-user(-backend).
> >=20
>=20
> Hi Stefan, are you implementing the guest slave and vhost-pci driver (we'=
ve
> posted to the dpdk mailinglist) as well? and do you have an estimation wh=
en
> would the prototype be ready?

I'm implementing the "[RFC virtio-dev] vhost-user-slave: add vhost-user
slave device type" device in QEMU and DPDK in order to show how the
ideas we've discussed work.

Here is the VIRTIO spec link again:
https://stefanha.github.io/virtio/vhost-user-slave.html#x1-2830007

It integrates into DPDK's librte_vhost so that existing vhost-user code
works over AF_UNIX and virtio-vhost-user without code duplication or
rewriting the devices.

I hope you'll like the code when it's done.  If not, it still has useful
code and ideas that would be needed to complete the vhost-pci RFC work
like extending the PCI transport in the VIRTIO spec, handling vhost-user
reconnection, etc.

I'm aiming to send an RFC in the next 2 weeks.

Stefan

--LZFKeWUZP29EKQNE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEbBAEBAgAGBQJaT556AAoJEJykq7OBq3PIROkH91N4PwZ9/IrAZO6WedIq0AEq
K/UsBAaDA4Oje969gU0ZvnyxMGI3ac3Di+1O4q8AQprdEVyJlWlPB2F+Ku2hIs6q
YhctLfNkVZO0DqRiX2QKzBz4Qfu7LFTptKAdYXRtApyf78Mh+2vpHLCwxcUoMrnu
/0ijdEKTFyQkOWfGXVr7xZu8ygkDpNsDeBNxpwb9Iw0TYUjzDT2jbiigvEqB7T2O
z/7jHnUWwcB2oGbzuage03j5+fdwGeTlfShbSvsoBpL3yV6/0oAWPiyuyD5eTpr3
sUQ0SqQXYxdM9dBgIbmQQAHXQrli/cYr4+IFgz44s0otcUL16HRUjVgfSpedhg==
=Aqyq
-----END PGP SIGNATURE-----

--LZFKeWUZP29EKQNE--
