Received: from eggs.gnu.org ([2001:4830:134:3::10]:34307)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dVbSV-0003OQ-TM
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 06:35:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dVbSS-0007aD-Nu
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 06:34:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51844)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dVbSS-0007a1-EY
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 06:34:56 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 502915F7B4
	for <qemu-devel@nongnu.org>; Thu, 13 Jul 2017 10:34:55 +0000 (UTC)
References: <ae882d766ec76c57a7babc2798f16a5a31d64358.1499931846.git.mprivozn@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c51771be-ae45-0a57-56c4-2f20d22bc594@redhat.com>
Date: Thu, 13 Jul 2017 05:34:51 -0500
MIME-Version: 1.0
In-Reply-To: <ae882d766ec76c57a7babc2798f16a5a31d64358.1499931846.git.mprivozn@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="7M53PNuMpIc4fjMEv0t2qNboPjB1OVFkL"
Subject: Re: [Qemu-devel] [PATCH] virtion-net: Prefer is_power_of_2()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michal Privoznik <mprivozn@redhat.com>, qemu-devel@nongnu.org
Cc: jasowang@redhat.com, mst@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--7M53PNuMpIc4fjMEv0t2qNboPjB1OVFkL
From: Eric Blake <eblake@redhat.com>
To: Michal Privoznik <mprivozn@redhat.com>, qemu-devel@nongnu.org
Cc: jasowang@redhat.com, mst@redhat.com
Message-ID: <c51771be-ae45-0a57-56c4-2f20d22bc594@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] virtion-net: Prefer is_power_of_2()
References: <ae882d766ec76c57a7babc2798f16a5a31d64358.1499931846.git.mprivozn@redhat.com>
In-Reply-To: <ae882d766ec76c57a7babc2798f16a5a31d64358.1499931846.git.mprivozn@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/13/2017 02:44 AM, Michal Privoznik wrote:

In the subject: s/virtion/virtio/

> We have a function that checks if given number is power of two.
> We should prefer it instead of expanding the check on our own.
>=20
> Signed-off-by: Michal Privoznik <mprivozn@redhat.com>
> ---
>  hw/net/virtio-net.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index 5630a9ec44..657d099c54 100644
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -1942,7 +1942,7 @@ static void virtio_net_device_realize(DeviceState=
 *dev, Error **errp)
>       */
>      if (n->net_conf.rx_queue_size < VIRTIO_NET_RX_QUEUE_MIN_SIZE ||
>          n->net_conf.rx_queue_size > VIRTQUEUE_MAX_SIZE ||
> -        (n->net_conf.rx_queue_size & (n->net_conf.rx_queue_size - 1)))=
 {
> +        !is_power_of_2(n->net_conf.rx_queue_size)) {
>          error_setg(errp, "Invalid rx_queue_size (=3D %" PRIu16 "), "
>                     "must be a power of 2 between %d and %d.",

As long as we're touching this, we should get rid of the trailing '.',
which error_setg() documents should not be used.

With those fixed, you can add:
Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--7M53PNuMpIc4fjMEv0t2qNboPjB1OVFkL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZZ0zLAAoJEKeha0olJ0NqsbIIAJakouAQgcSeH29/tvtKajQK
Wvu7NWnjaPFFSaKGMruhz/aIiYu5Id8efDIxJu5ThB3sU9fWBC8KBT/aK20veyFl
6XG0l3mj/QL6/dwwa/Iy2x16W+xXnsui/1DBK4IiCRXXDr7sUnDIKcdxWq1sOyRn
yNe5LfvKACxTiFJvy68LXNBQzsa8a0gsrgZjca8ae0eYpphlvEB7hGVyTNjyNJQ1
ff5T42YhN9nWtDTQq05ozltaONqSVqffKPnEIo3Js4a0FwlNLDG1tUqzX5np2by8
iAd4cN/EC9pZqkKylrVp8OAcEPRwQkN7k8fAkcLqX14mXjcsKMS7LE4m+iJ26iU=
=ulAJ
-----END PGP SIGNATURE-----

--7M53PNuMpIc4fjMEv0t2qNboPjB1OVFkL--
