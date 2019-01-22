Received: from eggs.gnu.org ([209.51.188.92]:41941)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gm10x-0000s7-M9
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 13:43:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gm10p-0002Wf-Ft
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 13:43:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55112)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gm10o-0001ee-AP
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 13:43:02 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 98DD9C7CA3
	for <qemu-devel@nongnu.org>; Tue, 22 Jan 2019 17:26:03 +0000 (UTC)
References: <20190122164940.29244-1-berrange@redhat.com>
	<20190122164940.29244-4-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <da007012-1ba8-878c-08dd-f682e579effc@redhat.com>
Date: Tue, 22 Jan 2019 11:25:55 -0600
MIME-Version: 1.0
In-Reply-To: <20190122164940.29244-4-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="WHlUin2XXkVhmsgCjmsEPPgI5aGVldDnA"
Subject: Re: [Qemu-devel] [PATCH v3 3/4] trace: forbid use of %m in trace
 event format strings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--WHlUin2XXkVhmsgCjmsEPPgI5aGVldDnA
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <da007012-1ba8-878c-08dd-f682e579effc@redhat.com>
Subject: Re: [PATCH v3 3/4] trace: forbid use of %m in trace event format
 strings
References: <20190122164940.29244-1-berrange@redhat.com>
 <20190122164940.29244-4-berrange@redhat.com>
In-Reply-To: <20190122164940.29244-4-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/22/19 10:49 AM, Daniel P. Berrang=C3=A9 wrote:
> The '%m' format specifier instructs glibc's printf() implementation to
> insert the contents of strerror(errno). Since this is a glibc extension=

> it should generally be avoided in QEMU due to need for portability to a=

> variety of platforms.

Up to you if you want to mention that syslog() portably supports %m, but
not all trace backends use syslog().

>=20
> Even though vfio is Linux-only code that could otherwise use "%m", it
> must still be avoided in trace-events files because several of the
> backends do not use the format string and so this error information is
> invisible to them.
>=20
> The errno string value should be given as an explicit trace argument
> instead, making it accessible to all backends. This also allows it to
> work correctly with future patches that use the format string with
> systemtap's simple printf code.
>=20
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  hw/vfio/pci.c                 | 2 +-
>  hw/vfio/trace-events          | 2 +-
>  scripts/tracetool/__init__.py | 4 ++++
>  3 files changed, 6 insertions(+), 2 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--WHlUin2XXkVhmsgCjmsEPPgI5aGVldDnA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlxHUiMACgkQp6FrSiUn
Q2piswgAjOO728DXZKgCJxUFeug0EfFO7m7r6sEgvrST7v7/GRaz7iBcS3NjAhuq
YHw3duNwgqp9TO0qElPts3ef74VzeVGd91KNLPrIt2SNXUuXPLOnp415ASFawifg
vC5U/Q8fU1aWH+XpOjjODeR1XgiC84cFJPNglS5Ut1zv/1LY0TmqSFXzgVhCoc/p
yyHuK2a3eE6pylJT+3dUzjqYmVv/vD00u3q781VFfMk6GZCSclbwJTy6PztqtHnx
B11rjJmL6IQepGyjrc+SLrJTCo7lSRH/OYzNntTDQ0/CqyGAP93GyUxuZUKtIsmp
12hZcl5LePKsKaRm1CQQ/MMv4jFubQ==
=GD6C
-----END PGP SIGNATURE-----

--WHlUin2XXkVhmsgCjmsEPPgI5aGVldDnA--
