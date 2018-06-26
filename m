Received: from eggs.gnu.org ([2001:4830:134:3::10]:33549)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mail@steffen-goertz.de>) id 1fXjrc-00070i-Pt
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 05:02:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mail@steffen-goertz.de>) id 1fXjrT-0001kN-D0
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 05:02:16 -0400
Received: from steffen-goertz.de ([88.198.119.201]:50992)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mail@steffen-goertz.de>) id 1fXjrT-0001jZ-5f
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 05:02:07 -0400
References: <20180626081743.22097-1-contrib@steffen-goertz.de>
	<ebb85873-2440-5047-73a1-81c793a39f6d@redhat.com>
From: =?UTF-8?Q?Steffen_G=c3=b6rtz?= <mail@steffen-goertz.de>
Message-ID: <9a57463e-8165-1fb7-0516-3451ff131e2d@steffen-goertz.de>
Date: Tue, 26 Jun 2018 11:02:01 +0200
MIME-Version: 1.0
In-Reply-To: <ebb85873-2440-5047-73a1-81c793a39f6d@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC] arm: Add NRF51 SOC non-volatile memory
 controller
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Jim Mussared <jim@groklearning.com>, Julia Suvorova <jusual@mail.ru>, Joel Stanley <joel@jms.id.au>

Hi Thomas,

On 26.06.2018 10:45, Thomas Huth wrote:
> On 26.06.2018 10:17, Steffen G=C3=B6rtz wrote:
> [...]
>> +static const MemoryRegionOps io_ops =3D { .read =3D io_read, .write =3D=
 io_write,
>> +        .endianness =3D DEVICE_LITTLE_ENDIAN, };
>=20
> Could you please put the entries on a separate line each? That would be
> better readable.
done
>=20
>> +static void nrf51_nvmc_init(Object *obj)
>> +{
>> +    Nrf51NVMCState *s =3D NRF51_NVMC(obj);
>> +    SysBusDevice *sbd =3D SYS_BUS_DEVICE(obj);
>> +
>> +    memory_region_init_io(&s->mmio, obj, &io_ops, s,
>> +    TYPE_NRF51_NVMC, NRF51_NVMC_SIZE);
> Please indent the second line of the memory_region_init_io statement.
done
>=20
>> +    sysbus_init_mmio(sbd, &s->mmio);

>> +#include "hw/sysbus.h"
>> +#include "qemu/timer.h"
>=20
> Any reason for including timer.h here? If not, please drop that line.

No it was a left over, removed.

Best regards,
Steffen
