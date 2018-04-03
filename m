Received: from eggs.gnu.org ([2001:4830:134:3::10]:33751)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1f3HMh-0002WM-Qj
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 04:32:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1f3HMd-0000bZ-TR
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 04:32:27 -0400
References: <20180329113320.8053-1-cohuck@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <c10da086-038b-4d88-bf46-0d4be8d55e36@redhat.com>
Date: Tue, 3 Apr 2018 10:32:11 +0200
MIME-Version: 1.0
In-Reply-To: <20180329113320.8053-1-cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH for-2.13] s390x: introduce
 2.13 compat machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, qemu-s390x@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>, Richard Henderson <rth@twiddle.net>

On 29.03.2018 13:33, Cornelia Huck wrote:
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
> Yes, it's that time again :)
> ---
>  hw/s390x/s390-virtio-ccw.c | 17 ++++++++++++++++-
>  include/hw/compat.h        |  3 +++
>  2 files changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> index 864145a7c6..122f316f6a 100644
> --- a/hw/s390x/s390-virtio-ccw.c
> +++ b/hw/s390x/s390-virtio-ccw.c
> @@ -668,6 +668,9 @@ bool css_migration_enabled(void)
>      }                                                                         \
>      type_init(ccw_machine_register_##suffix)
>  
> +#define CCW_COMPAT_2_12 \
> +        HW_COMPAT_2_12
> +
>  #define CCW_COMPAT_2_11 \
>          HW_COMPAT_2_11 \
>          {\
> @@ -753,14 +756,26 @@ bool css_migration_enabled(void)
>              .value    = "0",\
>          },
>  
> +static void ccw_machine_2_13_instance_options(MachineState *machine)
> +{
> +}
> +
> +static void ccw_machine_2_13_class_options(MachineClass *mc)
> +{
> +}
> +DEFINE_CCW_MACHINE(2_13, "2.13", true);
> +
>  static void ccw_machine_2_12_instance_options(MachineState *machine)
>  {
> +    ccw_machine_2_13_instance_options(machine);
>  }
>  
>  static void ccw_machine_2_12_class_options(MachineClass *mc)
>  {
> +    ccw_machine_2_13_class_options(mc);
> +    SET_MACHINE_COMPAT(mc, CCW_COMPAT_2_12);
>  }
> -DEFINE_CCW_MACHINE(2_12, "2.12", true);
> +DEFINE_CCW_MACHINE(2_12, "2.12", false);
>  
>  static void ccw_machine_2_11_instance_options(MachineState *machine)
>  {
> diff --git a/include/hw/compat.h b/include/hw/compat.h
> index bc9e3a6627..6e91491b77 100644
> --- a/include/hw/compat.h
> +++ b/include/hw/compat.h
> @@ -1,6 +1,9 @@
>  #ifndef HW_COMPAT_H
>  #define HW_COMPAT_H
>  
> +#define HW_COMPAT_2_12 \
> +    /* empty */
> +
>  #define HW_COMPAT_2_11 \
>      {\
>          .driver   = "hpet",\
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 

Thanks,

David / dhildenb
