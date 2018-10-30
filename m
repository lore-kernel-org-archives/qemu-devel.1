Received: from eggs.gnu.org ([2001:4830:134:3::10]:42087)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gHTgT-0005u2-WD
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 09:03:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gHTgO-0004z3-TG
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 09:03:49 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46704)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gHTgN-0004nw-FG
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 09:03:43 -0400
Received: by mail-wr1-f68.google.com with SMTP id 74-v6so4290927wrb.13
	for <qemu-devel@nongnu.org>; Tue, 30 Oct 2018 06:03:21 -0700 (PDT)
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
References: <1540899411-16761-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1540899411-16761-5-git-send-email-aleksandar.markovic@rt-rk.com>
	<f9b3eb95-7696-93b1-6b63-14b80e4d9217@redhat.com>
Message-ID: <d6b50cc0-c91c-e0f7-b832-1001508a20da@redhat.com>
Date: Tue, 30 Oct 2018 14:03:18 +0100
MIME-Version: 1.0
In-Reply-To: <f9b3eb95-7696-93b1-6b63-14b80e4d9217@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 4/5] target/mips: Misc R5900-related
 cosmetic changes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, qemu-devel@nongnu.org
Cc: smarkovic@wavecomp.com, pjovanovic@wavecomp.com, amarkovic@wavecomp.com, aurelien@aurel32.net

On 30/10/18 13:47, Philippe Mathieu-Daudé wrote:
> On 30/10/18 12:36, Aleksandar Markovic wrote:
>> From: Aleksandar Markovic <amarkovic@wavecomp.com>
>>
>> Misc changes in comments and strings for R5900.
>>
>> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
>> ---
>>   target/mips/translate.c          | 14 +++++++-------
>>   target/mips/translate_init.inc.c | 12 ------------
>>   2 files changed, 7 insertions(+), 19 deletions(-)
>>
>> diff --git a/target/mips/translate.c b/target/mips/translate.c
>> index 155331f..259ad2b 100644
>> --- a/target/mips/translate.c
>> +++ b/target/mips/translate.c
>> @@ -2096,8 +2096,8 @@ enum {
>>    * MTSAH   rs, immediate     Move Halfword Count to Shift Amount 
>> Register
>>    * PROT3W  rd, rt            Parallel Rotate 3 Words
>>    *
>> - *     The TX79-specific Multimedia Instruction encodings
>> - *     ==================================================
>> + *     Multimedia Instructions (MMI) encodings
> 
> Oh now I see this. I this single change should be squashed into patch #2 

I forgot the verb ;) I <think> this change ...

> of this series.
> 
> Also, maybe use "MultiMedia ..."
> 
