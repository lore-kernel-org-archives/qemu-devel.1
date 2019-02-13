Received: from eggs.gnu.org ([209.51.188.92]:52861)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1gtsVh-0001RZ-Tr
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 06:15:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1gtsNX-0005FK-NM
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 06:07:01 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55548
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1gtsNX-0004kp-HP
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 06:06:59 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x1DAx0FZ045329
	for <qemu-devel@nongnu.org>; Wed, 13 Feb 2019 06:06:39 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2qmh4cu2es-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 13 Feb 2019 06:06:39 -0500
Received: from localhost
	by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Wed, 13 Feb 2019 11:06:37 -0000
References: <20190213103519.32585-1-cohuck@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Wed, 13 Feb 2019 12:06:34 +0100
MIME-Version: 1.0
In-Reply-To: <20190213103519.32585-1-cohuck@redhat.com>
Content-Language: en-US
Message-Id: <6da20589-9240-0890-cc42-813178003eb2@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] s390x: upgrade status of KVM cores to
 "supported"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org



On 13.02.2019 11:35, Cornelia Huck wrote:
> We are actually paid to look after this.
> 
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>

Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>

> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 9a76845581b1..73ff5915638e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -377,7 +377,7 @@ S390
>  M: Halil Pasic <pasic@linux.ibm.com>
>  M: Cornelia Huck <cohuck@redhat.com>
>  M: Christian Borntraeger <borntraeger@de.ibm.com>
> -S: Maintained
> +S: Supported
>  F: target/s390x/kvm.c
>  F: target/s390x/kvm_s390x.h
>  F: target/s390x/kvm-stub.c
> 
