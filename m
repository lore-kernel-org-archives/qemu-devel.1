Received: from eggs.gnu.org ([2001:4830:134:3::10]:60962)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gSiO0-0002Mh-Jw
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 07:59:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gSiNz-0002Hf-Ht
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 07:59:12 -0500
References: <1543571638-2892-1-git-send-email-liq3ea@gmail.com>
	<16fc13de-778b-430e-d734-bbc802d25ba8@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <8f24cfdf-061b-75e8-9d89-e2b0b5196115@vivier.eu>
Date: Fri, 30 Nov 2018 13:58:57 +0100
MIME-Version: 1.0
In-Reply-To: <16fc13de-778b-430e-d734-bbc802d25ba8@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] util: vfio-helpers: use ARRAY_SIZE in
 qemu_vfio_init_pci()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Li Qiang <liq3ea@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org

On 30/11/2018 13:01, Philippe Mathieu-Daudé wrote:
> On 30/11/18 10:53, Li Qiang wrote:
>> Cc: qemu-trivial@nongnu.org
>>
>> Signed-off-by: Li Qiang <liq3ea@gmail.com>
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> 
>> ---
>>  util/vfio-helpers.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/util/vfio-helpers.c b/util/vfio-helpers.c
>> index cccc9cd42e..342d4a2285 100644
>> --- a/util/vfio-helpers.c
>> +++ b/util/vfio-helpers.c
>> @@ -348,7 +348,7 @@ static int qemu_vfio_init_pci(QEMUVFIOState *s, const char *device,
>>          goto fail;
>>      }
>>  
>> -    for (i = 0; i < 6; i++) {
>> +    for (i = 0; i < ARRAY_SIZE(s->bar_region_info); i++) {
>>          ret = qemu_vfio_pci_init_bar(s, i, errp);
>>          if (ret) {
>>              goto fail;
>>

I'm wondering if adding a #define to define the size of the array and
then using it with the for() loop wouldn't be better?

Laurent
