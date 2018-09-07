Received: from eggs.gnu.org ([2001:4830:134:3::10]:59140)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fyQOh-0000oz-Qo
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 19:42:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fyQOh-00020U-1S
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 19:42:43 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180901124639.19735-1-luc.michel@greensocs.com>
	<20180901124639.19735-3-luc.michel@greensocs.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <571adbe5-9f9a-f11c-8b0f-55e5fb01278f@amsat.org>
Date: Fri, 7 Sep 2018 20:42:25 -0300
MIME-Version: 1.0
In-Reply-To: <20180901124639.19735-3-luc.michel@greensocs.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 02/15] gdbstub: add multiprocess
 support to '?' packets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Luc Michel <luc.michel@greensocs.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, alistair@alistair23.me, mark.burton@greensocs.com, saipava@xilinx.com, edgari@xilinx.com, qemu-arm@nongnu.org

Hi Luc,

On 9/1/18 9:46 AM, Luc Michel wrote:
[...]
> +static char *get_thread_id(const GDBState *s, CPUState *cpu,
> +                           char *buf, size_t buf_size)

To avoid confusion with 'int qemu_get_thread_id()' from "qemu/osdep.h",
can we use another name such gdb_fmt_thread_id() or
get_thread_id_string() or better?

> +{
> +    if (s->multiprocess) {
> +        snprintf(buf, buf_size, "p%02x.%02x",
> +                 gdb_get_cpu_pid(s, cpu), cpu_gdb_index(cpu));
> +    } else {
> +        snprintf(buf, buf_size, "%02x", cpu_gdb_index(cpu));
> +

extra newline ;)

> +    }
> +
> +    return buf;
> +}
