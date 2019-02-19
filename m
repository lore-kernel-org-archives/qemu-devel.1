Received: from eggs.gnu.org ([209.51.188.92]:38654)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gw1qh-0005ki-KB
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 04:38:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gw1qg-0002cd-Iw
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 04:37:59 -0500
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335]:45817)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gw1qf-0002b3-Od
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 04:37:58 -0500
Received: by mail-ot1-x335.google.com with SMTP id 32so33019473ota.12
	for <qemu-devel@nongnu.org>; Tue, 19 Feb 2019 01:37:57 -0800 (PST)
MIME-Version: 1.0
References: <20190218143049.17142-1-david@gibson.dropbear.id.au>
In-Reply-To: <20190218143049.17142-1-david@gibson.dropbear.id.au>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 19 Feb 2019 09:37:44 +0000
Message-ID: <CAFEAcA9ZhMtkh+2CXYjsbYhj69iGgQzBwT2TFOriPgvDbOaPpw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 00/43] ppc-for-4.0 queue 20190219
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Greg Kurz <groug@kaod.org>, QEMU Developers <qemu-devel@nongnu.org>, qemu-ppc <qemu-ppc@nongnu.org>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>

On Mon, 18 Feb 2019 at 14:30, David Gibson <david@gibson.dropbear.id.au> wr=
ote:
>
> The following changes since commit 1e36232994c8ad01774501d2e299deba3a2469=
af:
>
>   Merge remote-tracking branch 'remotes/mcayland/tags/qemu-openbios-20190=
215' into staging (2019-02-15 11:12:14 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/dgibson/qemu.git tags/ppc-for-4.0-20190219
>
> for you to fetch changes up to 73e14c6a9cdefb94c01ea488f04e7fba7ac0dc5b:
>
>   target/ppc: convert vmin* and vmax* to vector operations (2019-02-18 11=
:00:44 +1100)
>
> ----------------------------------------------------------------
> ppc patch queue 2019-02-19
>
> Here's the next batch of ppc and spapr patches.  Higlights are:
>
>  * A bunch of improvements to TCG handling of vector instructions from
>    Richard Henderson and Marc Cave-Ayland
>
>  * Cleanup to the XICS interrupt controller from Greg Kurz, removing
>    the special KVM subclasses which were a bad idea
>
>  * Some refinements to the XIVE interrupt controller from C=C3=A9dric Le
>    Goater
>
>  * Fix from Fabiano Rosas for a really dumb buffer overflow in the
>    device tree code for memory hotplug
>
>  * Code for allowing access to SPRs from the gdb stub from Fabiano
>    Rosas
>
>  * Assorted minor fixes and cleanups
>

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.0
for any user-visible changes.

^^^ I notice the PowerPC section of the changelog is still pretty bare...

-- PMM
