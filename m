Received: from eggs.gnu.org ([2001:4830:134:3::10]:51222)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f9Vdt-0005cq-Vd
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 08:59:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f9Vdq-0007UX-R9
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 08:59:58 -0400
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:37268)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f9Vdq-0007Tb-Kl
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 08:59:54 -0400
Received: by mail-qk0-x243.google.com with SMTP id d74so8797273qkg.4
	for <qemu-devel@nongnu.org>; Fri, 20 Apr 2018 05:59:54 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
References: <20180419164642.9536-1-f4bug@amsat.org>
	<585ca5e3-8477-49d0-7132-981a95435a75@amsat.org>
Message-ID: <7c56e3de-983f-7864-16a2-f442df1ba2f7@amsat.org>
Date: Fri, 20 Apr 2018 09:59:43 -0300
MIME-Version: 1.0
In-Reply-To: <585ca5e3-8477-49d0-7132-981a95435a75@amsat.org>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature";
	boundary="bVF2Z3jv5IZkkqsUsSvozC2gIbLwm9OIB"
Subject: Re: [Qemu-devel] [RFC PATCH 0/7] avocado: Add acceptance tests
 parsing the Linux boot console
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>, Cleber Rosa <crosa@redhat.com>, Amador Pahim <apahim@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, Zheng Xiang <xiang.zheng@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, Laszlo Ersek <lersek@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, Alistair Francis <alistair23@gmail.com>, avocado-devel@redhat.com, Peter Maydell <peter.maydell@linaro.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--bVF2Z3jv5IZkkqsUsSvozC2gIbLwm9OIB
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
To: =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Amador Pahim <apahim@redhat.com>,
 Stefan Hajnoczi <stefanha@gmail.com>, Zheng Xiang <xiang.zheng@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Laszlo Ersek <lersek@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>,
 Alistair Francis <alistair23@gmail.com>, avocado-devel@redhat.com,
 Peter Maydell <peter.maydell@linaro.org>
Message-ID: <7c56e3de-983f-7864-16a2-f442df1ba2f7@amsat.org>
Subject: Re: [RFC PATCH 0/7] avocado: Add acceptance tests parsing the Linux
 boot console
References: <20180419164642.9536-1-f4bug@amsat.org>
 <585ca5e3-8477-49d0-7132-981a95435a75@amsat.org>
In-Reply-To: <585ca5e3-8477-49d0-7132-981a95435a75@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

> Cross-posting qemu-devel + avocado-devel.
>=20
>> While previously working on a Super I/O refactor, I encountered some p=
roblems
>> at runtime, after building the codebase successfully and running qtest=
s.
>> I had to manually start to boot different guests and check the bootlog=
=2E
>>
>> I wanted to give a try at Avocado which seems designed to simplify tha=
t kind
>> of functional tests.
>>
>> I applied Amador Pahim work following Cleber Rosa documentation from
>> http://lists.nongnu.org/archive/html/qemu-devel/2018-01/msg03891.html,=

>> however I had to modify few things to parse the boot console.
>> Since his work is not merged, I included it in this series.
>>
>> The tests simply expect to find a string reported by Linux printk when=
 a
>> device is detected/initialized, such "ttyS0 at I/O 0x3f8 (irq =3D 4) i=
s a 16550A"
>> and "i8042 KBD port at 0x60,0x64 irq 1" for the Super I/O chip, or suc=
h
>> "registered as PCnet/PCI II 79C970A" to confirms the PCI subsystem and=
 network
>> device are correctly detected:
>>
>>
>>     self.assertIn(u'ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A', bootl=
og)
>>     self.assertIn(u'ttyS1 at I/O 0x2f8 (irq =3D 3) is a 16550A', bootl=
og)
>>     self.assertIn(u'i8042 KBD port at 0x60,0x64 irq 1', bootlog)
>>     self.assertIn(u'i8042 AUX port at 0x60,0x64 irq 12', bootlog)
>>
>> Example of the tests output:
>>
>>     $ avocado run test_linux-boot-console.py -m test_linux-boot-consol=
e.py.data/parameters.yaml=20
>>     JOB ID     : 695094c9bbe8f6011226da7c2031c2c53e949910
>>     JOB LOG    : /home/phil/avocado/job-results/job-2018-04-19T13.36-6=
95094c/job.log
>>      (1/6) test_linux-boot-console.py:TestAlphaClipperBoot2_6.test_boo=
t_console;alpha-2582: PASS (4.76 s)
>>      (2/6) test_linux-boot-console.py:TestAlphaClipperBoot2_6.test_boo=
t_console;mips-4a72: PASS (0.00 s)
>>      (3/6) test_linux-boot-console.py:TestMips4kcMaltaBoot2_6.test_boo=
t_console;alpha-2582: PASS (0.00 s)
>>      (4/6) test_linux-boot-console.py:TestMips4kcMaltaBoot2_6.test_boo=
t_console;mips-4a72: PASS (3.92 s)
>>      (5/6) test_linux-boot-console.py:TestMips4kcMaltaBoot3_2.test_boo=
t_console;alpha-2582: PASS (0.00 s)
>>      (6/6) test_linux-boot-console.py:TestMips4kcMaltaBoot3_2.test_boo=
t_console;mips-4a72: PASS (4.08 s)
>>     RESULTS    : PASS 6 | ERROR 0 | FAIL 0 | SKIP 0 | WARN 0 | INTERRU=
PT 0 | CANCEL 0
>>     JOB TIME   : 13.31 s
>>
>> Please apologize my ugly Python, this series is just a proof-of-concep=
t :)
>> I couldn't figure out how to use the @skipUnless(correct arch) decorat=
or.
>=20
> Eduardo asked me to share my first impressions after trying this
> framework with QEMU.
>=20
> So far it seems more designed to run tests _inside_ a qemu instance
> (think user-space), eventually testing packages/scripts.

