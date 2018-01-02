Received: from eggs.gnu.org ([2001:4830:134:3::10]:33084)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1eWQpS-0004rV-3C
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 12:58:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1eWQpR-0001iR-Gz
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 12:58:22 -0500
Received: from mail-wm0-x229.google.com ([2a00:1450:400c:c09::229]:36452)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1eWQpR-0001hi-8X
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 12:58:21 -0500
Received: by mail-wm0-x229.google.com with SMTP id b76so62439665wmg.1
	for <qemu-devel@nongnu.org>; Tue, 02 Jan 2018 09:58:21 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <e20b8ff4-0f3e-ea6a-892a-0f4bf3cc0f84@redhat.com>
References: <20171215150659.1811-1-marcandre.lureau@redhat.com>
	<20171215150659.1811-3-marcandre.lureau@redhat.com>
	<8d27589c-50a3-69b4-adca-f44f076057a8@redhat.com>
	<CAJ+F1C+z6Yx-z9PEKK6G3a_t+7+msApuiQMeB2WiVeGPWS0zDQ@mail.gmail.com>
	<e20b8ff4-0f3e-ea6a-892a-0f4bf3cc0f84@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 2 Jan 2018 18:58:19 +0100
Message-ID: <CAJ+F1CKGqayKqZZAfLsXJR0zK87KtvNhRMF6MpvjsHMHZTFmcQ@mail.gmail.com>
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
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, QEMU <qemu-devel@nongnu.org>

On Tue, Jan 2, 2018 at 6:33 PM, Paolo Bonzini <pbonzini@redhat.com> wrote:
> On 02/01/2018 16:49, Marc-Andr=C3=A9 Lureau wrote:
>> Hi
>>
>> On Tue, Dec 19, 2017 at 5:35 PM, Eric Blake <eblake@redhat.com> wrote:
>>> On 12/15/2017 09:06 AM, Marc-Andr=C3=A9 Lureau wrote:
>>>>
>>>> Move generic make flags in MAKEFLAGS (SUBDIR_MAKEFLAGS is more qemu
>>>> specific).
>>>>
>>>> Use --quiet to silence make 'is up to date' message.
>>>>
>>>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>>>> ---
>>>>   Makefile  | 2 +-
>>>>   rules.mak | 2 ++
>>>>   2 files changed, 3 insertions(+), 1 deletion(-)
>>>
>>>
>>> Tested-by: Eric Blake <eblake@redhat.com>
>>>
>>> I'd still like a second opinion from another make expert (Paolo?) on wh=
ether
>>> this makes sense.  Thus, even though it looks sane to me, I'm not (yet)
>>> giving R-b.
>>>
>>
>> Paolo, what do you think?
>
> Sounds good to me.

Thanks, I assume I can add your review-by to the patch.


--=20
Marc-Andr=C3=A9 Lureau
