Received: from eggs.gnu.org ([2001:4830:134:3::10]:58873)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gOicV-0007xn-LB
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 07:25:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gOicS-0007Eb-Hg
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 07:25:39 -0500
Date: Mon, 19 Nov 2018 13:25:27 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20181119132527.0e7c26c9.cohuck@redhat.com>
In-Reply-To: <20181119120820.29878-22-maozhongyi@cmss.chinamobile.com>
References: <20181119120820.29878-1-maozhongyi@cmss.chinamobile.com>
	<20181119120820.29878-22-maozhongyi@cmss.chinamobile.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 21/22] event-facility: Change
 SysBusDeviceClass *sbdc to SysBusDeviceClass *sbc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
Cc: qemu-devel@nongnu.org, borntraeger@de.ibm.com, rth@twiddle.net, david@redhat.com, qemu-s390x@nongnu.org, Zhang Shengju <zhangshengju@cmss.chinamobile.com>

On Mon, 19 Nov 2018 20:08:19 +0800
Mao Zhongyi <maozhongyi@cmss.chinamobile.com> wrote:

> Most of the SysBusDeviceClass variables are named sbc,
> and sbdc here is a bit weird, so changing sbdc to keep
> it consistent with others might look good.

A quick git grep also gives sbd and k as variable names, and it is used
in a total of two lines which have not been touched since 2013, so...
meh. If others like the change, I'm not opposed to merging, though.

> 
> Cc: cohuck@redhat.com
> Cc: borntraeger@de.ibm.com
> Cc: rth@twiddle.net
> Cc: david@redhat.com
> Cc: qemu-s390x@nongnu.org
> 
> Signed-off-by: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
> Signed-off-by: Zhang Shengju <zhangshengju@cmss.chinamobile.com>
> ---
>  hw/s390x/event-facility.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/s390x/event-facility.c b/hw/s390x/event-facility.c
> index ee5b83448b..759e7bee01 100644
> --- a/hw/s390x/event-facility.c
> +++ b/hw/s390x/event-facility.c
> @@ -484,8 +484,8 @@ static void reset_event_facility(DeviceState *dev)
>  
>  static void init_event_facility_class(ObjectClass *klass, void *data)
>  {
> -    SysBusDeviceClass *sbdc = SYS_BUS_DEVICE_CLASS(klass);
> -    DeviceClass *dc = DEVICE_CLASS(sbdc);
> +    SysBusDeviceClass *sbc = SYS_BUS_DEVICE_CLASS(klass);
> +    DeviceClass *dc = DEVICE_CLASS(sbc);
>      SCLPEventFacilityClass *k = EVENT_FACILITY_CLASS(dc);
>  
>      dc->reset = reset_event_facility;
