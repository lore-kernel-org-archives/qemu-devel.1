Received: from eggs.gnu.org ([2001:4830:134:3::10]:33514)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1dcA6B-0003mq-VP
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 08:47:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1dcA67-0003wo-0T
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 08:47:04 -0400
Received: from mail-io0-x243.google.com ([2607:f8b0:4001:c06::243]:37825)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1dcA66-0003wN-Rb
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 08:46:58 -0400
Received: by mail-io0-x243.google.com with SMTP id c74so10603874iod.4
	for <qemu-devel@nongnu.org>; Mon, 31 Jul 2017 05:46:58 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
From: Programmingkid <programmingkidx@gmail.com>
In-Reply-To: <20170731094657.GE766@redhat.com>
Date: Mon, 31 Jul 2017 08:46:56 -0400
Content-Transfer-Encoding: quoted-printable
Message-Id: <421095EC-3086-46A4-AA1E-653831EA746D@gmail.com>
References: <BCFCA0C8-8811-43C3-B65A-76B4470868FD@gmail.com>
	<20170731094657.GE766@redhat.com>
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


> On Jul 31, 2017, at 5:46 AM, Daniel P. Berrange <berrange@redhat.com> =
wrote:
>=20
> On Sun, Jul 30, 2017 at 04:29:27PM -0400, Programmingkid wrote:
>> There are now keyboards that have 19 function keys. This patch =
extends QEMU so these function keys can be used.
>>=20
>> Signed-off-by: John Arbuckle <programmingkidx@gmail.com>
>> ---
>> qapi-schema.json  | 12 +++++++++++-
>> ui/input-keymap.c |  9 +++++++++
>> 2 files changed, 20 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/qapi-schema.json b/qapi-schema.json
>> index c96f0a2..f1c989b 100644
>> --- a/qapi-schema.json
>> +++ b/qapi-schema.json
>> @@ -4862,6 +4862,15 @@
>> # @ac_refresh: since 2.10
>> # @ac_bookmarks: since 2.10
>> # altgr, altgr_r: dropped in 2.10
>> +# @f16: since 2.11
>> +# @f17: since 2.11
>> +# @f18: since 2.11
>> +# @f19: since 2.11
>> +# @f20: since 2.11
>> +# @f21: since 2.11
>> +# @f22: since 2.11
>> +# @f23: since 2.11
>> +# @f24: since 2.11
>> #
>> # Since: 1.3.0
>> #
>> @@ -4888,7 +4897,8 @@
>>             'audionext', 'audioprev', 'audiostop', 'audioplay', =
'audiomute',
>>             'volumeup', 'volumedown', 'mediaselect',
>>             'mail', 'calculator', 'computer',
>> -            'ac_home', 'ac_back', 'ac_forward', 'ac_refresh', =
'ac_bookmarks' ] }
>> +            'ac_home', 'ac_back', 'ac_forward', 'ac_refresh', =
'ac_bookmarks',
>> +            'f16', 'f17', 'f18', 'f19', 'f20', 'f21', 'f22', 'f23', =
'f24'] }
>>=20
>> ##
>> # @KeyValue:
>=20
> This bit looks fine.
>=20
>> diff --git a/ui/input-keymap.c b/ui/input-keymap.c
>> index cf979c2..c0413e1 100644
>> --- a/ui/input-keymap.c
>> +++ b/ui/input-keymap.c
>> @@ -251,6 +251,15 @@ static const int qcode_to_number[] =3D {
>>=20
>>     [Q_KEY_CODE_F11] =3D 0x57,
>>     [Q_KEY_CODE_F12] =3D 0x58,
>> +    [Q_KEY_CODE_F16] =3D 0x59,
>> +    [Q_KEY_CODE_F17] =3D 0x5a,
>> +    [Q_KEY_CODE_F18] =3D 0x5b,
>> +    [Q_KEY_CODE_F19] =3D 0x5c,
>> +    [Q_KEY_CODE_F20] =3D 0x5d,
>> +    [Q_KEY_CODE_F21] =3D 0x5e,
>> +    [Q_KEY_CODE_F22] =3D 0x5f,
>> +    [Q_KEY_CODE_F23] =3D 0x60,
>> +    [Q_KEY_CODE_F24] =3D 0x61,
>=20
> You've got a gap there F13, F14, F15 were all missing (pre-existing =
bug in
> QEMU), so you can't carry on just incrementing after F12.

Actually F13, F14,and F15 are called Q_KEY_CODE_PRINT, =
Q_KEY_CODE_SCROLL_LOCK, and Q_KEY_CODE_PAUSE respectively.

> Even if that were not the case, AT set1 scancodes are insane with no =
logical
> numbering scheme. So what we actually end up needing is
>=20
>    F13 =3D=3D  0x5d
>    F14 =3D=3D  0x5e
>    F15 =3D=3D  0x5f
>    F16 =3D=3D  0x55
>    F17 =3D=3D  0x83
>    F18 =3D=3D  0xf7
>    F19 =3D=3D  0x84
>    F20 =3D=3D  0x5a
>    F21 =3D=3D  0x74
>    F22 =3D=3D  0xf9
>    F23 =3D=3D  0x6d
>    F24 =3D=3D  0x6f

Ok. I can adapt this numbering scheme in my next patch. Thank you for =
reviewing this patch set.=20=
