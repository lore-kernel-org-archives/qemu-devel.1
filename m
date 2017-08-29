Received: from eggs.gnu.org ([2001:4830:134:3::10]:58110)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dmiyA-0005hV-AL
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 12:02:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dmiy6-0000d5-EB
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 12:02:26 -0400
Received: from mail-pg0-x22a.google.com ([2607:f8b0:400e:c05::22a]:34485)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dmiy6-0000cd-8m
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 12:02:22 -0400
Received: by mail-pg0-x22a.google.com with SMTP id y15so12086959pgc.1
	for <qemu-devel@nongnu.org>; Tue, 29 Aug 2017 09:02:22 -0700 (PDT)
References: <1503414539-28762-1-git-send-email-peter.maydell@linaro.org>
	<1503414539-28762-12-git-send-email-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <4f8b56f1-7bd3-6485-37f4-02de5af5f90c@linaro.org>
Date: Tue, 29 Aug 2017 09:02:18 -0700
MIME-Version: 1.0
In-Reply-To: <1503414539-28762-12-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 11/20] target/arm: Make VTOR register
 banked for v8M
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

On 08/22/2017 08:08 AM, Peter Maydell wrote:
> Make the VTOR register banked if v8M security extensions are enabled.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/cpu.h      |  2 +-
>  hw/intc/armv7m_nvic.c | 13 +++++++------
>  target/arm/helper.c   |  2 +-
>  target/arm/machine.c  |  3 ++-
>  4 files changed, 11 insertions(+), 9 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
