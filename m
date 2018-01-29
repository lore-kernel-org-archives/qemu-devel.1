Received: from eggs.gnu.org ([2001:4830:134:3::10]:52621)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1egAxk-0008Dn-DR
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 10:03:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1egAxe-000156-S0
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 10:03:12 -0500
References: <20171219163713.31383-1-f4bug@amsat.org>
	<20171219163713.31383-2-f4bug@amsat.org>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <ef6f19e1-8759-1542-6c2f-a20417c2d4d9@redhat.com>
Date: Mon, 29 Jan 2018 16:02:37 +0100
MIME-Version: 1.0
In-Reply-To: <20171219163713.31383-2-f4bug@amsat.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="IhhRYno3eBaXoxK70677uOTdckhlw61ZD"
Subject: Re: [Qemu-devel] [PATCH 1/2] qemu-iotests: add missing rule to
 build socket_scm_helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Wenchao Xia <xiawenc@linux.vnet.ibm.com>, Stratos Psomadakis <psomas@grnet.gr>, Eric Blake <eblake@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--IhhRYno3eBaXoxK70677uOTdckhlw61ZD
From: Max Reitz <mreitz@redhat.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Wenchao Xia <xiawenc@linux.vnet.ibm.com>,
 Stratos Psomadakis <psomas@grnet.gr>, Eric Blake <eblake@redhat.com>
Message-ID: <ef6f19e1-8759-1542-6c2f-a20417c2d4d9@redhat.com>
Subject: Re: [PATCH 1/2] qemu-iotests: add missing rule to build
 socket_scm_helper
References: <20171219163713.31383-1-f4bug@amsat.org>
 <20171219163713.31383-2-f4bug@amsat.org>
In-Reply-To: <20171219163713.31383-2-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-12-19 17:37, Philippe Mathieu-Daud=C3=A9 wrote:
> 'make check-block' uses it on Linux.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  tests/Makefile.include | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index b4bcc872f2..fa5e9597f1 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -919,7 +919,7 @@ check-qapi-schema: $(patsubst %,check-%, $(check-qa=
pi-schema-y)) check-tests/qap
>  check-qtest: $(patsubst %,check-qtest-%, $(QTEST_TARGETS))
>  check-unit: $(patsubst %,check-%, $(check-unit-y))
>  check-speed: $(patsubst %,check-%, $(check-speed-y))
> -check-block: $(patsubst %,check-%, $(check-block-y))
> +check-block: $(patsubst %,check-%, $(check-block-y)) QEMU_IOTESTS_HELP=
ERS-$(CONFIG_LINUX)
>  check: check-qapi-schema check-unit check-qtest
>  check-clean:
>  	$(MAKE) -C tests/tcg clean

First, shouldn't it be $(QEMU_IOTESTS_HELPERS-y)?

Secondly, it seems that is already a dependency of
check-tests/qemu-iotests-quick.sh, which is basically what
$(check-block-y) is.  So even without that dependency here,
socket_scm_helper is built when I run make check-block and it's missing.

Max


--IhhRYno3eBaXoxK70677uOTdckhlw61ZD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlpvN40SHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AJP0IAILIjB0PxmDPrwWD0e3rjxFodLzxW3bX
jKepmzhTFfwz107jTt0e2OhsiF+PQjYZd28sks2dX0BEJKoS45RaAeb9VNUU82Uf
7GxvEARbaNZtVJvgPqLR3s45LORpPsm8LUH/VI9dujgmRLNDxJm3MmGmzkkC5PdT
4mz2Kqm5xEczn2YElfRYThtDsCtQCfg9ZST92O9wv8tSkXES0cca8F/7+3KRMZGj
uyw15U45OWVHHNaClZzGiBktsmfe95V8KOc8ERM+Ftjcub39plJpi2kk1cE7/R7q
4RZV3027vSPKp15rGpcbpFz375d47fM4w0V2DpS5o1lv5ehp8PdfXYk=
=7VdY
-----END PGP SIGNATURE-----

--IhhRYno3eBaXoxK70677uOTdckhlw61ZD--
