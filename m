Received: from eggs.gnu.org ([2001:4830:134:3::10]:40881)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1g83a4-00021E-PA
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 09:22:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1g83OC-0007IZ-Fe
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 09:10:01 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:35296)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1g83OC-0007IR-AM
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 09:10:00 -0400
Received: by mail-ot1-x342.google.com with SMTP id j9-v6so9082171otl.2
	for <qemu-devel@nongnu.org>; Thu, 04 Oct 2018 06:10:00 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <87tvm1rhh5.fsf@linaro.org>
References: <20181003183036.6716-1-philmd@redhat.com>
	<87va6hrhqt.fsf@linaro.org> <87tvm1rhh5.fsf@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 4 Oct 2018 14:09:38 +0100
Message-ID: <CAFEAcA9HUQ4igttzn3qRWvDxYFXMTwhL5+D-F3gGFmj6B+3zng@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <crosa@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>, Caio Carrara <ccarrara@redhat.com>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, Laszlo Ersek <lersek@redhat.com>

On 4 October 2018 at 14:04, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote=
:
>
> Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:
>
>> Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:
>>
>>> Hi,
>>>
>>> This RFC series add simple acceptance tests which boot SeaBIOS and EDK2=
 on
>>> the pc and virt/aarch64 default machines
>>>
>>> Still PoC but can be useful for the Avocado team to test the
>>> multi-arch targets.
>>
>> I couldn't get this to work on qemu-test (aarch64):
>>
>>   12:52:56 [alex@qemu-test:~/l/qemu.git] review/acceptance-rfc-v2 + avoc=
ado run tests/acceptance
>>   JOB ID     : b6377b8d4196903846c7d57e2b234c523d6c6ba1
>>   JOB LOG    : /home/alex/avocado/job-results/job-2018-10-04T12.53-b6377=
b8/job.log
>>    (1/9) tests/acceptance/boot_firmware.py:BootFirmware.test_seabios: ER=
ROR: timed out (15.14 s)
>>    (2/9) tests/acceptance/boot_firmware.py:BootFirmware.test_ovmf_pc: ER=
ROR: timed out (15.14 s)
>>    (3/9) tests/acceptance/boot_firmware.py:BootFirmware.test_ovmf_virt: =
FAIL: OVMF failed to boot (17.97 s)
>>    (4/9) tests/acceptance/boot_linux_console.py:BootLinuxConsole.test: E=
RROR: timed out (17.36 s)
>>    (5/9) tests/acceptance/version.py:Version.test_qmp_human_info_version=
: ERROR: timed out (15.14 s)
>>    (6/9) tests/acceptance/vnc.py:Vnc.test_no_vnc: ERROR: timed out (15.1=
4 s)
>>    (7/9) tests/acceptance/vnc.py:Vnc.test_no_vnc_change_password: ERROR:=
 timed out (15.14 s)
>>    (8/9) tests/acceptance/vnc.py:Vnc.test_vnc_change_password_requires_a=
_password: ERROR: timed out (15.14 s)
>>    (9/9) tests/acceptance/vnc.py:Vnc.test_vnc_change_password: ERROR: ti=
med out (15.14 s)
>>   RESULTS    : PASS 0 | ERROR 8 | FAIL 1 | SKIP 0 | WARN 0 | INTERRUPT 0=
 | CANCEL 0
>>   JOB TIME   : 142.37 s
>>
>> The error log: https://transfer.sh/lK71v/avocado-errors.log
>
> It looks like it's trying to launch a pc (rather than virt) machine:
>
>   2018-10-04 12:53:16,339 qemu             L0270 DEBUG| Output: 'qemu-sys=
tem-aarch64: -machine pc: unsupported machine type\nUse -machine help to li=
st supported machines\n'

That also suggests a secondary bug somewhere: if QEMU
exits immediately with an error, then the test should
fail immediately, not wait for a 15s timeout before
it notices.

thanks
-- PMM
