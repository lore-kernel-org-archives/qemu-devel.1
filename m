Received: from eggs.gnu.org ([2001:4830:134:3::10]:43985)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dwQJg-0000NS-BV
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 06:08:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dwQJb-0005C2-Vx
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 06:08:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60586)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dwQJb-0005Bc-Ow
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 06:08:39 -0400
References: <20170918160012.4317-1-david@redhat.com>
	<20170918160012.4317-5-david@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <aa25433f-d5a1-100b-2ee2-5d43f82f6912@redhat.com>
Date: Mon, 25 Sep 2017 12:08:34 +0200
MIME-Version: 1.0
In-Reply-To: <20170918160012.4317-5-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 04/27] s390x: introduce and use
 S390_MAX_CPUS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: Matthew Rosato <mjrosato@linux.vnet.ibm.com>, cohuck@redhat.com, Richard Henderson <richard.henderson@linaro.org>, Alexander Graf <agraf@suse.de>, borntraeger@de.ibm.com, Igor Mammedov <imammedo@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>

On 18.09.2017 17:59, David Hildenbrand wrote:
> Will be handy in the next patches.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  hw/s390x/s390-virtio-ccw.c | 2 +-
>  target/s390x/cpu.h         | 2 ++
>  2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> index d5a12a2472..a57d435cbf 100644
> --- a/hw/s390x/s390-virtio-ccw.c
> +++ b/hw/s390x/s390-virtio-ccw.c
> @@ -443,7 +443,7 @@ static void ccw_machine_class_init(ObjectClass *oc, void *data)
>      mc->no_parallel = 1;
>      mc->no_sdcard = 1;
>      mc->use_sclp = 1;
> -    mc->max_cpus = 248;
> +    mc->max_cpus = S390_MAX_CPUS;
>      mc->has_hotpluggable_cpus = true;
>      mc->get_hotplug_handler = s390_get_hotplug_handler;
>      mc->cpu_index_to_instance_props = s390_cpu_index_to_props;
> diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
> index f13aea3dd8..5f539b1057 100644
> --- a/target/s390x/cpu.h
> +++ b/target/s390x/cpu.h
> @@ -59,6 +59,8 @@
>  #define PSW_MCHK_MASK 0x0004000000000000
>  #define PSW_IO_MASK 0x0200000000000000
>  
> +#define S390_MAX_CPUS 248
> +
>  typedef struct PSW {
>      uint64_t mask;
>      uint64_t addr;
> 

Reviewed-by: Thomas Huth <thuth@redhat.com>
