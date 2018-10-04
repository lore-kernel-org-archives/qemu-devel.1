Received: from eggs.gnu.org ([2001:4830:134:3::10]:35996)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1g84pp-0006HS-0p
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 10:42:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1g84pl-0001hF-SL
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 10:42:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42822)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <crosa@redhat.com>) id 1g84pl-0001gr-KJ
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 10:42:33 -0400
References: <20181003183036.6716-1-philmd@redhat.com>
	<87va6hrhqt.fsf@linaro.org> <87tvm1rhh5.fsf@linaro.org>
	<CAFEAcA9HUQ4igttzn3qRWvDxYFXMTwhL5+D-F3gGFmj6B+3zng@mail.gmail.com>
From: Cleber Rosa <crosa@redhat.com>
Message-ID: <d80bac76-b831-e42c-5310-8f1d6925316f@redhat.com>
Date: Thu, 4 Oct 2018 10:42:31 -0400
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9HUQ4igttzn3qRWvDxYFXMTwhL5+D-F3gGFmj6B+3zng@mail.gmail.com>
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
To: Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>, Caio Carrara <ccarrara@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Laszlo Ersek <lersek@redhat.com>, Wainer dos Santos Moschetta <wainersm@redhat.com>



On 10/4/18 9:09 AM, Peter Maydell wrote:
> On 4 October 2018 at 14:04, Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:
>>
>> Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:
>>
>>> Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:
>>>
>>>> Hi,
>>>>
>>>> This RFC series add simple acceptance tests which boot SeaBIOS and E=
DK2 on
>>>> the pc and virt/aarch64 default machines
>>>>
>>>> Still PoC but can be useful for the Avocado team to test the
>>>> multi-arch targets.
>>>
>>> I couldn't get this to work on qemu-test (aarch64):
>>>
>>>   12:52:56 [alex@qemu-test:~/l/qemu.git] review/acceptance-rfc-v2 + a=
vocado run tests/acceptance
>>>   JOB ID     : b6377b8d4196903846c7d57e2b234c523d6c6ba1
>>>   JOB LOG    : /home/alex/avocado/job-results/job-2018-10-04T12.53-b6=
377b8/job.log
>>>    (1/9) tests/acceptance/boot_firmware.py:BootFirmware.test_seabios:=
 ERROR: timed out (15.14 s)
>>>    (2/9) tests/acceptance/boot_firmware.py:BootFirmware.test_ovmf_pc:=
 ERROR: timed out (15.14 s)
>>>    (3/9) tests/acceptance/boot_firmware.py:BootFirmware.test_ovmf_vir=
t: FAIL: OVMF failed to boot (17.97 s)
>>>    (4/9) tests/acceptance/boot_linux_console.py:BootLinuxConsole.test=
: ERROR: timed out (17.36 s)
>>>    (5/9) tests/acceptance/version.py:Version.test_qmp_human_info_vers=
ion: ERROR: timed out (15.14 s)
>>>    (6/9) tests/acceptance/vnc.py:Vnc.test_no_vnc: ERROR: timed out (1=
5.14 s)
>>>    (7/9) tests/acceptance/vnc.py:Vnc.test_no_vnc_change_password: ERR=
OR: timed out (15.14 s)
>>>    (8/9) tests/acceptance/vnc.py:Vnc.test_vnc_change_password_require=
s_a_password: ERROR: timed out (15.14 s)
>>>    (9/9) tests/acceptance/vnc.py:Vnc.test_vnc_change_password: ERROR:=
 timed out (15.14 s)
>>>   RESULTS    : PASS 0 | ERROR 8 | FAIL 1 | SKIP 0 | WARN 0 | INTERRUP=
T 0 | CANCEL 0
>>>   JOB TIME   : 142.37 s
>>>
>>> The error log: https://transfer.sh/lK71v/avocado-errors.log
>>
>> It looks like it's trying to launch a pc (rather than virt) machine:
>>
>>   2018-10-04 12:53:16,339 qemu             L0270 DEBUG| Output: 'qemu-=
system-aarch64: -machine pc: unsupported machine type\nUse -machine help =
to list supported machines\n'
>=20
> That also suggests a secondary bug somewhere: if QEMU
> exits immediately with an error, then the test should
> fail immediately, not wait for a 15s timeout before
> it notices.
>=20

That's true, and that's due to a connection timeout to the QMP socket.
It's a known issue that we're tracking here:

https://trello.com/c/O882Vulm/44-qemumachine-even-if-we-expect-qemu-to-ex=
it-with-an-error

And Wainer Moschetta (+cc) is working on it.

Regards,
- Cleber.

> thanks
> -- PMM
>=20
