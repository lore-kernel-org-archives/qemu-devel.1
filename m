Received: from eggs.gnu.org ([209.51.188.92]:37902)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alifm@linux.ibm.com>) id 1hDXfJ-0003s1-At
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 13:02:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alifm@linux.ibm.com>) id 1hDXfF-0003Pj-UK
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 13:02:36 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53792)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alifm@linux.ibm.com>) id 1hDXfA-0003Li-8C
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 13:02:30 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x38GxfDa094857
	for <qemu-devel@nongnu.org>; Mon, 8 Apr 2019 13:02:17 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2rr98qkbev-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 08 Apr 2019 13:02:17 -0400
Received: from localhost
	by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <alifm@linux.ibm.com>;
	Mon, 8 Apr 2019 18:02:16 +0100
References: <20190301093902.27799-1-cohuck@redhat.com>
	<20190301093902.27799-2-cohuck@redhat.com>
From: Farhan Ali <alifm@linux.ibm.com>
Date: Mon, 8 Apr 2019 13:02:12 -0400
MIME-Version: 1.0
In-Reply-To: <20190301093902.27799-2-cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <9e81af36-ebd2-671b-5256-90e8efaad6f2@linux.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v4 1/6] vfio-ccw: make it safe to access
 channel programs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org, qemu-devel@nongnu.org, qemu-s390x@nongnu.org, Alex Williamson <alex.williamson@redhat.com>



On 03/01/2019 04:38 AM, Cornelia Huck wrote:
> When we get a solicited interrupt, the start function may have
> been cleared by a csch, but we still have a channel program
> structure allocated. Make it safe to call the cp accessors in
> any case, so we can call them unconditionally.
> 
> While at it, also make sure that functions called from other parts
> of the code return gracefully if the channel program structure
> has not been initialized (even though that is a bug in the caller).
> 
> Reviewed-by: Eric Farman<farman@linux.ibm.com>
> Signed-off-by: Cornelia Huck<cohuck@redhat.com>
> ---

Hi Connie,

My series of fixes for vfio-ccw depends on this patch as I would like to 
call cp_free unconditionally :) (I had developed my code on top of your 
patches).

Could we pick this patch up as well when/if you pick up my patch series? 
I am in the process of sending out a v2.

Regarding this patch we could merge it as a stand alone patch, separate 
from this series. And also the patch LGTM

Reviewed-by: Farhan Ali <alifm@linux.ibm.com>

Thanks
Farhan
