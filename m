Received: from eggs.gnu.org ([2001:4830:134:3::10]:35177)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ebSfy-0001tr-LP
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 09:57:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ebSfv-0000wp-Iv
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 09:57:22 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34862)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ebSfv-0000wK-AF
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 09:57:19 -0500
References: <20180116134217.8725-1-berrange@redhat.com>
	<20180116134217.8725-13-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <f7e9f679-5d8b-263e-6e21-62dcbcc7984f@redhat.com>
Date: Tue, 16 Jan 2018 08:56:59 -0600
MIME-Version: 1.0
In-Reply-To: <20180116134217.8725-13-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="LrjmrmoHtgVdy1F9dkC6Y5MR3ijVuXyIk"
Subject: Re: [Qemu-devel] [PATCH v5 12/14] ui: update keycodemapdb to get
 py3 fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Fam Zheng <famz@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--LrjmrmoHtgVdy1F9dkC6Y5MR3ijVuXyIk
From: Eric Blake <eblake@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Fam Zheng <famz@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <f7e9f679-5d8b-263e-6e21-62dcbcc7984f@redhat.com>
Subject: Re: [PATCH v5 12/14] ui: update keycodemapdb to get py3 fixes
References: <20180116134217.8725-1-berrange@redhat.com>
 <20180116134217.8725-13-berrange@redhat.com>
In-Reply-To: <20180116134217.8725-13-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/16/2018 07:42 AM, Daniel P. Berrange wrote:
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  ui/keycodemapdb | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20

When posting submodule diffs, you can do:

$ git submodule summary ui/keycodemapdb HEAD^

to come up with what the change actually represents. (It's annoying that
git submodules aren't more user-friendly)

> diff --git a/ui/keycodemapdb b/ui/keycodemapdb
> index 05dad417e9..6b3d716e2b 160000
> --- a/ui/keycodemapdb
> +++ b/ui/keycodemapdb
> @@ -1 +1 @@
> -Subproject commit 05dad417e9d0b37ee1fba33056d91a6b734b3357
> +Subproject commit 6b3d716e2b6472eb7189d3220552280ef3d832ce
>=20

* ui/keycodemapdb 05dad41...6b3d716 (1):
  > Fix compat with py3 dict keys/values data types

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--LrjmrmoHtgVdy1F9dkC6Y5MR3ijVuXyIk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpeErsACgkQp6FrSiUn
Q2rSXgf/S5wamD1CONHNeRpKrBRYVEF+giGFnCQ09MAi07zlN5u7xAZAJwL6IHll
ox+6l/7eT3i0N521mzG2KdbPncpRb+ZqsloU66vTM80MAuX0zsrQDfGXzSmK4gkh
NAy7rD9BMlbN10zeO+PoFQIaeoXerZu+M8LGz6a81Zxfmp6W9lb2nf39Ci+pdGCZ
J+MNUqDY7bnxHBFetPWHeiHJY1IoabiQ/Wspnm7G8MYLHDmyfJXyaagCPN32Uo7P
2gz6DUJzv0TROzaVSyxAD3VrE06KnhUWBkvqccY1/EQ26q+zKY1RlAifldfRgohj
rjTSuwj7M2ucrSppwDjwc5Sh3xWKFg==
=VUwD
-----END PGP SIGNATURE-----

--LrjmrmoHtgVdy1F9dkC6Y5MR3ijVuXyIk--
