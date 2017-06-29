Received: from eggs.gnu.org ([2001:4830:134:3::10]:47288)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dQcpw-0006QB-9V
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 13:02:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dQcpv-0001Od-KG
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 13:02:36 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170629010300.2848-1-f4bug@amsat.org>
	<20170629010300.2848-6-f4bug@amsat.org>
	<9403a3d0-41f6-add2-04fd-12034fe7699a@redhat.com>
	<ecb12a15-5b0c-67ef-18ad-e627b591148e@weilnetz.de>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <280da99b-50a7-85fe-8f3e-0432adf8bed6@amsat.org>
Date: Thu, 29 Jun 2017 14:02:24 -0300
MIME-Version: 1.0
In-Reply-To: <ecb12a15-5b0c-67ef-18ad-e627b591148e@weilnetz.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH RESEND 5/8] tcg/tci: enable bswap16_i64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Weil <sw@weilnetz.de>, Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, "Emilio G . Cota" <cota@braap.org>, QEMU Trivial <qemu-trivial@nongnu.org>

On 06/29/2017 01:52 PM, Stefan Weil wrote:
> Am 29.06.2017 um 18:29 schrieb Eric Blake:
>> On 06/28/2017 08:02 PM, Philippe Mathieu-Daudé wrote:
>>> remove some copy/paste leftover, code seems sane.
>>>
>>
>>>
>>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>>>
>>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>>
>> Double-sob seems odd.
> 
> Maybe that double SOB can be cleaned by qemu-trivial (cc'ed).
> 
>>
>>> ---
>>>   tcg/tci.c | 1 -
>>>   1 file changed, 1 deletion(-)
>>>
>>
>> Otherwise,
>> Reviewed-by: Eric Blake <eblake@redhat.com>
>>
> 
> Note from the author: it's not a copy/paste leftover, but was
> there on purpose: that code part was simply never executed
> before, and I only removed the TODO() statements from tested
> code.

I'll reword the commit message in my tci-fixes-for-2.10-v2 series.

> So you are the first one who found a test case. Congratulations.

Oh nice :)

> Reviewed-by: Stefan Weil <sw@weilnetz.de>

Thank.
