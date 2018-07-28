Received: from eggs.gnu.org ([2001:4830:134:3::10]:40062)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fjSCs-0001fA-NK
	for qemu-devel@nongnu.org; Sat, 28 Jul 2018 12:36:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fjSCp-0002I6-HH
	for qemu-devel@nongnu.org; Sat, 28 Jul 2018 12:36:38 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:45533)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fjSCp-0002Hq-9h
	for qemu-devel@nongnu.org; Sat, 28 Jul 2018 12:36:35 -0400
Received: by mail-pg1-x543.google.com with SMTP id f1-v6so4934999pgq.12
	for <qemu-devel@nongnu.org>; Sat, 28 Jul 2018 09:36:34 -0700 (PDT)
References: <eb8233618cf64aa21c87e2809933f112a7aedf68.1532735306.git.alistair.francis@wdc.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <383842e2-9d91-ff2d-642d-c3cb003895b7@linaro.org>
Date: Sat, 28 Jul 2018 09:36:30 -0700
MIME-Version: 1.0
In-Reply-To: <eb8233618cf64aa21c87e2809933f112a7aedf68.1532735306.git.alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 1/1] configure: Add RISC-V host support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@wdc.com>, qemu-devel@nongnu.org, mjc@sifive.com
Cc: alistair23@gmail.com

On 07/27/2018 04:49 PM, Alistair Francis wrote:
> Allow QEMU to be built to run on a RISC-V host.
> 
> QEMU does not yet have a RISC-V TCG or user mode target port, but
> running other architectures on RISC-V using TCI does work.
> 
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  configure | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)

This is ok as far as it goes.

Even for TCI, you need some more.

At minimum, see Michael Clark's branch changes to accel/tcg/user-exec.c for
host signal handling.  While you can run *-softmmu without this, none of
*-linux-user will work reliably.

Another piece that even Michael Clark does not have is
linux-user/host/*/safe-syscall.S.


r~
