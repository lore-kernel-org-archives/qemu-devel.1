Received: from eggs.gnu.org ([2001:4830:134:3::10]:35858)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1fj21X-0001KT-7K
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 08:39:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1fj21T-0000ar-T3
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 08:39:11 -0400
Received: from chuckie.co.uk ([82.165.15.123]:35512
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1fj21T-0000WG-Ko
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 08:39:07 -0400
References: <20180727123112.13707-1-dgilbert@redhat.com>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <d09b7607-a23b-7c05-9faf-7ec0000684af@ilande.co.uk>
Date: Fri, 27 Jul 2018 13:38:54 +0100
MIME-Version: 1.0
In-Reply-To: <20180727123112.13707-1-dgilbert@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] macio/pmu: Fix missing vmsd terminator
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>, qemu-devel@nongnu.org, agraf@suse.de, lvivier@redhat.com

On 27/07/18 13:31, Dr. David Alan Gilbert (git) wrote:

> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> 
> Fix missing terminator in VMStateDescription
> 
> Fixes: d811d61fbc6ca5f2be2185fd7cfa916e7ba613ce
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>   hw/misc/macio/pmu.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/hw/misc/macio/pmu.c b/hw/misc/macio/pmu.c
> index e246b0fd41..27dfaf8a74 100644
> --- a/hw/misc/macio/pmu.c
> +++ b/hw/misc/macio/pmu.c
> @@ -686,6 +686,7 @@ static const VMStateDescription vmstate_pmu_adb = {
>           VMSTATE_TIMER_PTR(adb_poll_timer, PMUState),
>           VMSTATE_UINT8(adb_reply_size, PMUState),
>           VMSTATE_BUFFER(adb_reply, PMUState),
> +        VMSTATE_END_OF_LIST()
>       }
>   };

Gah, yes indeed it certainly looks like I missed this whilst working on 
the PMU code :(

Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Just out of interest does a savevm/loadvm migration still succeed once 
this has been added?


ATB,

Mark.
