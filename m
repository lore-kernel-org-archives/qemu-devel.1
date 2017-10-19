Received: from eggs.gnu.org ([2001:4830:134:3::10]:48048)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1e53yF-0003mi-Ee
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 02:06:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1e53yC-0008RI-7s
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 02:06:19 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35474
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bjsdjshi@linux.vnet.ibm.com>)
	id 1e53yC-0008R8-1R
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 02:06:16 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v9J64NV9091593
	for <qemu-devel@nongnu.org>; Thu, 19 Oct 2017 02:06:13 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2dpmwec9jc-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 19 Oct 2017 02:06:12 -0400
Received: from localhost
	by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bjsdjshi@linux.vnet.ibm.com>;
	Thu, 19 Oct 2017 02:06:12 -0400
Date: Thu, 19 Oct 2017 14:06:07 +0800
From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
References: <20171017140453.51099-1-pasic@linux.vnet.ibm.com>
	<20171017140453.51099-4-pasic@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171017140453.51099-4-pasic@linux.vnet.ibm.com>
Message-Id: <20171019060606.GB4612@bjsdjshi@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v3 3/7] s390x: improve error handling for
 SSCH and RSCH
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: Cornelia Huck <cohuck@redhat.com>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Thomas Huth <thuth@redhat.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, qemu-devel@nongnu.org

* Halil Pasic <pasic@linux.vnet.ibm.com> [2017-10-17 16:04:49 +0200]:

> Simplify the error handling of the SSCH and RSCH handler avoiding
> arbitrary and cryptic error codes being used to tell how the instruction
> is supposed to end.  Let the code detecting the condition tell how it's
> to be handled in a less ambiguous way.  It's best to handle SSCH and RSCH
> in one go as the emulation of the two shares a lot of code.
> 
> For passthrough this change isn't pure refactoring, but changes the way
> kernel reported EFAULT is handled. After clarifying the kernel interface
> we decided that EFAULT shall be mapped to unit exception.  Same goes for
> unexpected error codes and absence of required ORB flags.
> 
> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
> ---
>  hw/s390x/css.c              | 84 +++++++++++++--------------------------------
>  hw/s390x/s390-ccw.c         | 11 +++---
>  hw/vfio/ccw.c               | 28 +++++++++++----
>  include/hw/s390x/css.h      | 23 +++++++++----
>  include/hw/s390x/s390-ccw.h |  2 +-
>  target/s390x/ioinst.c       | 53 ++++------------------------
>  6 files changed, 75 insertions(+), 126 deletions(-)
> 

Agree for what already planned to fix when applying.

LGTM:
Reviewed-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>

-- 
Dong Jia Shi
