Received: from eggs.gnu.org ([2001:4830:134:3::10]:42807)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fYZMy-0003El-Lm
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 12:02:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fYZMu-0002Hg-3P
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 12:02:04 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:50325)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fYZMt-0002GH-P7
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 12:02:00 -0400
Received: by mail-wm0-x243.google.com with SMTP id e16-v6so10271498wmd.0
	for <qemu-devel@nongnu.org>; Thu, 28 Jun 2018 09:01:59 -0700 (PDT)
References: <20180622004435.10291-1-f4bug@amsat.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20180622004435.10291-1-f4bug@amsat.org>
Date: Thu, 28 Jun 2018 17:01:55 +0100
Message-ID: <87lgayvr0s.fsf@linaro.org>
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

> Hi,
>
> Another neanderthal approach to add multi-arch acceptance tests using
> Avocado.
>
> Since Cleber Rosa work got merged [0], I can restart my previous attempt =
[1]
> at using Avocado in QEMU.
> Cleber Rosa rewrote my previous v1 [1], in good python, now this v2 pushes
> a bit further:
> - we can now run other archs
> - Avocado is integrated into Travis CI
>
> I'm not sure Travis is the best CI available for those tests, but it runs
> quite fast:
>
>       ...
>       LINK    x86_64-softmmu/qemu-system-x86_64
>     JOB ID     : a3a56af3c02d193e862ce660aae1d9c72926dcb6
>     JOB LOG    : /home/travis/avocado/job-results/job-2018-06-21T23.49-a3=
a56af/job.log
>      (1/7) tests/acceptance/boot_linux_console.py:BootLinuxConsoleX86_64.=
test:  PASS (3.89 s)
>      (2/7) tests/acceptance/boot_linux_console.py:BootLinuxConsoleMips.te=
st:  PASS (1.83 s)
>      (3/7) tests/acceptance/version.py:Version.test_qmp_human_info_versio=
n:  PASS (0.05 s)
>      (4/7) tests/acceptance/vnc.py:Vnc.test_no_vnc:  PASS (0.04 s)
>      (5/7) tests/acceptance/vnc.py:Vnc.test_no_vnc_change_password:  PASS=
 (0.04 s)
>      (6/7) tests/acceptance/vnc.py:Vnc.test_vnc_change_password_requires_=
a_password:  PASS (0.05 s)
>      (7/7) tests/acceptance/vnc.py:Vnc.test_vnc_change_password:  PASS (0=
.05 s)
>     RESULTS    : PASS 7 | ERROR 0 | FAIL 0 | SKIP 0 | WARN 0 |
>       INTERRUPT 0 | CANCEL 0

That said on my AArch64 server it fairs better:

15:59:19 [alex.bennee@libgomp-d05-dev:~/l/qemu.git] review/avocado-v2 + avo=
cado run tests/acceptance
JOB ID     : f40e814204ff007c58073ca75abb38bd575f39f2
JOB LOG    : /home/alex.bennee/avocado/job-results/job-2018-06-28T15.59-f40=
e814/job.log
 (1/7) tests/acceptance/boot_linux_console.py:BootLinuxConsoleX86_64.test: =
CANCEL (0.00 s)
 (2/7) tests/acceptance/boot_linux_console.py:BootLinuxConsoleMips.test: PA=
SS (2.03 s)
 (3/7) tests/acceptance/version.py:Version.test_qmp_human_info_version: CAN=
CEL (0.00 s)
 (4/7) tests/acceptance/vnc.py:Vnc.test_no_vnc: CANCEL (0.00 s)
 (5/7) tests/acceptance/vnc.py:Vnc.test_no_vnc_change_password: CANCEL (0.0=
0 s)
 (6/7) tests/acceptance/vnc.py:Vnc.test_vnc_change_password_requires_a_pass=
word: CANCEL (0.00 s)
 (7/7) tests/acceptance/vnc.py:Vnc.test_vnc_change_password: CANCEL (0.00 s)
RESULTS    : PASS 1 | ERROR 0 | FAIL 0 | SKIP 0 | WARN 0 | INTERRUPT 0 | CA=
NCEL 6
JOB TIME   : 2.47 s

Although given the errors in the logs I'm surprised at ERROR 0

>     JOB TIME   : 6.21 s
>
>     Done. Your build exited with 0.
>
>     Job ran for 5 min 34 sec
>
> I couldn't add the Alpha tests because all the vmlinux kernels I found
> online are gzipped, so I'm waiting some upstream Avocado merges before.
>
> Cleber: I hope you can help me pythonizing this series :p
>
> Regards,
>
> Phil.
>
> [0]: http://lists.nongnu.org/archive/html/qemu-devel/2018-06/msg04531.html
> [1]: http://lists.nongnu.org/archive/html/qemu-devel/2018-04/msg03076.html
>
> Philippe Mathieu-Daud=C3=A9 (6):
>   avocado: Add a Test.arch property
>   tests/acceptance: Rename the x86-64 specific BootLinuxConsole test
>   tests/acceptance: Improve the Avocado tags
>   tests/acceptance: Add a BootLinuxConsoleMips test
>   tests/acceptance: Add a kludge to not use the default console
>   travis: Add Avocado tests
>
>  .travis.yml                               |  8 +++++
>  scripts/qemu.py                           |  6 ++--
>  tests/acceptance/avocado_qemu/__init__.py | 17 ++++++---
>  tests/acceptance/boot_linux_console.py    | 44 +++++++++++++++++++++--
>  4 files changed, 67 insertions(+), 8 deletions(-)


--
Alex Benn=C3=A9e