Current examples use the same pattern, which I felt a bit restricting:

[QemuTest]
  .setUp: prepare VM arguments, launch the VM

  .test_*: run tests in the running VM

  .tearDown: shutdown the VM and cleanup dangling files

> My tests are targeting the machine model itself, if the devices are
> correctly instantiated and so.
> The fastest approach was to check the Linux kernel bootlog, but if you
> look at the TestAlphaClipperBoot console you'll see a boot "firmware" i=
s
> executed before the kernel. Casually this firmware also send informatio=
n
> on the console, but what if the console is not accessible?
> We can use a chardev for the ioport80 POST, but some firmwares post boo=
t
> events via I2C, SPI, CAN...
>=20
> To improve the testing, my idea is to use the Tracing framework.
> The machine trace events would be logged in a db and avogado would
> verify some of the trace events, did they occur? in the correct sequenc=
e
> order? with the correct arguments? We can also check relative
> timestamps, is this sequence timing fast enough?
>=20
> I plan to use the gdb API to insert breakpoints and follow part
> execution flow, eventually injecting (faulty) events.
>=20
> The multi-arch/machines support is a bit weak yet.
>=20
> I'm personally more interested in automatically testing [real world]
> firmware or full machine boot process, the kind of integration testing =
I
> can not do with qtests.
>=20
> I liked the possibility to generate coredumps, or the replay function.
>=20
> I also liked to be able to write a test on how a machine boots, in ~20
> LOC (see TestAlphaClipperBoot2_6).
>=20
> The storage API is OK to fetch a full VM image, but not a single file
> like a kernel or a flash image


--bVF2Z3jv5IZkkqsUsSvozC2gIbLwm9OIB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+qvnXhKRciHc/Wuy4+MsLN6twN4FAlrZ5D8ACgkQ4+MsLN6t
wN5t+BAAt690hgfRc8dJRE3H+wTBc2n7hxt08IiYWcy3AkZ0pogniat856cB/Yl7
yE3QVnnSSM7YJFJrcc7ni8BGrbtit6ddMiYyIPS44djj/rjK43Eq/MThakbpHmJ/
ExV+zF10DwFS9MVq+93UYBiUDGHpReAl5dRA+IqCDiXcxAU+t7H+oV+KA9gIKcrU
DhM2OrvInxsT2Ww20zwMPAQ0aw//pOgrQUHn/a/PMwpA9W9i+OuK8qJb87j6GWnZ
yHHANR8DJ1nZfgAWgpu3cMJ8X/vbZ5UaT7INhTZrndPqa8EuWzO8VGSe6JGip7Jm
nfYi+ShiyF8RsnzKbVaO22geyuhM7oeclRNybdf/s4h4b+WseHlNcelmwItXfN8z
6qQ62RVn1GvRDVG2jfN0McMD3gXGIMiq8Cw3QZZQxtu0CmDcf1zc1n2T5L6kKI+t
YNlVIqv1ig/s3SiaHJEqausqYy5YhIirPF5qiLpJtdC3S2aN2AiLacifok77Aq7I
0U6OeJCIZSXuh7rRC66hj5n4s7cnKDRKS08nIocbihsGqAoGnZRaKwUbRj9tLbP7
msmzosLF1CsPv0b7W62USGQQunC6mj81QvR0TMdH0Tg4fESAc9VvZ/y0hnP9x7bM
yrfgh1N/1CYLAP7Nscjzx6w43FxuaI+NMwZmVQM+P4S/MMojAkI=
=7MLC
-----END PGP SIGNATURE-----

--bVF2Z3jv5IZkkqsUsSvozC2gIbLwm9OIB--
