Received: from eggs.gnu.org ([2001:4830:134:3::10]:33783)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cPA8N-00039H-AX
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 10:39:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cPA8M-0007KD-Dd
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 10:39:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43634)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cPA8M-0007Jk-4d
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 10:39:18 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2F33BF5DDB
	for <qemu-devel@nongnu.org>; Thu,  5 Jan 2017 15:39:18 +0000 (UTC)
References: <20170105135957.12003-1-marcandre.lureau@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <f6bf01a0-3890-5155-7581-633673824027@redhat.com>
Date: Thu, 5 Jan 2017 09:39:15 -0600
MIME-Version: 1.0
In-Reply-To: <20170105135957.12003-1-marcandre.lureau@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="SNmJfRiev8X5vfaGmIoGNphANTcbb8RQP"
Subject: Re: [Qemu-devel] [PATCH] error: report hints on stderr when no
 monitor
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: armbru@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--SNmJfRiev8X5vfaGmIoGNphANTcbb8RQP
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: armbru@redhat.com
Message-ID: <f6bf01a0-3890-5155-7581-633673824027@redhat.com>
Subject: Re: [PATCH] error: report hints on stderr when no monitor
References: <20170105135957.12003-1-marcandre.lureau@redhat.com>
In-Reply-To: <20170105135957.12003-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/05/2017 07:59 AM, Marc-Andr=C3=A9 Lureau wrote:
> Report the error hint when running from the command line and reaching a=
n
> error, ex:
>=20
> $ qemu-system-x86_64 -m 1Z
> qemu-system-x86_64: -m 1Z: Parameter 'size' expects a size
> You may use k, M, G or T suffixes for kilobytes, megabytes, gigabytes a=
nd terabytes.

[unrelated, but this reminds me: qemu-io allows '1m' and '1M' as
synonyms, but our command line parser is picky and requires the spelling
'1M'.  I wouldn't mind if we unified those two parsers, and make size
parsing case-insensitive everywhere]

>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  monitor.c | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Eric Blake <eblake@redhat.com>

>=20
> diff --git a/monitor.c b/monitor.c
> index a82f547488..e5cc11b5a5 100644
> --- a/monitor.c
> +++ b/monitor.c
> @@ -3973,6 +3973,8 @@ void error_vprintf_unless_qmp(const char *fmt, va=
_list ap)
>  {
>      if (cur_mon && !monitor_cur_is_qmp()) {
>          monitor_vprintf(cur_mon, fmt, ap);
> +    } else if (!cur_mon) {
> +        vfprintf(stderr, fmt, ap);
>      }
>  }
> =20
>=20

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--SNmJfRiev8X5vfaGmIoGNphANTcbb8RQP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYbmijAAoJEKeha0olJ0NqDcMH/R6twMV8ISzuF+rA7E/1guvu
Og16hsXig9QnmPsR8/AOGORWb4FtPjq+i+dBlw7camsYOIPDptzT4UeDxzqfHPac
sqel+HB8Amw9l3HaxyocUA6nTRKNgLWWTvx8MKDZXkVK61JTf8Iwos/Un/OyIpwc
sj7hsObh2E3d4j2JUIXIWLRG4ws3Eki/d0JYMegOqJyYLIwkTKFybmQ14B/d3Ec/
g1iB+XkVwUtXUlLU//uUC/bD04HK0Y0zuZtELnTH/NOI5SFeOtNu51Et94vHrRCJ
4GQaH4kCRF3bi0HLq2auctqMA1PNt0DyttsLxpp4mM+pO6aFpk/XjCfrl8YXwJ0=
=8xxL
-----END PGP SIGNATURE-----

--SNmJfRiev8X5vfaGmIoGNphANTcbb8RQP--
