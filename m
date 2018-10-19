Received: from eggs.gnu.org ([2001:4830:134:3::10]:52169)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gDQmd-0003Jo-Ft
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 05:09:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gDQmW-00033l-CZ
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 05:09:23 -0400
References: <20181015141453.32632-1-mreitz@redhat.com>
	<6be3d69f-1bb4-04c2-c1af-9afb8122753d@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <329e9dc5-03ea-575f-63b8-96a8bd8562eb@redhat.com>
Date: Fri, 19 Oct 2018 11:08:54 +0200
MIME-Version: 1.0
In-Reply-To: <6be3d69f-1bb4-04c2-c1af-9afb8122753d@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="raUhQCE1mChUX5qjGLZ1c5t2M8fIoTzk8"
Subject: Re: [Qemu-devel] [PATCH 0/9] iotests: Make them work for both
 Python 2 and 3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Cleber Rosa <crosa@redhat.com>, qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--raUhQCE1mChUX5qjGLZ1c5t2M8fIoTzk8
From: Max Reitz <mreitz@redhat.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <329e9dc5-03ea-575f-63b8-96a8bd8562eb@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 0/9] iotests: Make them work for both Python
 2 and 3
References: <20181015141453.32632-1-mreitz@redhat.com>
 <6be3d69f-1bb4-04c2-c1af-9afb8122753d@redhat.com>
In-Reply-To: <6be3d69f-1bb4-04c2-c1af-9afb8122753d@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 16.10.18 00:19, Philippe Mathieu-Daud=C3=A9 wrote:
> Hi Max,
>=20
> On 15/10/2018 16:14, Max Reitz wrote:
>> This series prepares the iotests to work with both Python 2 and 3.  In=

>> some places, it adds version-specific code and decides what to do base=
d
>> on the version (for instance, whether to import the StringIO class fro=
m
>> the 'io' or the 'StringIO' module), but most of the time, it just make=
s
>> code work for both versions in general.
>>
>> And when we make the switch to make Python 3 mandatory, we can simply
>> drop the Python 2 branches.
>>
>>
>> Max Reitz (9):
>>   iotests: Make nbd-fault-injector flush
>>   iotests: Flush in iotests.py's QemuIoInteractive
>>   iotests: Use Python byte strings where appropriate
>>   iotests: Use // for Python integer division
>>   iotests: Different iterator behavior in Python 3
>>   iotests: Explicitly inherit FDs in Python
>>   iotests: 'new' module replacement in 169
>>   iotests: Modify imports for Python 3
>>   iotests: Unify log outputs between Python 2 and 3
>=20
> You forgot:
>=20
>     MAINTAINERS: Add myself in the Python scripts section
>=20
> ;)

Aw, please, no.  You do know I don't really know Python? ;-)

Max


--raUhQCE1mChUX5qjGLZ1c5t2M8fIoTzk8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlvJnyYACgkQ9AfbAGHV
z0C1Pgf+LhIVCMh2kmn3JZGcCkAISD4y4ULMMr0SmNJLzRTc9Oqkns2WADA+IkG5
att2g1bTVTwBasP7Cl/jP22Wzpjy5aLq8aya3HuLuDmH33mhEzS+Rkqye/WxoZgO
cH8bBya2ffLjaHGs/vY9byyCWO8PwSY+aXRo/Vmv+7oD2HyvR6GWig6rbTD1JHhG
OSz6M1TcX/xblQhbBFGKTr5B7QhhU1hNrtEA5eg4mnLw8EYO82mEwz8aEFOEoJbl
05zWjAe3TyVmZDyci3j4ZUAe4tI6ORHFMPE0wI5fqiauc6YFjjwS7ZopJThtaLWD
iX51i9Msz+QNV0ymoVA6ayUuKvVN2w==
=+GQk
-----END PGP SIGNATURE-----

--raUhQCE1mChUX5qjGLZ1c5t2M8fIoTzk8--
