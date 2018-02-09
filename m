Received: from eggs.gnu.org ([2001:4830:134:3::10]:44423)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ekFpv-00015S-3C
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 16:03:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ekFpr-0001vC-2o
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 16:03:59 -0500
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244]:34088)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ekFpq-0001ur-TQ
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 16:03:55 -0500
Received: by mail-pg0-x244.google.com with SMTP id s73so4404633pgc.1
	for <qemu-devel@nongnu.org>; Fri, 09 Feb 2018 13:03:54 -0800 (PST)
References: <20180209165810.6668-1-peter.maydell@linaro.org>
	<20180209165810.6668-7-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <d1ebb592-a60c-4188-56e5-83ce4b90fab8@linaro.org>
Date: Fri, 9 Feb 2018 13:03:51 -0800
MIME-Version: 1.0
In-Reply-To: <20180209165810.6668-7-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 06/11] hw/intc/armv7m_nvic: Implement SCR
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

On 02/09/2018 08:58 AM, Peter Maydell wrote:
> We were previously making the system control register (SCR)
> just RAZ/WI. Although we don't implement the functionality
> this register controls, we should at least provide the state,
> including the banked state for v8M.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/cpu.h      |  7 +++++++
>  hw/intc/armv7m_nvic.c | 12 ++++++++----
>  target/arm/machine.c  | 12 ++++++++++++
>  3 files changed, 27 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
