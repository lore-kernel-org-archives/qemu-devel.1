Received: from eggs.gnu.org ([2001:4830:134:3::10]:37804)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gG3dQ-0001S4-5u
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 11:02:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gG3dK-0007xX-L8
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 11:02:48 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335]:51743)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gG3dK-0007tq-Cp
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 11:02:42 -0400
Received: by mail-wm1-x335.google.com with SMTP id 143-v6so1816773wmf.1
	for <qemu-devel@nongnu.org>; Fri, 26 Oct 2018 08:02:41 -0700 (PDT)
References: <20181025144644.15464-1-cota@braap.org>
	<20181025144644.15464-17-cota@braap.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <ae9c24a9-cafa-11cd-9daa-6e0885913b9d@linaro.org>
Date: Fri, 26 Oct 2018 16:02:37 +0100
MIME-Version: 1.0
In-Reply-To: <20181025144644.15464-17-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v4 17/71] ppc: convert to cpu_halted
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org

On 10/25/18 3:45 PM, Emilio G. Cota wrote:
> In ppce500_spin.c, acquire the lock just once to update
> both cpu->halted and cpu->stopped.
> 
> In hw/ppc/spapr_hcall.c, acquire the lock just once to
> update cpu->halted and call cpu_has_work, since later
> in the series we'll acquire the BQL (if not already held)
> from cpu_has_work.
> 
> Cc: David Gibson <david@gibson.dropbear.id.au>
> Cc: Alexander Graf <agraf@suse.de>
> Cc: qemu-ppc@nongnu.org
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~
