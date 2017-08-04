Received: from eggs.gnu.org ([2001:4830:134:3::10]:55472)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ddjBV-0000YV-44
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 16:27:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ddjBR-00012x-74
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 16:27:01 -0400
Received: from mail-pg0-x229.google.com ([2607:f8b0:400e:c05::229]:37670)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ddjBR-00012b-11
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 16:26:57 -0400
Received: by mail-pg0-x229.google.com with SMTP id y129so11933244pgy.4
	for <qemu-devel@nongnu.org>; Fri, 04 Aug 2017 13:26:56 -0700 (PDT)
References: <1501867249-1924-1-git-send-email-peter.maydell@linaro.org>
	<1501867249-1924-9-git-send-email-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <17d709e6-7f71-1d5b-1bdd-57b0323d2bcb@linaro.org>
Date: Fri, 4 Aug 2017 13:26:53 -0700
MIME-Version: 1.0
In-Reply-To: <1501867249-1924-9-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 8/8] target/arm: Implement new
 do_transaction_failed hook
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

On 08/04/2017 10:20 AM, Peter Maydell wrote:
> Implement the new do_transaction_failed hook for ARM, which should
> cause the CPU to take a prefetch abort or data abort.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/internals.h | 10 ++++++++++
>  target/arm/cpu.c       |  1 +
>  target/arm/op_helper.c | 43 +++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 54 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
