Received: from eggs.gnu.org ([209.51.188.92]:56398)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1h3Y6H-0007Nl-BU
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 23:29:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1h3Y27-0005F2-Pq
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 23:24:52 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431]:45635)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1h3Y27-0005Eb-HK
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 23:24:51 -0400
Received: by mail-pf1-x431.google.com with SMTP id v21so743507pfm.12
	for <qemu-devel@nongnu.org>; Mon, 11 Mar 2019 20:24:51 -0700 (PDT)
References: <20190311191602.25796-1-svens@stackframe.org>
	<20190311191602.25796-3-svens@stackframe.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <33f0dabd-da3a-2b39-5d17-f29b9cf84bd2@linaro.org>
Date: Mon, 11 Mar 2019 20:24:47 -0700
MIME-Version: 1.0
In-Reply-To: <20190311191602.25796-3-svens@stackframe.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 02/11] target/hppa: fix TLB handling for
 page 0
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

On 3/11/19 12:15 PM, Sven Schnelle wrote:
> Assume the following sequence:
> 
> pitlbe r0(sr0,r0)
> iitlba r4,(sr0,r0)
> ldil L%3000000,r5
> iitlbp r5,(sr0,r0)
> 
> This will purge the whole TLB and add an entry for page 0. However
> the current TLB implementation in helper_iitlba() will store to
> the last empty TLB entry, while helper_iitlbp() will write to the
> first empty entry. That is because an empty entry will match address
> 0 in helper_iitlba()
> 
> Signed-off-by: Sven Schnelle <svens@stackframe.org>
> ---
>  target/hppa/mem_helper.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
