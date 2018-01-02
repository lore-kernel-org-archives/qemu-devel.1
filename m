Received: from eggs.gnu.org ([2001:4830:134:3::10]:42565)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1eWOoY-0008S9-1S
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 10:49:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1eWOoX-0000Ss-7w
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 10:49:18 -0500
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:34584)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1eWOoX-0000SU-0O
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 10:49:17 -0500
Received: by mail-wr0-x242.google.com with SMTP id 36so15611031wrh.1
	for <qemu-devel@nongnu.org>; Tue, 02 Jan 2018 07:49:16 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <8d27589c-50a3-69b4-adca-f44f076057a8@redhat.com>
References: <20171215150659.1811-1-marcandre.lureau@redhat.com>
	<20171215150659.1811-3-marcandre.lureau@redhat.com>
	<8d27589c-50a3-69b4-adca-f44f076057a8@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 2 Jan 2018 16:49:15 +0100
Message-ID: <CAJ+F1C+z6Yx-z9PEKK6G3a_t+7+msApuiQMeB2WiVeGPWS0zDQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 02/13] build-sys: silence make by
 default or V=0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>

Hi

On Tue, Dec 19, 2017 at 5:35 PM, Eric Blake <eblake@redhat.com> wrote:
> On 12/15/2017 09:06 AM, Marc-Andr=C3=A9 Lureau wrote:
>>
>> Move generic make flags in MAKEFLAGS (SUBDIR_MAKEFLAGS is more qemu
>> specific).
>>
>> Use --quiet to silence make 'is up to date' message.
>>
>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> ---
>>   Makefile  | 2 +-
>>   rules.mak | 2 ++
>>   2 files changed, 3 insertions(+), 1 deletion(-)
>
>
> Tested-by: Eric Blake <eblake@redhat.com>
>
> I'd still like a second opinion from another make expert (Paolo?) on whet=
her
> this makes sense.  Thus, even though it looks sane to me, I'm not (yet)
> giving R-b.
>

Paolo, what do you think?

thanks

>>
>> diff --git a/Makefile b/Makefile
>> index 0331c182ed..199f39fde1 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -274,7 +274,7 @@ else
>>   DOCS=3D
>>   endif
>>   -SUBDIR_MAKEFLAGS=3D$(if $(V),,--no-print-directory)
>> BUILD_DIR=3D$(BUILD_DIR)
>> +SUBDIR_MAKEFLAGS=3DBUILD_DIR=3D$(BUILD_DIR)
>>   SUBDIR_DEVICES_MAK=3D$(patsubst %, %/config-devices.mak, $(TARGET_DIRS=
))
>>   SUBDIR_DEVICES_MAK_DEP=3D$(patsubst %, %-config-devices.mak.d,
>> $(TARGET_DIRS))
>>   diff --git a/rules.mak b/rules.mak
>> index 6e943335f3..5fb4951561 100644
>> --- a/rules.mak
>> +++ b/rules.mak
>> @@ -131,6 +131,8 @@ modules:
>>   # If called with only a single argument, will print nothing in quiet
>> mode.
>>   quiet-command =3D $(if $(V),$1,$(if $(2),@printf "  %-7s %s\n" $2 $3 &=
&
>> $1, @$1))
>>   +MAKEFLAGS +=3D $(if $(V),,--no-print-directory --quiet)
>> +
>>   # cc-option
>>   # Usage: CFLAGS+=3D$(call cc-option, -falign-functions=3D0,
>> -malign-functions=3D0)
>>
>
>
> --
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3266
> Virtualization:  qemu.org | libvirt.org
>



--=20
Marc-Andr=C3=A9 Lureau
