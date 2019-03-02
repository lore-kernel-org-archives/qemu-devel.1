Received: from eggs.gnu.org ([209.51.188.92]:34038)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h0AFL-0006Wr-2k
	for qemu-devel@nongnu.org; Sat, 02 Mar 2019 14:24:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h0AFK-0008Sg-Aa
	for qemu-devel@nongnu.org; Sat, 02 Mar 2019 14:24:31 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44639)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1h0AFK-0008SG-4Q
	for qemu-devel@nongnu.org; Sat, 02 Mar 2019 14:24:30 -0500
Received: by mail-wr1-f65.google.com with SMTP id w2so1274295wrt.11
	for <qemu-devel@nongnu.org>; Sat, 02 Mar 2019 11:24:30 -0800 (PST)
References: <20190301163518.20702-1-stefanha@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <be0192c8-05c4-2086-3ba2-d320f2b0e533@redhat.com>
Date: Sat, 2 Mar 2019 20:24:27 +0100
MIME-Version: 1.0
In-Reply-To: <20190301163518.20702-1-stefanha@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] MAINTAINERS: add missing support status
 fields
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, thuth@redhat.com, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

On 3/1/19 5:35 PM, Stefan Hajnoczi wrote:
> This patch adds the "S:" line for areas of the codebase that currently
> lack a support status field.
> 
> Note that there are a few more areas that are more abstract and do not
> correspond to a specific set of files.  They have not been modified.
> 
> Cc: Alex Bennée <alex.bennee@linaro.org>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  MAINTAINERS | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d941cb3862..2464f51879 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -338,6 +338,7 @@ F: include/hw/tricore/
>  
>  Multiarch Linux User Tests
>  M: Alex Bennée <alex.bennee@linaro.org>
> +S: Maintained
>  F: tests/tcg/multiarch/
>  
>  Guest CPU Cores (KVM):
> @@ -2094,6 +2095,7 @@ F: qemu.sasl
>  Coroutines
>  M: Stefan Hajnoczi <stefanha@redhat.com>
>  M: Kevin Wolf <kwolf@redhat.com>
> +S: Maintained
>  F: util/*coroutine*
>  F: include/qemu/coroutine*
>  F: tests/test-coroutine.c
> @@ -2528,6 +2530,7 @@ F: .gitlab-ci.yml
>  Guest Test Compilation Support
>  M: Alex Bennée <alex.bennee@linaro.org>
>  R: Philippe Mathieu-Daudé <f4bug@amsat.org>
> +S: Maintained
>  F: tests/tcg/Makefile
>  F: tests/tcg/Makefile.include
>  L: qemu-devel@nongnu.org
> 
