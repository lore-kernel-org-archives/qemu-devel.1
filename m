Received: from eggs.gnu.org ([209.51.188.92]:37854)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ggQwt-00023U-6P
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 04:11:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ggQws-0007ND-H8
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 04:11:55 -0500
References: <1546510620-6707-1-git-send-email-pmorel@linux.ibm.com>
	<1546510620-6707-2-git-send-email-pmorel@linux.ibm.com>
	<20190104153901.0bd2f703.cohuck@redhat.com>
	<206134f8-3f25-5078-e4f0-8a7814ce97d0@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <417f8d51-2a26-6e78-fe1a-1116b4e62b0b@redhat.com>
Date: Mon, 7 Jan 2019 10:11:46 +0100
MIME-Version: 1.0
In-Reply-To: <206134f8-3f25-5078-e4f0-8a7814ce97d0@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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
To: pmorel@linux.ibm.com, Cornelia Huck <cohuck@redhat.com>
Cc: walling@linux.ibm.com, borntraeger@de.ibm.com, rth@twiddle.net, david@redhat.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org, pasic@linux.ibm.com

On 2019-01-07 10:08, Pierre Morel wrote:
> On 04/01/2019 15:39, Cornelia Huck wrote:
>> On Thu,=C2=A0 3 Jan 2019 11:17:00 +0100
>> Pierre Morel <pmorel@linux.ibm.com> wrote:
>>
>>> +static void fmb_update(void *opaque)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 S390PCIBusDevice *pbdev =3D opaque;
>>> +=C2=A0=C2=A0=C2=A0 int64_t t =3D qemu_clock_get_ms(QEMU_CLOCK_VIRTUA=
L);
>>> +=C2=A0=C2=A0=C2=A0 int i;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 /* Update U bit */
>>> +=C2=A0=C2=A0=C2=A0 pbdev->fmb.last_update *=3D 2;
>>> +=C2=A0=C2=A0=C2=A0 pbdev->fmb.last_update |=3D UPDATE_U_BIT;
>>> +=C2=A0=C2=A0=C2=A0 if (fmb_do_update(pbdev, offsetof(ZpciFmb, last_u=
pdate),
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pbdev->fmb.last=
_update,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sizeof(((ZpciFm=
b *)0)->last_update))) {
>>
>> I really don't want to be a pain, but... this looks weird. Why not
>> simply sizeof(pbdev->fmb.last_update)?
>=20
> Isn't it preferable to use the size of the destination?

But "(ZpciFmb *)0" in the context of QEMU isn't the destination either,
it's an invalid pointer. So I think I agree with Cornelia,
"sizeof(pbdev->fmb.last_update)" looks much easier to read and
understand here.

 Thomas
