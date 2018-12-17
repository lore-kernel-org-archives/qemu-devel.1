Received: from eggs.gnu.org ([2001:4830:134:3::10]:59010)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gYw2I-00016p-Ft
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 11:46:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gYw2D-0003jc-Mw
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 11:46:30 -0500
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:45864)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gYw2D-0003gE-E9
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 11:46:25 -0500
Received: by mail-pg1-x543.google.com with SMTP id y4so6363503pgc.12
	for <qemu-devel@nongnu.org>; Mon, 17 Dec 2018 08:46:21 -0800 (PST)
References: <20181217122405.18732-1-mark.cave-ayland@ilande.co.uk>
	<20181217122405.18732-5-mark.cave-ayland@ilande.co.uk>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <2bd3dead-354e-31ca-bc19-fb1ed3191f15@linaro.org>
Date: Mon, 17 Dec 2018 08:46:17 -0800
MIME-Version: 1.0
In-Reply-To: <20181217122405.18732-5-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH v2 4/9] target/ppc: delay writeback of
 avr{l, h} during lvx instruction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, lvivier@redhat.com

On 12/17/18 4:24 AM, Mark Cave-Ayland wrote:
> During review of the previous patch, Richard pointed out an existing bug that
> the writeback to the avr{l,h} registers should be delayed until after any
> exceptions have been raised.
> 
> Perform both 64-bit loads into separate temporaries and then write them into
> the avr{l,h} registers together to ensure that this is always the case.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>  target/ppc/translate/vmx-impl.inc.c | 24 +++++++++++++-----------
>  1 file changed, 13 insertions(+), 11 deletions(-)

I feel a bit silly.  There was no bug, since the address is forced to be
aligned on a 16-byte boundary.  The second memory access will be to the same
page and cannot trap.

That said, I think the cleanup looks good.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
