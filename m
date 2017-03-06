Received: from eggs.gnu.org ([2001:4830:134:3::10]:55087)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ckvQQ-0003hU-Mm
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 11:23:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ckvQP-0001bl-Iq
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 11:23:54 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41248)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ckvQP-0001bV-A8
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 11:23:53 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7E837C0016B1
	for <qemu-devel@nongnu.org>; Mon,  6 Mar 2017 16:23:53 +0000 (UTC)
References: <1488702958-24336-1-git-send-email-armbru@redhat.com>
	<1488702958-24336-4-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <cb0e29f7-149a-cde1-2569-68de0190e3b8@redhat.com>
Date: Mon, 6 Mar 2017 10:23:51 -0600
MIME-Version: 1.0
In-Reply-To: <1488702958-24336-4-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="eAPUpwwLGaSTwcgeS2VuiiumQn52CgWfh"
Subject: Re: [Qemu-devel] [PULL v2 03/27] qmp-test: New,
 covering basic QMP protocol
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--eAPUpwwLGaSTwcgeS2VuiiumQn52CgWfh
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Message-ID: <cb0e29f7-149a-cde1-2569-68de0190e3b8@redhat.com>
Subject: Re: [Qemu-devel] [PULL v2 03/27] qmp-test: New, covering basic QMP
 protocol
References: <1488702958-24336-1-git-send-email-armbru@redhat.com>
 <1488702958-24336-4-git-send-email-armbru@redhat.com>
In-Reply-To: <1488702958-24336-4-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/05/2017 02:35 AM, Markus Armbruster wrote:
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> Message-Id: <1488544368-30622-4-git-send-email-armbru@redhat.com>
> ---
>  MAINTAINERS            |   1 +
>  tests/Makefile.include |   5 +-
>  tests/libqtest.c       |  17 ++++--
>  tests/libqtest.h       |   8 +++
>  tests/qmp-test.c       | 139 +++++++++++++++++++++++++++++++++++++++++=
++++++++
>  5 files changed, 164 insertions(+), 6 deletions(-)
>  create mode 100644 tests/qmp-test.c

Just now noticing (so a followup patch is fine, no need to stall the
pull request), but this should probably tweak .gitignore for the new
test (or maybe we should revive Marc-Andr=C3=A9's proposal to generate
=2Egitignore at make time).


--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--eAPUpwwLGaSTwcgeS2VuiiumQn52CgWfh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYvY0XAAoJEKeha0olJ0Nqy5QIAIart+W63n4skQZeGVv+HTec
4Vl/JHdWO9lR/VsN32975wiAlOOQeXVt+tJFaIvt4RQKHyUcIJLysO/Z0lZOzfam
U65IOgMRGAeyX0MknLRpxxFDF544ylfMUk6qmJW2QFtm+z3TJBiOl7GGXwwcnri8
dAvTjgQs2vfOUf7X3CPP9FqWsgHJVsJ/l6kJsL+1s0wf89+XtF9YjZmaxSlqPSvV
NhErrtqb9G20soIDY7qRGbcmW/Ce/EqqEsVzkrOM2Y+0XSJmQpSfDjbFXMs9WEhW
tjCNrGJ4jyUWY5pIyZf6HppdxiPyujo4mD4y//amAD9bkAgZ+6Mj46h2pAdzrKU=
=6Jf5
-----END PGP SIGNATURE-----

--eAPUpwwLGaSTwcgeS2VuiiumQn52CgWfh--
