Received: from eggs.gnu.org ([2001:4830:134:3::10]:56693)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cnmR4-000301-0g
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 09:24:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cnmR0-0003V2-OV
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 09:24:21 -0400
References: <1489477952-6901-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <14a8d8e9-fe37-5f32-c3c2-05419447fff6@redhat.com>
Date: Tue, 14 Mar 2017 08:24:13 -0500
MIME-Version: 1.0
In-Reply-To: <1489477952-6901-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="iFoe0CnpE29WcK9HflLB8fKLl5LCer2Ki"
Subject: Re: [Qemu-devel] [PATCH] hw/net/virtio-net.c: Follow CODING_STYLE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>, qemu devel <qemu-devel@nongnu.org>, Jason Wang <jasowang@redhat.com>, Laurent Vivier <laurent@vivier.eu>
Cc: QEMU Trivial <qemu-trivial@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--iFoe0CnpE29WcK9HflLB8fKLl5LCer2Ki
From: Eric Blake <eblake@redhat.com>
To: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>,
 qemu devel <qemu-devel@nongnu.org>, Jason Wang <jasowang@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>
Cc: QEMU Trivial <qemu-trivial@nongnu.org>
Message-ID: <14a8d8e9-fe37-5f32-c3c2-05419447fff6@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] hw/net/virtio-net.c: Follow CODING_STYLE
References: <1489477952-6901-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
In-Reply-To: <1489477952-6901-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/14/2017 02:52 AM, Zhang Chen wrote:
> Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
> ---
>  hw/net/virtio-net.c | 53 +++++++++++++++++++++++++++++++++------------=
--------
>  1 file changed, 33 insertions(+), 20 deletions(-)
>=20
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index c321680..ede618e 100644
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -273,7 +273,7 @@ static void virtio_net_set_status(struct VirtIODevi=
ce *vdev, uint8_t status)
>          if (queue_started) {
>              if (q->tx_timer) {
>                  timer_mod(q->tx_timer,
> -                               qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) +=
 n->tx_timeout);
> +                         qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + n->tx=
_timeout);

Indentation still looks off.  You want the two q's to be in the same colu=
mn.

Otherwise looks okay. Wholesale reformatting of a file with no other
changes tends to make 'git blame' attribution a bit noisier than
necessary, so it's a maintainer's judgment call whether to take it.  But
with the indentation fixed, you can add:
Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--iFoe0CnpE29WcK9HflLB8fKLl5LCer2Ki
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYx+79AAoJEKeha0olJ0NqWaQH/i46jcXjl+P4en4pWzyAWBl9
09YiPZ+/KGN8BJdlfFJ+4IMBEuoe7l9nCAkMfUwF8Xbx/3oQxyThiWA+n/kRMXTE
8a39CL5TGKGz7jcIte0ORa+4nG1w/0tLf8UE1dv/IMr4KkE6HQI+YqKHtS8ZO6L6
qscIQdu9r7ZgUWaaD6jSK8i9yo0c0u8WkzbE2F6Wk4Evz18zY4MrjEZLXpdg7O+O
DXcIVd9JI5R0gH6lvxDqfSUTom03gPA6BN8BWonjX5M9hyjPhVM4ekiYLNWdNX5G
PYMF30j7MSlihaOZLqEniPdD/+r5Gpoz4wfjr8F52u8uHbku8lbMRD5Xs30utKg=
=EdmU
-----END PGP SIGNATURE-----

--iFoe0CnpE29WcK9HflLB8fKLl5LCer2Ki--
