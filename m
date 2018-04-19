Received: from eggs.gnu.org ([2001:4830:134:3::10]:43343)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1f99O3-0007g1-0a
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 09:14:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1f99Nx-0002Pf-Dk
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 09:14:06 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53862 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1f99Nx-0002Oy-9C
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 09:14:01 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180417133602.23832-1-marcandre.lureau@redhat.com>
	<87r2nbwv9j.fsf@dusky.pond.sub.org>
	<CAJ+F1CLAh8kg6YH1jZPBy1Ec+A4bQP-05yo9BqKqdyqEWL-e+A@mail.gmail.com>
	<CAJ+F1CJ3Ok335xo+LSoBMmMF1D+BRuaQLJuO3Zp0pR8_r5YABw@mail.gmail.com>
Date: Thu, 19 Apr 2018 15:13:59 +0200
In-Reply-To: <CAJ+F1CJ3Ok335xo+LSoBMmMF1D+BRuaQLJuO3Zp0pR8_r5YABw@mail.gmail.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Thu, 19 Apr 2018
	13:48:12 +0200")
Message-ID: <8736zr5ofc.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, QEMU <qemu-devel@nongnu.org>

Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> writes:

> Hi
>
> On Thu, Apr 19, 2018 at 12:09 PM, Marc-Andr=C3=A9 Lureau
> <marcandre.lureau@gmail.com> wrote:
>>> On the one hand, we provide safe conversion macros QOBJECT() and
>>> qobject_to().  By the way, shouting one but not the other is a bit ugly.
>>
>> QOBJECT is static upcast, the compiler will shout.
>> qobject_to() is dynamic downcast, the runtime shout.
>
> Actually it doesn't shout, it merely tries and return NULL if it can't
> do it. So I understand what you mean now. So it's a balance, but so
> far, it seems those 2 fit our needs.

Misunderstanding?  By "shouting", I meant spelling all-caps.

The convention to shout macros makes sense because you generally need to
know when something's a macro.  In cases where you don't need to know,
it's okay not to shout.

>> I don't like to spent too much time on this, yet as you said, this is
>> a lovely improvement, so is there any real blocker left?
>
> I'll try to address your comments from v5 patches and send a v6.

Thanks!
