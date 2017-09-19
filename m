Received: from eggs.gnu.org ([2001:4830:134:3::10]:39775)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1duMuM-0001kL-UN
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 14:06:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1duMuH-0005xb-JI
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 14:06:04 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33992
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1duMuH-0005pj-Dj
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 14:06:01 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v8JI5XDo118394
	for <qemu-devel@nongnu.org>; Tue, 19 Sep 2017 14:05:57 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2d35np11ef-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 19 Sep 2017 14:05:57 -0400
Received: from localhost
	by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Tue, 19 Sep 2017 19:05:50 +0100
References: <20170913115029.47626-1-pasic@linux.vnet.ibm.com>
	<20170913115029.47626-5-pasic@linux.vnet.ibm.com>
	<20170919055005.GE5274@bjsdjshi@linux.vnet.ibm.com>
	<20170919114859.3e2d895b.cohuck@redhat.com>
	<fbb3522e-4086-359a-fca7-05371b76dac7@linux.vnet.ibm.com>
	<20170919125717.1ae0cd38.cohuck@redhat.com>
	<9872cee8-3503-8d52-c68f-d9c61143201c@linux.vnet.ibm.com>
	<20170919142351.1e3b66d8.cohuck@redhat.com>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Tue, 19 Sep 2017 20:05:48 +0200
MIME-Version: 1.0
In-Reply-To: <20170919142351.1e3b66d8.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <07b62387-ded5-ab32-e493-d3ffabc5c21b@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v2 4/4] s390x/css: support ccw IDA
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



On 09/19/2017 02:23 PM, Cornelia Huck wrote:
>>>>> +{
>>>>> +    union {uint64_t fmt2; uint32_t fmt1; } idaw;      
>>>>                                            ^
>>>> Nit.
>>>>    
>> Maybe checkpatch wanted it this way. My memories are blurry.  
> I'd just leave it like that, tbh.

Yes, if I remove the space before the } checkpatch.pl complains.

Going to keep it as is for v3.

Halil
