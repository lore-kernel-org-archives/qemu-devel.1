Received: from eggs.gnu.org ([2001:4830:134:3::10]:34045)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dHu8w-0006GJ-Av
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 11:42:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dHu8t-0005Ho-4k
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 11:42:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58058)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dHu8s-0005H4-Rk
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 11:42:07 -0400
References: <1496653049-44530-1-git-send-email-wei.w.wang@intel.com>
	<20170605182514-mutt-send-email-mst@kernel.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <4a21db67-4c02-7895-6b5c-1d60fe85c7f2@redhat.com>
Date: Mon, 5 Jun 2017 10:41:56 -0500
MIME-Version: 1.0
In-Reply-To: <20170605182514-mutt-send-email-mst@kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="7NNgGdpB09PhSeOhRngG7Pi9rtbPWDmrN"
Subject: Re: [Qemu-devel] [PATCH v1] virtio-net: enable configurable tx
 queue size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, Wei Wang <wei.w.wang@intel.com>
Cc: jasowang@redhat.com, stefanha@gmail.com, marcandre.lureau@gmail.com, pbonzini@redhat.com, virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org, jan.scheurich@ericsson.com, armbru@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--7NNgGdpB09PhSeOhRngG7Pi9rtbPWDmrN
From: Eric Blake <eblake@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Wei Wang <wei.w.wang@intel.com>
Cc: jasowang@redhat.com, stefanha@gmail.com, marcandre.lureau@gmail.com,
 pbonzini@redhat.com, virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org,
 jan.scheurich@ericsson.com, armbru@redhat.com
Message-ID: <4a21db67-4c02-7895-6b5c-1d60fe85c7f2@redhat.com>
Subject: Re: [PATCH v1] virtio-net: enable configurable tx queue size
References: <1496653049-44530-1-git-send-email-wei.w.wang@intel.com>
 <20170605182514-mutt-send-email-mst@kernel.org>
In-Reply-To: <20170605182514-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06/05/2017 10:38 AM, Michael S. Tsirkin wrote:
> On Mon, Jun 05, 2017 at 04:57:29PM +0800, Wei Wang wrote:
>> This patch enables the virtio-net tx queue size to be configurable
>> between 256 and 1024 by the user. The queue size specified by the
>> user should be power of 2. If "tx_queue_size" is not offered by the
>> user, the default queue size, 1024, will be used.
>>

>> +    if (n->net_conf.tx_queue_size < VIRTIO_NET_TX_QUEUE_MIN_SIZE ||
>> +        n->net_conf.tx_queue_size > VIRTQUEUE_MAX_SIZE ||
>> +        (n->net_conf.tx_queue_size & (n->net_conf.tx_queue_size - 1))=
) {
>=20
> Pls use is_power_of_2.
>=20
>> +        error_setg(errp, "Invalid tx_queue_size (=3D %" PRIu16 "), "
>> +                   "must be a power of 2 between %d and %d.",

No trailing '.' in error_setg() messages, please.

>> +                   n->net_conf.tx_queue_size, VIRTIO_NET_TX_QUEUE_MIN=
_SIZE,
>> +                   VIRTQUEUE_MAX_SIZE);
>=20
> I think management will need a way to discover the limits for
> this value. Not sure how. Cc QAPI maintainers.

Is this something that can be documented? Or is it a runtime-variable
limit, where you will need to query the limit on a per-machine basis?
Given that it looks like compile-time documentation, I'm leaning towards
documentation being sufficient.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--7NNgGdpB09PhSeOhRngG7Pi9rtbPWDmrN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZNXvEAAoJEKeha0olJ0NqUdUH/3sfY7ilVzVYNO/+tTfqzLO9
oVHdRz07EJhITXDPoESLH4Z1brTFTw8OiJN7TTa/Zn3W45NMx61qQSwl7RNAYAGi
p/SIrg+tqUvd/3xi0+6nQeRoEHCBbxT6K1dkpz1gNGjzOFxSyxGj76yGiDwktg0/
cxAx9Fq02jtaN4Pi70jRZsa2YmvQ/dqTUMd+yUAj8PjOPQklngm7F8CIUkVefQJb
x0k/trIY43de9fM5iArzBVVVxAkkKBxX1Qnw+J7GBDnfTr5/c7hP8tgd6kz2CF9g
Q3kGkyZJUioWKJkdmC+6miawXkr91LSNc5Pqi8zHspqWdzdtZsCeoSdhVdw6dws=
=7Em/
-----END PGP SIGNATURE-----

--7NNgGdpB09PhSeOhRngG7Pi9rtbPWDmrN--
