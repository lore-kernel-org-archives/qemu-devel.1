Received: from eggs.gnu.org ([2001:4830:134:3::10]:36117)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1d85Wa-0002Fk-9J
	for qemu-devel@nongnu.org; Tue, 09 May 2017 09:50:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1d85WZ-0001Mg-FZ
	for qemu-devel@nongnu.org; Tue, 09 May 2017 09:50:00 -0400
References: <20170508233918.9043-1-f4bug@amsat.org>
	<20170508233918.9043-5-f4bug@amsat.org>
	<56387911-b587-adf0-c65b-ed12374d604d@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <80969f61-38d4-20ac-d850-5e90c8852b40@redhat.com>
Date: Tue, 9 May 2017 09:49:45 -0400
MIME-Version: 1.0
In-Reply-To: <56387911-b587-adf0-c65b-ed12374d604d@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 04/11] ide/ahci: add missing includes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org, qemu-block@nongnu.org



On 05/08/2017 07:58 PM, Eric Blake wrote:
> On 05/08/2017 06:39 PM, Philippe Mathieu-Daud=C3=A9 wrote:
>> qemu/include/hw/ide/ahci.h:260:16: error: field =E2=80=98sglist=E2=80=99=
 has incomplete type
>>      QEMUSGList sglist;
>>                 ^~~~~~
>=20
> What are you doing to get this compilation error (configure options,
> platform, compiler, etc)?  I can't reproduce it. Is it something that
> pops up later when you remove includes from somewhere else, and you're
> just pre-emptively adding includes here to allow removal of includes la=
ter?
>=20

"What he said," but if I had to guess, Philippe is testing that each
header can be compiled separately.

>> /qemu/include/hw/ide/ahci.h:272:5: error: unknown type name =E2=80=98I=
DEDMA=E2=80=99
>>      IDEDMA dma;
>>      ^~~~~~
>> qemu/include/hw/ide/ahci.h:273:5: error: unknown type name =E2=80=98ID=
EBus=E2=80=99
>>      IDEBus port;
>>      ^~~~~~
>> qemu/include/hw/ide/ahci.h:305:15: error: field =E2=80=98parent_obj=E2=
=80=99 has incomplete type
>>      PCIDevice parent_obj;
>>                ^~~~~~~~~~
>>
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>> ---
>>  include/hw/ide/ahci.h | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/include/hw/ide/ahci.h b/include/hw/ide/ahci.h
>> index 0ca7c65820..293f9ebcd0 100644
>> --- a/include/hw/ide/ahci.h
>> +++ b/include/hw/ide/ahci.h
>> @@ -25,6 +25,8 @@
>>  #define HW_IDE_AHCI_H
>> =20
>>  #include "hw/sysbus.h"
>> +#include "hw/ide/internal.h">> +#include "sysemu/dma.h"
>> =20
>>  #define AHCI_MEM_BAR_SIZE         0x1000
>>  #define AHCI_MAX_PORTS            32
>>
>=20
