Received: from eggs.gnu.org ([209.51.188.92]:50978)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jjherne@linux.ibm.com>) id 1h1vsX-00032f-FX
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 11:28:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jjherne@linux.ibm.com>) id 1h1vsJ-0005G3-Oa
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 11:28:11 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56824)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jjherne@linux.ibm.com>)
	id 1h1vsD-00057U-Gl
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 11:27:58 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x27GQDZa059950
	for <qemu-devel@nongnu.org>; Thu, 7 Mar 2019 11:27:55 -0500
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2r36pnrjj6-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 07 Mar 2019 11:27:55 -0500
Received: from localhost
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <jjherne@linux.ibm.com>;
	Thu, 7 Mar 2019 16:27:54 -0000
Reply-To: jjherne@linux.ibm.com
References: <1551466776-29123-1-git-send-email-jjherne@linux.ibm.com>
	<1551466776-29123-14-git-send-email-jjherne@linux.ibm.com>
	<20190305132743.03fbb4c3.cohuck@redhat.com>
From: "Jason J. Herne" <jjherne@linux.ibm.com>
Date: Thu, 7 Mar 2019 11:27:48 -0500
MIME-Version: 1.0
In-Reply-To: <20190305132743.03fbb4c3.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <05979e02-d816-a422-8573-d5bdaf4384b6@linux.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v3 13/16] s390-bios: Use control unit type
 to determine boot method
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, pasic@linux.ibm.com, alifm@linux.ibm.com, borntraeger@de.ibm.com

On 3/5/19 7:27 AM, Cornelia Huck wrote:
> On Fri,  1 Mar 2019 13:59:33 -0500
> "Jason J. Herne" <jjherne@linux.ibm.com> wrote:
> 
>> The boot method is different depending on which device type we are
>> booting from. Let's examine the control unit type to determine if we're
>> a virtio device. We'll eventually add a case to check for a real dasd device
>> here as well.
>>
>> Since we have to call enable_subchannel() in main now, might as well
>> remove that call from virtio.c : run_ccw().
> 
> Any reason you cannot add the enable_subchannel() in the previous
> patch? Then you never need to introduce it in run_ccw() :)
> 

Just for clarity, the enablement of the subchannel has always been done in run_ccw. I 
merely encapsulated the logic into a function in patch #7. I do end up removing it here in 
#13, but this will actually break the netboot case I pointed out in my previous reply.
I agree that we can remove the call to enable_subchannel here if we add it to 
find_net_dev() but it is not a matter of never having introduced it in the first place.

-- 
-- Jason J. Herne (jjherne@linux.ibm.com)
