Received: from eggs.gnu.org ([209.51.188.92]:52560)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gvQmQ-0000zG-78
	for qemu-devel@nongnu.org; Sun, 17 Feb 2019 13:03:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gvQmP-00074X-IS
	for qemu-devel@nongnu.org; Sun, 17 Feb 2019 13:03:06 -0500
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:42338)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gvQmP-00074B-BY
	for qemu-devel@nongnu.org; Sun, 17 Feb 2019 13:03:05 -0500
Received: by mail-pg1-x542.google.com with SMTP id b2so1535863pgl.9
	for <qemu-devel@nongnu.org>; Sun, 17 Feb 2019 10:03:05 -0800 (PST)
References: <20190214125107.22178-1-peter.maydell@linaro.org>
	<20190214125107.22178-10-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <78c3ece6-248d-4cac-467c-7a4b45d4bb18@linaro.org>
Date: Sun, 17 Feb 2019 10:03:00 -0800
MIME-Version: 1.0
In-Reply-To: <20190214125107.22178-10-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 09/14] hw/arm/armsse: Allow boards to
 specify init-svtor
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

On 2/14/19 4:51 AM, Peter Maydell wrote:
> The Musca boards have DAPLink firmware that sets the initial
> secure VTOR value (the location of the vector table) differently
> depending on the boot mode (from flash, from RAM, etc). Export
> the init-svtor as a QOM property of the ARMSSE object so that
> the board can change it.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  include/hw/arm/armsse.h | 3 +++
>  hw/arm/armsse.c         | 8 ++++----
>  2 files changed, 7 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~
