Received: from eggs.gnu.org ([2001:4830:134:3::10]:42080)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dz2kd-0007Sp-JK
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 11:35:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dz2kZ-0005O1-IN
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 11:35:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:63155)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dz2kZ-0005N9-3V
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 11:35:19 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2369585550
	for <qemu-devel@nongnu.org>; Mon,  2 Oct 2017 15:35:18 +0000 (UTC)
References: <20171002140307.5292-1-armbru@redhat.com>
	<20171002140307.5292-9-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <56dbe987-f56b-51b9-844d-45c674bd92b4@redhat.com>
Date: Mon, 2 Oct 2017 10:35:16 -0500
MIME-Version: 1.0
In-Reply-To: <20171002140307.5292-9-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="PxxqqkGHn8FwEBwameJSV28w9P0397p4c"
Subject: Re: [Qemu-devel] [PATCH 8/8] qemu-options: Belatedly document
 --watchdog-action inject-nmi
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
List-ID: <qemu-devel.nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--PxxqqkGHn8FwEBwameJSV28w9P0397p4c
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Message-ID: <56dbe987-f56b-51b9-844d-45c674bd92b4@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 8/8] qemu-options: Belatedly document
 --watchdog-action inject-nmi
References: <20171002140307.5292-1-armbru@redhat.com>
 <20171002140307.5292-9-armbru@redhat.com>
In-Reply-To: <20171002140307.5292-9-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/02/2017 09:03 AM, Markus Armbruster wrote:
> Missed in commit 795dc6e46d, v2.4.0.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  qemu-options.hx | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

>=20
> diff --git a/qemu-options.hx b/qemu-options.hx
> index b792c65149..32afc11296 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -3596,7 +3596,7 @@ A virtual watchdog for s390x backed by the diagno=
se 288 hypercall
>  ETEXI
> =20
>  DEF("watchdog-action", HAS_ARG, QEMU_OPTION_watchdog_action, \
> -    "-watchdog-action reset|shutdown|poweroff|pause|debug|none\n" \
> +    "-watchdog-action reset|shutdown|poweroff|inject-nmi|pause|debug|n=
one\n" \
>      "                action when watchdog fires [default=3Dreset]\n",
>      QEMU_ARCH_ALL)
>  STEXI
> @@ -3610,6 +3610,7 @@ The default is
>  Other possible actions are:
>  @code{shutdown} (attempt to gracefully shutdown the guest),
>  @code{poweroff} (forcefully poweroff the guest),
> +@code{inject-nmi} (inject a NMI into the guest),
>  @code{pause} (pause the guest),
>  @code{debug} (print a debug message and continue), or
>  @code{none} (do nothing).
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--PxxqqkGHn8FwEBwameJSV28w9P0397p4c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnSXLUACgkQp6FrSiUn
Q2piWAf9Gri2VyglHAlwHi+LoN0XAIoWfqOHA9fEZC2D9bm9q3V7DO47mk3EeFsj
FlLkjTzeWDsmy7zAHhrtr9ITBuihb8Yi4kfBj7XgqJYnCdyHrGwypeAmswSAAP/G
jjXE6UH9zFt+MUzLyI4v60WHOi6smPEKSFmZSpJzx9KAcvzWOrIkSCGu9MPkG8mr
asHHR/C0cF05Xg23pd0zoZBaBF00Clhe1D4nwrAmHrfSVGRUPRTnNnpOJgYma/WA
7Ehw6otLp7J6XDDMSokDW4VOwdwf1ABwju8EVS6MIChvL72OUmQGn71A4cIHBQJf
CikO332HaDnJ2Ly3RvWgtplREFzc8A==
=pYPU
-----END PGP SIGNATURE-----

--PxxqqkGHn8FwEBwameJSV28w9P0397p4c--
