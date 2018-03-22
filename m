Received: from eggs.gnu.org ([2001:4830:134:3::10]:47242)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eyvfA-0008RR-1X
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 04:33:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eyvf5-00014a-VF
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 04:33:32 -0400
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:42967)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eyvf5-00013u-QY
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 04:33:27 -0400
Received: by mail-qk0-x242.google.com with SMTP id b198so8329669qkg.9
	for <qemu-devel@nongnu.org>; Thu, 22 Mar 2018 01:33:27 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180322034753.6301-1-famz@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <382fac6c-8762-d3b3-4597-acd429982196@amsat.org>
Date: Thu, 22 Mar 2018 05:33:22 -0300
MIME-Version: 1.0
In-Reply-To: <20180322034753.6301-1-famz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] tests: Fix ubuntu.i386 image initialization
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, eblake@redhat.com

On 03/22/2018 12:47 AM, Fam Zheng wrote:
> The apt-get commands we run through ssh expect certain features of the
> tty, and refuses to work if /dev/null is used. It is ugly, but easy to
> satisfy.
> 
> Actually, there is no reason to hide the output. It just makes things
> harder to diagnose. We can always redirect in the Makefile, so don't do
> it conditionally here.
> 
> Reported-by: Eric Blake <eblake@redhat.com>
> Signed-off-by: Fam Zheng <famz@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  tests/vm/basevm.py | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
> index 686d88decf..3a2d508c35 100755
> --- a/tests/vm/basevm.py
> +++ b/tests/vm/basevm.py
> @@ -107,10 +107,7 @@ class BaseVM(object):
>          assert not isinstance(cmd, str)
>          ssh_cmd += ["%s@127.0.0.1" % user] + list(cmd)
>          logging.debug("ssh_cmd: %s", " ".join(ssh_cmd))
> -        r = subprocess.call(ssh_cmd,
> -                            stdin=sys.stdin if interactive else self._devnull,
> -                            stdout=sys.stdout if interactive else self._stdout,
> -                            stderr=sys.stderr if interactive else self._stderr)
> +        r = subprocess.call(ssh_cmd)
>          if check and r != 0:
>              raise Exception("SSH command failed: %s" % cmd)
>          return r
> 
