Received: from eggs.gnu.org ([2001:4830:134:3::10]:60074)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ari@tuxera.com>) id 1fR0OB-0002mA-4f
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 15:16:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ari@tuxera.com>) id 1fR0O9-0000x5-It
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 15:16:02 -0400
References: <152838802373.447.10153412907099065793@d39dc562802a>
	<81cb1d4e-c50a-fb3b-5fef-eec378296868@tuxera.com>
	<a5e7f77f-d67c-67cf-6093-a73864734750@redhat.com>
From: Ari Sundholm <ari@tuxera.com>
Message-ID: <5bc38324-ec54-33f3-e74f-e21f9c026a21@tuxera.com>
Date: Thu, 7 Jun 2018 22:15:51 +0300
MIME-Version: 1.0
In-Reply-To: <a5e7f77f-d67c-67cf-6093-a73864734750@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 00/10] New block driver: blklogwrites
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, qemu-block@nongnu.org, mreitz@redhat.com

On 06/07/2018 09:59 PM, Eric Blake wrote:
> On 06/07/2018 01:28 PM, Ari Sundholm wrote:
>> On 06/07/2018 07:13 PM, no-reply@patchew.org wrote:
>>> Hi,
>>>
>>> This series failed build test on s390x host. Please find the details=20
>>> below.
>>>
>=20
>>> /var/tmp/patchew-tester-tmp-8bz4jnox/src/block/blklogwrites.c: In=20
>>> function =E2=80=98blk_log_writes_refresh_filename=E2=80=99:
>>> /var/tmp/patchew-tester-tmp-8bz4jnox/src/block/blklogwrites.c:136:32:=
=20
>>> error: =E2=80=98%s=E2=80=99 directive output may be truncated writing=
 up to 4095=20
>>> bytes into a region of size 4083 [-Werror=3Dformat-truncation=3D]
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "blklogwrites:%s:%s",
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^~
>>> In file included from /usr/include/stdio.h:939:0,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 from=20
>>> /var/tmp/patchew-tester-tmp-8bz4jnox/src/include/qemu/osdep.h:68,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 from=20
>>> /var/tmp/patchew-tester-tmp-8bz4jnox/src/block/blklogwrites.c:12:
>>> /usr/include/bits/stdio2.h:64:10: note: =E2=80=98__builtin___snprintf=
_chk=E2=80=99=20
>>> output between 15 and 8205 bytes into a destination of size 4096
>>> =C2=A0=C2=A0=C2=A0 return __builtin___snprintf_chk (__s, __n, __USE_F=
ORTIFY_LEVEL - 1,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^~~~~~~~=
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __bos (__s), __fmt, =
__va_arg_pack ());
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~~~~~~~~~~
>>> cc1: all warnings being treated as errors
>>> make: *** [/var/tmp/patchew-tester-tmp-8bz4jnox/src/rules.mak:69:=20
>>> block/blklogwrites.o] Error 1
>>> make: *** Waiting for unfinished jobs....
>>> =C2=A0=C2=A0 CC=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 block/qapi.o
>>> =3D=3D=3D OUTPUT END =3D=3D=3D
>>>
>>> Test command exited with code: 2
>>>
>>
>> Given that blkverify.c has a similar snprintf() call, with the=20
>> exception that it checks the return value in case the string was=20
>> truncated, am I safe in assuming that adding a check for the return=20
>> value of snprintf() fixes this one? I don't really see anything else I=
=20
>> could do about the error.
>=20
> Well, ideally we'd g_strdup_printf() the string (and g_free() it later)=
=20
> rather than use a fixed-size array, if we HAVE to produce a=20
> legacy-format name in the first place.=C2=A0 But if we stick with a=20
> fixed-width buffer, perhaps checking for snprintf() truncation, and=20
> returning NULL in that case, is enough to force a fallback to a=20
> pseudo-JSON string so that the end user doesn't lose information and th=
e=20
> compiler doesn't complain about failure to check for truncation.
>=20

The question of whether we should generate the filename at all is=20
something I've been wondering about. If we do generate it,=20
bs->exact_filename having a fixed length is something we can't (easily)=20
do anything about. The .bdrv_refresh_filename callback returns void, so=20
there isn't really a way to tell the caller about the truncation if it=20
does happen.

I think that, for now, I will fix the code to handle this part like=20
blkverify does: check for truncation and make the filename an empty=20
string if that happened. If we want to replace this with something like=20
just a bs->exact_filename[0] =3D '\0' without even trying to construct a=20
filename, that is something that can be done in a later version if we're=20
unsure now.

Thanks,
Ari Sundholm
ari@tuxera.com
