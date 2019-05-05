Received: from eggs.gnu.org ([209.51.188.92]:51554)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hNJXP-00062F-Mq
	for qemu-devel@nongnu.org; Sun, 05 May 2019 11:58:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hNJXO-0000aa-R3
	for qemu-devel@nongnu.org; Sun, 05 May 2019 11:58:51 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634]:45834)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hNJXO-0000Zw-Ko
	for qemu-devel@nongnu.org; Sun, 05 May 2019 11:58:50 -0400
Received: by mail-pl1-x634.google.com with SMTP id a5so146846pls.12
	for <qemu-devel@nongnu.org>; Sun, 05 May 2019 08:58:50 -0700 (PDT)
References: <20190428143845.11810-1-mark.cave-ayland@ilande.co.uk>
	<20190428143845.11810-3-mark.cave-ayland@ilande.co.uk>
	<55204805-9275-2bc4-2c38-51dc87aa836d@linaro.org>
	<7227a96f-ae59-3ed4-8b1f-9e92005b4a69@ilande.co.uk>
	<626519f6-28c2-9870-0c6d-12869fbf57f1@linaro.org>
	<cf86b84d-bf12-7b50-267d-cb2897cfd20d@ilande.co.uk>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <1bf82942-f737-724e-978e-cc5061ecebb4@linaro.org>
Date: Sun, 5 May 2019 08:58:46 -0700
MIME-Version: 1.0
In-Reply-To: <cf86b84d-bf12-7b50-267d-cb2897cfd20d@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 02/14] target/ppc: remove getVSR()/putVSR()
 from mem_helper.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, rth@twiddle.net, gkurz@kaod.org

On 5/5/19 8:49 AM, Mark Cave-Ayland wrote:
> Okay in that case I'll leave it as-is. So just to satisfy my curiosity here: is the
> problem here the mixing and matching of offsets and TCG globals, rather than the use
> of offsets as done for the VMX/VSX registers?

Correct.


r~
