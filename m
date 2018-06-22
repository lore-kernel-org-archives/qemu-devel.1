Received: from eggs.gnu.org ([2001:4830:134:3::10]:51900)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fWSU7-0005Cz-AZ
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 16:16:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fWSU6-0005kB-Bn
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 16:16:43 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180622134036.23182-1-f4bug@amsat.org>
	<20180622134036.23182-15-f4bug@amsat.org>
	<9e5b3eee-1335-9eae-709a-3f8d05729c03@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <49794564-eb8b-476e-6373-e70f814220ee@amsat.org>
Date: Fri, 22 Jun 2018 17:16:32 -0300
MIME-Version: 1.0
In-Reply-To: <9e5b3eee-1335-9eae-709a-3f8d05729c03@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 14/14] hw/arm/stellaris: Fix
 gptm_write() error message
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, qemu-arm@nongnu.org

On 06/22/2018 04:55 PM, Thomas Huth wrote:
> On 22.06.2018 15:40, Philippe Mathieu-Daudé wrote:
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>>  hw/arm/stellaris.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/hw/arm/stellaris.c b/hw/arm/stellaris.c
>> index d06e366402..42baa768b2 100644
>> --- a/hw/arm/stellaris.c
>> +++ b/hw/arm/stellaris.c
>> @@ -294,7 +294,7 @@ static void gptm_write(void *opaque, hwaddr offset,
>>          break;
>>      default:
>>          qemu_log_mask(LOG_GUEST_ERROR,
>> -                      "GPTM: read at bad offset 0x%x\n", (int)offset);
>> +                      "GPTM: write at bad offset 0x%x\n", (int)offset);
> 
> While you're at it, remove the cast and use HWADDR_PRIx ?

Sure.

Thanks for your review!
