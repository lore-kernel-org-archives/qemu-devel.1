Received: from eggs.gnu.org ([209.51.188.92]:56398)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1h3Y6C-0007Nl-PK
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 23:29:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1h3Y3k-0006sl-Qr
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 23:26:33 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:33778)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1h3Y3k-0006s7-IT
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 23:26:32 -0400
Received: by mail-pf1-x441.google.com with SMTP id i19so789987pfd.0
	for <qemu-devel@nongnu.org>; Mon, 11 Mar 2019 20:26:32 -0700 (PDT)
References: <20190311191602.25796-1-svens@stackframe.org>
	<20190311191602.25796-5-svens@stackframe.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <14649231-550d-17ab-5a1a-afda0fbd0da9@linaro.org>
Date: Mon, 11 Mar 2019 20:26:28 -0700
MIME-Version: 1.0
In-Reply-To: <20190311191602.25796-5-svens@stackframe.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 04/11] target/hppa: add TLB trace events
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
> To ease TLB debugging add a few trace events, which are disabled
> by default so that there's no performance impact.
> 
> Signed-off-by: Sven Schnelle <svens@stackframe.org>
> ---
>  Makefile.objs            |  1 +
>  target/hppa/mem_helper.c | 20 ++++++++++++++++++--
>  target/hppa/op_helper.c  |  2 ++
>  target/hppa/trace-events | 18 ++++++++++++++++++
>  4 files changed, 39 insertions(+), 2 deletions(-)
>  create mode 100644 target/hppa/trace-events

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
