Received: from eggs.gnu.org ([2001:4830:134:3::10]:46890)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgari@xilinx.com>) id 1gNb5q-0006Z1-Hd
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 05:11:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgari@xilinx.com>) id 1gNb5p-00045M-RT
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 05:11:18 -0500
Date: Fri, 16 Nov 2018 11:10:44 +0100
From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
Message-ID: <20181116101044.GU7447@toto>
References: <20181115094207.22846-1-luc.michel@greensocs.com>
	<20181115094207.22846-12-luc.michel@greensocs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20181115094207.22846-12-luc.michel@greensocs.com>
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
To: Luc Michel <luc.michel@greensocs.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, saipava@xilinx.com, edgari@xilinx.com, alistair@alistair23.me, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, mark.burton@greensocs.com, Eduardo Habkost <ehabkost@redhat.com>

On Thu, Nov 15, 2018 at 10:42:02AM +0100, Luc Michel wrote:
> Add support for the '!' extended mode packet. This is required for the
> multiprocess extension.
> 
> Signed-off-by: Luc Michel <luc.michel@greensocs.com>

Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>



> ---
>  gdbstub.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/gdbstub.c b/gdbstub.c
> index eec1cf0d09..ada53ac559 100644
> --- a/gdbstub.c
> +++ b/gdbstub.c
> @@ -1294,10 +1294,13 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
>      trace_gdbstub_io_command(line_buf);
>  
>      p = line_buf;
>      ch = *p++;
>      switch(ch) {
> +    case '!':
> +        put_packet(s, "OK");
> +        break;
>      case '?':
>          /* TODO: Make this return the correct value for user-mode.  */
>          snprintf(buf, sizeof(buf), "T%02xthread:%s;", GDB_SIGNAL_TRAP,
>                   gdb_fmt_thread_id(s, s->c_cpu, thread_id, sizeof(thread_id)));
>          put_packet(s, buf);
> -- 
> 2.19.1
> 
