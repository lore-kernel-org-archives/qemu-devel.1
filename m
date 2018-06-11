Received: from eggs.gnu.org ([2001:4830:134:3::10]:40792)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fSJCr-0001yn-4K
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 05:33:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fSJCn-0002Sh-VP
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 05:33:45 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54702 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fSJCn-0002Ri-Q9
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 05:33:41 -0400
Date: Mon, 11 Jun 2018 10:33:34 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180611093333.GA2661@work-vm>
References: <1528653731-4920-1-git-send-email-keno@juliacomputing.com>
	<87tvq9lps3.fsf@dusky.pond.sub.org>
	<CAFEAcA9XiuToz7pCEOysL-Hz1HvVyaMyeXV-yJi1xpHgdycLiw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA9XiuToz7pCEOysL-Hz1HvVyaMyeXV-yJi1xpHgdycLiw@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH v4] cutils: Provide strchrnul
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Markus Armbruster <armbru@redhat.com>, Keno Fischer <keno@juliacomputing.com>, QEMU Developers <qemu-devel@nongnu.org>, Greg Kurz <groug@kaod.org>, Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

* Peter Maydell (peter.maydell@linaro.org) wrote:
> On 11 June 2018 at 08:56, Markus Armbruster <armbru@redhat.com> wrote:
> > You're not printing $strchrnul like we print other configuration
> > results.  Hmm, we're not printing several of them.  Question for
> > maintainers (MAINTAINERS doesn't have any, so I'm cc'ing the top three
> > coughed up by get_maintainer.pl): bug or feature?  If feature, how do we
> > decide what to print?
> 
> If we printed everything that we tested for then the output would
> be unhelpfully enormous. My view is that we should print the
> "interesting" things for the user, ie the higher-level things
> that the user could potentially turn on by installing more
> libraries or has turned off explicitly or whatever. Reporting
> whether the host OS has strchrnul or whether we've had to
> provide our own implementation is doubly uninteresting:
>  * there's nothing the user could do to change this
>  * there is no visible effect (missing features, worse performance)
> 
> There's an argument that we should also log every config check
> result somehow (I think autoconf configures do this), but I
> don't think that our 'print stuff to stdout' is the right place
> for that.

We're not completely consistent, but I agree that we shouldn't print
the tiny things:

We're printing things that:
   a) Are user visible (e.g. KVM support)
   b) Reasonably major choices we make (e.g. coroutine backend)
   c) Some lesser things (madvise/posix_madvise/posix_memalign)
     However even (c) could be a problem if none were found

We probably shouldn't bother with printing things that have
no impact to either the user, or someone trying to cofnigure it and
wondering why a feature is missing.

Dave



> thanks
> -- PMM
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
