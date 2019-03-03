Received: from eggs.gnu.org ([209.51.188.92]:46420)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1h0abw-0008K1-Bl
	for qemu-devel@nongnu.org; Sun, 03 Mar 2019 18:33:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1h0abv-0004Rx-P2
	for qemu-devel@nongnu.org; Sun, 03 Mar 2019 18:33:36 -0500
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:40204)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1h0abv-0004Qn-Hf
	for qemu-devel@nongnu.org; Sun, 03 Mar 2019 18:33:35 -0500
Received: by mail-pg1-x543.google.com with SMTP id u9so1675579pgo.7
	for <qemu-devel@nongnu.org>; Sun, 03 Mar 2019 15:33:35 -0800 (PST)
References: <20190303172343.13406-1-mark.cave-ayland@ilande.co.uk>
	<20190303172343.13406-8-mark.cave-ayland@ilande.co.uk>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <ef383e24-2a66-10c4-b328-5177719b268d@linaro.org>
Date: Sun, 3 Mar 2019 15:33:31 -0800
MIME-Version: 1.0
In-Reply-To: <20190303172343.13406-8-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 7/8] target/ppc: introduce vsrh_offset()
 function
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
> -static inline int fpr_offset(int i)
> +static inline int vsrh_offset(int i)

I don't agree with this.  The original is clearer for its uses.


r~
