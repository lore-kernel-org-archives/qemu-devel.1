Received: from eggs.gnu.org ([2001:4830:134:3::10]:51249)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <n54@gmx.com>)
	id 1dDB59-0006OY-OM
	for qemu-devel@nongnu.org; Tue, 23 May 2017 10:46:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <n54@gmx.com>) id 1dDB56-0006Xt-I3
	for qemu-devel@nongnu.org; Tue, 23 May 2017 10:46:43 -0400
Received: from mout.gmx.net ([212.227.17.21]:57243)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <n54@gmx.com>) id 1dDB56-0006XL-5C
	for qemu-devel@nongnu.org; Tue, 23 May 2017 10:46:40 -0400
References: <20170514051820.15985-1-n54@gmx.com>
	<ccaec2d6-49d5-045a-219d-9d6e5deb6c79@amsat.org>
From: Kamil Rytarowski <n54@gmx.com>
Message-ID: <c7b62d04-8216-845e-9761-556811628b86@gmx.com>
Date: Tue, 23 May 2017 16:38:27 +0200
MIME-Version: 1.0
In-Reply-To: <ccaec2d6-49d5-045a-219d-9d6e5deb6c79@amsat.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Nk32vvt3fhFAxpjvgwk3OmULgBjoBbLCh"
Subject: Re: [Qemu-devel] [PATCH] libvixl: Correct build failures on NetBSD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, claudio.fontana@gmail.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Nk32vvt3fhFAxpjvgwk3OmULgBjoBbLCh
From: Kamil Rytarowski <n54@gmx.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, claudio.fontana@gmail.com
Message-ID: <c7b62d04-8216-845e-9761-556811628b86@gmx.com>
Subject: Re: [Qemu-devel] [PATCH] libvixl: Correct build failures on NetBSD
References: <20170514051820.15985-1-n54@gmx.com>
 <ccaec2d6-49d5-045a-219d-9d6e5deb6c79@amsat.org>
In-Reply-To: <ccaec2d6-49d5-045a-219d-9d6e5deb6c79@amsat.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Can we please merge it with master?

On 14.05.2017 07:41, Philippe Mathieu-Daud=E9 wrote:
> On 05/14/2017 02:18 AM, Kamil Rytarowski wrote:
>> Ensure that C99 macros are defined regardless of the inclusion order o=
f
>> headers in vixl. This is required at least on NetBSD.
>>
>> The vixl/globals.h headers defines __STDC_CONSTANT_MACROS and must be
>> included before other system headers.
>>
>> This file defines unconditionally the following macros, without alteri=
ng
>> the original sources:
>>  - __STDC_CONSTANT_MACROS
>>  - __STDC_LIMIT_MACROS
>>  - __STDC_FORMAT_MACROS
>>
>> Signed-off-by: Kamil Rytarowski <n54@gmx.com>
>=20
> Reviewed-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
>=20
>> ---
>>  disas/libvixl/Makefile.objs | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/disas/libvixl/Makefile.objs b/disas/libvixl/Makefile.objs=

>> index bbe7695fdb..860fb7f384 100644
>> --- a/disas/libvixl/Makefile.objs
>> +++ b/disas/libvixl/Makefile.objs
>> @@ -7,5 +7,8 @@ libvixl_OBJS =3D vixl/utils.o \
>>  # The -Wno-sign-compare is needed only for gcc 4.6, which complains
>> about
>>  # some signed-unsigned equality comparisons which later gcc versions
>> do not.
>>  $(addprefix $(obj)/,$(libvixl_OBJS)): QEMU_CFLAGS :=3D
>> -I$(SRC_PATH)/disas/libvixl $(QEMU_CFLAGS) -Wno-sign-compare
>> +# Ensure that C99 macros are defined regardless of the inclusion
>> order of
>> +# headers in vixl. This is required at least on NetBSD.
>> +$(addprefix $(obj)/,$(libvixl_OBJS)): QEMU_CFLAGS +=3D
>> -D__STDC_CONSTANT_MACROS -D__STDC_LIMIT_MACROS -D__STDC_FORMAT_MACROS
>>
>>  common-obj-$(CONFIG_ARM_A64_DIS) +=3D $(libvixl_OBJS)
>>
>=20



--Nk32vvt3fhFAxpjvgwk3OmULgBjoBbLCh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZJEljAAoJEEuzCOmwLnZsv34QAJQVbyIFNG/bR68Yc1KK1IBx
ts9/cM2Jm+DDLrlBHPmWurpiRj0Mg9j7rZ4BkQhnlYoZcr+/VilvGNMI381WMXfP
kJKu8/5NOVq4+QY1/ySlbnLSqaX7oObThrvEJ5nzle8bIbtQo+fh1U9tFtExsSLk
yDuFHO7WA/MYTnpB46PvYlLNqcrJHSU0ajtYQWUBIwviaDMN9nusln+W0pH6+Eqq
LJo3XpVVoqP4usmasdOa0OZUXyCobR7LHqF03CMuz3zbFeh3G6F8J6/vZZA7i33N
/c+HyZxw7k5FocwbrAQBzi3RfvAKI6qWwn9MkSjCVYvZa87jK3ZGBYxzqYUo54Ft
nBGxawATsh9lUKcJeuRzH7HtHitv+y6F6DnhiWtFR3nH7kdfTJ+VwFtgvVRz6VER
zIJdeilVqUjl5YxOfb16PbR2rPN3DjSlZpB3p95WbrxW41532//VqhfFQxjsQels
iOVKV7w/wUi9WPsWSsZTNjxmoKr+x4b0pjCu1vb3ikUpk9e8Dd+VVbZsl2AdLMX5
yvkLOe/ZK+LMHk9k1eKaV1ThKx8B7Kr5HFxeuUdRt3x2ldiK0VY8IN8wmcwO/ojR
L1TGAvSsislUgYZeHu3QF4azCS960cCi/dyPFQkGXICLc0DW4suaLOloo4p0yK5m
Xh0W4PZa3Lo8JuTsFy6C
=IOws
-----END PGP SIGNATURE-----

--Nk32vvt3fhFAxpjvgwk3OmULgBjoBbLCh--
