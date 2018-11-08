Received: from eggs.gnu.org ([2001:4830:134:3::10]:38050)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1gKkXN-0005kC-09
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 08:39:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1gKkXK-0004zo-8P
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 08:39:56 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:35364)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1gKkXJ-0004yY-VO
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 08:39:54 -0500
Received: by mail-wm1-x343.google.com with SMTP id t15-v6so1252564wmt.0
	for <qemu-devel@nongnu.org>; Thu, 08 Nov 2018 05:39:53 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20181108125256.30986-1-peter.maydell@linaro.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <fd88527e-5f49-cc0e-8b8d-fd52e7f4edfb@twiddle.net>
Date: Thu, 8 Nov 2018 14:39:48 +0100
MIME-Version: 1.0
In-Reply-To: <20181108125256.30986-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] tcg/tcg-op.h: Add multiple include guard
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: patches@linaro.org

On 11/8/18 1:52 PM, Peter Maydell wrote:
> The tcg-op.h header was missing the usual guard against multiple
> inclusion; add it.
> 
> (Spotted by lgtm.com's static analyzer.)
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  tcg/tcg-op.h | 5 +++++
>  1 file changed, 5 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

FWIW, while I can queue this, I do not have any other outstanding tcg patches.
 So maybe just apply it to master directly?


r~
