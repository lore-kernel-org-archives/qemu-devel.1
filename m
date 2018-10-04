Received: from eggs.gnu.org ([2001:4830:134:3::10]:35518)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1g84nZ-0004mq-8e
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 10:40:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1g84nW-0007BS-2l
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 10:40:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59404)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <crosa@redhat.com>) id 1g84nV-000760-Lj
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 10:40:14 -0400
References: <20181003183036.6716-1-philmd@redhat.com>
	<87va6hrhqt.fsf@linaro.org>
From: Cleber Rosa <crosa@redhat.com>
Message-ID: <ae5836b5-b5c4-7a3d-5c28-0cf948cad704@redhat.com>
Date: Thu, 4 Oct 2018 10:40:07 -0400
MIME-Version: 1.0
In-Reply-To: <87va6hrhqt.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH v2 0/3] acceptance tests: Test firmware
 checking debug console output
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, Caio Carrara <ccarrara@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org, Laszlo Ersek <lersek@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>



On 10/4/18 8:58 AM, Alex Benn=C3=A9e wrote:
>=20
> Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:
>=20
>> Hi,
>>
>> This RFC series add simple acceptance tests which boot SeaBIOS and EDK=
2 on
>> the pc and virt/aarch64 default machines
>>
>> Still PoC but can be useful for the Avocado team to test the
>> multi-arch targets.
>=20
> I couldn't get this to work on qemu-test (aarch64):
>=20
>   12:52:56 [alex@qemu-test:~/l/qemu.git] review/acceptance-rfc-v2 + avo=
cado run tests/acceptance
>   JOB ID     : b6377b8d4196903846c7d57e2b234c523d6c6ba1
>   JOB LOG    : /home/alex/avocado/job-results/job-2018-10-04T12.53-b637=
7b8/job.log
>    (1/9) tests/acceptance/boot_firmware.py:BootFirmware.test_seabios: E=
RROR: timed out (15.14 s)
>    (2/9) tests/acceptance/boot_firmware.py:BootFirmware.test_ovmf_pc: E=
RROR: timed out (15.14 s)
>    (3/9) tests/acceptance/boot_firmware.py:BootFirmware.test_ovmf_virt:=
 FAIL: OVMF failed to boot (17.97 s)
>    (4/9) tests/acceptance/boot_linux_console.py:BootLinuxConsole.test: =
ERROR: timed out (17.36 s)
>    (5/9) tests/acceptance/version.py:Version.test_qmp_human_info_versio=
n: ERROR: timed out (15.14 s)
>    (6/9) tests/acceptance/vnc.py:Vnc.test_no_vnc: ERROR: timed out (15.=
14 s)
>    (7/9) tests/acceptance/vnc.py:Vnc.test_no_vnc_change_password: ERROR=
: timed out (15.14 s)
>    (8/9) tests/acceptance/vnc.py:Vnc.test_vnc_change_password_requires_=
a_password: ERROR: timed out (15.14 s)
>    (9/9) tests/acceptance/vnc.py:Vnc.test_vnc_change_password: ERROR: t=
imed out (15.14 s)
>   RESULTS    : PASS 0 | ERROR 8 | FAIL 1 | SKIP 0 | WARN 0 | INTERRUPT =
0 | CANCEL 0
>   JOB TIME   : 142.37 s
>=20
> The error log: https://transfer.sh/lK71v/avocado-errors.log
>=20

The core reason is:

2018-10-04 12:53:16,339 qemu             L0270 DEBUG| Output:
'qemu-system-aarch64: -machine pc: unsupported machine type\nUse
-machine help to list supported machines\n'

I'm minutes away from sending a series that adds support for arch and
machine type defaults.

- Cleber.

>>
>> Since v1: https://lists.gnu.org/archive/html/qemu-devel/2018-09/msg037=
80.html
>> - more Pythonic context managers (Cleber)
>> - use wait_for (Cleber)
>> - use workdir (Cleber)
>> - use Avocado 65.0 "-p" option for aarch64 (Cleber)
>> - fixed Q35 incorrect description in cover (Laszlo)
>> - use ArmVirtQemu name (Laszlo)
>>
>> Next:
>> - address Laszlo comments about correct QEMU options and flash images
>> - use FDDrainer
>> - refactor common code in setUp()
>> - use new avocado.utils.archive gzip features (Cleber)
>> - test x86_64/aarch64 'arch' tags (Cleber)
>> - build EDK2 flash images (Laszlo)
>> - include variable store flash image (Laszlo)
>> - use virtual disk with UEFI shell script (Laszlo)
>> - improve OVMF binary selection (releases / snapshots) (Laszlo)
>> - check ISO images (Laszlo -> Cleber)
>> - add aexpect tests (Cleber?)
>>
>> Regards,
>>
>> Phil.
>>
>> Philippe Mathieu-Daud=C3=A9 (3):
>>   acceptance tests: Add SeaBIOS boot and debug console checking test
>>   acceptance tests: Add EDK2 OVMF boot and debug console checking test
>>   acceptance tests: Add EDK2 ArmVirtQemu boot and console checking tes=
t
>>
>>  tests/acceptance/boot_firmware.py | 159 +++++++++++++++++++++++++++++=
+
>>  1 file changed, 159 insertions(+)
>>  create mode 100644 tests/acceptance/boot_firmware.py
>=20
>=20
> --
> Alex Benn=C3=A9e
>=20
