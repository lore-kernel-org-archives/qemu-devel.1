Received: from eggs.gnu.org ([2001:4830:134:3::10]:47548)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1g71Du-0002Ag-MC
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 12:39:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1g71Dr-0001RR-G9
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 12:39:06 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53952)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1g71Dr-0001R6-8j
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 12:39:03 -0400
Received: by mail-wm1-f68.google.com with SMTP id b19-v6so9482209wme.3
	for <qemu-devel@nongnu.org>; Mon, 01 Oct 2018 09:39:03 -0700 (PDT)
References: <20181001115704.701-1-luc.michel@greensocs.com>
	<20181001115704.701-11-luc.michel@greensocs.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <c81c6345-df29-f7e9-77ea-2682d7e02585@redhat.com>
Date: Mon, 1 Oct 2018 18:39:00 +0200
MIME-Version: 1.0
In-Reply-To: <20181001115704.701-11-luc.michel@greensocs.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 10/15] gdbstub: add support for extended
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
Cc: Peter Maydell <peter.maydell@linaro.org>, alistair@alistair23.me, mark.burton@greensocs.com, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, saipava@xilinx.com, edgari@xilinx.com, qemu-arm@nongnu.org

Hi Luc,

On 01/10/2018 13:56, Luc Michel wrote:
> Add support for the '!' extended mode packet. This is required for the
> multiprocess extension.
> 
> Signed-off-by: Luc Michel <luc.michel@greensocs.com>
> ---
>  gdbstub.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/gdbstub.c b/gdbstub.c
> index 299783b3b8..d372972dd3 100644
> --- a/gdbstub.c
> +++ b/gdbstub.c
> @@ -1280,10 +1280,13 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
>      trace_gdbstub_io_command(line_buf);
>  
>      p = line_buf;
>      ch = *p++;
>      switch(ch) {
> +    case '!':
> +        put_packet(s, "OK");

Don't we want to also support the 'R' packet?

> +        break;
>      case '?':
>          /* TODO: Make this return the correct value for user-mode.  */
>          snprintf(buf, sizeof(buf), "T%02xthread:%s;", GDB_SIGNAL_TRAP,
>                   gdb_fmt_thread_id(s, s->c_cpu, thread_id, sizeof(thread_id)));
>          put_packet(s, buf);
> 
