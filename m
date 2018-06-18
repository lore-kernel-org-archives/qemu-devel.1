Received: from eggs.gnu.org ([2001:4830:134:3::10]:49330)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fUveB-0003BJ-Q5
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 11:00:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fUve2-0003Qw-Ds
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 11:00:47 -0400
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:45777)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fUve2-0003Ql-3r
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 11:00:38 -0400
Received: by mail-qk0-x244.google.com with SMTP id c198-v6so9489511qkg.12
	for <qemu-devel@nongnu.org>; Mon, 18 Jun 2018 08:00:37 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180618130709.19730-1-alex.bennee@linaro.org>
	<20180618130709.19730-6-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <58772def-4b88-7dda-a210-425bcb40bb71@amsat.org>
Date: Mon, 18 Jun 2018 12:00:33 -0300
MIME-Version: 1.0
In-Reply-To: <20180618130709.19730-6-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v1 5/8] docker: docker.py use "ps" to probe
 usage
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, famz@redhat.com, cota@braap.org, berrange@redhat.com, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de
Cc: qemu-devel@nongnu.org

On 06/18/2018 10:07 AM, Alex Bennée wrote:
> The "images" command is a fairly heavyweight command to run as it
> involves searching the whole docker file-system inventory. On a
> machine with a lot of images this makes start-up fairly expensive.

"version" would be even quicker.

> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  tests/docker/docker.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/docker/docker.py b/tests/docker/docker.py
> index c83fd89985..3072bf4a31 100755
> --- a/tests/docker/docker.py
> +++ b/tests/docker/docker.py
> @@ -49,7 +49,7 @@ def _guess_docker_command():
>      commands = [["docker"], ["sudo", "-n", "docker"]]
>      for cmd in commands:
>          try:
> -            if subprocess.call(cmd + ["images"],
> +            if subprocess.call(cmd + ["ps"],
>                                 stdout=DEVNULL, stderr=DEVNULL) == 0:
>                  return cmd
>          except OSError:
> 
