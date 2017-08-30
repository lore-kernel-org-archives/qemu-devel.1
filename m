Received: from eggs.gnu.org ([2001:4830:134:3::10]:51381)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1dn9Dc-0007vH-7a
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 16:04:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1dn9DZ-0008PZ-26
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 16:04:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44094)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <crosa@redhat.com>) id 1dn9DY-0008P4-Oe
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 16:04:04 -0400
References: <1502951113-4246-1-git-send-email-thuth@redhat.com>
	<1502951113-4246-3-git-send-email-thuth@redhat.com>
	<20170817104122.4d72674b.cohuck@redhat.com>
From: Cleber Rosa <crosa@redhat.com>
Message-ID: <ce407de7-0154-5ac1-b67a-62eb579d0755@redhat.com>
Date: Wed, 30 Aug 2017 16:03:50 -0400
MIME-Version: 1.0
In-Reply-To: <20170817104122.4d72674b.cohuck@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="rNOigjj0GeptPi2pgGDodPGBQ9iXhkhxL"
Subject: Re: [Qemu-devel] [PATCH 2/6] tests: Add network filter tests to the
 check-qtest-s390x list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, David Hildenbrand <david@redhat.com>, Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Eric Farman <farman@linux.vnet.ibm.com>, Fan Zhang <zhangfan@linux.vnet.ibm.com>, Farhan Ali <alifm@linux.vnet.ibm.com>, Fei Li <sherrylf@linux.vnet.ibm.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>, Jason J Herne <jjherne@linux.vnet.ibm.com>, Jing Liu <liujbjl@linux.vnet.ibm.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, QingFeng Hao <haoqf@linux.vnet.ibm.com>, Xiao Feng Ren <renxiaof@linux.vnet.ibm.com>, Yang Chen <bjcyang@linux.vnet.ibm.com>, Yi Min Zhao <zyimin@linux.vnet.ibm.com>, Marc Mari <markmb@redhat.com>, Michael S Tsirkin <mst@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--rNOigjj0GeptPi2pgGDodPGBQ9iXhkhxL
From: Cleber Rosa <crosa@redhat.com>
To: Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>,
 David Hildenbrand <david@redhat.com>,
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
Message-ID: <ce407de7-0154-5ac1-b67a-62eb579d0755@redhat.com>
Subject: Re: [PATCH 2/6] tests: Add network filter tests to the
 check-qtest-s390x list
References: <1502951113-4246-1-git-send-email-thuth@redhat.com>
 <1502951113-4246-3-git-send-email-thuth@redhat.com>
 <20170817104122.4d72674b.cohuck@redhat.com>
In-Reply-To: <20170817104122.4d72674b.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 08/17/2017 04:41 AM, Cornelia Huck wrote:
> On Thu, 17 Aug 2017 08:25:09 +0200
> Thomas Huth <thuth@redhat.com> wrote:
>=20
>> With some small modifications, we can also use the the netfilter,
>> the fiter-mirror and the filter-redirector tests on s390x.
>=20
> s/fiter/filter/
>=20
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>  tests/Makefile.include         |  3 +++
>>  tests/test-filter-mirror.c     |  9 +++++++--
>>  tests/test-filter-redirector.c | 22 ++++++++++++++++------
>>  tests/test-netfilter.c         | 11 ++++++++++-
>>  4 files changed, 36 insertions(+), 9 deletions(-)
>>
>=20
>> diff --git a/tests/test-filter-mirror.c b/tests/test-filter-mirror.c
>> index a1d5865..d569d27 100644
>> --- a/tests/test-filter-mirror.c
>> +++ b/tests/test-filter-mirror.c
>> @@ -25,6 +25,11 @@ static void test_mirror(void)
>>      char *recv_buf;
>>      uint32_t size =3D sizeof(send_buf);
>>      size =3D htonl(size);
>> +    const char *devstr =3D "e1000";
>> +
>> +    if (g_str_equal(qtest_get_arch(), "s390x")) {
>> +        devstr =3D "virtio-net-ccw";
>> +    }
>=20
> I'm wondering if we could unify selection of the network device
> somehow. There's probably two cases:
> - Test a specific device. This obviously needs to be decided
>   individually.
> - Just use a functional network device. For s390x, this will be
>   virtio-net-ccw; for other architectures, this test uses e1000, while
>   one of the tests below uses rtl8139 (why?). A helper for that may be
>   useful.
>=20

+1.

