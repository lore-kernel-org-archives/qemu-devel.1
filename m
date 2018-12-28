Received: from eggs.gnu.org ([208.118.235.92]:56401)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1gcgLF-0001pa-3j
	for qemu-devel@nongnu.org; Thu, 27 Dec 2018 19:49:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1gcgIZ-0000mA-GS
	for qemu-devel@nongnu.org; Thu, 27 Dec 2018 19:46:51 -0500
Received: from mail-it1-x143.google.com ([2607:f8b0:4864:20::143]:53190)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1gcgIY-0000id-4k
	for qemu-devel@nongnu.org; Thu, 27 Dec 2018 19:46:46 -0500
Received: by mail-it1-x143.google.com with SMTP id g76so26540989itg.2
	for <qemu-devel@nongnu.org>; Thu, 27 Dec 2018 16:46:45 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
From: Programmingkid <programmingkidx@gmail.com>
In-Reply-To: <e87c0056-4150-0d5e-e049-d71750da1f17@gmail.com>
Date: Thu, 27 Dec 2018 19:46:43 -0500
Content-Transfer-Encoding: quoted-printable
Message-Id: <228BFF97-3D85-4A30-89E1-18570472D119@gmail.com>
References: <mailman.31873.1545598364.1282.qemu-devel@nongnu.org>
	<E04FDC0A-1912-4402-9CF5-755914945754@gmail.com>
	<e87c0056-4150-0d5e-e049-d71750da1f17@gmail.com>
Subject: Re: [Qemu-devel] [PATCH v2 00/52] Audio 5.1 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?B?S8WRdsOhZ8OzIFpvbHTDoW4=?= <dirty.ice.hu@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>


> On Dec 27, 2018, at 8:33 AM, K=C5=91v=C3=A1g=C3=B3 Zolt=C3=A1n =
<dirty.ice.hu@gmail.com> wrote:
>=20
> Hi,
>=20
> I've pushed it to my github (modulo some random fixes not yet on the
> mailing list):
> https://github.com/DirtYiCE/qemu/tree/audio-51-2018
>=20
> I don't have a mac so I have no idea whether it works or not.
>=20
> Regards,
> Zoltan
>=20
> On 2018-12-26 12:24, Programmingkid wrote:
>>=20
>>> On Dec 23, 2018, at 3:52 PM, qemu-devel-request@nongnu.org wrote:
>>>=20
>>> Message: 4
>>> Date: Sun, 23 Dec 2018 21:51:36 +0100
>>> From: "=3D?UTF-8?q?K=3DC5=3D91v=3DC3=3DA1g=3DC3=3DB3=3D2C=3D20Zolt=3DC=
3=3DA1n?=3D"
>>> 	<dirty.ice.hu@gmail.com>
>>> To: qemu-devel@nongnu.org
>>> Cc: Gerd Hoffmann <kraxel@redhat.com>
>>> Subject: [Qemu-devel] [PATCH v2 00/52] Audio 5.1 patches
>>> Message-ID: <cover.1545598229.git.DirtY.iCE.hu@gmail.com>
>>> Content-Type: text/plain; charset=3DUTF-8
>>>=20
>>> Hi,
>>>=20
>>> I've updated my audio patchset to the current git master. Other than =
that not
>>> much happened since my last update [1], fixed a few small problems =
that I
>>> noticed while rebasing my patches.
>>>=20
>>> Please review.
>>=20
>> <snip>
>>=20
>> Hi I would like to run your patches. Do you have a repository that I =
may clone?=20
>>=20
>> Also have you been able to test these patches using a Mac OS X guest =
yet?=20
>>=20
>> Thank you.
>>=20
>=20

Hi, thanks for the link. This is what I did:

 - git clone https://github.com/DirtYiCE/qemu.git
 - git checkout audio-51-2018
 - ./configure --target-list=3Dppc-softmmu
 - make -j 4

The result was unfortunately some errors:

  CC      audio/coreaudio.o
audio/coreaudio.c:413:49: error: unknown type name 'HWVocieOut'; did you =
mean
      'HWVoiceOut'?
COREAUDIO_WRAPPER_FUNC(get_buffer_out, void *, (HWVocieOut *hw, size_t =
*size),
                                                ^~~~~~~~~~
                                                HWVoiceOut


audio/coreaudio.c:578:29: error: passing 'struct audio_pcm_info' to =
parameter of
      incompatible type 'struct audio_pcm_info *'; take the address with =
&
        coreaudio_get_flags(hw->info, as);
                            ^~~~~~~~
                            &
