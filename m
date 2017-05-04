Received: from eggs.gnu.org ([2001:4830:134:3::10]:36682)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1d6GFb-00076g-Du
	for qemu-devel@nongnu.org; Thu, 04 May 2017 08:52:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1d6GFX-0005P8-2T
	for qemu-devel@nongnu.org; Thu, 04 May 2017 08:52:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46838)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kchamart@redhat.com>) id 1d6GFW-0005OV-Rw
	for qemu-devel@nongnu.org; Thu, 04 May 2017 08:52:50 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BC9113DBC5
	for <qemu-devel@nongnu.org>; Thu,  4 May 2017 12:52:49 +0000 (UTC)
Date: Thu, 4 May 2017 14:52:46 +0200
From: Kashyap Chamarthy <kchamart@redhat.com>
Message-ID: <20170504125246.mfkghiglgpj4qoix@eukaryote>
References: <20170503104257.5127-1-dgilbert@redhat.com>
	<20170504100853.umbq3zaxqbbrbsw2@eukaryote>
	<20170504102523.GB2078@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170504102523.GB2078@work-vm>
Subject: Re: [Qemu-devel] [PATCH] block migration: Allow compile time disable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, quintela@redhat.com, jcody@redhat.com, kwolf@redhat.com

On Thu, May 04, 2017 at 11:25:25AM +0100, Dr. David Alan Gilbert wrote:
> * Kashyap Chamarthy (kchamart@redhat.com) wrote:
> > On Wed, May 03, 2017 at 11:42:57AM +0100, Dr. David Alan Gilbert (git) wrote:

[...]

> > > +#ifndef CONFIG_LIVE_BLOCK_MIGRATION
> > > +    if (params.blk || params.shared) {
> > > +        error_setg(errp, "QEMU compiled without old-style block migration. "
> > > +                         "Use drive_mirror+NBD.");
> > 
> > Is it worth spelling out briefly what the "old-style block
> > migration" is?  Something like:
> > 
> >     "QEMU compiled without old-style (i.e. QMP `migrate` with
> >     "inc":true) block migration. Use `drive-mirror`+NBD")
> >  
> > But I also wonder if it's needlessly wordy, so your call to
> > incorporate it or not.
> 
> I was trying to find a short way to say it, and that's the closest I
> got to.

Fair enough.

> > I spelled out the QMP equivalent (as opposed to HMP: 'migrate -b')
> > because, that's what users of higher layers (libvirt, OpenStack etc)
> > see in their QMP interactions with QEMU, when the old-style approach
> > is used:
> > 
> >     {"execute":"migrate","arguments":{{"detach":true,"blk":false,"inc":true,"uri":"fd:migrate"}
> 
> But would openstack users even know about QMP?

No, they're not expected to know of it.  Only developers digging into
Nova Vir driver issues that trickle down to QEMU normally know about it.

-- 
/kashyap
