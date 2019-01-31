Received: from eggs.gnu.org ([209.51.188.92]:54694)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gpANL-0008R4-8S
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 06:19:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gpANJ-0006QH-Ur
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 06:19:18 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:46235)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gpANJ-0006Nm-Ek
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 06:19:17 -0500
Received: by mail-ot1-x343.google.com with SMTP id w25so2419066otm.13
	for <qemu-devel@nongnu.org>; Thu, 31 Jan 2019 03:19:17 -0800 (PST)
MIME-Version: 1.0
References: <CAChFQ9RNaHyROB47QeLwc6cLCCnFx4SmXKV7rbs1MYjk7S0sbw@mail.gmail.com>
	<20190131104911.GF19982@redhat.com>
In-Reply-To: <20190131104911.GF19982@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 31 Jan 2019 11:19:04 +0000
Message-ID: <CAFEAcA_TYKmG+gfm1gUw-xjM3VFXUebCD22rGSPyBuZ9ugWVPQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] NSIS - including DLL dependencies for Windows
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Adam Baxter <voltagex@voltagex.org>, QEMU Developers <qemu-devel@nongnu.org>

On Thu, 31 Jan 2019 at 10:50, Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
 wrote:
>
> On Thu, Jan 31, 2019 at 02:45:13PM +1100, Adam Baxter wrote:
> > Hi,
> > How do I gather and include the required DLLs (SDL, zlib etc) in the NS=
IS
> > installer? (and also in a standalone build to be zipped up, but that's =
less
> > important)
> >
> > I noticed the wiki doesn't really mention bundling dependencies anywher=
e.
> >
> > The official unofficial windows builds are documented at
> > https://qemu.weilnetz.de/FAQ but this doesn't cover building the actual
> > installer.
>
> Yeah, this is a pretty major ommision in QEMU's build rules for the NSIS
> installer making it pretty much useless as is. We really need to expand
> it so that it can resolve the dlls that qemu .exe's need, locate them
> on the host and bundle them into the installer automatically.

I think my concern here potentially is a licensing one -- if we don't
actually ship installer binaries then that's fine for us, but an
installer script that automatically pulls in DLLs for glib and others
is a bit of a footgun for anybody that uses it since it will very likely
create an installer binary that is very difficult to ship to anybody
whilst remaining compliant with the licenses for our dependencies.

thanks
-- PMM
