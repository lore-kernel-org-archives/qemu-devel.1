Received: from eggs.gnu.org ([2001:4830:134:3::10]:42177)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dQlxd-0004iZ-GW
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 22:47:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dQlxc-00058u-FG
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 22:47:09 -0400
References: <20170621133023.27627-1-mreitz@redhat.com>
	<20170621133023.27627-2-mreitz@redhat.com>
	<748b90f3-8f89-59ea-4a65-69e938747c0b@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <6179c9e2-5486-0ff6-927d-da144c178e93@redhat.com>
Date: Fri, 30 Jun 2017 04:46:59 +0200
MIME-Version: 1.0
In-Reply-To: <748b90f3-8f89-59ea-4a65-69e938747c0b@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="O0djKLAI9fUFrIK11WfnxbWUGLXCQ48Is"
Subject: Re: [Qemu-devel] [PATCH v4 1/2] iotests: Use absolute paths for
 executables
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--O0djKLAI9fUFrIK11WfnxbWUGLXCQ48Is
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Message-ID: <6179c9e2-5486-0ff6-927d-da144c178e93@redhat.com>
Subject: Re: [PATCH v4 1/2] iotests: Use absolute paths for executables
References: <20170621133023.27627-1-mreitz@redhat.com>
 <20170621133023.27627-2-mreitz@redhat.com>
 <748b90f3-8f89-59ea-4a65-69e938747c0b@redhat.com>
In-Reply-To: <748b90f3-8f89-59ea-4a65-69e938747c0b@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-06-29 20:52, Eric Blake wrote:
> On 06/21/2017 08:30 AM, Max Reitz wrote:
>> A user may specify a relative path for accessing qemu, qemu-img, etc.
>> through environment variables ($QEMU_PROG and friends) or a symlink.
>>
>> If a test decides to change its working directory, relative paths will=

>> cease to work, however. Work around this by making all of the paths to=

>> programs that should undergo testing absolute. Besides "realpath", we
>> also have to use "which" to support programs in $PATH.
>=20
> Is this sentence stale...

Gnarf. Sure is, yes. Thanks for spotting!

>> As a side effect, this fixes specifying these programs as symlinks for=

>> out-of-tree builds: Before, you would have to create two symlinks, one=

>> in the build and one in the source tree (the first one for common.conf=
ig
>> to find, the second one for the iotest to use). Now it is sufficient t=
o
>> create one in the build tree because common.config will resolve it.
>>
>> Reported-by: Kevin Wolf <kwolf@redhat.com>
>> Reviewed-by: Eric Blake <eblake@redhat.com>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>>  tests/qemu-iotests/common.config | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/tests/qemu-iotests/common.config b/tests/qemu-iotests/com=
mon.config
>> index d1b45f5..c1dc425 100644
>> --- a/tests/qemu-iotests/common.config
>> +++ b/tests/qemu-iotests/common.config
>> @@ -103,6 +103,12 @@ if [ -z "$QEMU_VXHS_PROG" ]; then
>>      export QEMU_VXHS_PROG=3D"`set_prog_path qnio_server`"
>>  fi
>> =20
>> +export QEMU_PROG=3D$(realpath -- "$(type -p "$QEMU_PROG")")
>=20
> ...now that you updated per my review to favor 'type' over 'which'?
> Otherwise, the R-b stands.

Thanks, will fix and apply then...

=2E..and done, applied to my block branch:

https://github.com/XanClic/qemu/commits/block

Max


--O0djKLAI9fUFrIK11WfnxbWUGLXCQ48Is
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEvBAEBCAAZBQJZVbujEhxtcmVpdHpAcmVkaGF0LmNvbQAKCRD0B9sAYdXPQCKD
CACDbZn2m1+EFxq8lrhZU9wCzlxK7kFUIPDHcrvHz526SxoKb0aKq3ues06aeEOw
bFL+c/m55tbNb4J5WVqsBuZZYaSisrRWSEzXTC2EvedaYbJ6vc5vsyc98gJNjP5Y
g2RkBJJCblbGqXDUKVNfYQ4mgOtGoPmHUaEUxvscn1PMOyq0FewN/ydSMKGU2P5D
DbZWTIQrweRf2UOVj2yYdpnMGmYWRUn3agv+LdTlAOaLYKeJN473O7GvbKMnmPev
ZzjCbKEtl0QZGKBNCf7g9mTE/RJSN6WIoxME4O2slQo5AkwuPilLQH4j7XwPdg4X
w5iYZG6sw0/m6Ojy2N1K3JSS
=Acbp
-----END PGP SIGNATURE-----

--O0djKLAI9fUFrIK11WfnxbWUGLXCQ48Is--
