Received: from eggs.gnu.org ([2001:4830:134:3::10]:33888)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1ejUK8-0001ye-F6
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 13:20:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1ejUK5-0004yD-9Q
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 13:20:00 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33730)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1ejUK5-0004xc-0u
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 13:19:57 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w17IJJuk068686
	for <qemu-devel@nongnu.org>; Wed, 7 Feb 2018 13:19:55 -0500
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2g04jx6j7d-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 07 Feb 2018 13:19:55 -0500
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Wed, 7 Feb 2018 18:19:53 -0000
References: <20180207155531.28446-1-cohuck@redhat.com>
	<20180207155531.28446-2-cohuck@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Wed, 7 Feb 2018 19:19:48 +0100
MIME-Version: 1.0
In-Reply-To: <20180207155531.28446-2-cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <0158f292-439d-9b1c-7b74-1edd2e6b23ac@de.ibm.com>
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH 1/3] MAINTAINERS: add myself
 as overall s390x maintainer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: thuth@redhat.com, david@redhat.com, agraf@suse.de, rth@twiddle.net



On 02/07/2018 04:55 PM, Cornelia Huck wrote:
> All your mainframes are belong to me.
> 
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>

Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>

> ---
>  MAINTAINERS | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index bbc3a617c2..e24273a574 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -76,6 +76,29 @@ K: ^Subject:.*(?i)trivial
>  T: git git://git.corpit.ru/qemu.git trivial-patches
>  T: git git://github.com/vivier/qemu.git trivial-patches
> 
> +Architecture support
> +--------------------
> +S390
> +M: Cornelia Huck <cohuck@redhat.com>
> +S: Supported
> +F: default-configs/s390x-softmmu.mak
> +F: gdb-xml/s390*.xml
> +F: hw/char/sclp*.[hc]
> +F: hw/char/terminal3270.c
> +F: hw/intc/s390_flic.c
> +F: hw/intc/s390_flic_kvm.c
> +F: hw/s390x/
> +F: hw/vfio/ccw.c
> +F: hw/watchdog/wdt_diag288.c
> +F: include/hw/s390x/
> +F: include/hw/watchdog/wdt_diag288.h
> +F: pc-bios/s390-ccw/
> +F: pc-bios/s390-ccw.img
> +F: target/s390x/
> +K: ^Subject:.*(?i)s390(x|)
> +T: git git://github.com/cohuck/qemu.git s390-next
> +L: qemu-s390x@nongnu.org
> +
>  Guest CPU cores (TCG):
>  ----------------------
>  Overall
> 
