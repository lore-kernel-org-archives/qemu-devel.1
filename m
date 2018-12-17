Received: from eggs.gnu.org ([2001:4830:134:3::10]:58286)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gYvzq-0007VP-1g
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 11:43:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gYvzl-0001g3-6l
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 11:43:57 -0500
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:45694)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gYvzj-0001ds-5r
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 11:43:52 -0500
Received: by mail-pl1-x644.google.com with SMTP id a14so6379507plm.12
	for <qemu-devel@nongnu.org>; Mon, 17 Dec 2018 08:43:49 -0800 (PST)
References: <20181217122405.18732-1-mark.cave-ayland@ilande.co.uk>
	<20181217122405.18732-4-mark.cave-ayland@ilande.co.uk>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <f5d91e6a-b72a-4882-2184-e74398530deb@linaro.org>
Date: Mon, 17 Dec 2018 08:43:46 -0800
MIME-Version: 1.0
In-Reply-To: <20181217122405.18732-4-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH v2 3/9] target/ppc: introduce
 get_cpu_vsr{l, h}() and set_cpu_vsr{l, h}() helpers for VSR register access
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
> These helpers allow us to move VSR register values to/from the specified TCGv_i64
> argument.
> 
> To prevent VSX helpers accessing the cpu_vsr array directly, add extra TCG
> temporaries as required.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>  target/ppc/translate/vsx-impl.inc.c | 782 ++++++++++++++++++++++++++----------
>  1 file changed, 561 insertions(+), 221 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
