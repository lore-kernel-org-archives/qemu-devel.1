Received: from eggs.gnu.org ([2001:4830:134:3::10]:35519)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ekFHg-0001hr-Gj
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 15:28:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ekFHd-0002M4-AT
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 15:28:36 -0500
Received: from mail-pl0-x242.google.com ([2607:f8b0:400e:c01::242]:44710)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ekFHd-0002Lr-45
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 15:28:33 -0500
Received: by mail-pl0-x242.google.com with SMTP id f8so1960395plk.11
	for <qemu-devel@nongnu.org>; Fri, 09 Feb 2018 12:28:33 -0800 (PST)
References: <20180209165810.6668-1-peter.maydell@linaro.org>
	<20180209165810.6668-2-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <aaa56b0f-ef7e-a617-8ffe-52bf55169491@linaro.org>
Date: Fri, 9 Feb 2018 12:28:29 -0800
MIME-Version: 1.0
In-Reply-To: <20180209165810.6668-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 01/11] hw/intc/armv7m_nvic: Don't
 hardcode M profile ID registers in NVIC
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
> Instead of hardcoding the values of M profile ID registers in the
> NVIC, use the fields in the CPU struct. This will allow us to
> give different M profile CPU types different ID register values.
> 
> This commit includes the addition of the missing ID_ISAR5,
> which exists as RES0 in both v7M and v8M.
> 
> (The values of the ID registers might be wrong for the M4 --
> this commit leaves the behaviour there unchanged.)
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  hw/intc/armv7m_nvic.c | 30 ++++++++++++++++--------------
>  target/arm/cpu.c      | 28 ++++++++++++++++++++++++++++
>  2 files changed, 44 insertions(+), 14 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
