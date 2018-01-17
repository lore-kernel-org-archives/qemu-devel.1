Received: from eggs.gnu.org ([2001:4830:134:3::10]:34592)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1ebtuh-0000VY-Uz
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 15:02:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1ebtud-0003uv-0C
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 15:02:24 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:32998
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1ebtuc-0003uc-QJ
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 15:02:18 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w0HJtSrn076563
	for <qemu-devel@nongnu.org>; Wed, 17 Jan 2018 15:02:17 -0500
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2fjag47jqe-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 17 Jan 2018 15:02:17 -0500
Received: from localhost
	by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Wed, 17 Jan 2018 20:02:15 -0000
References: <20180117193757.73471-1-borntraeger@de.ibm.com>
	<20180117193757.73471-2-borntraeger@de.ibm.com>
	<c309fedd-29c0-e627-11e4-64fcbb7f09f5@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Wed, 17 Jan 2018 21:02:11 +0100
MIME-Version: 1.0
In-Reply-To: <c309fedd-29c0-e627-11e4-64fcbb7f09f5@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <746ffa7a-1452-ffcb-e305-a4cac7aee113@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v2 1/3] header sync
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Cornelia Huck <cohuck@redhat.com>
Cc: Janosch Frank <frankja@linux.vnet.ibm.com>, Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Alexander Graf <agraf@suse.de>, qemu-s390x <qemu-s390x@nongnu.org>, Halil Pasic <pasic@linux.vnet.ibm.com>, Richard Henderson <rth@twiddle.net>

It is just a header sync and mimics the kernel.
The previous header sync added the the commit that added the SPDX tag and this
header sync added the commit that removed the now redundant licence text.

On 01/17/2018 08:46 PM, Eric Blake wrote:
> On 01/17/2018 01:37 PM, Christian Borntraeger wrote:
>> replace with proper header sync
>>
>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
>> ---
>>  linux-headers/asm-s390/kvm.h | 9 ++++-----
>>  linux-headers/linux/kvm.h    | 5 +++--
>>  2 files changed, 7 insertions(+), 7 deletions(-)
>>tag
>> diff --git a/linux-headers/asm-s390/kvm.h b/linux-headers/asm-s390/kvm.h
>> index 32d372e..11def14 100644
>> --- a/linux-headers/asm-s390/kvm.h
>> +++ b/linux-headers/asm-s390/kvm.h
>> @@ -6,10 +6,6 @@
>>   *
>>   * Copyright IBM Corp. 2008
>>   *
>> - * This program is free software; you can redistribute it and/or modify
>> - * it under the terms of the GNU General Public License (version 2 only)
>> - * as published by the Free Software Foundation.
>> - *
> 
> Is dropping a license clause intentional?  If so, the commit message may
> want to go into more details why it is okay.
> 
