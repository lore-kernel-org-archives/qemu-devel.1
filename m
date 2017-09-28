Received: from eggs.gnu.org ([2001:4830:134:3::10]:43065)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dxZJV-0002nn-IQ
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 09:57:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dxZJQ-00075s-LQ
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 09:57:17 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59498)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1dxZGy-0005XF-M3
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 09:57:12 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v8SDnjLu036203
	for <qemu-devel@nongnu.org>; Thu, 28 Sep 2017 09:52:48 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2d91ujtb3r-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 28 Sep 2017 09:52:48 -0400
Received: from localhost
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Thu, 28 Sep 2017 14:52:43 +0100
References: <20170928134609.16985-1-david@redhat.com>
	<20170928134609.16985-2-david@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Thu, 28 Sep 2017 15:52:39 +0200
MIME-Version: 1.0
In-Reply-To: <20170928134609.16985-2-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <f2d649ee-3553-7b1d-4432-e646fb409a65@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v1 1/5] MAINTAINERS: use KVM s390x
 maintainers for kvm-stubs.c and kvm_s390x.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: thuth@redhat.com, cohuck@redhat.com, Alexander Graf <agraf@suse.de>, Richard Henderson <richard.henderson@linaro.org>



On 09/28/2017 03:46 PM, David Hildenbrand wrote:
> Forgot it when factoring code out into these files. This is 100% s390x
> KVM material.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>

Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  MAINTAINERS | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 932443df41..772ac209e1 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -299,6 +299,8 @@ M: Cornelia Huck <cohuck@redhat.com>
>  M: Alexander Graf <agraf@suse.de>
>  S: Maintained
>  F: target/s390x/kvm.c
> +F: target/s390x/kvm_s390x.h
> +F: target/s390x/kvm-stub.c
>  F: target/s390x/ioinst.[ch]
>  F: target/s390x/machine.c
>  F: hw/intc/s390_flic.c
> 
