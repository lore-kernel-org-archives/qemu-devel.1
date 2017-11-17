Received: from eggs.gnu.org ([2001:4830:134:3::10]:50627)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1eFgdl-0003Ky-9c
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 08:25:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1eFgdj-0004BT-Ne
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 08:25:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49728)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <crosa@redhat.com>) id 1eFgdj-0004At-DW
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 08:25:03 -0500
References: <20171116223527.4499-1-danielhb@linux.vnet.ibm.com>
	<20171116223527.4499-3-danielhb@linux.vnet.ibm.com>
From: Cleber Rosa <crosa@redhat.com>
Message-ID: <4ab78f2c-7088-81b4-2c5c-13a88bd8e75c@redhat.com>
Date: Fri, 17 Nov 2017 08:24:58 -0500
MIME-Version: 1.0
In-Reply-To: <20171116223527.4499-3-danielhb@linux.vnet.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Ua7FNqaojBt9xUi2ewiVHlSRU5ghuKqjG"
Subject: Re: [Qemu-devel] [PATCH v3 2/2] tests/qemu-iotests: adding
 savevm/loadvm with postcopy flag test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Ua7FNqaojBt9xUi2ewiVHlSRU5ghuKqjG
From: Cleber Rosa <crosa@redhat.com>
To: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>,
 qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>
Message-ID: <4ab78f2c-7088-81b4-2c5c-13a88bd8e75c@redhat.com>
Subject: Re: [PATCH v3 2/2] tests/qemu-iotests: adding savevm/loadvm with
 postcopy flag test
References: <20171116223527.4499-1-danielhb@linux.vnet.ibm.com>
 <20171116223527.4499-3-danielhb@linux.vnet.ibm.com>
In-Reply-To: <20171116223527.4499-3-danielhb@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 11/16/2017 05:35 PM, Daniel Henrique Barboza wrote:
> This patch implements a test case for the scenario that was failing
> prior to the patch "migration/ram.c: do not set 'postcopy_running' in
> POSTCOPY_INCOMING_END".
>=20
> This new test file 198 was derived from the test file 181 authored
> by Kevin Wolf.
>=20
> CC: Kevin Wolf <kwolf@redhat.com>
> CC: Max Reitz <mreitz@redhat.com>
> CC: Cleber Rosa <crosa@redhat.com>
> Signed-off-by: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
>=20
> ---
> I CCed Cleber Rosa because this patch was developed at the same
> time his patch series "[PATCH 00/10] I/O tests cleanups" hit the
> mailing list. Most of the cleanups/fixes he made in the series was
> done in this new test as well.
>=20

Your test looks like a positive review/validation of (some of) the
changes proposed in the "[PATCH 00/10] I/O tests cleanups" indeed.

Thanks for noticing that and for the CC.

- Cleber.

>  tests/qemu-iotests/198     | 110 +++++++++++++++++++++++++++++++++++++=
++++++++
>  tests/qemu-iotests/198.out |  20 +++++++++
>  tests/qemu-iotests/group   |   1 +
>  3 files changed, 131 insertions(+)
>  create mode 100755 tests/qemu-iotests/198
>  create mode 100644 tests/qemu-iotests/198.out
>=20
> diff --git a/tests/qemu-iotests/198 b/tests/qemu-iotests/198
> new file mode 100755
> index 0000000000..786e37fc95
> --- /dev/null
> +++ b/tests/qemu-iotests/198
> @@ -0,0 +1,110 @@
> +#!/bin/bash
> +#
> +# Test savevm and loadvm after live migration with postcopy flag
> +#
> +# Copyright (C) 2017, IBM Corporation.
> +#
> +# This file is derived from tests/qemu-iotests/181 by Kevin Wolf
> +#
> +# This program is free software; you can redistribute it and/or modify=

> +# it under the terms of the GNU General Public License as published by=

> +# the Free Software Foundation; either version 2 of the License, or
> +# (at your option) any later version.
> +#
> +# This program is distributed in the hope that it will be useful,
> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +# GNU General Public License for more details.
> +#
> +# You should have received a copy of the GNU General Public License
> +# along with this program.  If not, see <http://www.gnu.org/licenses/>=
=2E
> +#
> +# Creator/Owner : danielhb@linux.vnet.ibm.com
> +
> +seq=3D`basename $0`
> +echo "QA output created by $seq"
> +
> +status=3D1	# failure is the default!
> +
> +MIG_SOCKET=3D"${TEST_DIR}/migrate"
> +
> +# get standard environment, filters and checks
> +. ./common.rc
> +. ./common.filter
> +. ./common.qemu
> +
> +_cleanup()
> +{
> +    rm -f "${MIG_SOCKET}"
> +    _cleanup_test_img
> +    _cleanup_qemu
> +}
> +trap "_cleanup; exit \$status" 0 1 2 3 15
> +
> +_supported_fmt qcow2
> +_supported_proto generic
> +_supported_os Linux
> +
> +size=3D64M
> +_make_test_img $size
> +
> +echo
> +echo =3D=3D=3D Starting VMs =3D=3D=3D
> +echo
> +
> +qemu_comm_method=3D"monitor"
> +
> +if [ "$IMGOPTSSYNTAX" =3D "true" ]; then
> +    _launch_qemu \
> +        -drive "${TEST_IMG}",cache=3D${CACHEMODE},id=3Ddisk
> +else
> +    _launch_qemu \
> +        -drive file=3D"${TEST_IMG}",cache=3D${CACHEMODE},driver=3D$IMG=
FMT,id=3Ddisk
> +fi
> +src=3D$QEMU_HANDLE
> +
> +if [ "$IMGOPTSSYNTAX" =3D "true" ]; then
> +    _launch_qemu \
> +        -drive "${TEST_IMG}",cache=3D${CACHEMODE},id=3Ddisk \
> +        -incoming "unix:${MIG_SOCKET}"
> +else
> +    _launch_qemu \
> +        -drive file=3D"${TEST_IMG}",cache=3D${CACHEMODE},driver=3D$IMG=
FMT,id=3Ddisk \
> +        -incoming "unix:${MIG_SOCKET}"
> +fi
> +dest=3D$QEMU_HANDLE
> +
> +echo
> +echo =3D=3D=3D Set \'migrate_set_capability postcopy-ram on\' and migr=
ate =3D=3D=3D
> +echo
> +
> +silent=3Dyes
> +_send_qemu_cmd $dest 'migrate_set_capability postcopy-ram on' "(qemu)"=

