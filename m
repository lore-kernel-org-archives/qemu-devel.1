Received: from eggs.gnu.org ([2001:4830:134:3::10]:59072)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dhx2p-0004dd-MK
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 08:03:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dhx2m-000773-HZ
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 08:03:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38192)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dhx2m-00076S-86
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 08:03:28 -0400
References: <1502881586-25044-1-git-send-email-vadim.galitsyn@profitbricks.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <11c4defb-1915-0544-6ea8-9816500b749a@redhat.com>
Date: Wed, 16 Aug 2017 07:03:22 -0500
MIME-Version: 1.0
In-Reply-To: <1502881586-25044-1-git-send-email-vadim.galitsyn@profitbricks.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="r9X0UaeeQd7H04eIQDBnUAxN1tsfa8mbM"
Subject: Re: [Qemu-devel] [PATCH v6 1/3] Extend "info numa" with hotplugged
 memory information
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vadim Galitsyn <vadim.galitsyn@profitbricks.com>, Eduardo Habkost <ehabkost@redhat.com>, David Hildenbrand <david@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>, Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--r9X0UaeeQd7H04eIQDBnUAxN1tsfa8mbM
From: Eric Blake <eblake@redhat.com>
To: Vadim Galitsyn <vadim.galitsyn@profitbricks.com>,
 Eduardo Habkost <ehabkost@redhat.com>, David Hildenbrand <david@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 qemu-devel@nongnu.org
Message-ID: <11c4defb-1915-0544-6ea8-9816500b749a@redhat.com>
Subject: Re: [PATCH v6 1/3] Extend "info numa" with hotplugged memory
 information
References: <1502881586-25044-1-git-send-email-vadim.galitsyn@profitbricks.com>
In-Reply-To: <1502881586-25044-1-git-send-email-vadim.galitsyn@profitbricks.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/16/2017 06:06 AM, Vadim Galitsyn wrote:
> Report amount of hotplugged memory in addition to total
> amount per NUMA node.
>=20

meta-comment: when sending a multi-patch series, it's best to include a
0/3 cover letter.  This, and more tips, are found at
http://wiki.qemu.org/Contribute/SubmitAPatch

> Signed-off-by: Vadim Galitsyn <vadim.galitsyn@profitbricks.com>
> Cc: Eduardo Habkost <ehabkost@redhat.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: qemu-devel@nongnu.org
> ---
>  include/qemu/typedefs.h |  1 +
>  include/sysemu/numa.h   |  7 ++++++-
>  monitor.c               |  9 ++++++---
>  numa.c                  | 18 +++++++++++++-----
>  4 files changed, 26 insertions(+), 9 deletions(-)
>=20
> diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
> index 39bc835..e5f5347 100644
> --- a/include/qemu/typedefs.h
> +++ b/include/qemu/typedefs.h
> @@ -100,6 +100,7 @@ typedef struct uWireSlave uWireSlave;
>  typedef struct VirtIODevice VirtIODevice;
>  typedef struct Visitor Visitor;
>  typedef struct node_info NodeInfo;
> +typedef struct numa_node_mem NumaNodeMem;

Please follow HACKING naming conventions - name the struct NumaNodeMem
in all places (just because node_info didn't follow the rules doesn't
mean your addition should break them).  Also, this file should stay sorte=
d.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--r9X0UaeeQd7H04eIQDBnUAxN1tsfa8mbM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmUNIoACgkQp6FrSiUn
Q2o5Ggf/ces7JIOv9yXn/unCyxUyNbujrmSRZezqaqPDnCH41l0edeBuJK/pGO8T
UOho8p2vbVvYa52pOQUC2Mr3+fHt4SbyWzbEsGhcYCsGcO8EbNrZ+93l+ytiZTym
59crU6nae2X5nbbtIJoasCeICvYWBRH05T2Gksf8//CykEIV26QqWe5akcqN69xO
SJcC2/WXJB6BignjtZpZltvEuEwiRSyonjP/fIw0xXzrG6goXcHA+UNhCCFMZnLh
LnE7gUfS7KyfCrSfAyowkQCGb8qWgs/xNR8Qml02viN8irVF7TvFUg+MmjQo7+2U
gdI/wy+7Sg8BycagSqrOlEikqDC2Xg==
=f3to
-----END PGP SIGNATURE-----

--r9X0UaeeQd7H04eIQDBnUAxN1tsfa8mbM--
