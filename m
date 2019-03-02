Received: from eggs.gnu.org ([209.51.188.92]:57501)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h09s2-0007rL-Lf
	for qemu-devel@nongnu.org; Sat, 02 Mar 2019 14:00:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h09jB-0007p7-Rq
	for qemu-devel@nongnu.org; Sat, 02 Mar 2019 13:51:18 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55568)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1h09jB-0007oa-Ju
	for qemu-devel@nongnu.org; Sat, 02 Mar 2019 13:51:17 -0500
Received: by mail-wm1-f67.google.com with SMTP id q187so1068631wme.5
	for <qemu-devel@nongnu.org>; Sat, 02 Mar 2019 10:51:17 -0800 (PST)
References: <20190122121413.31437-1-ysato@users.sourceforge.jp>
	<20190302062138.10713-1-ysato@users.sourceforge.jp>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <ce64ecf0-5dff-fb8f-a29a-d73e556a8479@redhat.com>
Date: Sat, 2 Mar 2019 19:51:14 +0100
MIME-Version: 1.0
In-Reply-To: <20190302062138.10713-1-ysato@users.sourceforge.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH RFC v3 00/11] Add RX archtecture support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yoshinori Sato <ysato@users.sourceforge.jp>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, richard.henderson@linaro.org

Hi Yoshinori,

On 3/2/19 7:21 AM, Yoshinori Sato wrote:
> Hello.
> This patch series is added Renesas RX target emulation.
> 
> My git repository is bellow.
> git://git.pf.osdn.net/gitroot/y/ys/ysato/qemu.git
> 
> Since my understanding is not enough,
> I want many comments to make this a good one.

OK :)

Can you provide notes about how to test your port?
Such: links to toolchains, how to build, what firmware/OS we can run...

> 
> Thanks.
> 
> Changes v2
> Rewrite translate. using decodetree.py
> 
> Yoshinori Sato (11):
>   target/rx: TCG Translation
>   target/rx: TCG helper
>   target/rx: CPU definition
>   target/rx: RX disassembler
>   target/rx: miscellaneous functions
>   RX62N interrupt contorol uint
>   RX62N internal timer modules
>   RX62N internal serial communication interface
>   RX Target hardware definition
>   Add rx-softmmu
>   MAINTAINERS: Add RX entry.
> 
>  MAINTAINERS                    |   20 +
>  arch_init.c                    |    2 +
>  configure                      |    8 +
>  default-configs/rx-softmmu.mak |    7 +
>  hw/char/Makefile.objs          |    2 +-
>  hw/char/renesas_sci.c          |  288 ++++++
>  hw/intc/Makefile.objs          |    1 +
>  hw/intc/rx_icu.c               |  323 ++++++
>  hw/rx/Makefile.objs            |    1 +
>  hw/rx/rx62n.c                  |  227 ++++
>  hw/rx/rxqemu.c                 |  100 ++
>  hw/timer/Makefile.objs         |    2 +
>  hw/timer/renesas_cmt.c         |  235 +++++
>  hw/timer/renesas_tmr.c         |  412 ++++++++
>  include/disas/bfd.h            |    5 +
>  include/hw/char/renesas_sci.h  |   42 +
>  include/hw/intc/rx_icu.h       |   49 +
>  include/hw/rx/rx.h             |    7 +
>  include/hw/rx/rx62n.h          |   54 +
>  include/hw/timer/renesas_cmt.h |   33 +
>  include/hw/timer/renesas_tmr.h |   42 +
>  include/sysemu/arch_init.h     |    1 +
>  target/rx/Makefile.objs        |   11 +
>  target/rx/cpu-qom.h            |   52 +
>  target/rx/cpu.c                |  224 ++++
>  target/rx/cpu.h                |  214 ++++
>  target/rx/disas.c              | 1570 ++++++++++++++++++++++++++++
>  target/rx/gdbstub.c            |  113 ++
>  target/rx/helper.c             |  252 +++++
>  target/rx/helper.h             |   39 +
>  target/rx/insns.decode         |  336 ++++++
>  target/rx/monitor.c            |   38 +
>  target/rx/op_helper.c          |  602 +++++++++++
>  target/rx/translate.c          | 2220 ++++++++++++++++++++++++++++++++++++++++
>  34 files changed, 7531 insertions(+), 1 deletion(-)
>  create mode 100644 default-configs/rx-softmmu.mak
>  create mode 100644 hw/char/renesas_sci.c
>  create mode 100644 hw/intc/rx_icu.c
>  create mode 100644 hw/rx/Makefile.objs
>  create mode 100644 hw/rx/rx62n.c
>  create mode 100644 hw/rx/rxqemu.c
>  create mode 100644 hw/timer/renesas_cmt.c
>  create mode 100644 hw/timer/renesas_tmr.c
>  create mode 100644 include/hw/char/renesas_sci.h
>  create mode 100644 include/hw/intc/rx_icu.h
>  create mode 100644 include/hw/rx/rx.h
>  create mode 100644 include/hw/rx/rx62n.h
>  create mode 100644 include/hw/timer/renesas_cmt.h
>  create mode 100644 include/hw/timer/renesas_tmr.h
>  create mode 100644 target/rx/Makefile.objs
>  create mode 100644 target/rx/cpu-qom.h
>  create mode 100644 target/rx/cpu.c
>  create mode 100644 target/rx/cpu.h
>  create mode 100644 target/rx/disas.c
>  create mode 100644 target/rx/gdbstub.c
>  create mode 100644 target/rx/helper.c
>  create mode 100644 target/rx/helper.h
>  create mode 100644 target/rx/insns.decode
>  create mode 100644 target/rx/monitor.c
>  create mode 100644 target/rx/op_helper.c
>  create mode 100644 target/rx/translate.c
> 
