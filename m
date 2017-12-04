Received: from eggs.gnu.org ([2001:4830:134:3::10]:41578)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eLs4s-00012G-U1
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 09:50:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eLs4p-000668-L7
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 09:50:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39006)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1eLs4p-00064p-Ap
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 09:50:35 -0500
References: <20171116223527.4499-1-danielhb@linux.vnet.ibm.com>
	<20171116223527.4499-3-danielhb@linux.vnet.ibm.com>
	<6892975f-87d7-a348-ce21-739fdff4b25e@redhat.com>
	<86ab3a7c-bb8c-5dc6-8f26-995bcf07ef0a@linux.vnet.ibm.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <cfa46ea3-ab0e-d794-cebe-5a6e9fa9a626@redhat.com>
Date: Mon, 4 Dec 2017 15:50:29 +0100
MIME-Version: 1.0
In-Reply-To: <86ab3a7c-bb8c-5dc6-8f26-995bcf07ef0a@linux.vnet.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="4woecJtb4lR08A92wjeC82Rv06jOo7T2R"
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
Cc: Kevin Wolf <kwolf@redhat.com>, Cleber Rosa <crosa@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--4woecJtb4lR08A92wjeC82Rv06jOo7T2R
From: Max Reitz <mreitz@redhat.com>
To: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>,
 qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Cleber Rosa <crosa@redhat.com>
Message-ID: <cfa46ea3-ab0e-d794-cebe-5a6e9fa9a626@redhat.com>
Subject: Re: [PATCH v3 2/2] tests/qemu-iotests: adding savevm/loadvm with
 postcopy flag test
References: <20171116223527.4499-1-danielhb@linux.vnet.ibm.com>
 <20171116223527.4499-3-danielhb@linux.vnet.ibm.com>
 <6892975f-87d7-a348-ce21-739fdff4b25e@redhat.com>
 <86ab3a7c-bb8c-5dc6-8f26-995bcf07ef0a@linux.vnet.ibm.com>
In-Reply-To: <86ab3a7c-bb8c-5dc6-8f26-995bcf07ef0a@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-12-03 21:13, Daniel Henrique Barboza wrote:
> Hi Max,
>=20
> On 12/01/2017 06:13 PM, Max Reitz wrote:
>> On 2017-11-16 23:35, Daniel Henrique Barboza wrote:
>>> This patch implements a test case for the scenario that was failing
>>> prior to the patch "migration/ram.c: do not set 'postcopy_running' in=

