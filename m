Received: from eggs.gnu.org ([2001:4830:134:3::10]:38127)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dIeFk-0008MN-U3
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 12:56:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dIeFf-000758-WD
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 12:56:17 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44379)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1dIeFf-00074f-Lo
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 12:56:11 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v57Gsobu084701
	for <qemu-devel@nongnu.org>; Wed, 7 Jun 2017 12:56:09 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2axndq81db-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 07 Jun 2017 12:56:08 -0400
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Wed, 7 Jun 2017 17:56:06 +0100
References: <20170606165510.33057-1-pasic@linux.vnet.ibm.com>
	<20170606165510.33057-3-pasic@linux.vnet.ibm.com>
	<87wp8ndac8.fsf@secure.mitica>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Wed, 7 Jun 2017 18:56:03 +0200
MIME-Version: 1.0
In-Reply-To: <87wp8ndac8.fsf@secure.mitica>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <84f8eb54-da74-e55f-324d-91bcb05cc7ca@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [RFC PATCH 2/3] vmstate: error hint for failed
 equal checks part 2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: quintela@redhat.com
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, "Jason J . Herne" <jjherne@linux.vnet.ibm.com>, qemu-devel@nongnu.org



On 06/07/2017 06:35 PM, Juan Quintela wrote:
> Halil Pasic <pasic@linux.vnet.ibm.com> wrote:
>> Verbose error reporting for the _EQUAL family. Modify the standard _EQUAL
>> so the hint states the assertion probably failed due to a bug. Introduce
>> _EQUAL_HINT for specifying a context specific hint.
>>
>> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
>> ---
>> Keeping this separate for now because we may want something different
>> here. E.g. no new macros and adding an extra NULL parameter for all
>> pre-existing  _EQUAL usages.
> 
> 
> I think that the best thing is to just add the HINT always.  I checked
> and there are only 25 uses of VMSTATE_*_EQUAL.  I agree with dave that
> adding a NULL there, and make they work is a better strategy.
> 

Will do that!

> We are adding 8 new macros so we don't have to change 25 callers?
> 

It was more the fear of needlessly complicating the interface that
made me do this version first (I assumed typical usage is without
hint with the purpose of catching bugs).

I also wanted to avoid bothering a lot's of people in the first round
(I assume the usages are spread over files owned by various
maintainers).

Thanks for your review!

Regards,
Halil
