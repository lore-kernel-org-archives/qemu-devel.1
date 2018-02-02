Received: from eggs.gnu.org ([2001:4830:134:3::10]:46281)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ehch5-0007c2-Mt
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 09:52:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ehch1-0007Mg-Qr
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 09:51:59 -0500
References: <20180202143746.204851-1-borntraeger@de.ibm.com>
	<20180202143746.204851-2-borntraeger@de.ibm.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <3242e804-e38d-d989-0f98-46b8eeb21e36@redhat.com>
Date: Fri, 2 Feb 2018 08:51:49 -0600
MIME-Version: 1.0
In-Reply-To: <20180202143746.204851-2-borntraeger@de.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="HrWx33xsgNPJztKb5qIAEguu7FVa2dve4"
Subject: Re: [Qemu-devel] [PATCH v3 1/1] s390x/cpu: expose the guest crash
 information
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x <qemu-s390x@nongnu.org>
Cc: qemu-devel <qemu-devel@nongnu.org>, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>, Halil Pasic <pasic@linux.vnet.ibm.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--HrWx33xsgNPJztKb5qIAEguu7FVa2dve4
From: Eric Blake <eblake@redhat.com>
To: Christian Borntraeger <borntraeger@de.ibm.com>,
 qemu-s390x <qemu-s390x@nongnu.org>
Cc: qemu-devel <qemu-devel@nongnu.org>, Cornelia Huck <cohuck@redhat.com>,
 Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>,
 Halil Pasic <pasic@linux.vnet.ibm.com>
Message-ID: <3242e804-e38d-d989-0f98-46b8eeb21e36@redhat.com>
Subject: Re: [PATCH v3 1/1] s390x/cpu: expose the guest crash information
References: <20180202143746.204851-1-borntraeger@de.ibm.com>
 <20180202143746.204851-2-borntraeger@de.ibm.com>
In-Reply-To: <20180202143746.204851-2-borntraeger@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/02/2018 08:37 AM, Christian Borntraeger wrote:
> This patch is the s390 implementation of guest crash information,
> similar to commit d187e08dc4 ("i386/cpu: add crash-information QOM
> property") and the related commits. We will detect several crash
> reasons, with the "disabled wait" being the most important one, since
> this is used by all s390 guests as a "panic like" notification.
>=20
> Demonstrate these ways with examples as follows.
>=20
>   1. crash-information QOM property;

>=20
> Co-authored-by: Jing Liu <liujbjl@linux.vnet.ibm.com>
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  qapi/run-state.json   | 29 ++++++++++++++++++++++++--

QAPI changes look reasonable; I'll leave the review of the
target-specific code to those more familiar with the target.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--HrWx33xsgNPJztKb5qIAEguu7FVa2dve4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlp0ewUACgkQp6FrSiUn
Q2oEoggAiz1VNRrKUhM7+bqfTXKc6ZwXpSh59OAM0mLdtZIhSS24ybj8iHlZ3Za4
lYneRO05a/pmliQ7CTZdzs1hrs/LuAZrMrais2U5+cWfTboZmQXISwQka/NFF4jQ
xFRGjglLkgUHi9E74eanZrPRFswXjN4ZMAgzWVrYCTBmwR8inLWs6oSTvqLoHMxX
MQXvXU3H8ib6JDW0MMa309QnXe4bS++qCpbML4svyIQ+opd/xIi1vXJejg+6xQ6d
EIp7n7boA01f5WOvWZLoR5rXqvkmbutljhNccpgdPnjY5aB5QgFJxN3YduxaOhXu
ZtviRJMhrJ80RJzAbennso3lgc+YPQ==
=ihVs
-----END PGP SIGNATURE-----

--HrWx33xsgNPJztKb5qIAEguu7FVa2dve4--
