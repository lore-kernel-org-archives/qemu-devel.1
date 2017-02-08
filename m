Received: from eggs.gnu.org ([2001:4830:134:3::10]:43512)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cbZpc-0003ES-15
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 16:31:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cbZpW-0007GO-9p
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 16:31:16 -0500
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:33011)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cbZpW-0007GH-5K
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 16:31:10 -0500
Received: by mail-qt0-x243.google.com with SMTP id n13so25123674qtc.0
	for <qemu-devel@nongnu.org>; Wed, 08 Feb 2017 13:31:10 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1486571534-16301-1-git-send-email-yongbok.kim@imgtec.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <a8ac34d9-8c36-51e8-1716-352901809375@gmail.com>
Date: Wed, 8 Feb 2017 18:31:05 -0300
MIME-Version: 1.0
In-Reply-To: <1486571534-16301-1-git-send-email-yongbok.kim@imgtec.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 2/8] hw/mips_gictimer: provide API for
 retrieving frequency
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Yongbok Kim <yongbok.kim@imgtec.com>, aurelien@aurel32.net, Paul Burton <paul.burton@imgtec.com>paul.burton@imgtec.com

On 02/08/2017 01:32 PM, Yongbok Kim wrote:
> From: Paul Burton <paul.burton@imgtec.com>
>
> Provide a new function mips_gictimer_get_freq() which returns the
> frequency at which a GIC timer will count. This will be useful for
> boards which perform setup based upon this frequency.
>
> Signed-off-by: Paul Burton <paul.burton@imgtec.com>
> Reviewed-by: Leon Alrae <leon.alrae@imgtec.com>
> Signed-off-by: Yongbok Kim <yongbok.kim@imgtec.com>
> ---
>  hw/timer/mips_gictimer.c         | 5 +++++
>  include/hw/timer/mips_gictimer.h | 1 +
>  2 files changed, 6 insertions(+)
>
> diff --git a/hw/timer/mips_gictimer.c b/hw/timer/mips_gictimer.c
> index 3698889..f5c5806 100644
> --- a/hw/timer/mips_gictimer.c
> +++ b/hw/timer/mips_gictimer.c
> @@ -14,6 +14,11 @@
>
>  #define TIMER_PERIOD 10 /* 10 ns period for 100 Mhz frequency */
>
> +uint32_t mips_gictimer_get_freq(MIPSGICTimerState *gic)
> +{
> +    return NANOSECONDS_PER_SECOND / TIMER_PERIOD;
> +}
> +
>  static void gic_vptimer_update(MIPSGICTimerState *gictimer,
>                                     uint32_t vp_index, uint64_t now)
>  {
> diff --git a/include/hw/timer/mips_gictimer.h b/include/hw/timer/mips_gictimer.h
> index c8bc5d2..c7ca6c8 100644
> --- a/include/hw/timer/mips_gictimer.h
> +++ b/include/hw/timer/mips_gictimer.h
> @@ -31,6 +31,7 @@ struct MIPSGICTimerState {
>      MIPSGICTimerCB *cb;
>  };
>
> +uint32_t mips_gictimer_get_freq(MIPSGICTimerState *gic);
>  uint32_t mips_gictimer_get_sh_count(MIPSGICTimerState *gic);
>  void mips_gictimer_store_sh_count(MIPSGICTimerState *gic, uint64_t count);
>  uint32_t mips_gictimer_get_vp_compare(MIPSGICTimerState *gictimer,
>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
