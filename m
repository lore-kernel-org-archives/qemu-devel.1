Received: from eggs.gnu.org ([2001:4830:134:3::10]:55384)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1ceNJ3-0007ru-Qn
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 09:45:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1ceNIy-0004ea-Pm
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 09:45:13 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54268)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1ceNIy-0004d4-Fx
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 09:45:08 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1GEdSCA112329
	for <qemu-devel@nongnu.org>; Thu, 16 Feb 2017 09:45:07 -0500
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	by mx0a-001b2d01.pphosted.com with ESMTP id 28nd69argp-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 16 Feb 2017 09:45:07 -0500
Received: from localhost
	by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Thu, 16 Feb 2017 07:45:06 -0700
References: <20170116195452.23532-1-ehabkost@redhat.com>
	<0503ac26-e660-325c-8257-59227c41021d@redhat.com>
	<1daa0992-e594-d870-f264-923bf1cb9673@de.ibm.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Thu, 16 Feb 2017 15:44:59 +0100
MIME-Version: 1.0
In-Reply-To: <1daa0992-e594-d870-f264-923bf1cb9673@de.ibm.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Message-Id: <00e9f692-9d5f-4e85-7502-9fafb43a45f0@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH] i386: Support "-cpu host" on TCG too
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
Cc: Jiri Denemark <jdenemar@redhat.com>, Richard Henderson <rth@twiddle.net>, Igor Mammedov <imammedo@redhat.com>, "Jason J. Herne" <jjherne@linux.vnet.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>

On 02/16/2017 03:43 PM, Christian Borntraeger wrote:
> On 01/17/2017 06:43 PM, David Hildenbrand wrote:
>> Am 16.01.2017 um 20:54 schrieb Eduardo Habkost:
>>> Change the meaning of "-cpu host" to "enable all features
>>> supported by the accelerator in the current host", so that it can
>>> be used to enable/query all features supported by TCG.
>>>
>>> To make sure "host" is still at the end of the list in "-cpu
>>> help", add a "ordering" field that will be used when sorting the
>>> CPU model list.
>>>
>>> Cc: Richard Henderson <rth@twiddle.net>
>>> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
>>
>> I also had the same thing in mind when working on s390x models but
>> decided to do it like x86. Now that x86 changes ...
>>
>> Something like that should work for s390x (and I don't think it will break any concept). Most probably cleaner to handle this the same
>> way on all architectures and to not disable tests for s390x.
>>
>> Uncompiled and untested.
>>
>> @Conny and Christian, feel free to pick up and modify if this makes
>> sense
>>
> Looks sane to me. Can you resend properly, it looks like whitespace
> got damaged all over the place.
> 
> Thanks

Forget that. For some reason, the "max" cpu patch series did not reach my inbox :-/
Will look into that.
