Received: from eggs.gnu.org ([209.51.188.92]:35277)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gzLfQ-00073o-8w
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 08:24:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gzLfO-0004fv-CA
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 08:24:04 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:37430)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gzLfK-0004di-8x
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 08:23:59 -0500
Received: by mail-ot1-x343.google.com with SMTP id b3so17603452otp.4
	for <qemu-devel@nongnu.org>; Thu, 28 Feb 2019 05:23:51 -0800 (PST)
MIME-Version: 1.0
References: <CAFEAcA_-wNGz_ftDziARUwzL2Lc+1kkoMTo0OxV4UVwbTr8EaQ@mail.gmail.com>
	<9b211327-06a8-9739-e984-4b05557c12b4@suse.de>
	<20190104050301.GB2801@umbus.fritz.box>
In-Reply-To: <20190104050301.GB2801@umbus.fritz.box>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 28 Feb 2019 13:23:38 +0000
Message-ID: <CAFEAcA9fyHiKOA7bDr8c_05C6rX_CYdj8nP+xFFSH_4uWbokhQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] can we update QEMU's version of u-boot.e500 ?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Alexander Graf <agraf@suse.de>, QEMU Developers <qemu-devel@nongnu.org>

On Fri, 4 Jan 2019 at 05:22, David Gibson <david@gibson.dropbear.id.au> wrote:
>
> On Fri, Jan 04, 2019 at 12:44:59AM +0100, Alexander Graf wrote:
> >
> >
> > On 03.01.19 18:38, Peter Maydell wrote:
> > > Hi; currently we ship with a u-boot.e500 which is from u-boot
> > > v2017.07. It would be nice to move that forward, specifically
> > > to at least v2017.11, which contains upstream u-boot's part of the
> > > fix for https://bugs.launchpad.net/qemu/+bug/1714750 .
> > > (There are more recent releases than that; it's just the first
> > > that contains the fix.)
> > >
> > > Then we could remove the workaround in scripts/make-release and
> > > close out the bug.
> > >
> > > I've cc'd David as the current maintainer of pc-bios/u-boot.e500
> > > and Alex as the last person who did an update.
> >
> > I think it's a great idea to update it.
> >
> > David, do you want to do that or rather have me send a patch?
>
> Please send a patch.
>
> I'm maintainer of all the ppc boards by default, but I really don't
> know anything much about e500 or u-boot.

Hi -- any progress on this ? It would be nice to update the u-boot
blob before QEMU hits softfreeze for the next release in a
couple of weeks...

thanks
-- PMM
