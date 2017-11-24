Received: from eggs.gnu.org ([2001:4830:134:3::10]:49538)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eIG2s-0004Vr-9D
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 10:37:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eIG2p-0004mB-5h
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 10:37:38 -0500
References: <20171124153344.22972-1-cohuck@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <d2e85743-26da-97ce-29cf-68aff823afe5@redhat.com>
Date: Fri, 24 Nov 2017 16:37:30 +0100
MIME-Version: 1.0
In-Reply-To: <20171124153344.22972-1-cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.12] s390x: introduce 2.12 compat
 machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: borntraeger@de.ibm.com, agraf@suse.de, rth@twiddle.net, thuth@redhat.com

On 24.11.2017 16:33, Cornelia Huck wrote:
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
>  hw/s390x/s390-virtio-ccw.c | 17 ++++++++++++++++-
>  include/hw/compat.h        |  3 +++
>  2 files changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> index 6a57f94197..a23b8aec9f 100644
> --- a/hw/s390x/s390-virtio-ccw.c
> +++ b/hw/s390x/s390-virtio-ccw.c
> @@ -639,6 +639,9 @@ bool css_migration_enabled(void)
>      }                                                                         \
>      type_init(ccw_machine_register_##suffix)
>  
> +#define CCW_COMPAT_2_11 \
> +        HW_COMPAT_2_11
> +
>  #define CCW_COMPAT_2_10 \
>          HW_COMPAT_2_10
>  
> @@ -716,14 +719,26 @@ bool css_migration_enabled(void)
>              .value    = "0",\
>          },
>  
> +static void ccw_machine_2_12_instance_options(MachineState *machine)
> +{
> +}
> +
> +static void ccw_machine_2_12_class_options(MachineClass *mc)
> +{
> +}
> +DEFINE_CCW_MACHINE(2_12, "2.12", true);
> +
>  static void ccw_machine_2_11_instance_options(MachineState *machine)
>  {
> +    ccw_machine_2_12_instance_options(machine);
>  }
>  
>  static void ccw_machine_2_11_class_options(MachineClass *mc)
>  {
> +    ccw_machine_2_12_class_options(mc);
> +    SET_MACHINE_COMPAT(mc, CCW_COMPAT_2_11);
>  }
> -DEFINE_CCW_MACHINE(2_11, "2.11", true);
> +DEFINE_CCW_MACHINE(2_11, "2.11", false);
>  
>  static void ccw_machine_2_10_instance_options(MachineState *machine)
>  {
> diff --git a/include/hw/compat.h b/include/hw/compat.h
> index cf389b4e85..263de973a7 100644
> --- a/include/hw/compat.h
> +++ b/include/hw/compat.h
> @@ -1,6 +1,9 @@
>  #ifndef HW_COMPAT_H
>  #define HW_COMPAT_H
>  
> +#define HW_COMPAT_2_11 \
> +    /* empty */
> +
>  #define HW_COMPAT_2_10 \
>      {\
>          .driver   = "virtio-mouse-device",\
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

Will be helpful for QEMU cpu model changes soon :)

-- 

Thanks,

David / dhildenb
