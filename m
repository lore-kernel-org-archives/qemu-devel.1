Received: from eggs.gnu.org ([2001:4830:134:3::10]:58652)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fYaUI-0002Qz-13
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 13:13:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fYaUE-0000ZK-3n
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 13:13:41 -0400
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:37602)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fYaUD-0000WR-P0
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 13:13:38 -0400
Received: by mail-wr0-x242.google.com with SMTP id k6-v6so6269890wrp.4
	for <qemu-devel@nongnu.org>; Thu, 28 Jun 2018 10:13:37 -0700 (PDT)
References: <20180622004435.10291-1-f4bug@amsat.org>
	<87muvevrqt.fsf@linaro.org>
	<8f45f2f0-0e3e-7b0d-ff92-9fd21f1cb8f7@redhat.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <8f45f2f0-0e3e-7b0d-ff92-9fd21f1cb8f7@redhat.com>
Date: Thu, 28 Jun 2018 18:13:35 +0100
Message-ID: <87efgqvnpc.fsf@linaro.org>
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
To: Cleber Rosa <crosa@redhat.com>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org, =?utf-8?B?THVrw6E=?= =?utf-8?B?xaE=?= Doktor <ldoktor@redhat.com>, Fam Zheng <famz@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>


Cleber Rosa <crosa@redhat.com> writes:

> On 06/28/2018 11:46 AM, Alex Benn=C3=A9e wrote:
>>
>> Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> writes:
>>
>>> Hi,
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
>>>     RESULTS    : PASS 7 | ERROR 0 | FAIL 0 | SKIP 0 | WARN 0 | INTERRUP=
T 0 | CANCEL 0
>>>     JOB TIME   : 6.21 s
>>
>> Hmm however if I do:
>>
>>    pip install --user avocado-framework
>>    avocado run tests/acceptance
>>
>> I get:
>>
>>    Failed to load plugin from module "avocado_vt.plugins.vt_list": Impor=
tError('No module named netaddr',)
>>    Failed to load plugin from module "avocado_vt.plugins.vt": ImportErro=
r('No module named netaddr',)
>>    Failed to load plugin from module "avocado_vt.plugins.vt_bootstrap": =
OSError(13, 'Permission denied')
>
> Alex,
>
> These are errors related to your installation of Avocado-*VT*[1].
>
>>    Error running method "run" of plugin "virt": 'Namespace' object has n=
o attribute 'default_avocado_params'
>>    Avocado crashed unexpectedly: [Errno 13] Permission denied: '/var/lib=
/libvirt/images/avocado_sg6NRi'
>>    You can find details in /var/tmp/avocado-traceback-2018-06-28_16:44:2=
5-DGb1CG.log
>>
>
> And these from Avocado-*Virt*[2].  Neither of those are used in the
> tests under "tests/acceptance".
>
>> Which I seem to remember from last time I looked into this. I think
>> avocado makes a bunch of assumptions about the filesystem and OS layout
>> which is hard to gloss over for something you should be able to run
>> straight out of the source tree.
>>
>>
>
> These Avocado-*VT* issues deserve a better look indeed.  Would you
> please describe (if not here, under a GH issue) your environment?

Ahh probably from last time I tried to get things up and running. I
rm -rf ~/.local and things seem to be working well now.

However I was under the impression that VT or virt was needed for this
testing. Or is this an old assumption?

>
> Thanks,
> - Cleber.
>
> [1] - https://github.com/avocado-framework/avocado-vt
> [2] - https://github.com/avocado-framework/avocado-virt
>
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
