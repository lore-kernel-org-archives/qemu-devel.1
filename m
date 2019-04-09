Received: from eggs.gnu.org ([209.51.188.92]:44261)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hDuNz-00050c-8V
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 13:18:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hDuNy-0007Jy-5Q
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 13:18:15 -0400
MIME-Version: 1.0
References: <cover.1553899050.git.alistair.francis@wdc.com>
	<99590ce3f3572a2b02216a5d99cec03ccc3f35a8.1553899050.git.alistair.francis@wdc.com>
	<6b9005b62d51d3a1f44da142936e3d2b4b4dead5.camel@hellion.org.uk>
In-Reply-To: <6b9005b62d51d3a1f44da142936e3d2b4b4dead5.camel@hellion.org.uk>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 9 Apr 2019 10:16:39 -0700
Message-ID: <CAKmqyKOcgsmU5s5gta9v8rX9=2XxzPd0+dpa_c38jzVYb7T4Ag@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Ian Campbell <ijc@hellion.org.uk>
Cc: Alistair Francis <Alistair.Francis@wdc.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "alistair23@gmail.com" <alistair23@gmail.com>, "palmer@sifive.com" <palmer@sifive.com>

On Thu, Apr 4, 2019 at 5:35 AM Ian Campbell <ijc@hellion.org.uk> wrote:
>
> On Fri, 2019-03-29 at 22:39 +0000, Alistair Francis wrote:
> > +    for (i = 0; i < strlen(riscv_cpu); i++) {
> > +        if (i == 0 && riscv_cpu[i] == 'r' &&
> > +            riscv_cpu[i + 1] == 'v') {
>
> Dpes something somewhere else enforce a minimum length or can
> `riscv_cpu[i + 1]` be past the end of the string?
>
> Similarly some more times below and also for the `i += 2` bits.

Good point, a valid string must be at least 5 characters so I have
added a check before we start the parsing.

Alistair

>
> > +            /* Starts with "rv" */
> > +            i += 2;
> > +            if (riscv_cpu[i] == '3' && riscv_cpu[i + 1] == '2') {
> > +                i += 2;
> > +                valid = true;
> > +                rvxlen = RV32;
> > +            }
> > +            if (riscv_cpu[i] == '6' && riscv_cpu[i + 1] == '4') {
> > +                i += 2;
> > +                valid = true;
> > +                rvxlen = RV64;
> > +            }
> > +        }
>
> Ian.
>
