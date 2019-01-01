Received: from eggs.gnu.org ([208.118.235.92]:50916)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1geBbi-000261-CU
	for qemu-devel@nongnu.org; Mon, 31 Dec 2018 23:24:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1geBbf-000263-8I
	for qemu-devel@nongnu.org; Mon, 31 Dec 2018 23:24:46 -0500
Received: from mail-it1-x144.google.com ([2607:f8b0:4864:20::144]:50686)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1geBbf-00024Z-3V
	for qemu-devel@nongnu.org; Mon, 31 Dec 2018 23:24:43 -0500
Received: by mail-it1-x144.google.com with SMTP id z7so37451428iti.0
	for <qemu-devel@nongnu.org>; Mon, 31 Dec 2018 20:24:43 -0800 (PST)
From: Programmingkid <programmingkidx@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Date: Mon, 31 Dec 2018 23:24:41 -0500
References: <B4B164B9-DCEE-41B2-ACF5-81D4FCBFF23B@gmail.com>
Message-Id: <EB385199-ACC7-4B87-97E7-4C13610AA28F@gmail.com>
Subject: Re: [Qemu-devel] [PATCH v2 00/52] Audio 5.1 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?us-ascii?B?PT9VVEYtOD9CP1M4V1Jkc09oWjhPeklGcHZiSFREb1c0PT89?= <dirty.ice.hu@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>


