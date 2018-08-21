Received: from eggs.gnu.org ([2001:4830:134:3::10]:32918)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fs7zK-0004HD-9S
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 10:50:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fs7zI-0003TF-It
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 10:50:30 -0400
Received: from mail-oi0-x22d.google.com ([2607:f8b0:4003:c06::22d]:33611)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fs7zC-0003N3-Lo
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 10:50:25 -0400
Received: by mail-oi0-x22d.google.com with SMTP id 8-v6so32531520oip.0
	for <qemu-devel@nongnu.org>; Tue, 21 Aug 2018 07:50:22 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <6c13fca2-6f16-adb0-1072-7601abefd18d@steffen-goertz.de>
References: <20180811090836.4024-1-contrib@steffen-goertz.de>
	<20180811090836.4024-7-contrib@steffen-goertz.de>
	<CAFEAcA_=8r_X_rLfwJovEkusBb6hmaG5Ns8YQxQMLL4z0KpHXw@mail.gmail.com>
	<6c13fca2-6f16-adb0-1072-7601abefd18d@steffen-goertz.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 21 Aug 2018 15:50:01 +0100
Message-ID: <CAFEAcA91fZpidh1XefoB3v1monJBQFhdZAKVUpMvw6Pw6+fMiQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 6/7] arm: Instantiate nRF51 peripherals
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Steffen_G=C3=B6rtz?= <mail@steffen-goertz.de>
Cc: =?UTF-8?Q?Steffen_G=C3=B6rtz?= <contrib@steffen-goertz.de>, QEMU Developers <qemu-devel@nongnu.org>, Joel Stanley <joel@jms.id.au>, Stefan Hajnoczi <stefanha@gmail.com>, qemu-arm <qemu-arm@nongnu.org>, Jim Mussared <jim@groklearning.com>, Julia Suvorova <jusual@mail.ru>

On 21 August 2018 at 12:43, Steffen G=C3=B6rtz <mail@steffen-goertz.de> wro=
te:
> Hi Peter,
>>> +
>>> +static uint64_t clock_read(void *opaque, hwaddr addr, unsigned int siz=
e)
>>> +{
>>> +    qemu_log_mask(LOG_UNIMP, "%s: 0x%" HWADDR_PRIx " [%u]\n",
>>> +                  __func__, addr, size);
>>> +    return 1;
>>> +}
>>> +
>>> +static void clock_write(void *opaque, hwaddr addr, uint64_t data,
>>> +                        unsigned int size)
>>> +{
>>> +    qemu_log_mask(LOG_UNIMP, "%s: 0x%" HWADDR_PRIx " <- 0x%" PRIx64 " =
[%u]\n",
>>> +                  __func__, addr, data, size);
>>> +}
>>> +
>>> +static const MemoryRegionOps clock_ops =3D {
>>> +    .read =3D clock_read,
>>> +    .write =3D clock_write
>>> +};
>>
>> You don't need to roll your own "do nothing but log" device:
>> you can use the TYPE_UNIMPLEMENTED_DEVICE to do this.
>>
> Until we have a more proper STUB for POWER/CLOCK/MPU peripherals we actua=
lly need this,
> because the unimplemented device will return 0 on reads which will cause =
guest code to stall.

Oh, I see. I hadn't noticed that it was doing read-as-all-ones.

thanks
-- PMM
