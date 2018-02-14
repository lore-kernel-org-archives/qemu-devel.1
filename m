Received: from eggs.gnu.org ([2001:4830:134:3::10]:60697)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mihajlov@linux.vnet.ibm.com>) id 1elzKD-0001wS-43
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 10:50:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mihajlov@linux.vnet.ibm.com>) id 1elzK8-00057C-35
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 10:50:25 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55220
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mihajlov@linux.vnet.ibm.com>)
	id 1elzK7-00056v-Qr
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 10:50:19 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w1EFnBgd132710
	for <qemu-devel@nongnu.org>; Wed, 14 Feb 2018 10:50:19 -0500
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2g4ptjv07v-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 14 Feb 2018 10:50:18 -0500
Received: from localhost
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mihajlov@linux.vnet.ibm.com>;
	Wed, 14 Feb 2018 15:50:15 -0000
References: <1518542328-25741-1-git-send-email-mihajlov@linux.vnet.ibm.com>
	<1518542328-25741-4-git-send-email-mihajlov@linux.vnet.ibm.com>
	<20180214111522.677d77bc.cohuck@redhat.com>
	<a0d9f591-8f6d-4c98-8b71-cb8585c1ef12@redhat.com>
	<20180214162715.54743e55.cohuck@redhat.com>
From: Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>
Date: Wed, 14 Feb 2018 16:50:09 +0100
MIME-Version: 1.0
In-Reply-To: <20180214162715.54743e55.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Message-Id: <b1704559-ae69-8c1c-eae5-3e473e271364@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCHv2 3/3] qmp: add architecture specific cpu
 data for query-cpus-fast
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, Eric Blake <eblake@redhat.com>, berrange@redhat.com
Cc: qemu-devel@nongnu.org, agraf@suse.de, ehabkost@redhat.com, armbru@redhat.com, david@redhat.com, dgilbert@redhat.com, borntraeger@de.ibm.com, qemu-s390x@nongnu.org, pbonzini@redhat.com, rth@twiddle.net

On 14.02.2018 16:27, Cornelia Huck wrote:
> On Wed, 14 Feb 2018 09:15:23 -0600
> Eric Blake <eblake@redhat.com> wrote:
> 
>> On 02/14/2018 04:15 AM, Cornelia Huck wrote:
>>> On Tue, 13 Feb 2018 18:18:48 +0100
>>> Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com> wrote:
>>>   
>>
>>>> A suggestion was made on the mailing list to enhance the QAPI
>>>> code generation to support two layers of unions. This would
>>>> allow to specify the common fields once and avoid the duplication
>>>> in the leaf unions.
>>>>
>>>> On the other hand, the slow query-cpus should be deprecated
>>>> along with the slow CpuInfo type and eventually be removed.
>>>> Assuming that new architectures will not be added at high
>>>> rates, we could live with the duplication for the time being.  
>>>
>>> What would be a realistic timeframe for deprecation/removal of
>>> query-cpus, considering the libvirt usage? Are we aware of other users?  
>>
>> Well, if we want to start the clock ticking, this series also needs to 
>> touch qemu-doc.texi to start the deprecation clock, then we go at least 
>> two more releases with support for both old and new commands.
>>
> 
> I'd like to know first what libvirt plans to do -- no sense in starting
> deprecation if we're still stuck with it for a while.
> 
FWIW, I'm currently preparing libvirt patches to use query-cpus-fast if
available. I wouldn't see why it would take more than one libvirt
release to get them in.

The question might rather be, which combinations of qemu and libvirt are
considered useful. E.g., I didn't upgrade libvirt in a while on my test
system but am using bleeding edge QEMU. But that doesn't necessarily
resemble a valid setup.

-- 
Regards,
 Viktor Mihajlovski
