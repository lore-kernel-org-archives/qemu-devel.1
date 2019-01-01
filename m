Received: from eggs.gnu.org ([208.118.235.92]:47550)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1geMjV-0007e2-UE
	for qemu-devel@nongnu.org; Tue, 01 Jan 2019 11:17:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1geMjS-0004d0-1N
	for qemu-devel@nongnu.org; Tue, 01 Jan 2019 11:17:33 -0500
Received: from mail-io1-xd43.google.com ([2607:f8b0:4864:20::d43]:37908)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1geMjQ-0004P1-PM
	for qemu-devel@nongnu.org; Tue, 01 Jan 2019 11:17:29 -0500
Received: by mail-io1-xd43.google.com with SMTP id l14so22945578ioj.5
	for <qemu-devel@nongnu.org>; Tue, 01 Jan 2019 08:17:17 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
From: Programmingkid <programmingkidx@gmail.com>
In-Reply-To: <148c959b-c2cf-bf80-b8ec-6f0365b914af@gmail.com>
Date: Tue, 1 Jan 2019 11:17:13 -0500
Content-Transfer-Encoding: quoted-printable
Message-Id: <9DD59E5E-C84B-498C-A020-BADDAE9DD9A8@gmail.com>
References: <B4B164B9-DCEE-41B2-ACF5-81D4FCBFF23B@gmail.com>
	<EB385199-ACC7-4B87-97E7-4C13610AA28F@gmail.com>
	<148c959b-c2cf-bf80-b8ec-6f0365b914af@gmail.com>
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


> On Jan 1, 2019, at 7:27 AM, Zolt=C3=A1n K=C5=91v=C3=A1g=C3=B3 =
<dirty.ice.hu@gmail.com> wrote:
>=20
> On 2019-01-01 05:24, Programmingkid wrote:
>>> On 2018-12-29 01:49, Programmingkid wrote:
> [snip]
>>>>=20
>>>> I tried ac97 with a Windows 2000 guest in qemu-system-i386 - same =
demonic sound.
>>>> With the above configuration but with an es1370 sound card I heard =
the same sound. I kept seeing "es1370: warning: non looping mode" being =
printed in the terminal. This problem might need its own patch.
>>>> Using the sb16 sound card I heard the same unsettling sound.
>>>>=20
>>>> I could not test the HDA driver due to problems with my Windows 7 =
VM. =20
>>>>=20
>>>=20
>>>=20
>>> I have a feeling that bf870a0cf5e2c2dd7438e65473b4fca1fb0ca5d1
>>> (coreaudio: port to the new audio backend api) is the commit which
>>> breaks it, but without a mac I don't know how could I debug it. The =
way
>>> it initializes coreaudio changed a bit, that can cause problems.
>>> Could you please test whether this commit is the culprit or not?
>>>=20
>>> Regards,
>>> Zoltan
>>=20
>>=20
>> Hi how do you want me to test your theory? Revert the patch? If I did =
I don't think QEMU would still compile.=20
>=20
> No, don't revert it, that would generate too many conflicts. Just
>=20
> git checkout bf870a0c

This causes the very disturbing sound to play.

>=20
> and
>=20
> git checkout bf870a0c~

This also causes the very disturbing sound to play.

>=20
> should give you two versions that you can compare.
>=20
> Regards,
> Zoltan

Thank you.=
