Received: from eggs.gnu.org ([209.51.188.92]:50238)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gpCDX-0005dj-Vk
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 08:17:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gpCDX-00032q-9s
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 08:17:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58225)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gpCDX-00032V-17
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 08:17:19 -0500
References: <20190131130850.6850-1-yuval.shaia@oracle.com>
	<20190131130850.6850-8-yuval.shaia@oracle.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <42ba3330-f7ca-b5c5-126f-8dd97e343d51@redhat.com>
Date: Thu, 31 Jan 2019 07:17:16 -0600
MIME-Version: 1.0
In-Reply-To: <20190131130850.6850-8-yuval.shaia@oracle.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="FURdvNgQtm1UhvTKDjnjVopSIitPYH07M"
Subject: Re: [Qemu-devel] [PATCH 07/10] monitor: Expose pvrdma device
 statistics counters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yuval Shaia <yuval.shaia@oracle.com>, dgilbert@redhat.com, marcel.apfelbaum@gmail.com, armbru@redhat.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--FURdvNgQtm1UhvTKDjnjVopSIitPYH07M
From: Eric Blake <eblake@redhat.com>
To: Yuval Shaia <yuval.shaia@oracle.com>, dgilbert@redhat.com,
 marcel.apfelbaum@gmail.com, armbru@redhat.com, qemu-devel@nongnu.org
Message-ID: <42ba3330-f7ca-b5c5-126f-8dd97e343d51@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 07/10] monitor: Expose pvrdma device
 statistics counters
References: <20190131130850.6850-1-yuval.shaia@oracle.com>
 <20190131130850.6850-8-yuval.shaia@oracle.com>
In-Reply-To: <20190131130850.6850-8-yuval.shaia@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/31/19 7:08 AM, Yuval Shaia wrote:
> Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
> ---
>  hmp-commands-info.hx | 14 ++++++++++++++
>  monitor.c            |  6 ++++++
>  2 files changed, 20 insertions(+)

Commit message should state WHY this is being added as an HMP-only
command, and does not have a QMP counterpart.  It may be okay if the
interface is only designed to be useful to developers, but having that
justification in the git log is important.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--FURdvNgQtm1UhvTKDjnjVopSIitPYH07M
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlxS9VwACgkQp6FrSiUn
Q2rcIAgAh+8AqClTWrBNwnUABb3jY9wbiEpA+4aGzasxtWCnUTWbQv5RGPkjSjgb
QlANuuPtmNUwwFbESaSf23KxR2mUdBuBcsrvhMPQHWUHc1V4AbfPFhz7PXg1rfa3
aRWpnLGjmxeRUVefRUN6uet1ajXnZnqk6r7sUlYXLk+RxNy1Jrv4RuTKV4lWKAV7
HqeFM2msc7dKrMlcUPSbGKO9TASZ2vnTZDhXGBfH3QJJpsQuEDFR1G9xA1KkWQUI
6LgTR1l9JFM1Hv1AOGyl7CQlEN8f83BHBTWpVlMlhnFj9roMpDvDHrXsfM1+b9Xu
tuBS7J2Ke/g6+a3uS37aqEZrdlERgg==
=7ZH1
-----END PGP SIGNATURE-----

--FURdvNgQtm1UhvTKDjnjVopSIitPYH07M--
