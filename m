Received: from eggs.gnu.org ([2001:4830:134:3::10]:52601)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eWr3q-0001Dg-DW
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 16:58:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eWr3k-00061l-D5
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 16:58:58 -0500
Received: from mail-pl0-x243.google.com ([2607:f8b0:400e:c01::243]:45097)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eWr3k-00060U-2n
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 16:58:52 -0500
Received: by mail-pl0-x243.google.com with SMTP id o2so2022613plk.12
	for <qemu-devel@nongnu.org>; Wed, 03 Jan 2018 13:58:51 -0800 (PST)
References: <20180102234108.32713-1-laurent@vivier.eu>
	<20180102234108.32713-17-laurent@vivier.eu>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <5edeeb9b-88c9-4e99-2667-735364abce62@linaro.org>
Date: Wed, 3 Jan 2018 13:58:47 -0800
MIME-Version: 1.0
In-Reply-To: <20180102234108.32713-17-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v6 16/17] target/m68k: add the Interrupt
 Stack Pointer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
Cc: Thomas Huth <huth@tuxfamily.org>

On 01/02/2018 03:41 PM, Laurent Vivier wrote:
> Add the third stack pointer, the Interrupt Stack Pointer (ISP)
> (680x0 only). This stack will be needed in softmmu mode.
> 
> Update movec to set/get the value of the three stacks.
> 
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
> 
> Notes:
>     v6: use cpu_m68k_set_sr() to set SR in GDB stub and in m68k_cpu_reset()
> 
>  target/m68k/cpu.c       |  8 ++---
>  target/m68k/cpu.h       | 70 ++++++++++++++++++++++++++++++++++++++++-
>  target/m68k/gdbstub.c   |  2 +-
>  target/m68k/helper.c    | 82 ++++++++++++++++++++++++++++++++++++++++++++-----
>  target/m68k/helper.h    |  4 ++-
>  target/m68k/monitor.c   |  1 +
>  target/m68k/translate.c | 40 ++++++++++++++++++++++--
>  7 files changed, 190 insertions(+), 17 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
