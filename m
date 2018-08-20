Received: from eggs.gnu.org ([2001:4830:134:3::10]:38794)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1frg1n-0007di-My
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 04:59:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1frg1k-0002sG-Ft
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 04:59:11 -0400
Received: from mel.act-europe.fr ([2a02:2ab8:224:1::a0a:d2]:42643
	helo=smtp.eu.adacore.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <frederic.konrad@adacore.com>)
	id 1frg1k-0002rn-5q
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 04:59:08 -0400
References: <20180817114619.22354-1-peter.maydell@linaro.org>
	<20180817114619.22354-2-peter.maydell@linaro.org>
	<a5a2a7d6-8a20-f666-22b1-7e793d68d690@adacore.com>
	<CAFEAcA-M8GaupAjnt8SzEJTy8uhtxKZQvhmqoa8fcG1+KHPJfA@mail.gmail.com>
From: KONRAD Frederic <frederic.konrad@adacore.com>
Message-ID: <005c973f-0f4b-6de3-8786-e618b28798df@adacore.com>
Date: Mon, 20 Aug 2018 10:59:02 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-M8GaupAjnt8SzEJTy8uhtxKZQvhmqoa8fcG1+KHPJfA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/3] hw/ssi/xilinx_spips: Remove unneeded
 MMIO request_ptr code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Alistair Francis <alistair@alistair23.me>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>



Le 08/20/2018 =C3=A0 10:53 AM, Peter Maydell a =C3=A9crit=C2=A0:
> On 20 August 2018 at 09:49, KONRAD Frederic <frederic.konrad@adacore.co=
m> wrote:
>>
>>
>> Le 08/17/2018 =C3=A0 01:46 PM, Peter Maydell a =C3=A9crit :
>>>
>>> We now support direct execution from MMIO regions in the
>>> core memory subsystem. This means that we don't need to
>>> have device-specific support for it, and we can remove
>>> the request_ptr handling from the Xilinx SPIPS device.
>>> (It was broken anyway due to race conditions, and disabled
>>> by default.)
>>>
>>> This device is the only in-tree user of this API.
>>>
>>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>>> ---
>>>    hw/ssi/xilinx_spips.c | 46 ---------------------------------------=
----
>>>    1 file changed, 46 deletions(-)
>>>
>>> diff --git a/hw/ssi/xilinx_spips.c b/hw/ssi/xilinx_spips.c
>>> index c052bfc4b3c..16f88f74029 100644
>>> --- a/hw/ssi/xilinx_spips.c
>>> +++ b/hw/ssi/xilinx_spips.c
>>> @@ -1031,14 +1031,6 @@ static const MemoryRegionOps spips_ops =3D {
>>>      static void xilinx_qspips_invalidate_mmio_ptr(XilinxQSPIPS *q)
>>
>>
>> I'd drop this function and replace the calls by
>> q->lqspi_cached_addr =3D ~0ULL;
>=20
> I thought about that but decided it was reasonable to keep
> the function, because it matches with having a
> lqspi_load_cache() function still.
>=20

Right ok.

Thanks,
Fred

> thanks
> -- PMM
>=20
