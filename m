Received: from eggs.gnu.org ([209.51.188.92]:38698)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1h208J-00033P-UU
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 16:00:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1h208J-0008BF-7e
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 16:00:51 -0500
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:44047)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1h208I-0008AO-Ts
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 16:00:51 -0500
Received: by mail-pg1-x543.google.com with SMTP id j3so12215639pgm.11
	for <qemu-devel@nongnu.org>; Thu, 07 Mar 2019 13:00:50 -0800 (PST)
References: <20190307180520.13868-1-mark.cave-ayland@ilande.co.uk>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <bbc08425-8ff8-e6ff-7d2d-5df508316469@linaro.org>
Date: Thu, 7 Mar 2019 13:00:46 -0800
MIME-Version: 1.0
In-Reply-To: <20190307180520.13868-1-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 0/7] target/ppc: switch fpr/vsrl
 registers so all VSX registers are in host endian order
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au

On 3/7/19 10:05 AM, Mark Cave-Ayland wrote:
> Finally now that all VSX registers are stored in the same way, the vsr offset
> functions and get_cpu_vsrh()/get_cpu_vsrl() can be simplified accordingly.

For the todo list for 4.1 should be getting rid of getVSR and setVSR.


r`
