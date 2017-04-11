Received: from eggs.gnu.org ([2001:4830:134:3::10]:51112)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cxvhH-000215-Af
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 09:19:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cxvhB-0007HB-Cq
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 09:19:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57498)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cxvhB-0007Gt-40
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 09:18:57 -0400
References: <1491900566-32222-1-git-send-email-he.chen@linux.intel.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <173a855f-1ca7-e680-a39c-c5e6bce310be@redhat.com>
Date: Tue, 11 Apr 2017 08:18:49 -0500
MIME-Version: 1.0
In-Reply-To: <1491900566-32222-1-git-send-email-he.chen@linux.intel.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="08E5pJRKDqv5EF5BhBLpma7WGNhgbGMTq"
Subject: Re: [Qemu-devel] [PATCH v6] Allow setting NUMA distance for
 different NUMA nodes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: He Chen <he.chen@linux.intel.com>, qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>, Andrew Jones <drjones@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--08E5pJRKDqv5EF5BhBLpma7WGNhgbGMTq
From: Eric Blake <eblake@redhat.com>
To: He Chen <he.chen@linux.intel.com>, qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Andrew Jones <drjones@redhat.com>
Message-ID: <173a855f-1ca7-e680-a39c-c5e6bce310be@redhat.com>
Subject: Re: [PATCH v6] Allow setting NUMA distance for different NUMA nodes
References: <1491900566-32222-1-git-send-email-he.chen@linux.intel.com>
In-Reply-To: <1491900566-32222-1-git-send-email-he.chen@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/11/2017 03:49 AM, He Chen wrote:
> This patch is going to add SLIT table support in QEMU, and provides
> additional option `dist` for command `-numa` to allow user set vNUMA
> distance by QEMU command.
>=20
> With this patch, when a user wants to create a guest that contains
> several vNUMA nodes and also wants to set distance among those nodes,
> the QEMU command would like:
>=20
> ```
> -numa node,nodeid=3D0,cpus=3D0 \
> -numa node,nodeid=3D1,cpus=3D1 \
> -numa node,nodeid=3D2,cpus=3D2 \
> -numa node,nodeid=3D3,cpus=3D3 \
> -numa dist,src=3D0,dst=3D1,val=3D21 \
> -numa dist,src=3D0,dst=3D2,val=3D31 \
> -numa dist,src=3D0,dst=3D3,val=3D41 \
> -numa dist,src=3D1,dst=3D2,val=3D21 \
> -numa dist,src=3D1,dst=3D3,val=3D31 \
> -numa dist,src=3D2,dst=3D3,val=3D21 \
> ```
>=20
> Signed-off-by: He Chen <he.chen@linux.intel.com>
> ---

Here is where you should mention what changed since v5, to help focus
the attention of reviewers that have read earlier versions.


> +++ b/qapi-schema.json

>  ##
> +# @NumaDistOptions:
> +#
> +# Set the distance between 2 NUMA nodes.
> +#
> +# @src: source NUMA node.
> +#
> +# @dst: destination NUMA node.
> +#
> +# @val: NUMA distance from source node to destination node.
> +#       When a node is unreachable from another node, set the distance=

> +#       between them to 255.

Still no mention that distances less than 10 are invalid, or that a node
to itself defaults to 10 and can't be changed, or that other distances
default to 20.  But that starts to get complex enough, and you cover it
elsewhere, so I'm okay with what you have here.

Interface looks sane, but I'll leave others to do the code review.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--08E5pJRKDqv5EF5BhBLpma7WGNhgbGMTq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY7Ne5AAoJEKeha0olJ0NqEjYIAILBOmIMeGockNRjufe0wi7Y
yqU0qIk/J+Ii28TuCMbJ2Z37kg+dUZZG5FvL61GDjwVAUB2tGyEHC5OTwWAiEVTJ
8ubK2K8VDWVXXlk/QViyZzXdzIYGe4IW6vqJpQqwMAC7avkfNmG3W5nxLR94URxL
+tkhFBcRvPW6pDPfRPZ9el8uGFai76BW+vSR8G9iFX88rTtWaaMrdC7OopPneXaG
aXyqnoX/kDtbk+7JqwebIY8MpnPptEQy0NXorJ3ie7NsAxyU2Q7ee2f1gfIfotqG
+29eJxYeNBDfAUed6vzlahkXwRDJqN/yBcXB8Rn/td9Dno7PRWVFgVAXrbv8lLs=
=AnLt
-----END PGP SIGNATURE-----

--08E5pJRKDqv5EF5BhBLpma7WGNhgbGMTq--
