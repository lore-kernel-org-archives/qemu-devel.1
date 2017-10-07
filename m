Received: from eggs.gnu.org ([2001:4830:134:3::10]:41565)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1e0sAn-0006st-4x
	for qemu-devel@nongnu.org; Sat, 07 Oct 2017 12:41:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1e0sAk-0004CC-02
	for qemu-devel@nongnu.org; Sat, 07 Oct 2017 12:41:57 -0400
Received: from 1.mo177.mail-out.ovh.net ([178.33.107.143]:45686)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1e0sAj-0004BJ-QB
	for qemu-devel@nongnu.org; Sat, 07 Oct 2017 12:41:53 -0400
Received: from player779.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo177.mail-out.ovh.net (Postfix) with ESMTP id DE6C181C1C
	for <qemu-devel@nongnu.org>; Sat,  7 Oct 2017 18:41:50 +0200 (CEST)
References: <20170920070135.31379-1-clg@kaod.org>
	<20170920070135.31379-6-clg@kaod.org>
	<CAFEAcA-AnBaHadyHaOuS4648b3W3AXngMs9k9hCCDXyXBSLvTg@mail.gmail.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <2a6d818e-4306-1189-cddb-79cc2eea8499@kaod.org>
Date: Sat, 7 Oct 2017 18:41:42 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-AnBaHadyHaOuS4648b3W3AXngMs9k9hCCDXyXBSLvTg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 5/6] misc: add pca9552 LED blinker model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Andrew Jeffery <andrew@aj.id.au>, Joel Stanley <joel@jms.id.au>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>

On 10/06/2017 05:12 PM, Peter Maydell wrote:
> On 20 September 2017 at 08:01, C=C3=A9dric Le Goater <clg@kaod.org> wro=
te:
>> Specs are available here :
>>
>>   https://www.nxp.com/docs/en/data-sheet/PCA9552.pdf
>>
>> This is a simple model supporting the basic registers for led and GPIO
>> mode. The device also supports two blinking rates but not the model
>> yet.
>>
>> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
>=20
>=20
>> --- /dev/null
>> +++ b/include/hw/misc/pca9552.h
>> @@ -0,0 +1,32 @@
>> +/*
>> + * PCA9552 I2C LED blinker
>> + *
>> + * Copyright (c) 2017, IBM Corporation.
>> + *
>> + * This work is licensed under the terms of the GNU GPL, version 2 or
>> + * later. See the COPYING file in the top-level directory.
>> + */
>> +#ifndef PCA9552_H
>> +#define PCA9552_H
>> +
>> +#include "hw/i2c/i2c.h"
>> +
>> +#define TYPE_PCA9552 "pca9552"
>> +#define PCA9552(obj) OBJECT_CHECK(PCA9552State, (obj), TYPE_PCA9552)
>> +
>> +
>> +#define PCA9552_NR_REGS 10
>> +
>> +typedef struct PCA9552State {
>> +    /*< private >*/
>> +    I2CSlave i2c;
>> +    /*< public >*/
>> +
>> +    uint8_t len;
>> +    uint8_t pointer;
>> +    uint8_t buf[1]; /* just to remember how to handle a larger buffer=
 */
>=20
> Changing this later is going to be a migration compatibility break
> (or at least a bit painful to keep compat).
> Do we know how big the buffer is supposed to be?=20

one.=20

> If so it would be best to make it the correct size to start with.

yes I will change that.

Thanks,

C.

>=20
>> +
>> +    uint8_t regs[PCA9552_NR_REGS];
>> +} PCA9552State;
>=20
> thanks
> -- PMM
>=20
