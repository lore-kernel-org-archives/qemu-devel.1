Received: from eggs.gnu.org ([2001:4830:134:3::10]:48266)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1duN7O-0000vg-Fi
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 14:19:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1duN7L-0002gw-6w
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 14:19:34 -0400
Received: from mail-io0-x231.google.com ([2607:f8b0:4001:c06::231]:54253)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1duN7K-0002fa-Vn
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 14:19:31 -0400
Received: by mail-io0-x231.google.com with SMTP id q11so1109607ioe.10
	for <qemu-devel@nongnu.org>; Tue, 19 Sep 2017 11:19:30 -0700 (PDT)
References: <1505240046-11454-1-git-send-email-peter.maydell@linaro.org>
	<1505240046-11454-8-git-send-email-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <712822df-6575-070a-a7fa-5ed9298ab2a7@linaro.org>
Date: Tue, 19 Sep 2017 13:19:26 -0500
MIME-Version: 1.0
In-Reply-To: <1505240046-11454-8-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 07/19] nvic: Implement NVIC_ITNS<n>
 registers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org

On 09/12/2017 01:13 PM, Peter Maydell wrote:
> For v8M, the NVIC has a new set of registers per interrupt,
> NVIC_ITNS<n>. These determine whether the interrupt targets Secure
> or Non-secure state. Implement the register read/write code for
> these, and make them cause NVIC_IABR, NVIC_ICER, NVIC_ISER,
> NVIC_ICPR, NVIC_IPR and NVIC_ISPR to RAZ/WI for non-secure
> accesses to fields corresponding to interrupts which are
> configured to target secure state.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>


Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

> +            s->itns[startvec + i] = value & (1 << i);

It probably doesn't matter, since a functioning C99 compiler will do this
transformation during conversion to bool, but (value >> i) & 1.


r~
