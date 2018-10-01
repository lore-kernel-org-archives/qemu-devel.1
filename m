Received: from eggs.gnu.org ([2001:4830:134:3::10]:49957)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1g6tKh-00058J-RU
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 04:13:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1g6tKe-0006sV-MU
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 04:13:35 -0400
References: <20180926094219.20322-1-david@redhat.com>
	<20180926094219.20322-9-david@redhat.com>
	<df729c85-6fa1-93d7-c91e-7d3738fbf38f@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <83585994-587f-8281-3540-efa77ea8df2c@redhat.com>
Date: Mon, 1 Oct 2018 10:13:17 +0200
MIME-Version: 1.0
In-Reply-To: <df729c85-6fa1-93d7-c91e-7d3738fbf38f@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 08/24] memory-device: document
 MemoryDeviceClass
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Auger Eric <eric.auger@redhat.com>, qemu-devel@nongnu.org
Cc: Pankaj Gupta <pagupta@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Luiz Capitulino <lcapitul@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Richard Henderson <rth@twiddle.net>

On 30/09/2018 16:43, Auger Eric wrote:
> Hi David,
>=20
> On 9/26/18 11:42 AM, David Hildenbrand wrote:
>> Document the functions and when to not expect errors.
>>
>> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>=20
>> ---
>>  include/hw/mem/memory-device.h | 16 ++++++++++++++++
>>  1 file changed, 16 insertions(+)
>>
>> diff --git a/include/hw/mem/memory-device.h b/include/hw/mem/memory-de=
vice.h
>> index f02b229837..1d15cfc357 100644
>> --- a/include/hw/mem/memory-device.h
>> +++ b/include/hw/mem/memory-device.h
>> @@ -29,9 +29,25 @@ typedef struct MemoryDeviceState {
>>      Object parent_obj;
>>  } MemoryDeviceState;
>> =20
>> +/**> + * MemoryDeviceClass:
>> + * @get_addr: The address of the @md in guest physical memory. "0" me=
ans that
>> + * no address has been specified by the user and that no address has =
been
>> + * assigned yet.
>> + * @get_plugged_size: The amount of memory provided by this @md curre=
ntly
>> + * usable ("plugged") by the guest. This is helpful for devices that
>> + * dynamically manage the amount of memory accessible by the guest vi=
a
>> + * the reserved memory region. For most devices, this corresponds to =
the
>> + * size of the memory region.
>> + * @get_region_size: The size of the memory region of the @md that's =
mapped
>> + * in guest physical memory at @get_addr.
>> + * @fill_device_info: Translate current @md state into #MemoryDeviceI=
nfo.
> I think it may be relevant to document whether all those functions are
> mandated or if any are optional.

All are mandatory if not otherwise specified (right now none) ....

>=20
> With respect to the form, you could get inspired of
> include/exec/memory.h (see for instance IOMMUMemoryRegionClass doc)
>=20

... which seems to be the same approach used in IOMMUMemoryRegionClass.

While I am a friend of documentation,  I prefer to keep it short where
possible. (e.g. obvious things like "@md: the MemoryDeviceState", I
don't consider useful)

I am using right now a similar style as in include/hw/mem/pc-dimm.h and
include/exec/memory.h.

BTW, is there a coding style about such things? (where, how to document
classes, structs, fuucntions and parameters)

Thanks!


--=20

Thanks,

David / dhildenb
