Received: from eggs.gnu.org ([2001:4830:134:3::10]:53028)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1g85ZO-00087K-13
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 11:29:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1g85ZK-0004yp-3Y
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 11:29:41 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b]:34050)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1g85ZJ-0004v8-D6
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 11:29:37 -0400
Received: by mail-wr1-x42b.google.com with SMTP id z4-v6so10410347wrb.1
	for <qemu-devel@nongnu.org>; Thu, 04 Oct 2018 08:29:31 -0700 (PDT)
References: <20181003183036.6716-1-philmd@redhat.com>
	<87va6hrhqt.fsf@linaro.org>
	<ae5836b5-b5c4-7a3d-5c28-0cf948cad704@redhat.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <ae5836b5-b5c4-7a3d-5c28-0cf948cad704@redhat.com>
Date: Thu, 04 Oct 2018 16:29:28 +0100
Message-ID: <87r2h5raqv.fsf@linaro.org>
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
To: Cleber Rosa <crosa@redhat.com>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Caio Carrara <ccarrara@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org, Laszlo Ersek <lersek@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>


Cleber Rosa <crosa@redhat.com> writes:

> On 10/4/18 8:58 AM, Alex Benn=C3=A9e wrote:
>>
<snip>
>>
>> The error log: https://transfer.sh/lK71v/avocado-errors.log
>>
>
> The core reason is:
>
> 2018-10-04 12:53:16,339 qemu             L0270 DEBUG| Output:
> 'qemu-system-aarch64: -machine pc: unsupported machine type\nUse
> -machine help to list supported machines\n'
>
> I'm minutes away from sending a series that adds support for arch and
> machine type defaults.

\o/

I see it now, I shall have a look.

>
> - Cleber.
>
>>>
>>> Since v1: https://lists.gnu.org/archive/html/qemu-devel/2018-09/msg0378=
0.html
>>> - more Pythonic context managers (Cleber)
>>> - use wait_for (Cleber)
>>> - use workdir (Cleber)
>>> - use Avocado 65.0 "-p" option for aarch64 (Cleber)
>>> - fixed Q35 incorrect description in cover (Laszlo)
>>> - use ArmVirtQemu name (Laszlo)
>>>
>>> Next:
>>> - address Laszlo comments about correct QEMU options and flash images
>>> - use FDDrainer
>>> - refactor common code in setUp()
>>> - use new avocado.utils.archive gzip features (Cleber)
>>> - test x86_64/aarch64 'arch' tags (Cleber)
>>> - build EDK2 flash images (Laszlo)
>>> - include variable store flash image (Laszlo)
>>> - use virtual disk with UEFI shell script (Laszlo)
>>> - improve OVMF binary selection (releases / snapshots) (Laszlo)
>>> - check ISO images (Laszlo -> Cleber)
>>> - add aexpect tests (Cleber?)
>>>
>>> Regards,
>>>
>>> Phil.
>>>
>>> Philippe Mathieu-Daud=C3=A9 (3):
>>>   acceptance tests: Add SeaBIOS boot and debug console checking test
>>>   acceptance tests: Add EDK2 OVMF boot and debug console checking test
>>>   acceptance tests: Add EDK2 ArmVirtQemu boot and console checking test
>>>
>>>  tests/acceptance/boot_firmware.py | 159 ++++++++++++++++++++++++++++++
>>>  1 file changed, 159 insertions(+)
>>>  create mode 100644 tests/acceptance/boot_firmware.py
>>
>>
>> --
>> Alex Benn=C3=A9e
>>


--
Alex Benn=C3=A9e
