Received: from eggs.gnu.org ([209.51.188.92]:59802)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <akrowiak@linux.ibm.com>) id 1h3M2q-0004xO-H6
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 10:36:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <akrowiak@linux.ibm.com>) id 1h3M2p-0007JL-Lz
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 10:36:48 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57140)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <akrowiak@linux.ibm.com>)
	id 1h3M2p-0007II-AT
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 10:36:47 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x2BEY9Eb129413
	for <qemu-devel@nongnu.org>; Mon, 11 Mar 2019 10:36:45 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2r5s4jsm6f-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 11 Mar 2019 10:36:45 -0400
Received: from localhost
	by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <akrowiak@linux.ibm.com>;
	Mon, 11 Mar 2019 14:36:44 -0000
References: <1550519397-25359-1-git-send-email-akrowiak@linux.ibm.com>
	<1550519397-25359-3-git-send-email-akrowiak@linux.ibm.com>
	<20190220165128.630ad793.cohuck@redhat.com>
	<ee4e057a-8c40-1c40-3fbe-acbe4cc64aab@linux.ibm.com>
	<20190221173249.64a04e10.cohuck@redhat.com>
From: Tony Krowiak <akrowiak@linux.ibm.com>
Date: Mon, 11 Mar 2019 10:36:37 -0400
MIME-Version: 1.0
In-Reply-To: <20190221173249.64a04e10.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <be30451e-e6d9-eae6-f595-59d793238cba@linux.ibm.com>
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

On 2/21/19 11:32 AM, Cornelia Huck wrote:
> On Thu, 21 Feb 2019 11:26:53 -0500
> Tony Krowiak <akrowiak@linux.ibm.com> wrote:
> 
>> On 2/20/19 10:51 AM, Cornelia Huck wrote:
>>> On Mon, 18 Feb 2019 14:49:57 -0500
>>> Tony Krowiak <akrowiak@linux.ibm.com> wrote:
>>>    
>>>> Let's update the vfio-ap.txt document to include the hot plug/unplug
>>>> support introduced in this patch set.
>>>
>>> s/ introduced in this patch set//
>>>
>>> Nobody will know about this patch set when they look at the commit in
>>> the future :)
>>
>> Good point, I'll remove it.
> 
> I can do that while applying if no other feedback comes in.

Okay, sounds good to me.

> 
>>
>>>    
>>>>
>>>> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
>>>> ---
>>>>    docs/vfio-ap.txt | 61 +++++++++++++++++++++++++++++++++++++++++++++++++++-----
>>>>    1 file changed, 56 insertions(+), 5 deletions(-)
>>>
>>> Looks good to me, but would not mind a R-b before queuing.
>>>    
>>
> 
