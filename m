Received: from eggs.gnu.org ([2001:4830:134:3::10]:51591)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ecXAH-00049y-UM
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 08:57:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ecXAD-00043e-S4
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 08:57:05 -0500
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:37517)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1ecXAD-00041J-Lg
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 08:57:01 -0500
Received: by mail-wm0-x242.google.com with SMTP id v71so3740572wmv.2
	for <qemu-devel@nongnu.org>; Fri, 19 Jan 2018 05:57:01 -0800 (PST)
References: <151629549711.18276.15497684562308683805.stgit@bahia.lan>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <151629549711.18276.15497684562308683805.stgit@bahia.lan>
Date: Fri, 19 Jan 2018 13:56:59 +0000
Message-ID: <87lggune8k.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] scripts/qemu-gdb/timers.py: define
 encoding in header comment
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>


Greg Kurz <groug@kaod.org> writes:

> This is required otherwise python complains because of the
> accentuated letter in Alex's last name:
>
> Traceback (most recent call last):
>   File "scripts/qemu-gdb.py", line 29, in <module>
>     from qemugdb import aio, mtree, coroutine, tcg, timers
>   File "scripts/qemugdb/timers.py", line 1
> SyntaxError: Non-ASCII character '\xc3' in file scripts/qemugdb/timers.py
>  on line 1, but no encoding declared;
>  see http://www.python.org/peps/pep-0263.html for details
>
> Signed-off-by: Greg Kurz <groug@kaod.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>


> ---
>  scripts/qemugdb/timers.py |    1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/scripts/qemugdb/timers.py b/scripts/qemugdb/timers.py
> index be71a001e333..51ea04b5e2ec 100644
> --- a/scripts/qemugdb/timers.py
> +++ b/scripts/qemugdb/timers.py
> @@ -1,4 +1,5 @@
>  #!/usr/bin/python
> +# -*- coding: utf-8 -*-
>  # GDB debugging support
>  #
>  # Copyright 2017 Linaro Ltd


--
Alex Benn=C3=A9e
