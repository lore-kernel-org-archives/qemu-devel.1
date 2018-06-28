Received: from eggs.gnu.org ([2001:4830:134:3::10]:59563)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1fYeWL-00036J-HY
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 17:32:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1fYeWH-0006a2-KA
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 17:32:05 -0400
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244]:33459)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <shorne@gmail.com>) id 1fYeWH-0006X2-Dl
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 17:32:01 -0400
Received: by mail-pg0-x244.google.com with SMTP id e11-v6so3026284pgq.0
	for <qemu-devel@nongnu.org>; Thu, 28 Jun 2018 14:32:01 -0700 (PDT)
Date: Fri, 29 Jun 2018 06:31:58 +0900
From: Stafford Horne <shorne@gmail.com>
Message-ID: <20180628213158.GO24595@lianli.shorne-pla.net>
References: <20180628030330.15615-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180628030330.15615-1-richard.henderson@linaro.org>
Subject: Re: [Qemu-devel] [PATCH v3 00/23] target/openrisc improvements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org

On Wed, Jun 27, 2018 at 08:03:07PM -0700, Richard Henderson wrote:
> Changes since v2:
>   * Fix missing mtspr break.
>   * Reorg print_insn_or1k and interrupt logging to the start.
>   * Adjust exit after mtspr; fixing smp kernel crash.
>   * Fix signals patch based on Larent's review.

Thanks, I confirmed this is working for me too.

As mentioned before there are a few items I am working on.  I will take the
series and send the pull request during the merge window.

I didnt progress on those items yet as I was stuck on the issues mentioned
above, but I will look into fixing issues with:

 - DSX handling differs from hardware
 - PICMR (interrupt masking) differs from hardware

-Stafford
