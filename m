Received: from eggs.gnu.org ([2001:4830:134:3::10]:60150)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <walling@linux.vnet.ibm.com>) id 1eJhx8-0007uu-0i
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 10:37:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <walling@linux.vnet.ibm.com>) id 1eJhx3-0003WX-42
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 10:37:42 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44618
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <walling@linux.vnet.ibm.com>)
	id 1eJhx2-0003WG-U5
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 10:37:37 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vASFZqxI068227
	for <qemu-devel@nongnu.org>; Tue, 28 Nov 2017 10:37:36 -0500
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2eha8psgm7-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 28 Nov 2017 10:37:34 -0500
Received: from localhost
	by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <walling@linux.vnet.ibm.com>;
	Tue, 28 Nov 2017 08:36:49 -0700
References: <1511816136-30068-1-git-send-email-walling@linux.vnet.ibm.com>
	<1511816136-30068-2-git-send-email-walling@linux.vnet.ibm.com>
	<20171128114558.5284f736.cohuck@redhat.com>
From: "Collin L. Walling" <walling@linux.vnet.ibm.com>
Date: Tue, 28 Nov 2017 10:36:44 -0500
MIME-Version: 1.0
In-Reply-To: <20171128114558.5284f736.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Message-Id: <53db60d4-5f6f-0da2-1401-d1f67e45e569@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v1 1/5] s390-ccw: update libc.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: borntraeger@de.ibm.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org, frankja@linux.vnet.ibm.com

On 11/28/2017 05:45 AM, Cornelia Huck wrote:
> On Mon, 27 Nov 2017 15:55:32 -0500
> "Collin L. Walling" <walling@linux.vnet.ibm.com> wrote:
>
>> Moved:
>>    memcmp from bootmap.h to libc.h (renamed from _memcmp)
>>    strlen from sclp.c to libc.h (renamed from _strlen)
>>
>> Added C standard functions:
>>    isdigit
>>    atoi
>>
>> Added non-C standard function:
>>    itostr
>>
>> Signed-off-by: Collin L. Walling <walling@linux.vnet.ibm.com>
>> Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
>> Reviewed-by: frankja@linux.vnet.ibm.com
> You might want to include Janosch's complete name :)

Whoops! I'll make sure his complete name is in there.

-- 
- Collin L Walling
