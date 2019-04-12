Received: from eggs.gnu.org ([209.51.188.92]:60098)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hEukD-0001ls-HZ
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 07:53:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hEukC-0007uY-GR
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 07:53:21 -0400
Received: from mail-oi1-x229.google.com ([2607:f8b0:4864:20::229]:36182)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hEukB-0007tz-Px
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 07:53:20 -0400
Received: by mail-oi1-x229.google.com with SMTP id l203so7711565oia.3
	for <qemu-devel@nongnu.org>; Fri, 12 Apr 2019 04:53:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190412112044.15361-1-david@gibson.dropbear.id.au>
In-Reply-To: <20190412112044.15361-1-david@gibson.dropbear.id.au>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 12 Apr 2019 12:53:07 +0100
Message-ID: <CAFEAcA8VEM=brDF-U=8-5sEPhmcjX2vPy7tBJuMSqviVXbAetg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/1] ppc-for-4.0 queue 20190412
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-ppc <qemu-ppc@nongnu.org>, Greg Kurz <groug@kaod.org>, Laurent Vivier <lvivier@redhat.com>, spopovyc@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, clg@redhat.com

On Fri, 12 Apr 2019 at 12:20, David Gibson <david@gibson.dropbear.id.au> wrote:
>
> The following changes since commit 532cc6da74ec25b5ba6893b5757c977d54582949:
>
>   Update version for v4.0.0-rc3 release (2019-04-10 15:38:59 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/dgibson/qemu.git tags/ppc-for-4.0-20190412
>
> for you to fetch changes up to 4560116e42a21989a4b6cf9551ce2f90b16c7238:
>
>   spapr_pci: Fix broken naming of PCI bus (2019-04-12 12:23:02 +1000)
>
> ----------------------------------------------------------------
> ppc patch queue for 2018-04-12
>
> Here's a last minute pull request for 4.0.  Turns out my last pull
> request, to fix a regression in extended config space access for the
> pseries machine didn't fix things hard enough.  This PR has a single
> patch which improves the fix to work in more cases.
>
> It's a ghastly, ghastly hack, but it's simple and localized.  I
> already have patches almost ready to go in 4.1 that provides a simpler
> and cleaner solution to all this.
>
> ----------------------------------------------------------------

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.0
for any user-visible changes.

-- PMM
