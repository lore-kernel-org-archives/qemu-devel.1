Received: from eggs.gnu.org ([2001:4830:134:3::10]:53722)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d9dlh-0007bq-Nl
	for qemu-devel@nongnu.org; Sat, 13 May 2017 16:36:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d9dlg-0003sU-Vz
	for qemu-devel@nongnu.org; Sat, 13 May 2017 16:36:01 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170418013356.3578-1-eblake@redhat.com>
	<20170418013356.3578-27-eblake@redhat.com>
	<a80702a0-b0b0-2d14-8aca-895b0da9ceb0@weilnetz.de>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <5b75f876-02a7-6ef6-7716-c29e0985faf1@amsat.org>
Date: Sat, 13 May 2017 17:35:50 -0300
MIME-Version: 1.0
In-Reply-To: <a80702a0-b0b0-2d14-8aca-895b0da9ceb0@weilnetz.de>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 26/31] vdi: Avoid bitrot of debugging code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Weil <sw@weilnetz.de>, Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, kwolf@nongnu.org, jsnow@redhat.com, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On 04/18/2017 02:13 AM, Stefan Weil wrote:
> Am 18.04.2017 um 03:33 schrieb Eric Blake:
>> Rework the debug define so that we always get -Wformat checking,
>> even when debugging is disabled.
>>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>> ---
>
> Reviewed-by: Stefan Weil <sw@weilnetz.de>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

>
>>  block/vdi.c | 12 +++++++++---
>>  1 file changed, 9 insertions(+), 3 deletions(-)
>>
>> diff --git a/block/vdi.c b/block/vdi.c
>> index d12d9cd..a70b969 100644
>> --- a/block/vdi.c
>> +++ b/block/vdi.c
>> @@ -86,12 +86,18 @@
>>  #define DEFAULT_CLUSTER_SIZE (1 * MiB)
>>
>>  #if defined(CONFIG_VDI_DEBUG)
>> -#define logout(fmt, ...) \
>> -                fprintf(stderr, "vdi\t%-24s" fmt, __func__,
>> ##__VA_ARGS__)
>> +#define VDI_DEBUG 1
>>  #else
>> -#define logout(fmt, ...) ((void)0)
>> +#define VDI_DEBUG 0
>>  #endif
>>
>> +#define logout(fmt, ...) \
>> +    do
>> {                                                                \
>> +        if (VDI_DEBUG)
>> {                                                \
>> +            fprintf(stderr, "vdi\t%-24s" fmt, __func__,
>> ##__VA_ARGS__); \
>> +
>> }                                                               \
>> +    } while (0)
>> +
>>  /* Image signature. */
>>  #define VDI_SIGNATURE 0xbeda107f
>>
>
>
