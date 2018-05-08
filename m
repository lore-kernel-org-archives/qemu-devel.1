Received: from eggs.gnu.org ([2001:4830:134:3::10]:40257)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fFzvU-0000Eb-Iq
	for qemu-devel@nongnu.org; Tue, 08 May 2018 06:32:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fFzvQ-0007UO-Lj
	for qemu-devel@nongnu.org; Tue, 08 May 2018 06:32:56 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36536 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fFzvQ-0007UI-HY
	for qemu-devel@nongnu.org; Tue, 08 May 2018 06:32:52 -0400
Date: Tue, 8 May 2018 18:32:32 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180508103232.GA19024@xz-mi>
References: <20180502100422.8688-1-peterx@redhat.com>
	<20180502100422.8688-4-peterx@redhat.com>
	<20180508102338.GE19710@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180508102338.GE19710@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] [PATCH v4 3/4] monitor: more comments on lock-free
 fleids/funcs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>

On Tue, May 08, 2018 at 11:23:38AM +0100, Stefan Hajnoczi wrote:
> On Wed, May 02, 2018 at 06:04:21PM +0800, Peter Xu wrote:
> > Add some explicit comment for both Readline and cpu_set/cpu_get helpers
> > that they do not need the mon_lock protection.
> > 
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  monitor.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/monitor.c b/monitor.c
> > index 9f361ec21e..6100ad44f8 100644
> > --- a/monitor.c
> > +++ b/monitor.c
> > @@ -207,6 +207,7 @@ struct Monitor {
> >      int suspend_cnt;            /* Needs to be accessed atomically */
> >      bool skip_flush;
> >      bool use_io_thr;
> > +    /* Only used in parser, so no lock needed. */
> >      ReadLineState *rs;
> >      MonitorQMP qmp;
> >      gchar *mon_cpu_path;
> 
> Which fields does this comment cover?

"rs" only.  Maybe I should move the comment to the end of line?

    ReadLineState *rs;       /* Only used in parser, so no lock needed. */

-- 
Peter Xu
