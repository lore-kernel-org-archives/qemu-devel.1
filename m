Received: from eggs.gnu.org ([208.118.235.92]:55130)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gdN3X-0006dM-0K
	for qemu-devel@nongnu.org; Sat, 29 Dec 2018 17:26:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gdN3R-0005m8-3H
	for qemu-devel@nongnu.org; Sat, 29 Dec 2018 17:26:06 -0500
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:42033)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gdN3Q-0005jo-Ox
	for qemu-devel@nongnu.org; Sat, 29 Dec 2018 17:26:00 -0500
Received: by mail-pl1-x642.google.com with SMTP id y1so11371849plp.9
	for <qemu-devel@nongnu.org>; Sat, 29 Dec 2018 14:26:00 -0800 (PST)
References: <CAFyWVaai=5K7j8w+Abpk9jxGyKuo4v9w2BgmDbY=_29+Q++Jyw@mail.gmail.com>
	<20181228221018.5022-1-jimw@sifive.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <d7fc84cb-986c-77ce-bc91-0fd4e906025e@linaro.org>
Date: Sun, 30 Dec 2018 09:25:54 +1100
MIME-Version: 1.0
In-Reply-To: <20181228221018.5022-1-jimw@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 4/5 v2] RISC-V: Add debug support for
 accessing CSRs.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jim Wilson <jimw@sifive.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org

On 12/29/18 9:10 AM, Jim Wilson wrote:
> Adds a debugger parameter to csr_read_helper and csr_write_helper.  When
> this is true, we disable illegal instruction checks.
> 
> Signed-off-by: Jim Wilson <jimw@sifive.com>
> ---
>  linux-user/riscv/signal.c |  5 ++-
>  target/riscv/cpu.h        |  7 +++-
>  target/riscv/cpu_helper.c |  4 +-
>  target/riscv/gdbstub.c    |  4 +-
>  target/riscv/op_helper.c  | 93 ++++++++++++++++++++++++++++++++---------------
>  5 files changed, 76 insertions(+), 37 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
