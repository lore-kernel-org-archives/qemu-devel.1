Received: from eggs.gnu.org ([2001:4830:134:3::10]:46062)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1erET7-0007Jx-8r
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 22:01:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1erET2-00079b-To
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 22:01:17 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58816)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bjsdjshi@linux.vnet.ibm.com>)
	id 1erET2-00077w-Le
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 22:01:12 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w212xqsB075956
	for <qemu-devel@nongnu.org>; Wed, 28 Feb 2018 22:01:08 -0500
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2ge6wr4k5h-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 28 Feb 2018 22:01:08 -0500
Received: from localhost
	by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bjsdjshi@linux.vnet.ibm.com>;
	Wed, 28 Feb 2018 22:01:06 -0500
Date: Thu, 1 Mar 2018 11:01:01 +0800
From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
References: <20180227173251.17025-1-cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180227173251.17025-1-cohuck@redhat.com>
Message-Id: <20180301030101.GD5506@bjsdjshi@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH] vfio-ccw: license text should indicate GPL
 v2 or later
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Xiao Feng Ren <renxiaof@linux.vnet.ibm.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>

* Cornelia Huck <cohuck@redhat.com> [2018-02-27 18:32:51 +0100]:

> The license text currently specifies "any version" of the GPL. It
> is unlikely that GPL v1 was ever intended; change this to the
> standard "or any later version" text.
> 
> Cc: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
> Cc: Xiao Feng Ren <renxiaof@linux.vnet.ibm.com>
> Cc: Pierre Morel <pmorel@linux.vnet.ibm.com>
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
>  hw/vfio/ccw.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
> index 16713f2c52..4e5855741a 100644
> --- a/hw/vfio/ccw.c
> +++ b/hw/vfio/ccw.c
> @@ -6,8 +6,8 @@
>   *            Xiao Feng Ren <renxiaof@linux.vnet.ibm.com>
>   *            Pierre Morel <pmorel@linux.vnet.ibm.com>
>   *
> - * This work is licensed under the terms of the GNU GPL, version 2 or(at
> - * your option) any version. See the COPYING file in the top-level
> + * This work is licensed under the terms of the GNU GPL, version 2 or (at
> + * your option) any later version. See the COPYING file in the top-level
>   * directory.
>   */
> 
Dunno why the word 'later' is missing... could be some copy/paste
mistake.

Reviewed-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>

-- 
Dong Jia Shi
