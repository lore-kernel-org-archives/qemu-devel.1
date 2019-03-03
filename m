Received: from eggs.gnu.org ([209.51.188.92]:43231)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1h0aO7-00033e-27
	for qemu-devel@nongnu.org; Sun, 03 Mar 2019 18:19:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1h0aO5-0004r5-El
	for qemu-devel@nongnu.org; Sun, 03 Mar 2019 18:19:19 -0500
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:38953)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1h0aO4-0004nq-GU
	for qemu-devel@nongnu.org; Sun, 03 Mar 2019 18:19:17 -0500
Received: by mail-pg1-x544.google.com with SMTP id h8so1661325pgp.6
	for <qemu-devel@nongnu.org>; Sun, 03 Mar 2019 15:19:13 -0800 (PST)
References: <20190303172343.13406-1-mark.cave-ayland@ilande.co.uk>
	<20190303172343.13406-2-mark.cave-ayland@ilande.co.uk>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <bdf231c7-fbc0-4b4a-9887-b86201e19813@linaro.org>
Date: Sun, 3 Mar 2019 15:19:08 -0800
MIME-Version: 1.0
In-Reply-To: <20190303172343.13406-2-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/8] target/ppc: introduce single
 fpr_offset() function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au

On 3/3/19 9:23 AM, Mark Cave-Ayland wrote:
> Instead of having multiple copies of the offset calculation logic, move it to a
> single fpr_offset() function.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>  target/ppc/cpu.h       | 7 ++++++-
>  target/ppc/translate.c | 4 ++--
>  2 files changed, 8 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
