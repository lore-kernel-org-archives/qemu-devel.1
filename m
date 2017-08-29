Received: from eggs.gnu.org ([2001:4830:134:3::10]:58698)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dmiyh-00067y-66
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 12:03:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dmiye-0001EM-23
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 12:02:59 -0400
Received: from mail-pf0-x22b.google.com ([2607:f8b0:400e:c00::22b]:33190)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dmiyd-0001DZ-SC
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 12:02:55 -0400
Received: by mail-pf0-x22b.google.com with SMTP id r62so11486276pfj.0
	for <qemu-devel@nongnu.org>; Tue, 29 Aug 2017 09:02:55 -0700 (PDT)
References: <1503414539-28762-1-git-send-email-peter.maydell@linaro.org>
	<1503414539-28762-13-git-send-email-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <f7aa0654-40cb-bef7-3963-d84c5ced9d21@linaro.org>
Date: Tue, 29 Aug 2017 09:02:51 -0700
MIME-Version: 1.0
In-Reply-To: <1503414539-28762-13-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 12/20] target/arm: Make MPU_MAIR0,
 MPU_MAIR1 registers banked for v8M
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
> Make the MPU registers MPU_MAIR0 and MPU_MAIR1 banked if v8M security
> extensions are enabled.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/cpu.h      | 4 ++--
>  hw/intc/armv7m_nvic.c | 8 ++++----
>  target/arm/cpu.c      | 4 ++--
>  target/arm/machine.c  | 6 ++++--
>  4 files changed, 12 insertions(+), 10 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
