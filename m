Received: from eggs.gnu.org ([2001:4830:134:3::10]:54014)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d6eTr-0004c8-DK
	for qemu-devel@nongnu.org; Fri, 05 May 2017 10:45:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d6eTm-00085n-Dz
	for qemu-devel@nongnu.org; Fri, 05 May 2017 10:45:15 -0400
Received: from mail-wm0-x22b.google.com ([2a00:1450:400c:c09::22b]:38198)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1d6eTm-00084K-7x
	for qemu-devel@nongnu.org; Fri, 05 May 2017 10:45:10 -0400
Received: by mail-wm0-x22b.google.com with SMTP id 142so8480190wma.1
	for <qemu-devel@nongnu.org>; Fri, 05 May 2017 07:45:09 -0700 (PDT)
Date: Fri, 5 May 2017 15:45:06 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170505144506.GA14316@stefanha-x1.localdomain>
References: <CAEfK_46MMR6cH3ahuJ=zfcuKAp07iU20Ps+yZYv5s9woCPnsSw@mail.gmail.com>
	<20170502142207.GJ22502@stefanha-x1.localdomain>
	<CAEfK_46hGYYpO4YhYcxdUar1ugLQwbpJMgxAJDJU13zSpbD4zw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dDRMvlgZJXvWKvBx"
Content-Disposition: inline
In-Reply-To: <CAEfK_46hGYYpO4YhYcxdUar1ugLQwbpJMgxAJDJU13zSpbD4zw@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH] gdbstub: implement remote debugging
 protocol escapes for command receive
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Doug Gale <doug16k@gmail.com>
Cc: qemu-devel@nongnu.org


--dDRMvlgZJXvWKvBx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 02, 2017 at 10:32:40AM -0400, Doug Gale wrote:
> +            } else {
> +                /* decode repeat length */
> +                int repeat = (unsigned char)ch - ' ' + 3;
> +                if (s->line_buf_index + repeat >= sizeof(s->line_buf) - 1) {
> +                    /* that many repeats would overrun the command buffer */
> +#ifdef DEBUG_GDB
> +                    printf("gdbstub command buffer overrun,"
> +                           " dropping command\n");
> +#endif
> +                    s->state = RS_IDLE;
> +                } else if (s->line_buf_index <= 2) {

Why s->line_buf_index <= 2?  I expected s->line_buf_index < 1 since we
just need 1 character to clone for run-length decoding.

> +                    /* got a repeat but we have nothing to repeat */
> +#ifdef DEBUG_GDB
> +                    printf("gdbstub got invalid RLE sequence\n");
> +#endif
> +                } else {

Missing s->state = RS_IDLE?

--dDRMvlgZJXvWKvBx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZDI/yAAoJEJykq7OBq3PIfwIH/1vkZvq0KmuvpYNn8xxTRVgE
J+MejocyCzJ2MAVe7BdQjS9I6URAMsWL2SKT0AQmQv7jii6JIcvQk+h99Cksw9AV
m2cKC5BVeOXKDRVbCsgbP7j+vrnuMDG7YQ+v8v+kqnQ+0tE1TEzLkSM6yAzgxiV1
8+5wb1vIlQffxIC9JWG9JIApcSWaA1Cm52nFN6uKTd3klDIkztc8bsnfvlZv4JCZ
NfDnBooA5uN3vnQE0lwaQWR/VOdppDtjmw1ze1kKlrEfpCIUDBh+mrNKt5HmtwBp
3KTwYZS28X5LwrFqYcx9qyMQ/gfCrbslV6g6YbQDY20cbKLSJn8D0LvMNQ/SEds=
=ZJos
-----END PGP SIGNATURE-----

--dDRMvlgZJXvWKvBx--
