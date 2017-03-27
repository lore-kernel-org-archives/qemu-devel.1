Received: from eggs.gnu.org ([2001:4830:134:3::10]:48857)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1csYOz-0006vv-4x
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 13:25:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1csYOu-0007qY-S7
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 13:25:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:11551)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1csYOu-0007qJ-JH
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 13:25:52 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8E91864A64
	for <qemu-devel@nongnu.org>; Mon, 27 Mar 2017 17:25:51 +0000 (UTC)
References: <1490621195-2228-1-git-send-email-armbru@redhat.com>
	<1490621195-2228-12-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <9c819272-e41e-9571-606e-62c742fe3cfe@redhat.com>
Date: Mon, 27 Mar 2017 12:25:49 -0500
MIME-Version: 1.0
In-Reply-To: <1490621195-2228-12-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="ms8l6i3fhAGknnCPtmqGNdjtnXNK9QXkt"
Subject: Re: [Qemu-devel] [PATCH RFC v3 for-2.9 11/11] rbd: Fix bugs around
 -drive parameter "server"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: jdurgin@redhat.com, jcody@redhat.com, kwolf@redhat.com, mreitz@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ms8l6i3fhAGknnCPtmqGNdjtnXNK9QXkt
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: jdurgin@redhat.com, jcody@redhat.com, kwolf@redhat.com, mreitz@redhat.com
Message-ID: <9c819272-e41e-9571-606e-62c742fe3cfe@redhat.com>
Subject: Re: [PATCH RFC v3 for-2.9 11/11] rbd: Fix bugs around -drive
 parameter "server"
References: <1490621195-2228-1-git-send-email-armbru@redhat.com>
 <1490621195-2228-12-git-send-email-armbru@redhat.com>
In-Reply-To: <1490621195-2228-12-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/27/2017 08:26 AM, Markus Armbruster wrote:
> qemu_rbd_open() takes option parameters as a flattened QDict, with
> keys of the form server.%d.host, server.%d.port, where %d counts up
> from zero.
>=20
> qemu_rbd_array_opts() extracts these values as follows.  First, it
> calls qdict_array_entries() to find the list's length.  For each list
> element, it formats the list's key prefix (e.g. "server.0."), then
> creates a new QDict holding the options with that key prefix, then
> converts that to a QemuOpts, so it can finally get the member values
> from there.
>=20
> If there's one surefire way to make code using QDict more awkward,
> it's creating more of them and mixing in QemuOpts for good measure.
>=20
> The extraction of keys starting with server.%d into another QDict
> makes us ignore parameters like server.0.neither-host-nor-port
> silently.
>=20
> The conversion to QemuOpts abuses runtime_opts, as described a few
> commits ago.
>=20
> Rewrite to simply get the values straight from the options QDict.
>=20
> Fixes -drive not to crash when server.*.* are present, but
> server.*.host is absent.
>=20
> Fixes -drive to reject invalid server.*.*.
>=20
> Permits cleaning up runtime_opts.  Do that, and fix -drive to reject
> bogus parameters host and port instead of silently ignoring them.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  block/rbd.c | 127 +++++++++++++++-------------------------------------=
--------
>  1 file changed, 32 insertions(+), 95 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--ms8l6i3fhAGknnCPtmqGNdjtnXNK9QXkt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY2UsdAAoJEKeha0olJ0NqKOkH/jCSNEguHHeeuPPWADhD0Gg2
/zElyCyuN1kmJ4PrbBWLwDVVl2Gdx1fa2K4URqTequIYR279v7SksPwhzLNxxza2
Ai1CBShrAW7B0FnP2abuYN4DMCdqXMx2b70RwDNlzf8BVMsIAhuQ1mIacfwWGmtw
iwnjkO0YttxQQnlfUrltnsD7r1SbjWwzVPdq+v5p9eo2QrK1TFYAXmQBigAkd7B4
uQVjuN4Pif3JKs0jOilB4YGGXW566vDi2UxWXIp3PxtfihWgn/2QsKcY5+I/9fF6
4ho3mJfbyFDREx2j51f0FeHIoBNjAnEgqUunYWqu2GwpeHYMH+w+TQ5cM8IdZjA=
=zhqo
-----END PGP SIGNATURE-----

--ms8l6i3fhAGknnCPtmqGNdjtnXNK9QXkt--
