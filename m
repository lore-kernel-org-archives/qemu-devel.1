Received: from eggs.gnu.org ([2001:4830:134:3::10]:60221)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1dl0Xt-0007TF-0c
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 18:24:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1dl0Xo-0004eF-R3
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 18:24:12 -0400
Received: from mail-it0-x242.google.com ([2607:f8b0:4001:c0b::242]:36825)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1dl0Xo-0004eA-Kf
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 18:24:08 -0400
Received: by mail-it0-x242.google.com with SMTP id c196so523191itc.3
	for <qemu-devel@nongnu.org>; Thu, 24 Aug 2017 15:24:08 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
From: Programmingkid <programmingkidx@gmail.com>
In-Reply-To: <0f7c2030-f9dc-1069-cb94-6d42030e8bc7@redhat.com>
Date: Thu, 24 Aug 2017 18:24:06 -0400
Content-Transfer-Encoding: quoted-printable
Message-Id: <DF371398-2160-4F3C-9B12-9A6A2DE286A4@gmail.com>
References: <mailman.3749.1503600836.21955.qemu-devel@nongnu.org>
	<74846968-830E-4239-9DC7-B1252A5AC946@gmail.com>
	<60e13112-931d-a517-ddb1-20c2f2de736e@redhat.com>
	<230513EB-08AB-41E9-97A6-69C646A5D205@gmail.com>
	<0f7c2030-f9dc-1069-cb94-6d42030e8bc7@redhat.com>
Subject: Re: [Qemu-devel] Make test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cleber Rosa <crosa@redhat.com>
Cc: qemu-devel@nongnu.org


> On Aug 24, 2017, at 6:21 PM, Cleber Rosa <crosa@redhat.com> wrote:
>=20
>=20
>=20
> On 08/24/2017 06:18 PM, Programmingkid wrote:
>> After applying the patches I saw this error:
>>=20
>> $ make test
>> make -C tests/tcg test
>>  CC      test_path.o
>>  LINK    test_path
>> ./test_path
>> cc -m32 -nostdlib -Wall -O2 -g -fno-strict-aliasing -static  -o =
hello-i386 hello-i386.c
>> hello-i386.c:1:10: fatal error: 'asm/unistd.h' file not found
>> #include <asm/unistd.h>
>>         ^
>> 1 error generated.
>> make[1]: *** [hello-i386] Error 1
>> make: *** [test] Error 2
>>=20
>=20
> Thanks for testing it.
>=20
>>=20
>> The path to this header file is /usr/include/unistd.h and =
/usr/include/sys/unistd.h on my computer. Maybe you could add this to =
your patches to make them more Mac-friendly:
>>=20
>> #ifdef __MACH__ /* Mach kernel - what's used in Mac OS X */
>> 	#include <unistd.h>
>> #endif
>>=20
>> http://pubs.opengroup.org/onlinepubs/7908799/xsh/unistd.h.html
>> Then again this page states you should be able to do a "#include =
<unistd.h>" on your posix compatible platform.
>>=20
>> Thank you.
>>=20
>=20
> I'll take a look and attempt a more portable fix on a v2.
>=20
> Regards!
>=20
> --=20
> Cleber Rosa
> [ Sr Software Engineer - Virtualization Team - Red Hat ]
> [ Avocado Test Framework - avocado-framework.github.io ]
> [  7ABB 96EB 8B46 B94D 5E0F  E9BB 657E 8D33 A5F2 09F3  ]

Forgot to mention that doing a "#include <unistd.h>" does work on Mac OS =
X. Does this work on your platform?

#include <stdio.h>
#include <unistd.h>

int main(int argc, char *argv[])
{
	printf("version =3D %ld\n", _POSIX_VERSION);
	return 0;
}=
