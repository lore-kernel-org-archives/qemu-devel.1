Received: from eggs.gnu.org ([2001:4830:134:3::10]:55360)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fSI5H-0003Sc-D2
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 04:21:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fSI5D-0007y5-HB
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 04:21:51 -0400
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:46518)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fSI5D-0007xj-9p
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 04:21:47 -0400
Received: by mail-wr0-x242.google.com with SMTP id v13-v6so19357001wrp.13
	for <qemu-devel@nongnu.org>; Mon, 11 Jun 2018 01:21:47 -0700 (PDT)
References: <20180608123307.24773-1-alex.bennee@linaro.org>
	<20180608123307.24773-50-alex.bennee@linaro.org>
	<4ce0dd57-ca84-7c5b-45b8-4ccdd255ea73@amsat.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <4ce0dd57-ca84-7c5b-45b8-4ccdd255ea73@amsat.org>
Date: Mon, 11 Jun 2018 09:21:45 +0100
Message-ID: <87602p20o6.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 49/49] .travis.yml: add check-tcg test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: cota@braap.org, famz@redhat.com, berrange@redhat.com, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de, pbonzini@redhat.com, stefanha@redhat.com, stefanb@linux.vnet.ibm.com, marcandre.lureau@redhat.com, qemu-devel@nongnu.org


Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> writes:

> Hi Alex,
>
> On 06/08/2018 09:33 AM, Alex Benn=C3=A9e wrote:
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> ---
>>  .travis.yml | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/.travis.yml b/.travis.yml
>> index 814be151f4..f1d2d9edec 100644
>> --- a/.travis.yml
>> +++ b/.travis.yml
>> @@ -152,3 +152,9 @@ matrix:
>>          - TEST_CMD=3D""
>>        before_script:
>>          - ./configure ${CONFIG} --extra-cflags=3D"-g3 -O0 -fsanitize=3D=
thread -fuse-ld=3Dgold" || cat config.log
>> +    - env:
>> +        - CONFIG=3D"--disable-system --disable-docs"
>> +        - TEST_CMD=3D"make check-tcg"
>
> Since we have default MAKEFLAGS=3D"-j3"
>
> I'm getting many failures:
>
>   CROSS-BUILD ppc64le guest-tests with docker qemu:debian-ppc64el-cross
>   BUILD   debian-riscv64-cross
>   BUILD   debian-s390x-cross
>   CROSS-BUILD riscv64 guest-tests with docker qemu:debian-riscv64-cross
>   CROSS-BUILD s390x guest-tests with docker qemu:debian-s390x-cross
> Error in atexit._run_exitfuncs:
> Traceback (most recent call last):
>   File "/usr/lib/python2.7/atexit.py", line 24, in _run_exitfuncs
>     func(*targs, **kargs)
>   File "/home/travis/qemu/tests/docker/docker.py", line 174, in
> _kill_instances
>     return self._do_kill_instances(True)
>   File "/home/travis/qemu/tests/docker/docker.py", line 154, in
> _do_kill_instances
>     resp =3D self._output(["inspect", i])
>   File "/home/travis/qemu/tests/docker/docker.py", line 179, in _output
>     **kwargs)
>   File "/usr/lib/python2.7/subprocess.py", line 223, in check_output
>     raise CalledProcessError(retcode, cmd, output=3Doutput)
> CalledProcessError: Command '['docker', 'inspect', 'c71dbe973c55']'
> returned non-zero exit status 1
> Error in sys.exitfunc:
> Traceback (most recent call last):
>   File "/usr/lib/python2.7/atexit.py", line 24, in _run_exitfuncs
>     func(*targs, **kargs)
>   File "/home/travis/qemu/tests/docker/docker.py", line 174, in
> _kill_instances
>     return self._do_kill_instances(True)
>   File "/home/travis/qemu/tests/docker/docker.py", line 154, in
> _do_kill_instances
>     resp =3D self._output(["inspect", i])
>   File "/home/travis/qemu/tests/docker/docker.py", line 179, in _output
>     **kwargs)
>   File "/usr/lib/python2.7/subprocess.py", line 223, in check_output
>     raise CalledProcessError(retcode, cmd, output=3Doutput)
> subprocess.CalledProcessError: Command '['docker', 'inspect',
> 'c71dbe973c55']' returned non-zero exit status 1
>   BUILD   debian-sid
>   GEN     sh4eb-linux-user/config-target.h
>   CROSS-BUILD sh4eb guest-tests SKIPPED
>   CROSS-BUILD sparc guest-tests SKIPPED
>   GEN     sparc32plus-linux-user/config-target.h
>   CROSS-BUILD sparc32plus guest-tests SKIPPED
>   BUILD   debian-sid
>
> This works fine adding:
>
>      - MAKEFLAGS=3D"-j1"

Hmm I would really like to get this working properly. But I thought I
did by building everything at the top level. I messed around with
conditional dependencies currently in:

  https://github.com/stsquad/qemu/tree/testing/tcg-testing-revival-v7

To try and make this better.

>
> Adding MAKEFLAGS=3D"-j1":
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> Tested-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>
>> +      sudo: required
>> +      dist: trusty
>> +      compiler: gcc
>>


--
Alex Benn=C3=A9e
