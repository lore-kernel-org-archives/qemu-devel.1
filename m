Received: from eggs.gnu.org ([2001:4830:134:3::10]:47822)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <akrowiak@linux.vnet.ibm.com>) id 1fAHem-000550-Mz
	for qemu-devel@nongnu.org; Sun, 22 Apr 2018 12:16:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <akrowiak@linux.vnet.ibm.com>) id 1fAHej-00079J-H1
	for qemu-devel@nongnu.org; Sun, 22 Apr 2018 12:16:04 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44458)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <akrowiak@linux.vnet.ibm.com>)
	id 1fAHej-00078b-7g
	for qemu-devel@nongnu.org; Sun, 22 Apr 2018 12:16:01 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w3MGDsZ2024448
	for <qemu-devel@nongnu.org>; Sun, 22 Apr 2018 12:15:59 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2hgk1qr8y2-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Sun, 22 Apr 2018 12:15:59 -0400
Received: from localhost
	by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <akrowiak@linux.vnet.ibm.com>;
	Sun, 22 Apr 2018 12:15:58 -0400
References: <1523819244-29954-1-git-send-email-akrowiak@linux.vnet.ibm.com>
	<1523819244-29954-4-git-send-email-akrowiak@linux.vnet.ibm.com>
	<819cba2d-32d7-6a5c-978f-1c6aa04872fa@linux.vnet.ibm.com>
	<bf3ac9e4-1f53-0372-450d-1a84f780d25e@linux.vnet.ibm.com>
	<204d8b6e-0068-d8de-ebe6-2598d136997d@linux.ibm.com>
From: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Date: Sun, 22 Apr 2018 12:15:51 -0400
MIME-Version: 1.0
In-Reply-To: <204d8b6e-0068-d8de-ebe6-2598d136997d@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Message-Id: <5f379564-c348-b09c-40c8-96cf6328f87e@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v4 3/5] s390x/cpumodel: Set up CPU model
 for AP device support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.ibm.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: mjrosato@linux.vnet.ibm.com, peter.maydell@linaro.org, alifm@linux.vnet.ibm.com, eskultet@redhat.com, david@redhat.com, pmorel@linux.vnet.ibm.com, cohuck@redhat.com, heiko.carstens@de.ibm.com, alex.williamson@redhat.com, agraf@suse.de, borntraeger@de.ibm.com, qemu-s390x@nongnu.org, jjherne@linux.vnet.ibm.com, schwidefsky@de.ibm.com, pbonzini@redhat.com, bjsdjshi@linux.vnet.ibm.com, eric.auger@redhat.com, rth@twiddle.net

On 04/22/2018 12:01 PM, Halil Pasic wrote:
>
>
> On 04/22/2018 05:43 PM, Tony Krowiak wrote:
>>>> +    FEAT_INIT_MISC("ap", "AP facilities installed"),
>>>
>>> Why plural ('facilities')? Would not s/facilities/instructions be 
>>> more end-user
>>> friendly?
>>
>> It's a matter of opinion. I prefer facilities because AP is comprised 
>> of not only
>> instructions, but also AP processors.
>
> Please elaborate. You mean processors like AP cards? If yes what if 
> the matrix is
> empty (e.g. the state we decided is the default when no further action 
> is taken
> (assign queues to the vfio-ap kernel driver, set up an mdev, -device 
> vfio-ap on
> qemu cmd line))?

I don't want to get into a debate about this. If it means that much to 
you, I'll
go ahead and change it.

>
>
> I just wanted to point out that this plural is very vague. Not 
> speaking about that
> QCI should be an AP facility too, but is not included in this 
> 'features' and is not
> covered by this cpu model feature. It has it's own cpu model feature 
> and even a
> dedicated STFLE bit.

Uncle .... I got it.

>
>
> Regards,
> Halil
