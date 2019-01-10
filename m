Received: from eggs.gnu.org ([209.51.188.92]:38531)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ghcwx-0006sV-Az
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 11:12:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ghcww-0007uv-Ij
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 11:12:55 -0500
Received: from mail-yb1-f194.google.com ([209.85.219.194]:44612)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ghcww-0007te-F0
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 11:12:54 -0500
Received: by mail-yb1-f194.google.com with SMTP id e1so4619958ybn.11
	for <qemu-devel@nongnu.org>; Thu, 10 Jan 2019 08:12:54 -0800 (PST)
MIME-Version: 1.0
References: <20190109220942.23822-1-pbonzini@redhat.com>
	<CAFEAcA9v3v3k_cFZCwvD5WD4FmiuFT=0UAjCBHEwpO+LuQWjAw@mail.gmail.com>
	<CAAdtpL5cuJdVgfgoo1oNfEpTZFkybLRn5MWqLna7osTUT=MCbg@mail.gmail.com>
	<CAFEAcA9huyGyKeOfwX7ZKPc7620DaA6ZP7cUvNFmbxe4AB72fg@mail.gmail.com>
In-Reply-To: <CAFEAcA9huyGyKeOfwX7ZKPc7620DaA6ZP7cUvNFmbxe4AB72fg@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 10 Jan 2019 17:12:40 +0100
Message-ID: <CAAdtpL6VsQn1WKo9=a-UaRD_acn8a_XVA1R46YX+MCx9-89hHg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL v6 00/35] Misc patches for 2018-12-18
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>

On Thu, Jan 10, 2019 at 3:31 PM Peter Maydell <peter.maydell@linaro.org> wr=
ote:
> On Thu, 10 Jan 2019 at 14:27, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g> wrote:
> > Le jeu. 10 janv. 2019 15:21, Peter Maydell <peter.maydell@linaro.org> a=
 =C3=A9crit :
> >> ...'make check-tcg' fails:
>
> > This should work fine if you retry this PR after having merged
> > Fam's PR which contains the fix.
>
> Cool. I will do that and retry.
>
> >> This seems to happen reliably with this pullreq merged
> >> in, but master is OK.
> >
> >
> > I guess Travis is using a cached image.
>
> I'm not using travis, this is a local run of the test.
> But perhaps my system has a cached image. It seems a bit
> odd that it uses that cached image when testing master
> but not when testing Paolo's merge, though.

The patch "test: replace gtester with a TAP driver" contains docker
changes (adding libtest-harness-perl) which trigger a rebuild, your
builds using /master should use the cache.

This might be a problem with this new package (if so, Fam's PR isn't
going to help here).

I'll check and if possible improve the docker.py output to get a more
useful error message.

Regards,

Phil.
