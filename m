Received: from eggs.gnu.org ([2001:4830:134:3::10]:33672)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dmj6S-0004VN-8h
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 12:11:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dmj6P-0005bK-2h
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 12:11:00 -0400
Received: from mail-pf0-x235.google.com ([2607:f8b0:400e:c00::235]:33925)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dmj6O-0005Ze-Sn
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 12:10:56 -0400
Received: by mail-pf0-x235.google.com with SMTP id l87so1694072pfj.1
	for <qemu-devel@nongnu.org>; Tue, 29 Aug 2017 09:10:56 -0700 (PDT)
References: <1503414539-28762-1-git-send-email-peter.maydell@linaro.org>
	<1503414539-28762-18-git-send-email-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <dfd92b0b-45c5-cdb3-702c-c746d77d74ab@linaro.org>
Date: Tue, 29 Aug 2017 09:10:53 -0700
MIME-Version: 1.0
In-Reply-To: <1503414539-28762-18-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 17/20] target/arm: Make MMFAR banked for v8M
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
> Make the MMFAR register banked if v8M security extensions are
> enabled.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/cpu.h      | 2 +-
>  hw/intc/armv7m_nvic.c | 4 ++--
>  target/arm/helper.c   | 4 ++--
>  target/arm/machine.c  | 3 ++-
>  4 files changed, 7 insertions(+), 6 deletions(-)


Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
