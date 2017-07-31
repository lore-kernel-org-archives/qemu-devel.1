Received: from eggs.gnu.org ([2001:4830:134:3::10]:39186)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1dcC3x-0004Jo-SE
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 10:52:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1dcC3u-0004O3-Nq
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 10:52:53 -0400
Received: from mail-it0-x241.google.com ([2607:f8b0:4001:c0b::241]:34013)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1dcC3u-0004Nl-Hb
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 10:52:50 -0400
Received: by mail-it0-x241.google.com with SMTP id t78so17919251ita.1
	for <qemu-devel@nongnu.org>; Mon, 31 Jul 2017 07:52:50 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
From: Programmingkid <programmingkidx@gmail.com>
In-Reply-To: <20170731131010.GB21310@redhat.com>
Date: Mon, 31 Jul 2017 10:52:46 -0400
Content-Transfer-Encoding: quoted-printable
Message-Id: <8A5AD082-9A78-4535-BF44-1CBF31E52803@gmail.com>
References: <BCFCA0C8-8811-43C3-B65A-76B4470868FD@gmail.com>
	<20170731094657.GE766@redhat.com>
	<421095EC-3086-46A4-AA1E-653831EA746D@gmail.com>
	<20170731131010.GB21310@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 1/2] Add more function keys to QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Eric Blake <eblake@redhat.com>, "qemu-devel@nongnu.org qemu-devel" <qemu-devel@nongnu.org>


> On Jul 31, 2017, at 9:10 AM, Daniel P. Berrange <berrange@redhat.com> =
wrote:
>=20
> On Mon, Jul 31, 2017 at 08:46:56AM -0400, Programmingkid wrote:
>>=20
>>> On Jul 31, 2017, at 5:46 AM, Daniel P. Berrange =
<berrange@redhat.com> wrote:
>>>=20
>>> On Sun, Jul 30, 2017 at 04:29:27PM -0400, Programmingkid wrote:
>>>> There are now keyboards that have 19 function keys. This patch =
extends QEMU so these function keys can be used.
>>>>=20
>>>> Signed-off-by: John Arbuckle <programmingkidx@gmail.com>
>>>> ---
>>>> qapi-schema.json  | 12 +++++++++++-
>>>> ui/input-keymap.c |  9 +++++++++
>>>> 2 files changed, 20 insertions(+), 1 deletion(-)
>>>>=20
>>>> diff --git a/qapi-schema.json b/qapi-schema.json
>>>> index c96f0a2..f1c989b 100644
>>>> --- a/qapi-schema.json
>>>> +++ b/qapi-schema.json
>>>> @@ -4862,6 +4862,15 @@
>>>> # @ac_refresh: since 2.10
>>>> # @ac_bookmarks: since 2.10
>>>> # altgr, altgr_r: dropped in 2.10
>>>> +# @f16: since 2.11
>>>> +# @f17: since 2.11
>>>> +# @f18: since 2.11
>>>> +# @f19: since 2.11
>>>> +# @f20: since 2.11
>>>> +# @f21: since 2.11
>>>> +# @f22: since 2.11
>>>> +# @f23: since 2.11
>>>> +# @f24: since 2.11
>>>> #
>>>> # Since: 1.3.0
>>>> #
>>>> @@ -4888,7 +4897,8 @@
>>>>            'audionext', 'audioprev', 'audiostop', 'audioplay', =
'audiomute',
>>>>            'volumeup', 'volumedown', 'mediaselect',
>>>>            'mail', 'calculator', 'computer',
>>>> -            'ac_home', 'ac_back', 'ac_forward', 'ac_refresh', =
'ac_bookmarks' ] }
>>>> +            'ac_home', 'ac_back', 'ac_forward', 'ac_refresh', =
'ac_bookmarks',
>>>> +            'f16', 'f17', 'f18', 'f19', 'f20', 'f21', 'f22', =
'f23', 'f24'] }
>>>>=20
>>>> ##
>>>> # @KeyValue:
>>>=20
>>> This bit looks fine.
>>>=20
>>>> diff --git a/ui/input-keymap.c b/ui/input-keymap.c
>>>> index cf979c2..c0413e1 100644
>>>> --- a/ui/input-keymap.c
>>>> +++ b/ui/input-keymap.c
>>>> @@ -251,6 +251,15 @@ static const int qcode_to_number[] =3D {
>>>>=20
>>>>    [Q_KEY_CODE_F11] =3D 0x57,
>>>>    [Q_KEY_CODE_F12] =3D 0x58,
>>>> +    [Q_KEY_CODE_F16] =3D 0x59,
>>>> +    [Q_KEY_CODE_F17] =3D 0x5a,
>>>> +    [Q_KEY_CODE_F18] =3D 0x5b,
>>>> +    [Q_KEY_CODE_F19] =3D 0x5c,
>>>> +    [Q_KEY_CODE_F20] =3D 0x5d,
>>>> +    [Q_KEY_CODE_F21] =3D 0x5e,
>>>> +    [Q_KEY_CODE_F22] =3D 0x5f,
>>>> +    [Q_KEY_CODE_F23] =3D 0x60,
>>>> +    [Q_KEY_CODE_F24] =3D 0x61,
>>>=20
>>> You've got a gap there F13, F14, F15 were all missing (pre-existing =
bug in
>>> QEMU), so you can't carry on just incrementing after F12.
>>=20
>> Actually F13, F14,and F15 are called Q_KEY_CODE_PRINT, =
Q_KEY_CODE_SCROLL_LOCK,
>> and Q_KEY_CODE_PAUSE respectively.
>=20
> Huh. That's not right. Print/Scroll/Pause are completely separate to =
F13/14/15

Actually it is how PC keyboards function keys F13 to F15 are labelled. =
This picture should help.=20

=
https://www.google.com/imgres?imgurl=3Dhttps%3A%2F%2Faz801952.vo.msecnd.ne=
t%2Fresources%2F679d2c4e-1733-4515-8c1f-256ce28e8a53.gif&imgrefurl=3Dhttps=
%3A%2F%2Feducation.microsoft.com%2FStory%2FLesson%3Ftoken%3DNmRcC&docid=3D=
WBXJqxx8_YpxSM&tbnid=3Dof7lxsyPbWzk2M%3A&vet=3D10ahUKEwic1uTT4LPVAhXm3YMKH=
WnWBJ4QMwjXASgCMAI..i&w=3D900&h=3D288&bih=3D947&biw=3D1349&q=3Dpc%20keyboa=
rd%20image&ved=3D0ahUKEwic1uTT4LPVAhXm3YMKHWnWBJ4QMwjXASgCMAI&iact=3Dmrc&u=
act=3D8

The Print Screen, Scroll Lock, and Pause/Break keys correspond to F13, =
F14, and F15 on this keyboard. It is the same way on older Macintosh =
keyboards. As for keyboards of other systems there could be a =
difference. I'm aware of a specific example but I suppose it is =
possible. I do know with the current mapping of the Print Screen, Scroll =
Lock, and Pause/Break keys to the F13 to F15 keys Windows, Linux, and =
Mac OS guests seem to like it.=20

Did you want separate Q_KEY_CODE_F13, Q_KEY_CODE_F14, and Q_KEY_CODE_F15 =
constants added to QEMU?=
