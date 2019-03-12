Received: from eggs.gnu.org ([209.51.188.92]:56398)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1h3Y6B-0007Nl-Ry
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 23:29:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1h3Y4u-0007fD-SF
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 23:27:45 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:40411)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1h3Y4u-0007e0-IT
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 23:27:44 -0400
Received: by mail-pg1-x543.google.com with SMTP id u9so711131pgo.7
	for <qemu-devel@nongnu.org>; Mon, 11 Mar 2019 20:27:44 -0700 (PDT)
References: <20190311191602.25796-1-svens@stackframe.org>
	<20190311191602.25796-11-svens@stackframe.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <e9dd31ab-dcf5-63a8-baf5-ec63c0369590@linaro.org>
Date: Mon, 11 Mar 2019 20:27:40 -0700
MIME-Version: 1.0
In-Reply-To: <20190311191602.25796-11-svens@stackframe.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 10/11] target/hppa: exit TB if either Data
 or Instruction TLB changes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sven Schnelle <svens@stackframe.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>

On 3/11/19 12:16 PM, Sven Schnelle wrote:
> The current code assumes that we don't need to exit the TB
> if a Data Cache Flush or Insert has happend. However, as we
> have a shared Data/Instruction TLB, a Data cache flush also
> flushes Instruction TLB entries, and a Data cache TLB insert
> might also evict a Instruction TLB entry.
> 
> So exit the TB in all cases if Instruction translation is enabled.
> 
> Signed-off-by: Sven Schnelle <svens@stackframe.org>
> ---
>  target/hppa/translate.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)

I suppose since we advertise a unified i/d tlb, the os feels that
either i/d flush should be sufficient.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
