Received: from eggs.gnu.org ([2001:4830:134:3::10]:46600)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e090T-0005lB-G1
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 12:28:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e090S-0006JV-Lo
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 12:28:17 -0400
Received: from mail-qt0-x231.google.com ([2607:f8b0:400d:c0d::231]:48426)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e090S-0006J8-GZ
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 12:28:16 -0400
Received: by mail-qt0-x231.google.com with SMTP id d13so25757735qta.5
	for <qemu-devel@nongnu.org>; Thu, 05 Oct 2017 09:28:16 -0700 (PDT)
References: <1506092407-26985-1-git-send-email-peter.maydell@linaro.org>
	<1506092407-26985-8-git-send-email-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <021427db-f8cb-9416-31bb-85f0bbb80e2d@linaro.org>
Date: Thu, 5 Oct 2017 12:28:13 -0400
MIME-Version: 1.0
In-Reply-To: <1506092407-26985-8-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 07/20] target/arm: Warn about restoring to
 unaligned stack
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

On 09/22/2017 10:59 AM, Peter Maydell wrote:
> Attempting to do an exception return with an exception frame that
> is not 8-aligned is UNPREDICTABLE in v8M; warn about this.
> (It is not UNPREDICTABLE in v7M, and our implementation can
> handle the merely-4-aligned case fine, so we don't need to
> do anything except warn.)
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/helper.c | 7 +++++++
>  1 file changed, 7 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
