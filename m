Received: from eggs.gnu.org ([2001:4830:134:3::10]:46601)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eCa0f-0007Uo-RK
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 18:43:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eCa0b-0004b9-U3
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 18:43:53 -0500
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:45721)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eCa0b-0004ay-Oq
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 18:43:49 -0500
Received: by mail-qt0-x244.google.com with SMTP id q33so1153974qta.2
	for <qemu-devel@nongnu.org>; Wed, 08 Nov 2017 15:43:49 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <cover.1510181732.git.alistair.francis@xilinx.com>
	<10f1bca388976b18119fd4fc28d6fdcf7106f7d3.1510181732.git.alistair.francis@xilinx.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <20c00ee8-6d77-e8bd-aa77-6db5db789900@amsat.org>
Date: Wed, 8 Nov 2017 20:43:45 -0300
MIME-Version: 1.0
In-Reply-To: <10f1bca388976b18119fd4fc28d6fdcf7106f7d3.1510181732.git.alistair.francis@xilinx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 40/45] hw/watchdog: Replace
 fprintf(stderr, "*\n" with error_report()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, qemu-devel@nongnu.org, "Richard W.M. Jones" <rjones@redhat.com>
Cc: alistair23@gmail.com, armbru@redhat.com

On 11/08/2017 07:58 PM, Alistair Francis wrote:
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
> Some lines were then manually tweaked to pass checkpatch.
> 
> Some lines in wdt_i6300esb.c were manuallly changed to qemu_log_mask().
> 
> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
> ---
> V3:
>  - Use qemu_log_mask(LOG_UNIMP,... in wdt_i6300esb.c
> V2:
>  - Split hw patch into individual directories
> 
>  hw/watchdog/watchdog.c     | 11 +++++------
>  hw/watchdog/wdt_i6300esb.c | 10 +++++++---
>  2 files changed, 12 insertions(+), 9 deletions(-)
> 
> diff --git a/hw/watchdog/watchdog.c b/hw/watchdog/watchdog.c
> index 670114ecfe..9594457082 100644
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
> @@ -52,8 +53,7 @@ int select_watchdog(const char *p)
>      /* -watchdog ? lists available devices and exits cleanly. */
>      if (is_help_option(p)) {
>          QLIST_FOREACH(model, &watchdog_list, entry) {
> -            fprintf(stderr, "\t%s\t%s\n",
> -                     model->wdt_name, model->wdt_description);
> +            error_report("\t%s\t%s", model->wdt_name, model->wdt_description);
>          }
>          return 2;
>      }
> @@ -68,10 +68,9 @@ int select_watchdog(const char *p)
>          }
>      }
>  
> -    fprintf(stderr, "Unknown -watchdog device. Supported devices are:\n");
> +    error_report("Unknown -watchdog device. Supported devices are:");
>      QLIST_FOREACH(model, &watchdog_list, entry) {
> -        fprintf(stderr, "\t%s\t%s\n",
> -                 model->wdt_name, model->wdt_description);
> +        error_report("\t%s\t%s", model->wdt_name, model->wdt_description);
>      }
>      return 1;
>  }
> @@ -126,7 +125,7 @@ void watchdog_perform_action(void)
>  
>      case WATCHDOG_ACTION_DEBUG:
>          qapi_event_send_watchdog(WATCHDOG_ACTION_DEBUG, &error_abort);
> -        fprintf(stderr, "watchdog: timer fired\n");
> +        error_report("watchdog: timer fired");

I don't think this is an error and would rather use info_report() here.

Richard what do you think?

>          break;
>  
>      case WATCHDOG_ACTION_NONE:
> diff --git a/hw/watchdog/wdt_i6300esb.c b/hw/watchdog/wdt_i6300esb.c
> index e596b0804d..967f3ebc0d 100644
> --- a/hw/watchdog/wdt_i6300esb.c
> +++ b/hw/watchdog/wdt_i6300esb.c
> @@ -20,7 +20,7 @@
>   */
>  
>  #include "qemu/osdep.h"
> -
> +#include "include/qemu/log.h"
>  #include "qemu-common.h"
>  #include "qemu/timer.h"
>  #include "sysemu/watchdog.h"
> @@ -186,10 +186,14 @@ static void i6300esb_timer_expired(void *vp)
>          /* What to do at the end of stage 1? */
>          switch (d->int_type) {
>          case INT_TYPE_IRQ:
> -            fprintf(stderr, "i6300esb_timer_expired: I would send APIC 1 INT 10 here if I knew how (XXX)\n");
> +               qemu_log_mask(LOG_UNIMP,
> +                             "i6300esb: timer expired but System "
> +                             "APIC 1 INT10 not emitted\n");
>              break;
>          case INT_TYPE_SMI:
> -            fprintf(stderr, "i6300esb_timer_expired: I would send SMI here if I knew how (XXX)\n");
> +               qemu_log_mask(LOG_UNIMP,
> +                             "i6300esb: timer expired but System "
> +                             "Management Interrupt not emitted\n");
>              break;
>          }
>  
> 
