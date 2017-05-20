Received: from eggs.gnu.org ([2001:4830:134:3::10]:34499)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andrew@aj.id.au>) id 1dBslb-0001yH-FW
	for qemu-devel@nongnu.org; Fri, 19 May 2017 21:01:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andrew@aj.id.au>) id 1dBsla-0002Va-JA
	for qemu-devel@nongnu.org; Fri, 19 May 2017 21:01:11 -0400
Message-ID: <1495242020.23485.1.camel@aj.id.au>
From: Andrew Jeffery <andrew@aj.id.au>
Date: Sat, 20 May 2017 11:00:20 +1000
In-Reply-To: <149524146010.732.16986967949772245903@c05f1edc8ed1>
References: <149524146010.732.16986967949772245903@c05f1edc8ed1>
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-EoSPiC5TjTfuXvClmuX9"
Mime-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH 0/2] hw/adc: Implement a basic Aspeed ADC
 model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com, qemu-arm@nongnu.org, peter.maydell@linaro.org, ryan_chen@aspeedtech.com, alistair@alistair23.me, clg@kaod.org, joel@jms.id.au


--=-EoSPiC5TjTfuXvClmuX9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2017-05-19 at 17:51 -0700, no-reply@patchew.org wrote:
> In file included from /tmp/qemu-test/src/hw/adc/aspeed_adc.c:15:0:
> /tmp/qemu-test/src/hw/adc/aspeed_adc.c: In function 'aspeed_adc_read':
> /tmp/qemu-test/src/hw/adc/aspeed_adc.c:106:34: error: format '%lx' expect=
s argument of type 'long unsigned int', but argument 3 has type 'hwaddr {ak=
a long long unsigned int}' [-Werror=3Dformat=3D]
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_log_mask(LOG_UNIMP,=
 "%s: addr: 0x%lx, size: %u\n", __func__, addr,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^
> /tmp/qemu-test/src/include/qemu/log.h:94:22: note: in definition of macro=
 'qemu_log_mask'
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
qemu_log(FMT, ## __VA_ARGS__);=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^~~
> /tmp/qemu-test/src/hw/adc/aspeed_adc.c: In function 'aspeed_adc_write':
> /tmp/qemu-test/src/hw/adc/aspeed_adc.c:162:34: error: format '%lu' expect=
s argument of type 'long unsigned int', but argument 3 has type 'hwaddr {ak=
a long long unsigned int}' [-Werror=3Dformat=3D]
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_log_mask(LOG_UNIMP,=
 "%s: %lu\n", __func__, addr);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^
> /tmp/qemu-test/src/include/qemu/log.h:94:22: note: in definition of macro=
 'qemu_log_mask'
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
qemu_log(FMT, ## __VA_ARGS__);=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^~~
> cc1: all warnings being treated as errors
> /tmp/qemu-test/src/rules.mak:69: recipe for target 'hw/adc/aspeed_adc.o' =
failed
> make[1]: *** [hw/adc/aspeed_adc.o] Error 1
> make[1]: *** Waiting for unfinished jobs....
> =C2=A0 CC=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 aarch64-softmmu/hw/scsi/virtio-sc=
si-dataplane.o
> Makefile:327: recipe for target 'subdir-aarch64-softmmu' failed
> make: *** [subdir-aarch64-softmmu] Error 2
> make: *** Waiting for unfinished jobs....
> =C2=A0 GEN=C2=A0=C2=A0=C2=A0=C2=A0 x86_64-softmmu/qemu-system-x86_64.exe
> tests/docker/Makefile.include:118: recipe for target 'docker-run' failed
> make[1]: *** [docker-run] Error 2
> make[1]: Leaving directory '/var/tmp/patchew-tester-tmp-i73ef6w0/src'
> tests/docker/Makefile.include:149: recipe for target 'docker-run-test-min=
gw@fedora' failed
> > make: *** [docker-run-test-mingw@fedora] Error 2
> =3D=3D=3D OUTPUT END =3D=3D=3D
>=20
> Test command exited with code: 2

I'll fix the format string issues in v2 along with any other issues
identified in review.

Separately, is it necessary for the bot to send the entirety of the
build output? Can we make it a bit smarter to send just the error with
some small amount of context? Maybe send the full log as an attachment?
Or host it and link to it from the email? It's a bit tedious having to
scroll through all that output to find the error at the bottom.

Cheers,

Andrew
--=-EoSPiC5TjTfuXvClmuX9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIcBAABCgAGBQJZH5UkAAoJEJ0dnzgO5LT5fyUP/3n//wnVmanOFJBHWjWxDsj9
2Il0+mcQsWZpWpGLoW6BF9wDGUuDkeOgX89AMNl43RQZGhRZMwm5mGBqOAuSi+OM
GwG5A6vvHIN+HbEI3SZoC5krB3jtB13/x2utQW+NgiehSJ6d+cuUxbDy1Heeassh
hbawGQm6Zr16lLhtu9fdJJK4e4CWMu7PEFdNZEvgq762uS8DtFACqOSQ8xE8QIme
tBk2hSN6t0gKI2eevjUyoR8XlcPcSRTyNxV+9EKNpE+O3UqPqZZzS6TvF+nVpf3s
CSlE6pBURYKSg+fJuI4DRkWhPn1L1X2RhQmXqCe3a8nJnrgSQVV67+eh1Fpi52Uc
LehKcKWHV1JAQPw/ryZFKf4UCNiRO4KF1+D9xOC8WfiMmnDYrV07Y3moQjy/Wiys
dicwSJDxAELIMZ/LzYG8nT1IumYntT8QUQixmP4pO1dd2V5e1eWhj/6KgiHLlQKv
mW8TLb5ZORX8n/gZk9Rezl0VQ1X+i+LnY6sNBaS4l55dmwngK9/2/haZbBLSeouh
VW3Bo/5y83bqcauOAQEsNsvgq+zyR8YlJBJ6hELwRPvkXHPDbvrU4VLms0s+rVPj
k8eLyf3wQOny4ZaEbVrYFT9NsvGggE6LqVj1rzMeigT5TdvVXPTfcpfmJgBja95F
GKCv9GJS72MFYyP3ZJ24
=fu8k
-----END PGP SIGNATURE-----

--=-EoSPiC5TjTfuXvClmuX9--
