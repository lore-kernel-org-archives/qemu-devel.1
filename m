Received: from eggs.gnu.org ([2001:4830:134:3::10]:45470)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e71om-0000ba-MC
	for qemu-devel@nongnu.org; Tue, 24 Oct 2017 12:12:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e71oj-0001zS-Gc
	for qemu-devel@nongnu.org; Tue, 24 Oct 2017 12:12:40 -0400
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:43862)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e71oj-0001zE-Bm
	for qemu-devel@nongnu.org; Tue, 24 Oct 2017 12:12:37 -0400
Received: by mail-qk0-x241.google.com with SMTP id w134so26942926qkb.0
	for <qemu-devel@nongnu.org>; Tue, 24 Oct 2017 09:12:36 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <cover.1508390588.git.alistair.francis@xilinx.com>
	<d34071814ded4ba1ffd2482b3bdfbb71175fc06f.1508390588.git.alistair.francis@xilinx.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <9c20cefb-7bb1-8324-820f-a2caa538bbe7@amsat.org>
Date: Tue, 24 Oct 2017 13:12:33 -0300
MIME-Version: 1.0
In-Reply-To: <d34071814ded4ba1ffd2482b3bdfbb71175fc06f.1508390588.git.alistair.francis@xilinx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 40/46] hw/watchdog: Replace
 fprintf(stderr, "*\n" with error_report()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, qemu-devel@nongnu.org
Cc: alistair23@gmail.com, armbru@redhat.com

On 10/19/2017 01:18 PM, Alistair Francis wrote:
> Replace a large number of the fprintf(stderr, "*\n" calls with
> error_report(). The functions were renamed with these commands and then
> compiler issues where manually fixed.
> 
> find ./* -type f -exec sed -i \
>     'N;N;N;N;N;N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>     {} +
> find ./* -type f -exec sed -i \
>     'N;N;N;N;N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>     {} +
> find ./* -type f -exec sed -i \
>     'N;N;N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>     {} +
> find ./* -type f -exec sed -i \
>     'N;N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>     {} +
> find ./* -type f -exec sed -i \
>     'N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>     {} +
> find ./* -type f -exec sed -i \
>     'N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>     {} +
> find ./* -type f -exec sed -i \
>     'N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>     {} +
> find ./* -type f -exec sed -i \
>     'N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>     {} +
> find ./* -type f -exec sed -i \
>     'N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>     {} +
> find ./* -type f -exec sed -i \
>     'N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>     {} +
> find ./* -type f -exec sed -i \
>     'N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>     {} +
> 
> Some lines where then manually tweaked to pass checkpatch.
> 
> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
> ---
> V2:
>  - Split hw patch into individual directories
> 
>  hw/watchdog/watchdog.c     | 9 +++++----
>  hw/watchdog/wdt_i6300esb.c | 8 +++++---
>  2 files changed, 10 insertions(+), 7 deletions(-)
> 
> diff --git a/hw/watchdog/watchdog.c b/hw/watchdog/watchdog.c
> index 670114ecfe..d6d11ef1e5 100644
> --- a/hw/watchdog/watchdog.c
> +++ b/hw/watchdog/watchdog.c
> @@ -20,6 +20,7 @@
>   */
>  
>  #include "qemu/osdep.h"
> +#include "qemu/error-report.h"
>  #include "qemu/option.h"
>  #include "qemu/config-file.h"
>  #include "qemu/queue.h"
> @@ -52,7 +53,7 @@ int select_watchdog(const char *p)
>      /* -watchdog ? lists available devices and exits cleanly. */
>      if (is_help_option(p)) {
>          QLIST_FOREACH(model, &watchdog_list, entry) {
> -            fprintf(stderr, "\t%s\t%s\n",
> +            error_report("\t%s\t%s",
>                       model->wdt_name, model->wdt_description);

align?

>          }
>          return 2;
> @@ -68,9 +69,9 @@ int select_watchdog(const char *p)
>          }
>      }
>  
> -    fprintf(stderr, "Unknown -watchdog device. Supported devices are:\n");
> +    error_report("Unknown -watchdog device. Supported devices are:");
>      QLIST_FOREACH(model, &watchdog_list, entry) {
> -        fprintf(stderr, "\t%s\t%s\n",
> +        error_report("\t%s\t%s",
>                   model->wdt_name, model->wdt_description);

align?

>      }
>      return 1;
> @@ -126,7 +127,7 @@ void watchdog_perform_action(void)
>  
>      case WATCHDOG_ACTION_DEBUG:
>          qapi_event_send_watchdog(WATCHDOG_ACTION_DEBUG, &error_abort);
> -        fprintf(stderr, "watchdog: timer fired\n");
> +        error_report("watchdog: timer fired");
>          break;
>  
>      case WATCHDOG_ACTION_NONE:
> diff --git a/hw/watchdog/wdt_i6300esb.c b/hw/watchdog/wdt_i6300esb.c
> index e596b0804d..c5f5190e55 100644
> --- a/hw/watchdog/wdt_i6300esb.c
> +++ b/hw/watchdog/wdt_i6300esb.c
> @@ -20,7 +20,7 @@
>   */
>  
>  #include "qemu/osdep.h"
> -
> +#include "qemu/error-report.h"
>  #include "qemu-common.h"
>  #include "qemu/timer.h"
>  #include "sysemu/watchdog.h"
> @@ -186,10 +186,12 @@ static void i6300esb_timer_expired(void *vp)
>          /* What to do at the end of stage 1? */
>          switch (d->int_type) {
>          case INT_TYPE_IRQ:
> -            fprintf(stderr, "i6300esb_timer_expired: I would send APIC 1 INT 10 here if I knew how (XXX)\n");
> +            error_report("i6300esb_timer_expired: I would send APIC 1 INT 10"
> +                          "here if I knew how (XXX)");

I'm not sure this is an useful message...

What about:

               qemu_log_mask(LOG_UNIMP,
                            "i6300esb: tmr expired but System "
                            "APIC 1 INT10 _NOT_ emitted\n");
>              break;
>          case INT_TYPE_SMI:
> -            fprintf(stderr, "i6300esb_timer_expired: I would send SMI here if I knew how (XXX)\n");
> +            error_report("i6300esb_timer_expired: I would send SMI here if I"
> +                         "knew how (XXX)");

               qemu_log_mask(LOG_UNIMP,
                            "i6300esb: tmr expired but System "
                            "Management Interrupt _NOT_ emitted\n");

>              break;
>          }
>  
> 
