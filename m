Received: from eggs.gnu.org ([2001:4830:134:3::10]:38055)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gWucm-0002dj-4L
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 21:51:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gWuci-0006Fa-PX
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 21:51:47 -0500
Received: from mail-ot1-x330.google.com ([2607:f8b0:4864:20::330]:32987)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gWuci-0006Eu-Gu
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 21:51:44 -0500
Received: by mail-ot1-x330.google.com with SMTP id i20so16276410otl.0
	for <qemu-devel@nongnu.org>; Tue, 11 Dec 2018 18:51:44 -0800 (PST)
References: <cover.1544229872.git.alistair.francis@wdc.com>
	<d579b3cc437a3b81025d42fee40faaf3c0196470.1544229872.git.alistair.francis@wdc.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <b7c33fb4-b912-64cd-88bd-6a527d8d3972@linaro.org>
Date: Tue, 11 Dec 2018 20:51:40 -0600
MIME-Version: 1.0
In-Reply-To: <d579b3cc437a3b81025d42fee40faaf3c0196470.1544229872.git.alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v3 15/24] riscv: tcg-target: Add the add2 and
 sub2 instructions
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

On 12/7/18 6:48 PM, Alistair Francis wrote:
> +static void tcg_out_addsub2(TCGContext *s,
> +                            TCGReg rl, TCGReg rh,
> +                            TCGReg al, TCGReg ah,
> +                            TCGReg bl, TCGReg bh,
> +                            bool cbl, bool cbh, bool is_sub, bool is32bit)

bl and bh must be TCGArg, since they may be constants, as indicated by cbl+cbh.


r~
