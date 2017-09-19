Received: from eggs.gnu.org ([2001:4830:134:3::10]:44077)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1duNkf-0003wK-VG
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 15:00:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1duNkc-0004Ld-Mh
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 15:00:10 -0400
Received: from mail-io0-x22c.google.com ([2607:f8b0:4001:c06::22c]:51087)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1duNkc-0004LH-Gu
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 15:00:06 -0400
Received: by mail-io0-x22c.google.com with SMTP id w94so1408119ioi.7
	for <qemu-devel@nongnu.org>; Tue, 19 Sep 2017 12:00:06 -0700 (PDT)
References: <1505240046-11454-1-git-send-email-peter.maydell@linaro.org>
	<1505240046-11454-15-git-send-email-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <0414513a-a050-f16c-94b4-24da7dd49972@linaro.org>
Date: Tue, 19 Sep 2017 13:59:58 -0500
MIME-Version: 1.0
In-Reply-To: <1505240046-11454-15-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 14/19] nvic: Disable the non-secure
 HardFault if AIRCR.BFHFNMINS is clear
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

On 09/12/2017 01:14 PM, Peter Maydell wrote:
> If AIRCR.BFHFNMINS is clear, then although NonSecure HardFault
> can still be pended via SHCSR.HARDFAULTPENDED it mustn't actually
> preempt execution. The simple way to achieve this is to clear the
> enable bit for it, since the enable bit isn't guest visible.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/intc/armv7m_nvic.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~
