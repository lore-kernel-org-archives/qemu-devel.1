Received: from eggs.gnu.org ([2001:4830:134:3::10]:51241)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e2l2E-0005gU-8U
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 17:28:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e2l2B-0003Cy-2w
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 17:28:54 -0400
Received: from mail-pf0-x231.google.com ([2607:f8b0:400e:c00::231]:44252)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e2l2A-0003A4-Sr
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 17:28:51 -0400
Received: by mail-pf0-x231.google.com with SMTP id x7so6737359pfa.1
	for <qemu-devel@nongnu.org>; Thu, 12 Oct 2017 14:28:50 -0700 (PDT)
References: <cover.1503467674.git.shorne@gmail.com>
	<5bbe0752efa40ad6fe397a344967ee0b93394392.1503467674.git.shorne@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <f89d1cc0-51f8-3403-fb33-82f993cd59f2@linaro.org>
Date: Thu, 12 Oct 2017 14:28:47 -0700
MIME-Version: 1.0
In-Reply-To: <5bbe0752efa40ad6fe397a344967ee0b93394392.1503467674.git.shorne@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 5/5] openrisc: Only kick cpu on timeout,
 not on update
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stafford Horne <shorne@gmail.com>, QEMU Development <qemu-devel@nongnu.org>
Cc: Openrisc <openrisc@lists.librecores.org>, Richard Henderson <rth@twiddle.net>

On 08/22/2017 10:57 PM, Stafford Horne wrote:
> Previously we were kicking the cpu on every update.  This caused
> problems noticeable in SMP configurations where one CPU got pinned
> continuously servicing timer exceptions.
> 
> Signed-off-by: Stafford Horne <shorne@gmail.com>
> ---
>  hw/openrisc/cputimer.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
