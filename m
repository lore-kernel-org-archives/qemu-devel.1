Received: from eggs.gnu.org ([2001:4830:134:3::10]:57263)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gYvwk-0006VS-Cp
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 11:40:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gYvwf-00077L-5U
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 11:40:46 -0500
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:39150)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gYvwe-00074E-A1
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 11:40:40 -0500
Received: by mail-pl1-x644.google.com with SMTP id 101so6390721pld.6
	for <qemu-devel@nongnu.org>; Mon, 17 Dec 2018 08:40:37 -0800 (PST)
References: <20181217122405.18732-1-mark.cave-ayland@ilande.co.uk>
	<20181217122405.18732-2-mark.cave-ayland@ilande.co.uk>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <06de2004-b85c-bf5d-844c-c15fe78efe63@linaro.org>
Date: Mon, 17 Dec 2018 08:40:33 -0800
MIME-Version: 1.0
In-Reply-To: <20181217122405.18732-2-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH v2 1/9] target/ppc: introduce get_fpr()
 and set_fpr() helpers for FP register access
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, lvivier@redhat.com

On 12/17/18 4:23 AM, Mark Cave-Ayland wrote:
> These helpers allow us to move FP register values to/from the specified TCGv_i64
> argument in the VSR helpers to be introduced shortly.
> 
> To prevent FP helpers accessing the cpu_fpr array directly, add extra TCG
> temporaries as required.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>  target/ppc/translate.c             |  10 +
>  target/ppc/translate/fp-impl.inc.c | 490 ++++++++++++++++++++++++++++---------
>  2 files changed, 390 insertions(+), 110 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
