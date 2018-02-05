Received: from eggs.gnu.org ([2001:4830:134:3::10]:33261)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eihc6-0004be-M3
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 09:19:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eihc3-0001X2-FX
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 09:19:18 -0500
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244]:32832)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eihc3-0001WO-9f
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 09:19:15 -0500
Received: by mail-pg0-x244.google.com with SMTP id u1so18645243pgr.0
	for <qemu-devel@nongnu.org>; Mon, 05 Feb 2018 06:19:15 -0800 (PST)
References: <1517811767-75958-1-git-send-email-mjc@sifive.com>
	<1517811767-75958-22-git-send-email-mjc@sifive.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <fa6614d4-2c97-326b-7c58-782a3b65dc61@linaro.org>
Date: Mon, 5 Feb 2018 06:19:10 -0800
MIME-Version: 1.0
In-Reply-To: <1517811767-75958-22-git-send-email-mjc@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 22/22] RISC-V Build Infrastructure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Clark <mjc@sifive.com>, qemu-devel@nongnu.org
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, RISC-V Patches <patches@groups.riscv.org>

On 02/04/2018 10:22 PM, Michael Clark wrote:
> This adds RISC-V into the build system enabling the following targets:
> 
> - riscv32-softmmu
> - riscv64-softmmu
> - riscv32-linux-user
> - riscv64-linux-user
> 
> This adds defaults configs for RISC-V, enables the build for the RISC-V
> CPU core, hardware, and Linux User Emulation. The 'qemu-binfmt-conf.sh'
> script is updated to add the RISC-V ELF magic.
> 
> Expected checkpatch errors for consistency reasons:
> 
> ERROR: line over 90 characters
> FILE: scripts/qemu-binfmt-conf.sh
> Signed-off-by: Michael Clark <mjc@sifive.com>
> ---

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
