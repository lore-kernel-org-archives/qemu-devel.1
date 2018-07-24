Received: from eggs.gnu.org ([2001:4830:134:3::10]:45136)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fi27z-000728-Bj
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 14:33:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fi27y-0001Sx-MT
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 14:33:43 -0400
Received: from mail-pl0-x241.google.com ([2607:f8b0:400e:c01::241]:39201)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fi27y-0001Rz-Dk
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 14:33:42 -0400
Received: by mail-pl0-x241.google.com with SMTP id m1-v6so2133332plt.6
	for <qemu-devel@nongnu.org>; Tue, 24 Jul 2018 11:33:42 -0700 (PDT)
References: <20180724115950.17316-1-peter.maydell@linaro.org>
	<20180724115950.17316-2-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <45ea5494-fbc5-33da-0538-23c94c4125cf@linaro.org>
Date: Tue, 24 Jul 2018 11:33:38 -0700
MIME-Version: 1.0
In-Reply-To: <20180724115950.17316-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/5] target/arm: Mask virtual interrupts if
 HCR_EL2.TGE is set
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

On 07/24/2018 04:59 AM, Peter Maydell wrote:
> If the "trap general exceptions" bit HCR_EL2.TGE is set, we
> must mask all virtual interrupts (as per DDI0487C.a D1.14.3).
> Implement this in arm_excp_unmasked().
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/cpu.h | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
