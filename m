Received: from eggs.gnu.org ([2001:4830:134:3::10]:44846)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alifm@linux.ibm.com>) id 1f47dR-00012c-Kq
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 12:21:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alifm@linux.ibm.com>) id 1f47dN-0000JE-Hy
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 12:21:13 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35288)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alifm@linux.ibm.com>) id 1f47dN-0000Fv-7g
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 12:21:09 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w35GHAFm029093
	for <qemu-devel@nongnu.org>; Thu, 5 Apr 2018 12:21:07 -0400
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2h5kt5u11d-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 05 Apr 2018 12:21:06 -0400
Received: from localhost
	by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <alifm@linux.ibm.com>;
	Thu, 5 Apr 2018 10:21:05 -0600
References: <1522940844-12336-1-git-send-email-mihajlov@linux.vnet.ibm.com>
	<1522940844-12336-2-git-send-email-mihajlov@linux.vnet.ibm.com>
From: Farhan Ali <alifm@linux.ibm.com>
Date: Thu, 5 Apr 2018 12:21:00 -0400
MIME-Version: 1.0
In-Reply-To: <1522940844-12336-2-git-send-email-mihajlov@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <ab5156d7-7120-2c31-370b-9ca0ffda2f9a@linux.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 1/3] s390: Refactor IPL parameter block
 generation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>, cohuck@redhat.com, borntraeger@de.ibm.com, agraf@suse.de, rth@twiddle.net, david@redhat.com, thuth@redhat.com, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org



On 04/05/2018 11:07 AM, Viktor Mihajlovski wrote:
> Splitting out the the CCW device extraction allows reuse.
> 
> Signed-off-by: Viktor Mihajlovski<mihajlov@linux.vnet.ibm.com>
> ---
>   hw/s390x/ipl.c | 81 ++++++++++++++++++++++++++++++++++++----------------------
>   1 file changed, 51 insertions(+), 30 deletions(-)

Reviewed-by: Farhan Ali <alifm@linux.vnet.ibm.com>
