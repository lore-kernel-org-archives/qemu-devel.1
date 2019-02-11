Received: from eggs.gnu.org ([209.51.188.92]:48670)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gt6sZ-0004a6-6f
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 03:23:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gt6sY-0006rz-EV
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 03:23:51 -0500
Date: Mon, 11 Feb 2019 09:23:39 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190211092339.054706bb.cohuck@redhat.com>
In-Reply-To: <20190208221111.25237-1-walling@linux.ibm.com>
References: <20190208221111.25237-1-walling@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/2] s390x/cpumodel: default enable mepoch
 for z14 and later
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Collin Walling <walling@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, david@redhat.com, borntraeger@de.ibm.com, pasic@linux.ibm.com, rth@twiddle.net

On Fri,  8 Feb 2019 17:11:10 -0500
Collin Walling <walling@linux.ibm.com> wrote:

> Latest systems and host kernels support mepoch, which is a
> feature that was meant to be supported for z14 GA1 from the
> get-go. Let's copy it to the z14 GA1 default CPU model.

Do older kernels simply not support it, or was there something actively
missing? IOW, is it fine to turn this on with older kernels?

[It's probably all good, although I like to wait for David's ack for
any cpu model patches :)]

> 
> Machines s390-ccw-virtio-3.1 and older will retain the old CPU
> models and will not provide this bit in the default model.
> 
> Signed-off-by: Collin Walling <walling@linux.ibm.com>
> ---
>  hw/s390x/s390-virtio-ccw.c  | 1 +
>  target/s390x/gen-features.c | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> index fd9d0b0542..32c5027345 100644
> --- a/hw/s390x/s390-virtio-ccw.c
> +++ b/hw/s390x/s390-virtio-ccw.c
> @@ -757,6 +757,7 @@ DEFINE_CCW_MACHINE(4_0, "4.0", true);
>  static void ccw_machine_3_1_instance_options(MachineState *machine)
>  {
>      ccw_machine_4_0_instance_options(machine);
> +    s390_cpudef_featoff_greater(14, 1, S390_FEAT_MULTIPLE_EPOCH);
>  }
>  
>  static void ccw_machine_3_1_class_options(MachineClass *mc)
> diff --git a/target/s390x/gen-features.c b/target/s390x/gen-features.c
> index 70015eaaf5..d258d67dca 100644
> --- a/target/s390x/gen-features.c
> +++ b/target/s390x/gen-features.c
> @@ -550,6 +550,7 @@ static uint16_t default_GEN14_GA1[] = {
>      S390_FEAT_GROUP_MSA_EXT_6,
>      S390_FEAT_GROUP_MSA_EXT_7,
>      S390_FEAT_GROUP_MSA_EXT_8,
> +    S390_FEAT_MULTIPLE_EPOCH,
>  };
>  
>  /* QEMU (CPU model) features */
