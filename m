Received: from [208.118.235.92] (port=60330 helo=eggs.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dirty.ice.hu@gmail.com>) id 1gfXQ3-000545-6e
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 16:54:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dirty.ice.hu@gmail.com>) id 1gfXPw-0001NZ-BG
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 16:54:13 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:53224)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <dirty.ice.hu@gmail.com>)
	id 1gfXPw-0001Hf-4n
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 16:54:12 -0500
Received: by mail-wm1-x343.google.com with SMTP id m1so2327654wml.2
	for <qemu-devel@nongnu.org>; Fri, 04 Jan 2019 13:54:11 -0800 (PST)
From: "=?UTF-8?B?Wm9sdMOhbiBLxZF2w6Fnw7M=?=" <dirty.ice.hu@gmail.com>
References: <B4B164B9-DCEE-41B2-ACF5-81D4FCBFF23B@gmail.com>
	<EB385199-ACC7-4B87-97E7-4C13610AA28F@gmail.com>
	<148c959b-c2cf-bf80-b8ec-6f0365b914af@gmail.com>
	<9DD59E5E-C84B-498C-A020-BADDAE9DD9A8@gmail.com>
Message-ID: <999942c1-6655-da1e-63c1-836ed18d003c@gmail.com>
Date: Fri, 4 Jan 2019 22:54:09 +0100
MIME-Version: 1.0
In-Reply-To: <9DD59E5E-C84B-498C-A020-BADDAE9DD9A8@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: hu-HU
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 00/52] Audio 5.1 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Programmingkid <programmingkidx@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>

On 2019-01-01 17:17, Programmingkid wrote:
> 
>> On Jan 1, 2019, at 7:27 AM, Zoltán Kővágó <dirty.ice.hu@gmail.com> wrote:
>>
>> On 2019-01-01 05:24, Programmingkid wrote:
>>>> On 2018-12-29 01:49, Programmingkid wrote:
>> [snip]
>>>>>
>>>>> I tried ac97 with a Windows 2000 guest in qemu-system-i386 - same demonic sound.
>>>>> With the above configuration but with an es1370 sound card I heard the same sound. I kept seeing "es1370: warning: non looping mode" being printed in the terminal. This problem might need its own patch.
>>>>> Using the sb16 sound card I heard the same unsettling sound.
>>>>>
>>>>> I could not test the HDA driver due to problems with my Windows 7 VM.  
>>>>>
>>>>
>>>>
>>>> I have a feeling that bf870a0cf5e2c2dd7438e65473b4fca1fb0ca5d1
>>>> (coreaudio: port to the new audio backend api) is the commit which
>>>> breaks it, but without a mac I don't know how could I debug it. The way
>>>> it initializes coreaudio changed a bit, that can cause problems.
>>>> Could you please test whether this commit is the culprit or not?
>>>>
>>>> Regards,
>>>> Zoltan
>>>
>>>
>>> Hi how do you want me to test your theory? Revert the patch? If I did I don't think QEMU would still compile. 
>>
>> No, don't revert it, that would generate too many conflicts. Just
>>
>> git checkout bf870a0c
> 
> This causes the very disturbing sound to play.
> 
>>
>> and
>>
>> git checkout bf870a0c~
> 
> This also causes the very disturbing sound to play.
> 
>>
>> should give you two versions that you can compare.
>>
>> Regards,
>> Zoltan
> 
> Thank you.
> 

That's worrying, since before that commit I didn't really do any big
refactoring on coreaudio itself, and without a Mac I have no idea how
could I debug it.
Could you at least try a git bisect and figure out which commit broke it?

Thanks,
Zoltan
