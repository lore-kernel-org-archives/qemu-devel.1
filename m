Received: from eggs.gnu.org ([209.51.188.92]:55584)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1h3Noo-0006HH-TR
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 12:30:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1h3Nok-0000Ys-A6
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 12:30:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47278)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1h3Noi-0000UW-CQ
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 12:30:20 -0400
References: <3246431b-8d6e-f2bc-e0f0-99d80384d97b@redhat.com>
	<9fb589af-a78e-6eeb-ca1c-a5049c5ac5ab@redhat.com>
	<CAFEAcA_RQU+HYczN4Z=vEL8U31---GTi_HOxg8y50pzX8p+p7Q@mail.gmail.com>
	<877ed6x0ha.fsf@dusky.pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <885fd5a3-918e-67cc-9603-19736bfcdd3a@redhat.com>
Date: Mon, 11 Mar 2019 17:30:09 +0100
MIME-Version: 1.0
In-Reply-To: <877ed6x0ha.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] converting build system to Meson?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, Richard Henderson <rth@twiddle.net>, qemu-devel <qemu-devel@nongnu.org>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>

On 10/03/19 15:33, Markus Armbruster wrote:
>>  * is not particularly hard to deal with for the common cases
>>    ("add new source file" is straightforward)
>>  * covers all our requirements as far as I'm aware
>>    (whereas you've listed a couple of places where Meson
>>    would need changes/extensions to support things we do already)
>>  * is generally flexible enough to be hackable to deal with odd
>>    cases (it has escape mechanisms to generic-programmability,
>>    even if they're ugly and awkward)
>=20
> Yes, it's hackable, but it takes quite a hacker to hack it.  While it's
> reasonably easy to do simple things in it with basic voodoo skills, the
> learning curve goes up like the Zimbabwean inflation rate after that.  =
I
> got plenty of experience in Make, and consider myself pretty fluent, ye=
t
> I find myself running to Paolo for help.

The build system should make it trivial to do trivial things; easy to do
things that are a matter of cut-and-paste from something that already
exist; possible to do everything else.

We are good at the first and barely acceptable at the second.  The third
depends on your definition of possible and on the effort you want to put =
in.

My hope with a switch to Meson would be to keep the first just as
trivial as it is now (commas and quotes do add visual weight but do not
make things any less trivial; they are a nuisance but not a blocker);
make the second easier; make the third hopefully much easier and at
least more predictable.

There is a possibility that sooner or later we'll find out something
else that requires more Meson patches.  Our build system is already
quite mature, so that's at least not too likely, but it's obviously
impossible to rule it out definitively.

Paolo
