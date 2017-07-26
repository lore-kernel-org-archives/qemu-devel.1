Received: from eggs.gnu.org ([2001:4830:134:3::10]:50063)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1daJoi-0004At-Pr
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 06:45:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1daJoe-0005AF-Ol
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 06:45:24 -0400
Received: from mailapp01.imgtec.com ([195.59.15.196]:6865)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1daJoe-00057S-Hz
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 06:45:20 -0400
References: <65ED9743-B53C-4E6A-866F-C883650914CE@gmail.com>
	<91ba54de-b2eb-f3a9-eb0f-a697b7698149@amsat.org>
From: Yongbok Kim <yongbok.kim@imgtec.com>
Message-ID: <bbd9cca3-ffaa-2aba-1bc8-a9f0b0df0bb9@imgtec.com>
Date: Wed, 26 Jul 2017 11:45:15 +0100
MIME-Version: 1.0
In-Reply-To: <91ba54de-b2eb-f3a9-eb0f-a697b7698149@amsat.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
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
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Programmingkid <programmingkidx@gmail.com>, "qemu-devel@nongnu.org qemu-devel" <qemu-devel@nongnu.org>
Cc: James Hogan <james.hogan@imgtec.com>, Aurelien Jarno <aurelien@aurel32.net>



On 26/07/2017 05:13, Philippe Mathieu-Daud=C3=A9 wrote:
> Hi John,
>=20
> On 07/25/2017 07:55 PM, Programmingkid wrote:
>> While compiling the mips64el-softmmu target I encountered these errors=
:
>>
>>    CC      hw/display/g364fb.o
>> hw/core/loader-fit.c:105:41: error: expected expression
>>          *addr =3D fdt32_to_cpu(*(fdt32_t *)prop);
>>                                          ^
>> hw/core/loader-fit.c:105:32: error: use of undeclared identifier 'fdt3=
2_t'
>=20
> It seems you are missing the libfdt headers, so indeed you found bug.
>=20
> Replacing CONFIG_FITLOADER by CONFIG_FDT in hw/core/Makefile.objs and
> default-configs/mips64el-softmmu.mak should fix it, can you try?
>=20
>>          *addr =3D fdt32_to_cpu(*(fdt32_t *)prop);
>>                                 ^
>> hw/core/loader-fit.c:108:41: error: expected expression
>>          *addr =3D fdt64_to_cpu(*(fdt64_t *)prop);
>>                                          ^
>> hw/core/loader-fit.c:108:32: error: use of undeclared identifier 'fdt6=
4_t'
>>          *addr =3D fdt64_to_cpu(*(fdt64_t *)prop);
>>                                 ^
>> hw/core/loader-fit.c:278:19: warning: implicit declaration of function
>>        'fdt_first_subnode' is invalid in C99
>> [-Wimplicit-function-declaration]
>>              off =3D fdt_first_subnode(itb, configs);
>>                    ^
>> hw/core/loader-fit.c:286:23: warning: implicit declaration of function
>>        'fdt_next_subnode' is invalid in C99
>> [-Wimplicit-function-declaration]
>>                  off =3D fdt_next_subnode(itb, off);
>>                        ^
>> 2 warnings and 4 errors generated.
>> make: *** [hw/core/loader-fit.o] Error 1
>> make: *** Waiting for unfinished jobs=E2=80=A6.
>=20
> It'd be useful if next time you also tell which compiler/version are yo=
u
> using.
>=20
>> Steps to reproduce the error:
>> ./configure --target-list=3Dmips64el-softmmu && make
>=20
> And also the ./configure output, I'm interested by:
>=20
> "fdt support       no"
>=20
> Regards,
>=20
> Phil.



Hi,

As Philippe pointed, it looks like something with dtc(libfdt).
Could you also try to install DTC into your QEMU source base?
By default for mips64el-softmmu, if DTC is not compatible you should get
this message.

ERROR: DTC (libfdt) version >=3D 1.4.2 not present. Your options:
         (1) Preferred: Install the DTC (libfdt) devel package
         (2) Fetch the DTC submodule, using:
             git submodule update --init dtc

Since I am not able to reproduce the problem on my machines,
please let us know the detail of your system.

$ ../master/configure --target-list=3Dmips64el-softmmu && make -j
...
  GEN     trace/generated-helpers.c
  CC      mips64el-softmmu/trace/control-target.o
  CC      mips64el-softmmu/trace/generated-helpers.o
  LINK    mips64el-softmmu/qemu-system-mips64el

Regards,
Yongbok
