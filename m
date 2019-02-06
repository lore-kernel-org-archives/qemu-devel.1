Received: from eggs.gnu.org ([209.51.188.92]:34138)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1grGVt-0004z9-Ob
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 01:16:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1grGHW-0004Hg-69
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 01:02:00 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a]:41238)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1grGHS-00048N-F4
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 01:01:56 -0500
Received: by mail-wr1-x42a.google.com with SMTP id x10so6140309wrs.8
	for <qemu-devel@nongnu.org>; Tue, 05 Feb 2019 22:01:43 -0800 (PST)
References: <20190128165333.3814-1-svens@stackframe.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <ec7055d5-83b9-19b0-71c8-198f70c64ece@linaro.org>
Date: Wed, 6 Feb 2019 06:01:38 +0000
MIME-Version: 1.0
In-Reply-To: <20190128165333.3814-1-svens@stackframe.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] target/hppa: fix setting registers via gdb
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sven Schnelle <svens@stackframe.org>, qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>

On 1/28/19 4:53 PM, Sven Schnelle wrote:
> While doing 'set $pcoqh=0xf0000000' i triggered the assertion below. From looking
> at the source, it looks like the argument order for deposit64() is wrong, and val
> needs to be moved to the end.
> 
> Signed-off-by: Sven Schnelle <svens@stackframe.org>

Queued, thanks.


r~
