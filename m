Received: from eggs.gnu.org ([2001:4830:134:3::10]:37571)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ehhtR-00031Y-PM
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 15:25:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ehhtO-000553-Kp
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 15:25:05 -0500
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:36274)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ehhtO-00054j-E4
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 15:25:02 -0500
Received: by mail-qk0-x242.google.com with SMTP id d21so25514068qkj.3
	for <qemu-devel@nongnu.org>; Fri, 02 Feb 2018 12:25:02 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180202183731.29990-1-armbru@redhat.com>
	<20180202183731.29990-13-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <56dc5bfa-a28b-f088-c9b2-5253f9c31bcf@amsat.org>
Date: Fri, 2 Feb 2018 17:24:03 -0300
MIME-Version: 1.0
In-Reply-To: <20180202183731.29990-13-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v7 12/15] hw/timer: Replace fprintf(stderr,
 "*\n" with error_report()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org, alistair.francis@xilinx.com



On 02/02/2018 03:37 PM, Markus Armbruster wrote:
> From: Alistair Francis <alistair.francis@xilinx.com>
> 
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
> 
> Conversions that aren't followed by exit() dropped, because they might
> be inappropriate.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  hw/timer/xilinx_timer.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/timer/xilinx_timer.c b/hw/timer/xilinx_timer.c
> index 59439c05be..2d658b5791 100644
> --- a/hw/timer/xilinx_timer.c
> +++ b/hw/timer/xilinx_timer.c
> @@ -127,7 +127,7 @@ timer_read(void *opaque, hwaddr addr, unsigned int size)
>              break;
>  
>      }
> -    D(fprintf(stderr, "%s timer=%d %x=%x\n", __func__, timer, addr * 4, r));
> +    D(error_report("%s timer=%d %x=%x", __func__, timer, addr * 4, r));

Not sure what we gain here, since those aren't error messages but trace
event.
Can you drop this patch from your series? I'll convert to tracepoints
and send a patch for this file.

>      return r;
>  }
>  
> @@ -135,8 +135,8 @@ static void timer_enable(struct xlx_timer *xt)
>  {
>      uint64_t count;
>  
> -    D(fprintf(stderr, "%s timer=%d down=%d\n", __func__,
> -              xt->nr, xt->regs[R_TCSR] & TCSR_UDT));
> +    D(error_report("%s timer=%d down=%d", __func__,
> +                   xt->nr, xt->regs[R_TCSR] & TCSR_UDT));
>  
>      ptimer_stop(xt->ptimer);
>  
> @@ -160,7 +160,7 @@ timer_write(void *opaque, hwaddr addr,
>      addr >>= 2;
>      timer = timer_from_addr(addr);
>      xt = &t->timers[timer];
> -    D(fprintf(stderr, "%s addr=%x val=%x (timer=%d off=%d)\n",
> +    D(error_report("%s addr=%x val=%x (timer=%d off=%d)",
>               __func__, addr * 4, value, timer, addr & 3));
>      /* Further decoding to address a specific timers reg.  */
>      addr &= 3;
> @@ -197,7 +197,7 @@ static void timer_hit(void *opaque)
>  {
>      struct xlx_timer *xt = opaque;
>      struct timerblock *t = xt->parent;
> -    D(fprintf(stderr, "%s %d\n", __func__, xt->nr));
> +    D(error_report("%s %d", __func__, xt->nr));
>      xt->regs[R_TCSR] |= TCSR_TINT;
>  
>      if (xt->regs[R_TCSR] & TCSR_ARHT)
> 
