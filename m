Received: from eggs.gnu.org ([2001:4830:134:3::10]:48382)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gWpdc-0001Pv-Ly
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 16:32:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gWpdZ-0000fl-GQ
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 16:32:20 -0500
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:44902)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gWpdZ-0000fS-0p
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 16:32:17 -0500
Received: by mail-oi1-x241.google.com with SMTP id m6so13269298oig.11
	for <qemu-devel@nongnu.org>; Tue, 11 Dec 2018 13:32:16 -0800 (PST)
References: <20181207085635.4291-1-mark.cave-ayland@ilande.co.uk>
	<alpine.BSF.2.21.9999.1812100112050.45639@zero.eik.bme.hu>
	<20181210025943.GE4261@umbus.fritz.box>
	<alpine.BSF.2.21.9999.1812102035360.24343@zero.eik.bme.hu>
	<20181211012027.GA4261@umbus.fritz.box>
	<7bcfc7ae-7777-e1e5-d1a4-36c2d958b845@ilande.co.uk>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <b9b3f1b9-4bda-9f32-8c36-e374d90fb0f1@linaro.org>
Date: Tue, 11 Dec 2018 15:32:11 -0600
MIME-Version: 1.0
In-Reply-To: <7bcfc7ae-7777-e1e5-d1a4-36c2d958b845@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-ppc] [RFC PATCH 0/6] target/ppc: convert VMX
 instructions to use TCG vector operations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, David Gibson <david@gibson.dropbear.id.au>, BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On 12/11/18 1:35 PM, Mark Cave-Ayland wrote:
> Looking at your profiles above, the primary hotspot appears to be
> helper_lookup_tb_ptr(). However as someone quite new to the TCG parts of QEMU, I
> couldn't tell you whether or not this is to be expected.
> 
> Perhaps a question for Richard: what could we consider to be a "normal" backend when
> looking at profiles in terms of recommended features to implement, and to get an idea
> of what a typical profile should look like?
> 
> It would be interesting to compare with a similar workload profile on e.g. ARM to see
> if there is anything obvious that stands out for PPC.

For Alpha, which has relatively sane tlb management, the top entry in the
profile is helper_lookup_tb_ptr at about 8%.  Otherwise, somewhere in the top 2
or 3 functions will be helper_le_ldq_mmu at about 2%.

That's probably a best-case scenario.


r~
