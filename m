Received: from eggs.gnu.org ([2001:4830:134:3::10]:55288)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dvYOb-0002C2-DT
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 20:34:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dvYOY-0004ye-99
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 20:34:13 -0400
Received: from mail-oi0-x231.google.com ([2607:f8b0:4003:c06::231]:52038)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dvYOY-0004yM-3i
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 20:34:10 -0400
Received: by mail-oi0-x231.google.com with SMTP id f195so688760oih.8
	for <qemu-devel@nongnu.org>; Fri, 22 Sep 2017 17:34:09 -0700 (PDT)
References: <1506092407-26985-1-git-send-email-peter.maydell@linaro.org>
	<1506092407-26985-2-git-send-email-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <eeaae730-0316-5559-be2f-76499b87ae08@linaro.org>
Date: Fri, 22 Sep 2017 19:34:04 -0500
MIME-Version: 1.0
In-Reply-To: <1506092407-26985-2-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 01/20] nvic: Clear the vector arrays and
 prigroup on reset
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

On 09/22/2017 09:59 AM, Peter Maydell wrote:
> Reset for devices does not include an automatic clear of the
> device state (unlike CPU state, where most of the state
> structure is cleared to zero). Add some missing initialization
> of NVIC state that meant that the device was left in the wrong
> state if the guest did a warm reset.
> 
> (In particular, since we were resetting the computed state like
> s->exception_prio but not all the state it was computed
> from like s->vectors[x].active, the NVIC wound up in an
> inconsistent state that could later trigger assertion failures.)
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/intc/armv7m_nvic.c | 5 +++++
>  1 file changed, 5 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