>> =20
>>      ret =3D socketpair(PF_UNIX, SOCK_STREAM, 0, send_sock);
>>      g_assert_cmpint(ret, !=3D, -1);
>=20
>> diff --git a/tests/test-filter-redirector.c b/tests/test-filter-redire=
ctor.c
>> index 69c663b..3afd411 100644
>> --- a/tests/test-filter-redirector.c
>> +++ b/tests/test-filter-redirector.c
>> @@ -57,6 +57,16 @@
>>  #include "qemu/error-report.h"
>>  #include "qemu/main-loop.h"
>> =20
>> +static const char *get_devstr(void)
>> +{
>> +    if (g_str_equal(qtest_get_arch(), "s390x")) {
>> +        return "virtio-net-ccw";
>> +    }
>> +
>> +    return "rtl8139";
>=20
> No problem with your patch, but I'm wondering why this does not use
> e1000. Special capabilities of rtl8139?
>=20

Tested with e1000.  No problems at all.

>> +}
>> +
>> +
>>  static void test_redirector_tx(void)
>>  {
>>      int backend_sock[2], recv_sock;
>=20
>> diff --git a/tests/test-netfilter.c b/tests/test-netfilter.c
>> index 8b5a9b2..2506473 100644
>> --- a/tests/test-netfilter.c
>> +++ b/tests/test-netfilter.c
>> @@ -182,6 +182,12 @@ static void remove_netdev_with_multi_netfilter(vo=
id)
>>  int main(int argc, char **argv)
>>  {
>>      int ret;
>> +    char *args;
>> +    const char *devstr =3D "e1000";
>=20
> It's our old friend again :)
>=20
>> +
>> +    if (g_str_equal(qtest_get_arch(), "s390x")) {
>> +        devstr =3D "virtio-net-ccw";
>> +    }
>> =20
>>      g_test_init(&argc, &argv, NULL);
>>      qtest_add_func("/netfilter/addremove_one", add_one_netfilter);
>> @@ -191,10 +197,13 @@ int main(int argc, char **argv)
>>      qtest_add_func("/netfilter/remove_netdev_multi",
>>                     remove_netdev_with_multi_netfilter);
>> =20
>> -    qtest_start("-netdev user,id=3Dqtest-bn0 -device e1000,netdev=3Dq=
test-bn0");
>> +    args =3D g_strdup_printf("-netdev user,id=3Dqtest-bn0 "
>> +                           "-device %s,netdev=3Dqtest-bn0", devstr);
>> +    qtest_start(args);
>>      ret =3D g_test_run();
>> =20
>>      qtest_end();
>> +    g_free(args);
>> =20
>>      return ret;
>>  }
>=20
> Even though I think we should deal with the questions above, having
> more tests for s390x is certainly a good idea. Thus,
>=20
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
>=20

Seconded: the network device selection is a different problem.

Reviewed-by: Cleber Rosa <crosa@redhat.com>


--rNOigjj0GeptPi2pgGDodPGBQ9iXhkhxL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAlmnGiYACgkQZX6NM6Xy
CfM/GhAAsRVllB4iFB0CQ8ybMR6FrVhzTgIC+n+l+yy0+zHXDqCNttxVjSLdPYT5
kANXEVqnr++wAc3wgIY4JwlJzWuBHIxsLotpt04H7XhkrtHL8xYwpDO1DWfl0X6K
WsIGgY/Jz3iegVNhSkhqfc+DbjL2K8jjfljaz00It+UK5s5P9nbRXUPy5xAgPEhJ
VOsjCxZiqvz8MWmUvjYwrMGVPGFPQ/W799UfYBw7U3+McEjdGNu2AcN5Wl5fDnKT
hpLFWU8S0Q4k6COP4OjRHVx1N8oTweu8ouLkXQTr2zLofH8t2CCSPzcUPBjVxpk0
qLNibGVnw4+xQODSa0JDg38GZmIGsM4OuE1vGKcOEv478U/EECRdqiQr3Lyw1Yxx
sl4QT2/5XEhFQbtrbcqS/iwfCahvjePGHP8QgxYx644uF/jGmQSzaKHsQ1k9gT/3
ty6jSLp58ExKmsy3skGOI7GOMBOndHhHE0i5GcpQi2tk5XgOih9B2XQJpC/W23a8
y2AyZhioBM4f5+5l0znJ24GwbUlZ02+V6l0bK6JxTF5LlOvKsrr7phflvcBt4nzn
GCoSEQvpedKW6S2Cd4I5rr4Qxeu0aqt5trl4z8dJS1tIxRs6zbU1GGB2FlTythRP
+Y34tmnxtHV1D74D3TBVFTcTzoUxKUY40oGBrDhPmCUDGahruIE=
=KhWK
-----END PGP SIGNATURE-----

--rNOigjj0GeptPi2pgGDodPGBQ9iXhkhxL--
