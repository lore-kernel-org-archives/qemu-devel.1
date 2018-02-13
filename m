Received: from eggs.gnu.org ([2001:4830:134:3::10]:50671)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1elcZK-0003Ed-7l
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 10:32:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1elcZG-0006Xe-5J
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 10:32:30 -0500
Received: from mail-pl0-x241.google.com ([2607:f8b0:400e:c01::241]:42601)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1elcZF-0006Wx-Tg
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 10:32:26 -0500
Received: by mail-pl0-x241.google.com with SMTP id 31so1276803ple.9
	for <qemu-devel@nongnu.org>; Tue, 13 Feb 2018 07:32:25 -0800 (PST)
References: <20180213132246.26844-1-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <7c13f354-1385-d528-44c7-20ed2c284b34@linaro.org>
Date: Tue, 13 Feb 2018 07:32:21 -0800
MIME-Version: 1.0
In-Reply-To: <20180213132246.26844-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] linux-user: Remove THREAD macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: patches@linaro.org, Laurent Vivier <laurent@vivier.eu>, Riku Voipio <riku.voipio@iki.fi>

On 02/13/2018 05:22 AM, Peter Maydell wrote:
> Back when we used to support compiling either with or without
> NPTL threading library support, we used a macro THREAD which would
> expand either to nothing (no thread support) or to __thread (threads
> supported). For a long time now we have required thread support,
> so remove the macro and just use __thread directly as other parts
> of QEMU do.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  linux-user/qemu.h | 4 +---
>  linux-user/main.c | 2 +-
>  2 files changed, 2 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
