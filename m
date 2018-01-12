Received: from eggs.gnu.org ([2001:4830:134:3::10]:49740)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ea2PK-0008LJ-8b
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 11:42:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ea2PF-0003Fo-NR
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 11:42:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51084)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ea2PF-0003FX-H4
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 11:42:13 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6541E629C3
	for <qemu-devel@nongnu.org>; Fri, 12 Jan 2018 16:42:12 +0000 (UTC)
References: <1515755504-21341-2-git-send-email-pbonzini@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <3f2a6cb0-f683-7dcb-44aa-f852e3a922fb@redhat.com>
Date: Fri, 12 Jan 2018 10:42:09 -0600
MIME-Version: 1.0
In-Reply-To: <1515755504-21341-2-git-send-email-pbonzini@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Z6PkR3dl5VXtY2GEvIgYrkNOIi5z5IZuG"
Subject: Re: [Qemu-devel] [PATCH] virtio/vhost: do not take address of
 packed members
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Z6PkR3dl5VXtY2GEvIgYrkNOIi5z5IZuG
From: Eric Blake <eblake@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>
Message-ID: <3f2a6cb0-f683-7dcb-44aa-f852e3a922fb@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] virtio/vhost: do not take address of packed
 members
References: <1515755504-21341-2-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1515755504-21341-2-git-send-email-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/12/2018 05:11 AM, Paolo Bonzini wrote:
> The address of a packed member is not packed, which may cause accesses
> to unaligned pointers.  Avoid this by reading the packed value before
> passing it to another function.
>=20
> Cc: Jason Wang <jasowang@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  hw/char/virtio-serial-bus.c | 6 +++---
>  hw/virtio/vhost-user.c      | 7 +++++--
>  2 files changed, 8 insertions(+), 5 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--Z6PkR3dl5VXtY2GEvIgYrkNOIi5z5IZuG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpY5WEACgkQp6FrSiUn
Q2pOAggAqwIDJEe/9UicVLqtusO/38NzbSXfL/NkFnGfzhFykKZNhGq0zHuCb+uh
i6l/cqLD0uUrOo3NpR5oG4IaX2OnDvW8MCwKFotRlvcr0e+eN1EP43HSUpfF5iHv
fj0e60mfH75kNedqfM5UGx0rNxx8SVo/XWCzBCCvZDFIyGJU//KaoTVjkAssDzkw
uY2HHvzHs2KLHq1qc31+SBhcclnjVvblvHk+H23S2KYfFxizu/Lrm/PaxYxoSeKU
byblekg6tve3c+qUA5tfgiaWVqa10ff6G1BjSdgyUahfbD4a6/qZuRehg5MIegIk
h3ewCO8jqrrp+CnzOG3hl8UilbnoQQ==
=kspK
-----END PGP SIGNATURE-----

--Z6PkR3dl5VXtY2GEvIgYrkNOIi5z5IZuG--
