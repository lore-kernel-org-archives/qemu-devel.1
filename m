Received: from eggs.gnu.org ([2001:4830:134:3::10]:48119)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dHbbj-0004CA-Da
	for qemu-devel@nongnu.org; Sun, 04 Jun 2017 15:54:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dHbbi-0007hU-0c
	for qemu-devel@nongnu.org; Sun, 04 Jun 2017 15:54:39 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:42436)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1dHbbh-0007gr-QE
	for qemu-devel@nongnu.org; Sun, 04 Jun 2017 15:54:37 -0400
Date: Sun, 4 Jun 2017 21:54:35 +0200
From: Aurelien Jarno <aurelien@aurel32.net>
Message-ID: <20170604195435.5fbese4rgxaa7b6i@aurel32.net>
References: <20170604173509.29684-1-rth@twiddle.net>
	<149660117521.4501.17173636129226569414@f98a8425f76e>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <149660117521.4501.17173636129226569414@f98a8425f76e>
Subject: Re: [Qemu-devel] [PULL 00/69] target/s390x tcg patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: rth@twiddle.net, famz@redhat.com, peter.maydell@linaro.org

On 2017-06-04 11:32, no-reply@patchew.org wrote:
> Hi,
>=20
> This series failed build test on s390x host. Please find the details belo=
w.
>=20
> Subject: [Qemu-devel] [PULL 00/69] target/s390x tcg patches
> Message-id: 20170604173509.29684-1-rth@twiddle.net
> Type: series
>=20

[snip]

> /var/tmp/patchew-tester-tmp-9ddil10x/src/target/s390x/mem_helper.c: In fu=
nction =E2=80=98helper_lpq=E2=80=99:
> /var/tmp/patchew-tester-tmp-9ddil10x/src/target/s390x/mem_helper.c:1675:1=
6: error: implicit declaration of function =E2=80=98helper_atomic_ldo_be_mm=
u=E2=80=99 [-Werror=3Dimplicit-function-declaration]
>      Int128 v =3D helper_atomic_ldo_be_mmu(env, addr, oi, ra);
>                 ^~~~~~~~~~~~~~~~~~~~~~~~
> /var/tmp/patchew-tester-tmp-9ddil10x/src/target/s390x/mem_helper.c:1675:5=
: error: nested extern declaration of =E2=80=98helper_atomic_ldo_be_mmu=E2=
=80=99 [-Werror=3Dnested-externs]
>      Int128 v =3D helper_atomic_ldo_be_mmu(env, addr, oi, ra);
>      ^~~~~~
> /var/tmp/patchew-tester-tmp-9ddil10x/src/target/s390x/mem_helper.c: In fu=
nction =E2=80=98helper_stpq=E2=80=99:
> /var/tmp/patchew-tester-tmp-9ddil10x/src/target/s390x/mem_helper.c:1690:5=
: error: implicit declaration of function =E2=80=98helper_atomic_sto_be_mmu=
=E2=80=99 [-Werror=3Dimplicit-function-declaration]
>      helper_atomic_sto_be_mmu(env, addr, v, oi, ra);
>      ^~~~~~~~~~~~~~~~~~~~~~~~
> /var/tmp/patchew-tester-tmp-9ddil10x/src/target/s390x/mem_helper.c:1690:5=
: error: nested extern declaration of =E2=80=98helper_atomic_sto_be_mmu=E2=
=80=99 [-Werror=3Dnested-externs]
> cc1: all warnings being treated as errors
> /var/tmp/patchew-tester-tmp-9ddil10x/src/rules.mak:69: recipe for target =
'target/s390x/mem_helper.o' failed
> make[1]: *** [target/s390x/mem_helper.o] Error 1
> Makefile:327: recipe for target 'subdir-s390x-softmmu' failed
> make: *** [subdir-s390x-softmmu] Error 2
> make: *** Waiting for unfinished jobs....

Sorry for not testing test building those patches properly.

The best is probably to just drop them for now as they are independent
besides some easy conflict to solve in helper.h. Properly implementing
the !CONFIG_ATOMIC128 case requires to check the alignment and it's
better done with the check_alignment function introduced later in the
series.

I'll send new patches for those two instructions in the next hours.

Aurelien

--=20
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                 http://www.aurel32.net
