Received: from eggs.gnu.org ([2001:4830:134:3::10]:39680)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1fEpbX-0001pk-3b
	for qemu-devel@nongnu.org; Sat, 05 May 2018 01:19:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1fEpbS-0004lQ-DK
	for qemu-devel@nongnu.org; Sat, 05 May 2018 01:19:31 -0400
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244]:44046)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <shorne@gmail.com>) id 1fEpbS-0004ks-6H
	for qemu-devel@nongnu.org; Sat, 05 May 2018 01:19:26 -0400
Received: by mail-pf0-x244.google.com with SMTP id q22so18954594pff.11
	for <qemu-devel@nongnu.org>; Fri, 04 May 2018 22:19:25 -0700 (PDT)
Date: Sat, 5 May 2018 14:19:22 +0900
From: Stafford Horne <shorne@gmail.com>
Message-ID: <20180505051922.GB4501@lianli.shorne-pla.net>
References: <20180504054030.24527-1-richard.henderson@linaro.org>
	<20180504054030.24527-2-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180504054030.24527-2-richard.henderson@linaro.org>
Subject: Re: [Qemu-devel] [PATCH 01/13] target-openrisc: Write back result
 before FPE exception
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, bandvig@mail.ru

On Thu, May 03, 2018 at 10:40:18PM -0700, Richard Henderson wrote:
> From: Richard Henderson <rth@twiddle.net>
> 
> The architecture manual is unclear about this, but the or1ksim
> does writeback before the exception.  This requires splitting
> the helpers in half, with the exception raised by the second.

I dont really see a problem with this, ccing bandvig who did a lot of the fpu
hardware implementation in mor1kx.

> Reviewed-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
> Signed-off-by: Richard Henderson <rth@twiddle.net>

Acked-by: Stafford Horne <shorne@gmail.com>

> ---
>  target/openrisc/helper.h     |  25 +++--
>  target/openrisc/fpu_helper.c | 250 +++++++++----------------------------------
>  target/openrisc/translate.c  | 101 ++++++++++-------
>  3 files changed, 125 insertions(+), 251 deletions(-)
> 
 
