Received: from eggs.gnu.org ([2001:4830:134:3::10]:45900)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1eFgUl-0008Cj-3l
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 08:15:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1eFgUj-0001S9-Q7
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 08:15:47 -0500
References: <20171116173810.16457-1-crosa@redhat.com>
	<20171116173810.16457-2-crosa@redhat.com>
	<a5c42ab2-f384-4768-6e07-30814789ef5c@redhat.com>
From: Cleber Rosa <crosa@redhat.com>
Message-ID: <efb77a22-77c4-9671-744e-5713ae727959@redhat.com>
Date: Fri, 17 Nov 2017 08:15:33 -0500
MIME-Version: 1.0
In-Reply-To: <a5c42ab2-f384-4768-6e07-30814789ef5c@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="CXqRk0tDkEtsRjxXbU5MNcPqQ7KakWoNg"
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 01/10] qemu-iotests: make
 execution of tests agnostic to test type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--CXqRk0tDkEtsRjxXbU5MNcPqQ7KakWoNg
From: Cleber Rosa <crosa@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Message-ID: <efb77a22-77c4-9671-744e-5713ae727959@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 01/10] qemu-iotests: make
 execution of tests agnostic to test type
References: <20171116173810.16457-1-crosa@redhat.com>
 <20171116173810.16457-2-crosa@redhat.com>
 <a5c42ab2-f384-4768-6e07-30814789ef5c@redhat.com>
In-Reply-To: <a5c42ab2-f384-4768-6e07-30814789ef5c@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 11/17/2017 02:25 AM, Paolo Bonzini wrote:
> On 16/11/2017 18:38, Cleber Rosa wrote:
>> check makes a distinction on how it runs Python based tests.  The
>> current approach is inconsistent because:
>>
>> 1) a large number of Python tests are already set as executable files
>> (eg: 030, 040, 041, 044, 045, 055, 056, 057, 065, 093, 118, 147, 149,
>> 155, 165 and 194)
>>
>> 2) a smaller number of Python tests are not set as executable files
>>
>> 3) the true purpose of a shebang line is to make a file executable,
>> while it currently is used (inconsistently) as a test type flag
>>
>> 4) the same logic could in theory be applied to shell based tests,
>> that is, if first line contains a shell shebang, run it with
>> "$SHELL $test_file", but it'd be pointless
>>
>> IMO, there's no value in the distinction that check makes.  Dropping
>> this distinction makes the interface simpler: check requires an
>> executable file.
>>
>> Signed-off-by: Cleber Rosa <crosa@redhat.com>
>=20
> This is quirky, but I think it makes sense to obey the configure
> script's chosen Python interpreter.  Unlike /bin/sh or /bin/bash, there=

> can be many Python interpreters on a system and the user may not want
> the one in /usr/bin/python (think of old RHEL with software collections=
,
> even though our use of Python is generally portable to older versions).=

>=20

Yes, that's a valid point.  Looking at it closer, we usually get "python
-B" from configure, so this changes the behavior (can plague the
developer box with .pyc files).

> I'd keep it for now; in the longer term, we should set up a virtual
> environment so that the shebang line does the right thing.
>=20

Agreed.

> However, making files executable is certainly a good idea.
>=20
> Thanks,
>=20
> Paolo
>=20

Thanks for the review,
- Cleber.

