Received: from eggs.gnu.org ([2001:4830:134:3::10]:60914)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <walling@linux.ibm.com>) id 1gXB5G-0003ZP-F8
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 15:26:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <walling@linux.ibm.com>) id 1gXB57-0007jm-Bi
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 15:26:14 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46426)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <walling@linux.ibm.com>)
	id 1gXB56-0007fl-QW
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 15:26:09 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	wBCKJI0t105638
	for <qemu-devel@nongnu.org>; Wed, 12 Dec 2018 15:26:06 -0500
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2pb7ahd4rc-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 12 Dec 2018 15:26:05 -0500
Received: from localhost
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <walling@linux.ibm.com>;
	Wed, 12 Dec 2018 20:26:05 -0000
References: <20181022090255.19671-1-zyimin@linux.ibm.com>
	<698a7fdd-47cc-cb3e-a280-3c4b656d92ef@redhat.com>
	<20181023232517.6b93085b.cohuck@redhat.com>
	<494ff50b-8b0f-1393-fbc5-bf5033a246ce@linux.ibm.com>
	<20181031114954.5e51d0c2.cohuck@redhat.com>
	<d8e0621a-d11e-a172-e40e-ec96dd92d5cd@linux.ibm.com>
	<20181130102708.5d6ca0e0.cohuck@redhat.com>
From: Collin Walling <walling@linux.ibm.com>
Date: Wed, 12 Dec 2018 15:25:57 -0500
MIME-Version: 1.0
In-Reply-To: <20181130102708.5d6ca0e0.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Message-Id: <a1d0ebac-346a-18e0-b05b-42d2b051cff4@linux.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] s390x/pci: add common fmb
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, Pierre Morel <pmorel@linux.ibm.com>
Cc: qemu-s390x@nongnu.org, borntraeger@de.ibm.com, Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Yi Min Zhao <zyimin@linux.ibm.com>

On 11/30/2018 04:27 AM, Cornelia Huck wrote:
> On Fri, 30 Nov 2018 10:23:14 +0100
> Pierre Morel <pmorel@linux.ibm.com> wrote:
>=20
>> On 31/10/2018 11:49, Cornelia Huck wrote:
>>> On Wed, 24 Oct 2018 11:58:33 +0800
>>> Yi Min Zhao <zyimin@linux.ibm.com> wrote:
>>>  =20
>>>> =E5=9C=A8 2018/10/24 =E4=B8=8A=E5=8D=885:25, Cornelia Huck =E5=86=99=
=E9=81=93: =20
>>>>> On Mon, 22 Oct 2018 13:17:34 +0100
>>>>> Thomas Huth <thuth@redhat.com> wrote:
>>>>>    =20
>>
>> ...snip...
>>
>>>> If endianness has error, I think the values must looks wrong.
>>>> The right thing is that values increase from 0 and intervally.
>>>> =20
>>>
>>> Thanks for pointing me to that file; when I run under tcg, the values
>>> indeed look like they have an endianness issue:
>>>
>>> Update interval: 4000 ms
>>> Samples: 637534208
>>> Last update TOD: f4c01d0098000000
>>>             Load operations:	10520408729537478656
>>>            Store operations:	5980780305148018688
>>>      Store block operations:	0
>>>          Refresh operations:	0
>>>             Allocated pages:	0
>>>                Mapped pages:	0
>>>              Unmapped pages:	0
>>>
>>> (virtio-net-pci device on a just-booted guest)
>>>  =20
>>
>> Hy Conny,
>>
>> I saw we lack a response to Thomas.
>> Otherwise have you any remark?
>=20
> I don't remember anything beyond the endianess issue.
>=20

This patch looks sane to me (I've lost the parent email on my
client, else I would've replied directly to that).

I'm currently awaiting getting my system up-and-running to test
this thoroughly. Shall we do one more round with the endianess=20
addressed in the mean time?

--=20
Respectfully,
- Collin Walling
