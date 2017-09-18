Received: from eggs.gnu.org ([2001:4830:134:3::10]:58699)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dtsX7-0005cP-Sk
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 05:40:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dtsX4-0003li-Rq
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 05:40:05 -0400
Received: from mail-wr0-x22b.google.com ([2a00:1450:400c:c0c::22b]:46131)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dtsX4-0003lB-Kn
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 05:40:02 -0400
Received: by mail-wr0-x22b.google.com with SMTP id o42so5691894wrb.3
	for <qemu-devel@nongnu.org>; Mon, 18 Sep 2017 02:40:02 -0700 (PDT)
References: <20170918052524.4045-1-kwolf@redhat.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20170918052524.4045-1-kwolf@redhat.com>
Date: Mon, 18 Sep 2017 10:40:00 +0100
Message-ID: <87efr4jqfj.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] qemu.py: Fix syntax error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, ldoktor@redhat.com, famz@redhat.com, ehabkost@redhat.com, qemu-devel@nongnu.org, stefanha@gmail.com, apahim@redhat.com, armbru@redhat.com, mreitz@redhat.com, crosa@redhat.com


Kevin Wolf <kwolf@redhat.com> writes:

> Python requires parentheses around multiline expression. This fixes the
> breakage of all Python-based qemu-iotests cases that was introduced in
> commit dab91d9aa0.
>
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>

Heh, just sent an identical patch.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>

> ---
>
> Eduardo, I think I'm going to include this patch in a block layer pull
> request today, just to stop the CI spam I'm getting, so the CC is just
> FYI.
>
>  scripts/qemu.py | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/scripts/qemu.py b/scripts/qemu.py
> index 8c67595ec8..5e02dd8e78 100644
> --- a/scripts/qemu.py
> +++ b/scripts/qemu.py
> @@ -193,8 +193,8 @@ class QEMUMachine(object):
>          qemulog = open(self._qemu_log_path, 'wb')
>          try:
>              self._pre_launch()
> -            self._qemu_full_args = self._wrapper + [self._binary] +
> -                                    self._base_args() + self._args
> +            self._qemu_full_args = (self._wrapper + [self._binary] +
> +                                    self._base_args() + self._args)
>              self._popen = subprocess.Popen(self._qemu_full_args,
>                                             stdin=devnull,
>                                             stdout=qemulog,


--
Alex Bennée
