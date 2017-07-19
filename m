Received: from eggs.gnu.org ([2001:4830:134:3::10]:49732)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dXljp-00072O-TK
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 05:57:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dXljm-0005VV-QR
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 05:57:49 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58296
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1dXljm-0005VH-Kp
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 05:57:46 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v6J9rtFU085926
	for <qemu-devel@nongnu.org>; Wed, 19 Jul 2017 05:57:45 -0400
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2bt4kwhqud-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 19 Jul 2017 05:57:45 -0400
Received: from localhost
	by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Wed, 19 Jul 2017 05:57:45 -0400
References: <20170719095033.20482-1-david@redhat.com>
	<20170719095033.20482-5-david@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Wed, 19 Jul 2017 11:57:39 +0200
MIME-Version: 1.0
In-Reply-To: <20170719095033.20482-5-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-IE
Content-Transfer-Encoding: 7bit
Message-Id: <9400b55c-109f-959f-b4f3-86e0b7c12e9b@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v1 4/5] s390x/kvm: better comment regarding
 zPCI feature availability
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: rth@twiddle.net, thuth@redhat.com, cohuck@redhat.com, jjherne@linux.vnet.ibm.com

On 07/19/2017 11:50 AM, David Hildenbrand wrote:
> Signed-off-by: David Hildenbrand <david@redhat.com>

Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  target/s390x/kvm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
> index fe02315..3d0b7b3 100644
> --- a/target/s390x/kvm.c
> +++ b/target/s390x/kvm.c
> @@ -2661,7 +2661,7 @@ void kvm_s390_get_host_cpu_model(S390CPUModel *model, Error **errp)
>          clear_bit(S390_FEAT_CMM_NT, model->features);
>      }
> 
> -    /* set zpci and aen facilities */
> +    /* We emulate a zPCI bus and AEN, therefore we don't need HW support */
>      set_bit(S390_FEAT_ZPCI, model->features);
>      set_bit(S390_FEAT_ADAPTER_EVENT_NOTIFICATION, model->features);
> 
