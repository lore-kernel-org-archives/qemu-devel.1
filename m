Received: from eggs.gnu.org ([208.118.235.92]:58682)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dirty.ice.hu@gmail.com>) id 1geJ8e-0001O4-4P
	for qemu-devel@nongnu.org; Tue, 01 Jan 2019 07:27:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dirty.ice.hu@gmail.com>) id 1geJ8d-00022B-EB
	for qemu-devel@nongnu.org; Tue, 01 Jan 2019 07:27:16 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:39601)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <dirty.ice.hu@gmail.com>)
	id 1geJ8d-00021i-8F
	for qemu-devel@nongnu.org; Tue, 01 Jan 2019 07:27:15 -0500
Received: by mail-wr1-x444.google.com with SMTP id t27so28141664wra.6
	for <qemu-devel@nongnu.org>; Tue, 01 Jan 2019 04:27:15 -0800 (PST)
From: "=?UTF-8?B?Wm9sdMOhbiBLxZF2w6Fnw7M=?=" <dirty.ice.hu@gmail.com>
References: <B4B164B9-DCEE-41B2-ACF5-81D4FCBFF23B@gmail.com>
	<EB385199-ACC7-4B87-97E7-4C13610AA28F@gmail.com>
Message-ID: <148c959b-c2cf-bf80-b8ec-6f0365b914af@gmail.com>
Date: Tue, 1 Jan 2019 13:27:07 +0100
MIME-Version: 1.0
In-Reply-To: <EB385199-ACC7-4B87-97E7-4C13610AA28F@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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

On 2019-01-01 05:24, Programmingkid wrote:
>> On 2018-12-29 01:49, Programmingkid wrote:
[snip]
>>>
>>> I tried ac97 with a Windows 2000 guest in qemu-system-i386 - same demonic sound.
>>> With the above configuration but with an es1370 sound card I heard the same sound. I kept seeing "es1370: warning: non looping mode" being printed in the terminal. This problem might need its own patch.
>>> Using the sb16 sound card I heard the same unsettling sound.
>>>
>>> I could not test the HDA driver due to problems with my Windows 7 VM.  
>>>
>>
>>
>> I have a feeling that bf870a0cf5e2c2dd7438e65473b4fca1fb0ca5d1
>> (coreaudio: port to the new audio backend api) is the commit which
>> breaks it, but without a mac I don't know how could I debug it. The way
>> it initializes coreaudio changed a bit, that can cause problems.
>> Could you please test whether this commit is the culprit or not?
>>
>> Regards,
>> Zoltan
> 
> 
> Hi how do you want me to test your theory? Revert the patch? If I did I don't think QEMU would still compile. 

No, don't revert it, that would generate too many conflicts. Just

git checkout bf870a0c

and

git checkout bf870a0c~

should give you two versions that you can compare.

Regards,
Zoltan
