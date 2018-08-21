Received: from eggs.gnu.org ([2001:4830:134:3::10]:53080)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jjherne@linux.ibm.com>) id 1fsCNw-0000lN-Cy
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 15:32:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jjherne@linux.ibm.com>) id 1fsCNp-0007hu-Tu
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 15:32:12 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40768
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jjherne@linux.ibm.com>)
	id 1fsCNo-0007fv-6n
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 15:32:05 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w7LJTUm0030863
	for <qemu-devel@nongnu.org>; Tue, 21 Aug 2018 15:32:03 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2m0pp6njpp-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 21 Aug 2018 15:32:02 -0400
Received: from localhost
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <jjherne@linux.ibm.com>;
	Tue, 21 Aug 2018 13:32:02 -0600
Reply-To: jjherne@linux.ibm.com
References: <1530811543-6881-1-git-send-email-jjherne@linux.ibm.com>
	<20180815134844.55722b47.cohuck@redhat.com>
From: "Jason J. Herne" <jjherne@linux.ibm.com>
Date: Tue, 21 Aug 2018 15:31:55 -0400
MIME-Version: 1.0
In-Reply-To: <20180815134844.55722b47.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <f9634033-8cf4-b677-28f8-1eda2cb6647e@linux.ibm.com>
Subject: Re: [Qemu-devel] [RFC 00/15] s390: vfio-ccw dasd ipl support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, pasic@linux.ibm.com, bjsdjshi@linux.ibm.com, borntraeger@de.ibm.com

On 08/15/2018 07:48 AM, Cornelia Huck wrote:
> On Thu,  5 Jul 2018 13:25:28 -0400
> "Jason J. Herne" <jjherne@linux.ibm.com> wrote:
> 
>> This is to support booting from vfio-ccw dasd devices. We basically implement
>> the real hardware ipl procedure. This allows for booting Linux guests on
>> vfio-ccw devices.
>>
>> vfio-ccw's channel program prefetch algorithm complicates ipl because most ipl
>> channel programs dynamically modify themselves. Details on the ipl process and
>> how we worked around this issue can be found in docs/devel/s390-dasd-ipl.txt.
> 
> Cleaning up my mail backlog... I think there were some comments; will
> there be a new version forthcoming?
> 

Yes there will. We're hitting a hang now and not sure if it is a device, 
configuration or coding problem. Once I get that cleared up I'll be back 
for round #2.

-- 
-- Jason J. Herne (jjherne@linux.ibm.com)
