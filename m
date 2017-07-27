Received: from eggs.gnu.org ([2001:4830:134:3::10]:36676)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dah3l-00055r-IK
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 07:34:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dah3i-0002uG-TZ
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 07:34:29 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55999
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1dah3i-0002u2-O4
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 07:34:26 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v6RBXvaA116330
	for <qemu-devel@nongnu.org>; Thu, 27 Jul 2017 07:34:25 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2bydde5qdq-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 27 Jul 2017 07:34:24 -0400
Received: from localhost
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Thu, 27 Jul 2017 12:34:21 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com
	[9.149.105.59])
	by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with
	ESMTP id v6RBYJ7A40894518
	for <qemu-devel@nongnu.org>; Thu, 27 Jul 2017 11:34:19 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7F498A4051
	for <qemu-devel@nongnu.org>; Thu, 27 Jul 2017 12:31:25 +0100 (BST)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2D523A4040
	for <qemu-devel@nongnu.org>; Thu, 27 Jul 2017 12:31:25 +0100 (BST)
Received: from oc3836556865.ibm.com (unknown [9.152.224.141])
	by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP
	for <qemu-devel@nongnu.org>; Thu, 27 Jul 2017 12:31:25 +0100 (BST)
References: <20170725224442.13383-1-pasic@linux.vnet.ibm.com>
	<20170727102636.43d6a789@gondolin>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Thu, 27 Jul 2017 13:34:19 +0200
MIME-Version: 1.0
In-Reply-To: <20170727102636.43d6a789@gondolin>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <afdebd22-d914-c945-2665-2588c426d498@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 0/2] ccw interpretation AR compliance
 improvements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org



On 07/27/2017 10:26 AM, Cornelia Huck wrote:
> On Wed, 26 Jul 2017 00:44:40 +0200
> Halil Pasic <pasic@linux.vnet.ibm.com> wrote:
> 
>> There were some missing checks. There might be some more missing.  For details,
>> see the individual patches.
> 
> The checks are not perfect? Colour me shocked ;)
> 

With a fedora or without ;)?


>>
>> Regarding testing: did not do much more than a simple smoke test
>> with virtio-ccw.
> 
> I think we need a way to throw random channel programs at a channel
> device...
> 

By random do you mean random random, or do you mean carefully crafted
to provoke (and verify) certain responses. If it's more like the second
case I've actually wrote something (a kernel driver) for 'internal use'
but at the moment it's limited to indirect data access support (no test
cases for invalid invalid channel programs). The 'internal guys' say it
probably ain't interesting for the rest of the world make this external,
but if you are interested I could send you the patch these days.

Regards,
Halil

>>
>> Halil Pasic (2):
>>   s390x/css: check ccw address validity
>>   s390x/css: fix bits must be zero check for TIC
>>
>>  hw/s390x/css.c | 21 ++++++++++++++++++++-
>>  1 file changed, 20 insertions(+), 1 deletion(-)
>>
> 
> 
