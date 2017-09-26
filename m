Received: from eggs.gnu.org ([2001:4830:134:3::10]:39108)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fiuczy@linux.vnet.ibm.com>) id 1dwpXV-0003ZF-77
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 09:04:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fiuczy@linux.vnet.ibm.com>) id 1dwpXQ-0006ZX-6R
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 09:04:41 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55184
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <fiuczy@linux.vnet.ibm.com>)
	id 1dwpXQ-0006Y4-0P
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 09:04:36 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v8QCxOuL098922
	for <qemu-devel@nongnu.org>; Tue, 26 Sep 2017 09:04:30 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2d7puvjp5p-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 26 Sep 2017 09:04:29 -0400
Received: from localhost
	by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <fiuczy@linux.vnet.ibm.com>;
	Tue, 26 Sep 2017 14:04:27 +0100
References: <20170922083855.102341-1-borntraeger@de.ibm.com>
	<20170922083855.102341-3-borntraeger@de.ibm.com>
	<5e7ba7d5-82d4-f1e6-532a-37c2c445c227@linux.vnet.ibm.com>
	<ccb6e3eb-320e-b5dd-f728-09d8cab440c4@de.ibm.com>
	<eee7e600-a8b0-6e23-580b-803f3b4e9efa@linux.vnet.ibm.com>
	<4a31c53b-98aa-747a-1402-1a93e74c565b@de.ibm.com>
	<5cdfe359-2e78-7e2a-72c2-d3e69574288e@linux.vnet.ibm.com>
	<20170925120745.7326637e.cohuck@redhat.com>
	<20da1950-3aa5-c29f-3d54-4f82289f34f1@de.ibm.com>
	<20170925134532.08e9e273.cohuck@redhat.com>
	<4cbc3c5b-3050-2e4e-f4cd-0c92fdb8e11f@de.ibm.com>
	<c2f8bd1a-7d6e-1443-e180-fc90b68c4557@linux.vnet.ibm.com>
From: Boris Fiuczynski <fiuczy@linux.vnet.ibm.com>
Date: Tue, 26 Sep 2017 15:04:23 +0200
MIME-Version: 1.0
In-Reply-To: <c2f8bd1a-7d6e-1443-e180-fc90b68c4557@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <d38dcac4-df9d-eb8e-e437-cb604f1a2da1@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH/RFC 2/3] s390x/ais: enable ais when
 migration is available
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yi Min Zhao <zyimin@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: Halil Pasic <pasic@linux.vnet.ibm.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, David Hildenbrand <david@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Alexander Graf <agraf@suse.de>, "Jason J . Herne" <jjherne@linux.vnet.ibm.com>, Richard Henderson <rth@twiddle.net>

On 09/26/2017 11:14 AM, Yi Min Zhao wrote:
>=20
>=20
> =E5=9C=A8 2017/9/25 =E4=B8=8B=E5=8D=887:47, Christian Borntraeger =E5=86=
=99=E9=81=93:
>> On 09/25/2017 01:45 PM, Cornelia Huck wrote:
>>> On Mon, 25 Sep 2017 12:12:49 +0200
>>> Christian Borntraeger <borntraeger@de.ibm.com> wrote:
>>>
>>>> On 09/25/2017 12:07 PM, Cornelia Huck wrote:
>>>>> On Fri, 22 Sep 2017 16:27:00 +0200
>>>>> Halil Pasic <pasic@linux.vnet.ibm.com> wrote:
>>>>>> One thing I would find very helpful is what do we expect to work=20
>>>>>> and not
>>>>>> work for which version. Kind of a matrix. For instance should vfio=
=20
>>>>>> pci
>>>>>> work for versions prior 2.11. I think in the not so distant past w=
e
>>>>>> changed how SIC works (so it complains when we don't have ais).
>>>>> A matrix sounds like a good idea.
>>>> I think we do not even need a matrix, a minimum level will suffice=20
>>>> because...
>>>>> I don't think we really ever had a setup that worked out of the box
>>>> exactly: ...it never worked until 2.10 and we do not have libvirt=20
>>>> support yet.
>>>> Now with the fix 2.10 will also not work, so I think its fair to say
>>>>
>>>> PCI passthrough via VFIO will be supported for
>>>> - KVM: host kernel >=3D 4.13
>>>> - TCG: TBD
>>>> - QEMU >=3D 2.11
>>>> - libvirt TBD
>>> Make that zpci-per-se, no?
>>>
>>> with KVM: host kernel >=3D 4.13 && QEMU >=3D 2.11
>>> with TCG: tbd, I don't think anybody has time to wire this up for 2.1=
1
>>>
>>> Apropos libvirt: How will it determine whether zpci should be
>>> supported? There are some old QEMU + KVM combinations out there that
>>> will have a phb (but not be usable by stock Linux guests as the featu=
re
>>> bits are missing). Version fence? Check for cpu feature support?
>> I think for multibus or something like that Boris wanted to check for=20
>> a version
>> anyway. So maybe 2.11 (now that 2.10 is broken regarding ais) as a=20
>> minimum QEMU
>> level would make sense.
>>
>>
> I think this makes sense. But I think I have to discuss this with Boris.
In libvirt multibus is one of the few (very old) supports that would=20
allow checking against a qemu version.
Detection of zpci support is another matter since that capability is=20
tied to the existence of the zpci object in qom. Tying the zpci=20
capability to the multibus support has its pro and cons. I have not made=20
up my mind yet.


--=20
Mit freundlichen Gr=C3=BC=C3=9Fen/Kind regards
    Boris Fiuczynski

IBM Deutschland Research & Development GmbH
Vorsitzender des Aufsichtsrats: Martina K=C3=B6deritz
Gesch=C3=A4ftsf=C3=BChrung: Dirk Wittkopp
Sitz der Gesellschaft: B=C3=B6blingen
Registergericht: Amtsgericht Stuttgart, HRB 243294
