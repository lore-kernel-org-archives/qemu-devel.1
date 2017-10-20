Received: from eggs.gnu.org ([2001:4830:134:3::10]:33603)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1e5Z0A-0005el-4a
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 11:14:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1e5Z09-0006a5-0m
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 11:14:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38812)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1e5Z08-0006ZQ-Nl
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 11:14:20 -0400
References: <87y3oqugm7.fsf@marc-ibm.boeblingen.de.ibm.com>
	<20171005121115.GD3946746@orkuz.home>
	<87y3ok7n2n.fsf@marc-ibm.boeblingen.de.ibm.com>
	<20171012120714.GA314661@orkuz.home>
	<87mv4m6pp5.fsf@marc-ibm.boeblingen.de.ibm.com>
	<0aab6dae-a926-c106-9bc5-68561a9bef5c@redhat.com>
	<0dae2b6c-9164-efc7-5c67-0e4aa5eb4a21@de.ibm.com>
	<fcf03f16-389e-83b5-77bf-d7a50151005c@redhat.com>
	<2bfd5f45-3db1-b6c7-3162-43be564cfa05@de.ibm.com>
	<fb0b2486-706c-c7af-0e38-ddea1faa7b92@redhat.com>
	<90dcd7c4-0a89-df06-90e3-0d8253871395@de.ibm.com>
	<2812651d-6d15-347c-5f1d-40fb0e35f66a@redhat.com>
	<ffef8da1-4824-0940-4dbb-17b7a3de7157@de.ibm.com>
	<c05abe6e-2ba6-a678-fe51-4c0c2f828b7e@linux.vnet.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <b3aa4c20-cbcc-5757-06b1-eba1d3903778@redhat.com>
Date: Fri, 20 Oct 2017 17:14:09 +0200
MIME-Version: 1.0
In-Reply-To: <c05abe6e-2ba6-a678-fe51-4c0c2f828b7e@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [libvirt] Question about the host-model CPU mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Marc Hartmayer <mhartmay@linux.vnet.ibm.com>, libvir-list@redhat.com, qemu-devel@nongnu.org
Cc: Jiri Denemark <jdenemar@redhat.com>, Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>, "Jason J. Herne" <jjherne@linux.vnet.ibm.com>, Boris Fiuczynski <fiuczy@linux.vnet.ibm.com>


> 
> I intend to put some brain-power in this too. Probably next week.
> 
> My general impression is, that I have a at places different understanding
> of how things should work compared to David. Especially when it comes
> to this concept of persistent copying, and also an end-user-digestible
> definition of what host-model does. (I think this with copying capabilities
> from whatever xml which is subject to convoluted caching is a bit too
> hard to digest for an end user not involved in the development of qemu
> and libvirt).

When reading the doc I was assuming that it would be a persistent copy.
But it would only fix part of the issue.

In the end, it specifies quite clearly what is copied. And if that is
not runnable with the selected machine, bad luck. Therefore ...

> 
> I had a conversation with Boris a couple of hours ago, and it seems, things
> are pretty convoluted.
> 
> If I understand the train of thought here (David) it can be summarized like this:
> For a certain QEMU binary no aspect of the cpu-models may depend on the
> machine type. In particular, compat properties and compat handling is
> not alowed to alter cpu-models (whether the available cpu models nor the
> capabilities of each of these).

... I always recommended avoiding such compatibility settings in the
machine. But before we had CPU models it was really all we had. No we
should let go of it.

We might be able to fix this one (gs) and take care of it in the future,
but ...

> 
> This we would have to make a part of the external interface. That way
> one could be sure that the 'cpu capabilities' are machine-type independent
> (that is, the same for all the machine types).

... the problem is once nasty stuff like zPCI comes in place. If we ever
have (other?) machine dependent stuff that toggles CPU features, we can
only try limit the damage.

> 
> Or did I get this completely wrong? (Based on the answer branches my
> think).

Not at all.

> 
> Halil
> 


-- 

Thanks,

David
