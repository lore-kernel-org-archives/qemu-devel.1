Received: from eggs.gnu.org ([2001:4830:134:3::10]:35996)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eXOJo-0006uq-IC
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 04:29:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eXOJl-0001qv-CC
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 04:29:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52354)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1eXOJl-0001pB-5l
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 04:29:37 -0500
Date: Fri, 5 Jan 2018 09:29:29 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180105092929.GB2491@work-vm>
References: <20180103093834.20879-1-quintela@redhat.com>
	<ce168bf2-8e61-1f62-8042-7e7df2decd8c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ce168bf2-8e61-1f62-8042-7e7df2decd8c@redhat.com>
Subject: Re: [Qemu-devel] [PULL 00/14] Migration pull request
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org, lvivier@redhat.com, peterx@redhat.com, Alexey <a.perevalov@samsung.com>, Markus Armbruster <armbru@redhat.com>

* Eric Blake (eblake@redhat.com) wrote:
> On 01/03/2018 03:38 AM, Juan Quintela wrote:
> > Hi
> > 
> > This are the changes for migration that are already reviewed.
> > 
> > Please, apply.
> > 
> 
> > Alexey Perevalov (6):
> >       migration: introduce postcopy-blocktime capability
> >       migration: add postcopy blocktime ctx into MigrationIncomingState
> >       migration: calculate vCPU blocktime on dst side
> >       migration: postcopy_blocktime documentation
> >       migration: add blocktime calculation into migration-test
> >       migration: add postcopy total blocktime into query-migrate
> 
> I had unanswered questions about these patches in the v12 series, where
> I'm not sure if the interface is still quite right.  We're still early
> enough that we could adjust the interface after the fact depending on
> how the questions are answered; but we're also early enough that it may
> be smarter to get the interface right before including it in a pull
> request.  I'll leave it to Peter and Juan to sort out whether this means
> an updated pull request is needed, or to take this as-is.

Hadn't that discussion been done to death about 10 times during the
(long) life of this series?

Dave

> -- 
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3266
> Virtualization:  qemu.org | libvirt.org
> 



--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
