Received: from eggs.gnu.org ([2001:4830:134:3::10]:44731)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1dn8m0-0000Pg-5J
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 15:35:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1dn8lu-0005m2-Re
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 15:35:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53704)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <crosa@redhat.com>) id 1dn8lu-0005jz-IS
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 15:35:30 -0400
References: <1502951113-4246-1-git-send-email-thuth@redhat.com>
	<1502951113-4246-2-git-send-email-thuth@redhat.com>
From: Cleber Rosa <crosa@redhat.com>
Message-ID: <0e7bd160-7e41-e09d-b2d5-bb9368bc6f56@redhat.com>
Date: Wed, 30 Aug 2017 15:35:15 -0400
MIME-Version: 1.0
In-Reply-To: <1502951113-4246-2-git-send-email-thuth@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="brJ0V5BuBtlph34F0iWMOPCwp40hNE3aH"
Subject: Re: [Qemu-devel] [PATCH 1/6] tests: Run filter-redirector and
 -mirror test only on POSIX systems
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>
Cc: David Hildenbrand <david@redhat.com>, Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Eric Farman <farman@linux.vnet.ibm.com>, Fan Zhang <zhangfan@linux.vnet.ibm.com>, Farhan Ali <alifm@linux.vnet.ibm.com>, Fei Li <sherrylf@linux.vnet.ibm.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>, Jason J Herne <jjherne@linux.vnet.ibm.com>, Jing Liu <liujbjl@linux.vnet.ibm.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, QingFeng Hao <haoqf@linux.vnet.ibm.com>, Xiao Feng Ren <renxiaof@linux.vnet.ibm.com>, Yang Chen <bjcyang@linux.vnet.ibm.com>, Yi Min Zhao <zyimin@linux.vnet.ibm.com>, Marc Mari <markmb@redhat.com>, Michael S Tsirkin <mst@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--brJ0V5BuBtlph34F0iWMOPCwp40hNE3aH
From: Cleber Rosa <crosa@redhat.com>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Cornelia Huck <cohuck@redhat.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>
Cc: David Hildenbrand <david@redhat.com>,
 Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>,
 Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>,
 Eric Farman <farman@linux.vnet.ibm.com>,
 Fan Zhang <zhangfan@linux.vnet.ibm.com>,
 Farhan Ali <alifm@linux.vnet.ibm.com>, Fei Li <sherrylf@linux.vnet.ibm.com>,
 Halil Pasic <pasic@linux.vnet.ibm.com>,
 Janosch Frank <frankja@linux.vnet.ibm.com>,
 Jason J Herne <jjherne@linux.vnet.ibm.com>,
 Jing Liu <liujbjl@linux.vnet.ibm.com>,
 Pierre Morel <pmorel@linux.vnet.ibm.com>,
 QingFeng Hao <haoqf@linux.vnet.ibm.com>,
 Xiao Feng Ren <renxiaof@linux.vnet.ibm.com>,
 Yang Chen <bjcyang@linux.vnet.ibm.com>,
 Yi Min Zhao <zyimin@linux.vnet.ibm.com>, Marc Mari <markmb@redhat.com>,
 Michael S Tsirkin <mst@redhat.com>
Message-ID: <0e7bd160-7e41-e09d-b2d5-bb9368bc6f56@redhat.com>
Subject: Re: [PATCH 1/6] tests: Run filter-redirector and -mirror test only on
 POSIX systems
References: <1502951113-4246-1-git-send-email-thuth@redhat.com>
 <1502951113-4246-2-git-send-email-thuth@redhat.com>
