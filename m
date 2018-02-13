Received: from eggs.gnu.org ([2001:4830:134:3::10]:42780)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1eldTl-0004qw-Tx
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 11:30:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1eldTi-0006tb-7C
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 11:30:49 -0500
Received: from 4.mo68.mail-out.ovh.net ([46.105.59.63]:48685)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1eldTi-0006nX-0d
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 11:30:46 -0500
Received: from player711.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo68.mail-out.ovh.net (Postfix) with ESMTP id 8E44BC86FA
	for <qemu-devel@nongnu.org>; Tue, 13 Feb 2018 17:30:35 +0100 (CET)
Date: Tue, 13 Feb 2018 17:30:22 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20180213173022.25c0fd8b@bahia.lan>
In-Reply-To: <20180212161323.GC2545@work-vm>
References: <20180206191515.25830-1-mdroth@linux.vnet.ibm.com>
	<1fa746ad-7640-6159-26e3-b2fb378c68af@kamp.de>
	<20180212161323.GC2545@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-stable] [PATCH 00/54] Patch Round-up for
 stable 2.11.1, freeze on 2018-02-12
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Peter Lieven <pl@kamp.de>, qemu-stable@nongnu.org, christian.ehrhardt@canonical.com, qemu-devel@nongnu.org

On Mon, 12 Feb 2018 16:13:23 +0000
"Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:

> * Peter Lieven (pl@kamp.de) wrote:
> > Am 06.02.2018 um 20:14 schrieb Michael Roth:  
> > > Hi everyone,
> > > 
> > > The following new patches are queued for QEMU stable v2.11.1:
> > > 
> > >    https://github.com/mdroth/qemu/commits/stable-2.11-staging
> > > 
> > > The release is planned for 2017-02-14:
> > > 
> > >    https://wiki.qemu.org/Planning/2.11
> > > 
> > > Please respond here or CC qemu-stable@nongnu.org on any patches you
> > > think should be included in the release.
> > > 
> > > Of particular importance would be any feedback on the various QEMU
> > > patches relating to Spectre/Meltdown mitigation. The current tree has
> > > what I understand to be the QEMU components required for x86, s390,
> > > and pseries, but feedback/confirmation from the various authors would
> > > be greatly appreciated.  
> > 
> > Hi,
> > 
> > I also found the following patches that affect migration:
> > 
> > migration: Don't leak IO channels
> > migration: Recover block devices if failure in device state
> > migration/savevm.c: set MAX_VM_CMD_PACKAGED_SIZE to 1ul << 32
> > 
> > In general it seems that migration related patches are often not tagged qemu-stable.
> > David, can you check if there are patches missing?  
> 
> I'm always a bit cautious about forwarding stuff to stable; just because
> it's landed in our main branch it doesn't mean many people have tested
> it, so I'd rather wait unless it was particularly urgent.
> 
> The 'migration: Recover block devices if failure in device state' is
> probably a good candidate.
> Another one would be Greg Kurz's:
> 875fcd013ab68c64802998b22f54f0184479d21b - migration: incoming postcopy advise sanity checks
> 

Yeah. Mike pushed it to its stable-2.11-staging tree:

https://github.com/mdroth/qemu/commit/a3fd64f2fe9f90c7b4d002910a54049ee6a09b64

Cheers,

--
Greg

> Dave
> 
> > Thank you,
> > Peter
> >   
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> 
