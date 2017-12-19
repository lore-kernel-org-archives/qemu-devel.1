Received: from eggs.gnu.org ([2001:4830:134:3::10]:49283)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eRMXg-0003kN-V5
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 13:23:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eRMXd-0006a9-35
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 13:23:04 -0500
Date: Tue, 19 Dec 2017 18:22:50 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20171219182249.GE2730@work-vm>
References: <1513700253-10045-1-git-send-email-thuth@redhat.com>
	<20171219162157.GD3567@redhat.com>
	<7d919cca-4dc1-6591-1a01-4143d3fe2b3b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7d919cca-4dc1-6591-1a01-4143d3fe2b3b@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] monitor: Remove legacy "-mon default=on"
 parameter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, qemu-trivial@nongnu.org, sw@weilnetz.de

* Thomas Huth (thuth@redhat.com) wrote:
> On 19.12.2017 17:21, Daniel P. Berrange wrote:
> > On Tue, Dec 19, 2017 at 05:17:33PM +0100, Thomas Huth wrote:
> >> The "default" parameter of the "-mon" option is useless since
> >> QEMU v2.4.0, and marked as deprecated since QEMU v2.8.0. That
> >> should have been long enough to let people update their scripts,
> >> so time to remove it now.
> >>
> >> Signed-off-by: Thomas Huth <thuth@redhat.com>
> >> ---
> >>  monitor.c     | 3 ---
> >>  qemu-doc.texi | 9 ---------
> >>  vl.c          | 4 ----
> >>  3 files changed, 16 deletions(-)
> >>
> >> diff --git a/monitor.c b/monitor.c
> >> index e36fb53..e53c6e1 100644
> >> --- a/monitor.c
> >> +++ b/monitor.c
> >> @@ -4141,9 +4141,6 @@ QemuOptsList qemu_mon_opts = {
> >>              .name = "chardev",
> >>              .type = QEMU_OPT_STRING,
> >>          },{
> >> -            .name = "default",  /* deprecated */
> >> -            .type = QEMU_OPT_BOOL,
> >> -        },{
> >>              .name = "pretty",
> >>              .type = QEMU_OPT_BOOL,
> >>          },
> >> diff --git a/qemu-doc.texi b/qemu-doc.texi
> >> index d9861b3..6913b32 100644
> >> --- a/qemu-doc.texi
> >> +++ b/qemu-doc.texi
> >> @@ -2401,15 +2401,6 @@ setting ``-machine kernel_irqchip=off''.
> >>  The ``-no-kvm'' argument is now a synonym for setting
> >>  ``-machine accel=tcg''.
> >>  
> >> -@subsection -mon default=on (since 2.4.0)
> >> -
> >> -The ``default'' option to the ``-mon'' argument is
> >> -now ignored. When multiple monitors were enabled, it
> >> -indicated which monitor would receive log messages
> >> -from the various subsystems. This feature is no longer
> >> -required as messages are now only sent to the monitor
> >> -in response to explicitly monitor commands.
> >> -
> >>  @subsection -vnc tls (since 2.5.0)
> > 
> > It occurs to me that qemu.org only ever displays the very latest version
> > of the qemu-tech doc.
> > 
> > So if someone has deployed QEMU 2.11, and reads the doc online, once your
> > patches are commited, all the info about deprecated features that affect
> > their 2.11 version will have gone, despite 2.12 not yet existing.
> 
> No, as far as I know, the online qemu-doc is only updated for release
> candidates and releases, so the current information will stay there a
> little bit longer.
> 
> > So rather than deleting entries from the deprecation appendix, should
> > we move them to a separate appendix, or "Formerly deprecated, now
> > deleted" features. Or just change the annotation
> > 
> >   (since 2.4.0)
> > 
> > to
> > 
> >   (deprecated since 2.4.0, deleted in 2.12.0)
> 
> Please, no. I really don't think that we should carry around the old
> cruft forever, even if it's just in the deprecation chapter of the
> qemu-doc. At one point in time, we should really just let it go. If
> users still want to get information about this afterwards, they can use
> Google to dig out older versions of the qemu-doc or the various
> ChangeLog pages in our Wiki, where we describe the deprecation of
> parameters, too.

I agree this is a job for a separate page; either the ChangeLog or
a separate 'defunct' wikipage.

Dave

>  Thomas
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
