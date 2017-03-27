Received: from eggs.gnu.org ([2001:4830:134:3::10]:54397)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1csJUJ-0002UO-NA
	for qemu-devel@nongnu.org; Sun, 26 Mar 2017 21:30:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1csJUI-0002yV-3G
	for qemu-devel@nongnu.org; Sun, 26 Mar 2017 21:30:27 -0400
Date: Mon, 27 Mar 2017 11:31:05 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170327003105.GR19078@umbus.fritz.box>
References: <1490189568-167621-1-git-send-email-imammedo@redhat.com>
	<1490189568-167621-2-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ZmeoGP/RI+eIV+cU"
Content-Disposition: inline
In-Reply-To: <1490189568-167621-2-git-send-email-imammedo@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.10 01/23] tests: add CPUs to numa
 node mapping test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Andrew Jones <drjones@redhat.com>, Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Shannon Zhao <zhaoshenglong@huawei.com>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org


--ZmeoGP/RI+eIV+cU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 22, 2017 at 02:32:26PM +0100, Igor Mammedov wrote:
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  tests/Makefile.include |   5 +++
>  tests/numa-test.c      | 106 +++++++++++++++++++++++++++++++++++++++++++=
++++++
>  2 files changed, 111 insertions(+)
>  create mode 100644 tests/numa-test.c
>=20
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index 402e71c..4547b01 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -260,6 +260,7 @@ check-qtest-i386-y +=3D tests/test-filter-mirror$(EXE=
SUF)
>  check-qtest-i386-y +=3D tests/test-filter-redirector$(EXESUF)
>  check-qtest-i386-y +=3D tests/postcopy-test$(EXESUF)
>  check-qtest-i386-y +=3D tests/test-x86-cpuid-compat$(EXESUF)
> +check-qtest-i386-y +=3D tests/numa-test$(EXESUF)
>  check-qtest-x86_64-y +=3D $(check-qtest-i386-y)
>  gcov-files-i386-y +=3D i386-softmmu/hw/timer/mc146818rtc.c
>  gcov-files-x86_64-y =3D $(subst i386-softmmu/,x86_64-softmmu/,$(gcov-fil=
es-i386-y))
> @@ -300,6 +301,7 @@ check-qtest-ppc64-y +=3D tests/test-netfilter$(EXESUF)
>  check-qtest-ppc64-y +=3D tests/test-filter-mirror$(EXESUF)
>  check-qtest-ppc64-y +=3D tests/test-filter-redirector$(EXESUF)
>  check-qtest-ppc64-y +=3D tests/display-vga-test$(EXESUF)
> +check-qtest-ppc64-y +=3D tests/numa-test$(EXESUF)
>  check-qtest-ppc64-$(CONFIG_EVENTFD) +=3D tests/ivshmem-test$(EXESUF)
> =20
>  check-qtest-sh4-y =3D tests/endianness-test$(EXESUF)
> @@ -324,6 +326,8 @@ gcov-files-arm-y +=3D arm-softmmu/hw/block/virtio-blk=
=2Ec
>  check-qtest-arm-y +=3D tests/test-arm-mptimer$(EXESUF)
>  gcov-files-arm-y +=3D hw/timer/arm_mptimer.c
> =20
> +check-qtest-aarch64-y =3D tests/numa-test$(EXESUF)
> +
>  check-qtest-microblazeel-y =3D $(check-qtest-microblaze-y)
> =20
>  check-qtest-xtensaeb-y =3D $(check-qtest-xtensa-y)
> @@ -747,6 +751,7 @@ tests/vhost-user-bridge$(EXESUF): tests/vhost-user-br=
idge.o contrib/libvhost-use
>  tests/test-uuid$(EXESUF): tests/test-uuid.o $(test-util-obj-y)
>  tests/test-arm-mptimer$(EXESUF): tests/test-arm-mptimer.o
>  tests/test-qapi-util$(EXESUF): tests/test-qapi-util.o $(test-util-obj-y)
> +tests/numa-test$(EXESUF): tests/numa-test.o
> =20
>  tests/migration/stress$(EXESUF): tests/migration/stress.o
>  	$(call quiet-command, $(LINKPROG) -static -O3 $(PTHREAD_LIB) -o $@ $< ,=
"LINK","$(TARGET_DIR)$@")
> diff --git a/tests/numa-test.c b/tests/numa-test.c
> new file mode 100644
> index 0000000..f5da0c8
> --- /dev/null
> +++ b/tests/numa-test.c
> @@ -0,0 +1,106 @@
> +/*
> + * NUMA configuration test cases
> + *
> + * Copyright (c) 2017 Red Hat Inc.
> + * Authors:
> + *  Igor Mammedov <imammedo@redhat.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "libqtest.h"
> +
> +static char *make_cli(const char *generic_cli, const char *test_cli)
> +{
> +    return g_strdup_printf("%s %s", generic_cli ? generic_cli : "", test=
_cli);
> +}
> +
> +static char *hmp_info_numa(void)
> +{
> +    QDict *resp;
> +    char *s;
> +
> +    resp =3D qmp("{ 'execute': 'human-monitor-command', 'arguments': "
> +                      "{ 'command-line': 'info numa '} }");
> +    g_assert(resp);
> +    g_assert(qdict_haskey(resp, "return"));
> +    s =3D g_strdup(qdict_get_str(resp, "return"));
> +    g_assert(s);
> +    QDECREF(resp);
> +    return s;
> +}
> +
> +static void test_mon_explicit(const void *data)
> +{
> +    char *s;
> +    char *cli;
> +
> +    cli =3D make_cli(data, "-smp 8 "
> +                   "-numa node,nodeid=3D0,cpus=3D0-3 "
> +                   "-numa node,nodeid=3D1,cpus=3D4-7 ");
> +    qtest_start(cli);
> +
> +    s =3D hmp_info_numa();
> +    g_assert(strstr(s, "node 0 cpus: 0 1 2 3"));
> +    g_assert(strstr(s, "node 1 cpus: 4 5 6 7"));
> +    g_free(s);
> +
> +    qtest_end();
> +    g_free(cli);
> +}
> +
> +static void test_mon_default(const void *data)
> +{
> +    char *s;
> +    char *cli;
> +
> +    cli =3D make_cli(data, "-smp 8 -numa node -numa node");
> +    qtest_start(cli);
> +
> +    s =3D hmp_info_numa();
> +    g_assert(strstr(s, "node 0 cpus: 0 2 4 6"));
> +    g_assert(strstr(s, "node 1 cpus: 1 3 5 7"));
> +    g_free(s);
> +
> +    qtest_end();
> +    g_free(cli);
> +}
> +
> +static void test_mon_partial(const void *data)
> +{
> +    char *s;
> +    char *cli;
> +
> +    cli =3D make_cli(data, "-smp 8 "
> +                   "-numa node,nodeid=3D0,cpus=3D0-1 "
> +                   "-numa node,nodeid=3D1,cpus=3D4-5 ");
> +    qtest_start(cli);
> +
> +    s =3D hmp_info_numa();
> +    g_assert(strstr(s, "node 0 cpus: 0 1 2 3 6 7"));
> +    g_assert(strstr(s, "node 1 cpus: 4 5"));
> +    g_free(s);
> +
> +    qtest_end();
> +    g_free(cli);
> +}
> +
> +int main(int argc, char **argv)
> +{
> +    const char *args =3D NULL;
> +    const char *arch =3D qtest_get_arch();
> +
> +    if (strcmp(arch, "aarch64") =3D=3D 0) {
> +        args =3D "-machine virt";
> +    }
> +
> +    g_test_init(&argc, &argv, NULL);
> +
> +    qtest_add_data_func("/numa/mon/default", args, test_mon_default);
> +    qtest_add_data_func("/numa/mon/cpus/explicit", args, test_mon_explic=
it);
> +    qtest_add_data_func("/numa/mon/cpus/partial", args, test_mon_partial=
);
> +
> +    return g_test_run();
> +}

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--ZmeoGP/RI+eIV+cU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJY2F1JAAoJEGw4ysog2bOSzZQP/3FX711Q9FbQHlg1E6H8btGT
Qdw/t/aPGVLjHOnqfeTixB8Dyfg0hHgDoLMWs4eOdvpjPJ6tZdLMZzoJW5fXgHkB
vjnfuYPikLqh5dZn7nVKH/UzyDq4iWWtEn8icXpViBDMILRbQufA0l8oj53pIE9J
HWUcSD8qncpx/obHfikchlXTimA7xzyvGmiqK/mjyp1cRPA3CQV3R9ZGqAixgFtm
NDP8XOvWhh/0kUQ7c5czqxanU+V21oKYkk7CWfoWV1qHt8pcScWpUh+5gKggIlzs
Hq8LXRCgrDujtYpTbHv03MoIHErwxV7ux9tZB2Aw00snAWz8DAahG0EtTxtIUycD
qnTU/NodmMbWtIbk0Kb5oRWAadKbQJt+Rtj1/G1pjKthMJvGtegJo1v4uotcLEkf
lHwjRJzLzRVqEO6rfujxR3VkC4sYr488IQbc1OJqKWRZ37vs8kxBfI1AueB+f/eX
lsyO5QPCSq31AZy87iU4rYUruJiGbRh78bE2l9/wRgQEJQj6lEANa4ZutLAX7XY3
xAFeFEXqBiJFH29OK5t838+d3Ep36fG311xSrgm5PwVak53w85ESxvoOUzc0+66R
nNvLtBPmxELMnD4RNvFXKgh/JnRbmy7vIjybS8ncLSZr7oUWspFIVcRWEI7+Qx6q
ETUt4pywDpJ23R7aWzjG
=UGhg
-----END PGP SIGNATURE-----

--ZmeoGP/RI+eIV+cU--
