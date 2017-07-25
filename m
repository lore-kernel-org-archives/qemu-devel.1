Received: from eggs.gnu.org ([2001:4830:134:3::10]:55261)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1da0Zb-0004V7-Nz
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 10:12:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1da0ZY-0003Sk-IH
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 10:12:31 -0400
Received: from mail-wr0-x22d.google.com ([2a00:1450:400c:c0c::22d]:36458)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1da0ZY-0003SJ-AJ
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 10:12:28 -0400
Received: by mail-wr0-x22d.google.com with SMTP id y43so119611108wrd.3
	for <qemu-devel@nongnu.org>; Tue, 25 Jul 2017 07:12:28 -0700 (PDT)
References: <20170724182751.18261-1-f4bug@amsat.org>
	<20170724182751.18261-36-f4bug@amsat.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20170724182751.18261-36-f4bug@amsat.org>
Date: Tue, 25 Jul 2017 15:12:25 +0100
Message-ID: <87lgncehbq.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC PATCH for 2.10 35/35] script to run docker
 image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: Eric Blake <eblake@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org


Philippe Mathieu-Daudé <f4bug@amsat.org> writes:

> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  scripts/dockershell | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
>  create mode 100755 scripts/dockershell
>
> diff --git a/scripts/dockershell b/scripts/dockershell
> new file mode 100755
> index 0000000000..f6a2276172
> --- /dev/null
> +++ b/scripts/dockershell
> @@ -0,0 +1,30 @@
> +#! /bin/sh
> +
> +# This script starts a docker shell with QEMU directory mounted
> +#
> +# Copyright (C) 2017 Philippe Mathieu-Daudé. GPLv2+.
> +#
> +# Usage:
> +# ./scripts/dockershell qemu:debian-bleeding-dev
<snip>

This isn't appropriate for 2.10 now we are feature frozen. That said I
have pondered a helper script for this sort of thing before. As it stand
I just rely on my shell to remember the correct invocation for me.

This is the sort of functionality we would need for maybe cross
compiling tests using docker.

--
Alex Bennée
