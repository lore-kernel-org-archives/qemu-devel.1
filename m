Received: from eggs.gnu.org ([2001:4830:134:3::10]:58566)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cg6dJ-0007n3-CU
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 04:21:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cg6dI-0000qb-IE
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 04:21:17 -0500
Date: Tue, 21 Feb 2017 09:21:06 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170221092105.GA2377@work-vm>
References: <1487067971-10443-1-git-send-email-armbru@redhat.com>
	<1487067971-10443-22-git-send-email-armbru@redhat.com>
	<20170220193429.GJ2372@work-vm> <87a89fnbxx.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a89fnbxx.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] [PATCH 21/24] util/cutils: Let qemu_strtosz*()
 optionally reject trailing crap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org, "open list:Block layer core" <qemu-block@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>

* Markus Armbruster (armbru@redhat.com) wrote:
> "Dr. David Alan Gilbert" <dgilbert@redhat.com> writes:
> 
> > * Markus Armbruster (armbru@redhat.com) wrote:
> >> Change the qemu_strtosz() & friends to return -EINVAL when @endptr is
> >> null and the conversion doesn't consume the string completely.
> >> Matches how qemu_strtol() & friends work.
> >> 
> >> Only test_qemu_strtosz_simple() passes a null @endptr.  No functional
> >> change there, because its conversion consumes the string.
> >> 
> >> Simplify callers that use @endptr only to fail when it doesn't point
> >> to '\0' to pass a null @endptr instead.
> >> 
> >> Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
> >> Cc: Eduardo Habkost <ehabkost@redhat.com> (maintainer:X86)
> >> Cc: Kevin Wolf <kwolf@redhat.com> (supporter:Block layer core)
> >> Cc: Max Reitz <mreitz@redhat.com> (supporter:Block layer core)
> >> Cc: qemu-block@nongnu.org (open list:Block layer core)
> >> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> >
> > Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> >
> > (end and endptr are horribly confusing names in do_strtosz)
> 
> Could rename for consistency with qemu_strtol() & friends:
> 
> * Parameter @end to @endptr
> 
> * Local variable @endptr to @ep
> 
> Would that be useful?

Oh I wouldn't worry too much about it; and those perhaps aren't
that much clearer.

Dave

--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
