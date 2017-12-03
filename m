Received: from eggs.gnu.org ([2001:4830:134:3::10]:49583)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eLVol-00078Y-1j
	for qemu-devel@nongnu.org; Sun, 03 Dec 2017 10:04:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eLVoh-0002gr-VC
	for qemu-devel@nongnu.org; Sun, 03 Dec 2017 10:04:31 -0500
Received: from mail-pg0-x229.google.com ([2607:f8b0:400e:c05::229]:35813)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eLVoh-0002gP-Oc
	for qemu-devel@nongnu.org; Sun, 03 Dec 2017 10:04:27 -0500
Received: by mail-pg0-x229.google.com with SMTP id q20so6504271pgv.2
	for <qemu-devel@nongnu.org>; Sun, 03 Dec 2017 07:04:27 -0800 (PST)
References: <1512153879-5291-1-git-send-email-peter.maydell@linaro.org>
	<1512153879-5291-4-git-send-email-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <228027a9-1b2e-82a5-64a0-bd70e6c93a29@linaro.org>
Date: Sun, 3 Dec 2017 07:04:24 -0800
MIME-Version: 1.0
In-Reply-To: <1512153879-5291-4-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 3/7] target/arm: Add missing M profile case
 to regime_is_user()
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
> When we added the ARMMMUIdx_MSUser MMU index we forgot to
> add it to the case statement in regime_is_user(), so we
> weren't treating it as unprivileged when doing MPU lookups.
> Correct the omission.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/helper.c | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
