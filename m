Received: from eggs.gnu.org ([2001:4830:134:3::10]:49398)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dkubN-0006tR-It
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 12:03:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dkubM-0000me-FH
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 12:03:25 -0400
References: <20170823140506.28723-1-stefanha@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <9b8f814f-dcc4-0247-64ef-13a4e921c2a3@redhat.com>
Date: Thu, 24 Aug 2017 11:03:07 -0500
MIME-Version: 1.0
In-Reply-To: <20170823140506.28723-1-stefanha@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="chrjR7l8V3n4B2bLJlOmIXpTmIm9U4DUR"
Subject: Re: [Qemu-devel] [PATCH] qemu-iotests: add 194 non-shared storage
 migration test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-block@nongnu.org, Fam Zheng <famz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--chrjR7l8V3n4B2bLJlOmIXpTmIm9U4DUR
From: Eric Blake <eblake@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-block@nongnu.org,
 Fam Zheng <famz@redhat.com>
Message-ID: <9b8f814f-dcc4-0247-64ef-13a4e921c2a3@redhat.com>
Subject: Re: [PATCH] qemu-iotests: add 194 non-shared storage migration test
References: <20170823140506.28723-1-stefanha@redhat.com>
In-Reply-To: <20170823140506.28723-1-stefanha@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/23/2017 09:05 AM, Stefan Hajnoczi wrote:
> Non-shared storage migration with NBD and drive-mirror is currently not=

> tested by qemu-iotests.  This test case covers the basic migration
> scenario.
>=20
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> Based-on: <20170823134242.12080-1-famz@redhat.com>
> ---
>  tests/qemu-iotests/194        | 73 +++++++++++++++++++++++++++++++++++=
++++++++
>  tests/qemu-iotests/194.out    | 13 ++++++++
>  tests/qemu-iotests/group      |  1 +
>  tests/qemu-iotests/iotests.py | 13 ++++++++
>  4 files changed, 100 insertions(+)
>  create mode 100755 tests/qemu-iotests/194
>  create mode 100644 tests/qemu-iotests/194.out
>=20

> +iotests.log('Waiting for drive-mirror to complete...')
> +iotests.log(source_vm.event_wait('BLOCK_JOB_READY'),
> +            filters=3D[iotests.filter_qmp_event])
> +
> +iotests.log('Starting migration...')
> +source_vm.qmp('migrate-set-capabilities',
> +              capabilities=3D[{'capability': 'events', 'state': True}]=
)
> +dest_vm.qmp('migrate-set-capabilities',
> +            capabilities=3D[{'capability': 'events', 'state': True}])
> +iotests.log(source_vm.qmp('migrate', uri=3D'unix:{0}'.format(migration=
_sock_path)))
> +
> +while True:
> +    event =3D source_vm.event_wait('MIGRATION')
> +    iotests.log(event, filters=3D[iotests.filter_qmp_event])
> +    if event['data']['status'] in ('completed', 'failed'):
> +        break

As a followup patch for 2.11, we could extend this test to also issue a
block-job-cancel (to further imitate the sequence of commands issued by
libvirt).  But that enhancement is not a show-stopper for what got
committed for 2.10-rc4.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--chrjR7l8V3n4B2bLJlOmIXpTmIm9U4DUR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlme+LsACgkQp6FrSiUn
Q2rHjwf/adhlov5tztZyJTge06t2G7t6qu/qzZWGesnzyLlCQDrU1DmkEBmIzMFa
fiF24/A5BCxbV7gdNWLigPi24fUUCzg5BlN7tgchKAv/I+jgOQJ75dfqCwRgUXeL
RW+BfxNVS98zVSMN64fggWV1jjwPfbzy2Kj5VCzxANq3JBgbaQ9kfys3NAreahy+
UQbfzQWYcWK2tMP9AXyOw/cQXJH+BgDoM7c3+8oQD7mO3UFd1Li6rQwiWLvRdZrE
/qWp8+OSNG4AKYl7hydCjJhbfgZB0ta8GQx7EN5gboTl9iFlYXmTrfLDHFRMYueT
fiu2WbZl4qBKGqjeNpXwwLgBkoe2kg==
=rzyy
-----END PGP SIGNATURE-----

--chrjR7l8V3n4B2bLJlOmIXpTmIm9U4DUR--
