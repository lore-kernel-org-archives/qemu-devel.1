Received: from eggs.gnu.org ([2001:4830:134:3::10]:54998)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1gI0GV-00068G-7f
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 19:51:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1gI0GU-00089B-JF
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 19:51:11 -0400
References: <20181026081653.24602-1-luc.michel@greensocs.com>
	<20181026081653.24602-16-luc.michel@greensocs.com>
From: Alistair <alistair23@gmail.com>
Message-ID: <7893bcd8-5ff8-b4f0-bbfb-0834604d2257@gmail.com>
Date: Wed, 31 Oct 2018 16:51:03 -0700
MIME-Version: 1.0
In-Reply-To: <20181026081653.24602-16-luc.michel@greensocs.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 15/16] gdbstub: add multiprocess
 extension support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Luc Michel <luc.michel@greensocs.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, alistair@alistair23.me, mark.burton@greensocs.com, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, saipava@xilinx.com, edgari@xilinx.com, qemu-arm@nongnu.org

On 10/26/18 1:16 AM, Luc Michel wrote:
> Add multiprocess extension support by enabling multiprocess mode when
> the peer requests it, and by replying that we actually support it in the
> qSupported reply packet.
> 
> Signed-off-by: Luc Michel <luc.michel@greensocs.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>   gdbstub.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/gdbstub.c b/gdbstub.c
> index 09480df2bf..a1b63de34b 100644
> --- a/gdbstub.c
> +++ b/gdbstub.c
> @@ -1718,10 +1718,16 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
>               snprintf(buf, sizeof(buf), "PacketSize=%x", MAX_PACKET_LENGTH);
>               cc = CPU_GET_CLASS(first_cpu);
>               if (cc->gdb_core_xml_file != NULL) {
>                   pstrcat(buf, sizeof(buf), ";qXfer:features:read+");
>               }
> +
> +            if (strstr(p, "multiprocess+")) {
> +                s->multiprocess = true;
> +            }
> +            pstrcat(buf, sizeof(buf), ";multiprocess+");
> +
>               put_packet(s, buf);
>               break;
>           }
>           if (strncmp(p, "Xfer:features:read:", 19) == 0) {
>               const char *xml;
> 
