Received: from eggs.gnu.org ([2001:4830:134:3::10]:38222)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1dBLC9-0006m7-J6
	for qemu-devel@nongnu.org; Thu, 18 May 2017 09:10:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1dBLC5-0008Vw-Fl
	for qemu-devel@nongnu.org; Thu, 18 May 2017 09:10:21 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49984
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1dBLC5-0008Va-AT
	for qemu-devel@nongnu.org; Thu, 18 May 2017 09:10:17 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v4ID8WGl061639
	for <qemu-devel@nongnu.org>; Thu, 18 May 2017 09:10:16 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2ahapmw2g5-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 18 May 2017 09:10:16 -0400
Received: from localhost
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Thu, 18 May 2017 14:10:12 +0100
Date: Thu, 18 May 2017 15:09:46 +0200
From: Cornelia Huck <cornelia.huck@de.ibm.com>
In-Reply-To: <20170517004813.58227-14-bjsdjshi@linux.vnet.ibm.com>
References: <20170517004813.58227-1-bjsdjshi@linux.vnet.ibm.com>
	<20170517004813.58227-14-bjsdjshi@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20170518150946.3c747ffb.cornelia.huck@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v8 13/13] MAINTAINERS: Add vfio-ccw
 maintainer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, qemu-devel@nongnu.org, borntraeger@de.ibm.com, agraf@suse.com, alex.williamson@redhat.com, eric.auger@redhat.com

On Wed, 17 May 2017 02:48:13 +0200
Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com> wrote:

> Add Cornelia Huck as the vfio-ccw maintainer.
> 
> Acked-by: Alex Williamson <alex.williamson@redhat.com>
> Signed-off-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
> ---
>  MAINTAINERS | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index efdec47319..a4ae36b411 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -997,6 +997,13 @@ S: Supported
>  F: hw/vfio/*
>  F: include/hw/vfio/
> 
> +vfio-ccw
> +M: Cornelia Huck <cornelia.huck@de.ibm.com>
> +S: Supported
> +F: hw/vfio/ccw.c
> +F: hw/s390x/s390-ccw.c
> +F: include/hw/s390x/s390-ccw.h
> +
>  vhost
>  M: Michael S. Tsirkin <mst@redhat.com>
>  S: Supported

I'll take vfio-ccw patches via the normal s390-next tree, I guess.
Added a T: section.
