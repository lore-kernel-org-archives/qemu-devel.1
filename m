Received: from eggs.gnu.org ([2001:4830:134:3::10]:51201)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eLVwA-0001jR-4z
	for qemu-devel@nongnu.org; Sun, 03 Dec 2017 10:12:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eLVw5-0007Di-6d
	for qemu-devel@nongnu.org; Sun, 03 Dec 2017 10:12:10 -0500
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244]:44292)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eLVw5-0007DE-1l
	for qemu-devel@nongnu.org; Sun, 03 Dec 2017 10:12:05 -0500
Received: by mail-pg0-x244.google.com with SMTP id j9so6501828pgc.11
	for <qemu-devel@nongnu.org>; Sun, 03 Dec 2017 07:12:04 -0800 (PST)
References: <1512153879-5291-1-git-send-email-peter.maydell@linaro.org>
	<1512153879-5291-6-git-send-email-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <1712a666-876d-a174-aaf4-94a85ee71d22@linaro.org>
Date: Sun, 3 Dec 2017 07:12:01 -0800
MIME-Version: 1.0
In-Reply-To: <1512153879-5291-6-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 5/7] target/arm: Create new
 arm_v7m_mmu_idx_for_secstate_and_priv()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

On 12/01/2017 10:44 AM, Peter Maydell wrote:
> The TT instruction is going to need to look up the MMU index
> for a specified security and privilege state. Refactor the
> existing arm_v7m_mmu_idx_for_secstate() into a version that
> lets you specify the privilege state and one that uses the
> current state of the CPU.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/cpu.h | 21 ++++++++++++++++-----
>  1 file changed, 16 insertions(+), 5 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
