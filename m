Received: from eggs.gnu.org ([209.51.188.92]:45785)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jjherne@linux.ibm.com>) id 1ghbrJ-0002ZJ-BV
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 10:03:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jjherne@linux.ibm.com>) id 1ghbrI-0006we-BW
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 10:03:01 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33078)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jjherne@linux.ibm.com>)
	id 1ghbrI-0006uo-0b
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 10:03:00 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	x0AExQ08009793
	for <qemu-devel@nongnu.org>; Thu, 10 Jan 2019 10:02:58 -0500
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2px73ac7v2-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 10 Jan 2019 10:02:56 -0500
Received: from localhost
	by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <jjherne@linux.ibm.com>;
	Thu, 10 Jan 2019 15:02:53 -0000
Reply-To: jjherne@linux.ibm.com
References: <1544623878-11248-1-git-send-email-jjherne@linux.ibm.com>
	<1544623878-11248-11-git-send-email-jjherne@linux.ibm.com>
	<20181213182100.6da37a95.cohuck@redhat.com>
	<bfde1bd3-0725-1085-8a98-eeaf2b0694ed@linux.ibm.com>
	<729790ec-a74a-2e6e-89ed-3d450c95f54f@linux.ibm.com>
	<20190109193406.616fcf66.cohuck@redhat.com>
	<18c1ba75-84f6-e928-64a9-ccf5044d92b5@linux.ibm.com>
	<20190110131513.0d264b10.cohuck@redhat.com>
From: "Jason J. Herne" <jjherne@linux.ibm.com>
Date: Thu, 10 Jan 2019 10:02:48 -0500
MIME-Version: 1.0
In-Reply-To: <20190110131513.0d264b10.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <ab861426-9a7e-ff00-e5de-0bcbef6d7f5f@linux.ibm.com>
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH 10/15] s390-bios: Support for
 running format-0/1 channel programs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: pasic@linux.ibm.com, borntraeger@de.ibm.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org

On 1/10/19 7:15 AM, Cornelia Huck wrote:
> On Wed, 9 Jan 2019 15:01:19 -0500
> "Jason J. Herne" <jjherne@linux.ibm.com> wrote:
> 
>> On 1/9/19 1:34 PM, Cornelia Huck wrote:
>>> On Wed, 9 Jan 2019 13:10:26 -0500
>>> "Jason J. Herne" <jjherne@linux.ibm.com> wrote:
> 
>>>> I'm not sure what value there is in abstracting sense at the moment. I'm not even sure
>>>> what other device's sense data looks like. Since my description of the SENSE CCW comes
>>>> from an ECKD reference I have not been able to verify any areas of the data that are
>>>> common across device types. Thoughts?
>>>
>>> There's SA22-7204-01 ("Common I/O Device Commands"), which is from 1992
>>> (this is what I have on my disk -- is there anything newer?). It
>>> specifies what bits 0-5 of byte 0 mean and states that bytes 1-31 are
>>> optional and device-specific.
>>>
>>> Maybe some other bits have been specified after 1992, but I have not
>>> come across documentation for them.
>>
>> That publication is no longer available. According to my quick research it has been
>> replaced by an internal only publication. I'll see what I can find.
> 
> The publication no longer being available is not good, as it is a
> normative reference pointed to by the virtio standard (see
> http://docs.oasis-open.org/virtio/virtio/v1.0/cs04/virtio-v1.0-cs04.html#x1-30001)
> :(
> 
> Is there any chance that at least that old version can be made
> available again?

A quick web search turns up the following link:
http://publibz.boulder.ibm.com/support/libraryserver/FRAMESET/DZ9AR501/CCONTENTS?D

So I guess it is available, even if the document has been superseded internally.


-- 
-- Jason J. Herne (jjherne@linux.ibm.com)
