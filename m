Received: from eggs.gnu.org ([2001:4830:134:3::10]:57067)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1drkky-000152-Tb
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 08:57:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1drkkx-0004rw-SF
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 08:57:36 -0400
Date: Tue, 12 Sep 2017 14:57:27 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170912125727.GK29136@localhost.localdomain>
References: <20170809215510.22802-1-pbonzini@redhat.com>
	<20170809215510.22802-8-pbonzini@redhat.com>
	<20170912104005.GF29136@localhost.localdomain>
	<c8262464-87aa-71b6-ffa0-4af8411a9bea@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c8262464-87aa-71b6-ffa0-4af8411a9bea@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 07/12] qemu-iotests: disintegrate more
 parts of common.config
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org

Am 12.09.2017 um 14:31 hat Paolo Bonzini geschrieben:
> On 12/09/2017 12:40, Kevin Wolf wrote:
> > Am 09.08.2017 um 23:55 hat Paolo Bonzini geschrieben:
> >> Split "check" parts from tests part.
> >>
> >> For the directory setup, the actual computation of directories goes
> >> in "check", while the sanity checks go in the tests.
> >>
> >> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> > 
> > Same comment as for patch 1, we may want to keep this working.
> 
> Can you explain what is the use case?  For local symlinks I (sort of)
> understand it, but not here.  This as far as I understand is code that
> never runs.

Sorry, somehow I replied to the wrong patch...

This was meant as a comment for patch 9 ('do not search for binaries in
the current directory').

> My preferred alternatives would be one of these:
> 
> - add a patch 13 that restores the local symlink feature on top of the
> cleaned up code.
> 
> - later, rewrite "check" in Python now that it is clear what code is
> part of it and what code is part of the tests.

Do you really think that removing and the reintroducing the feature is
easier than just keeping it in the first place?

> or:
> 
> - leave local symlinks broken
> 
> - when "check" is rewritten in Python, add a configuration mechanism
> based on .ini file syntax that replaces the local symlinks.
> 
> What do you think?

I don't mind the solution as long as after the series, it is still
working. I think this means option 1.

Kevin
