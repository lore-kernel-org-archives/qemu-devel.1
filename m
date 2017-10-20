Received: from eggs.gnu.org ([2001:4830:134:3::10]:51375)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1e5QpB-0000a3-PU
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 02:30:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1e5Qp8-0006pj-HL
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 02:30:29 -0400
Received: from 5.mo5.mail-out.ovh.net ([87.98.173.103]:35740)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1e5Qp8-0006nO-Aw
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 02:30:26 -0400
Received: from player786.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id C0E16145100
	for <qemu-devel@nongnu.org>; Fri, 20 Oct 2017 08:30:24 +0200 (CEST)
References: <20171019151249.13663-1-clg@kaod.org>
	<20171019151249.13663-2-clg@kaod.org>
	<CAFEAcA-6gXF9skgYRTke5-0Ds_SLceAgX-Dz6WyyuiYJSz7afw@mail.gmail.com>
	<114c397f-7540-15ca-a44d-0b3a4cdcc238@amsat.org>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <c8392d97-7823-7a00-648c-31a786957c26@kaod.org>
Date: Fri, 20 Oct 2017 08:30:17 +0200
MIME-Version: 1.0
In-Reply-To: <114c397f-7540-15ca-a44d-0b3a4cdcc238@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 1/8] aspeed: use a ROM memory region to
 catch invalid writes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Andrew Jeffery <andrew@aj.id.au>, Joel Stanley <joel@jms.id.au>

On 10/20/2017 05:10 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> On 10/19/2017 12:44 PM, Peter Maydell wrote:
>> On 19 October 2017 at 16:12, C=C3=A9dric Le Goater <clg@kaod.org> wrot=
e:
>>> Some legacy firmwares access unimplemented addresses on the Aspeed So=
C
>>> (old U-Boot code using variables in the bss when it shouldn't do).
>>> Let's use a ROM memory region to catch the invalid writes and support
>>> new boards without using the 'ignore_memory_transaction_failures'
>>> flag.
>>>
>>> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
>>> ---
>>>
>>>  Changes since v4 :
>>>
>>>  - use a ROM memory region
>>
>> Probably worth mentioning in the commit message that this
>> is a migration compatibility break for these boards.
>=20
> What about the eeprom_buf from patch 6 "Add EEPROM I2C devices"?
>=20
> My understanding is a migrated board would resume with a zeroized
> eeprom, is this the expected behaviour?

That would be probably the case. yes. As we don't populate the eeprom=20
with VPD at machine init time and that migration is clearly not tested,=20
I think we will address this issue later. =20

Thanks,

C. =20
