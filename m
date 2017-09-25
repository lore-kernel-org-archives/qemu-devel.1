Received: from eggs.gnu.org ([2001:4830:134:3::10]:52805)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dwY1K-00059y-7M
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 14:22:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dwY1F-0002mN-L6
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 14:22:18 -0400
Received: from mail-pf0-x22c.google.com ([2607:f8b0:400e:c00::22c]:54487)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dwY1F-0002lc-D6
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 14:22:13 -0400
Received: by mail-pf0-x22c.google.com with SMTP id d187so4206536pfg.11
	for <qemu-devel@nongnu.org>; Mon, 25 Sep 2017 11:22:13 -0700 (PDT)
References: <20170921110625.9500-1-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <824254ac-23a1-30d5-e64e-e4e3147db6c4@linaro.org>
Date: Mon, 25 Sep 2017 11:22:09 -0700
MIME-Version: 1.0
In-Reply-To: <20170921110625.9500-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] accel/tcg/cputlb: avoid recursive BQL
 (fixes #1706296)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Paolo Bonzini <bonzini@gnu.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Jones <rjones@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

On 09/21/2017 04:06 AM, Alex Bennée wrote:
> The mmio path (see exec.c:prepare_mmio_access) already protects itself
> against recursive locking and it makes sense to do the same for
> io_readx/writex. Otherwise any helper running in the BQL context will
> assert when it attempts to write to device memory as in the case of
> the bug report.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> CC: Richard Jones <rjones@redhat.com>
> CC: Paolo Bonzini <bonzini@gnu.org>
> ---
>  accel/tcg/cputlb.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

I guess I'll queue this through tcg-next?


r~