In-Reply-To: <1502951113-4246-2-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 08/17/2017 02:25 AM, Thomas Huth wrote:
> This way we can get rid of the ugly #ifdefs in the code which makes
> it easier to extend later.
>=20
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  tests/Makefile.include         |  8 ++++----
>  tests/test-filter-mirror.c     |  5 -----
>  tests/test-filter-redirector.c | 10 ----------
>  3 files changed, 4 insertions(+), 19 deletions(-)
>=20
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index 37c1bed..8d5991d 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -283,8 +283,8 @@ ifeq ($(CONFIG_VHOST_USER_NET_TEST_i386),)
>  check-qtest-x86_64-$(CONFIG_VHOST_USER_NET_TEST_x86_64) +=3D tests/vho=
st-user-test$(EXESUF)
>  endif
>  check-qtest-i386-$(CONFIG_SLIRP) +=3D tests/test-netfilter$(EXESUF)
> -check-qtest-i386-y +=3D tests/test-filter-mirror$(EXESUF)
> -check-qtest-i386-y +=3D tests/test-filter-redirector$(EXESUF)
> +check-qtest-i386-$(CONFIG_POSIX) +=3D tests/test-filter-mirror$(EXESUF=
)
> +check-qtest-i386-$(CONFIG_POSIX) +=3D tests/test-filter-redirector$(EX=
ESUF)
>  check-qtest-i386-y +=3D tests/postcopy-test$(EXESUF)
>  check-qtest-i386-y +=3D tests/test-x86-cpuid-compat$(EXESUF)
>  check-qtest-i386-y +=3D tests/numa-test$(EXESUF)
> @@ -325,8 +325,8 @@ check-qtest-ppc64-y +=3D tests/usb-hcd-xhci-test$(E=
XESUF)
>  gcov-files-ppc64-y +=3D hw/usb/hcd-xhci.c
>  check-qtest-ppc64-y +=3D $(check-qtest-virtio-y)
>  check-qtest-ppc64-$(CONFIG_SLIRP) +=3D tests/test-netfilter$(EXESUF)
> -check-qtest-ppc64-y +=3D tests/test-filter-mirror$(EXESUF)
> -check-qtest-ppc64-y +=3D tests/test-filter-redirector$(EXESUF)
> +check-qtest-ppc64-$(CONFIG_POSIX) +=3D tests/test-filter-mirror$(EXESU=
F)
> +check-qtest-ppc64-$(CONFIG_POSIX) +=3D tests/test-filter-redirector$(E=
XESUF)
>  check-qtest-ppc64-y +=3D tests/display-vga-test$(EXESUF)
>  check-qtest-ppc64-y +=3D tests/numa-test$(EXESUF)
>  check-qtest-ppc64-$(CONFIG_IVSHMEM) +=3D tests/ivshmem-test$(EXESUF)
> diff --git a/tests/test-filter-mirror.c b/tests/test-filter-mirror.c
> index 9f84402..a1d5865 100644
> --- a/tests/test-filter-mirror.c
> +++ b/tests/test-filter-mirror.c
> @@ -17,9 +17,6 @@
> =20
>  static void test_mirror(void)
>  {
> -#ifndef _WIN32
> -/* socketpair(PF_UNIX) which does not exist on windows */
> -
>      int send_sock[2], recv_sock;
>      char *cmdline;
>      uint32_t ret =3D 0, len =3D 0;
> @@ -74,8 +71,6 @@ static void test_mirror(void)
>      g_free(recv_buf);
>      close(recv_sock);
>      unlink(sock_path);
> -
> -#endif
>  }
> =20
>  int main(int argc, char **argv)
> diff --git a/tests/test-filter-redirector.c b/tests/test-filter-redirec=
tor.c
> index 0c4b8d5..69c663b 100644
> --- a/tests/test-filter-redirector.c
> +++ b/tests/test-filter-redirector.c
> @@ -59,9 +59,6 @@
> =20
>  static void test_redirector_tx(void)
>  {
> -#ifndef _WIN32
> -/* socketpair(PF_UNIX) which does not exist on windows */
> -
>      int backend_sock[2], recv_sock;
>      char *cmdline;
>      uint32_t ret =3D 0, len =3D 0;
> @@ -129,15 +126,10 @@ static void test_redirector_tx(void)
>      unlink(sock_path0);
>      unlink(sock_path1);
>      qtest_end();
> -
> -#endif
>  }
> =20
>  static void test_redirector_rx(void)
>  {
> -#ifndef _WIN32
> -/* socketpair(PF_UNIX) which does not exist on windows */
> -
>      int backend_sock[2], send_sock;
>      char *cmdline;
>      uint32_t ret =3D 0, len =3D 0;
> @@ -203,8 +195,6 @@ static void test_redirector_rx(void)
>      unlink(sock_path0);
>      unlink(sock_path1);
>      qtest_end();
> -
> -#endif
>  }
> =20
>  int main(int argc, char **argv)
>=20

Tested attempting to cross-compile those:

 $ ./configure --cross-prefix=3Di686-w64-mingw32-
 $ make
 $ make tests/test-filter-mirror.exe
 ...
  CC      tests/test-filter-redirector.o
tests/test-filter-redirector.c: In function 'test_redirector_tx':
tests/test-filter-redirector.c:72:11: error: implicit declaration of
function 'socketpair'; did you mean 'socket_init'?
[-Werror=3Dimplicit-function-declaration]
 ...

Which is supposed to fail.

Tested-by: Cleber Rosa <crosa@redhat.com>


--brJ0V5BuBtlph34F0iWMOPCwp40hNE3aH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAlmnE3MACgkQZX6NM6Xy
CfMFuQ//QOqA8pLUOB+Z5sz0XBz7h32COKON7PHre/U+k6MS943UL73BGFEcM9TJ
uW+/wtuGPjrcoJZDXWOTfH8QKTmEpX4YLickW4Bx4volXmvPXlX68nLe520Xv7TS
gYpk+QK1UfhHxjYnjwvfmUirmQ3Yzfxu5NrHu1uNXd6I5eANJuzQQDqwvxeWAyUe
hAMpGvDSYqbA4fMjsk7HMrRlCXBT6AmLSaTAwxmpjmCJ0/XzGGwUuqmE6rWxPrqW
+afbeuzHEwho8d6lb3YQlQhiKLrDPUlxeMMNB4OkZepAf7TLDBTBLwgR+iJPzL4n
A3SBV/slv+hDHHHUG6/UECnHA99IcV9I1pY/CKrIhjerLrR5/siqlHDbHY2ar3Dd
bFVlka/FJ6uqzUH75PIFFMxApQW3qV7Y3AahtqOHDA7bt/vXFVxXgu+52QWs8v6M
GIaMxu90qUEX8q0/CIOpyS7pqySmz3zW6Vfrjcdbx9XH/QcGllREkGFUQ2nvszqB
2M1r5LINml5NZR4AA+/YR6aG2SwfH7jitevrPejfhHem2SygE3/BQ6Uqv7+H7C1C
OUpHjteKVrTQ8ItZkpfXjZEIXFAse77970yv/MEZHu1IwiRKmD5preY59tk0I9r5
mH2VM29UFirZG4fmx4AWUdKi7GKf9wn5Z5DIN6jcSZ/1nHYPlbw=
=xgeL
-----END PGP SIGNATURE-----

--brJ0V5BuBtlph34F0iWMOPCwp40hNE3aH--
