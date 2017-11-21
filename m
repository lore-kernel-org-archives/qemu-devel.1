Received: from eggs.gnu.org ([2001:4830:134:3::10]:55560)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eHEju-0004N0-H0
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 15:01:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eHEjp-0001Vk-NK
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 15:01:50 -0500
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:42665)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eHEjp-0001V1-Gc
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 15:01:45 -0500
Received: by mail-wm0-x244.google.com with SMTP id l188so4124716wma.1
	for <qemu-devel@nongnu.org>; Tue, 21 Nov 2017 12:01:45 -0800 (PST)
References: <1511276851-17680-1-git-send-email-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <d7501f95-225c-b423-3dde-8f9bb04aadd0@linaro.org>
Date: Tue, 21 Nov 2017 21:01:38 +0100
MIME-Version: 1.0
In-Reply-To: <1511276851-17680-1-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] accel/tcg/cpu-exec-common.c: Remove
 unnecessary include of memory-internal.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org
Cc: patches@linaro.org

On 11/21/2017 04:07 PM, Peter Maydell wrote:
> The cpu-exec-common.c file includes memory-internal.h, but it doesn't
> actually use anything from that header. Remove the unnecessary include.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  accel/tcg/cpu-exec-common.c | 1 -
>  1 file changed, 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
