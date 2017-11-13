Received: from eggs.gnu.org ([2001:4830:134:3::10]:57176)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pmorel@linux.vnet.ibm.com>) id 1eEFun-0001r0-B7
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 09:40:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pmorel@linux.vnet.ibm.com>) id 1eEFuk-0001x5-3z
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 09:40:45 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39632
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pmorel@linux.vnet.ibm.com>)
	id 1eEFuj-0001wz-Up
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 09:40:42 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vADEe57g144222
	for <qemu-devel@nongnu.org>; Mon, 13 Nov 2017 09:40:37 -0500
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2e7dbbr36f-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 13 Nov 2017 09:40:36 -0500
Received: from localhost
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pmorel@linux.vnet.ibm.com>;
	Mon, 13 Nov 2017 14:40:35 -0000
References: <1510075479-17224-1-git-send-email-pmorel@linux.vnet.ibm.com>
	<1510075479-17224-3-git-send-email-pmorel@linux.vnet.ibm.com>
	<20171109175018.1c2f1b60.cohuck@redhat.com>
	<b1d8f3bf-b04c-1270-6ed0-ef5dfe7940d5@linux.vnet.ibm.com>
	<20171113124843.7a7c0d42.cohuck@redhat.com>
From: Pierre Morel <pmorel@linux.vnet.ibm.com>
Date: Mon, 13 Nov 2017 15:40:32 +0100
MIME-Version: 1.0
In-Reply-To: <20171113124843.7a7c0d42.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <9d0e9891-e985-5958-40a5-1f413b0cba2d@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/7] s390x/pci: rework PCI STORE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: borntraeger@de.ibm.com, pasic@linux.vnet.ibm.com, zyimin@linux.vnet.ibm.com, qemu-devel@nongnu.org, agraf@suse.de

On 13/11/2017 12:48, Cornelia Huck wrote:
> On Mon, 13 Nov 2017 10:03:37 +0100
> Pierre Morel <pmorel@linux.vnet.ibm.com> wrote:
>=20
>> On 09/11/2017 17:50, Cornelia Huck wrote:
>>> On Tue,  7 Nov 2017 18:24:34 +0100
>>> Pierre Morel <pmorel@linux.vnet.ibm.com> wrote:
>=20
>>>> +    case PCI_ROM_SLOT:
>>>
>>> So, will this be filled in a later patch? (Reading from the top.)
>>
>> No it will not it is only a reminder that we explicitly do not support=
 it.
>> Since I do not know if we ever will support it do you think I better l=
et
>> it fall?
>=20
> Either add a comment, or drop it. Otherwise I will ask again in the
> future :)
>=20

OK Ill do the easier, just suppress it and its brother in PCI LOAD. :)

--=20
Pierre Morel
Linux/KVM/QEMU in B=C3=B6blingen - Germany
