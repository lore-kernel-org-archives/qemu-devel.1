Received: from eggs.gnu.org ([2001:4830:134:3::10]:40676)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fWJ7n-0007xQ-ST
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 06:17:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fWJ7n-0004w0-2D
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 06:17:03 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:40087)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fWJ7m-0004vk-T1
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 06:17:02 -0400
Received: by mail-oi0-x243.google.com with SMTP id f79-v6so5676878oib.7
	for <qemu-devel@nongnu.org>; Fri, 22 Jun 2018 03:17:02 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180612005145.3375-11-richard.henderson@linaro.org>
References: <20180612005145.3375-1-richard.henderson@linaro.org>
	<20180612005145.3375-11-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 22 Jun 2018 11:16:41 +0100
Message-ID: <CAFEAcA8672_8-FJWAqvSy0NBOS7wvsnEDRZSA83pX9WjO04zOA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 10/19] linux-user: Propagate goto
 unimplemented to default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Laurent Vivier <laurent@vivier.eu>

On 12 June 2018 at 01:51, Richard Henderson
<richard.henderson@linaro.org> wrote:
> There is no point in listing a syscall if you want the same effect as
> not listing it.  In one less trivial case, the goto was demonstrably
> not reachable.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  linux-user/syscall.c | 144 +------------------------------------------
>  1 file changed, 1 insertion(+), 143 deletions(-)
>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
