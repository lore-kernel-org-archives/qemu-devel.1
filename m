Received: from eggs.gnu.org ([2001:4830:134:3::10]:48368)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dVxri-00037d-6B
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 06:30:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dVxrf-0007WQ-0k
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 06:30:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44106)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1dVxre-0007W5-Qw
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 06:30:26 -0400
Date: Fri, 14 Jul 2017 11:30:20 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170714103020.GG27446@stefanha-x1.localdomain>
References: <20170713110237.6712-1-lprosek@redhat.com>
	<20170713110237.6712-8-lprosek@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9Iq5ULCa7nGtWwZS"
Content-Disposition: inline
In-Reply-To: <20170713110237.6712-8-lprosek@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 7/8] virtio-scsi: use virtqueue_error
 for errors with queue context
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ladi Prosek <lprosek@redhat.com>
Cc: qemu-devel@nongnu.org, casasfernando@hotmail.com, mst@redhat.com, jasowang@redhat.com, armbru@redhat.com, groug@kaod.org, arei.gonglei@huawei.com, aneesh.kumar@linux.vnet.ibm.com


--9Iq5ULCa7nGtWwZS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 13, 2017 at 01:02:36PM +0200, Ladi Prosek wrote:
> virtqueue_error includes queue index in the error output and is preferred
> for errors that pertain to a virtqueue rather than to the device as a who=
le.
>=20
> Signed-off-by: Ladi Prosek <lprosek@redhat.com>
> ---
>  hw/scsi/virtio-scsi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--9Iq5ULCa7nGtWwZS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZaJ08AAoJEJykq7OBq3PIiJQIAJAdPMZ4cA9NZd2O1Mx6QehN
fk9k5Z2Qr24Y0la8trUImGjozAmloX9aW1ZdYTfhiI0I3o/Syo7IbWXLJHP0b+X0
rwwVl2cMUz6X53+bVPtsttwy3ORoN2VjNg40plbEqF0hDDQu68tSTIfpKRQ/UuwF
kI1qXK6Ld5CCw/8nYyqMFunRHVlf7mEnF3egGpTfBgNfaos92zRpf883sIKVsQqt
Qw+xeTnFZYTFYCSIwc5t761E5t7gJH3pZTXEl9HF/YFeDbQSpk0e7qSlKwMmgpv0
/aObGo0RWPShk9fnnjqoVkjEwpUruKCwyydSuWt7G7JPr4bK5xPCYuD8ACYRfVo=
=rP1m
-----END PGP SIGNATURE-----

--9Iq5ULCa7nGtWwZS--
