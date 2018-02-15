Received: from eggs.gnu.org ([2001:4830:134:3::10]:50212)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1emIdL-0002sp-Oo
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 07:27:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1emIdG-0004kc-NQ
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 07:27:27 -0500
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:33964)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1emIdG-0004kS-ID
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 07:27:22 -0500
Received: by mail-qk0-x241.google.com with SMTP id o7so16236397qkc.1
	for <qemu-devel@nongnu.org>; Thu, 15 Feb 2018 04:27:22 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180215042900.16078-1-f4bug@amsat.org>
	<20180215042900.16078-6-f4bug@amsat.org>
	<36b2678c-0e9f-9f92-6832-895d7cb1ee89@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <0a522b8b-2005-77a3-2b13-5792029b1ba6@amsat.org>
Date: Thu, 15 Feb 2018 09:27:19 -0300
MIME-Version: 1.0
In-Reply-To: <36b2678c-0e9f-9f92-6832-895d7cb1ee89@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 05/30] hw/mips/r4k: constify params_size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Yongbok Kim <yongbok.kim@mips.com>, Aurelien Jarno <aurelien@aurel32.net>

Hi Thomas,

On 02/15/2018 03:19 AM, Thomas Huth wrote:
> On 15.02.2018 05:28, Philippe Mathieu-Daudé wrote:
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>>  hw/mips/mips_r4k.c | 5 ++---
>>  1 file changed, 2 insertions(+), 3 deletions(-)
>>
>> diff --git a/hw/mips/mips_r4k.c b/hw/mips/mips_r4k.c
>> index 830ee7732c..5a74c44b9a 100644
>> --- a/hw/mips/mips_r4k.c
>> +++ b/hw/mips/mips_r4k.c
>> @@ -79,8 +79,9 @@ typedef struct ResetData {
>>  
>>  static int64_t load_kernel(void)
>>  {
>> +    const size_t params_size = 264;
>>      int64_t entry, kernel_high;
>> -    long kernel_size, initrd_size, params_size;
>> +    long kernel_size, initrd_size;
>>      ram_addr_t initrd_offset;
>>      uint32_t *params_buf;
>>      int big_endian;
>> @@ -128,7 +129,6 @@ static int64_t load_kernel(void)
>>      }
>>  
>>      /* Store command line.  */
>> -    params_size = 264;
>>      params_buf = g_malloc(params_size);
>>  
>>      params_buf[0] = tswap32(ram_size);
>> @@ -144,7 +144,6 @@ static int64_t load_kernel(void)
>>  
>>      rom_add_blob_fixed("params", params_buf, params_size,
>>                         (16 << 20) - 264);
>> -
>>      g_free(params_buf);
>>      return entry;
>>  }
> 
> The last hunk is an unnecessary white-space change. Did you maybe rather
> wanted to replace the 264 in the preceding line instead?

Yes :( Since this change was a bit different than the rest, I extracted
from the next patch "hw/mips: use the BYTE-based definitions" but missed.

Thanks for reviewing,

Phil.

> 
>  Thomas
> 
