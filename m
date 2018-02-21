Received: from eggs.gnu.org ([2001:4830:134:3::10]:58753)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1eoawg-0007vj-H9
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 15:25:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1eoavc-0006kL-DO
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 15:24:54 -0500
Received: from mail-pl0-x22b.google.com ([2607:f8b0:400e:c01::22b]:34538)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1eoavb-0006hh-UO
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 15:23:48 -0500
Received: by mail-pl0-x22b.google.com with SMTP id u13so1569290plq.1
	for <qemu-devel@nongnu.org>; Wed, 21 Feb 2018 12:23:47 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1519093616-10563-1-git-send-email-cota@braap.org>
	<1519093616-10563-2-git-send-email-cota@braap.org>
	<512f6e39-9aa0-7e4f-fad4-7085d499ae65@linaro.org>
	<20180221201723.GA30501@flamenco>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <acb5eeb7-a350-2cb9-2596-f1017dce7aae@twiddle.net>
Date: Wed, 21 Feb 2018 12:23:43 -0800
MIME-Version: 1.0
In-Reply-To: <20180221201723.GA30501@flamenco>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCHv2 1/2] translator: merge max_insns into
 DisasContextBase
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>

On 02/21/2018 12:17 PM, Emilio G. Cota wrote:
> On Wed, Feb 21, 2018 at 10:19:05 -0800, Richard Henderson wrote:
>> On 02/19/2018 06:26 PM, Emilio G. Cota wrote:
>>> @@ -68,6 +69,7 @@ typedef struct DisasContextBase {
>>>      target_ulong pc_next;
>>>      DisasJumpType is_jmp;
>>>      unsigned int num_insns;
>>> +    int max_insns;
>>>      bool singlestep_enabled;
>>>  } DisasContextBase;
>>
>> We really should pick the same type for max_insns and num_insns, which ever
>> type we settle on.  I can't see how we can go wrong with unsigned...
> 
> I was just trying to avoid warnings with -Wsign-compare in case
> we ever enabled it.

Well, right.  That's my point.  We compare num_insns < max_insns.

> Should I bother converting the "bound" variables we use for
> MIN(max_insns, bound) to unsigned as well? Or just leave them
> alone and forget about -Wsign-compare?

You could change num_insns to "int" as well.


r~
