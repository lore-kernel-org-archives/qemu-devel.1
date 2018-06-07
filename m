Received: from eggs.gnu.org ([2001:4830:134:3::10]:56806)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fR07u-0004iG-DU
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 14:59:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fR07t-00073r-Ig
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 14:59:14 -0400
References: <152838802373.447.10153412907099065793@d39dc562802a>
	<81cb1d4e-c50a-fb3b-5fef-eec378296868@tuxera.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <a5e7f77f-d67c-67cf-6093-a73864734750@redhat.com>
Date: Thu, 7 Jun 2018 13:59:02 -0500
MIME-Version: 1.0
In-Reply-To: <81cb1d4e-c50a-fb3b-5fef-eec378296868@tuxera.com>
Content-Type: text/plain; charset=utf-8; format=flowed
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
To: Ari Sundholm <ari@tuxera.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, qemu-block@nongnu.org, mreitz@redhat.com

On 06/07/2018 01:28 PM, Ari Sundholm wrote:
> On 06/07/2018 07:13 PM, no-reply@patchew.org wrote:
>> Hi,
>>
>> This series failed build test on s390x host. Please find the details=20
>> below.
>>

>> /var/tmp/patchew-tester-tmp-8bz4jnox/src/block/blklogwrites.c: In=20
>> function =E2=80=98blk_log_writes_refresh_filename=E2=80=99:
>> /var/tmp/patchew-tester-tmp-8bz4jnox/src/block/blklogwrites.c:136:32:=20
>> error: =E2=80=98%s=E2=80=99 directive output may be truncated writing =
up to 4095 bytes=20
>> into a region of size 4083 [-Werror=3Dformat-truncation=3D]
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "blklogwrites:%s:%s",
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^~
>> In file included from /usr/include/stdio.h:939:0,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 from=20
>> /var/tmp/patchew-tester-tmp-8bz4jnox/src/include/qemu/osdep.h:68,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 from=20
>> /var/tmp/patchew-tester-tmp-8bz4jnox/src/block/blklogwrites.c:12:
>> /usr/include/bits/stdio2.h:64:10: note: =E2=80=98__builtin___snprintf_=
chk=E2=80=99=20
>> output between 15 and 8205 bytes into a destination of size 4096
>> =C2=A0=C2=A0=C2=A0 return __builtin___snprintf_chk (__s, __n, __USE_FO=
RTIFY_LEVEL - 1,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^~~~~~~~~=
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __bos (__s), __fmt, _=
_va_arg_pack ());
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~~~~~~~~~
>> cc1: all warnings being treated as errors
>> make: *** [/var/tmp/patchew-tester-tmp-8bz4jnox/src/rules.mak:69:=20
>> block/blklogwrites.o] Error 1
>> make: *** Waiting for unfinished jobs....
>> =C2=A0=C2=A0 CC=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 block/qapi.o
>> =3D=3D=3D OUTPUT END =3D=3D=3D
>>
>> Test command exited with code: 2
>>
>=20
> Given that blkverify.c has a similar snprintf() call, with the exceptio=
n=20
> that it checks the return value in case the string was truncated, am I=20
> safe in assuming that adding a check for the return value of snprintf()=
=20
> fixes this one? I don't really see anything else I could do about the=20
> error.

Well, ideally we'd g_strdup_printf() the string (and g_free() it later)=20
rather than use a fixed-size array, if we HAVE to produce a=20
legacy-format name in the first place.  But if we stick with a=20
fixed-width buffer, perhaps checking for snprintf() truncation, and=20
returning NULL in that case, is enough to force a fallback to a=20
pseudo-JSON string so that the end user doesn't lose information and the=20
compiler doesn't complain about failure to check for truncation.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
