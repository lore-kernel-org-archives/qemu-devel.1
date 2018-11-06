Received: from eggs.gnu.org ([2001:4830:134:3::10]:58893)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gJyE9-0003G5-Ir
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 05:04:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gJyE6-0003tb-Cy
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 05:04:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38316)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gJyE6-0003sm-5V
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 05:04:50 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1B61FC049585
	for <qemu-devel@nongnu.org>; Tue,  6 Nov 2018 10:04:49 +0000 (UTC)
References: <1540929011-19894-1-git-send-email-pbonzini@redhat.com>
	<1540929011-19894-9-git-send-email-pbonzini@redhat.com>
	<4a977f62-40aa-0620-5698-42bf3afaa869@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1c161e1f-e62a-8138-f613-815783ca0e1f@redhat.com>
Date: Tue, 6 Nov 2018 11:04:43 +0100
MIME-Version: 1.0
In-Reply-To: <4a977f62-40aa-0620-5698-42bf3afaa869@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 08/10] memory-mapping: skip non-volatile
 memory regions in GuestPhysBlockList
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>

On 05/11/2018 16:37, Laszlo Ersek wrote:
> On 10/30/18 20:50, Paolo Bonzini wrote:
>> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>>
>> GuestPhysBlockList is currently used to produce dumps. Given the size
>> and the typical usage of NVDIMM for storage, they are not a good idea
>> to have in the dumps. We may want to have an extra dump option to
>> include them. For now, skip non-volatile regions.
>>
>> The TCG memory clear function is going to use the GuestPhysBlockList
>> as well, and will thus skip NVDIMM for similar reasons.
>>
>> Cc: lersek@redhat.com
>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> Message-Id: <20181003114454.5662-4-marcandre.lureau@redhat.com>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> ---
>>  memory_mapping.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/memory_mapping.c b/memory_mapping.c
>> index 775466f..724dd0b 100644
>> --- a/memory_mapping.c
>> +++ b/memory_mapping.c
>> @@ -206,7 +206,8 @@ static void guest_phys_blocks_region_add(MemoryLis=
tener *listener,
>> =20
>>      /* we only care about RAM */
>>      if (!memory_region_is_ram(section->mr) ||
>> -        memory_region_is_ram_device(section->mr)) {
>> +        memory_region_is_ram_device(section->mr) ||
>> +        memory_region_is_nonvolatile(section->mr)) {
>>          return;
>>      }
>> =20
>>
>=20
> This patch misses my R-b, and (in chronological order) DavidH's, from:
>=20
> http://mid.mail-archive.com/9fa8a684-8d5d-1644-3aee-86a196d31f8d@redhat=
.com
> http://mid.mail-archive.com/79e58e5c-4d78-e93d-ebe8-4b1bb65752fe@redhat=
.com

Fixed, thanks.

Paolo
