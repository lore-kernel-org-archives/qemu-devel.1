Received: from eggs.gnu.org ([209.51.188.92]:40460)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gnpsZ-0004w3-Ms
	for qemu-devel@nongnu.org; Sun, 27 Jan 2019 14:14:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gnpsX-0005HF-Mu
	for qemu-devel@nongnu.org; Sun, 27 Jan 2019 14:14:03 -0500
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:35073)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gnpsX-0005Gi-8f
	for qemu-devel@nongnu.org; Sun, 27 Jan 2019 14:14:01 -0500
Received: by mail-pg1-x541.google.com with SMTP id s198so6291112pgs.2
	for <qemu-devel@nongnu.org>; Sun, 27 Jan 2019 11:14:00 -0800 (PST)
References: <20190127090306.30826-1-mark.cave-ayland@ilande.co.uk>
	<20190127090306.30826-5-mark.cave-ayland@ilande.co.uk>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <a4d87525-9ef3-e163-4265-58b2ca23e4f7@linaro.org>
Date: Sun, 27 Jan 2019 11:13:56 -0800
MIME-Version: 1.0
In-Reply-To: <20190127090306.30826-5-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 4/8] target/ppc: eliminate use of HI_IDX
 and LO_IDX macros from int_helper.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au

On 1/27/19 1:03 AM, Mark Cave-Ayland wrote:
> The original purpose of these macros was to correctly reference the high and low
> parts of the VSRs regardless of the host endianness.
> 
> Replace these direct references to high and low parts with the relevant VsrD
> macro instead, and completely remove the now-unused HI_IDX and LO_IDX macros.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>  target/ppc/int_helper.c | 180 +++++++++++++++++++++++-------------------------
>  1 file changed, 85 insertions(+), 95 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
