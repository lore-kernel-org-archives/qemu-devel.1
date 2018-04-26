Received: from eggs.gnu.org ([2001:4830:134:3::10]:45731)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fBl3Q-000704-Ns
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 13:51:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fBl3O-0006d2-5m
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 13:51:36 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50300 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fBl3N-0006cW-V9
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 13:51:34 -0400
References: <1524761612-5307-1-git-send-email-ian.jackson@eu.citrix.com>
	<1524761612-5307-8-git-send-email-ian.jackson@eu.citrix.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <daf2149b-103f-b6bd-75cf-31ce0e946873@redhat.com>
Date: Thu, 26 Apr 2018 12:51:24 -0500
MIME-Version: 1.0
In-Reply-To: <1524761612-5307-8-git-send-email-ian.jackson@eu.citrix.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="UTT7izJ56FXa2htTpiG7uYLTUYZXoRVEO"
Subject: Re: [Qemu-devel] [RFC PATCH 7/7] error reporting: HACKING: Say to
 use error_report_errno
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ian Jackson <ian.jackson@eu.citrix.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, "=?UTF-8?Q?Daniel_P_._Berrang=c3=a9?=" <berrange@redhat.com>, Alistair Francis <alistair.francis@xilinx.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--UTT7izJ56FXa2htTpiG7uYLTUYZXoRVEO
From: Eric Blake <eblake@redhat.com>
To: Ian Jackson <ian.jackson@eu.citrix.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 =?UTF-8?Q?Daniel_P_._Berrang=c3=a9?= <berrange@redhat.com>,
 Alistair Francis <alistair.francis@xilinx.com>
Message-ID: <daf2149b-103f-b6bd-75cf-31ce0e946873@redhat.com>
Subject: Re: [RFC PATCH 7/7] error reporting: HACKING: Say to use
 error_report_errno
References: <1524761612-5307-1-git-send-email-ian.jackson@eu.citrix.com>
 <1524761612-5307-8-git-send-email-ian.jackson@eu.citrix.com>
In-Reply-To: <1524761612-5307-8-git-send-email-ian.jackson@eu.citrix.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/26/2018 11:53 AM, Ian Jackson wrote:
> Signed-off-by: Ian Jackson <Ian.Jackson@eu.citrix.com>
> ---
>  HACKING | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/HACKING b/HACKING
> index 4125c97..95563a3 100644
> --- a/HACKING
> +++ b/HACKING
> @@ -189,6 +189,7 @@ error_report() or error_vreport() from error-report=
=2Eh.  This ensures the
>  error is reported in the right place (current monitor or stderr), and =
in
>  a uniform format.
> =20
> +Use error_report_errno rather than open-coding calls to strerror().
>  Use error_printf() & friends to print additional information.

Our style is to write this as error_report_errno().  Or even copy the
approach used in the next line, stating 'error_report_errno() & friends'.=


--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--UTT7izJ56FXa2htTpiG7uYLTUYZXoRVEO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlriEZwACgkQp6FrSiUn
Q2qbWAf+NAxN47C5HCeagFrOP1xvS8VCMjakJxo5V4yJwhamxaGw4HE7Ozm9Giz4
+PGXNj2ooiFnq1FNVzYeBTm/ecSUcVtAGLiEcWv+HlKIrU/bGlFeWz+I0lxhlCRi
RIbEyYW9pY2YM5inavLwIapVCuUnsdg7m4KBYlbixYsYma/p1I2C4sU1/VbPSTL8
uMAn0yVJo0X8YqyihbnkK6NrZQbGmp1L2T+L5WGE3yVe3lPZinuSAK1w+0Y6yikX
a7xu+HzYS0tklUf1vYja8clUbpHLSPxteNy4jVw46mvXy0EVXEtm2X4jbaCHTqdN
lIDHupIxPkf0BIcB/I8GYpB3KLH39Q==
=fab7
-----END PGP SIGNATURE-----

--UTT7izJ56FXa2htTpiG7uYLTUYZXoRVEO--
