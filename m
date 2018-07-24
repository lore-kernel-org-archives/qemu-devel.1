Received: from eggs.gnu.org ([2001:4830:134:3::10]:45814)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fhva7-0005TH-HM
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 07:34:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fhva2-0007wu-Lz
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 07:34:19 -0400
References: <20180723131016.4161-1-cohuck@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <95354de0-1159-f2dc-b6ef-0cc957a67c47@redhat.com>
Date: Tue, 24 Jul 2018 13:34:10 +0200
MIME-Version: 1.0
In-Reply-To: <20180723131016.4161-1-cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-3.1] s390x: introduce 3.1 compat machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, qemu-s390x@nongnu.org
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org

On 23.07.2018 15:10, Cornelia Huck wrote:
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
>  hw/s390x/s390-virtio-ccw.c | 17 ++++++++++++++++-
>  include/hw/compat.h        |  3 +++
>  2 files changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> index 7983185d04..d366909474 100644
> --- a/hw/s390x/s390-virtio-ccw.c
> +++ b/hw/s390x/s390-virtio-ccw.c
> @@ -673,6 +673,9 @@ bool css_migration_enabled(void)
>      }                                                                         \
>      type_init(ccw_machine_register_##suffix)
>  
> +#define CCW_COMPAT_3_0 \
> +        HW_COMPAT_3_0
> +
>  #define CCW_COMPAT_2_12 \
>          HW_COMPAT_2_12
>  
> @@ -761,14 +764,26 @@ bool css_migration_enabled(void)
>              .value    = "0",\
>          },
>  
> +static void ccw_machine_3_1_instance_options(MachineState *machine)
> +{
> +}
> +
> +static void ccw_machine_3_1_class_options(MachineClass *mc)
> +{
> +}
> +DEFINE_CCW_MACHINE(3_1, "3.1", true);
> +
>  static void ccw_machine_3_0_instance_options(MachineState *machine)
>  {
> +    ccw_machine_3_1_instance_options(machine);
>  }
>  
>  static void ccw_machine_3_0_class_options(MachineClass *mc)
>  {
> +    ccw_machine_3_1_class_options(mc);
> +    SET_MACHINE_COMPAT(mc, CCW_COMPAT_3_0);
>  }
> -DEFINE_CCW_MACHINE(3_0, "3.0", true);
> +DEFINE_CCW_MACHINE(3_0, "3.0", false);
>  
>  static void ccw_machine_2_12_instance_options(MachineState *machine)
>  {
> diff --git a/include/hw/compat.h b/include/hw/compat.h
> index c08f4040bb..6f4d5fc647 100644
> --- a/include/hw/compat.h
> +++ b/include/hw/compat.h
> @@ -1,6 +1,9 @@
>  #ifndef HW_COMPAT_H
>  #define HW_COMPAT_H
>  
> +#define HW_COMPAT_3_0 \
> +    /* empty */
> +
>  #define HW_COMPAT_2_12 \
>      {\
>          .driver   = "migration",\
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 

Thanks,

David / dhildenb
