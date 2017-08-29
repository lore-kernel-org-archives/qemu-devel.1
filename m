Received: from eggs.gnu.org ([2001:4830:134:3::10]:44062)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dmiKb-0004aH-QG
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 11:21:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dmiKY-0007YO-NI
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 11:21:33 -0400
Received: from mail-pg0-x22a.google.com ([2607:f8b0:400e:c05::22a]:33018)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dmiKY-0007Xu-Gn
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 11:21:30 -0400
Received: by mail-pg0-x22a.google.com with SMTP id t3so11774365pgt.0
	for <qemu-devel@nongnu.org>; Tue, 29 Aug 2017 08:21:30 -0700 (PDT)
References: <1503414539-28762-1-git-send-email-peter.maydell@linaro.org>
	<1503414539-28762-2-git-send-email-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <54b68f0d-5ef2-7d1c-3c1a-5b114dfb4921@linaro.org>
Date: Tue, 29 Aug 2017 08:21:26 -0700
MIME-Version: 1.0
In-Reply-To: <1503414539-28762-2-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 01/20] target/arm: Implement ARMv8M's
 PMSAv8 registers
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
> As part of ARMv8M, we need to add support for the PMSAv8 MPU
> architecture.
> 
> PMSAv8 differs from PMSAv7 both in register/data layout (for instance
> using base and limit registers rather than base and size) and also in
> behaviour (for example it does not have subregions); rather than
> trying to wedge it into the existing PMSAv7 code and data structures,
> we define separate ones.
> 
> This commit adds the data structures which hold the state for a
> PMSAv8 MPU and the register interface to it.  The implementation of
> the MPU behaviour will be added in a subsequent commit.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/cpu.h      |  13 ++++++
>  hw/intc/armv7m_nvic.c | 122 ++++++++++++++++++++++++++++++++++++++++++++++----
>  target/arm/cpu.c      |  36 ++++++++++-----
>  target/arm/machine.c  |  28 +++++++++++-
>  4 files changed, 179 insertions(+), 20 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
