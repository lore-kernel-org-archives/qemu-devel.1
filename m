Received: from eggs.gnu.org ([2001:4830:134:3::10]:37630)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dKUDl-0006xX-S2
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 14:37:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dKUDg-00012t-UM
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 14:37:49 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:36689)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dKUDg-00012j-PW
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 14:37:44 -0400
Received: by mail-qt0-x243.google.com with SMTP id s33so28495756qtg.3
	for <qemu-devel@nongnu.org>; Mon, 12 Jun 2017 11:37:44 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170611231633.32582-1-laurent@vivier.eu>
	<20170611231633.32582-5-laurent@vivier.eu>
	<48fecf30-cc95-de46-e4a7-50f94dd1d49b@twiddle.net>
	<aded5012-9d86-825f-be0a-2b1c54a1fa3b@vivier.eu>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <12dd68e8-a294-2714-696f-ab45edde095a@twiddle.net>
Date: Mon, 12 Jun 2017 11:37:40 -0700
MIME-Version: 1.0
In-Reply-To: <aded5012-9d86-825f-be0a-2b1c54a1fa3b@vivier.eu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v4 4/7] target-m68k: move fmove CR to a
 function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>

On 06/12/2017 10:56 AM, Laurent Vivier wrote:
> Le 12/06/2017 à 18:13, Richard Henderson a écrit :
>> On 06/11/2017 04:16 PM, Laurent Vivier wrote:
>>> Move code of fmove to/from control register to a function
>>>
>>> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
>>> ---
>>>    target/m68k/translate.c | 66
>>> ++++++++++++++++++++++++++++++-------------------
>>>    1 file changed, 41 insertions(+), 25 deletions(-)
>>
>> In that this is 100% code movement,
>>
>> Reviewed-by: Richard Henderson <rth@twiddle.net>
>>
>>
>>> +            cpu_abort(NULL, "Unimplemented: fmove from control %d",
>>> mask);
>>> +            goto undef;
>>
>> But cpu_abort doesn't return, and will exit qemu.
>> This should be qemu_log_mask(LOG_UNIMP, ...).
> 
> Do you want I update the patch to fix that?

Yes please.


r~
