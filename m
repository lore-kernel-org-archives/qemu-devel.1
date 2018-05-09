Received: from eggs.gnu.org ([2001:4830:134:3::10]:59516)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fGGA3-0001DD-2E
	for qemu-devel@nongnu.org; Tue, 08 May 2018 23:53:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fGG9y-0005YQ-Dv
	for qemu-devel@nongnu.org; Tue, 08 May 2018 23:53:03 -0400
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:39664)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fGG9y-0005Xx-9I
	for qemu-devel@nongnu.org; Tue, 08 May 2018 23:52:58 -0400
Received: by mail-qk0-x244.google.com with SMTP id z75so26501844qkb.6
	for <qemu-devel@nongnu.org>; Tue, 08 May 2018 20:52:58 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180421232120.22208-1-f4bug@amsat.org>
	<b258037c-2e37-3c21-8fe5-38e5dcf5cf2c@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <e3b4d5b3-d223-8a28-4c2a-ff3cd9b0e78c@amsat.org>
Date: Wed, 9 May 2018 00:52:51 -0300
MIME-Version: 1.0
In-Reply-To: <b258037c-2e37-3c21-8fe5-38e5dcf5cf2c@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] elf-loader: Avoid calling qsort(NULL, 0,
 ...) call
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Filippov <jcmvbkbc@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Richard Henderson <richard.henderson@linaro.org>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org

Hi Paolo,

On 04/22/2018 04:22 PM, Richard Henderson wrote:
> On 04/21/2018 01:21 PM, Philippe Mathieu-Daudé wrote:
>> This fixes the following ASan warning:
>>
>>   $ qemu-system-xtensa -M kc705 -m 128M -semihosting -nographic -monitor null -kernel Image.elf
>>   include/hw/elf_ops.h:179:5: runtime error: null pointer passed as argument 1, which is declared to never be null
>>
>> Reported-by: AddressSanitizer
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>>  include/hw/elf_ops.h | 39 ++++++++++++++++++++++-----------------
>>  1 file changed, 22 insertions(+), 17 deletions(-)
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Since this patch isn't Xtensa specific, can it goes via your MISC tree?

Thanks,

Phil.
