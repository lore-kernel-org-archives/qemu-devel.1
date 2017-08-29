Received: from eggs.gnu.org ([2001:4830:134:3::10]:46179)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dmiRc-0008ML-Oh
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 11:28:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dmiRZ-00021G-L2
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 11:28:48 -0400
Received: from mail-pg0-x230.google.com ([2607:f8b0:400e:c05::230]:35153)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dmiRZ-00020t-Fd
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 11:28:45 -0400
Received: by mail-pg0-x230.google.com with SMTP id 63so11744740pgc.2
	for <qemu-devel@nongnu.org>; Tue, 29 Aug 2017 08:28:45 -0700 (PDT)
References: <1503414539-28762-1-git-send-email-peter.maydell@linaro.org>
	<1503414539-28762-4-git-send-email-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <9af3401e-031a-3ae3-d2fc-315dab3ef9e1@linaro.org>
Date: Tue, 29 Aug 2017 08:28:41 -0700
MIME-Version: 1.0
In-Reply-To: <1503414539-28762-4-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 03/20] target/arm: Add state field,
 feature bit and migration for v8M secure state
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
> As the first step in implementing ARM v8M's security extension:
>  * add a new feature bit ARM_FEATURE_M_SECURITY
>  * add the CPU state field that indicates whether the CPU is
>    currently in the secure state
>  * add a migration subsection for this new state
>    (we will add the Secure copies of banked register state
>    to this subsection in later patches)
>  * add a #define for the one new-in-v8M exception type
>  * make the CPU debug log print S/NS status
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/cpu.h       |  3 +++
>  target/arm/cpu.c       |  4 ++++
>  target/arm/machine.c   | 20 ++++++++++++++++++++
>  target/arm/translate.c |  8 +++++++-
>  4 files changed, 34 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
