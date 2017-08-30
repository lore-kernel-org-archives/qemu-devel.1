Received: from eggs.gnu.org ([2001:4830:134:3::10]:45778)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1dnAjd-0001qw-KH
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 17:41:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1dnAjc-0002xM-Ik
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 17:41:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:16013)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <crosa@redhat.com>) id 1dnAjc-0002xE-8Z
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 17:41:16 -0400
References: <1502951113-4246-1-git-send-email-thuth@redhat.com>
	<1502951113-4246-4-git-send-email-thuth@redhat.com>
From: Cleber Rosa <crosa@redhat.com>
Message-ID: <f19573ba-30c2-2c2b-5f05-8d9372fec583@redhat.com>
Date: Wed, 30 Aug 2017 17:41:01 -0400
MIME-Version: 1.0
In-Reply-To: <1502951113-4246-4-git-send-email-thuth@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="9taHBnEuhOu28BxXFdKl5nDlJQquIqqnt"
Subject: Re: [Qemu-devel] [PATCH 3/6] tests: Enable the drive_del test also
 on s390x
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
--9taHBnEuhOu28BxXFdKl5nDlJQquIqqnt
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
Message-ID: <f19573ba-30c2-2c2b-5f05-8d9372fec583@redhat.com>
Subject: Re: [PATCH 3/6] tests: Enable the drive_del test also on s390x
References: <1502951113-4246-1-git-send-email-thuth@redhat.com>
 <1502951113-4246-4-git-send-email-thuth@redhat.com>
In-Reply-To: <1502951113-4246-4-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 08/17/2017 02:25 AM, Thomas Huth wrote:
> By using the "virtio-xxx" device name aliases instead of the
> "virtio-xxx-pci" names, we can use this test on s390x, too,
> to check that adding and deleting also works fine with the
> virtio-ccw bus.
>=20
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  tests/Makefile.include |  1 +
>  tests/drive_del-test.c | 13 +++++++------
>  2 files changed, 8 insertions(+), 6 deletions(-)
>=20
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index 0bb18b3..ff2a551 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -363,6 +363,7 @@ check-qtest-s390x-y =3D tests/boot-serial-test$(EXE=
SUF)
>  check-qtest-s390x-$(CONFIG_SLIRP) +=3D tests/test-netfilter$(EXESUF)
>  check-qtest-s390x-$(CONFIG_POSIX) +=3D tests/test-filter-mirror$(EXESU=
F)
>  check-qtest-s390x-$(CONFIG_POSIX) +=3D tests/test-filter-redirector$(E=
XESUF)
> +check-qtest-s390x-y +=3D tests/drive_del-test$(EXESUF)
> =20
>  check-qtest-generic-y +=3D tests/qom-test$(EXESUF)
>  check-qtest-generic-y +=3D tests/test-hmp$(EXESUF)
> diff --git a/tests/drive_del-test.c b/tests/drive_del-test.c
> index 2175139..efceb31 100644
> --- a/tests/drive_del-test.c
> +++ b/tests/drive_del-test.c
> @@ -65,12 +65,12 @@ static void test_after_failed_device_add(void)
> =20
>      qtest_start("-drive if=3Dnone,id=3Ddrive0");
> =20
> -    /* Make device_add fail.  If this leaks the virtio-blk-pci device =
then a
> +    /* Make device_add fail.  If this leaks the virtio-blk device then=
 a
>       * reference to drive0 will also be held (via qdev properties).
>       */
>      response =3D qmp("{'execute': 'device_add',"
>                     " 'arguments': {"
> -                   "   'driver': 'virtio-blk-pci',"
> +                   "   'driver': 'virtio-blk',"
>                     "   'drive': 'drive0'"
>                     "}}");
>      g_assert(response);
> @@ -82,7 +82,7 @@ static void test_after_failed_device_add(void)
>      drive_del();
> =20
>      /* Try to re-add the drive.  This fails with duplicate IDs if a le=
aked
> -     * virtio-blk-pci exists that holds a reference to the old drive0.=

> +     * virtio-blk exists that holds a reference to the old drive0.
>       */
>      drive_add();
> =20
> @@ -93,7 +93,7 @@ static void test_drive_del_device_del(void)
>  {
>      /* Start with a drive used by a device that unplugs instantaneousl=
y */
>      qtest_start("-drive if=3Dnone,id=3Ddrive0,file=3Dnull-co://,format=
=3Draw"
> -                " -device virtio-scsi-pci"
> +                " -device virtio-scsi"
>                  " -device scsi-hd,drive=3Ddrive0,id=3Ddev0");
> =20
>      /*
> @@ -114,9 +114,10 @@ int main(int argc, char **argv)
> =20
>      qtest_add_func("/drive_del/without-dev", test_drive_without_dev);
> =20
> -    /* TODO I guess any arch with PCI would do */
> +    /* TODO I guess any arch with a hot-pluggable virtio bus would do =
*/
>      if (!strcmp(arch, "i386") || !strcmp(arch, "x86_64") ||
> -        !strcmp(arch, "ppc") || !strcmp(arch, "ppc64")) {
> +        !strcmp(arch, "ppc") || !strcmp(arch, "ppc64") ||
> +        !strcmp(arch, "s390x")) {
>          qtest_add_func("/drive_del/after_failed_device_add",
>                         test_after_failed_device_add);
>          qtest_add_func("/blockdev/drive_del_device_del",
>=20

I honestly can't comment on the device to be used on this test (as
others have commented).  Putting that aside, and given the fact  that I
went through the lengths of testing it on the s390x target:

Tested-by: Cleber Rosa <crosa@redhat.com>


--9taHBnEuhOu28BxXFdKl5nDlJQquIqqnt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAlmnMO0ACgkQZX6NM6Xy
CfOJmg/9HejG4/o7svzEQrWJCElEC1iZNfD4ALLWKQTDdEUsnudNXGwZwsWQRTx7
FKaktbaIMaR9cPYQ5ofd6spThM9+B1CL1+DoxO2ss/tOZOAcxB64cBvhd3LOxrE4
qmQVyjHehqnHg7C2eWy+8ckSBCgyQQlqFhX9HwCditgqvKpE0ZMOAWOK/gHrLZ8B
TanAU3Iwt7HH5YTD9uHDuvCs0pqertpjqqvIhZwjH7Ony3fuZTsbvR49wMSNWaEr
gFZu6TIWh0Uh2Riyo4avx3iI6+xE78jDP1eFJtX5sivbb3l/nzC4OFHqMOTOU48k
eVhvjl5IFQyjzOBVsNBf11MlKf95wdPhZ+HCifw4Jw0P9E4NmxrYTgaiix1zQtIa
BBI/qXJfi11TTBLwRA01i3FVmOi5C1TA1tN0qqi5T+BpsWU/2X8k1lsiL8v1e9Yg
TQdP9amVlO4URNkTT336qOwRtDyc++N8WkHufv7js+fvzUSHZeNHku0CkS55Nl98
CrywiRFLCN9aPBz1rkL1Iu/VKVOCVaXEvfaGjAUjLJoJ1YR7KLV7ckyPb6ObgY9U
4poUjVz30gnnU5ERp1vjbpEHyTwkPH8ze1+b7uuX+7IEaXG4ZuJ2ae1mRjvvjoY4
8Y9eYvRB5U+WKDnl+iAiqiwaxAQ7ch/U+NKt0EaGwKsgYioZoWI=
=PMf/
-----END PGP SIGNATURE-----

--9taHBnEuhOu28BxXFdKl5nDlJQquIqqnt--
