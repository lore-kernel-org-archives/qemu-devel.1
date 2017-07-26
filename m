Received: from eggs.gnu.org ([2001:4830:134:3::10]:47793)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1daQ33-0003EM-Hr
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 13:24:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1daQ30-0006OG-E5
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 13:24:37 -0400
Received: from mail-it0-x244.google.com ([2607:f8b0:4001:c0b::244]:38615)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1daQ30-0006Ni-8v
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 13:24:34 -0400
Received: by mail-it0-x244.google.com with SMTP id h199so6945972ith.5
	for <qemu-devel@nongnu.org>; Wed, 26 Jul 2017 10:24:34 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
From: Programmingkid <programmingkidx@gmail.com>
In-Reply-To: <bbd9cca3-ffaa-2aba-1bc8-a9f0b0df0bb9@imgtec.com>
Date: Wed, 26 Jul 2017 13:24:32 -0400
Content-Transfer-Encoding: quoted-printable
Message-Id: <0796D7B3-86EA-49E7-A3D3-D6D2E738515C@gmail.com>
References: <65ED9743-B53C-4E6A-866F-C883650914CE@gmail.com>
	<91ba54de-b2eb-f3a9-eb0f-a697b7698149@amsat.org>
	<bbd9cca3-ffaa-2aba-1bc8-a9f0b0df0bb9@imgtec.com>
Subject: Re: [Qemu-devel] hw/core/loader-fit.c:105:41: error: expected
 expression
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yongbok Kim <yongbok.kim@imgtec.com>
Cc: =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, "qemu-devel@nongnu.org qemu-devel" <qemu-devel@nongnu.org>, James Hogan <james.hogan@imgtec.com>, Aurelien Jarno <aurelien@aurel32.net>


> On Jul 26, 2017, at 6:45 AM, Yongbok Kim <yongbok.kim@imgtec.com> =
wrote:
>=20
>=20
>=20
> On 26/07/2017 05:13, Philippe Mathieu-Daud=C3=A9 wrote:
>> Hi John,
>>=20
>> On 07/25/2017 07:55 PM, Programmingkid wrote:
>>> While compiling the mips64el-softmmu target I encountered these =
errors:
>>>=20
>>>   CC      hw/display/g364fb.o
>>> hw/core/loader-fit.c:105:41: error: expected expression
>>>         *addr =3D fdt32_to_cpu(*(fdt32_t *)prop);
>>>                                         ^
>>> hw/core/loader-fit.c:105:32: error: use of undeclared identifier =
'fdt32_t'
>>=20
>> It seems you are missing the libfdt headers, so indeed you found bug.
>>=20
>> Replacing CONFIG_FITLOADER by CONFIG_FDT in hw/core/Makefile.objs and
>> default-configs/mips64el-softmmu.mak should fix it, can you try?
>>=20
>>>         *addr =3D fdt32_to_cpu(*(fdt32_t *)prop);
>>>                                ^
>>> hw/core/loader-fit.c:108:41: error: expected expression
>>>         *addr =3D fdt64_to_cpu(*(fdt64_t *)prop);
>>>                                         ^
>>> hw/core/loader-fit.c:108:32: error: use of undeclared identifier =
'fdt64_t'
>>>         *addr =3D fdt64_to_cpu(*(fdt64_t *)prop);
>>>                                ^
>>> hw/core/loader-fit.c:278:19: warning: implicit declaration of =
function
>>>       'fdt_first_subnode' is invalid in C99
>>> [-Wimplicit-function-declaration]
>>>             off =3D fdt_first_subnode(itb, configs);
>>>                   ^
>>> hw/core/loader-fit.c:286:23: warning: implicit declaration of =
function
>>>       'fdt_next_subnode' is invalid in C99
>>> [-Wimplicit-function-declaration]
>>>                 off =3D fdt_next_subnode(itb, off);
>>>                       ^
>>> 2 warnings and 4 errors generated.
>>> make: *** [hw/core/loader-fit.o] Error 1
>>> make: *** Waiting for unfinished jobs=E2=80=A6.
>>=20
>> It'd be useful if next time you also tell which compiler/version are =
you
>> using.
>>=20
>>> Steps to reproduce the error:
>>> ./configure --target-list=3Dmips64el-softmmu && make
>>=20
>> And also the ./configure output, I'm interested by:
>>=20
>> "fdt support       no"
>>=20
>> Regards,
>>=20
>> Phil.
>=20
>=20
>=20
> Hi,
>=20
> As Philippe pointed, it looks like something with dtc(libfdt).
> Could you also try to install DTC into your QEMU source base?
> By default for mips64el-softmmu, if DTC is not compatible you should =
get
> this message.
>=20
> ERROR: DTC (libfdt) version >=3D 1.4.2 not present. Your options:
>         (1) Preferred: Install the DTC (libfdt) devel package
>         (2) Fetch the DTC submodule, using:
>             git submodule update --init dtc
>=20
> Since I am not able to reproduce the problem on my machines,
> please let us know the detail of your system.
>=20
> $ ../master/configure --target-list=3Dmips64el-softmmu && make -j
> ...
>  GEN     trace/generated-helpers.c
>  CC      mips64el-softmmu/trace/control-target.o
>  CC      mips64el-softmmu/trace/generated-helpers.o
>  LINK    mips64el-softmmu/qemu-system-mips64el
>=20
> Regards,
> Yongbok

My host system is Mac OS 10.12. It looks like I was using an older =
version of libfdt.
Updating fixed the problem. Thank you.
