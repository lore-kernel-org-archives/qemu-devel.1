Received: from eggs.gnu.org ([2001:4830:134:3::10]:49027)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dnSC8-0005ST-NK
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 12:19:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dnSC6-0008Ot-2m
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 12:19:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55030)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dnSC5-0008OL-Q8
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 12:19:50 -0400
References: <20170831131425.3953-1-marcandre.lureau@redhat.com>
	<20170831131425.3953-2-marcandre.lureau@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c0fa5298-e696-0a44-429f-a5f87ed89564@redhat.com>
Date: Thu, 31 Aug 2017 11:19:44 -0500
MIME-Version: 1.0
In-Reply-To: <20170831131425.3953-2-marcandre.lureau@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="ieMFVq5tQWfacSwWKf0KlnSQnWuPQXoPF"
Subject: Re: [Qemu-devel] [PATCH 2/2] .dir-locals.el: add json schema to
 auto-mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: berrange@redhat.com, armbru@redhat.com, Michael Roth <mdroth@linux.vnet.ibm.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ieMFVq5tQWfacSwWKf0KlnSQnWuPQXoPF
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: berrange@redhat.com, armbru@redhat.com,
 Michael Roth <mdroth@linux.vnet.ibm.com>
Message-ID: <c0fa5298-e696-0a44-429f-a5f87ed89564@redhat.com>
Subject: Re: [PATCH 2/2] .dir-locals.el: add json schema to auto-mode
References: <20170831131425.3953-1-marcandre.lureau@redhat.com>
 <20170831131425.3953-2-marcandre.lureau@redhat.com>
In-Reply-To: <20170831131425.3953-2-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/31/2017 08:14 AM, Marc-Andr=C3=A9 Lureau wrote:
> The json schema is more friendly to python-mode since it doesn't
> follow strictly json (comments to start with).

I found that hard to read, and missing a key word of 'emacs'.  Maybe
reword it as:

Under emacs, our QAPI files (.json suffix) are more friendly to edit
under python-mode than the per-suffix default of json-mode (in part
because of our use of comments).

>=20
> All schema files add file variables to set the python mode, but most
> tests didn't. This will cover all json files now.
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---

> +++ b/.dir-locals.el
> @@ -2,6 +2,8 @@
>              (indent-tabs-mode . nil)))
>   (nil . ((eval . (setq auto-mode-alist (append
>                                          '(("Makefile.*" . makefile-gma=
ke-mode)
> -                                          ("\\.mak\\'" . makefile-gmak=
e-mode))
> +                                          ("\\.mak\\'" . makefile-gmak=
e-mode)
> +                                          ;; json schema is not pure j=
son
> +                                          ("\\.json\\'" . python-mode)=
)
>                                          auto-mode-alist))))
>        ))

Not sure if the comment could be worded better, maybe:

;; Our .json files are QAPI, and allow more than pure json

Again, the idea makes sense to me, but you may want to get feedback from
other power emacs users.

[Also, don't forget the 0/2 cover letter if you send v2]

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--ieMFVq5tQWfacSwWKf0KlnSQnWuPQXoPF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmoNyAACgkQp6FrSiUn
Q2p5Agf/aUCEMJqztVxO1lGoW7zFQpNV2ziTp53I1UmqEI0D0NkvH16w5k6sUbBb
TpLA6lT0iaul7xSjmgVKEDsZ3l/8lgySdYaUHIwUvtraiYN8GvwIUROm/lrQl3wK
BCr/K6V4aMKj542coyMP8yYMBKKt1cmUCM2ob1xoavEM0XrHLlndDhz8HdUHh8Hz
kTOm9G5aldcOZEi1q9T86hwB0KkR9K6YvLTDb3z9zVynegEx43wycSxujjI+Q4nM
KvfpGGxhX15wxIaeHWKKc0aaBYKEhyyCxWlNLGb7jUQY2jb/sfgq3XYUmkfbUROG
c4tm0uNQw5n/I4i1py/ADgLtqxgTng==
=MtfC
-----END PGP SIGNATURE-----

--ieMFVq5tQWfacSwWKf0KlnSQnWuPQXoPF--
