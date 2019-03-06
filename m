Received: from eggs.gnu.org ([209.51.188.92]:43781)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1h1XM0-0007Tc-LK
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 09:17:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1h1XLz-0003CD-W6
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 09:17:04 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20190304194857.9780-1-philmd@redhat.com>
	<20190304194857.9780-2-philmd@redhat.com>
	<9576f379-4ade-62ec-1a03-277148bdf8e4@redhat.com>
Date: Wed, 06 Mar 2019 15:16:53 +0100
In-Reply-To: <9576f379-4ade-62ec-1a03-277148bdf8e4@redhat.com> (Laszlo Ersek's
	message of "Tue, 5 Mar 2019 18:17:42 +0100")
Message-ID: <87tvggw0iy.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/4] pflash_cfi01: Add
 pflash_cfi01_get_blk() helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

Laszlo Ersek <lersek@redhat.com> writes:

> On 03/04/19 20:48, Philippe Mathieu-Daud=C3=A9 wrote:
>> Add an helper to access the opaque struct PFlashCFI01.
>>=20
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> [PMD: Extracted from bigger patch]
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>> ---
>>  hw/block/pflash_cfi01.c  | 5 +++++
>>  include/hw/block/flash.h | 1 +
>>  2 files changed, 6 insertions(+)
>>=20
>> diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
>> index 9d1c356eb6..9ecab693e8 100644
>> --- a/hw/block/pflash_cfi01.c
>> +++ b/hw/block/pflash_cfi01.c
>> @@ -972,6 +972,11 @@ MemoryRegion *pflash_cfi01_get_memory(PFlashCFI01 *=
fl)
>>      return &fl->mem;
>>  }
>>=20=20
>> +BlockBackend *pflash_cfi01_get_blk(PFlashCFI01 *fl)
>> +{
>> +    return fl->blk;
>> +}
>> +
>>  static void postload_update_cb(void *opaque, int running, RunState stat=
e)
>>  {
>>      PFlashCFI01 *pfl =3D opaque;
>> diff --git a/include/hw/block/flash.h b/include/hw/block/flash.h
>> index 914932eaec..a0f488732a 100644
>> --- a/include/hw/block/flash.h
>> +++ b/include/hw/block/flash.h
>> @@ -22,6 +22,7 @@ PFlashCFI01 *pflash_cfi01_register(hwaddr base,
>>                                     uint16_t id0, uint16_t id1,
>>                                     uint16_t id2, uint16_t id3,
>>                                     int be);
>> +BlockBackend *pflash_cfi01_get_blk(PFlashCFI01 *fl);
>>  MemoryRegion *pflash_cfi01_get_memory(PFlashCFI01 *fl);
>>=20=20
>>  /* pflash_cfi02.c */
>>=20
>
> I generally prefer to keep the same order between declarations of
> functions, and definitions of the same functions. Compare
> pflash_cfi01_get_memory() here.

My fault, not Philippe's.

> With that updated,
>
> Reviewed-by: Laszlo Ersek <lersek@redhat.com>

Thanks!
