Received: from eggs.gnu.org ([2001:4830:134:3::10]:51901)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1e84sb-0004Nt-LJ
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 09:40:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1e84sY-0003CP-FW
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 09:40:57 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58744
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1e84sY-0003Au-9Y
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 09:40:54 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v9RDafPp016822
	for <qemu-devel@nongnu.org>; Fri, 27 Oct 2017 09:40:51 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2dv5tcgbr0-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 27 Oct 2017 09:40:50 -0400
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Fri, 27 Oct 2017 14:40:49 +0100
References: <20171020145437.18549-1-borntraeger@de.ibm.com>
	<c76678f3-70df-e963-12b8-208c5c2a1578@linux.vnet.ibm.com>
	<b40f75d4-2280-fc66-b92f-34717b51ed47@linux.vnet.ibm.com>
	<d7a16f29-1420-d723-4a42-ac549e3f4f52@de.ibm.com>
	<03b0c516-7044-d71e-1b1f-c3bef84ac812@de.ibm.com>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Fri, 27 Oct 2017 15:40:46 +0200
MIME-Version: 1.0
In-Reply-To: <03b0c516-7044-d71e-1b1f-c3bef84ac812@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <108a9258-f245-f0bc-44cd-29f6528d34d4@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [libvirt] [PATCH/QEMU] s390x/kvm: use
 cpu_model_available for guarded storage on compat machines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>, jjherne@linux.vnet.ibm.com, Marc Hartmayer <mhartmay@linux.vnet.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: libvir-list@redhat.com, Jiri Denemark <jdenemar@redhat.com>, qemu-devel@nongnu.org



On 10/27/2017 02:57 PM, Christian Borntraeger wrote:
> 
> 
> On 10/27/2017 02:45 PM, Christian Borntraeger wrote:
>>
>>
>> On 10/27/2017 02:31 PM, Halil Pasic wrote:
>> gs is explicitly disabled.
>>>
>>> Now that I think about it, maybe the 2.9 binary is going to reject
>>> the explicit gs flag altogether, because it's unknown.
>>>
>>> Isn't this a problem? 
>>
>> No. This is exactly the _solution_ and not the problem. The target will reject
>> unknown cpu features and migration will be aborted. This is exactly what the CPU
>> model is for.

I'm not sure we talk abut the same thing. I'm talking about the following. I
want to disable a cpu-model feature for the sake of migration (because I know
that binary version X does not support the feature, because it does not know
about it). Now if I do it via let's say -cpu z13,gs=off on let's say 2.11,
and start with the exact same command line (-cpu z13,gs=off) on lets say 2.9
my migration will explode because of the unknown feature I'm specifying
not to be used.

Well I'm not sure what I describe is relevant. My thinking is along the lines
some features are added incrementally. How do use those of the features not included
in -base model which both of my environments support and disable those that
are unsupported by one of the environments.

I will think about it some more. I've asked Boris about this situation,
and he did not put my mind at ease (to be more precise he seemed to
see this as a potential problem too), so I've decided to mention it.
Sorry if I've generated some unnecessary noise.

I think the root of the problem is that I don't understand the difference between
z13-base and z13, and the associated rules and expected/intended usages. 

> FWIW, I think in your particular case the QEMU will reject the z14 cpu and not even come
> to checking the gs. 
> 

I had a z13 cpu model in mind. I don't mention a z14 cpu-model (QEMU, not hw) in
my whole email.

Regards,
Halil
