Received: from eggs.gnu.org ([209.51.188.92]:40914)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gm0zx-0008QO-Oh
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 13:42:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gm0zu-0001xV-L8
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 13:42:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:5466)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gm0zu-0001dh-2z
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 13:42:06 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A8E672CD7ED
	for <qemu-devel@nongnu.org>; Tue, 22 Jan 2019 17:23:56 +0000 (UTC)
References: <20190122164940.29244-1-berrange@redhat.com>
	<20190122164940.29244-2-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <bd4498b5-41af-19f6-59d1-040116d4a9a2@redhat.com>
Date: Tue, 22 Jan 2019 11:23:46 -0600
MIME-Version: 1.0
In-Reply-To: <20190122164940.29244-2-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="qIQmTCwDzKcBy4l01mKTzZJJnwkbQcEYs"
Subject: Re: [Qemu-devel] [PATCH v3 1/4] display: ensure qxl log_buf is a
 nul terminated string
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
--qIQmTCwDzKcBy4l01mKTzZJJnwkbQcEYs
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <bd4498b5-41af-19f6-59d1-040116d4a9a2@redhat.com>
Subject: Re: [PATCH v3 1/4] display: ensure qxl log_buf is a nul terminated
 string
References: <20190122164940.29244-1-berrange@redhat.com>
 <20190122164940.29244-2-berrange@redhat.com>
In-Reply-To: <20190122164940.29244-2-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/22/19 10:49 AM, Daniel P. Berrang=C3=A9 wrote:
> The QXL_IO_LOG command allows the guest to send log messages to the hos=
t
> via a buffer in the QXLRam struct. QEMU prints these to the console if
> the qxl 'guestdebug' option is set to non-zero. It will also feed them
> to the trace subsystem if any backends are built-in.
>=20
> In both cases the log_buf data will get treated as being as a nul
> terminated string, by the printf '%s' format specifier and / or other
> code reading the buffer.
>=20
> QEMU does nothing to guarantee that the log_buf really is nul terminate=
d,
> so there is potential for out of bounds array access.
>=20
> This would affect any QEMU which has the log, syslog or ftrace trace
> backends built into QEMU. It can only be triggered if the 'qxl_io_log'
> trace event is enabled, however, so they are not vulnerable without
> specific administrative action to enable this.
>=20
> It would also affect QEMU if the 'guestdebug' parameter is set to a
> non-zero value, which again is not the default and requires explicit
> admin opt-in.
>=20
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  hw/display/qxl.c        | 14 ++++++++++----
>  hw/display/trace-events |  2 +-
>  2 files changed, 11 insertions(+), 5 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--qIQmTCwDzKcBy4l01mKTzZJJnwkbQcEYs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlxHUaMACgkQp6FrSiUn
Q2oIgQgAnrncdhs4eDc65iie9/FDiqeoqcYXhM6jK+YJjiN2eZ0nrat3ZJ4HoWFW
xXvHZNphQD28kTAtZJIPr5ltAyOjkq62QA/IKaWDaBEKWqP68PhOa+HDiN3ywy1W
tkl6w3IE49pT860oaVcf+8PI7rm/mLpvWXaGx7L1zSWZFD45OSOUA0s1+xiPXClQ
nuufB1DsyA0PoPJXeClqc1SrPhOMU2tE0iZpOmxZbawWz10MePwcwziA41o6L6R3
zBTiyX/4xOtt+/OQgZF/ptr3X9X9DMZO5qzbo2TYluLQJw3HVRngbPfaWcpSoojx
IrzlvK03w5t79JS6o9mxdox3Crr6Og==
=7B3G
-----END PGP SIGNATURE-----

--qIQmTCwDzKcBy4l01mKTzZJJnwkbQcEYs--
