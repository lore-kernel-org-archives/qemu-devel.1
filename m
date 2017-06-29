Received: from eggs.gnu.org ([2001:4830:134:3::10]:42131)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1dQcZO-0000Cz-FJ
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 12:45:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1dQcZK-0000QA-FI
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 12:45:30 -0400
Received: from mail.weilnetz.de ([37.120.169.71]:36862
	helo=v2201612906741603.powersrv.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sw@weilnetz.de>) id 1dQcZK-0000Pq-8a
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 12:45:26 -0400
References: <20170629010300.2848-1-f4bug@amsat.org>
	<0e0d7ae6-5c1e-5c54-9d09-ef03e600b87e@redhat.com>
	<98d49899-a2d8-8ecc-70ac-becc5252ae32@redhat.com>
	<dd63346e-e200-c2d1-c109-78dc57fcffc7@redhat.com>
	<db5c43ba-10b1-9fce-30e6-c40368ecc46c@redhat.com>
From: Stefan Weil <sw@weilnetz.de>
Message-ID: <4810736b-7bf7-9494-c1a7-73f246b86cc4@weilnetz.de>
Date: Thu, 29 Jun 2017 18:45:24 +0200
MIME-Version: 1.0
In-Reply-To: <db5c43ba-10b1-9fce-30e6-c40368ecc46c@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 0/8] removal of tci (tcg interpreter)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, "Emilio G . Cota" <cota@braap.org>, Peter Maydell <peter.maydell@linaro.org>

Am 29.06.2017 um 17:47 schrieb Paolo Bonzini:
>=20
>=20
> On 29/06/2017 17:46, Thomas Huth wrote:
>>> TCI is enabled only with a specific configure argument if your machin=
e
>>> is not supported by TCG.  This would break _build_ configurations, no=
t
>>> user configurations.  It's a remote possibility that users are buildi=
ng
>>> their own QEMU, with TCI enabled, to work around a TCG bug.  So we ca=
n
>>> be more speedy in removing the code.
>> You never know ... it's unlikely, but there might be people around who
>> run configure with "--enable-tcg-interpreter" on purpose.
>=20
> And they have never reported a bug? :)  But I agree it's not a big deal=
.
>  Richard should decide.
>=20
> Paolo

Was there a bug? I'm not aware of one.

The TODO assertions were added on purpose when I wrote the code:

Initially all TCG codes had it, and I removed them as soon as a
statement was executed and I had verified the result.

So the recently failing assertions are simply code which was
not triggered before, maybe because earlier versions of QEMU
did not use those cases or maybe because a new guest scenario
now needs them while my tests did not.

TCI was never meant to be used for production, so I think
my approach was acceptable.

Stefan
