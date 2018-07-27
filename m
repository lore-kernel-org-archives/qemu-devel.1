Received: from eggs.gnu.org ([2001:4830:134:3::10]:39674)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1fj2Dk-0002Cr-3z
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 08:51:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1fj2Df-0005Pb-9s
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 08:51:48 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49230 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lvivier@redhat.com>) id 1fj2Df-0005Ox-2o
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 08:51:43 -0400
References: <20180727123112.13707-1-dgilbert@redhat.com>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <58589351-4c34-ac31-5dc9-5e75d723c1c1@redhat.com>
Date: Fri, 27 Jul 2018 14:51:40 +0200
MIME-Version: 1.0
In-Reply-To: <20180727123112.13707-1-dgilbert@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>, qemu-devel@nongnu.org, mark.cave-ayland@ilande.co.uk, agraf@suse.de

On 27/07/2018 14:31, Dr. David Alan Gilbert (git) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> 
> Fix missing terminator in VMStateDescription
> 
> Fixes: d811d61fbc6ca5f2be2185fd7cfa916e7ba613ce
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>  hw/misc/macio/pmu.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/hw/misc/macio/pmu.c b/hw/misc/macio/pmu.c
> index e246b0fd41..27dfaf8a74 100644
> --- a/hw/misc/macio/pmu.c
> +++ b/hw/misc/macio/pmu.c
> @@ -686,6 +686,7 @@ static const VMStateDescription vmstate_pmu_adb = {
>          VMSTATE_TIMER_PTR(adb_poll_timer, PMUState),
>          VMSTATE_UINT8(adb_reply_size, PMUState),
>          VMSTATE_BUFFER(adb_reply, PMUState),
> +        VMSTATE_END_OF_LIST()
>      }
>  };
>  
> 

Reviewed-by: Laurent Vivier <lvivier@redhat.com>
