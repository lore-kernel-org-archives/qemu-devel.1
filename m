Received: from eggs.gnu.org ([2001:4830:134:3::10]:45564)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.ibm.com>) id 1ffkvd-00028B-F0
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 07:47:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.ibm.com>) id 1ffkvZ-0004RK-Ae
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 07:47:33 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52220
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.ibm.com>) id 1ffkvZ-0004R2-4C
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 07:47:29 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w6IBi7nC179840
	for <qemu-devel@nongnu.org>; Wed, 18 Jul 2018 07:47:28 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2ka4t68f9y-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 18 Jul 2018 07:47:28 -0400
Received: from localhost
	by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.ibm.com>;
	Wed, 18 Jul 2018 12:47:26 +0100
References: <1530811543-6881-1-git-send-email-jjherne@linux.ibm.com>
	<1530811543-6881-15-git-send-email-jjherne@linux.ibm.com>
	<a00e445e-f8f5-b098-bccb-7fcaf1260402@redhat.com>
	<20180718094039.3271a216.cohuck@redhat.com>
	<066430cc-7ab0-839e-0cc9-7cdda027c253@linux.ibm.com>
	<20180718133537.26dfeffa.cohuck@redhat.com>
From: Halil Pasic <pasic@linux.ibm.com>
Date: Wed, 18 Jul 2018 13:47:20 +0200
MIME-Version: 1.0
In-Reply-To: <20180718133537.26dfeffa.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <84bac3f2-2745-36e1-7bd4-20d7667c0f20@linux.ibm.com>
Subject: Re: [Qemu-devel] [qemu-s390x] [RFC 14/15] s390-bios: Support
 booting from real dasd device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: "Jason J. Herne" <jjherne@linux.ibm.com>, David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org, borntraeger@de.ibm.com, qemu-s390x@nongnu.org, bjsdjshi@linux.ibm.com



On 07/18/2018 01:35 PM, Cornelia Huck wrote:
>> So to translate the new stuff we would actually have to stop the channel
>> program and resubmit the rest (either by suspend+resume or by break
>> chaining+ssch). The problem with that an execution of a channel program
>> that is composed of four ccws A,B,C,D and an execution of a channel
>> programs composed of ccws A,B immediately followed by and execution
>> of a channel program composed of the ccws C,D is not the same. I.e. it
>> is not generally safe to break a chain of ccws.
> Exploiting suspending would have been my idea. Probably combined with a
> new interface that fetches ccw-by-ccw.
> 
> But I don't think it makes sense to spend time thinking about this
> right now.
> 

IMHO exploiting suspending won't work, because the rsch starts a new
chain. If the suspend is a part of the original program the author
of it is responsible to make sure this ain't a problem. But if we
start setting the suspend flag ourselves, we may end up in trouble.

Regards,
Halil  