> On Dec 31, 2018, at 12:00 PM, qemu-devel-request@nongnu.org wrote:
>=20
> Message: 2
> Date: Mon, 31 Dec 2018 16:50:47 +0100
> From: "=3D?UTF-8?B?S8WRdsOhZ8OzIFpvbHTDoW4=3D?=3D" =
<dirty.ice.hu@gmail.com>
> To: Programmingkid <programmingkidx@gmail.com>
> Cc: QEMU Developers <qemu-devel@nongnu.org>, Gerd Hoffmann
> 	<kraxel@redhat.com>
> Subject: Re: [Qemu-devel] [PATCH v2 00/52] Audio 5.1 patches
> Message-ID: <d6966a53-3e5e-83c4-7900-38784969744a@gmail.com>
> Content-Type: text/plain; charset=3Dutf-8
>=20
> On 2018-12-29 01:49, Programmingkid wrote:
>>=20
>>> On Dec 28, 2018, at 7:19 PM, Zolt?n K?v?g? <dirty.ice.hu@gmail.com> =
wrote:
>>>=20
>>> On 2018-12-29 01:12, Programmingkid wrote:
>>>>=20
>>>>> On Dec 28, 2018, at 3:05 PM, K?v?g? Zolt?n =
<dirty.ice.hu@gmail.com> wrote:
>>>>>=20
>>>>> On 2018-12-28 01:46, Programmingkid wrote:
>>>>>>=20
>>>>>>> On Dec 27, 2018, at 8:33 AM, K?v?g? Zolt?n =
<dirty.ice.hu@gmail.com> wrote:
>>>>>>>=20
>>>>>>> Hi,
>>>>>>>=20
>>>>>>> I've pushed it to my github (modulo some random fixes not yet on =
the
>>>>>>> mailing list):
>>>>>>> https://github.com/DirtYiCE/qemu/tree/audio-51-2018
>>>>>>>=20
>>>>>>> I don't have a mac so I have no idea whether it works or not.
>>>>>>>=20
>>>>>>> Regards,
>>>>>>> Zoltan
>>>>>>>=20
>>>>>>> On 2018-12-26 12:24, Programmingkid wrote:
>>>>>>>>=20
>>>>>>>>> On Dec 23, 2018, at 3:52 PM, qemu-devel-request@nongnu.org =
wrote:
>>>>>>>>>=20
>>>>>>>>> Message: 4
>>>>>>>>> Date: Sun, 23 Dec 2018 21:51:36 +0100
>>>>>>>>> From: "=3D?UTF-8?q?K=3DC5=3D91v=3DC3=3DA1g=3DC3=3DB3=3D2C=3D20Zo=
lt=3DC3=3DA1n?=3D"
>>>>>>>>> 	<dirty.ice.hu@gmail.com>
>>>>>>>>> To: qemu-devel@nongnu.org
>>>>>>>>> Cc: Gerd Hoffmann <kraxel@redhat.com>
>>>>>>>>> Subject: [Qemu-devel] [PATCH v2 00/52] Audio 5.1 patches
>>>>>>>>> Message-ID: <cover.1545598229.git.DirtY.iCE.hu@gmail.com>
>>>>>>>>> Content-Type: text/plain; charset=3DUTF-8
>>>>>>>>>=20
>>>>>>>>> Hi,
>>>>>>>>>=20
>>>>>>>>> I've updated my audio patchset to the current git master. =
Other than that not
>>>>>>>>> much happened since my last update [1], fixed a few small =
problems that I
>>>>>>>>> noticed while rebasing my patches.
>>>>>>>>>=20
>>>>>>>>> Please review.
>>>>>>>>=20
>>>>>>>> <snip>
>>>>>>>>=20
>>>>>>>> Hi I would like to run your patches. Do you have a repository =
that I may clone?=20
>>>>>>>>=20
>>>>>>>> Also have you been able to test these patches using a Mac OS X =
guest yet?=20
>>>>>>>>=20
>>>>>>>> Thank you.
>>>>>>>>=20
>>>>>>>=20
>>>>>>=20
>>>>>> Hi, thanks for the link. This is what I did:
>>>>>>=20
>>>>>> - git clone https://github.com/DirtYiCE/qemu.git
>>>>>> - git checkout audio-51-2018
>>>>>> - ./configure --target-list=3Dppc-softmmu
>>>>>> - make -j 4
>>>>>>=20
>>>>>> The result was unfortunately some errors:
>>>>>>=20
>>>>>> CC      audio/coreaudio.o
>>>>>> audio/coreaudio.c:413:49: error: unknown type name 'HWVocieOut'; =
did you mean
>>>>>>   'HWVoiceOut'?
>>>>>> COREAUDIO_WRAPPER_FUNC(get_buffer_out, void *, (HWVocieOut *hw, =
size_t *size),
>>>>>>                                             ^~~~~~~~~~
>>>>>>                                             HWVoiceOut
>>>>>>=20
>>>>>>=20
>>>>>> audio/coreaudio.c:578:29: error: passing 'struct audio_pcm_info' =
to parameter of
>>>>>>   incompatible type 'struct audio_pcm_info *'; take the address =
with &
>>>>>>     coreaudio_get_flags(hw->info, as);
>>>>>>                         ^~~~~~~~
>>>>>>                         &
>>>>>>=20
>>>>>>=20
>>>>>=20
>>>>> Hi,
>>>>>=20
>>>>> I pushed an updated version, it should fix the compile errors =
(hopefully).
>>>>>=20
>>>>> Regards,
>>>>> Zoltan
>>>>=20
>>>> Thank you for the update. I tested this series using a Mac OS 10.4 =
and Windows 2000 guest. Both were using a USB sound card. The sound that =
comes out of my speakers is demonic! It is the loudest, scariest sound I =
have ever heard. I'm sorry but this patch series ruins the USB sound =
card.
>>>>=20
>>>> I am happy to test out any future updates that you make this patch =
series.=20
>>>>=20
>>>> Thank you.
>>>>=20
>>>=20
>>> I'm sorry to hear that. Could you please test it with some other =
card,
>>> like the hda? Even though usb works fine for me on Linux with alsa =
so
>>> the problem is probably with the coreaudio backend.
>>>=20
>>> Regards,
>>> Zoltan
>>=20
>> I tried ac97 with a Windows 2000 guest in qemu-system-i386 - same =
demonic sound.
>> With the above configuration but with an es1370 sound card I heard =
the same sound. I kept seeing "es1370: warning: non looping mode" being =
printed in the terminal. This problem might need its own patch.
>> Using the sb16 sound card I heard the same unsettling sound.
>>=20
>> I could not test the HDA driver due to problems with my Windows 7 VM. =
=20
>>=20
>=20
>=20
> I have a feeling that bf870a0cf5e2c2dd7438e65473b4fca1fb0ca5d1
> (coreaudio: port to the new audio backend api) is the commit which
> breaks it, but without a mac I don't know how could I debug it. The =
way
> it initializes coreaudio changed a bit, that can cause problems.
> Could you please test whether this commit is the culprit or not?
>=20
> Regards,
> Zoltan


Hi how do you want me to test your theory? Revert the patch? If I did I =
don't think QEMU would still compile.=20
