Received: from eggs.gnu.org ([2001:4830:134:3::10]:51149)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fSCGt-0002MJ-Uv
	for qemu-devel@nongnu.org; Sun, 10 Jun 2018 22:09:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fSCGp-0000sa-Fi
	for qemu-devel@nongnu.org; Sun, 10 Jun 2018 22:09:27 -0400
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:46432)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fSCGp-0000sJ-Am
	for qemu-devel@nongnu.org; Sun, 10 Jun 2018 22:09:23 -0400
Received: by mail-qk0-x244.google.com with SMTP id k86-v6so12106309qkh.13
	for <qemu-devel@nongnu.org>; Sun, 10 Jun 2018 19:09:23 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180608123307.24773-1-alex.bennee@linaro.org>
	<20180608123307.24773-50-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <4ce0dd57-ca84-7c5b-45b8-4ccdd255ea73@amsat.org>
Date: Sun, 10 Jun 2018 23:09:16 -0300
MIME-Version: 1.0
In-Reply-To: <20180608123307.24773-50-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v6 49/49] .travis.yml: add check-tcg test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, cota@braap.org, famz@redhat.com, berrange@redhat.com, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de, pbonzini@redhat.com, stefanha@redhat.com, stefanb@linux.vnet.ibm.com, marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org

Hi Alex,

On 06/08/2018 09:33 AM, Alex Bennée wrote:
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  .travis.yml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/.travis.yml b/.travis.yml
> index 814be151f4..f1d2d9edec 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -152,3 +152,9 @@ matrix:
>          - TEST_CMD=""
>        before_script:
>          - ./configure ${CONFIG} --extra-cflags="-g3 -O0 -fsanitize=thread -fuse-ld=gold" || cat config.log
> +    - env:
> +        - CONFIG="--disable-system --disable-docs"
> +        - TEST_CMD="make check-tcg"

Since we have default MAKEFLAGS="-j3"

I'm getting many failures:

  CROSS-BUILD ppc64le guest-tests with docker qemu:debian-ppc64el-cross
  BUILD   debian-riscv64-cross
  BUILD   debian-s390x-cross
  CROSS-BUILD riscv64 guest-tests with docker qemu:debian-riscv64-cross
  CROSS-BUILD s390x guest-tests with docker qemu:debian-s390x-cross
Error in atexit._run_exitfuncs:
Traceback (most recent call last):
  File "/usr/lib/python2.7/atexit.py", line 24, in _run_exitfuncs
    func(*targs, **kargs)
  File "/home/travis/qemu/tests/docker/docker.py", line 174, in
_kill_instances
    return self._do_kill_instances(True)
  File "/home/travis/qemu/tests/docker/docker.py", line 154, in
_do_kill_instances
    resp = self._output(["inspect", i])
  File "/home/travis/qemu/tests/docker/docker.py", line 179, in _output
    **kwargs)
  File "/usr/lib/python2.7/subprocess.py", line 223, in check_output
    raise CalledProcessError(retcode, cmd, output=output)
CalledProcessError: Command '['docker', 'inspect', 'c71dbe973c55']'
returned non-zero exit status 1
Error in sys.exitfunc:
Traceback (most recent call last):
  File "/usr/lib/python2.7/atexit.py", line 24, in _run_exitfuncs
    func(*targs, **kargs)
  File "/home/travis/qemu/tests/docker/docker.py", line 174, in
_kill_instances
    return self._do_kill_instances(True)
  File "/home/travis/qemu/tests/docker/docker.py", line 154, in
_do_kill_instances
    resp = self._output(["inspect", i])
  File "/home/travis/qemu/tests/docker/docker.py", line 179, in _output
    **kwargs)
  File "/usr/lib/python2.7/subprocess.py", line 223, in check_output
    raise CalledProcessError(retcode, cmd, output=output)
subprocess.CalledProcessError: Command '['docker', 'inspect',
'c71dbe973c55']' returned non-zero exit status 1
  BUILD   debian-sid
  GEN     sh4eb-linux-user/config-target.h
  CROSS-BUILD sh4eb guest-tests SKIPPED
  CROSS-BUILD sparc guest-tests SKIPPED
  GEN     sparc32plus-linux-user/config-target.h
  CROSS-BUILD sparc32plus guest-tests SKIPPED
  BUILD   debian-sid

This works fine adding:

     - MAKEFLAGS="-j1"

Adding MAKEFLAGS="-j1":
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> +      sudo: required
> +      dist: trusty
> +      compiler: gcc
> 
