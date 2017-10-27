Received: from eggs.gnu.org ([2001:4830:134:3::10]:47033)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1e88x6-0003Vc-VI
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 14:01:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1e88x3-00045t-Tc
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 14:01:53 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54356
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1e88x3-00044z-Oa
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 14:01:49 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v9RI0EGW019599
	for <qemu-devel@nongnu.org>; Fri, 27 Oct 2017 14:01:45 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2dv8rmtp1f-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 27 Oct 2017 14:01:44 -0400
Received: from localhost
	by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Fri, 27 Oct 2017 19:01:43 +0100
References: <20171020145437.18549-1-borntraeger@de.ibm.com>
	<c76678f3-70df-e963-12b8-208c5c2a1578@linux.vnet.ibm.com>
	<b40f75d4-2280-fc66-b92f-34717b51ed47@linux.vnet.ibm.com>
	<d7a16f29-1420-d723-4a42-ac549e3f4f52@de.ibm.com>
	<03b0c516-7044-d71e-1b1f-c3bef84ac812@de.ibm.com>
	<108a9258-f245-f0bc-44cd-29f6528d34d4@linux.vnet.ibm.com>
	<277f202a-212b-2868-06e0-62c262909c03@de.ibm.com>
	<a98a959b-dc89-a75b-6479-9d8c2d9666b7@linux.vnet.ibm.com>
	<20171027171231.GI4938@orkuz.home>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Fri, 27 Oct 2017 20:01:38 +0200
MIME-Version: 1.0
In-Reply-To: <20171027171231.GI4938@orkuz.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <834ff2e2-53b7-a3c3-bedf-214c17884efb@linux.vnet.ibm.com>
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
To: Christian Borntraeger <borntraeger@de.ibm.com>, jjherne@linux.vnet.ibm.com, Marc Hartmayer <mhartmay@linux.vnet.ibm.com>, Cornelia Huck <cohuck@redhat.com>, libvir-list@redhat.com, qemu-devel@nongnu.org, Boris Fiuczynski <fiuczy@linux.vnet.ibm.com>



On 10/27/2017 07:12 PM, Jiri Denemark wrote:
> On Fri, Oct 27, 2017 at 17:18:44 +0200, Halil Pasic wrote:
>> On 10/27/2017 04:06 PM, Christian Borntraeger wrote:
> ...
>>> I talked to several people and it seems that on x86 the host model will also enable new features
>>> that are not known by older QEMUs and its considered works as designed. (see also Jiris mail)
>>
>> Yes, I've seen that. It would be nice though if this design was easier to
>> find in written. Unfortunately I can read minds only to a very limited extent,
>> and the written stuff I've read did not give me a full understanding of the
>> design -- although the entity to blame for this could be my limited intellect.
> 
> I think it's more likely the documentation is just not perfect. I'll
> look at it and try to make it better. I know about some parts which need
> to be clarified thanks to this discussion.
> 
> Jirka
> 

Feel free to put me on cc for the patch. I would be happy to give it a
look, but since I'm not actively reading the libvirt list, I'm afraid it will
slip past me if I'm not in cc.

Regards,
Halil
