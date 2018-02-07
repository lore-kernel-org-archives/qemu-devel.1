Received: from eggs.gnu.org ([2001:4830:134:3::10]:34437)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1ejULa-0003Pk-2u
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 13:21:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1ejULX-000675-JY
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 13:21:30 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39530)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1ejULX-000665-Ab
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 13:21:27 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w17IL2dR038425
	for <qemu-devel@nongnu.org>; Wed, 7 Feb 2018 13:21:26 -0500
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2g06d3rnbg-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 07 Feb 2018 13:21:25 -0500
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Wed, 7 Feb 2018 18:21:22 -0000
References: <20180207155531.28446-1-cohuck@redhat.com>
	<20180207155531.28446-3-cohuck@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Wed, 7 Feb 2018 19:21:17 +0100
MIME-Version: 1.0
In-Reply-To: <20180207155531.28446-3-cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <e1eb4a58-19f0-3e08-5188-560c9efdde28@de.ibm.com>
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH 2/3] MAINTAINERS: reorganize
 s390-ccw bios maintainership
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
> Split it out from the s390-ccw-virtio machine, add Thomas as a
> maintainer in addition to Christian.
> 
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>

Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>

Thanks Thomas for volunteering to co-maintain.
> ---
>  MAINTAINERS | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e24273a574..bd2dc7ed7c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -855,15 +855,22 @@ F: hw/char/sclp*.[hc]
>  F: hw/char/terminal3270.c
>  F: hw/s390x/
>  F: include/hw/s390x/
> -F: pc-bios/s390-ccw/
>  F: hw/watchdog/wdt_diag288.c
>  F: include/hw/watchdog/wdt_diag288.h
> -F: pc-bios/s390-ccw.img
>  F: default-configs/s390x-softmmu.mak
>  T: git git://github.com/cohuck/qemu.git s390-next
>  T: git git://github.com/borntraeger/qemu.git s390-next
>  L: qemu-s390x@nongnu.org
> 
> +S390-ccw Bios
> +M: Christian Borntraeger <borntraeger@de.ibm.com>
> +M: Thomas Huth <thuth@redhat.com>
> +S: Supported
> +F: pc-bios/s390-ccw/
> +F: pc-bios/s390-ccw.img
> +T: git git://github.com/borntraeger/qemu.git s390-next
> +L: qemu-s390x@nongnu.org
> +
>  UniCore32 Machines
>  -------------
>  PKUnity-3 SoC initramfs-with-busybox
> 
