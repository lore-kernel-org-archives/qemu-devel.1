Received: from eggs.gnu.org ([2001:4830:134:3::10]:50835)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eenvt-0005tk-Pu
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 15:15:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eenvp-0000Pp-5q
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 15:15:37 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45282)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1eenvo-0000PV-TX
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 15:15:33 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3F99E55882
	for <qemu-devel@nongnu.org>; Thu, 25 Jan 2018 20:15:32 +0000 (UTC)
References: <20180125175949.7780-1-pbonzini@redhat.com>
	<20180125175949.7780-5-pbonzini@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <de71ef60-9787-25fb-617e-5c139351c039@redhat.com>
Date: Thu, 25 Jan 2018 14:15:27 -0600
MIME-Version: 1.0
In-Reply-To: <20180125175949.7780-5-pbonzini@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="N7dB2L4mRBHT2M4W6vlv9nXcYD5DHmm21"
Subject: Re: [Qemu-devel] [PATCH 4/5] coroutine-lock: make
 qemu_co_enter_next thread-safe
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
--N7dB2L4mRBHT2M4W6vlv9nXcYD5DHmm21
From: Eric Blake <eblake@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: famz@redhat.com
Message-ID: <de71ef60-9787-25fb-617e-5c139351c039@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 4/5] coroutine-lock: make qemu_co_enter_next
 thread-safe
References: <20180125175949.7780-1-pbonzini@redhat.com>
 <20180125175949.7780-5-pbonzini@redhat.com>
In-Reply-To: <20180125175949.7780-5-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/25/2018 11:59 AM, Paolo Bonzini wrote:
> qemu_co_queue_next does not need to release and re-acquire the mutex,
> because the queued coroutine does not run immediately.  However, this
> does not hold for qemu_co_enter_next.  Now that qemu_co_queue_wait
> can synchronize (via QemuLockable) with code that is not running in
> coroutine context, it's important that code using qemu_co_enter_next
> can easily use a standardized locking idiom.
>=20
> First of all, qemu_co_enter_next must use aio_co_wake to restart the
> coroutine.  Second, the function gains a second argument, a QemuLockabl=
e*,
> and the comments of qemu_co_queue_next and qemu_co_queue_restart_all
> are adjusted to clarify the difference.
>=20
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---

>  /**
> - * Restarts all coroutines in the CoQueue and leaves the queue empty.
> + * Empties the CoQueue; all coroutines in it will run in FIFO orer as =
soon

s/orer/order/

> + * as the current one yields.
>   */
>  void coroutine_fn qemu_co_queue_restart_all(CoQueue *queue);


--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--N7dB2L4mRBHT2M4W6vlv9nXcYD5DHmm21
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpqOt8ACgkQp6FrSiUn
Q2r+KQgApZ35sjYUo9DkB5PMMLCTm9s5F4KLuXvP6njBiSSjEwTD/Eu72KStbXnl
+XAWnug2SjqRd4RC5raGRslpz9NSoAhuvRo+C8INaORtdo2DZ/JtFKFlSmlHZX+B
4IvZfACeoPIwFQWjyWZVKCfZ7SRJntHEMzS/YEVnVLKYeiPZrrQ+wHLUuk47YGgu
XO2Objy+BOean+dOgrJy/J46fHEIpMksGTwhrLySmiIW3igWjfXn2nfhBAgdghOf
P5FBjAC619rYc7rmPgGD5Dw9KX/rwPGN6hX7xw3/9rJqByJkKe/E4oxS3D0MXxV9
EfmnNpEQ8QQZD41RDja/En5o1MDxKA==
=5HfV
-----END PGP SIGNATURE-----

--N7dB2L4mRBHT2M4W6vlv9nXcYD5DHmm21--
