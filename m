Received: from eggs.gnu.org ([2001:4830:134:3::10]:41325)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dtzlU-0004SD-9r
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 13:23:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dtzlR-0001hA-6n
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 13:23:24 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36524)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1dtzlQ-0001go-U4
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 13:23:21 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v8IHJHxj016941
	for <qemu-devel@nongnu.org>; Mon, 18 Sep 2017 13:23:19 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2d2gdt0bd9-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 18 Sep 2017 13:23:19 -0400
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Mon, 18 Sep 2017 18:23:17 +0100
References: <20170918163322.206581-1-borntraeger@de.ibm.com>
	<c83c066e-093a-fca5-6c47-9eff6cffc03d@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Mon, 18 Sep 2017 19:23:13 +0200
MIME-Version: 1.0
In-Reply-To: <c83c066e-093a-fca5-6c47-9eff6cffc03d@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <2e7d1283-86f7-7650-073a-2f10b07d8ad3@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH] s390x/cpu: expose the guest crash
 information
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Cornelia Huck <cohuck@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>, Jing Liu <liujbjl@linux.vnet.ibm.com>, qemu-devel <qemu-devel@nongnu.org>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>



On 09/18/2017 07:12 PM, Eric Blake wrote:
> On 09/18/2017 11:33 AM, Christian Borntraeger wrote:
>> From: Jing Liu <liujbjl@linux.vnet.ibm.com>
>>
>> This patch is the s390 implementation of guest crash information, similar
>> to commit d187e08dc4 ("i386/cpu: add crash-information QOM property") and
>> the related commits. We will detect several crash reasons, with the
>> "disabled wait" being the most important one, since this is used by all
>> s390 guests as a "panic like" notification.
>>
> 
>> +
>> +##
>> +# @GuestPanicInformationKVMS390:
>> +#
>> +# KVM-S390 specific guest panic information (PSW)
>> +#
>> +# Since: 2.11
>> +##
>> +{'struct': 'GuestPanicInformationKVMS390',
>> + 'data': { 'psw_mask': 'uint64',
>> +           'psw_addr': 'uint64',
> 
> New interfaces should favor '-' over '_'; is there any reason we can't
> name these 'psw-mask' and 'pws-addr'?

Can change.
