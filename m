Received: from eggs.gnu.org ([2001:4830:134:3::10]:58446)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ewYeW-0000lc-HT
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 15:35:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ewYeV-0006Pa-B3
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 15:35:04 -0400
References: <1521100145-15304-1-git-send-email-thuth@redhat.com>
	<1521100145-15304-4-git-send-email-thuth@redhat.com>
	<dcb8eab2-ab81-91d5-5a4e-6d666eb8e98c@amsat.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <baed5efa-3733-151e-3ef2-fabb30080557@redhat.com>
Date: Thu, 15 Mar 2018 20:34:54 +0100
MIME-Version: 1.0
In-Reply-To: <dcb8eab2-ab81-91d5-5a4e-6d666eb8e98c@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 3/3] tests/cdrom-test: Test that -cdrom
 parameter is working
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Victor Kaplansky <victork@redhat.com>, qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-s390x@nongnu.org, =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>

On 15.03.2018 12:42, Philippe Mathieu-Daud=C3=A9 wrote:
> Hi Thomas,
>=20
> On 03/15/2018 08:49 AM, Thomas Huth wrote:
>> Commit 1454509726719e0933c800 recently broke the "-cdrom" parameter
>> on a couple of boards without that we noticed it immediately. Thus
>> add a test which checks that "-cdrom" can at least be used to start
>> QEMU with certain machine types.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>  tests/Makefile.include |  7 +++++-
>>  tests/cdrom-test.c     | 63 +++++++++++++++++++++++++++++++++++++++++=
++++++++-
>>  2 files changed, 68 insertions(+), 2 deletions(-)
>>
>> diff --git a/tests/Makefile.include b/tests/Makefile.include
>> index a104222..b744fea 100644
>> --- a/tests/Makefile.include
>> +++ b/tests/Makefile.include
>> @@ -321,8 +321,9 @@ check-qtest-microblaze-y =3D tests/boot-serial-tes=
t$(EXESUF)
>>  check-qtest-mips-y =3D tests/endianness-test$(EXESUF)
>> =20
>>  check-qtest-mips64-y =3D tests/endianness-test$(EXESUF)
>> +check-qtest-mips64-y +=3D tests/cdrom-test$(EXESUF)
>> =20
>> -check-qtest-mips64el-y =3D tests/endianness-test$(EXESUF)
>> +check-qtest-mips64el-y =3D $(check-qtest-mips64-y)
>> =20
>>  check-qtest-moxie-y =3D tests/boot-serial-test$(EXESUF)
>> =20
>> @@ -356,6 +357,7 @@ check-qtest-ppc64-y +=3D tests/display-vga-test$(E=
XESUF)
>>  check-qtest-ppc64-y +=3D tests/numa-test$(EXESUF)
>>  check-qtest-ppc64-$(CONFIG_IVSHMEM) +=3D tests/ivshmem-test$(EXESUF)
>>  check-qtest-ppc64-y +=3D tests/cpu-plug-test$(EXESUF)
>> +check-qtest-ppc64-y +=3D tests/cdrom-test$(EXESUF)
>> =20
>>  check-qtest-sh4-y =3D tests/endianness-test$(EXESUF)
>> =20
>> @@ -365,10 +367,12 @@ check-qtest-sparc-y =3D tests/prom-env-test$(EXE=
SUF)
>>  check-qtest-sparc-y +=3D tests/m48t59-test$(EXESUF)
>>  gcov-files-sparc-y =3D hw/timer/m48t59.c
>>  check-qtest-sparc-y +=3D tests/boot-serial-test$(EXESUF)
>> +check-qtest-sparc-y +=3D tests/cdrom-test$(EXESUF)
>> =20
>>  check-qtest-sparc64-y =3D tests/endianness-test$(EXESUF)
>>  check-qtest-sparc64-y +=3D tests/prom-env-test$(EXESUF)
>>  check-qtest-sparc64-y +=3D tests/boot-serial-test$(EXESUF)
>> +check-qtest-sparc64-y +=3D tests/cdrom-test$(EXESUF)
>> =20
>>  check-qtest-arm-y =3D tests/tmp105-test$(EXESUF)
>>  check-qtest-arm-y +=3D tests/ds1338-test$(EXESUF)
>> @@ -384,6 +388,7 @@ check-qtest-arm-y +=3D tests/sdhci-test$(EXESUF)
>>  check-qtest-aarch64-y =3D tests/numa-test$(EXESUF)
>>  check-qtest-aarch64-y +=3D tests/sdhci-test$(EXESUF)
>>  check-qtest-aarch64-y +=3D tests/boot-serial-test$(EXESUF)
>> +check-qtest-aarch64-y +=3D tests/cdrom-test$(EXESUF)
>=20
> Since you use g_str_equal(arch,), maybe this test can be added
> regardless the arch in check-qtest-generic.

Yes, sounds like a good idea. I think the test can even be run on other
architectures by using the default machine or "-M none" ... I'll give it
a try ...

>>      ret =3D g_test_run();
>>
>=20
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

 Thanks!
  Thomas
