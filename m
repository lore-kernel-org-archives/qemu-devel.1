Received: from eggs.gnu.org ([2001:4830:134:3::10]:55192)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alifm@linux.ibm.com>) id 1fO4xf-0003On-UZ
	for qemu-devel@nongnu.org; Wed, 30 May 2018 13:32:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alifm@linux.ibm.com>) id 1fO4xb-0005r4-Ut
	for qemu-devel@nongnu.org; Wed, 30 May 2018 13:32:35 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56332
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alifm@linux.ibm.com>) id 1fO4xb-0005os-OV
	for qemu-devel@nongnu.org; Wed, 30 May 2018 13:32:31 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w4UHOjEA057602
	for <qemu-devel@nongnu.org>; Wed, 30 May 2018 13:32:29 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2j9xjd6k24-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 30 May 2018 13:32:29 -0400
Received: from localhost
	by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <alifm@linux.ibm.com>;
	Wed, 30 May 2018 11:32:28 -0600
References: <1527568809-5640-1-git-send-email-walling@linux.ibm.com>
From: Farhan Ali <alifm@linux.ibm.com>
Date: Wed, 30 May 2018 13:31:08 -0400
MIME-Version: 1.0
In-Reply-To: <1527568809-5640-1-git-send-email-walling@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <13532906-180e-a47f-52ed-37981b8076bf@linux.ibm.com>
Subject: Re: [Qemu-devel] [PATCH] pc-bios/s390-ccw: define loadparm length
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Collin Walling <walling@linux.ibm.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org, cohuck@redhat.com, lersek@redhat.com



On 05/29/2018 12:40 AM, Collin Walling wrote:
> Loadparm is defined by the s390 architecture to be 8 bytes
> in length. Let's define this size in the s390-ccw bios.
> 
> Suggested-by: Laszlo Ersek<lersek@redhat.com>
> Signed-off-by: Collin Walling<walling@linux.ibm.com>
> ---
>   pc-bios/s390-ccw/iplb.h | 4 +++-
>   pc-bios/s390-ccw/main.c | 8 ++++----
>   pc-bios/s390-ccw/sclp.c | 2 +-
>   pc-bios/s390-ccw/sclp.h | 2 +-
>   4 files changed, 9 insertions(+), 7 deletions(-)

Reviewed-by: Farhan Ali <alifm@linux.ibm.com>
