Received: from eggs.gnu.org ([2001:4830:134:3::10]:34729)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1eoEmV-0003z1-09
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 15:44:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1eoEmR-0001Xo-UL
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 15:44:55 -0500
Date: Tue, 20 Feb 2018 15:44:50 -0500
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20180220204450.GA27101@flamenco>
References: <cover.1519150239.git.balaton@eik.bme.hu>
	<CAFEAcA8UnMNoGbpx+Mhh8AT9MfOMuUZvMd139tGQFokTAWqWpA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA8UnMNoGbpx+Mhh8AT9MfOMuUZvMd139tGQFokTAWqWpA@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH 0/2] Firmware blob and git submodule for
 Sam460ex
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: BALATON Zoltan <balaton@eik.bme.hu>, Francois Revol <revol@free.fr>, qemu-ppc@nongnu.org, QEMU Developers <qemu-devel@nongnu.org>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>

On Tue, Feb 20, 2018 at 18:31:17 +0000, Peter Maydell wrote:
> On 20 February 2018 at 18:10, BALATON Zoltan <balaton@eik.bme.hu> wrote:
> > I've created a git repo for the Sam460ex u-boot sources and this adds
> > that as a submodule and a separate patch to add the binary built from
> > these sources. Feel free to keep this as two patches, squash them into
> > one patch or take the git repo and commit the content under the QEMU
> > repo and use that as a submodule as you see fit (or let me know if any
> > changes are needed for these patches).
> >
> > BALATON Zoltan (2):
> >   roms: Added git submodule for u-boot-sam460 (firmware for sam460ex)
> >   pc-bios: Added u-boot-sam460 firmware binary
> 
> We already have a submodule for u-boot. Is it not possible to
> build this bios blob from those upstream u-boot sources?

This is discussed in the following thread:
  Re: [Qemu-ppc] [PATCH v3 2/2] ppc: Add aCube Sam460ex board
  http://lists.gnu.org/archive/html/qemu-ppc/2018-02/msg00268.html

		Emilio
