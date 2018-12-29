Received: from eggs.gnu.org ([208.118.235.92]:45736)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dirty.ice.hu@gmail.com>) id 1gd2PX-0004on-NI
	for qemu-devel@nongnu.org; Fri, 28 Dec 2018 19:23:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dirty.ice.hu@gmail.com>) id 1gd2M3-0000QO-7S
	for qemu-devel@nongnu.org; Fri, 28 Dec 2018 19:19:52 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:51885)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <dirty.ice.hu@gmail.com>)
	id 1gd2M3-0000Q6-1F
	for qemu-devel@nongnu.org; Fri, 28 Dec 2018 19:19:51 -0500
Received: by mail-wm1-x342.google.com with SMTP id b11so19974220wmj.1
	for <qemu-devel@nongnu.org>; Fri, 28 Dec 2018 16:19:50 -0800 (PST)
From: "=?UTF-8?B?Wm9sdMOhbiBLxZF2w6Fnw7M=?=" <dirty.ice.hu@gmail.com>
References: <mailman.31873.1545598364.1282.qemu-devel@nongnu.org>
	<E04FDC0A-1912-4402-9CF5-755914945754@gmail.com>
	<e87c0056-4150-0d5e-e049-d71750da1f17@gmail.com>
	<228BFF97-3D85-4A30-89E1-18570472D119@gmail.com>
	<335c7f56-d3e0-0be8-d416-484eb181038e@gmail.com>
	<15778293-4038-4D3A-982A-20DFA333E179@gmail.com>
Message-ID: <78f4f24e-6fe0-9da2-8ac7-01dbd70a3739@gmail.com>
Date: Sat, 29 Dec 2018 01:19:47 +0100
MIME-Version: 1.0
In-Reply-To: <15778293-4038-4D3A-982A-20DFA333E179@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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

On 2018-12-29 01:12, Programmingkid wrote:
> 
>> On Dec 28, 2018, at 3:05 PM, Kővágó Zoltán <dirty.ice.hu@gmail.com> wrote:
>>
>> On 2018-12-28 01:46, Programmingkid wrote:
>>>
>>>> On Dec 27, 2018, at 8:33 AM, Kővágó Zoltán <dirty.ice.hu@gmail.com> wrote:
>>>>
>>>> Hi,
>>>>
>>>> I've pushed it to my github (modulo some random fixes not yet on the
>>>> mailing list):
>>>> https://github.com/DirtYiCE/qemu/tree/audio-51-2018
>>>>
>>>> I don't have a mac so I have no idea whether it works or not.
>>>>
>>>> Regards,
>>>> Zoltan
>>>>
>>>> On 2018-12-26 12:24, Programmingkid wrote:
>>>>>
>>>>>> On Dec 23, 2018, at 3:52 PM, qemu-devel-request@nongnu.org wrote:
>>>>>>
>>>>>> Message: 4
>>>>>> Date: Sun, 23 Dec 2018 21:51:36 +0100
>>>>>> From: "=?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?="
>>>>>> 	<dirty.ice.hu@gmail.com>
>>>>>> To: qemu-devel@nongnu.org
>>>>>> Cc: Gerd Hoffmann <kraxel@redhat.com>
>>>>>> Subject: [Qemu-devel] [PATCH v2 00/52] Audio 5.1 patches
>>>>>> Message-ID: <cover.1545598229.git.DirtY.iCE.hu@gmail.com>
>>>>>> Content-Type: text/plain; charset=UTF-8
>>>>>>
>>>>>> Hi,
>>>>>>
>>>>>> I've updated my audio patchset to the current git master. Other than that not
>>>>>> much happened since my last update [1], fixed a few small problems that I
>>>>>> noticed while rebasing my patches.
>>>>>>
>>>>>> Please review.
>>>>>
>>>>> <snip>
>>>>>
>>>>> Hi I would like to run your patches. Do you have a repository that I may clone? 
>>>>>
>>>>> Also have you been able to test these patches using a Mac OS X guest yet? 
>>>>>
>>>>> Thank you.
>>>>>
>>>>
>>>
>>> Hi, thanks for the link. This is what I did:
>>>
>>> - git clone https://github.com/DirtYiCE/qemu.git
>>> - git checkout audio-51-2018
>>> - ./configure --target-list=ppc-softmmu
>>> - make -j 4
>>>
>>> The result was unfortunately some errors:
>>>
>>>  CC      audio/coreaudio.o
>>> audio/coreaudio.c:413:49: error: unknown type name 'HWVocieOut'; did you mean
>>>      'HWVoiceOut'?
>>> COREAUDIO_WRAPPER_FUNC(get_buffer_out, void *, (HWVocieOut *hw, size_t *size),
>>>                                                ^~~~~~~~~~
>>>                                                HWVoiceOut
>>>
>>>
>>> audio/coreaudio.c:578:29: error: passing 'struct audio_pcm_info' to parameter of
>>>      incompatible type 'struct audio_pcm_info *'; take the address with &
>>>        coreaudio_get_flags(hw->info, as);
>>>                            ^~~~~~~~
>>>                            &
>>>
>>>
>>
>> Hi,
>>
>> I pushed an updated version, it should fix the compile errors (hopefully).
>>
>> Regards,
>> Zoltan
> 
> Thank you for the update. I tested this series using a Mac OS 10.4 and Windows 2000 guest. Both were using a USB sound card. The sound that comes out of my speakers is demonic! It is the loudest, scariest sound I have ever heard. I'm sorry but this patch series ruins the USB sound card.
> 
> I am happy to test out any future updates that you make this patch series. 
> 
> Thank you.
> 

I'm sorry to hear that. Could you please test it with some other card,
like the hda? Even though usb works fine for me on Linux with alsa so
the problem is probably with the coreaudio backend.

Regards,
Zoltan
