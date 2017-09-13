Received: from eggs.gnu.org ([2001:4830:134:3::10]:43436)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dsA3N-0004Nc-4c
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 11:58:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dsA3M-00021r-DW
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 11:58:17 -0400
Received: from mail-pg0-x22a.google.com ([2607:f8b0:400e:c05::22a]:43997)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dsA3M-00021e-7Q
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 11:58:16 -0400
Received: by mail-pg0-x22a.google.com with SMTP id u18so1187916pgo.0
	for <qemu-devel@nongnu.org>; Wed, 13 Sep 2017 08:58:16 -0700 (PDT)
References: <1505137930-13255-1-git-send-email-peter.maydell@linaro.org>
	<1505137930-13255-5-git-send-email-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <51e485a4-6557-717c-fa18-7e46033f8f73@linaro.org>
Date: Wed, 13 Sep 2017 08:58:12 -0700
MIME-Version: 1.0
In-Reply-To: <1505137930-13255-5-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 4/7] nvic: Don't apply group priority mask
 to negative priorities
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

On 09/11/2017 06:52 AM, Peter Maydell wrote:
> In several places we were unconditionally applying the
> nvic_gprio_mask() to a priority value. This is incorrect
> if the priority is one of the fixed negative priority
> values (for NMI and HardFault), so don't do it.
> 
> This bug would have caused both NMI and HardFault to be
> considered as the same priority and so NMI wouldn't
> correctly preempt HardFault.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/intc/armv7m_nvic.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
