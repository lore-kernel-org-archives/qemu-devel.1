Received: from eggs.gnu.org ([209.51.188.92]:55157)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gsDGY-0005IM-C4
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 16:00:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gsDGX-0001g7-FA
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 16:00:54 -0500
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:46046)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gsDGX-0001ej-5e
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 16:00:53 -0500
Received: by mail-pg1-x542.google.com with SMTP id y4so2086702pgc.12
	for <qemu-devel@nongnu.org>; Fri, 08 Feb 2019 13:00:52 -0800 (PST)
References: <20190208163727.13733-1-remi@remlab.net>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <8f51cf7f-ba18-a123-e31d-a95d18918cb8@linaro.org>
Date: Fri, 8 Feb 2019 10:12:13 -0800
MIME-Version: 1.0
In-Reply-To: <20190208163727.13733-1-remi@remlab.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] tcg: assert last byte is in guest space
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?R=c3=a9mi_Denis-Courmont?= <remi@remlab.net>, qemu-devel@nongnu.org

On 2/8/19 8:37 AM, Rémi Denis-Courmont wrote:
> Rather than assert that the first byte of a checked range is within the
> guest address space, assert that the last byte is. The assertion is
> moved past the overflow check to ensure that the last byte is actually
> the one with the highest address.
> 
> Signed-off-by: Rémi Denis-Courmont <remi@remlab.net>
> ---
>  accel/tcg/translate-all.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)

What are you trying to fix here?

You've moved the assert past some returns, so that some cases that should not
be handled by this function no longer get checked.  As the comment says, the
address should already have been filtered by h2g_valid.


r~
