Received: from eggs.gnu.org ([209.51.188.92]:46665)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1gt6k2-00010J-5n
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 03:15:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1gt6k1-0000na-AK
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 03:15:02 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42230)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1gt6k0-0000ml-VG
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 03:15:01 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x1B8DjpX137532
	for <qemu-devel@nongnu.org>; Mon, 11 Feb 2019 03:14:58 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2qk322nubb-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 11 Feb 2019 03:14:58 -0500
Received: from localhost
	by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Mon, 11 Feb 2019 08:14:55 -0000
References: <20190208221111.25237-1-walling@linux.ibm.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Mon, 11 Feb 2019 09:14:50 +0100
MIME-Version: 1.0
In-Reply-To: <20190208221111.25237-1-walling@linux.ibm.com>
Content-Language: en-US
Message-Id: <d39e1a4d-fd41-74fc-8ff2-72b964af3942@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH 1/2] s390x/cpumodel: default
 enable mepoch for z14 and later
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Collin Walling <walling@linux.ibm.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: pasic@linux.ibm.com, rth@twiddle.net, cohuck@redhat.com, david@redhat.com



On 08.02.2019 23:11, Collin Walling wrote:
> Latest systems and host kernels support mepoch, which is a
> feature that was meant to be supported for z14 GA1 from the
> get-go. Let's copy it to the z14 GA1 default CPU model.
> 
> Machines s390-ccw-virtio-3.1 and older will retain the old CPU
> models and will not provide this bit in the default model.
> 
> Signed-off-by: Collin Walling <walling@linux.ibm.com>

Yes, we missed that back then for the intial z14 version as the kernel
and qemu parts were added later. 

Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>


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
> 
