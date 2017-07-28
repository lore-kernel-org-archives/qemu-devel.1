Received: from eggs.gnu.org ([2001:4830:134:3::10]:34263)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1dav8J-00043I-Tt
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 22:36:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1dav8G-00062N-RZ
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 22:36:07 -0400
Received: from mail-it0-x241.google.com ([2607:f8b0:4001:c0b::241]:38136)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1dav8G-00061z-MU
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 22:36:04 -0400
Received: by mail-it0-x241.google.com with SMTP id h199so9778695ith.5
	for <qemu-devel@nongnu.org>; Thu, 27 Jul 2017 19:36:04 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
From: Programmingkid <programmingkidx@gmail.com>
In-Reply-To: <20170727145448.GV2555@redhat.com>
Date: Thu, 27 Jul 2017 22:36:02 -0400
Content-Transfer-Encoding: quoted-printable
Message-Id: <6FD43B48-E475-422A-A7F9-38B5589D051B@gmail.com>
References: <1920BE03-56F6-4E44-B9D2-0638A86FACB2@gmail.com>
	<20170727145448.GV2555@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/2] Add more function keys to QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, "qemu-devel@nongnu.org qemu-devel" <qemu-devel@nongnu.org>


> On Jul 27, 2017, at 10:54 AM, Daniel P. Berrange <berrange@redhat.com> =
wrote:
>=20
> On Thu, Jul 27, 2017 at 10:51:33AM -0400, Programmingkid wrote:
>> There are now keyboards that have 19 function keys. This patch =
extends
>> QEMU so these function keys can be used.=20
>>=20
>> Signed-off-by: John Arbuckle <programmingkidx@gmail.com>
>> ---
>> qapi-schema.json  | 6 +++++-
>> ui/input-keymap.c | 4 ++++
>> 2 files changed, 9 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/qapi-schema.json b/qapi-schema.json
>> index 9c6c3e1..a051820 100644
>> --- a/qapi-schema.json
>> +++ b/qapi-schema.json
>> @@ -4842,6 +4842,10 @@
>> # @hiragana: since 2.9
>> # @henkan: since 2.9
>> # @yen: since 2.9
>> +# @f16: since 2.10
>> +# @f17: since 2.10
>> +# @f18: since 2.10
>> +# @f19: since 2.10
>> #
>> # Since: 1.3.0
>> #
>> @@ -4864,7 +4868,7 @@
>>             'props', 'undo', 'front', 'copy', 'open', 'paste', =
'find', 'cut',
>>             'lf', 'help', 'meta_l', 'meta_r', 'compose', 'pause',
>>             'ro', 'hiragana', 'henkan', 'yen',
>> -            'kp_comma', 'kp_equals', 'power' ] }
>> +            'kp_comma', 'kp_equals', 'power', 'f16', 'f17', 'f18', =
'f19'] }
>=20
> Linux and AT set 1 go all the way to F24, and OS-X goes to F20, so =
don't
> arbitrarily stop short at F19
>=20
> Regards,
> Daniel

I think I will future-proof this patch by going all the way to F30.=20=
