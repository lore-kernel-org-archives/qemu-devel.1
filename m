Received: from eggs.gnu.org ([208.118.235.92]:51708)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1gd2pL-0000Hi-LB
	for qemu-devel@nongnu.org; Fri, 28 Dec 2018 19:50:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1gd2pI-00072Y-4R
	for qemu-devel@nongnu.org; Fri, 28 Dec 2018 19:50:07 -0500
Received: from mail-io1-xd43.google.com ([2607:f8b0:4864:20::d43]:44717)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1gd2pG-0006ye-1a
	for qemu-devel@nongnu.org; Fri, 28 Dec 2018 19:50:02 -0500
Received: by mail-io1-xd43.google.com with SMTP id r200so17847975iod.11
	for <qemu-devel@nongnu.org>; Fri, 28 Dec 2018 16:49:59 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
From: Programmingkid <programmingkidx@gmail.com>
In-Reply-To: <78f4f24e-6fe0-9da2-8ac7-01dbd70a3739@gmail.com>
Date: Fri, 28 Dec 2018 19:49:56 -0500
Content-Transfer-Encoding: quoted-printable
Message-Id: <06BEE403-8294-4764-AFE6-91701E325F1A@gmail.com>
References: <mailman.31873.1545598364.1282.qemu-devel@nongnu.org>
	<E04FDC0A-1912-4402-9CF5-755914945754@gmail.com>
	<e87c0056-4150-0d5e-e049-d71750da1f17@gmail.com>
	<228BFF97-3D85-4A30-89E1-18570472D119@gmail.com>
	<335c7f56-d3e0-0be8-d416-484eb181038e@gmail.com>
	<15778293-4038-4D3A-982A-20DFA333E179@gmail.com>
	<78f4f24e-6fe0-9da2-8ac7-01dbd70a3739@gmail.com>
Subject: Re: [Qemu-devel] [PATCH v2 00/52] Audio 5.1 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?B?Wm9sdMOhbiBLxZF2w6Fnw7M=?= <dirty.ice.hu@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>


> On Dec 28, 2018, at 7:19 PM, Zolt=C3=A1n K=C5=91v=C3=A1g=C3=B3 =
<dirty.ice.hu@gmail.com> wrote:
>=20
> On 2018-12-29 01:12, Programmingkid wrote:
>>=20
>>> On Dec 28, 2018, at 3:05 PM, K=C5=91v=C3=A1g=C3=B3 Zolt=C3=A1n =
<dirty.ice.hu@gmail.com> wrote:
>>>=20
>>> On 2018-12-28 01:46, Programmingkid wrote:
>>>>=20
>>>>> On Dec 27, 2018, at 8:33 AM, K=C5=91v=C3=A1g=C3=B3 Zolt=C3=A1n =
<dirty.ice.hu@gmail.com> wrote:
>>>>>=20
>>>>> Hi,
>>>>>=20
>>>>> I've pushed it to my github (modulo some random fixes not yet on =
the
>>>>> mailing list):
>>>>> https://github.com/DirtYiCE/qemu/tree/audio-51-2018
>>>>>=20
>>>>> I don't have a mac so I have no idea whether it works or not.
>>>>>=20
>>>>> Regards,
>>>>> Zoltan
>>>>>=20
>>>>> On 2018-12-26 12:24, Programmingkid wrote:
>>>>>>=20
>>>>>>> On Dec 23, 2018, at 3:52 PM, qemu-devel-request@nongnu.org =
wrote:
>>>>>>>=20
>>>>>>> Message: 4
>>>>>>> Date: Sun, 23 Dec 2018 21:51:36 +0100
>>>>>>> From: "=3D?UTF-8?q?K=3DC5=3D91v=3DC3=3DA1g=3DC3=3DB3=3D2C=3D20Zolt=
=3DC3=3DA1n?=3D"
>>>>>>> 	<dirty.ice.hu@gmail.com>
>>>>>>> To: qemu-devel@nongnu.org
>>>>>>> Cc: Gerd Hoffmann <kraxel@redhat.com>
>>>>>>> Subject: [Qemu-devel] [PATCH v2 00/52] Audio 5.1 patches
>>>>>>> Message-ID: <cover.1545598229.git.DirtY.iCE.hu@gmail.com>
>>>>>>> Content-Type: text/plain; charset=3DUTF-8
>>>>>>>=20
>>>>>>> Hi,
>>>>>>>=20
>>>>>>> I've updated my audio patchset to the current git master. Other =
than that not
>>>>>>> much happened since my last update [1], fixed a few small =
problems that I
>>>>>>> noticed while rebasing my patches.
>>>>>>>=20
>>>>>>> Please review.
>>>>>>=20
>>>>>> <snip>
>>>>>>=20
>>>>>> Hi I would like to run your patches. Do you have a repository =
that I may clone?=20
>>>>>>=20
>>>>>> Also have you been able to test these patches using a Mac OS X =
guest yet?=20
>>>>>>=20
>>>>>> Thank you.
>>>>>>=20
>>>>>=20
>>>>=20
>>>> Hi, thanks for the link. This is what I did:
>>>>=20
>>>> - git clone https://github.com/DirtYiCE/qemu.git
>>>> - git checkout audio-51-2018
>>>> - ./configure --target-list=3Dppc-softmmu
>>>> - make -j 4
>>>>=20
>>>> The result was unfortunately some errors:
>>>>=20
>>>> CC      audio/coreaudio.o
>>>> audio/coreaudio.c:413:49: error: unknown type name 'HWVocieOut'; =
did you mean
>>>>     'HWVoiceOut'?
>>>> COREAUDIO_WRAPPER_FUNC(get_buffer_out, void *, (HWVocieOut *hw, =
size_t *size),
>>>>                                               ^~~~~~~~~~
>>>>                                               HWVoiceOut
>>>>=20
>>>>=20
>>>> audio/coreaudio.c:578:29: error: passing 'struct audio_pcm_info' to =
parameter of
>>>>     incompatible type 'struct audio_pcm_info *'; take the address =
with &
>>>>       coreaudio_get_flags(hw->info, as);
>>>>                           ^~~~~~~~
>>>>                           &
>>>>=20
>>>>=20
>>>=20
>>> Hi,
>>>=20
>>> I pushed an updated version, it should fix the compile errors =
(hopefully).
>>>=20
>>> Regards,
>>> Zoltan
>>=20
>> Thank you for the update. I tested this series using a Mac OS 10.4 =
and Windows 2000 guest. Both were using a USB sound card. The sound that =
comes out of my speakers is demonic! It is the loudest, scariest sound I =
have ever heard. I'm sorry but this patch series ruins the USB sound =
card.
>>=20
>> I am happy to test out any future updates that you make this patch =
series.=20
>>=20
>> Thank you.
>>=20
>=20
> I'm sorry to hear that. Could you please test it with some other card,
> like the hda? Even though usb works fine for me on Linux with alsa so
> the problem is probably with the coreaudio backend.
>=20
> Regards,
> Zoltan

I tried ac97 with a Windows 2000 guest in qemu-system-i386 - same =
demonic sound.
With the above configuration but with an es1370 sound card I heard the =
same sound. I kept seeing "es1370: warning: non looping mode" being =
printed in the terminal. This problem might need its own patch.
Using the sb16 sound card I heard the same unsettling sound.

I could not test the HDA driver due to problems with my Windows 7 VM. =20=
