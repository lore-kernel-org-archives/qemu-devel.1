Received: from eggs.gnu.org ([2001:4830:134:3::10]:58942)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dFiR6-0003x4-H0
	for qemu-devel@nongnu.org; Tue, 30 May 2017 10:47:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dFiR3-0006GK-UK
	for qemu-devel@nongnu.org; Tue, 30 May 2017 10:47:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50064)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dFiR3-0006Fj-Nx
	for qemu-devel@nongnu.org; Tue, 30 May 2017 10:47:49 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id AA12A3DBC4
	for <qemu-devel@nongnu.org>; Tue, 30 May 2017 14:47:48 +0000 (UTC)
Date: Tue, 30 May 2017 15:47:42 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170530144742.GI2120@work-vm>
References: <20170524112152.23226-1-quintela@redhat.com>
	<20170524112412.GK3873@pxdev.xzpeter.org>
	<87wp965w1g.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87wp965w1g.fsf@secure.mitica>
Subject: Re: [Qemu-devel] [PATCH v2] migration: Allow unregister of
 save_live handlers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org, lvivier@redhat.com

* Juan Quintela (quintela@redhat.com) wrote:
> Peter Xu <peterx@redhat.com> wrote:
> > On Wed, May 24, 2017 at 01:21:52PM +0200, Juan Quintela wrote:
> >> Migration non save_live handlers have an ops member that is
> >> dinamically allocated by migration code.  Save_live handlers have it
> >> passed as argument and are responsability of the caller.  Add a new
> >> member is_allocated that remembers if ops has to be freed.  This
> >> allows unregister_savevm() to work with save_live handlers.
> >> 
> >> Signed-off-by: Juan Quintela <quintela@redhat.com>
> >
> > I thought Laurent will prepare one patch that will directly remove
> > existing register_savevm() callers, no?
> 
> s390, vmxnet3 and slirp are using it.  I am not sure that we will get
> that ones "changed" so easily.

I think Halil is working on s390,  slirp has a tricky loop I need to
look at again.  And vmxnet3 is...odd.

Dave

> Later, Juan.
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
