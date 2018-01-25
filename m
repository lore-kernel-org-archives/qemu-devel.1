Received: from eggs.gnu.org ([2001:4830:134:3::10]:50079)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eentr-0004SA-3A
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 15:13:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eentm-0007XX-FE
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 15:13:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33044)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1eentm-0007XD-6g
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 15:13:26 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 36F10C07012C
	for <qemu-devel@nongnu.org>; Thu, 25 Jan 2018 20:13:25 +0000 (UTC)
References: <20180125175949.7780-1-pbonzini@redhat.com>
	<20180125175949.7780-3-pbonzini@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <19017a4f-c586-5551-9fcb-d10b49eaa961@redhat.com>
Date: Thu, 25 Jan 2018 14:13:20 -0600
MIME-Version: 1.0
In-Reply-To: <20180125175949.7780-3-pbonzini@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="GRnmIji6PDjuNdJPVH1yOzfdzajboaBb0"
Subject: Re: [Qemu-devel] [PATCH 2/5] lockable: add QemuLockable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: famz@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--GRnmIji6PDjuNdJPVH1yOzfdzajboaBb0
From: Eric Blake <eblake@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: famz@redhat.com
Message-ID: <19017a4f-c586-5551-9fcb-d10b49eaa961@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/5] lockable: add QemuLockable
References: <20180125175949.7780-1-pbonzini@redhat.com>
 <20180125175949.7780-3-pbonzini@redhat.com>
In-Reply-To: <20180125175949.7780-3-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/25/2018 11:59 AM, Paolo Bonzini wrote:
> QemuLockable is a polymorphic lock type that takes an object and
> knows which function to use for locking and unlocking.  The
> implementation could use C11 _Generic, but since the support is
> not very widespread I am instead using __builtin_choose_expr and
> __builtin_types_compatible_p, which are already used by
> include/qemu/atomic.h.
>=20
> QemuLockable can be used to implement lock guards, or to pass around
> a lock in such a way that a function can release it and re-acquire it.
> The next patch will do this for CoQueue.
>=20
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---

> +
> +static inline __attribute__((__always_inline__)) QemuLockable *
> +qemu_make_lockable(void *x, QemuLockable *lockable)
> +{
> +    /* We cannot test this in a macro, otherwise we get * compiler

Spurious '*' ?

> +     * warnings like "the address of 'm' will always evaluate as 'true=
'".
> +     */
> +    return x ? lockable : NULL;
> +}
> +

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--GRnmIji6PDjuNdJPVH1yOzfdzajboaBb0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpqOmAACgkQp6FrSiUn
Q2oWmAf/YQlYccNQrIfgn4v+wC+jGR6CIkvRwyjh60l0LV/VyrjRz2TkooQEwt9G
FxQBFxDBauKXEni8mteOgSVXZRwA4/lcowuiOvXs5R1oiu+rWQ5PkCCHpLUuKnPV
NO9byHjmvMKl133X/dgKjRNK7AB5KsejDVKZxgHw0LSZFXECJvjcv9ty1I208Z2+
3gyQN7I/Uo0e5/UYhdFEPJ4IAdhw6HIj91kL+p81K2zqes+C5QMGOqDz69UMcCx4
7ZcxoZpKX43XtckS473aKENXbc6x6Q5ufV40tBDqSuyn6vH8tgRib7qebShVzrN1
sPQkpkeK3d7b+OeYbLlxNzzRdix7iA==
=xC3a
-----END PGP SIGNATURE-----

--GRnmIji6PDjuNdJPVH1yOzfdzajboaBb0--
