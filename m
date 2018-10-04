Received: from eggs.gnu.org ([2001:4830:134:3::10]:36606)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1g83Ig-0003gE-IU
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 09:04:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1g83IX-00081L-Sp
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 09:04:14 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b]:37436)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1g83IX-0007xa-F2
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 09:04:09 -0400
Received: by mail-wm1-x32b.google.com with SMTP id 185-v6so8991712wmt.2
	for <qemu-devel@nongnu.org>; Thu, 04 Oct 2018 06:04:09 -0700 (PDT)
References: <20181003183036.6716-1-philmd@redhat.com>
	<87va6hrhqt.fsf@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <87va6hrhqt.fsf@linaro.org>
Date: Thu, 04 Oct 2018 14:04:06 +0100
Message-ID: <87tvm1rhh5.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Cc: Cleber Rosa <crosa@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Caio Carrara <ccarrara@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org, Laszlo Ersek <lersek@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>


Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:

> Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:
>
>> Hi,
>>
>> This RFC series add simple acceptance tests which boot SeaBIOS and EDK2 =
on
>> the pc and virt/aarch64 default machines
>>
>> Still PoC but can be useful for the Avocado team to test the
>> multi-arch targets.
>
> I couldn't get this to work on qemu-test (aarch64):
>
>   12:52:56 [alex@qemu-test:~/l/qemu.git] review/acceptance-rfc-v2 + avoca=
do run tests/acceptance
>   JOB ID     : b6377b8d4196903846c7d57e2b234c523d6c6ba1
>   JOB LOG    : /home/alex/avocado/job-results/job-2018-10-04T12.53-b6377b=
8/job.log
>    (1/9) tests/acceptance/boot_firmware.py:BootFirmware.test_seabios: ERR=
OR: timed out (15.14 s)
>    (2/9) tests/acceptance/boot_firmware.py:BootFirmware.test_ovmf_pc: ERR=
OR: timed out (15.14 s)
>    (3/9) tests/acceptance/boot_firmware.py:BootFirmware.test_ovmf_virt: F=
AIL: OVMF failed to boot (17.97 s)
>    (4/9) tests/acceptance/boot_linux_console.py:BootLinuxConsole.test: ER=
ROR: timed out (17.36 s)
>    (5/9) tests/acceptance/version.py:Version.test_qmp_human_info_version:=
 ERROR: timed out (15.14 s)
>    (6/9) tests/acceptance/vnc.py:Vnc.test_no_vnc: ERROR: timed out (15.14=
 s)
>    (7/9) tests/acceptance/vnc.py:Vnc.test_no_vnc_change_password: ERROR: =
timed out (15.14 s)
>    (8/9) tests/acceptance/vnc.py:Vnc.test_vnc_change_password_requires_a_=
password: ERROR: timed out (15.14 s)
>    (9/9) tests/acceptance/vnc.py:Vnc.test_vnc_change_password: ERROR: tim=
ed out (15.14 s)
>   RESULTS    : PASS 0 | ERROR 8 | FAIL 1 | SKIP 0 | WARN 0 | INTERRUPT 0 =
| CANCEL 0
>   JOB TIME   : 142.37 s
>
> The error log: https://transfer.sh/lK71v/avocado-errors.log

It looks like it's trying to launch a pc (rather than virt) machine:

  2018-10-04 12:53:16,339 qemu             L0270 DEBUG| Output: 'qemu-syste=
m-aarch64: -machine pc: unsupported machine type\nUse -machine help to list=
 supported machines\n'

>
>>
>> Since v1: https://lists.gnu.org/archive/html/qemu-devel/2018-09/msg03780=
.html
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
>>   acceptance tests: Add EDK2 ArmVirtQemu boot and console checking test
>>
>>  tests/acceptance/boot_firmware.py | 159 ++++++++++++++++++++++++++++++
>>  1 file changed, 159 insertions(+)
>>  create mode 100644 tests/acceptance/boot_firmware.py


--
Alex Benn=C3=A9e
