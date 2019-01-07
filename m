Received: from eggs.gnu.org ([209.51.188.92]:41437)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pmorel@linux.ibm.com>) id 1ggR7F-0006q4-IM
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 04:22:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pmorel@linux.ibm.com>) id 1ggR7E-0000NV-O6
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 04:22:37 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44862)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pmorel@linux.ibm.com>)
	id 1ggR7E-00083I-C2
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 04:22:36 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	x079Jebu011846
	for <qemu-devel@nongnu.org>; Mon, 7 Jan 2019 04:22:18 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2pv2y22rya-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 07 Jan 2019 04:22:17 -0500
Received: from localhost
	by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pmorel@linux.ibm.com>;
	Mon, 7 Jan 2019 09:22:15 -0000
Reply-To: pmorel@linux.ibm.com
References: <1546510620-6707-1-git-send-email-pmorel@linux.ibm.com>
	<1546510620-6707-2-git-send-email-pmorel@linux.ibm.com>
	<20190104153901.0bd2f703.cohuck@redhat.com>
	<206134f8-3f25-5078-e4f0-8a7814ce97d0@linux.ibm.com>
	<417f8d51-2a26-6e78-fe1a-1116b4e62b0b@redhat.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Date: Mon, 7 Jan 2019 10:22:10 +0100
MIME-Version: 1.0
In-Reply-To: <417f8d51-2a26-6e78-fe1a-1116b4e62b0b@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <903d2323-ccf8-3786-faa1-a8082410dfe2@linux.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6] s390x/pci: add common function
 measurement block
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>
Cc: walling@linux.ibm.com, borntraeger@de.ibm.com, rth@twiddle.net, david@redhat.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org, pasic@linux.ibm.com

On 07/01/2019 10:11, Thomas Huth wrote:
> On 2019-01-07 10:08, Pierre Morel wrote:
>> On 04/01/2019 15:39, Cornelia Huck wrote:
>>> On Thu,=C2=A0 3 Jan 2019 11:17:00 +0100
>>> Pierre Morel <pmorel@linux.ibm.com> wrote:
>>>
>>>> +static void fmb_update(void *opaque)
>>>> +{
>>>> +=C2=A0=C2=A0=C2=A0 S390PCIBusDevice *pbdev =3D opaque;
>>>> +=C2=A0=C2=A0=C2=A0 int64_t t =3D qemu_clock_get_ms(QEMU_CLOCK_VIRTU=
AL);
>>>> +=C2=A0=C2=A0=C2=A0 int i;
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 /* Update U bit */
>>>> +=C2=A0=C2=A0=C2=A0 pbdev->fmb.last_update *=3D 2;
>>>> +=C2=A0=C2=A0=C2=A0 pbdev->fmb.last_update |=3D UPDATE_U_BIT;
>>>> +=C2=A0=C2=A0=C2=A0 if (fmb_do_update(pbdev, offsetof(ZpciFmb, last_=
update),
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pbdev->fmb.last=
_update,
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sizeof(((ZpciFm=
b *)0)->last_update))) {
>>>
>>> I really don't want to be a pain, but... this looks weird. Why not
>>> simply sizeof(pbdev->fmb.last_update)?
>>
>> Isn't it preferable to use the size of the destination?
>=20
> But "(ZpciFmb *)0" in the context of QEMU isn't the destination either,
> it's an invalid pointer. So I think I agree with Cornelia,
> "sizeof(pbdev->fmb.last_update)" looks much easier to read and
> understand here.
>=20
>   Thomas
>=20
>=20

sizeof() returns the field length, the pointer value is not relevant.
But I will do as you wish if you both prefer to use this.
Anyway, this should be the same.

regards,
Pierre

--=20
Pierre Morel
Linux/KVM/QEMU in B=C3=B6blingen - Germany
