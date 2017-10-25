Received: from eggs.gnu.org ([2001:4830:134:3::10]:56529)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mhartmay@linux.vnet.ibm.com>) id 1e7Ooi-0002t8-TP
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 12:46:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mhartmay@linux.vnet.ibm.com>) id 1e7Oof-0008Kk-QS
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 12:46:08 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54244)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mhartmay@linux.vnet.ibm.com>)
	id 1e7Oof-0008Ja-Hc
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 12:46:05 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v9PGjtVd022096
	for <qemu-devel@nongnu.org>; Wed, 25 Oct 2017 12:46:00 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2dtvgmefnu-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 25 Oct 2017 12:45:59 -0400
Received: from localhost
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mhartmay@linux.vnet.ibm.com>;
	Wed, 25 Oct 2017 17:45:56 +0100
From: Marc Hartmayer <mhartmay@linux.vnet.ibm.com>
In-Reply-To: <a7b30204-a854-afde-af01-234520cc6d7b@redhat.com>
References: <20171020145437.18549-1-borntraeger@de.ibm.com>
	<d028d04a-9c28-af10-3410-f9007867cc05@de.ibm.com>
	<1ac27ce2-091d-e1b7-fc94-ebdf696a35e9@redhat.com>
	<9f4037d8-93a3-be0f-8cb4-4424158e236b@linux.vnet.ibm.com>
	<a7b30204-a854-afde-af01-234520cc6d7b@redhat.com>
Date: Wed, 25 Oct 2017 18:45:51 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Message-Id: <87wp3jqips.fsf@marc-ibm.boeblingen.de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH/QEMU] s390x/kvm: use cpu_model_available
 for guarded storage on compat machines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, Boris Fiuczynski <fiuczy@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: libvir-list@redhat.com, qemu-devel@nongnu.org, Jiri Denemark <jdenemar@redhat.com>, "Jason J . Herne" <jjherne@linux.vnet.ibm.com>, Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>, Halil Pasic <pasic@linux.vnet.ibm.com>

On Wed, Oct 25, 2017 at 05:50 PM +0200, David Hildenbrand <david@redhat.com=
> wrote:
> On 25.10.2017 17:09, Boris Fiuczynski wrote:
>> On 10/25/2017 12:23 PM, David Hildenbrand wrote:
>>> On 25.10.2017 12:18, Christian Borntraeger wrote:
>>>> Ping, I plan to submit belows patch for 2.11. We can then still look i=
nto
>>>> a libvirt<->qemu interface for limiting host-model depending on machin=
e versions
>>>> (or not).
>>>
>>> I think this would be sufficient for now.
>>>
>>> Having different host models, depending on the the machine type sounds
>>> wrong. But maybe we'll need it in the future.
>>>
>>
>> David, I disagree if your proposal is to generally tolerate new cpu
>> features in old machine types. This *might* work for gs but how do you
>> guaranty that guests do not behave differently/wrong when suddenly new
>> cpu features are made available to guest when (re-)starting them.
>> That is my feedback for the qemu side of this mater.
>
> Just re-reading this section, so what you mean is:
>
> a) guest is started, host model is copied and used. guest works.
> b) guest is stopped.
> c) QEMU/KVM/HW is updated.
> d) guest is started, new host model is copied. guest no longer works.
>
> d) could be because there are now some additional features with e.g.
> broken guest implementation or now missing features.
>
>
> What you propose (if I am not wrong) is a to bind features somehow to a
> QEMU machine. I think that should never be done. You could not catch now
> missing features.

What exactly do you mean by the last sentence?

>
> What would you think about a persistent host-model copy option? So
> instead of copying at every start, only copy and replace it once in the X=
ML?
>
> Easy to specify by the user and no CPU feature changes will happend
> "blindly".
>
>
> --
>
> Thanks,
>
> David
>
--
Beste Gr=C3=BC=C3=9Fe / Kind regards
   Marc Hartmayer

IBM Deutschland Research & Development GmbH
Vorsitzende des Aufsichtsrats: Martina Koederitz
Gesch=C3=A4ftsf=C3=BChrung: Dirk Wittkopp
Sitz der Gesellschaft: B=C3=B6blingen
Registergericht: Amtsgericht Stuttgart, HRB 243294
