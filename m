Received: from eggs.gnu.org ([2001:4830:134:3::10]:36490)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mihajlov@linux.vnet.ibm.com>) id 1f0qas-0005RC-IL
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 11:33:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mihajlov@linux.vnet.ibm.com>) id 1f0qao-0001QU-CK
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 11:33:02 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47922
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mihajlov@linux.vnet.ibm.com>)
	id 1f0qao-0001PO-6T
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 11:32:58 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w2RFOP9M052767
	for <qemu-devel@nongnu.org>; Tue, 27 Mar 2018 11:32:56 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2gyqqubtnv-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 27 Mar 2018 11:32:54 -0400
Received: from localhost
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mihajlov@linux.vnet.ibm.com>;
	Tue, 27 Mar 2018 16:32:50 +0100
References: <20180327123800.28851-1-sathnaga@linux.vnet.ibm.com>
	<686b98e4-cf4e-00c9-e4fd-a3efd9f52994@redhat.com>
	<20180327162542.1517b072.cohuck@redhat.com>
From: Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>
Date: Tue, 27 Mar 2018 17:32:46 +0200
MIME-Version: 1.0
In-Reply-To: <20180327162542.1517b072.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Message-Id: <03198a17-bbac-874c-5205-9e6697393d66@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH for-2.12] hmp.c: Revert hmp_info_cpus
 output format
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, Eric Blake <eblake@redhat.com>
Cc: sathnaga@linux.vnet.ibm.com, qemu-devel@nongnu.org

On 27.03.2018 16:25, Cornelia Huck wrote:
> On Tue, 27 Mar 2018 08:59:04 -0500
> Eric Blake <eblake@redhat.com> wrote:
> 
>> On 03/27/2018 07:38 AM, sathnaga@linux.vnet.ibm.com wrote:
>>> From: Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>
>>>
>>> This commit 137b5cb6ab565cb3781d5337591e155932b4230e
>>> refactors info cpus output and changes output format from
>>> 'thread_id' to 'thread-id', this would break parsing
>>> of output in above layers like libvirt, test framework etc.
>>>
>>> This patch just reverts back output format to 'thread_id'.
>>>
>>> CC: Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>
>>> Signed-off-by: Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>
>>> ---
>>>   hmp.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)  
>>
>> I'm not opposed to this patch (because it is a trivial way to keep older 
>> stuff working), but agree with Daniel that HMP output can change at any 
>> time, so other stuff relying on HMP should be fixed.  Libvirt is not 
>> affected, so if we DO take this into 2.12, we should update the commit 
>> message to drop mention of libvirt being impacted, maybe along the lines of:
>>
>> Commit 137b5cb6 refactored 'info cpus' output, changing 'thread_id' to 
>> 'thread-id'.  While HMP is not a stable interface, it is trivial to keep 
>> the spelling consistent for test frameworks that have not yet updated to 
>> using QMP.
>>
>> With the improved commit message,
>> Reviewed-by: Eric Blake <eblake@redhat.com>
>>
> 
> Yes, that certainly makes sense.
> 
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> 
Right. Seems I got carried away during the thread_id to thread-id
conversion.

-- 
Regards,
 Viktor Mihajlovski
