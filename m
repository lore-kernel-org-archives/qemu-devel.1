Received: from eggs.gnu.org ([2001:4830:134:3::10]:34451)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dmj8A-0005pC-Mc
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 12:12:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dmj86-0006XX-TE
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 12:12:46 -0400
Received: from mail-pg0-x22d.google.com ([2607:f8b0:400e:c05::22d]:33751)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dmj86-0006X3-OM
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 12:12:42 -0400
Received: by mail-pg0-x22d.google.com with SMTP id t3so12171141pgt.0
	for <qemu-devel@nongnu.org>; Tue, 29 Aug 2017 09:12:42 -0700 (PDT)
References: <1503414539-28762-1-git-send-email-peter.maydell@linaro.org>
	<1503414539-28762-19-git-send-email-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <4cdccf07-6786-2e01-04c1-1c06151acd5a@linaro.org>
Date: Tue, 29 Aug 2017 09:12:39 -0700
MIME-Version: 1.0
In-Reply-To: <1503414539-28762-19-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 18/20] target/arm: Make CFSR register
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
> Make the CFSR register banked if v8M security extensions are enabled.
> 
> Not all the bits in this register are banked: the BFSR
> bits [15:8] are shared between S and NS, and we store them
> in the NS copy of the register.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/cpu.h      |  7 ++++++-
>  hw/intc/armv7m_nvic.c | 15 +++++++++++++--
>  target/arm/helper.c   | 18 +++++++++---------
>  target/arm/machine.c  |  3 ++-
>  4 files changed, 30 insertions(+), 13 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