>>> POSTCOPY_INCOMING_END".
>>>
>>> This new test file 198 was derived from the test file 181 authored
>>> by Kevin Wolf.
>>>
>>> CC: Kevin Wolf <kwolf@redhat.com>
>>> CC: Max Reitz <mreitz@redhat.com>
>>> CC: Cleber Rosa <crosa@redhat.com>
>>> Signed-off-by: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
>>>
>>> ---
>>> I CCed Cleber Rosa because this patch was developed at the same
>>> time his patch series "[PATCH 00/10] I/O tests cleanups" hit the
>>> mailing list. Most of the cleanups/fixes he made in the series was
>>> done in this new test as well.
>>>
>>>  tests/qemu-iotests/198     | 110 +++++++++++++++++++++++++++++++++++=
++++++++++
>>>  tests/qemu-iotests/198.out |  20 +++++++++
>>>  tests/qemu-iotests/group   |   1 +
>>>  3 files changed, 131 insertions(+)
>>>  create mode 100755 tests/qemu-iotests/198
>>>  create mode 100644 tests/qemu-iotests/198.out
>> Looks good overall, just two nitpicks below.
>>
>>> diff --git a/tests/qemu-iotests/198 b/tests/qemu-iotests/198
>>> new file mode 100755
>>> index 0000000000..786e37fc95
>>> --- /dev/null
>>> +++ b/tests/qemu-iotests/198
>>> @@ -0,0 +1,110 @@
>>> +#!/bin/bash
>>> +#
>>> +# Test savevm and loadvm after live migration with postcopy flag
>>> +#
>>> +# Copyright (C) 2017, IBM Corporation.
>>> +#
>>> +# This file is derived from tests/qemu-iotests/181 by Kevin Wolf
>>> +#
>>> +# This program is free software; you can redistribute it and/or modi=
fy
>>> +# it under the terms of the GNU General Public License as published =
by
>>> +# the Free Software Foundation; either version 2 of the License, or
>>> +# (at your option) any later version.
>>> +#
>>> +# This program is distributed in the hope that it will be useful,
>>> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
>>> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>>> +# GNU General Public License for more details.
>>> +#
>>> +# You should have received a copy of the GNU General Public License
>>> +# along with this program.  If not, see <http://www.gnu.org/licenses=
/>.
>>> +#
>>> +# Creator/Owner : danielhb@linux.vnet.ibm.com
>>> +
>>> +seq=3D`basename $0`
>>> +echo "QA output created by $seq"
>>> +
>>> +status=3D1	# failure is the default!
>>> +
>>> +MIG_SOCKET=3D"${TEST_DIR}/migrate"
>>> +
>>> +# get standard environment, filters and checks
>>> +. ./common.rc
>>> +. ./common.filter
>>> +. ./common.qemu
>>> +
>>> +_cleanup()
>>> +{
>>> +    rm -f "${MIG_SOCKET}"
>>> +    _cleanup_test_img
>>> +    _cleanup_qemu
>>> +}
>>> +trap "_cleanup; exit \$status" 0 1 2 3 15
>>> +
>>> +_supported_fmt qcow2
>>> +_supported_proto generic
>>> +_supported_os Linux
>>> +
>>> +size=3D64M
>>> +_make_test_img $size
>>> +
>>> +echo
>>> +echo =3D=3D=3D Starting VMs =3D=3D=3D
>>> +echo
>>> +
>>> +qemu_comm_method=3D"monitor"
>>> +
>>> +if [ "$IMGOPTSSYNTAX" =3D "true" ]; then
>>> +    _launch_qemu \
>>> +        -drive "${TEST_IMG}",cache=3D${CACHEMODE},id=3Ddisk
>>> +else
>>> +    _launch_qemu \
>>> +        -drive file=3D"${TEST_IMG}",cache=3D${CACHEMODE},driver=3D$I=
MGFMT,id=3Ddisk
>>> +fi
>>> +src=3D$QEMU_HANDLE
>>> +
>>> +if [ "$IMGOPTSSYNTAX" =3D "true" ]; then
>>> +    _launch_qemu \
>>> +        -drive "${TEST_IMG}",cache=3D${CACHEMODE},id=3Ddisk \
>>> +        -incoming "unix:${MIG_SOCKET}"
>>> +else
>>> +    _launch_qemu \
>>> +        -drive file=3D"${TEST_IMG}",cache=3D${CACHEMODE},driver=3D$I=
MGFMT,id=3Ddisk \
>>> +        -incoming "unix:${MIG_SOCKET}"
>>> +fi
>>> +dest=3D$QEMU_HANDLE
>>> +
>>> +echo
>>> +echo =3D=3D=3D Set \'migrate_set_capability postcopy-ram on\' and mi=
grate =3D=3D=3D
>>> +echo
>>> +
>>> +silent=3Dyes
>>> +_send_qemu_cmd $dest 'migrate_set_capability postcopy-ram on' "(qemu=
)"
>>> +_send_qemu_cmd $src 'migrate_set_capability postcopy-ram on' "(qemu)=
"
>>> +_send_qemu_cmd $src "migrate -d unix:${MIG_SOCKET}" "(qemu)"
>>> +
>>> +QEMU_COMM_TIMEOUT=3D1 qemu_cmd_repeat=3D10 silent=3Dyes \
>>> +    _send_qemu_cmd $src "info migrate" "completed\|failed"
>>> +silent=3Dyes _send_qemu_cmd $src "" "(qemu)"
>> Would it make sense to query the migration status non-silently here,
>> too, so that the test output would verify that it has actually succeed=
ed?
>>
>> (I suppose the savevm/loadvm coming up next would fail if the migratio=
n
>> failed, but maybe if it's easy enough...)
>=20
> Not exactly non-silently, but we can do something like this:
>=20
>=20
> echo
> echo =3D=3D=3D Check if migration was successful =3D=3D=3D
> echo
>=20
> QEMU_COMM_TIMEOUT=3D1 silent=3Dyes \
> =C2=A0=C2=A0=C2=A0 _send_qemu_cmd $src "info migrate" "completed"
> silent=3Dyes _send_qemu_cmd $src "" "(qemu)"
>=20
>=20
> If migration failed, the test will fail with timeout error waiting for
> "completed"
> prior to savevm. What do you think?

Sounds good.  Shouldn't you keep the qemu_cmd_repeat=3D10, though?

Max


--4woecJtb4lR08A92wjeC82Rv06jOo7T2R
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlolYLUSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AI7YH/itKlD85zefQiQTXhR+J/42jBR6f70Jw
cU/plZDwIU29ptCl3g7iNLCnbP3b4/pY2+V8W+8kXfycAaomfpZ7HlhRB9wHSzrL
kDTXwlKgi9ZZr2G6botibhx2EnUct+FbNhmUw6SXTiXr4ucT7PvjgiXoXjzr60hD
HF0WXzZF9gAHuZnooKH+txTf8chdulg80477juFaDlxImk5H9Nrzob+BmVZmNuoq
D6QMQ4CGhYXRWJN8e/fKqDhGcRKPSH8IXAPzt52DyAo06nnjoZpHDoDJFPoU01f6
McI4EwrrGGTFIToCvA52K/B55b0GaQEmKCV60snPkR2Mkf56kVWJgoM=
=vE/W
-----END PGP SIGNATURE-----

--4woecJtb4lR08A92wjeC82Rv06jOo7T2R--
