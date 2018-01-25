Received: from eggs.gnu.org ([2001:4830:134:3::10]:47982)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <walling@linux.vnet.ibm.com>) id 1eejE7-00056Q-1c
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 10:14:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <walling@linux.vnet.ibm.com>) id 1eejE3-0008Rt-Vl
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 10:14:07 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51634)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <walling@linux.vnet.ibm.com>)
	id 1eejE3-0008RU-N9
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 10:14:03 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w0PFB4jr037507
	for <qemu-devel@nongnu.org>; Thu, 25 Jan 2018 10:14:02 -0500
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2fqf707g7p-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 25 Jan 2018 10:14:02 -0500
Received: from localhost
	by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <walling@linux.vnet.ibm.com>;
	Thu, 25 Jan 2018 10:14:00 -0500
References: <1516732013-18272-1-git-send-email-walling@linux.vnet.ibm.com>
	<1516732013-18272-4-git-send-email-walling@linux.vnet.ibm.com>
	<c6161112-4dd4-d626-556f-b3a958607779@redhat.com>
From: "Collin L. Walling" <walling@linux.vnet.ibm.com>
Date: Thu, 25 Jan 2018 10:13:57 -0500
MIME-Version: 1.0
In-Reply-To: <c6161112-4dd4-d626-556f-b3a958607779@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Message-Id: <2a10bb90-7a82-bfe8-30da-6ba17b01a212@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v4 03/10] s390-ccw: refactor
 IPL structs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: alifm@linux.vnet.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, david@redhat.com, frankja@linux.vnet.ibm.com

On 01/25/2018 06:39 AM, Thomas Huth wrote:
> On 23.01.2018 19:26, Collin L. Walling wrote:
>> ECKD DASDs have different IPL structures for CDL and LDL
>> formats. The current Ipl1 and Ipl2 structs follow the CDL
>> format, so we prepend "EckdCdl" to them. Boot info for LDL
>> has been moved to a new struct: EckdLdlIpl1.
>>
>> Also introduce structs for IPL stages 1 and 1b.
> I'd maybe move the 1b stuff into a later patch, when you really need it.

Makes sense to me.

>
> By the way, is there a public spec available somewhere for these ECKD
> boot structures?

The zipl source code should be available if you have the time and
want to understand the nitty-gritty of how all the data gets written.

https://github.com/ibm-s390-tools/s390-tools/tree/master/zipl

I'm also fairly confident we have a document available /somewhere/...
I'll ask around and provide something for you ASAP.

>
> Anyway, patch looks fine to me, so:
>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
>

Thanks for the review!

-- 
- Collin L Walling
