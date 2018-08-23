Received: from eggs.gnu.org ([2001:4830:134:3::10]:54079)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fsrFI-00077d-QF
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 11:10:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fsrFE-0002g4-Jo
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 11:10:00 -0400
Date: Thu, 23 Aug 2018 17:09:51 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180823170951.656eaaeb.cohuck@redhat.com>
In-Reply-To: <88336ca5-052d-5b18-4cbe-1fb3b7fd7197@redhat.com>
References: <1535027120-26187-1-git-send-email-thuth@redhat.com>
	<20180823165410.5ff77164.cohuck@redhat.com>
	<88336ca5-052d-5b18-4cbe-1fb3b7fd7197@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] tests/migration: Enable the migration test
 on s390x, too
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org

On Thu, 23 Aug 2018 17:00:55 +0200
Thomas Huth <thuth@redhat.com> wrote:

> On 2018-08-23 16:54, Cornelia Huck wrote:
> > On Thu, 23 Aug 2018 14:25:20 +0200
> > Thomas Huth <thuth@redhat.com> wrote:
> >   
> >> We can re-use the s390-ccw bios code to implement a small firmware
> >> for a s390x guest which prints out the "A" and "B" characters and
> >> modifies the memory, as required for the migration test.
> >>
> >> Signed-off-by: Thomas Huth <thuth@redhat.com>
> >> ---
> >>  tests/Makefile.include               |   1 +
> >>  tests/migration-test.c               |  23 ++
> >>  tests/migration/s390x-a-b-rebuild.sh |  42 ++++
> >>  tests/migration/s390x-a-b.c          |  35 +++
> >>  tests/migration/s390x-a-b.h          | 427 +++++++++++++++++++++++++++++++++++
> >>  5 files changed, 528 insertions(+)
> >>  create mode 100755 tests/migration/s390x-a-b-rebuild.sh
> >>  create mode 100644 tests/migration/s390x-a-b.c
> >>  create mode 100644 tests/migration/s390x-a-b.h  
> > 
> > Hm, I wanted to comment that those new files should be added to the
> > MAINTAINERS file pattern (here as well :), but tests/migration does not
> > seem to have an entry in MAINTAINERS yet...  
> 
> Yeah, but that's a pre-existing problem... care to send a patch?

I would, if somebody told me who should be listed there... or those
people can just do it themselves ;)
