Received: from eggs.gnu.org ([2001:4830:134:3::10]:45602)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dVFw4-0003Gj-Aq
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 07:36:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dVFw0-0004eD-Cq
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 07:36:04 -0400
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:33467)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dVFw0-0004dQ-9I
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 07:36:00 -0400
Received: by mail-qk0-x243.google.com with SMTP id a66so1976667qkb.0
	for <qemu-devel@nongnu.org>; Wed, 12 Jul 2017 04:36:00 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170712075528.22770-1-famz@redhat.com>
	<20170712075528.22770-2-famz@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <31b414be-1ea0-acbf-38f5-d732b75b122d@amsat.org>
Date: Wed, 12 Jul 2017 08:35:56 -0300
MIME-Version: 1.0
In-Reply-To: <20170712075528.22770-2-famz@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 1/2] docker.py: Drop infile parameter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

On 07/12/2017 04:55 AM, Fam Zheng wrote:
> The **kwargs can do this just well.
> 
> Signed-off-by: Fam Zheng <famz@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>   tests/docker/docker.py | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/tests/docker/docker.py b/tests/docker/docker.py
> index e707e5b..f5ac86b 100755
> --- a/tests/docker/docker.py
> +++ b/tests/docker/docker.py
> @@ -112,11 +112,9 @@ class Docker(object):
>           signal.signal(signal.SIGTERM, self._kill_instances)
>           signal.signal(signal.SIGHUP, self._kill_instances)
>   
> -    def _do(self, cmd, quiet=True, infile=None, **kwargs):
> +    def _do(self, cmd, quiet=True, **kwargs):
>           if quiet:
>               kwargs["stdout"] = DEVNULL
> -        if infile:
> -            kwargs["stdin"] = infile
>           return subprocess.call(self._command + cmd, **kwargs)
>   
>       def _do_kill_instances(self, only_known, only_active=True):
> @@ -184,7 +182,7 @@ class Docker(object):
>       def update_image(self, tag, tarball, quiet=True):
>           "Update a tagged image using "
>   
> -        self._do(["build", "-t", tag, "-"], quiet=quiet, infile=tarball)
> +        self._do(["build", "-t", tag, "-"], quiet=quiet, stdin=tarball)
>   
>       def image_matches_dockerfile(self, tag, dockerfile):
>           try:
> 
