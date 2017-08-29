Received: from eggs.gnu.org ([2001:4830:134:3::10]:59891)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dmj1s-0000YP-SD
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 12:06:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dmj1n-00033f-CV
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 12:06:16 -0400
Received: from mail-pg0-x22f.google.com ([2607:f8b0:400e:c05::22f]:36068)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dmj1n-00032l-6P
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 12:06:11 -0400
Received: by mail-pg0-x22f.google.com with SMTP id r133so12032220pgr.3
	for <qemu-devel@nongnu.org>; Tue, 29 Aug 2017 09:06:11 -0700 (PDT)
References: <1503414539-28762-1-git-send-email-peter.maydell@linaro.org>
	<1503414539-28762-16-git-send-email-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <2fb5131c-e4a5-3700-4fad-f4fbfb0a23d8@linaro.org>
Date: Tue, 29 Aug 2017 09:06:07 -0700
MIME-Version: 1.0
In-Reply-To: <1503414539-28762-16-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 15/20] target/arm: Make MPU_CTRL register
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
> Make the MPU_CTRL register banked if v8M security extensions are
> enabled.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/cpu.h      | 2 +-
>  hw/intc/armv7m_nvic.c | 9 +++++----
>  target/arm/helper.c   | 5 +++--
>  target/arm/machine.c  | 3 ++-
>  4 files changed, 11 insertions(+), 8 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
