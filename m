Received: from eggs.gnu.org ([209.51.188.92]:48930)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pmorel@linux.ibm.com>) id 1goWej-0002U2-Od
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 11:54:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pmorel@linux.ibm.com>) id 1goWeh-00022b-PG
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 11:54:37 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56102
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pmorel@linux.ibm.com>)
	id 1goWef-0001zg-RM
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 11:54:35 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x0TGoIej018650
	for <qemu-devel@nongnu.org>; Tue, 29 Jan 2019 11:54:30 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2qasgb4n80-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 29 Jan 2019 11:54:30 -0500
Received: from localhost
	by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pmorel@linux.ibm.com>;
	Tue, 29 Jan 2019 16:54:28 -0000
Reply-To: pmorel@linux.ibm.com
References: <20190121134249.16615-1-david@redhat.com>
	<20190121134249.16615-2-david@redhat.com>
	<7f7d8582-b6d2-b120-c768-8cc8350b416c@linux.ibm.com>
	<86377327-ab6d-df3a-b914-688206273bd5@redhat.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Date: Tue, 29 Jan 2019 17:54:24 +0100
MIME-Version: 1.0
In-Reply-To: <86377327-ab6d-df3a-b914-688206273bd5@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <14055713-cd8e-7fc5-d819-3724838662a3@linux.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 1/2] s390x/pci: Introduce unplug
 requests and split unplug handler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Collin Walling <walling@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, Richard Henderson <rth@twiddle.net>

On 29/01/2019 16:14, David Hildenbrand wrote:
> On 29.01.19 14:31, Pierre Morel wrote:
>> On 21/01/2019 14:42, David Hildenbrand wrote:
>>> PCI on s390x is really weird and how it was modeled in QEMU might not=
 have
>>> been the right choice. Anyhow, right now it is the case that:
>>> - Hotplugging a PCI device will silently create a zPCI device
>>>     (if none is provided)
>>> - Hotunplugging a zPCI device will unplug the PCI device (if any)
>>> - Hotunplugging a PCI device will unplug also the zPCI device
>>> As far as I can see, we can no longer change this behavior. But we
>>> should fix it.


>> So unplugging PCI first will deny the guest any possibility to smoothl=
y
>> relinquish a device.
>>
>>
>> Is it possible the other way around?
>=20
> Maybe, but it does not really matter. We unplug both devices
> synchronously, without the guest recognizing the order. We always have
> the unplug request first that notifies the guest. When we get an ACK
> from the guest, we can unpplug both devices in any order.
>=20
> (and if we want to change the order, we should do it in a separate
> patch, this patch does not change the order, just refactors the code)


If it is done atomically, then I have no objection.

Regards,
Pierre



--=20
Pierre Morel
Linux/KVM/QEMU in B=C3=B6blingen - Germany
