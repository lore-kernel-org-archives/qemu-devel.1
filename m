Received: from eggs.gnu.org ([2001:4830:134:3::10]:60894)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fYaf7-0006K6-Oa
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 13:24:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fYaf3-0000LM-Mf
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 13:24:53 -0400
Received: from mail-qt0-x233.google.com ([2607:f8b0:400d:c0d::233]:38985)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fYaf3-0000Kv-GG
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 13:24:49 -0400
Received: by mail-qt0-x233.google.com with SMTP id q12-v6so1508118qtp.6
	for <qemu-devel@nongnu.org>; Thu, 28 Jun 2018 10:24:49 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180622004435.10291-1-f4bug@amsat.org>
	<87muvevrqt.fsf@linaro.org>
	<8f45f2f0-0e3e-7b0d-ff92-9fd21f1cb8f7@redhat.com>
	<87efgqvnpc.fsf@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <8d3c05f5-8174-34fe-015d-36c435f1482f@amsat.org>
Date: Thu, 28 Jun 2018 14:24:43 -0300
MIME-Version: 1.0
In-Reply-To: <87efgqvnpc.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Cleber Rosa <crosa@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org, =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>, Fam Zheng <famz@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>

On 06/28/2018 02:13 PM, Alex Bennée wrote:
> 
> Cleber Rosa <crosa@redhat.com> writes:
> 
>> On 06/28/2018 11:46 AM, Alex Bennée wrote:
>>>
>>> Philippe Mathieu-Daudé <f4bug@amsat.org> writes:
>>>
>>>> Hi,
>>>>
>>>> Another neanderthal approach to add multi-arch acceptance tests using
>>>> Avocado.
>>>>
>>>> Since Cleber Rosa work got merged [0], I can restart my previous attempt [1]
>>>> at using Avocado in QEMU.
>>>> Cleber Rosa rewrote my previous v1 [1], in good python, now this v2 pushes
>>>> a bit further:
>>>> - we can now run other archs
>>>> - Avocado is integrated into Travis CI
>>>>
>>>> I'm not sure Travis is the best CI available for those tests, but it runs
>>>> quite fast:
>>>>
>>>>       ...
>>>>       LINK    x86_64-softmmu/qemu-system-x86_64
>>>>     JOB ID     : a3a56af3c02d193e862ce660aae1d9c72926dcb6
>>>>     JOB LOG    : /home/travis/avocado/job-results/job-2018-06-21T23.49-a3a56af/job.log
>>>>      (1/7) tests/acceptance/boot_linux_console.py:BootLinuxConsoleX86_64.test:  PASS (3.89 s)
>>>>      (2/7) tests/acceptance/boot_linux_console.py:BootLinuxConsoleMips.test:  PASS (1.83 s)
>>>>      (3/7) tests/acceptance/version.py:Version.test_qmp_human_info_version:  PASS (0.05 s)
>>>>      (4/7) tests/acceptance/vnc.py:Vnc.test_no_vnc:  PASS (0.04 s)
>>>>      (5/7) tests/acceptance/vnc.py:Vnc.test_no_vnc_change_password:  PASS (0.04 s)
>>>>      (6/7) tests/acceptance/vnc.py:Vnc.test_vnc_change_password_requires_a_password:  PASS (0.05 s)
>>>>      (7/7) tests/acceptance/vnc.py:Vnc.test_vnc_change_password:  PASS (0.05 s)
>>>>     RESULTS    : PASS 7 | ERROR 0 | FAIL 0 | SKIP 0 | WARN 0 | INTERRUPT 0 | CANCEL 0
>>>>     JOB TIME   : 6.21 s
>>>
>>> Hmm however if I do:
>>>
>>>    pip install --user avocado-framework
>>>    avocado run tests/acceptance
>>>
>>> I get:
>>>
>>>    Failed to load plugin from module "avocado_vt.plugins.vt_list": ImportError('No module named netaddr',)
>>>    Failed to load plugin from module "avocado_vt.plugins.vt": ImportError('No module named netaddr',)
>>>    Failed to load plugin from module "avocado_vt.plugins.vt_bootstrap": OSError(13, 'Permission denied')
>>
>> Alex,
>>
>> These are errors related to your installation of Avocado-*VT*[1].
>>
>>>    Error running method "run" of plugin "virt": 'Namespace' object has no attribute 'default_avocado_params'
>>>    Avocado crashed unexpectedly: [Errno 13] Permission denied: '/var/lib/libvirt/images/avocado_sg6NRi'
>>>    You can find details in /var/tmp/avocado-traceback-2018-06-28_16:44:25-DGb1CG.log
>>>
>>
>> And these from Avocado-*Virt*[2].  Neither of those are used in the
>> tests under "tests/acceptance".
>>
>>> Which I seem to remember from last time I looked into this. I think
>>> avocado makes a bunch of assumptions about the filesystem and OS layout
>>> which is hard to gloss over for something you should be able to run
>>> straight out of the source tree.
>>>
>>>
>>
>> These Avocado-*VT* issues deserve a better look indeed.  Would you
>> please describe (if not here, under a GH issue) your environment?
> 
> Ahh probably from last time I tried to get things up and running. I
> rm -rf ~/.local and things seem to be working well now.

Should we check for a prerequisite version?

> 
> However I was under the impression that VT or virt was needed for this
> testing. Or is this an old assumption?

I don't use neither of these for my qemu-system testing, but I'm more
interested in testing system targets that are different from my host.

I think the VT/virt make sens when you test on a same (target, host)
tuple and worry about perfs.

<snip>
