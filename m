Received: from eggs.gnu.org ([2001:4830:134:3::10]:48088)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ekG1W-0008V3-H1
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 16:15:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ekG1T-0001mP-Bm
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 16:15:58 -0500
Received: from mail-pl0-x243.google.com ([2607:f8b0:400e:c01::243]:45140)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ekG1T-0001mA-5p
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 16:15:55 -0500
Received: by mail-pl0-x243.google.com with SMTP id p5so2018584plo.12
	for <qemu-devel@nongnu.org>; Fri, 09 Feb 2018 13:15:55 -0800 (PST)
References: <20180209165810.6668-1-peter.maydell@linaro.org>
	<20180209165810.6668-12-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <2eb3c590-a93c-c2eb-d24a-9de5a2b19ca0@linaro.org>
Date: Fri, 9 Feb 2018 13:15:51 -0800
MIME-Version: 1.0
In-Reply-To: <20180209165810.6668-12-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 11/11] target/arm: Implement v8M MSPLIM
 and PSPLIM registers
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
> The v8M architecture includes hardware support for enforcing
> stack pointer limits. We don't implement this behaviour yet,
> but provide the MSPLIM and PSPLIM stack pointer limit registers
> as reads-as-written, so that when we do implement the checks
> in future this won't break guest migration.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/cpu.h     |  2 ++
>  target/arm/helper.c  | 46 ++++++++++++++++++++++++++++++++++++++++++++++
>  target/arm/machine.c | 21 +++++++++++++++++++++
>  3 files changed, 69 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
