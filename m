Received: from eggs.gnu.org ([209.51.188.92]:51714)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gwrPk-0005kK-1N
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 11:41:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gwrPh-0001kq-AC
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 11:41:35 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53568)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gwrPf-0001iZ-DD
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 11:41:32 -0500
Received: by mail-wm1-f67.google.com with SMTP id e74so9629539wmg.3
	for <qemu-devel@nongnu.org>; Thu, 21 Feb 2019 08:41:28 -0800 (PST)
References: <20190218125615.18970-1-armbru@redhat.com>
	<20190218125615.18970-2-armbru@redhat.com>
	<095c8b8c-d33a-e972-d38f-b22b39d5c4b0@redhat.com>
	<87o977uc8t.fsf@dusky.pond.sub.org>
	<667aa10b-c0f0-2d2a-201d-d4e5a2db085b@redhat.com>
	<87wolt5woo.fsf@dusky.pond.sub.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <26b3b60f-78bd-a08a-dc5e-f33a29e30e43@redhat.com>
Date: Thu, 21 Feb 2019 17:41:25 +0100
MIME-Version: 1.0
In-Reply-To: <87wolt5woo.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 01/10] pflash: Rename pflash_t to
 PFlashCFI01, PFlashCFI02
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: kwolf@redhat.com, qemu-block@nongnu.org, alex.bennee@linaro.org, qemu-devel@nongnu.org, mreitz@redhat.com, qemu-ppc@nongnu.org, lersek@redhat.com

On 2/21/19 10:15 AM, Markus Armbruster wrote:
> Philippe Mathieu-Daudé <philmd@redhat.com> writes:
> 
>> On 2/19/19 2:41 PM, Markus Armbruster wrote:
>>> Philippe Mathieu-Daudé <philmd@redhat.com> writes:
>>>
>>>> On 2/18/19 1:56 PM, Markus Armbruster wrote:
>>>>> flash.h's incomplete struct pflash_t is completed both in
>>>>> pflash_cfi01.c and in pflash_cfi02.c.  The complete types are
>>>>> incompatible.  This can hide type errors, such as passing a pflash_t
>>>>> created with pflash_cfi02_register() to pflash_cfi01_get_memory().
>>>>>
>>>>> Furthermore, POSIX reserves typedef names ending with _t.
>>
>> Worth adding in CODING_STYLE 'Naming' section :)
>>
>>>>>
>>>>> Rename the two structs to PFlashCFI01 and PFlashCFI02.
>>>>
>>>> Why not ParallelFlashCFIxx?
>>>
>>> Feels a bit long, and we abbreviate to pflash pretty consistently.  That
>>> said, I'm not particularly enamored with my choice of name :)
>>>
>>>> Ideally ParallelFlashCFI would be an InterfaceInfo...
>>>
>>> You mean TYPE_CFI_PFLASH0{1,2} should be children of an abstract parent?
>>
>> I'd use "TYPE_PFLASH_CFI0[12]".
> 
> That's a separate renaming patch.  It could go right before PATCH 03.
> Worthwhile?

Definitively not the more important issue with this device =)
