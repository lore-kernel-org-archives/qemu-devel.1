Received: from eggs.gnu.org ([2001:4830:134:3::10]:33341)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dFSFs-0004aS-0z
	for qemu-devel@nongnu.org; Mon, 29 May 2017 17:31:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dFSFo-0008EV-2P
	for qemu-devel@nongnu.org; Mon, 29 May 2017 17:31:12 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:32878)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dFSFn-0008EJ-Su
	for qemu-devel@nongnu.org; Mon, 29 May 2017 17:31:07 -0400
Received: by mail-oi0-x243.google.com with SMTP id h4so13185776oib.0
	for <qemu-devel@nongnu.org>; Mon, 29 May 2017 14:31:07 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170529084546.26500-1-marcandre.lureau@redhat.com>
	<20170529084546.26500-15-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <436727fa-d35c-cfa9-52b3-f59e58a92bb7@amsat.org>
Date: Mon, 29 May 2017 18:31:05 -0300
MIME-Version: 1.0
In-Reply-To: <20170529084546.26500-15-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 14/14] char: move char devices to
 chardev/
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com

On 05/29/2017 05:45 AM, Marc-André Lureau wrote:
> Suggested by Paolo Bonizini during series review.

Bonzini ;) "serie" singular

> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  {backends => chardev}/baum.c         |  0
>  {backends => chardev}/msmouse.c      |  0
>  spice-qemu-char.c => chardev/spice.c |  2 +-
>  {backends => chardev}/testdev.c      |  0
>  {backends => chardev}/wctablet.c     |  0
>  MAINTAINERS                          |  4 +---
>  Makefile.objs                        |  4 ++--
>  backends/Makefile.objs               |  4 ----
>  backends/trace-events                | 10 ----------
>  chardev/Makefile.objs                |  6 ++++++
>  chardev/trace-events                 | 18 ++++++++++++++++++
>  trace-events                         |  7 -------
>  12 files changed, 28 insertions(+), 27 deletions(-)
>  rename {backends => chardev}/baum.c (100%)
>  rename {backends => chardev}/msmouse.c (100%)
>  rename spice-qemu-char.c => chardev/spice.c (99%)
>  rename {backends => chardev}/testdev.c (100%)
>  rename {backends => chardev}/wctablet.c (100%)
>  create mode 100644 chardev/trace-events
>
> diff --git a/backends/baum.c b/chardev/baum.c
> similarity index 100%
> rename from backends/baum.c
> rename to chardev/baum.c
> diff --git a/backends/msmouse.c b/chardev/msmouse.c
> similarity index 100%
> rename from backends/msmouse.c
> rename to chardev/msmouse.c
> diff --git a/spice-qemu-char.c b/chardev/spice.c
> similarity index 99%
> rename from spice-qemu-char.c
> rename to chardev/spice.c
> index 1c6c2e3969..a312078812 100644
> --- a/spice-qemu-char.c
> +++ b/chardev/spice.c
> @@ -1,5 +1,5 @@
>  #include "qemu/osdep.h"
> -#include "trace-root.h"
> +#include "trace.h"
>  #include "ui/qemu-spice.h"
>  #include "chardev/char.h"
>  #include "qemu/error-report.h"
> diff --git a/backends/testdev.c b/chardev/testdev.c
> similarity index 100%
> rename from backends/testdev.c
> rename to chardev/testdev.c
> diff --git a/backends/wctablet.c b/chardev/wctablet.c
> similarity index 100%
> rename from backends/wctablet.c
> rename to chardev/wctablet.c
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 59e03436ad..7ee69d0e42 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1231,13 +1231,11 @@ M: Marc-André Lureau <marcandre.lureau@redhat.com>
>  S: Maintained
>  F: chardev/
>  F: include/chardev/
> -F: backends/msmouse.c
> -F: backends/testdev.c
>
>  Character Devices (Braille)
>  M: Samuel Thibault <samuel.thibault@ens-lyon.org>
>  S: Maintained
> -F: backends/baum.c
> +F: chardev/baum.c
>
>  Command line option argument parsing
>  M: Markus Armbruster <armbru@redhat.com>
> diff --git a/Makefile.objs b/Makefile.objs
> index 2100845ce2..0575802440 100644
> --- a/Makefile.objs
> +++ b/Makefile.objs
> @@ -50,8 +50,6 @@ common-obj-$(CONFIG_LINUX) += fsdev/
>
>  common-obj-y += migration/
>
> -common-obj-$(CONFIG_SPICE) += spice-qemu-char.o
> -
>  common-obj-y += audio/
>  common-obj-y += hw/
>  common-obj-y += accel.o
> @@ -70,6 +68,7 @@ common-obj-y += tpm.o
>  common-obj-$(CONFIG_SLIRP) += slirp/
>
>  common-obj-y += backends/
> +common-obj-y += chardev/
>
>  common-obj-$(CONFIG_SECCOMP) += qemu-seccomp.o
>
> @@ -121,6 +120,7 @@ trace-events-subdirs += io
>  trace-events-subdirs += migration
>  trace-events-subdirs += block
>  trace-events-subdirs += backends
> +trace-events-subdirs += chardev
>  trace-events-subdirs += hw/block
>  trace-events-subdirs += hw/block/dataplane
>  trace-events-subdirs += hw/char
> diff --git a/backends/Makefile.objs b/backends/Makefile.objs
> index 0e0f1567b2..0400799efd 100644
> --- a/backends/Makefile.objs
> +++ b/backends/Makefile.objs
> @@ -1,10 +1,6 @@
>  common-obj-y += rng.o rng-egd.o
>  common-obj-$(CONFIG_POSIX) += rng-random.o
>
> -common-obj-y += msmouse.o wctablet.o testdev.o
> -common-obj-$(CONFIG_BRLAPI) += baum.o
> -baum.o-cflags := $(SDL_CFLAGS)
> -
>  common-obj-$(CONFIG_TPM) += tpm.o
>
>  common-obj-y += hostmem.o hostmem-ram.o
> diff --git a/backends/trace-events b/backends/trace-events
> index 8c3289a3f9..e69de29bb2 100644
> --- a/backends/trace-events
> +++ b/backends/trace-events
> @@ -1,10 +0,0 @@
> -# See docs/tracing.txt for syntax documentation.
> -
> -# backends/wctablet.c
> -wct_init(void) ""
> -wct_cmd_re(void) ""
> -wct_cmd_st(void) ""
> -wct_cmd_sp(void) ""
> -wct_cmd_ts(int input) "0x%02x"
> -wct_cmd_other(const char *cmd) "%s"
> -wct_speed(int speed) "%d"
> diff --git a/chardev/Makefile.objs b/chardev/Makefile.objs
> index e0b37dbfd8..52a8127606 100644
> --- a/chardev/Makefile.objs
> +++ b/chardev/Makefile.objs
> @@ -16,3 +16,9 @@ chardev-obj-y += char-stdio.o
>  chardev-obj-y += char-udp.o
>  chardev-obj-$(CONFIG_WIN32) += char-win.o
>  chardev-obj-$(CONFIG_WIN32) += char-win-stdio.o
> +
> +common-obj-y += msmouse.o wctablet.o testdev.o
> +common-obj-$(CONFIG_BRLAPI) += baum.o
> +baum.o-cflags := $(SDL_CFLAGS)
> +
> +common-obj-$(CONFIG_SPICE) += spice.o
> diff --git a/chardev/trace-events b/chardev/trace-events
> new file mode 100644
> index 0000000000..822dde668b
> --- /dev/null
> +++ b/chardev/trace-events
> @@ -0,0 +1,18 @@
> +# See docs/tracing.txt for syntax documentation.
> +
> +# chardev/wctablet.c
> +wct_init(void) ""
> +wct_cmd_re(void) ""
> +wct_cmd_st(void) ""
> +wct_cmd_sp(void) ""
> +wct_cmd_ts(int input) "0x%02x"
> +wct_cmd_other(const char *cmd) "%s"
> +wct_speed(int speed) "%d"
> +
> +# chardev/spice.c
> +spice_vmc_write(ssize_t out, int len) "spice wrote %zd of requested %d"
> +spice_vmc_read(int bytes, int len) "spice read %d of requested %d"
> +spice_vmc_register_interface(void *scd) "spice vmc registered interface %p"
> +spice_vmc_unregister_interface(void *scd) "spice vmc unregistered interface %p"
> +spice_vmc_event(int event) "spice vmc event %d"
> +
> diff --git a/trace-events b/trace-events
> index e582d6315d..c785af294a 100644
> --- a/trace-events
> +++ b/trace-events
> @@ -41,13 +41,6 @@ system_wakeup_request(int reason) "reason=%d"
>  qemu_system_shutdown_request(void) ""
>  qemu_system_powerdown_request(void) ""
>
> -# spice-qemu-char.c
> -spice_vmc_write(ssize_t out, int len) "spice wrote %zd of requested %d"
> -spice_vmc_read(int bytes, int len) "spice read %d of requested %d"
> -spice_vmc_register_interface(void *scd) "spice vmc registered interface %p"
> -spice_vmc_unregister_interface(void *scd) "spice vmc unregistered interface %p"
> -spice_vmc_event(int event) "spice vmc event %d"
> -
>  # monitor.c
>  monitor_protocol_event_handler(uint32_t event, void *qdict) "event=%d data=%p"
>  monitor_protocol_event_emit(uint32_t event, void *data) "event=%d data=%p"
>
