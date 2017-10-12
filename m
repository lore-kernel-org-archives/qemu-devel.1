Received: from eggs.gnu.org ([2001:4830:134:3::10]:41280)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e2kRb-000855-Ec
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 16:51:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e2kRa-00079s-6j
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 16:51:03 -0400
Received: from mail-pf0-x236.google.com ([2607:f8b0:400e:c00::236]:51440)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e2kRZ-00079f-WC
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 16:51:02 -0400
Received: by mail-pf0-x236.google.com with SMTP id n14so6585248pfh.8
	for <qemu-devel@nongnu.org>; Thu, 12 Oct 2017 13:51:01 -0700 (PDT)
References: <cover.1503467674.git.shorne@gmail.com>
	<9ff134a8c36d63ad667d94cacb5ef490e2227e1e.1503467674.git.shorne@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <05f62b13-b759-1b12-89fc-59d4eedf3791@linaro.org>
Date: Thu, 12 Oct 2017 13:50:58 -0700
MIME-Version: 1.0
In-Reply-To: <9ff134a8c36d63ad667d94cacb5ef490e2227e1e.1503467674.git.shorne@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 3/5] openrisc/cputimer: Perparation for
 Multicore
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
> In order to support multicore system we move some of the previously
> static state variables into the state of each core.
> 
> On the other hand in order to allow timers to be synced between each
> code the ttcr (tick timer count register) is moved out of the core.
> This is not as per real hardware spec which has a separate timer counter
> per core, but it seems the most simple way to keep each clock in sync.
> 
> Signed-off-by: Stafford Horne <shorne@gmail.com>
> ---
>  hw/openrisc/cputimer.c       | 62 +++++++++++++++++++++++++++++++++-----------
>  target/openrisc/cpu.c        |  1 -
>  target/openrisc/cpu.h        |  4 ++-
>  target/openrisc/machine.c    |  1 -
>  target/openrisc/sys_helper.c |  4 +--
>  5 files changed, 52 insertions(+), 20 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
