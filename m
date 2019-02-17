Received: from eggs.gnu.org ([209.51.188.92]:51435)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gvQge-0006no-D6
	for qemu-devel@nongnu.org; Sun, 17 Feb 2019 12:57:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gvQgc-0001xy-Hm
	for qemu-devel@nongnu.org; Sun, 17 Feb 2019 12:57:08 -0500
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:36754)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gvQgc-0001wt-7q
	for qemu-devel@nongnu.org; Sun, 17 Feb 2019 12:57:06 -0500
Received: by mail-pg1-x541.google.com with SMTP id r124so7273372pgr.3
	for <qemu-devel@nongnu.org>; Sun, 17 Feb 2019 09:57:06 -0800 (PST)
References: <20190214125107.22178-1-peter.maydell@linaro.org>
	<20190214125107.22178-6-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <f90b5e4f-f388-b167-5d2b-51c8598d0abb@linaro.org>
Date: Sun, 17 Feb 2019 09:57:00 -0800
MIME-Version: 1.0
In-Reply-To: <20190214125107.22178-6-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 05/14] hw/char/pl011: Allow use as an
 embedded-struct device
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

On 2/14/19 4:50 AM, Peter Maydell wrote:
> Create a new include file for the pl011's device struct,
> type macros, etc, so that it can be instantiated using
> the "embedded struct" coding style.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  include/hw/char/pl011.h | 34 ++++++++++++++++++++++++++++++++++
>  hw/char/pl011.c         | 31 ++-----------------------------
>  2 files changed, 36 insertions(+), 29 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~
