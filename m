Received: from eggs.gnu.org ([209.51.188.92]:49957)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gvQZd-0002qk-F1
	for qemu-devel@nongnu.org; Sun, 17 Feb 2019 12:49:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gvQZc-0002m8-KU
	for qemu-devel@nongnu.org; Sun, 17 Feb 2019 12:49:53 -0500
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:34480)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gvQZc-0002l4-C7
	for qemu-devel@nongnu.org; Sun, 17 Feb 2019 12:49:52 -0500
Received: by mail-pl1-x644.google.com with SMTP id d15so404526plr.1
	for <qemu-devel@nongnu.org>; Sun, 17 Feb 2019 09:49:52 -0800 (PST)
References: <20190214113408.10214-1-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <32ee50a4-f8cd-ffce-6b42-4611611b2e34@linaro.org>
Date: Sun, 17 Feb 2019 09:49:48 -0800
MIME-Version: 1.0
In-Reply-To: <20190214113408.10214-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] target/arm: v8M MPU should use background
 region as default, not always
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

On 2/14/19 3:34 AM, Peter Maydell wrote:
> The "background region" for a v8M MPU is a default which will be used
> (if enabled, and if the access is privileged) if the access does
> not match any specific MPU region. We were incorrectly using it
> always (by putting the condition at the wrong nesting level). This
> meant that we would always return the default background permissions
> rather than the correct permissions for a specific region, and also
> that we would not return the right information in response to a
> TT instruction.
> 
> Move the check for the background region to the same place in the
> logic as the equivalent v8M MPUCheck() pseudocode puts it.
> This in turn means we must adjust the condition we use to detect
> matches in multiple regions to avoid false-positives.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> I found this because the incorrect TT response eventually resulted
> in the Zephyr RTOS writing an invalid region number back to the
> NVIC and tripping the guest_errors logging.
> ---
>  target/arm/helper.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~
