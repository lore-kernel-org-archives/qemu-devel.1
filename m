Received: from eggs.gnu.org ([2001:4830:134:3::10]:53952)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1faMrI-0004Ac-7V
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 11:04:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1faMrH-0000mh-9W
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 11:04:48 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:38600)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1faMrH-0000m9-4H
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 11:04:47 -0400
Received: by mail-oi0-x241.google.com with SMTP id v8-v6so4441273oie.5
	for <qemu-devel@nongnu.org>; Tue, 03 Jul 2018 08:04:47 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180703055804.13449-1-david@gibson.dropbear.id.au>
References: <20180703055804.13449-1-david@gibson.dropbear.id.au>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 3 Jul 2018 16:04:25 +0100
Message-ID: <CAFEAcA87Fog9mMsUFNSjpyAv3naEO-RSCXu-75HMLynaWim6Ew@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 00/35] ppc-for-3.0 queue 20180703
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc <qemu-ppc@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Greg Kurz <groug@kaod.org>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, Alexander Graf <agraf@suse.de>, Michael Roth <mdroth@linux.vnet.ibm.com>, Alexey Kardashevskiy <aik@ozlabs.ru>

On 3 July 2018 at 06:57, David Gibson <david@gibson.dropbear.id.au> wrote:
> The following changes since commit ab08440a4ee09032d1a9cb22fdcab23bc7e1c6=
56:
>
>   Merge remote-tracking branch 'remotes/rth/tags/pull-tcg-20180702' into =
staging (2018-07-02 17:57:46 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/dgibson/qemu.git tags/ppc-for-3.0-20180703
>
> for you to fetch changes up to 29f9cef39eb1ae55e82c6763eb22d7a1bdff7276:
>
>   ppc: Include vga cirrus card into the compiling process (2018-07-03 11:=
23:09 +1000)
>
> ----------------------------------------------------------------
> ppc patch queue 2018-07-03
>
> Here's a last minue pull request before today's soft freeze.  Ideally
> I would have sent this earlier, but I was waiting for a couple of
> extra fixes I knew were close.  And the freeze crept up on me, like
> always.
>
> Most of the changes here are bugfixes in any case.  There are some
> cleanups as well, which have been in my staging tree for a little
> while.  There are a couple of truly new features (some extensions to
> the sam460ex platform), but these are low risk, since they only affect
> a new and not really stabilized machine type anyway.
>
> Higlights are:
>   * Mac platform improvements from Mark Cave-Ayland
>   * Sam460ex improvements from BALATON Zoltan et al.
>   * XICS interrupt handler cleanups from C=C3=A9dric Le Goater
>   * TCG improvements for atomic loads and stores from Richard
>     Henderson
>   * Assorted other bugfixes
>

Applied, thanks.

-- PMM
