Received: from eggs.gnu.org ([2001:4830:134:3::10]:45588)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1d3luB-0000II-Ej
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 12:04:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1d3luA-0003RQ-LO
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 12:04:31 -0400
Received: from mail-wm0-x22a.google.com ([2a00:1450:400c:c09::22a]:38596)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1d3luA-0003RM-F1
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 12:04:30 -0400
Received: by mail-wm0-x22a.google.com with SMTP id r190so23231554wme.1
	for <qemu-devel@nongnu.org>; Thu, 27 Apr 2017 09:04:30 -0700 (PDT)
References: <20170427120006.20564-1-rth@twiddle.net>
	<20170427120006.20564-3-rth@twiddle.net>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20170427120006.20564-3-rth@twiddle.net>
Date: Thu, 27 Apr 2017 17:04:59 +0100
Message-ID: <8760hp96qc.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v5 02/19] tcg/sparc: Use the proper
 compilation flags for 32-bit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: qemu-devel@nongnu.org, cota@braap.org


Richard Henderson <rth@twiddle.net> writes:

> We have required a v9 cpu since 9b9c37c36439ee0452632253dac7a31897f27f70.
> However, the flags we were using did not reliably enable v8plus, which
> meant that the compiler didn't know it could inline 64-bit atomics.
>
> Signed-off-by: Richard Henderson <rth@twiddle.net>

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>

> ---
>  configure | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/configure b/configure
> index c35acf1..55dd9c3 100755
> --- a/configure
> +++ b/configure
> @@ -1206,12 +1206,12 @@ case "$cpu" in
>             LDFLAGS="-m64 $LDFLAGS"
>             ;;
>      sparc)
> -           LDFLAGS="-m32 $LDFLAGS"
> -           CPU_CFLAGS="-m32 -mcpu=ultrasparc"
> +           CPU_CFLAGS="-m32 -mv8plus -mcpu=ultrasparc"
> +           LDFLAGS="-m32 -mv8plus $LDFLAGS"
>             ;;
>      sparc64)
> -           LDFLAGS="-m64 $LDFLAGS"
>             CPU_CFLAGS="-m64 -mcpu=ultrasparc"
> +           LDFLAGS="-m64 $LDFLAGS"
>             ;;
>      s390)
>             CPU_CFLAGS="-m31"


--
Alex Bennée
