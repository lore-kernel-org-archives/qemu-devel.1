Received: from eggs.gnu.org ([209.51.188.92]:48239)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <akrowiak@linux.ibm.com>) id 1gwrBz-0007sJ-SK
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 11:27:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <akrowiak@linux.ibm.com>) id 1gwrBz-0001gW-69
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 11:27:23 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58758)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <akrowiak@linux.ibm.com>)
	id 1gwrBy-0001ZM-QO
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 11:27:23 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x1LGImR2032486
	for <qemu-devel@nongnu.org>; Thu, 21 Feb 2019 11:27:03 -0500
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2qswymwagk-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 21 Feb 2019 11:27:02 -0500
Received: from localhost
	by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <akrowiak@linux.ibm.com>;
	Thu, 21 Feb 2019 16:27:02 -0000
References: <1550519397-25359-1-git-send-email-akrowiak@linux.ibm.com>
	<1550519397-25359-3-git-send-email-akrowiak@linux.ibm.com>
	<20190220165128.630ad793.cohuck@redhat.com>
From: Tony Krowiak <akrowiak@linux.ibm.com>
Date: Thu, 21 Feb 2019 11:26:53 -0500
MIME-Version: 1.0
In-Reply-To: <20190220165128.630ad793.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <ee4e057a-8c40-1c40-3fbe-acbe4cc64aab@linux.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v3 2/2] s390x/vfio-ap: document hot
 plug/unplug of vfio-ap device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, borntraeger@de.ibm.com, david@redhat.com, pmorel@linux.ibm.com, alifm@linux.ibm.com, mjrosato@linux.ibm.com, pasic@linux.ibm.com, alex.williamson@redhat.com, fiuczy@linux.ibm.com

On 2/20/19 10:51 AM, Cornelia Huck wrote:
> On Mon, 18 Feb 2019 14:49:57 -0500
> Tony Krowiak <akrowiak@linux.ibm.com> wrote:
> 
>> Let's update the vfio-ap.txt document to include the hot plug/unplug
>> support introduced in this patch set.
> 
> s/ introduced in this patch set//
> 
> Nobody will know about this patch set when they look at the commit in
> the future :)

Good point, I'll remove it.

> 
>>
>> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
>> ---
>>   docs/vfio-ap.txt | 61 +++++++++++++++++++++++++++++++++++++++++++++++++++-----
>>   1 file changed, 56 insertions(+), 5 deletions(-)
> 
> Looks good to me, but would not mind a R-b before queuing.
> 
