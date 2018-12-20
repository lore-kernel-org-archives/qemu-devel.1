Received: from eggs.gnu.org ([2001:4830:134:3::10]:47096)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gZwjb-0000UT-6a
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 06:43:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gZwjX-0004TE-66
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 06:43:23 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53289)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gZwjW-0004SF-Uc
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 06:43:19 -0500
Received: by mail-wm1-f65.google.com with SMTP id d15so1656564wmb.3
	for <qemu-devel@nongnu.org>; Thu, 20 Dec 2018 03:43:18 -0800 (PST)
References: <20181219151917.3874-1-pbonzini@redhat.com>
	<CAFEAcA_0jPh6TVOqzfp_O5eFitNocabR1GdLkwwZcv6QcW=iUQ@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <d5bc276c-b149-acc6-03b8-6f5c5a309e4a@redhat.com>
Date: Thu, 20 Dec 2018 12:43:15 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_0jPh6TVOqzfp_O5eFitNocabR1GdLkwwZcv6QcW=iUQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PULL v2 00/35] Misc patches for 2018-12-18
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 12/20/18 12:10 AM, Peter Maydell wrote:
> On Wed, 19 Dec 2018 at 15:21, Paolo Bonzini <pbonzini@redhat.com> wrote:
>>
>> The following changes since commit e85c577158a2e8e252414959da9ef15c12eec63d:
>>
>>   Merge remote-tracking branch 'remotes/huth-gitlab/tags/pull-request-2018-12-17' into staging (2018-12-18 14:31:06 +0000)
>>
>> are available in the Git repository at:
>>
>>   git://github.com/bonzini/qemu.git tags/for-upstream
>>
>> for you to fetch changes up to b4e8bbb9ae50045160957e7ab66c4f1cae535ea4:
>>
>>   avoid TABs in files that only contain a few (2018-12-19 16:03:22 +0100)
>>
>> ----------------------------------------------------------------
>> * HAX support for Linux hosts (Alejandro)
>> * esp bugfixes (Guenter)
>> * Windows build cleanup (Marc-André)
>> * checkpatch logic improvements (Paolo)
>> * coalesced range bugfix (Paolo)
>> * switch testsuite to TAP (Paolo)
>> * QTAILQ rewrite (Paolo)
>> * block/iscsi.c cancellation fixes (Stefan)
>> * improve selection of the default accelerator (Thomas)
>>
>> ----------------------------------------------------------------
[...]
> I also get this splat trying to do 'make check-tcg':
> 
> make: Entering directory
> '/home/petmay01/linaro/qemu-for-merges/build/all-linux-static'
>   BUILD   debian9
> The command '/bin/sh -c DEBIAN_FRONTEND=noninteractive eatmydata
> apt install -y --no-install-recommends         bison
> build-essential         ca-certificates         clang         flex
>     gettext         git         libtest-harness-perl
> pkg-config         psmisc         python         texinfo
> $(apt-get -s build-dep qemu | egrep ^Inst | fgrep '[all]' | cut -d\
> -f2)' returned a non-zero code: 100
> Traceback (most recent call last):
>   File "/home/petmay01/linaro/qemu-for-merges/tests/docker/docker.py",
> line 563, in <module>
>     sys.exit(main())
>   File "/home/petmay01/linaro/qemu-for-merges/tests/docker/docker.py",
> line 560, in main
>     return args.cmdobj.run(args, argv)
>   File "/home/petmay01/linaro/qemu-for-merges/tests/docker/docker.py",
> line 376, in run
>     extra_files_cksum=cksum)
>   File "/home/petmay01/linaro/qemu-for-merges/tests/docker/docker.py",
> line 254, in build_image
>     quiet=quiet)
>   File "/home/petmay01/linaro/qemu-for-merges/tests/docker/docker.py",
> line 181, in _do_check
>     return subprocess.check_call(self._command + cmd, **kwargs)
>   File "/usr/lib/python2.7/subprocess.py", line 541, in check_call
>     raise CalledProcessError(retcode, cmd)
> subprocess.CalledProcessError: Command '['docker', 'build', '-t',
> 'qemu:debian9', '-f', '/tmp/docker_buildsvtS6R/tmp74LVkj.docker',
> '/tmp/docker_buildsvtS6R']' returned non-zero exit status 100
> /home/petmay01/linaro/qemu-for-merges/tests/docker/Makefile.include:53:
> recipe for target 'docker-image-debian9' failed
> make: *** [docker-image-debian9] Error 1

This looks an unrelated error. The Debian mirror you are using might be
out of sync (or syncing), or the filesystem where you store your Docker
image is full?
