Received: from eggs.gnu.org ([2001:4830:134:3::10]:50515)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1ejo5T-0005ef-UW
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 10:26:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1ejo5P-0000HC-RY
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 10:26:11 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60164)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <danielhb@linux.vnet.ibm.com>)
	id 1ejo5P-0000Gz-JN
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 10:26:07 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w18FOl69140044
	for <qemu-devel@nongnu.org>; Thu, 8 Feb 2018 10:26:06 -0500
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2g0n4c52yb-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 08 Feb 2018 10:26:04 -0500
Received: from localhost
	by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <danielhb@linux.vnet.ibm.com>;
	Thu, 8 Feb 2018 08:26:04 -0700
References: <20180207155531.28446-1-cohuck@redhat.com>
	<20180207155531.28446-2-cohuck@redhat.com>
From: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Date: Thu, 8 Feb 2018 13:25:55 -0200
MIME-Version: 1.0
In-Reply-To: <20180207155531.28446-2-cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Message-Id: <8818285e-b658-3c47-c2a1-c742aaa2636d@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 1/3] MAINTAINERS: add myself as overall
 s390x maintainer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: thuth@redhat.com, david@redhat.com, agraf@suse.de, borntraeger@de.ibm.com, rth@twiddle.net



On 02/07/2018 01:55 PM, Cornelia Huck wrote:
> All your mainframes are belong to me.

Zero Wing reference!

Liked-by: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>

>
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
>   MAINTAINERS | 23 +++++++++++++++++++++++
>   1 file changed, 23 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index bbc3a617c2..e24273a574 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -76,6 +76,29 @@ K: ^Subject:.*(?i)trivial
>   T: git git://git.corpit.ru/qemu.git trivial-patches
>   T: git git://github.com/vivier/qemu.git trivial-patches
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
>   Guest CPU cores (TCG):
>   ----------------------
>   Overall
