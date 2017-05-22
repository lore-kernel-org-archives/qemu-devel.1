Received: from eggs.gnu.org ([2001:4830:134:3::10]:55035)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dCk8I-0002i0-Or
	for qemu-devel@nongnu.org; Mon, 22 May 2017 06:00:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dCk8F-0006Px-N6
	for qemu-devel@nongnu.org; Mon, 22 May 2017 06:00:10 -0400
Received: from mail-wm0-x22a.google.com ([2a00:1450:400c:c09::22a]:38875)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dCk8F-0006Lr-F2
	for qemu-devel@nongnu.org; Mon, 22 May 2017 06:00:07 -0400
Received: by mail-wm0-x22a.google.com with SMTP id e127so32084733wmg.1
	for <qemu-devel@nongnu.org>; Mon, 22 May 2017 03:00:06 -0700 (PDT)
References: <20170521032956.27446-1-f4bug@amsat.org>
	<20170521032956.27446-2-f4bug@amsat.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20170521032956.27446-2-f4bug@amsat.org>
Date: Mon, 22 May 2017 11:00:08 +0100
Message-ID: <87lgpp43fb.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 01/24] docker: let _copy_with_mkdir()
 sub_path argument be optional
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: qemu-devel@nongnu.org, Fam Zheng <famz@redhat.com>


Philippe Mathieu-Daudé <f4bug@amsat.org> writes:

> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>

> ---
>  tests/docker/docker.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tests/docker/docker.py b/tests/docker/docker.py
> index 8747f6a440..6ddc6e4c2a 100755
> --- a/tests/docker/docker.py
> +++ b/tests/docker/docker.py
> @@ -52,7 +52,7 @@ def _guess_docker_command():
>      raise Exception("Cannot find working docker command. Tried:\n%s" % \
>                      commands_txt)
>
> -def _copy_with_mkdir(src, root_dir, sub_path):
> +def _copy_with_mkdir(src, root_dir, sub_path='.'):
>      """Copy src into root_dir, creating sub_path as needed."""
>      dest_dir = os.path.normpath("%s/%s" % (root_dir, sub_path))
>      try:


--
Alex Bennée
