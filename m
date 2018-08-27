Received: from eggs.gnu.org ([2001:4830:134:3::10]:52113)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fuAuX-0004yK-Di
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 02:22:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fuAuU-0004JW-6H
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 02:22:01 -0400
References: <20180821043343.7514-1-david@gibson.dropbear.id.au>
	<20180821043343.7514-26-david@gibson.dropbear.id.au>
	<CAFEAcA8k7u6HoAuS3v-FUzDA37-1a9Sy=QrqXvJVEKjRtCWsAA@mail.gmail.com>
	<7a3389a5-ffc5-58d9-659d-fbc46e88ca24@kaod.org>
	<20180824173839.03f8c29b@bahia.lan>
	<7e4d61cc-1da4-ecb8-8dd3-f3e51b20861a@kaod.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <e47d2b72-cc32-cbee-3662-0aedea03024f@redhat.com>
Date: Mon, 27 Aug 2018 08:21:48 +0200
MIME-Version: 1.0
In-Reply-To: <7e4d61cc-1da4-ecb8-8dd3-f3e51b20861a@kaod.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-ppc] [PULL 25/26] spapr_pci: factorize the
 use of SPAPR_MACHINE_GET_CLASS()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, Greg Kurz <groug@kaod.org>
Cc: Laurent Vivier <lvivier@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, qemu-ppc <qemu-ppc@nongnu.org>, David Gibson <david@gibson.dropbear.id.au>

On 2018-08-24 18:43, C=C3=A9dric Le Goater wrote:
> On 08/24/2018 05:38 PM, Greg Kurz wrote:
>> On Fri, 24 Aug 2018 17:30:12 +0200
>> C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>>
>>> On 08/24/2018 05:09 PM, Peter Maydell wrote:
>>>> On 21 August 2018 at 05:33, David Gibson <david@gibson.dropbear.id.a=
u> wrote: =20
>>>>> From: C=C3=A9dric Le Goater <clg@kaod.org>
[...]
>>> Is there a way to specify which device type can or can not be=20
>>> plugged on a machine ?=20
>>>
>>> I suppose we cannot use :=20
>>>
>>> 	machine_class_allow_dynamic_sysbus_dev()=20
>>>
>>> for cold plugged devices. Or can we ? That would be better.
>>>
>>
>> Hmm... not sure this would help. The root problem is that many
>> places in spapr_pci and spapr_cpu_core assume the machine is
>> sPAPR.
>=20
> which is a perfectly legitimate assumption for a sPAPR only device,
> same for spapr_cpu_core. I would think. Shouldn't we enforce=20
> the restriction at the machine level instead and not at the device
> level ?=20
>=20
> I thought that was the purpose of commit 0bd1909da606 ("machine:=20
> Replace has_dynamic_sysbus with list of allowed devices"), to=20
> make sure machines had a predefined list of user-creatable devices.

The "spapr-pci-host-bridge" is explicitly marked with
"dc->user_creatable =3D true" - so it is creatable everywhere. You could
try whether it is possible to make it only creatable via the white list
instead ... not sure whether that works though, since there is a class
hierarchy (TYPE_PCI_HOST_BRIDGE) in between?

 Thomas
