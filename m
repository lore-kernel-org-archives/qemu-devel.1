Received: from eggs.gnu.org ([2001:4830:134:3::10]:43534)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fPm1A-0002vv-5o
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 05:43:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fPm17-0000GC-4g
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 05:43:12 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:40073)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1fPm16-0000FX-TR
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 05:43:09 -0400
Received: by mail-wm0-x244.google.com with SMTP id n5-v6so1589535wmc.5
	for <qemu-devel@nongnu.org>; Mon, 04 Jun 2018 02:43:08 -0700 (PDT)
Date: Mon, 4 Jun 2018 10:43:06 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180604094306.GD13674@stefanha-x1.localdomain>
References: <CANzW0muSNEuBquUdmU2E_vfpc6zTdsoQh6KG2ooQDBAwq12u6w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="x4pBfXISqBoDm8sr"
Content-Disposition: inline
In-Reply-To: <CANzW0muSNEuBquUdmU2E_vfpc6zTdsoQh6KG2ooQDBAwq12u6w@mail.gmail.com>
Subject: Re: [Qemu-devel] virtio-vsock feature has no TCG (non-KVM) support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Artem Pisarenko <artem.k.pisarenko@gmail.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>


--x4pBfXISqBoDm8sr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 01, 2018 at 04:15:52PM +0600, Artem Pisarenko wrote:
> Please, add important note to https://wiki.qemu.org/Features/VirtioVsock page,
> that this feature only supported in KVM accelerated mode. It's not obvious.
> Furthermore, it isn't checked by qemu when invoking with "-device
> vhost-vsock-pci,..." and user encounters this only when communicating (via
> AF_VSOCK) application fails to connect() with weird "Connection timed out"
> error.

Hi Artem,
Thanks for letting me know this is broken.  In principle it should work
because the kernel vhost drivers are independent of KVM and QEMU already
implements the ioeventfd mechanism that vhost needs in TCG mode.

I've added it to my todo list.

Stefan

--x4pBfXISqBoDm8sr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbFQmpAAoJEJykq7OBq3PIyQcH/jRk6eAuwUD/V3QfP/tuhGVG
uaPMBQcAvxPk5Gwoq/lifzY1RwV9nnhBuQSC6kS8gGe3phEaqONJY2nMjet3HAbH
hXBMFfx6SDnLwIiWUy1UalDj8hjnYUCEXi6OlcHcXbSJwOcF7ptLnudFWEP0TT/v
xNGiOMfeMcfdfvBj7V1YFVn3hA+owIhomeYvV+FuFCYyLy2U82XKuL+uhaz5LZf3
MwvrySVdr9Jx9tI1bN0kaAMtNaQkZBMs2onRD0H1G+jEA05xeVSYK7qSQSa/D4XP
JOPyKkB8GbKQcLuC0Lfff9mf5Mog3//LH+KfVJtMtVitXrfXM2lsHLEhtYiNC8o=
=XHaq
-----END PGP SIGNATURE-----

--x4pBfXISqBoDm8sr--
