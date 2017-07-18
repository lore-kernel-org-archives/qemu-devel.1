Received: from eggs.gnu.org ([2001:4830:134:3::10]:58024)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dXTQf-0006Q5-Lo
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 10:24:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dXTQe-0004Xr-Oa
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 10:24:49 -0400
References: <1500385286-21142-1-git-send-email-armbru@redhat.com>
	<1500385286-21142-2-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <6229304c-ee67-3678-2ea3-eddf3f42f3cb@redhat.com>
Date: Tue, 18 Jul 2017 09:24:40 -0500
MIME-Version: 1.0
In-Reply-To: <1500385286-21142-2-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="pxXBC9Vh8AsLA5oVsnEKvQafpMeOb26eD"
Subject: Re: [Qemu-devel] [PATCH for-2.10 01/10] qapi: Separate type QNull
 from QObject
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: berrange@redhat.com, kwolf@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org, quintela@redhat.com, dgilbert@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--pxXBC9Vh8AsLA5oVsnEKvQafpMeOb26eD
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: berrange@redhat.com, kwolf@redhat.com, mreitz@redhat.com,
 qemu-block@nongnu.org, quintela@redhat.com, dgilbert@redhat.com
Message-ID: <6229304c-ee67-3678-2ea3-eddf3f42f3cb@redhat.com>
Subject: Re: [PATCH for-2.10 01/10] qapi: Separate type QNull from QObject
References: <1500385286-21142-1-git-send-email-armbru@redhat.com>
 <1500385286-21142-2-git-send-email-armbru@redhat.com>
In-Reply-To: <1500385286-21142-2-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/18/2017 08:41 AM, Markus Armbruster wrote:
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  include/qapi/qmp/qobject.h    | 10 +++++++---
>  qapi/qobject-output-visitor.c |  2 +-
>  qobject/json-parser.c         |  2 +-
>  qobject/qnull.c               |  8 +++++---
>  target/i386/cpu.c             |  4 ++--
>  tests/check-qjson.c           |  6 +++---
>  tests/check-qnull.c           | 18 +++++++++---------
>  7 files changed, 28 insertions(+), 22 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--pxXBC9Vh8AsLA5oVsnEKvQafpMeOb26eD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlluGigACgkQp6FrSiUn
Q2rHTgf/T9Q33io+EAoRIbIhtZu/kiW6TRkKWwZ1uIBo/KTWKaUWcVcxu1phEMf4
NR7cSZvipv4KBgJ6nbfhmnIsf9I9yptb605f7F+NTxlV7Ey/6BzJJkUch8QDB71C
g4ZZV63xDZc/9uLF+A31pAvewkolbVMQtMtaPk6OVYjAMSWyMzXwxtr2+plcuiCe
UNH9z7UoNjsItlaZZCsm836UQi+LsGDVXWQSI6BAqGSUhzVNg9abXvlrNg0a1GZ1
mzkBxVEYbaAVCLt6cBxR6qhZE6airHVO3T6EhzPXaRcdMDvNiaLYW5uK8LKopixP
s9XUA+sfdrSPt9AtpB1oCShZWuXjxA==
=jtan
-----END PGP SIGNATURE-----

--pxXBC9Vh8AsLA5oVsnEKvQafpMeOb26eD--
