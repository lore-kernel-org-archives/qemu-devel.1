Received: from eggs.gnu.org ([2001:4830:134:3::10]:52262)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fWSVR-0006AM-Dw
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 16:18:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fWSVO-0006gu-9k
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 16:18:05 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180622124716.9179-1-f4bug@amsat.org>
	<CAKmqyKMp8-ZAaTU2nxaMCqoR0JsbXoogR6t6Nq7UwU3B3o1AKw@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <8ae01d79-ef5e-0036-bd4d-cb667a3e2cf4@amsat.org>
Date: Fri, 22 Jun 2018 17:17:57 -0300
MIME-Version: 1.0
In-Reply-To: <CAKmqyKMp8-ZAaTU2nxaMCqoR0JsbXoogR6t6Nq7UwU3B3o1AKw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] hw/core/register: Log unimplemented access
 via the 'unimp' debug level
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair23@gmail.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Alistair Francis <alistair@alistair23.me>, QEMU Trivial <qemu-trivial@nongnu.org>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>

On 06/22/2018 04:49 PM, Alistair Francis wrote:
> On Fri, Jun 22, 2018 at 5:47 AM, Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>>  hw/core/register.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/core/register.c b/hw/core/register.c
>> index d2d1636250..8ed7c6b927 100644
>> --- a/hw/core/register.c
>> +++ b/hw/core/register.c
>> @@ -203,7 +203,7 @@ void register_write_memory(void *opaque, hwaddr addr,
>>      }
>>
>>      if (!reg) {
>> -        qemu_log_mask(LOG_GUEST_ERROR, "%s: write to unimplemented register " \
>> +        qemu_log_mask(LOG_UNIMP, "%s: write to unimplemented register " \
>>                        "at address: %#" PRIx64 "\n", reg_array->prefix, addr);
>>          return;
>>      }
>> @@ -232,7 +232,7 @@ uint64_t register_read_memory(void *opaque, hwaddr addr,
>>      }
>>
>>      if (!reg) {
>> -        qemu_log_mask(LOG_GUEST_ERROR, "%s:  read to unimplemented register " \
>> +        qemu_log_mask(LOG_UNIMP, "%s:  read to unimplemented register " \
>>                        "at address: %#" PRIx64 "\n", reg_array->prefix, addr);
> 
> I'm not sure this is correct. These can be unimplemented because there
> are gaps in the register memory map, so it is a guest error.

This is exactly what I was wondering, thanks for your comment, I'll
probably add a comment about it.

> 
> Alistair
> 
>>          return 0;
>>      }
>> --
>> 2.18.0.rc2
>>
>>
