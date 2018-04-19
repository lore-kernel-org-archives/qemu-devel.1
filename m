Received: from eggs.gnu.org ([2001:4830:134:3::10]:53721)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1f982y-0008EI-1B
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 07:48:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1f982x-0003jO-AZ
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 07:48:16 -0400
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:35633)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1f982x-0003io-3r
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 07:48:15 -0400
Received: by mail-wr0-x244.google.com with SMTP id w3-v6so13222278wrg.2
	for <qemu-devel@nongnu.org>; Thu, 19 Apr 2018 04:48:14 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAJ+F1CLAh8kg6YH1jZPBy1Ec+A4bQP-05yo9BqKqdyqEWL-e+A@mail.gmail.com>
References: <20180417133602.23832-1-marcandre.lureau@redhat.com>
	<87r2nbwv9j.fsf@dusky.pond.sub.org>
	<CAJ+F1CLAh8kg6YH1jZPBy1Ec+A4bQP-05yo9BqKqdyqEWL-e+A@mail.gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 19 Apr 2018 13:48:12 +0200
Message-ID: <CAJ+F1CJ3Ok335xo+LSoBMmMF1D+BRuaQLJuO3Zp0pR8_r5YABw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 0/5] Simplify qobject refcount
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

On Thu, Apr 19, 2018 at 12:09 PM, Marc-Andr=C3=A9 Lureau
<marcandre.lureau@gmail.com> wrote:
>> On the one hand, we provide safe conversion macros QOBJECT() and
>> qobject_to().  By the way, shouting one but not the other is a bit ugly.
>
> QOBJECT is static upcast, the compiler will shout.
> qobject_to() is dynamic downcast, the runtime shout.

Actually it doesn't shout, it merely tries and return NULL if it can't
do it. So I understand what you mean now. So it's a balance, but so
far, it seems those 2 fit our needs.

> I don't like to spent too much time on this, yet as you said, this is
> a lovely improvement, so is there any real blocker left?

I'll try to address your comments from v5 patches and send a v6.


--=20
Marc-Andr=C3=A9 Lureau
