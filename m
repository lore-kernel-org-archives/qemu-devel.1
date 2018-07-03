Received: from eggs.gnu.org ([2001:4830:134:3::10]:60898)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1faTsC-0003CS-BP
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 18:34:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1faTs9-0007xr-7S
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 18:34:12 -0400
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:37976)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1faTs9-0007xe-1p
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 18:34:09 -0400
Received: by mail-qk0-x241.google.com with SMTP id y4-v6so1921608qka.5
	for <qemu-devel@nongnu.org>; Tue, 03 Jul 2018 15:34:08 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180702151023.24532-1-shorne@gmail.com>
	<20180702151023.24532-23-shorne@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <feef2195-8fd8-f9e1-da85-f3286a9e2b1d@amsat.org>
Date: Tue, 3 Jul 2018 19:34:02 -0300
MIME-Version: 1.0
In-Reply-To: <20180702151023.24532-23-shorne@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL v2 22/25] linux-user: Implement signals for
 openrisc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stafford Horne <shorne@gmail.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: Riku Voipio <riku.voipio@iki.fi>, Richard Henderson <richard.henderson@linaro.org>, QEMU Development <qemu-devel@nongnu.org>, Laurent Vivier <laurent@vivier.eu>

Hi Stafford,

On 07/02/2018 12:10 PM, Stafford Horne wrote:
> From: Richard Henderson <richard.henderson@linaro.org>
> 
> All of the existing code was boilerplate from elsewhere,
> and would crash the guest upon the first signal.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Stafford Horne <shorne@gmail.com>
> 
> ---
> v2:
>   Add a comment to the new definition of target_pt_regs.
>   Install the signal mask into the ucontext.
> v3:
>   Incorporate feedback from Laurent.

Oops this is not supposed to enter git history, something is wrong with
your pull request script.

> ---
>  linux-user/openrisc/signal.c         | 217 +++++++++++----------------
>  linux-user/openrisc/target_syscall.h |  28 +---
>  linux-user/signal.c                  |   2 +-
>  target/openrisc/cpu.c                |   1 +
>  4 files changed, 94 insertions(+), 154 deletions(-)

<snip>
