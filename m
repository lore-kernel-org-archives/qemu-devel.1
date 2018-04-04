Received: from eggs.gnu.org ([2001:4830:134:3::10]:49252)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1f3fmB-0001Uo-5V
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 06:36:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1f3fm8-0006za-0G
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 06:36:23 -0400
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:33718)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1f3fm7-0006yr-Nm
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 06:36:19 -0400
Received: by mail-wr0-x243.google.com with SMTP id z73so21809665wrb.0
	for <qemu-devel@nongnu.org>; Wed, 04 Apr 2018 03:36:19 -0700 (PDT)
Date: Wed, 4 Apr 2018 11:36:16 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180404103616.GM4467@stefanha-x1.localdomain>
References: <20180328173238.507470-1-vsementsov@virtuozzo.com>
	<20180328173238.507470-5-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lbQeYSs6J2ITmUo7"
Content-Disposition: inline
In-Reply-To: <20180328173238.507470-5-vsementsov@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH 4/4] scripts/qemugdb: backtraces for
 coroutines in coredump
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, stefanha@redhat.com, den@openvz.org


--lbQeYSs6J2ITmUo7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 28, 2018 at 08:32:38PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> We can't get coroutine backtrace through obvious way
>  - set regs
>  - bt
>  - restore regs
> when debugging a coredump.
> So, let's go hard way: clone current coredump file, patch regs
> in it and execute a subprocess gdb to get backtrace from this
> patched coredump.

I have CCed you on a patch that uses 'select-frame' to temporarily
switch stacks.  This works in a coredump and does not require
cloning/patching the coredump file.

Please let me know if 'select-frame' works for you, it would be
preferrable to cloning/patching the coredump file.

Stefan

--lbQeYSs6J2ITmUo7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaxKqgAAoJEJykq7OBq3PIYPcIAJ8RL3VX8H4PAKKQciHmZZQE
saDnT9E6/lcLT3QXKtRT/xoxP3fs452XXtVsoZIPZW2lb3QJ0GGXfzpRXejPD/fT
FHQH6hbD/Pi0OGm6nV0S8hl1r4woXT5JcfdWrGMDCocgKjNxzcQZv2FwWugKHtlJ
3rA1j8620tnHWeKRHgB7bgK7jv3fxH3LcOk+r0/sSQD59JH3UiUmy9TqBF/NjN02
+v8yoJpnw3kQO5gq5IriTEQRnMKKKxjQudd8VXIj/tRvGFVnkYCShmW+meijwvj5
EckgYsrVOwKWT+rhpSDXJ4BU+i7fogNxJhx1uqRLhW+HVN9Xnkaznb7ekN4mMEY=
=Ry8Q
-----END PGP SIGNATURE-----

--lbQeYSs6J2ITmUo7--
