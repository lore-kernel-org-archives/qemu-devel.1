Received: from eggs.gnu.org ([209.51.188.92]:42401)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gyt9Y-00070i-Gt
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 01:57:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gyt9X-0003cE-Ps
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 01:57:16 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20190226193408.23862-1-armbru@redhat.com>
	<20190226193408.23862-12-armbru@redhat.com>
	<alpine.BSF.2.21.9999.1902270206280.5023@zero.eik.bme.hu>
Date: Wed, 27 Feb 2019 07:57:10 +0100
In-Reply-To: <alpine.BSF.2.21.9999.1902270206280.5023@zero.eik.bme.hu>
	(BALATON Zoltan's message of "Wed, 27 Feb 2019 02:11:10 +0100 (CET)")
Message-ID: <87lg21oh15.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v2 11/11] pflash: Clean up after
 commit 368a354f02b part 2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: kwolf@redhat.com, qemu-block@nongnu.org, lersek@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com, qemu-ppc@nongnu.org, alex.bennee@linaro.org

BALATON Zoltan <balaton@eik.bme.hu> writes:

> On Tue, 26 Feb 2019, Markus Armbruster wrote:
>> QOMification left parameter @size unused in pflash_cfi01_register()
>> and pflash_cfi02_register().  Obviously, @size should match
>> @sector_len and @nb_blocs, i.e. size =3D=3D sector_len * nb_blocs.  All
>> callers satisfy this.
>>
>> Remove @nb_blocs and compute it from @size and @sector_len.
>>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> Reviewed-by: Laszlo Ersek <lersek@redhat.com>
>> Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> ---
[...]
>> diff --git a/hw/arm/gumstix.c b/hw/arm/gumstix.c
>> index 304dbeab2f..2e526218f4 100644
>> --- a/hw/arm/gumstix.c
>> +++ b/hw/arm/gumstix.c
>> @@ -74,7 +74,7 @@ static void connex_init(MachineState *machine)
>> #endif
>>     if (!pflash_cfi01_register(0x00000000, "connext.rom", connex_rom,
>>                                dinfo ? blk_by_legacy_dinfo(dinfo) : NULL,
>> -                               sector_len, connex_rom / sector_len,
>> +                               sector_len,
>>                                2, 0, 0, 0, 0, be)) {
>
> I'd say you could also reformat and join next line during this change
> to avoid short lines in the middle (also for all other similar changes
> below). But I have no strong feelings about that so I don't
> mind. (This might be easier to review the patch this way but the
> resulting code will look ugly.)

Will do, thanks!
