Received: from eggs.gnu.org ([2001:4830:134:3::10]:58343)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eXVfp-0003Ut-K6
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 12:20:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eXVfm-0000Yk-FH
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 12:20:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47058)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1eXVfm-0000XI-3d
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 12:20:50 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 534028BD20
	for <qemu-devel@nongnu.org>; Fri,  5 Jan 2018 17:20:49 +0000 (UTC)
References: <20180105170138.23357-1-dgilbert@redhat.com>
	<20180105170138.23357-2-dgilbert@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <8f12d622-5d32-3317-aa8f-5a36916157e5@redhat.com>
Date: Fri, 5 Jan 2018 11:20:47 -0600
MIME-Version: 1.0
In-Reply-To: <20180105170138.23357-2-dgilbert@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="KwmMXLnBP11NunFFM0lLYZgjLafAhAQnM"
Subject: Re: [Qemu-devel] [PATCH 1/2] find_ram_offset: Add comments and
 tracing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>, qemu-devel@nongnu.org, pbonzini@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--KwmMXLnBP11NunFFM0lLYZgjLafAhAQnM
From: Eric Blake <eblake@redhat.com>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>,
 qemu-devel@nongnu.org, pbonzini@redhat.com
Message-ID: <8f12d622-5d32-3317-aa8f-5a36916157e5@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/2] find_ram_offset: Add comments and
 tracing
References: <20180105170138.23357-1-dgilbert@redhat.com>
 <20180105170138.23357-2-dgilbert@redhat.com>
In-Reply-To: <20180105170138.23357-2-dgilbert@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/05/2018 11:01 AM, Dr. David Alan Gilbert (git) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>=20
> Add some comments so I can understand the various nested loops.
> Add some tracing so I can see what they're doing.
>=20
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>  exec.c       | 17 ++++++++++++++++-
>  trace-events |  3 +++
>  2 files changed, 19 insertions(+), 1 deletion(-)
>=20

> +
> +        /* If it fits remember our place and remember the size
> +         * of gap, but keep going so that we might find a smaller
> +         * gap to fill so avoiding fragmentation.

s/so avoiding/in order to avoid/

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--KwmMXLnBP11NunFFM0lLYZgjLafAhAQnM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpPs+8ACgkQp6FrSiUn
Q2okhwgAhBNWdRryhHBZnyHMX4zn1LDPw62sC6l0i1al4qCrnYAow31RtcGwjAw1
imgPmZb54e7K4p+s8T23lZowDo6nu6D0CsYaO4k0ieL9yVsCGt7li849iNxjaaKD
f/8teHmxFhK8Nm5VR9xgOs70N6EtNkwHqFUMUlg1kv3FNgNP4XygrzJx0o25vBAt
VvZEpogrHnrrWkPdXe5ZwFXGw7xygDl8NkIkcAfP3KjEQI96C7otakCPGkZjTV5M
6kC7NPIvVaocZTxx2/amsdhlyYbBC/2CQv3GCWotpD+aMKFeSg72SGvp7fAjaK3I
0d7BBFUoM50qhKxz41AFeqfoLsCAEw==
=v4Al
-----END PGP SIGNATURE-----

--KwmMXLnBP11NunFFM0lLYZgjLafAhAQnM--
