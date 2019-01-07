Received: from eggs.gnu.org ([209.51.188.92]:37111)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pmorel@linux.ibm.com>) id 1ggQu7-0000j6-Iu
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 04:09:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pmorel@linux.ibm.com>) id 1ggQu4-00058H-CR
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 04:09:03 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44080)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pmorel@linux.ibm.com>)
	id 1ggQu4-00057z-1Y
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 04:09:00 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	x0794DjN043953
	for <qemu-devel@nongnu.org>; Mon, 7 Jan 2019 04:08:57 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2pv2y22abw-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 07 Jan 2019 04:08:57 -0500
Received: from localhost
	by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pmorel@linux.ibm.com>;
	Mon, 7 Jan 2019 09:08:54 -0000
Reply-To: pmorel@linux.ibm.com
References: <1546510620-6707-1-git-send-email-pmorel@linux.ibm.com>
	<1546510620-6707-2-git-send-email-pmorel@linux.ibm.com>
	<20190104153901.0bd2f703.cohuck@redhat.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Date: Mon, 7 Jan 2019 10:08:51 +0100
MIME-Version: 1.0
In-Reply-To: <20190104153901.0bd2f703.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <206134f8-3f25-5078-e4f0-8a7814ce97d0@linux.ibm.com>
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
To: Cornelia Huck <cohuck@redhat.com>
Cc: walling@linux.ibm.com, borntraeger@de.ibm.com, rth@twiddle.net, david@redhat.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org, pasic@linux.ibm.com, thuth@redhat.com

On 04/01/2019 15:39, Cornelia Huck wrote:
> On Thu,  3 Jan 2019 11:17:00 +0100
> Pierre Morel <pmorel@linux.ibm.com> wrote:
>=20
>> +static void fmb_update(void *opaque)
>> +{
>> +    S390PCIBusDevice *pbdev =3D opaque;
>> +    int64_t t =3D qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL);
>> +    int i;
>> +
>> +    /* Update U bit */
>> +    pbdev->fmb.last_update *=3D 2;
>> +    pbdev->fmb.last_update |=3D UPDATE_U_BIT;
>> +    if (fmb_do_update(pbdev, offsetof(ZpciFmb, last_update),
>> +                      pbdev->fmb.last_update,
>> +                      sizeof(((ZpciFmb *)0)->last_update))) {
>=20
> I really don't want to be a pain, but... this looks weird. Why not
> simply sizeof(pbdev->fmb.last_update)?

Isn't it preferable to use the size of the destination?

Regards,
Pierre

--=20
Pierre Morel
Linux/KVM/QEMU in B=C3=B6blingen - Germany
