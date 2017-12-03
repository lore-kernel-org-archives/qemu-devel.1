Received: from eggs.gnu.org ([2001:4830:134:3::10]:34729)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eLWl5-0006bN-Tg
	for qemu-devel@nongnu.org; Sun, 03 Dec 2017 11:04:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eLWl1-0002WT-06
	for qemu-devel@nongnu.org; Sun, 03 Dec 2017 11:04:47 -0500
Received: from mail-pg0-x232.google.com ([2607:f8b0:400e:c05::232]:40780)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eLWl0-0002WL-P9
	for qemu-devel@nongnu.org; Sun, 03 Dec 2017 11:04:42 -0500
Received: by mail-pg0-x232.google.com with SMTP id k15so6529067pgr.7
	for <qemu-devel@nongnu.org>; Sun, 03 Dec 2017 08:04:42 -0800 (PST)
References: <1512153879-5291-1-git-send-email-peter.maydell@linaro.org>
	<1512153879-5291-8-git-send-email-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <b647f571-fffb-1f40-9bf4-74d1f97fc8f8@linaro.org>
Date: Sun, 3 Dec 2017 08:04:38 -0800
MIME-Version: 1.0
In-Reply-To: <1512153879-5291-8-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 7/7] target/arm: Implement TT instruction
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
> Implement the TT instruction which queries the security
> state and access permissions of a memory location.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/helper.h    |   2 +
>  target/arm/helper.c    | 108 +++++++++++++++++++++++++++++++++++++++++++++++++
>  target/arm/translate.c |  29 ++++++++++++-
>  3 files changed, 138 insertions(+), 1 deletion(-)


Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
