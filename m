Received: from eggs.gnu.org ([209.51.188.92]:40495)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gjXAN-0006gc-Kx
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 17:26:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gjXAJ-0003AV-6W
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 17:26:39 -0500
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:42469)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gjX9y-0002zl-RF
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 17:26:16 -0500
Received: by mail-pg1-x543.google.com with SMTP id d72so1840738pga.9
	for <qemu-devel@nongnu.org>; Tue, 15 Jan 2019 14:26:13 -0800 (PST)
References: <cover.1547510220.git.alistair.francis@wdc.com>
	<f437442d547363c1d0c27dd30e1c428a83c02e50.1547510220.git.alistair.francis@wdc.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <0c224494-c6b5-4800-6f4a-df4eecf0fa8c@linaro.org>
Date: Wed, 16 Jan 2019 09:26:06 +1100
MIME-Version: 1.0
In-Reply-To: <f437442d547363c1d0c27dd30e1c428a83c02e50.1547510220.git.alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 7/8] RISC-V: Add misa.MAFD checks to
 translate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <Alistair.Francis@wdc.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>
Cc: "alistair23@gmail.com" <alistair23@gmail.com>

On 1/15/19 10:58 AM, Alistair Francis wrote:
> From: Michael Clark <mjc@sifive.com>
> 
> Add misa checks for M, A, F and D extensions and if they are
> not present generate illegal instructions. This improves
> emulation accurary for harts with a limited set of extensions.
> 
> Cc: Palmer Dabbelt <palmer@sifive.com>
> Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>
> Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
> Cc: Alistair Francis <Alistair.Francis@wdc.com>
> Cc: Emilio G. Cota <cota@braap.org>
> Signed-off-by: Michael Clark <mjc@sifive.com>
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  target/riscv/translate.c | 158 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 158 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
