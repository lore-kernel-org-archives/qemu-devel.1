Received: from eggs.gnu.org ([2001:4830:134:3::10]:34943)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dsRvB-000382-V2
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 07:03:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dsRv8-0005HF-NS
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 07:03:01 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46958
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1dsRv8-0005Gr-IQ
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 07:02:58 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v8EAxkiM014881
	for <qemu-devel@nongnu.org>; Thu, 14 Sep 2017 07:02:57 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2cynx3aabq-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 14 Sep 2017 07:02:57 -0400
Received: from localhost
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Thu, 14 Sep 2017 12:02:54 +0100
References: <20170913115029.47626-1-pasic@linux.vnet.ibm.com>
	<20170914111556.457796e0.cohuck@redhat.com>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Thu, 14 Sep 2017 13:02:51 +0200
MIME-Version: 1.0
In-Reply-To: <20170914111556.457796e0.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <8e6f5026-727c-89fc-a052-7142e011a381@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v2 0/4] add CCW indirect data access support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, qemu-devel@nongnu.org



On 09/14/2017 11:15 AM, Cornelia Huck wrote:
> On Wed, 13 Sep 2017 13:50:25 +0200
> Halil Pasic <pasic@linux.vnet.ibm.com> wrote:
> 
>> Abstract
>> --------
>>
>> The objective of this series is introducing CCW IDA (indirect data
>> access) support to our virtual channel subsystem implementation. Briefly
>> CCW IDA can be thought of as a kind of a scatter gather support for a
>> single CCW. If certain flags are set, the cda is to be interpreted as an
>> address to a list which in turn holds further addresses designating the
>> actual data.  Thus the scheme which we are currently using for accessing
>> CCW payload does not work in general case. Currently there is no
>> immediate need for proper IDA handling (no use case), but since it IDA is
>> a non-optional part of the architecture, the only way towards AR
>> compliance is actually implementing IDA.
>>
>> Testing
>> -------
>>
>> On request the things meant for testing from v1 were factored out
>> into a separate series (requested by Connie). Please look for
>> the series  'tests for CCW IDA' (comming soon) or use the stuff
>> form v1.
> 
> Generally, looks good; currently testing it.
> 
> Would not mind some R-bs :)
> 

Many thanks for the quick review! Of course I consent to every
change you have proposed to make (before applying).

About the stale comments I've just sent out a patch.

About the r-b's I think the guys in cc are the most likely
candidates. Pierre should be back starting next week. Dong
Jia I haven't seen in a while, but I don't know about anything.
Of course I would happy if somebody less expected joins in.

Thanks again!

Halil
