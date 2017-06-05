Received: from eggs.gnu.org ([2001:4830:134:3::10]:39337)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dHr7k-00053U-MX
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 08:28:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dHr7g-0006Kx-55
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 08:28:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46210)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dHr7f-0006KA-SO
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 08:28:40 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BDF0280460
	for <qemu-devel@nongnu.org>; Mon,  5 Jun 2017 12:28:38 +0000 (UTC)
References: <20170605104216.22429-1-stefanha@redhat.com>
	<20170605104216.22429-3-stefanha@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <935cf4db-d918-04e5-fed7-bd0f4e17ffc1@redhat.com>
Date: Mon, 5 Jun 2017 07:28:35 -0500
MIME-Version: 1.0
In-Reply-To: <20170605104216.22429-3-stefanha@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="falB6wWJeRfWTooaNQj18dvKNFkd6vdBA"
Subject: Re: [Qemu-devel] [PATCH 2/2] monitor: resurrect handle_qmp_command
 trace event
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--falB6wWJeRfWTooaNQj18dvKNFkd6vdBA
From: Eric Blake <eblake@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org
Message-ID: <935cf4db-d918-04e5-fed7-bd0f4e17ffc1@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/2] monitor: resurrect handle_qmp_command
 trace event
References: <20170605104216.22429-1-stefanha@redhat.com>
 <20170605104216.22429-3-stefanha@redhat.com>
In-Reply-To: <20170605104216.22429-3-stefanha@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06/05/2017 05:42 AM, Stefan Hajnoczi wrote:
> Commit 104fc3027960dd2aa9d310936a6cb201c60e1088 ("qmp: Drop duplicated
> QMP command object checks") removed the call to
> trace_handle_qmp_command() while eliminating code duplication.
>=20
> This patch brings the trace event back so QEMU-internal trace events ca=
n
> be correlated with the QMP commands that caused them.
>=20
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  monitor.c    | 5 +++++
>  trace-events | 1 +
>  2 files changed, 6 insertions(+)
>=20

> @@ -3823,6 +3824,10 @@ static void handle_qmp_command(JSONMessageParser=
 *parser, GQueue *tokens)
>          qdict_del(qdict, "id");
>      } /* else will fail qmp_dispatch() */
> =20
> +    req_json =3D qobject_to_json(req);
> +    trace_handle_qmp_command(mon, qstring_get_str(req_json));
> +    qobject_decref(QOBJECT(req_json));

I should really revive my patches that create a JSON output visitor, as
it would use less memory allocation in use cases like this.  But that's
not your problem.

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--falB6wWJeRfWTooaNQj18dvKNFkd6vdBA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZNU5zAAoJEKeha0olJ0NqZZQH/2rfOhhBiDy1HSBWvfT14Th5
uHdmdSdXRGOuJeNRLfrSy1iJX9LwU3/8o9I2JMQeWbk17vsjHo1BHGJLRfbhMSYk
WuQXhyy00lvZR91p14qNSLNfkRhyNt+fjdEv5Y4SH0yJ9hoqyFyfYKa2Vk+CXV3e
32ivuerYSbRqzqTNBeza525rRfvKDu2cTmGCdT3utV5jlZSx1boVwKPnmHi9QR4U
4N5DihTGv3e7+1lKAfVNogl9y5SoZ/VcG4eyUyQJVIYuecgkeyAeFGu4V+JEjuhp
DTGmtoaOi3148F6uNeqCAIT/WBKaW9g7GF/VJc2wWwQhKGIsfbNLCNTMbT6huSI=
=FLoN
-----END PGP SIGNATURE-----

--falB6wWJeRfWTooaNQj18dvKNFkd6vdBA--
