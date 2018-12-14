Received: from eggs.gnu.org ([2001:4830:134:3::10]:39978)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1gXnTx-0008CQ-AJ
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 08:26:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1gXnTr-0004Lp-6o
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 08:26:19 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59610
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1gXnTq-0004La-HL
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 08:26:14 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	wBEDOmI1044831
	for <qemu-devel@nongnu.org>; Fri, 14 Dec 2018 08:26:13 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2pcd878f93-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 14 Dec 2018 08:26:13 -0500
Received: from localhost
	by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Fri, 14 Dec 2018 13:26:12 -0000
References: <1544792887-14575-1-git-send-email-thuth@redhat.com>
	<d068a183-1162-c720-e5f0-16f168f2b607@de.ibm.com>
	<9f8c3d48-7404-b645-06e6-f44eab13d0e1@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Fri, 14 Dec 2018 14:26:08 +0100
In-Reply-To: <9f8c3d48-7404-b645-06e6-f44eab13d0e1@redhat.com>
Content-Language: en-US
Message-Id: <098bd7bb-ec1b-93be-1dd6-52c4f8f33374@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: Quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH] hw/s390x: Fix bad mask in time2tod()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel@nongnu.org, Halil Pasic <pasic@linux.ibm.com>, David Hildenbrand <david@redhat.com>, qemu-stable@nongnu.org



On 14.12.2018 14:23, Thomas Huth wrote:
> On 2018-12-14 14:15, Christian Borntraeger wrote:
>>
>>
>> On 14.12.2018 14:08, Thomas Huth wrote:
>>> The time2tod() function tries to deal with the 9 uppermost bits in the
>>> time value, but uses the wrong mask for this: 0xff80000000000000 should
>>> be used instead of 0xff10000000000000 here.
>>>
>>> Fixes: 14055ce53c2d901d826ffad7fb7d6bb8ab46bdfd
>>
>> Can you alsways have commit id and subject
>>
>> like
>> Fixes: 14055ce53c2d ("s390x/tcg: avoid overflows in time2tod/tod2time")
>=20
> In https://wiki.qemu.org/Contribute/SubmitAPatch we currently have:
>=20
>  Fixes: <full-SHA-commit-id>


Interesting. Linus strongly opposed to only have the commit id as people of=
ten
do cut and paste errors so nobody could actually find out which commit was =
meant.
So the Linux variant is not sha commit of at least 12 digits + subject.

>=20
> ... and the full commit ID is sometimes very useful for downstream, so
> I'd rather avoid to abbreviate that here. But I can try to remember to
> put the title of the patch in another spot of the description, too.
>=20
>  Thomas
>=20
