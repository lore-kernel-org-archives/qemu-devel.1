Received: from eggs.gnu.org ([2001:4830:134:3::10]:35072)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eWQtW-0006L7-U3
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 13:02:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eWQtT-0004Oq-Kq
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 13:02:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52440)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eWQtT-0004OS-FR
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 13:02:31 -0500
References: <20171215150659.1811-1-marcandre.lureau@redhat.com>
	<20171215150659.1811-3-marcandre.lureau@redhat.com>
	<8d27589c-50a3-69b4-adca-f44f076057a8@redhat.com>
	<CAJ+F1C+z6Yx-z9PEKK6G3a_t+7+msApuiQMeB2WiVeGPWS0zDQ@mail.gmail.com>
	<e20b8ff4-0f3e-ea6a-892a-0f4bf3cc0f84@redhat.com>
	<CAJ+F1CKGqayKqZZAfLsXJR0zK87KtvNhRMF6MpvjsHMHZTFmcQ@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <7781eadc-4d94-4311-b312-454571a20305@redhat.com>
Date: Tue, 2 Jan 2018 19:02:27 +0100
MIME-Version: 1.0
In-Reply-To: <CAJ+F1CKGqayKqZZAfLsXJR0zK87KtvNhRMF6MpvjsHMHZTFmcQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>
Cc: Eric Blake <eblake@redhat.com>, QEMU <qemu-devel@nongnu.org>

On 02/01/2018 18:58, Marc-Andr=C3=A9 Lureau wrote:
> On Tue, Jan 2, 2018 at 6:33 PM, Paolo Bonzini <pbonzini@redhat.com> wro=
te:
>> On 02/01/2018 16:49, Marc-Andr=C3=A9 Lureau wrote:
>>> Hi
>>>
>>> On Tue, Dec 19, 2017 at 5:35 PM, Eric Blake <eblake@redhat.com> wrote=
:
>>>> On 12/15/2017 09:06 AM, Marc-Andr=C3=A9 Lureau wrote:
>>>>>
>>>>> Move generic make flags in MAKEFLAGS (SUBDIR_MAKEFLAGS is more qemu
>>>>> specific).
>>>>>
>>>>> Use --quiet to silence make 'is up to date' message.
>>>>>
>>>>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>>>>> ---
>>>>>   Makefile  | 2 +-
>>>>>   rules.mak | 2 ++
>>>>>   2 files changed, 3 insertions(+), 1 deletion(-)
>>>>
>>>>
>>>> Tested-by: Eric Blake <eblake@redhat.com>
>>>>
>>>> I'd still like a second opinion from another make expert (Paolo?) on=
 whether
>>>> this makes sense.  Thus, even though it looks sane to me, I'm not (y=
et)
>>>> giving R-b.
>>>>
>>>
>>> Paolo, what do you think?
>>
>> Sounds good to me.
>=20
> Thanks, I assume I can add your review-by to the patch.

More like Acked-by, I didn't review it closely.

Paolo
