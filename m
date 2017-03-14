Received: from eggs.gnu.org ([2001:4830:134:3::10]:55914)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cnjfP-0007JV-Of
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 06:27:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cnjfM-0000l2-Hz
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 06:26:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54296)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cnjfM-0000kZ-Bg
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 06:26:56 -0400
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 575583B731
	for <qemu-devel@nongnu.org>; Tue, 14 Mar 2017 10:26:56 +0000 (UTC)
Date: Tue, 14 Mar 2017 10:26:52 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170314102652.GC2652@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170313124434.1043-1-quintela@redhat.com>
	<20170314102142.GC2445@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170314102142.GC2445@work-vm>
Subject: Re: [Qemu-devel] [PATCH 00/16] Multifd v4
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org

On Tue, Mar 14, 2017 at 10:21:43AM +0000, Dr. David Alan Gilbert wrote:
> * Juan Quintela (quintela@redhat.com) wrote:
> > Hi
> > 
> > This is the 4th version of multifd. Changes:
> > - XBZRLE don't need to be checked for
> > - Documentation and defaults are consistent
> > - split socketArgs
> > - use iovec instead of creating something similar.
> > - We use now the exported size of target page (another HACK removal)
> > - created qio_chanel_{wirtev,readv}_all functions.  the _full() name
> >   was already taken.
> >   What they do is the same that the without _all() function, but if it
> >   returns due to blocking it redo the call.
> > - it is checkpatch.pl clean now.
> > 
> > Please comment, Juan.
> 
> High level things,
>   a) I think you probably need to do some bandwidth measurements to show
>     that multifd is managing to have some benefit - it would be good
>     for the cover letter.

multi-fd will certainly benefit encrypted migration, since we'll be able
to burn multiple CPUs for AES instead of bottlenecking on one CPU, and
thus able to take greater advantage of networks with > 1-GigE bandwidth.

Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
