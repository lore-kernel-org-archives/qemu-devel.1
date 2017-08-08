Received: from eggs.gnu.org ([2001:4830:134:3::10]:44289)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dfArl-0005I9-By
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 16:12:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dfArk-0001rG-4W
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 16:12:37 -0400
References: <20170808183306.27474-1-jsnow@redhat.com>
	<20170808183306.27474-2-jsnow@redhat.com>
	<c0250626-4c3a-fa61-a749-387fbabd6934@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <84ef3be1-b018-90df-c360-635a6bd9f537@redhat.com>
Date: Tue, 8 Aug 2017 16:12:25 -0400
MIME-Version: 1.0
In-Reply-To: <c0250626-4c3a-fa61-a749-387fbabd6934@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/9] IDE: replace DEBUG_IDE with tracing
 system
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org



On 08/08/2017 04:00 PM, Eric Blake wrote:
> On 08/08/2017 01:32 PM, John Snow wrote:
>> Out with the old, in with the new.
>>
>> Signed-off-by: John Snow <jsnow@redhat.com>
>> ---
>=20
>>  hw/ide/piix.c             | 11 ++++----
>>  hw/ide/trace-events       | 33 ++++++++++++++++++++++++
>>  hw/ide/via.c              | 10 +++-----
>=20
> Hmm - should we tweak scripts/git.orderfile to prioritize trace-events
> over .c files? Then again, right now it prioritizes all .c files before
> anything that didn't match, so that things like trace-events will at
> least avoid falling in the middle of a patch if you use the project's
> orderfile.
>=20

Sorry!

>> +++ b/hw/ide/cmd646.c
>> @@ -32,6 +32,7 @@
>>  #include "sysemu/dma.h"
>> =20
>>  #include "hw/ide/pci.h"
>> +#include "trace.h"
>> =20
>>  /* CMD646 specific */
>>  #define CFR		0x50
>> @@ -195,9 +196,8 @@ static uint64_t bmdma_read(void *opaque, hwaddr ad=
dr,
>>          val =3D 0xff;
>>          break;
>>      }
>> -#ifdef DEBUG_IDE
>> -    printf("bmdma: readb " TARGET_FMT_plx " : 0x%02x\n", addr, val);
>> -#endif
>=20
> Yay for killing code prone to bitrot.
>=20

Yup, seeya later.

>> +++ b/hw/ide/core.c
>=20
>> @@ -2054,18 +2044,18 @@ void ide_exec_cmd(IDEBus *bus, uint32_t val)
>>      }
>=20
>>      hob =3D 0;
>> -    switch(addr) {
>> +    switch(reg_num) {
>=20
> Worth fixing the style to put space after switch while touching this?
>=20

Yes.

>> +++ b/hw/ide/trace-events
>> @@ -0,0 +1,33 @@
>> +# See docs/devel/tracing.txt for syntax documentation.
>> +
>> +# hw/ide/core.c
>=20
>> +
>> +# hw/ide/pci.c
>> +bmdma_reset(void) ""
>=20
> An empty trace? Do all the backends support it?
>=20

Oh, I don't know... I guess I can just repeat the function name in here,
or add something arbitrary.

>> +# hw/ide/cmd646.c
>=20
> Worth sorting the sections by filename?
>=20

Oh, you mean alphabetically?

I'd like to keep the BMDMA HBA tracers near each other, but otherwise I
can, yes.

> Whether or not you tweak based on my nits,
>=20
> Reviewed-by: Eric Blake <eblake@redhat.com>
>=20

There's likely to be many nits, so I'll accept all the critique.

John
