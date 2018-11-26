Received: from eggs.gnu.org ([2001:4830:134:3::10]:57866)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1gRJNb-0004s8-TH
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 11:05:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1gRJNY-000405-FI
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 11:04:59 -0500
MIME-Version: 1.0
References: <20181126032038.22044-1-maozhongyi@cmss.chinamobile.com>
In-Reply-To: <20181126032038.22044-1-maozhongyi@cmss.chinamobile.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 26 Nov 2018 08:04:26 -0800
Message-ID: <CAKmqyKOMsHi4wr4xDkhSxEou1k9hxvgUtu_94bBQ35fgKAvvKw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] riscv/cpu: use
 device_class_set_parent_realize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: maozhongyi@cmss.chinamobile.com
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, qemu-riscv@nongnu.org, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Palmer Dabbelt <palmer@sifive.com>, Michael Clark <mjc@sifive.com>, Alistair Francis <Alistair.Francis@wdc.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>

On Sun, Nov 25, 2018 at 7:21 PM Mao Zhongyi
<maozhongyi@cmss.chinamobile.com> wrote:
>
> Signed-off-by: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index a025a0a3ba..5e8a2cb2ba 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -330,8 +330,8 @@ static void riscv_cpu_class_init(ObjectClass *c, void *data)
>      CPUClass *cc = CPU_CLASS(c);
>      DeviceClass *dc = DEVICE_CLASS(c);
>
> -    mcc->parent_realize = dc->realize;
> -    dc->realize = riscv_cpu_realize;
> +    device_class_set_parent_realize(dc, riscv_cpu_realize,
> +                                    &mcc->parent_realize);
>
>      mcc->parent_reset = cc->reset;
>      cc->reset = riscv_cpu_reset;
> --
> 2.17.1
>
>
>
>
