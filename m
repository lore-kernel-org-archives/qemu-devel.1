Received: from eggs.gnu.org ([2001:4830:134:3::10]:60687)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1drNKB-0005M3-CO
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 07:56:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1drNKA-0001Ya-Hc
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 07:56:23 -0400
Received: from mel.act-europe.fr ([2a02:2ab8:224:1::a0a:d2]:38218
	helo=smtp.eu.adacore.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <frederic.konrad@adacore.com>)
	id 1drNKA-0001XA-B8
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 07:56:22 -0400
References: <cover.1504656490.git.alistair.francis@xilinx.com>
	<16cf589bc0c0431fbba6bbed8d1a50b49d24e867.1504656490.git.alistair.francis@xilinx.com>
From: KONRAD Frederic <frederic.konrad@adacore.com>
Message-ID: <c270c470-fad7-b8ea-b445-c975d3c3c432@adacore.com>
Date: Mon, 11 Sep 2017 13:56:18 +0200
MIME-Version: 1.0
In-Reply-To: <16cf589bc0c0431fbba6bbed8d1a50b49d24e867.1504656490.git.alistair.francis@xilinx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v1 2/2] netduino2: Specify the valid CPUs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>
Cc: qemu-devel@nongnu.org, marcel@redhat.com, alistair23@gmail.com, ehabkost@redhat.com



On 09/06/2017 02:12 AM, Alistair Francis wrote:
> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
> ---
> 
>   hw/arm/netduino2.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/hw/arm/netduino2.c b/hw/arm/netduino2.c
> index 3cfe332dd1..accca344fd 100644
> --- a/hw/arm/netduino2.c
> +++ b/hw/arm/netduino2.c
> @@ -43,8 +43,13 @@ static void netduino2_init(MachineState *machine)
>   
>   static void netduino2_machine_init(MachineClass *mc)
>   {
> +    const char *val = "cortex-m3";
> +
>       mc->desc = "Netduino 2 Machine";
>       mc->init = netduino2_init;
> +
> +    mc->valid_cpu_types = g_array_new(false, false, sizeof(char *));
> +    g_array_append_val(mc->valid_cpu_types, val);
>   }

Hi Alistair,

Nice idea! Why not adding an helper function which take a const
char** in argument?

Fred

>   
>   DEFINE_MACHINE("netduino2", netduino2_machine_init)
> 
