Received: from eggs.gnu.org ([2001:4830:134:3::10]:37273)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1frfwb-0005ov-Ci
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 04:53:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1frfwa-0008Um-NG
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 04:53:49 -0400
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:36164)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1frfwa-0008UA-IN
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 04:53:48 -0400
Received: by mail-oi0-x244.google.com with SMTP id n21-v6so24514712oig.3
	for <qemu-devel@nongnu.org>; Mon, 20 Aug 2018 01:53:48 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <a5a2a7d6-8a20-f666-22b1-7e793d68d690@adacore.com>
References: <20180817114619.22354-1-peter.maydell@linaro.org>
	<20180817114619.22354-2-peter.maydell@linaro.org>
	<a5a2a7d6-8a20-f666-22b1-7e793d68d690@adacore.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 Aug 2018 09:53:26 +0100
Message-ID: <CAFEAcA-M8GaupAjnt8SzEJTy8uhtxKZQvhmqoa8fcG1+KHPJfA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: KONRAD Frederic <frederic.konrad@adacore.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Alistair Francis <alistair@alistair23.me>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>

On 20 August 2018 at 09:49, KONRAD Frederic <frederic.konrad@adacore.com> w=
rote:
>
>
> Le 08/17/2018 =C3=A0 01:46 PM, Peter Maydell a =C3=A9crit :
>>
>> We now support direct execution from MMIO regions in the
>> core memory subsystem. This means that we don't need to
>> have device-specific support for it, and we can remove
>> the request_ptr handling from the Xilinx SPIPS device.
>> (It was broken anyway due to race conditions, and disabled
>> by default.)
>>
>> This device is the only in-tree user of this API.
>>
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>> ---
>>   hw/ssi/xilinx_spips.c | 46 -------------------------------------------
>>   1 file changed, 46 deletions(-)
>>
>> diff --git a/hw/ssi/xilinx_spips.c b/hw/ssi/xilinx_spips.c
>> index c052bfc4b3c..16f88f74029 100644
>> --- a/hw/ssi/xilinx_spips.c
>> +++ b/hw/ssi/xilinx_spips.c
>> @@ -1031,14 +1031,6 @@ static const MemoryRegionOps spips_ops =3D {
>>     static void xilinx_qspips_invalidate_mmio_ptr(XilinxQSPIPS *q)
>
>
> I'd drop this function and replace the calls by
> q->lqspi_cached_addr =3D ~0ULL;

I thought about that but decided it was reasonable to keep
the function, because it matches with having a
lqspi_load_cache() function still.

thanks
-- PMM
