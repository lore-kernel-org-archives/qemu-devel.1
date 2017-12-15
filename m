Received: from eggs.gnu.org ([2001:4830:134:3::10]:37365)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1ePkF2-0004H6-Tz
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 02:17:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1ePkEy-0002El-Ur
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 02:17:08 -0500
Received: from 8.mo5.mail-out.ovh.net ([178.32.116.78]:57997)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1ePkEy-0002Cw-NU
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 02:17:04 -0500
Received: from player773.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id A5C5415C78B
	for <qemu-devel@nongnu.org>; Fri, 15 Dec 2017 08:17:02 +0100 (CET)
References: <20171215061739.9494-1-clg@kaod.org>
	<df01dd59-d118-0bc4-3c1e-21bdaa3e47b0@ozlabs.ru>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <40d07664-5f54-bd1c-f7f7-d11e7909e5a6@kaod.org>
Date: Fri, 15 Dec 2017 08:16:57 +0100
MIME-Version: 1.0
In-Reply-To: <df01dd59-d118-0bc4-3c1e-21bdaa3e47b0@ozlabs.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH] ppc/pnv: change powernv_ prefix
 to pnv_ for overall naming consistency
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

On 12/15/2017 07:43 AM, Alexey Kardashevskiy wrote:
> On 15/12/17 17:17, C=C3=A9dric Le Goater wrote:
>> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
>> ---
>>  hw/ppc/pnv.c         | 84 ++++++++++++++++++++++++++-----------------=
---------
>>  hw/ppc/pnv_core.c    |  8 ++---
>>  hw/ppc/pnv_lpc.c     |  2 +-
>>  include/hw/ppc/pnv.h |  8 ++---
>>  4 files changed, 51 insertions(+), 51 deletions(-)
>>
>> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
>> index c35c439d816b..4bc5f61d0da7 100644
>> --- a/hw/ppc/pnv.c
>> +++ b/hw/ppc/pnv.c
>> @@ -77,7 +77,7 @@ static const char *pnv_chip_core_typename(const PnvC=
hip *o)
>>   * that has a different "affinity". In practice, it means one range
>>   * per chip.
>>   */
>> -static void powernv_populate_memory_node(void *fdt, int chip_id, hwad=
dr start,
>> +static void pnv_populate_memory_node(void *fdt, int chip_id, hwaddr s=
tart,
>>                                           hwaddr size)
>=20
> You may also want to fix indentations like the line above.

yes. I missed that. I should run indent after using sed.

While I am at it, I can also change the name of the routines=20
populating the device tree.=20

David,=20

are you following more or less this pattern :

	<machine>_dt_<device>

Thanks,

C.