> +_send_qemu_cmd $src 'migrate_set_capability postcopy-ram on' "(qemu)"
> +_send_qemu_cmd $src "migrate -d unix:${MIG_SOCKET}" "(qemu)"
> +
> +QEMU_COMM_TIMEOUT=3D1 qemu_cmd_repeat=3D10 silent=3Dyes \
> +    _send_qemu_cmd $src "info migrate" "completed\|failed"
> +silent=3Dyes _send_qemu_cmd $src "" "(qemu)"
> +
> +echo
> +echo =3D=3D=3D On destination, execute savevm and loadvm =3D=3D=3D
> +echo
> +
> +silent=3D
> +_send_qemu_cmd $dest 'savevm state1"' "(qemu)"
> +_send_qemu_cmd $dest 'loadvm state1"' "(qemu)"
> +
> +echo
> +echo =3D=3D=3D Shut down and check image =3D=3D=3D
> +echo
> +
> +_send_qemu_cmd $src 'quit' ""
> +_send_qemu_cmd $dest 'quit' ""
> +wait=3D1 _cleanup_qemu
> +
> +_check_test_img
> +
> +# success, all done
> +echo "*** done"
> +status=3D0
> diff --git a/tests/qemu-iotests/198.out b/tests/qemu-iotests/198.out
> new file mode 100644
> index 0000000000..6c27303857
> --- /dev/null
> +++ b/tests/qemu-iotests/198.out
> @@ -0,0 +1,20 @@
> +QA output created by 198
> +Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864
> +
> +=3D=3D=3D Starting VMs =3D=3D=3D
> +
> +
> +=3D=3D=3D Set 'migrate_set_capability postcopy-ram on' and migrate =3D=
=3D=3D
> +
> +
> +=3D=3D=3D On destination, execute savevm and loadvm =3D=3D=3D
> +
> +(qemu) savevm state1"
> +(qemu) loadvm state1"
> +
> +=3D=3D=3D Shut down and check image =3D=3D=3D
> +
> +(qemu) quit
> +(qemu) quit
> +No errors were found on the image.
> +*** done
> diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
> index 24e5ad1b79..84d082bc38 100644
> --- a/tests/qemu-iotests/group
> +++ b/tests/qemu-iotests/group
> @@ -194,3 +194,4 @@
>  194 rw auto migration quick
>  195 rw auto quick
>  197 rw auto quick
> +198 rw auto migration
>=20


--Ua7FNqaojBt9xUi2ewiVHlSRU5ghuKqjG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAloO4yoACgkQZX6NM6Xy
CfOccRAAh8SCL1oYJLukiFO05Pq094+7Qav95itFH6nsA2CEKJYwAYAkrnr1H5b4
A/fMQXBRblSi+H9Gq1J4RphqiWpzIxsznJTUgZRCPoyuiH/nhTlDEawceCWeRG2J
lUcJlLt8Jk1Vi6NPL9eDYsL1vyUiSPICXMFsGcMg+/Hoijq1oQzICAMeC7TWWzHH
aB51kIHCTKiJ7J/TzfIzaGcMxbdphXbLfWPHzXmXNIy1Gc/ld/JBR3gu5sZxkvhx
fse54DZ1khqcZkA2Y/SlzNcApClApviTyCmKETUMu/vKwVkzWVxzCNs9nezRxtrw
bjNaQF8oeYKbbNHU3EH/dpjHfVYqRcNhlAB9TIKiKnnN1RoSgsfZ8g428SaVWizg
JgsdNCZveuhX93fEbqK8LnwD7iGgX2ELH+/++WwdeuucDQELoHJijgRHmIvkQYC5
Cx95bJOyFd9+5KJtPIK+IhvdnOxIxkJteG9/zLWl9IFF8EJ3MysPuzmQ3OQwFyOM
6upVSk+xxW18tLfKa5B3YWhS+9WfAbjpJ5/A7ZYH7+i4dYr0NjZZm3rhlOjqef5C
91H9IrowcdbvNtTCZwhBsxGEULkS+ekU06TkDTMH2enLY4JJXdApZmMWkfNdlPI9
aG/929j+V8KL83QBbFk7DJSANsth86OXsMIDHW0YI7shgvvIhIQ=
=tG3Q
-----END PGP SIGNATURE-----

--Ua7FNqaojBt9xUi2ewiVHlSRU5ghuKqjG--
