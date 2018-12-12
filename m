Received: from eggs.gnu.org ([2001:4830:134:3::10]:48549)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gXDqf-0004ra-Ul
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 18:23:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gXDqc-000162-N8
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 18:23:25 -0500
Received: from mail-oi1-x229.google.com ([2607:f8b0:4864:20::229]:39684)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gXDqY-0000yQ-Up
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 18:23:20 -0500
Received: by mail-oi1-x229.google.com with SMTP id i6so133243oia.6
	for <qemu-devel@nongnu.org>; Wed, 12 Dec 2018 15:23:12 -0800 (PST)
References: <cover.1544643238.git.alistair.francis@wdc.com>
	<2560616ffb8a0e8c3001e3c5490c8bc1463468d0.1544643238.git.alistair.francis@wdc.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <4c5a2e04-2c85-9c46-b807-31b447da8730@linaro.org>
Date: Wed, 12 Dec 2018 17:23:08 -0600
MIME-Version: 1.0
In-Reply-To: <2560616ffb8a0e8c3001e3c5490c8bc1463468d0.1544643238.git.alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 05/23] riscv: Add the tcg-target header
 file
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

On 12/12/18 1:43 PM, Alistair Francis wrote:
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ddfeb32c6c..aa88ee176e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -262,6 +262,7 @@ S: Maintained
>  F: target/riscv/
>  F: hw/riscv/
>  F: include/hw/riscv/
> +F: tcg/riscv/

This section is for RISC-V the target.
Your new entry belongs in RISC-V the TCG host.

See the "Tiny Code Generator (TCG)" header.


r~
