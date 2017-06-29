Received: from eggs.gnu.org ([2001:4830:134:3::10]:43491)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dQV5e-0005e0-Em
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 04:46:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dQV5b-0006Gu-9u
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 04:46:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:2052)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dQV5b-0006GW-3K
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 04:46:15 -0400
References: <20170629010300.2848-1-f4bug@amsat.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <0e0d7ae6-5c1e-5c54-9d09-ef03e600b87e@redhat.com>
Date: Thu, 29 Jun 2017 10:46:08 +0200
MIME-Version: 1.0
In-Reply-To: <20170629010300.2848-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, "Emilio G . Cota" <cota@braap.org>, Stefan Weil <sw@weilnetz.de>, Peter Maydell <peter.maydell@linaro.org>

 Hi Philippe,

On 29.06.2017 03:02, Philippe Mathieu-Daud=C3=A9 wrote:
> There have been some comments on the ML about the usefulness of tci.
>=20
> https://lists.nongnu.org/archive/html/qemu-devel/2017-06/msg04551.html
>=20
>   Peter Maydell> I'd prefer we just got rid of it.
>=20
> https://lists.nongnu.org/archive/html/qemu-devel/2017-06/msg04296.html
>=20
>   Richard Henderson> Is it time to remove it? I'm pretty sure the only =
hosts
>                      for which it will work have proper backends...
>=20
> Richard quotes are way clearer than me trying to paraphrase what he tol=
d me:
> - it doesn't use libffi, and as such the way it makes calls to helpers =
doesn't work for many hosts.
> - we already cover almost everthing that debian does. if debian or gent=
oo doesn't support it, one can confidently say there's little interest.
> - if someone *does* want to run qemu on something else, it isn't diffic=
ult to port tcg.
>=20
> I figured out MAINTAINERS was unsync, so added patches 1-4, they are no=
t really
> tci-related.

Since they are not related to TCI at all, please submit these as
separate series.

> Patches 5,6 are trivial fixes to let the codebase quite sane if there i=
s future
> need to revert/reimport tci.

I think this should go into 2.10...

> Patches 7,8 are the removal, marked RFC... let's debate!

... but NACK for a direct removal. Common sense is to make obsolete
features as deprecated first and then wait for 2 public releases before
the final removal, so that users still have a chance to speak up in case
they still need the feature and are willing to maintain it.

Please see the following URL for details (and please also add an entry
for TCI in the Miscellaneous section there):

  http://wiki.qemu.org/Features/LegacyRemoval

 Thomas
