Received: from eggs.gnu.org ([209.51.188.92]:51285)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bmeng.cn@gmail.com>) id 1h2mwd-0006LJ-8W
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 20:08:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bmeng.cn@gmail.com>) id 1h2mwc-0003Mh-13
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 20:08:03 -0500
MIME-Version: 1.0
References: <20190210201726.3567-1-lukas.auer@aisec.fraunhofer.de>
In-Reply-To: <20190210201726.3567-1-lukas.auer@aisec.fraunhofer.de>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Sun, 10 Mar 2019 09:07:48 +0800
Message-ID: <CAEUhbmUtSAeznt1DCwJ7tS=YFeqwnYBemS6278=QQ60qs_MthA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] hw/riscv/virt: re-add machine-specific
 compatible string to /soc/ node
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Lukas Auer <lukas.auer@aisec.fraunhofer.de>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Palmer Dabbelt <palmer@sifive.com>, Michael Clark <mjc@sifive.com>, Alistair Francis <Alistair.Francis@wdc.com>

Hi Lukas,

On Mon, Feb 11, 2019 at 6:13 AM Lukas Auer
<lukas.auer@aisec.fraunhofer.de> wrote:
>
> Re-add the previous compatible string "riscv-virtio-soc" to the soc
> device tree node to allow U-Boot and Linux to bind machine-specific
> drivers to it. The current compatible string "simple-bus" is retained.
>
> This is required by U-Boot to bind devices early, as part of the
> pre-relocation driver model.
>

I see no problem with U-Boot working with current compatible string
"simple-bus". In fact I had planned to remove the compatible string
"riscv-virtio-soc" in U-Boot but did not get time to work on it.

> Fixes: 53f54508dae6("hw/riscv/virtio: Set the soc device tree node as a
> simple-bus")
> Signed-off-by: Lukas Auer <lukas.auer@aisec.fraunhofer.de>
> ---
>
>  hw/riscv/virt.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>

Regards,
Bin