>=20
>> ---
>>  tests/qemu-iotests/096   | 0
>>  tests/qemu-iotests/124   | 0
>>  tests/qemu-iotests/129   | 0
>>  tests/qemu-iotests/132   | 0
>>  tests/qemu-iotests/136   | 0
>>  tests/qemu-iotests/139   | 0
>>  tests/qemu-iotests/148   | 0
>>  tests/qemu-iotests/152   | 0
>>  tests/qemu-iotests/163   | 0
>>  tests/qemu-iotests/check | 9 ++-------
>>  10 files changed, 2 insertions(+), 7 deletions(-)
>>  mode change 100644 =3D> 100755 tests/qemu-iotests/096
>>  mode change 100644 =3D> 100755 tests/qemu-iotests/124
>>  mode change 100644 =3D> 100755 tests/qemu-iotests/129
>>  mode change 100644 =3D> 100755 tests/qemu-iotests/132
>>  mode change 100644 =3D> 100755 tests/qemu-iotests/136
>>  mode change 100644 =3D> 100755 tests/qemu-iotests/139
>>  mode change 100644 =3D> 100755 tests/qemu-iotests/148
>>  mode change 100644 =3D> 100755 tests/qemu-iotests/152
>>  mode change 100644 =3D> 100755 tests/qemu-iotests/163
>>
>> diff --git a/tests/qemu-iotests/096 b/tests/qemu-iotests/096
>> old mode 100644
>> new mode 100755
>> diff --git a/tests/qemu-iotests/124 b/tests/qemu-iotests/124
>> old mode 100644
>> new mode 100755
>> diff --git a/tests/qemu-iotests/129 b/tests/qemu-iotests/129
>> old mode 100644
>> new mode 100755
>> diff --git a/tests/qemu-iotests/132 b/tests/qemu-iotests/132
>> old mode 100644
>> new mode 100755
>> diff --git a/tests/qemu-iotests/136 b/tests/qemu-iotests/136
>> old mode 100644
>> new mode 100755
>> diff --git a/tests/qemu-iotests/139 b/tests/qemu-iotests/139
>> old mode 100644
>> new mode 100755
>> diff --git a/tests/qemu-iotests/148 b/tests/qemu-iotests/148
>> old mode 100644
>> new mode 100755
>> diff --git a/tests/qemu-iotests/152 b/tests/qemu-iotests/152
>> old mode 100644
>> new mode 100755
>> diff --git a/tests/qemu-iotests/163 b/tests/qemu-iotests/163
>> old mode 100644
>> new mode 100755
>> diff --git a/tests/qemu-iotests/check b/tests/qemu-iotests/check
>> index e6b6ff7a04..08741328d0 100755
>> --- a/tests/qemu-iotests/check
>> +++ b/tests/qemu-iotests/check
>> @@ -741,20 +741,15 @@ do
>>          start=3D`_wallclock`
>>          $timestamp && printf %s "        [$(date "+%T")]"
>> =20
>> -        if [ "$(head -n 1 "$source_iotests/$seq")" =3D=3D "#!/usr/bin=
/env python" ]; then
>> -            run_command=3D"$PYTHON $seq"
>> -        else
>> -            run_command=3D"./$seq"
>> -        fi
>>          export OUTPUT_DIR=3D$PWD
>>          if $debug; then
>>              (cd "$source_iotests";
>>              MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(($RANDOM % 255 + 1=
))} \
>> -                    $run_command -d 2>&1 | tee $tmp.out)
>> +                    ./$seq -d 2>&1 | tee $tmp.out)
>>          else
>>              (cd "$source_iotests";
>>              MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(($RANDOM % 255 + 1=
))} \
>> -                    $run_command >$tmp.out 2>&1)
>> +                    ./$seq >$tmp.out 2>&1)
>>          fi
>>          sts=3D$?
>>          $timestamp && _timestamp
>>
>=20
>=20


--CXqRk0tDkEtsRjxXbU5MNcPqQ7KakWoNg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAloO4PgACgkQZX6NM6Xy
CfO9JhAAu4HOePrW7LClKazUkHQ2PnLt9ujPBd7Hon5T5wAW9LlLtFqVdh7ns1tT
x4i24p021WI/5yp12eEiEGF27ZWLYTUskyiuxzoBodrhqqI/5euEZqKap/mukzuC
tkfwyqHgVpEi9buqo1ZYFvRNzc7GByvl4rwNx71B/greoAdjCIR9A8ldsRU6eSu0
NmpmZo400v3x2Yz4pyRzuEBTvgycfRbhNN6nAjJ8aK7cU+nBgY750NMdfMjtGuuw
XQIbPsodkWk6Wsf4IKwHZPyEy7y7YjH/bk5dNMSqNZ6oXKv1nYUM7vt1ai8eQKj+
PPOTkrhN5rxFKtI+v/rkYUvQlcYJ6I3gSBFMx16U+CzwUEODKfHI1dWhNMyAi9CA
t1uFT2YxzSsXxO6Cl9QvFAA8V7Xb6UQ0riMbspCzJLJ9IfmurxxbIXr9ej5RUEc8
ICmvBN1RZSC5pPiCWLFwG0XLSupagjeDwsRMoK+9lwJD8I7YW2TYlKXkyex3k3wQ
ehJp1IF6CAYznGEVQM+T8SVTLTAzhx/9ZNBSLkfkSRtSwWZnAiBZaleh0XT8M42k
n+7TAqAAyRy9IGUt/MN0vtDR4kYPEuQ7OZBjEJ3zYgQiBrXV5LX18i8GJZMIdeHE
jBdGP4VrpZJ59lH1DgxdRgIbEDMoKona8CqGayxwKc7JFdmkte0=
=6asW
-----END PGP SIGNATURE-----

--CXqRk0tDkEtsRjxXbU5MNcPqQ7KakWoNg--
