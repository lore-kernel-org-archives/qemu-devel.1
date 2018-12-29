Received: from eggs.gnu.org ([208.118.235.92]:53929)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gdN1t-00058Z-By
	for qemu-devel@nongnu.org; Sat, 29 Dec 2018 17:24:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gdN0s-0002Op-D9
	for qemu-devel@nongnu.org; Sat, 29 Dec 2018 17:23:25 -0500
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:44743)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gdN0s-0002OF-7K
	for qemu-devel@nongnu.org; Sat, 29 Dec 2018 17:23:22 -0500
Received: by mail-pg1-x544.google.com with SMTP id t13so11394460pgr.11
	for <qemu-devel@nongnu.org>; Sat, 29 Dec 2018 14:23:22 -0800 (PST)
References: <CAFyWVaai=5K7j8w+Abpk9jxGyKuo4v9w2BgmDbY=_29+Q++Jyw@mail.gmail.com>
	<20181228220951.4962-1-jimw@sifive.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <f3e26863-4624-2c8f-5a9d-f3e76b7e6f0e@linaro.org>
Date: Sun, 30 Dec 2018 09:23:15 +1100
MIME-Version: 1.0
In-Reply-To: <20181228220951.4962-1-jimw@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 3/5 v2] RISC-V: Map gdb CSR reg numbers to
 hw reg numbers.
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

On 12/29/18 9:09 AM, Jim Wilson wrote:
> +++ b/target/riscv/csr-map.h
> @@ -0,0 +1,248 @@
> +/*
> + * The GDB CSR xml files list them in documentation order, not numerical order,
> + * and are missing entries for unnamed CSRs.  So we need to map the gdb numbers
> + * to the hardware numbers.
> + */
> +
> +int csr_register_map[] = {

static const?

Putting an initialized variable in a header file doesn't seem right.  Is this
supposed to be a declaration that is shared between c files?


r~
