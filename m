Received: from eggs.gnu.org ([209.51.188.92]:36240)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ijc@hellion.org.uk>) id 1hC1au-0007bR-Rh
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 08:35:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ijc@hellion.org.uk>) id 1hC1at-00059P-HV
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 08:35:48 -0400
Message-ID: <6b9005b62d51d3a1f44da142936e3d2b4b4dead5.camel@hellion.org.uk>
From: Ian Campbell <ijc@hellion.org.uk>
Date: Thu, 04 Apr 2019 13:35:38 +0100
In-Reply-To: <99590ce3f3572a2b02216a5d99cec03ccc3f35a8.1553899050.git.alistair.francis@wdc.com>
References: <cover.1553899050.git.alistair.francis@wdc.com>
	<99590ce3f3572a2b02216a5d99cec03ccc3f35a8.1553899050.git.alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for 4.1 v2 2/6] target/riscv: Fall back to
 generating a RISC-V CPU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <Alistair.Francis@wdc.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>
Cc: "alistair23@gmail.com" <alistair23@gmail.com>, "palmer@sifive.com" <palmer@sifive.com>

On Fri, 2019-03-29 at 22:39 +0000, Alistair Francis wrote:
> +    for (i = 0; i < strlen(riscv_cpu); i++) {
> +        if (i == 0 && riscv_cpu[i] == 'r' &&
> +            riscv_cpu[i + 1] == 'v') {

Dpes something somewhere else enforce a minimum length or can
`riscv_cpu[i + 1]` be past the end of the string?

Similarly some more times below and also for the `i += 2` bits.

> +            /* Starts with "rv" */
> +            i += 2;
> +            if (riscv_cpu[i] == '3' && riscv_cpu[i + 1] == '2') {
> +                i += 2;
> +                valid = true;
> +                rvxlen = RV32;
> +            }
> +            if (riscv_cpu[i] == '6' && riscv_cpu[i + 1] == '4') {
> +                i += 2;
> +                valid = true;
> +                rvxlen = RV64;
> +            }
> +        }

Ian.
