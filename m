Received: from eggs.gnu.org ([2001:4830:134:3::10]:59571)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fj5d3-0006e3-90
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 12:30:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fj5d0-0007Oc-5O
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 12:30:09 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:39724)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fj5cz-0007Nu-R9
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 12:30:06 -0400
Received: by mail-wm0-x241.google.com with SMTP id h20-v6so6070364wmb.4
	for <qemu-devel@nongnu.org>; Fri, 27 Jul 2018 09:30:05 -0700 (PDT)
References: <20180622004435.10291-1-f4bug@amsat.org>
	<87lgayvr0s.fsf@linaro.org>
	<d63f9e99-703a-78c4-8aaf-00f79c67cd9f@amsat.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <d63f9e99-703a-78c4-8aaf-00f79c67cd9f@amsat.org>
Date: Fri, 27 Jul 2018 17:30:02 +0100
Message-ID: <87tvoksktx.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 0/6] Avocado: start multi-arch tests,
 add a Travis job
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: Cleber Rosa <crosa@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org, =?utf-8?B?THVrw6HFoQ==?= Doktor <ldoktor@redhat.com>, Fam Zheng <famz@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>


Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> writes:

> Hi Alex,
>
> On 06/28/2018 01:01 PM, Alex Benn=C3=A9e wrote:
>> Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> writes:
>>>
>>> Another neanderthal approach to add multi-arch acceptance tests using
>>> Avocado.
>>>
>>> Since Cleber Rosa work got merged [0], I can restart my previous attemp=
t [1]
>>> at using Avocado in QEMU.
>>> Cleber Rosa rewrote my previous v1 [1], in good python, now this v2 pus=
hes
>>> a bit further:
>>> - we can now run other archs
>>> - Avocado is integrated into Travis CI
>>>
>>> I'm not sure Travis is the best CI available for those tests, but it ru=
ns
>>> quite fast:
>>>
>>>       ...
>>>       LINK    x86_64-softmmu/qemu-system-x86_64
>>>     JOB ID     : a3a56af3c02d193e862ce660aae1d9c72926dcb6
>>>     JOB LOG    : /home/travis/avocado/job-results/job-2018-06-21T23.49-=
a3a56af/job.log
>>>      (1/7) tests/acceptance/boot_linux_console.py:BootLinuxConsoleX86_6=
4.test:  PASS (3.89 s)
>>>      (2/7) tests/acceptance/boot_linux_console.py:BootLinuxConsoleMips.=
test:  PASS (1.83 s)
>>>      (3/7) tests/acceptance/version.py:Version.test_qmp_human_info_vers=
ion:  PASS (0.05 s)
>>>      (4/7) tests/acceptance/vnc.py:Vnc.test_no_vnc:  PASS (0.04 s)
>>>      (5/7) tests/acceptance/vnc.py:Vnc.test_no_vnc_change_password:  PA=
SS (0.04 s)
>>>      (6/7) tests/acceptance/vnc.py:Vnc.test_vnc_change_password_require=
s_a_password:  PASS (0.05 s)
>>>      (7/7) tests/acceptance/vnc.py:Vnc.test_vnc_change_password:  PASS =
(0.05 s)
>>>     RESULTS    : PASS 7 | ERROR 0 | FAIL 0 | SKIP 0 | WARN 0 |
>>>       INTERRUPT 0 | CANCEL 0
>>
>> That said on my AArch64 server it fairs better:
>>
>> 15:59:19 [alex.bennee@libgomp-d05-dev:~/l/qemu.git] review/avocado-v2 + =
avocado run tests/acceptance
>> JOB ID     : f40e814204ff007c58073ca75abb38bd575f39f2
>> JOB LOG    : /home/alex.bennee/avocado/job-results/job-2018-06-28T15.59-=
f40e814/job.log
>>  (1/7) tests/acceptance/boot_linux_console.py:BootLinuxConsoleX86_64.tes=
t: CANCEL (0.00 s)
>>  (2/7) tests/acceptance/boot_linux_console.py:BootLinuxConsoleMips.test:=
 PASS (2.03 s)
>>  (3/7) tests/acceptance/version.py:Version.test_qmp_human_info_version: =
CANCEL (0.00 s)
>>  (4/7) tests/acceptance/vnc.py:Vnc.test_no_vnc: CANCEL (0.00 s)
>>  (5/7) tests/acceptance/vnc.py:Vnc.test_no_vnc_change_password: CANCEL (=
0.00 s)
>>  (6/7) tests/acceptance/vnc.py:Vnc.test_vnc_change_password_requires_a_p=
assword: CANCEL (0.00 s)
>>  (7/7) tests/acceptance/vnc.py:Vnc.test_vnc_change_password: CANCEL (0.0=
0 s)
>> RESULTS    : PASS 1 | ERROR 0 | FAIL 0 | SKIP 0 | WARN 0 | INTERRUPT 0 |=
 CANCEL 6
>> JOB TIME   : 2.47 s
>>
>> Although given the errors in the logs I'm surprised at ERROR 0
>
> Why are you surprised? You were expecting the BootLinuxConsoleMips to
> fail?

No but a bunch have CANCELed... maybe they are skipping but if the test
is run and it fails to complete I would expect that to be an error.

>
>>
>>>     JOB TIME   : 6.21 s
>>>
>>>     Done. Your build exited with 0.
>>>
>>>     Job ran for 5 min 34 sec
>>>
>>> I couldn't add the Alpha tests because all the vmlinux kernels I found
>>> online are gzipped, so I'm waiting some upstream Avocado merges before.
>>>
>>> Cleber: I hope you can help me pythonizing this series :p
>>>
>>> Regards,
>>>
>>> Phil.
>>>
>>> [0]: http://lists.nongnu.org/archive/html/qemu-devel/2018-06/msg04531.h=
tml
>>> [1]: http://lists.nongnu.org/archive/html/qemu-devel/2018-04/msg03076.h=
tml
>>>
>>> Philippe Mathieu-Daud=C3=A9 (6):
>>>   avocado: Add a Test.arch property
>>>   tests/acceptance: Rename the x86-64 specific BootLinuxConsole test
>>>   tests/acceptance: Improve the Avocado tags
>>>   tests/acceptance: Add a BootLinuxConsoleMips test
>>>   tests/acceptance: Add a kludge to not use the default console
>>>   travis: Add Avocado tests
>>>
>>>  .travis.yml                               |  8 +++++
>>>  scripts/qemu.py                           |  6 ++--
>>>  tests/acceptance/avocado_qemu/__init__.py | 17 ++++++---
>>>  tests/acceptance/boot_linux_console.py    | 44 +++++++++++++++++++++--
>>>  4 files changed, 67 insertions(+), 8 deletions(-)
>>
>>
>> --
>> Alex Benn=C3=A9e
>>


--
Alex Benn=C3=A9e
