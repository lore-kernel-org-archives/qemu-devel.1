Received: from eggs.gnu.org ([2001:4830:134:3::10]:53115)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Paul.Burton@mips.com>) id 1fTsJa-0005UK-2Y
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 13:15:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Paul.Burton@mips.com>) id 1fTsJV-0006V4-Qd
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 13:15:10 -0400
Received: from 9pmail.ess.barracuda.com ([64.235.150.225]:48176)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Paul.Burton@mips.com>)
	id 1fTsJV-0006D1-KX
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 13:15:05 -0400
Date: Fri, 15 Jun 2018 10:14:38 -0700
From: Paul Burton <paul.burton@mips.com>
Message-ID: <20180615171438.zrkv3xnciua6o24d@pburton-laptop>
References: <20180604110358.2821-1-peter.maydell@linaro.org>
	<CAFEAcA9m8Q0KSHDBFv_AhTv+R6T1w+6A9Ux65M1aFXR6cM6Abg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAFEAcA9m8Q0KSHDBFv_AhTv+R6T1w+6A9Ux65M1aFXR6cM6Abg@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH 0/2] mips boston/malta: don't have
 nomigrate RAM regions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Juan Quintela <quintela@redhat.com>, "patches@linaro.org" <patches@linaro.org>, "Dr. David
	Alan Gilbert" <dgilbert@redhat.com>, =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>, Yongbok Kim <yongbok.kim@mips.com>, Aurelien Jarno <aurelien@aurel32.net>

Hi Peter,

On Fri, Jun 15, 2018 at 11:08:11AM +0100, Peter Maydell wrote:
> On 4 June 2018 at 12:03, Peter Maydell <peter.maydell@linaro.org> wrote:
> > This patchset fixes a a bug in the MIPS boston and malta boards:
> > they currently use memory_region_init_rom_nomigrate() to create
> > memory regions for their BIOS/flash, and they don't manually
> > register the MR with vmstate_register_ram() either. This currently
> > means that its contents are migrated, but as a RAM block whose
> > name is the empty string; in future (when a patch which is currently
> > in the outstanding migration tree pull request hits master) it
> > will mean they are not migrated at all. Switch to using
> > memory_region_init_ram() instead, so the memory contents are
> > migrated with a reasonable name.
> >
> > Note that this is a cross-version migration compatibility break
> > for both machines, but:
> >  (a) migration will break anyway due to the "don't migrate
> >      unnamed RAM blocks" patch
> >  (b) neither machine is versioned, so we don't really care about
> >      maintaining cross-version migration compatibility AFAIK
> 
> Any comment from the MIPS maintainers?
> 
> thanks
> -- PMM

FWIW, this looks fine to me for both Boston & Malta:

    Reviewed-by: Paul Burton <paul.burton@mips.com>

Thanks,
    Paul
