Received: from eggs.gnu.org ([2001:4830:134:3::10]:52920)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gWPnJ-0007j4-Fl
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 12:56:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gWPnE-0000qa-Hb
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 12:56:37 -0500
Received: from mail-oi1-x235.google.com ([2607:f8b0:4864:20::235]:33556)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gWPnE-0000o7-6t
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 12:56:32 -0500
Received: by mail-oi1-x235.google.com with SMTP id c206so9732072oib.0
	for <qemu-devel@nongnu.org>; Mon, 10 Dec 2018 09:56:31 -0800 (PST)
References: <cover.1544229872.git.alistair.francis@wdc.com>
	<c1cbe33881d567ee4712128282e6fcc49a5736b5.1544229872.git.alistair.francis@wdc.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <98465a90-99cc-bce6-8cde-5025a30b3785@linaro.org>
Date: Mon, 10 Dec 2018 11:56:27 -0600
MIME-Version: 1.0
In-Reply-To: <c1cbe33881d567ee4712128282e6fcc49a5736b5.1544229872.git.alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v3 19/24] riscv: tcg-target: Add the out op
 decoder
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

On 12/7/18 6:49 PM, Alistair Francis wrote:
> +    case INDEX_op_neg_i64:
> +        tcg_out_opc_imm(s, OPC_SUB, a0, TCG_REG_ZERO, a1);

tcg_out_opc_reg.

> +    case INDEX_op_mulsh_i32:
> +    case INDEX_op_mulsh_i64:
> +        tcg_out_opc_imm(s, OPC_MULH, a0, a1, a2);
> +        break;
> +
> +    case INDEX_op_muluh_i32:
> +    case INDEX_op_muluh_i64:
> +        tcg_out_opc_imm(s, OPC_MULHU, a0, a1, a2);
> +        break;

Likewise.


r~
