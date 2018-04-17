Received: from eggs.gnu.org ([2001:4830:134:3::10]:46231)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1f8QgE-0002qZ-GR
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 09:29:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1f8Qg9-0006xI-0S
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 09:29:54 -0400
Received: from mail-wr0-x22c.google.com ([2a00:1450:400c:c0c::22c]:43341)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1f8Qg8-0006wp-Ps
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 09:29:48 -0400
Received: by mail-wr0-x22c.google.com with SMTP id u4so4162639wrg.10
	for <qemu-devel@nongnu.org>; Tue, 17 Apr 2018 06:29:48 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <87k1t7sgka.fsf@dusky.pond.sub.org>
References: <20180413161842.5117-1-marcandre.lureau@redhat.com>
	<20180413161842.5117-5-marcandre.lureau@redhat.com>
	<87k1t7sgka.fsf@dusky.pond.sub.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 17 Apr 2018 15:29:47 +0200
Message-ID: <CAJ+F1C+hdK1hA=8kXTO=rQ7Ud8-NCkNnkb+1+bMZMT39tLiQQw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 4/4] qobject: modify qobject_ref() to
 assert on NULL and return obj
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, QEMU <qemu-devel@nongnu.org>

Hi

On Mon, Apr 16, 2018 at 10:26 AM, Markus Armbruster <armbru@redhat.com> wro=
te:
> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>
>> Following a discussion on the mailing list:
>
> If a reader of this commit message could profit from reading the
> discussion, refer to it by URL and/or Message-Id.  If not, don't mention
> it.
>
>>                                             while it may be convenient
>> to accept NULL value in qobject_unref() (for similar reasons as free()
>> accepts NULL), it is a probably a bad idea to accept NULL argument in
>> qobject_ref().
>
> Yes?  What's the patch doing about it?  Peeking ahead: it outlaws it.
> So say that.
>

ok, it's the patch title.

>> Furthermore,
>
> Commit message smell: two things in one patch.  Worth separating them?
>

ok

>>              it is convenient and more clear to call qobject_ref() at
>> the time when the reference is associated with a variable, or
>> argument. For this reason, make qobject_ref() return the same pointer
>> as given.
>
> Not 100% clear whether the patch merely makes the "convenient and more
> clear" way possible, or reality.  Peeking ahead: it's the latter.  So
> say that.
>
> How did you find the places to change?

manual review

> Do you think you got them all?

I think so

>
>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>



--=20
Marc-Andr=C3=A9 Lureau
