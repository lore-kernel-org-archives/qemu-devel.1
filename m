Received: from eggs.gnu.org ([209.51.188.92]:56408)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1h3Y6H-0007Np-E6
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 23:29:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1h3Y1w-0004k6-Ig
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 23:24:41 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:40395)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1h3Y1w-0004jV-Aq
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 23:24:40 -0400
Received: by mail-pg1-x544.google.com with SMTP id u9so705820pgo.7
	for <qemu-devel@nongnu.org>; Mon, 11 Mar 2019 20:24:40 -0700 (PDT)
References: <20190311191602.25796-1-svens@stackframe.org>
	<20190311191602.25796-2-svens@stackframe.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <a2151efb-2e96-f6b1-7262-5b832a4cbd48@linaro.org>
Date: Mon, 11 Mar 2019 20:24:36 -0700
MIME-Version: 1.0
In-Reply-To: <20190311191602.25796-2-svens@stackframe.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 01/11] target/hppa: fix overwriting source
 reg in addb
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
> When one of the source registers is the same as the destination register,
> the source register gets overwritten with the destionation value before
> do_add_sv() is called, which leads to unexpection condition matches.
> 
> Signed-off-by: Sven Schnelle <svens@stackframe.org>
> ---
>  target/hppa/translate.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
