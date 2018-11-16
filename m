Received: from eggs.gnu.org ([2001:4830:134:3::10]:38441)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1gNmAa-0005Vl-RO
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 17:00:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1gNmAZ-0000La-SO
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 17:00:56 -0500
References: <20181115094207.22846-1-luc.michel@greensocs.com>
	<20181115094207.22846-12-luc.michel@greensocs.com>
From: Alistair Francis <alistair23@gmail.com>
Message-ID: <fd647af4-7131-2484-d6ce-f70b5a1fee8d@gmail.com>
Date: Fri, 16 Nov 2018 14:00:44 -0800
MIME-Version: 1.0
In-Reply-To: <20181115094207.22846-12-luc.michel@greensocs.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v6 11/16] gdbstub: add support for extended
 mode packet
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

On 15/11/2018 1:42 am, Luc Michel wrote:
> Add support for the '!' extended mode packet. This is required for the
> multiprocess extension.
> 
> Signed-off-by: Luc Michel <luc.michel@greensocs.com>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>   gdbstub.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/gdbstub.c b/gdbstub.c
> index eec1cf0d09..ada53ac559 100644
> --- a/gdbstub.c
> +++ b/gdbstub.c
> @@ -1294,10 +1294,13 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
>       trace_gdbstub_io_command(line_buf);
>   
>       p = line_buf;
>       ch = *p++;
>       switch(ch) {
> +    case '!':
> +        put_packet(s, "OK");
> +        break;
>       case '?':
>           /* TODO: Make this return the correct value for user-mode.  */
>           snprintf(buf, sizeof(buf), "T%02xthread:%s;", GDB_SIGNAL_TRAP,
>                    gdb_fmt_thread_id(s, s->c_cpu, thread_id, sizeof(thread_id)));
>           put_packet(s, buf);
> 
