Received: from eggs.gnu.org ([2001:4830:134:3::10]:57755)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1cyOho-0003T1-9q
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 16:17:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1cyOhj-0007GH-Ci
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 16:17:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39362)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1cyOhj-0007FK-74
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 16:17:27 -0400
References: <1488435591-17882-1-git-send-email-mst@redhat.com>
	<1488435591-17882-3-git-send-email-mst@redhat.com>
	<CAJ+F1C+kLB5VCsSakbd6+CKx4uNbxZNqd+vNMAWte4yKqcbw9Q@mail.gmail.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <83ab7c00-5d71-d3fc-741b-2a7abbb6f63a@redhat.com>
Date: Wed, 12 Apr 2017 22:17:19 +0200
MIME-Version: 1.0
In-Reply-To: <CAJ+F1C+kLB5VCsSakbd6+CKx4uNbxZNqd+vNMAWte4yKqcbw9Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 02/15] docs: VM Generation ID device
 description
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Cc: Gal Hammer <ghammer@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Ben Warren <ben@skyportsystems.com>, Igor Mammedov <imammedo@redhat.com>

On 04/12/17 22:06, Marc-Andr=C3=A9 Lureau wrote:
> On Thu, Mar 2, 2017 at 10:22 AM Michael S. Tsirkin <mst@redhat.com> wro=
te:

>> +Device Usage:
>> +-------------
>> +
>> +The device has one property, which may be only be set using the comma=
nd
>> line:
>> +
>> +  guid - sets the value of the GUID.  A special value "auto" instruct=
s
>> +         QEMU to generate a new random GUID.
>> +
>> +For example:
>> +
>> +  QEMU  -device vmgenid,guid=3D"324e6eaf-d1d1-4bf6-bf41-b9bb6c91fb87"
>> +  QEMU  -device vmgenid,guid=3Dauto
>>
>=20
> The default will keep uuid to null, should it be documented? Wouldn't i=
t
> make sense to default to auto?

I guess it might.

>=20
>=20
>> +The property may be queried via QMP/HMP:
>> +
>> +  (QEMU) query-vm-generation-id
>> +  {"return": {"guid": "324e6eaf-d1d1-4bf6-bf41-b9bb6c91fb87"}}
>> +
>> +Setting of this parameter is intentionally left out from the QMP/HMP
>> +interfaces.  There are no known use cases for changing the GUID once =
QEMU
>> is
>> +running, and adding this capability would greatly increase the comple=
xity.
>>
>=20
> Is this supposed to be not permitted?
>=20
> { "execute": "qom-set", "arguments": { "path":
> "/machine/peripheral-anon/device[1]", "property": "guid", "value": "aut=
o" }
> }

I don't know if qom-set can be disabled for individual devices / device
properties. Either way, setting a new GUID for VMGENID will definitely
take custom code.

> Is there any linux kernel support being worked on?

There's an RHBZ for it (alias "vmgenid-kernel"):

https://bugzilla.redhat.com/show_bug.cgi?id=3D1159983

(It is private because RHBZs for the kernel component are private by
default.)

Thanks
Laszlo
