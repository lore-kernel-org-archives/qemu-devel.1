Received: from eggs.gnu.org ([209.51.188.92]:53994)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1grX2G-00042N-N4
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 18:55:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1grX2C-0000IP-OG
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 18:55:19 -0500
MIME-Version: 1.0
References: <CAFyWVaZ5tQq4eGaZiPBq7172PB_x3JCqV6c2xo=wSJdgbJakKQ@mail.gmail.com>
	<20190130025559.12696-1-jimw@sifive.com>
In-Reply-To: <20190130025559.12696-1-jimw@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 6 Feb 2019 15:54:21 -0800
Message-ID: <CAKmqyKMofPxKdrhW=XSD_jbFGK3K5EgK3WLDTj1tB=T0MWPD=Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 3/5 v3] RISC-V: Fixes to CSR_* register
 macros.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jim Wilson <jimw@sifive.com>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, qemu-riscv@nongnu.org

On Tue, Jan 29, 2019 at 6:56 PM Jim Wilson <jimw@sifive.com> wrote:
>
> This adds some missing CSR_* register macros, and documents some as being
> priv v1.9.1 specific.
>
> Signed-off-by: Jim Wilson <jimw@sifive.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu_bits.h | 35 +++++++++++++++++++++++++++++++++--
>  1 file changed, 33 insertions(+), 2 deletions(-)
>
> diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
> index 5439f47..316d500 100644
> --- a/target/riscv/cpu_bits.h
> +++ b/target/riscv/cpu_bits.h
> @@ -135,16 +135,22 @@
>  /* Legacy Counter Setup (priv v1.9.1) */
>  #define CSR_MUCOUNTEREN     0x320
>  #define CSR_MSCOUNTEREN     0x321
> +#define CSR_MHCOUNTEREN     0x322
>
>  /* Machine Trap Handling */
>  #define CSR_MSCRATCH        0x340
>  #define CSR_MEPC            0x341
>  #define CSR_MCAUSE          0x342
> -#define CSR_MBADADDR        0x343
> +#define CSR_MTVAL           0x343
>  #define CSR_MIP             0x344
>
> +/* Legacy Machine Trap Handling (priv v1.9.1) */
> +#define CSR_MBADADDR        0x343
> +
>  /* Supervisor Trap Setup */
>  #define CSR_SSTATUS         0x100
> +#define CSR_SEDELEG         0x102
> +#define CSR_SIDELEG         0x103
>  #define CSR_SIE             0x104
>  #define CSR_STVEC           0x105
>  #define CSR_SCOUNTEREN      0x106
> @@ -153,9 +159,12 @@
>  #define CSR_SSCRATCH        0x140
>  #define CSR_SEPC            0x141
>  #define CSR_SCAUSE          0x142
> -#define CSR_SBADADDR        0x143
> +#define CSR_STVAL           0x143
>  #define CSR_SIP             0x144
>
> +/* Legacy Supervisor Trap Handling (priv v1.9.1) */
> +#define CSR_SBADADDR        0x143
> +
>  /* Supervisor Protection and Translation */
>  #define CSR_SPTBR           0x180
>  #define CSR_SATP            0x180
> @@ -282,6 +291,28 @@
>  #define CSR_MHPMCOUNTER30H  0xb9e
>  #define CSR_MHPMCOUNTER31H  0xb9f
>
> +/* Legacy Hypervisor Trap Setup (priv v1.9.1) */
> +#define CSR_HSTATUS         0x200
> +#define CSR_HEDELEG         0x202
> +#define CSR_HIDELEG         0x203
> +#define CSR_HIE             0x204
> +#define CSR_HTVEC           0x205
> +
> +/* Legacy Hypervisor Trap Handling (priv v1.9.1) */
> +#define CSR_HSCRATCH        0x240
> +#define CSR_HEPC            0x241
> +#define CSR_HCAUSE          0x242
> +#define CSR_HBADADDR        0x243
> +#define CSR_HIP             0x244
> +
> +/* Legacy Machine Protection and Translation (priv v1.9.1) */
> +#define CSR_MBASE           0x380
> +#define CSR_MBOUND          0x381
> +#define CSR_MIBASE          0x382
> +#define CSR_MIBOUND         0x383
> +#define CSR_MDBASE          0x384
> +#define CSR_MDBOUND         0x385
> +
>  /* mstatus CSR bits */
>  #define MSTATUS_UIE         0x00000001
>  #define MSTATUS_SIE         0x00000002
> --
> 2.7.4
>
>
