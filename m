Received: from eggs.gnu.org ([2001:4830:134:3::10]:51829)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1df6AJ-0005Qx-Fj
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 11:11:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1df6AH-0005nT-BW
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 11:11:27 -0400
Received: from mail-wm0-x232.google.com ([2a00:1450:400c:c09::232]:33804)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1df6AH-0005lX-6Q
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 11:11:25 -0400
Received: by mail-wm0-x232.google.com with SMTP id t138so7146138wmt.1
	for <qemu-devel@nongnu.org>; Tue, 08 Aug 2017 08:11:23 -0700 (PDT)
References: <20170728053610.15770-1-f4bug@amsat.org>
	<20170728053610.15770-19-f4bug@amsat.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20170728053610.15770-19-f4bug@amsat.org>
Date: Tue, 08 Aug 2017 16:11:20 +0100
Message-ID: <87mv7aumav.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 18/47] MAINTAINERS: add missing TCG entry
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: Richard Henderson <rth@twiddle.net>, qemu-trivial@nongnu.org, qemu-devel@nongnu.org


Philippe Mathieu-Daudé <f4bug@amsat.org> writes:

> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8cb94af6c5..6b83dac812 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1633,6 +1633,7 @@ Common code
>  M: Richard Henderson <rth@twiddle.net>
>  S: Maintained
>  F: tcg/
> +F: disas.c

Is this really TCG only? Can't the monitor call monitor_disas in any
mode?

>
>  AArch64 target
>  M: Claudio Fontana <claudio.fontana@huawei.com>


--
Alex Bennée
