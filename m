Received: from eggs.gnu.org ([2001:4830:134:3::10]:57993)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <baiyaowei@cmss.chinamobile.com>) id 1fQwn7-00052T-Ek
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 11:25:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <baiyaowei@cmss.chinamobile.com>) id 1fQwn6-0002B8-L1
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 11:25:33 -0400
Date: Thu, 7 Jun 2018 11:25:01 -0400
From: Yaowei Bai <baiyaowei@cmss.chinamobile.com>
Message-ID: <20180607152501.GA9745@byw>
Reply-To: baiyaowei@cmss.chinamobile.com
References: <1528382639-9202-1-git-send-email-baiyaowei@cmss.chinamobile.com>
	<20180607150558.GI6435@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180607150558.GI6435@localhost.localdomain>
Subject: Re: [Qemu-devel] [PATCH] gitignore: Ignore qapi/qapi-*-job.[ch]
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jeff Cody <jcody@redhat.com>
Cc: kwolf@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org, eblake@redhat.com

On Thu, Jun 07, 2018 at 11:05:58AM -0400, Jeff Cody wrote:
> On Thu, Jun 07, 2018 at 10:43:59AM -0400, Yaowei Bai wrote:
> > They were introduced by commit bf42508f24ee(job: Introduce
> > qapi/job.json) but forgot to ignore them in .gitignore.
> > 
> > Signed-off-by: Yaowei Bai <baiyaowei@cmss.chinamobile.com>
> 
> Good patch, but Eric Blake already sent an identical one that has two r-b's
> on it already, so that is probably the one to pull in:

OK, pls ignore this one.

> 
> 
> [Qemu-block] [PATCH] block: Ignore generated job QAPI files
> essage-Id: <20180531212435.165261-1-eblake@redhat.com>
> 
> Thanks,
> Jeff
> 
> > ---
> >  .gitignore | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/.gitignore b/.gitignore
> > index a178e4c..e4bacc6 100644
> > --- a/.gitignore
> > +++ b/.gitignore
> > @@ -36,6 +36,7 @@
> >  /qapi/qapi-commands-common.[ch]
> >  /qapi/qapi-commands-crypto.[ch]
> >  /qapi/qapi-commands-introspect.[ch]
> > +/qapi/qapi-commands-job.[ch]
> >  /qapi/qapi-commands-migration.[ch]
> >  /qapi/qapi-commands-misc.[ch]
> >  /qapi/qapi-commands-net.[ch]
> > @@ -53,6 +54,7 @@
> >  /qapi/qapi-events-common.[ch]
> >  /qapi/qapi-events-crypto.[ch]
> >  /qapi/qapi-events-introspect.[ch]
> > +/qapi/qapi-events-job.[ch]
> >  /qapi/qapi-events-migration.[ch]
> >  /qapi/qapi-events-misc.[ch]
> >  /qapi/qapi-events-net.[ch]
> > @@ -71,6 +73,7 @@
> >  /qapi/qapi-types-common.[ch]
> >  /qapi/qapi-types-crypto.[ch]
> >  /qapi/qapi-types-introspect.[ch]
> > +/qapi/qapi-types-job.[ch]
> >  /qapi/qapi-types-migration.[ch]
> >  /qapi/qapi-types-misc.[ch]
> >  /qapi/qapi-types-net.[ch]
> > @@ -88,6 +91,7 @@
> >  /qapi/qapi-visit-common.[ch]
> >  /qapi/qapi-visit-crypto.[ch]
> >  /qapi/qapi-visit-introspect.[ch]
> > +/qapi/qapi-visit-job.[ch]
> >  /qapi/qapi-visit-migration.[ch]
> >  /qapi/qapi-visit-misc.[ch]
> >  /qapi/qapi-visit-net.[ch]
> > -- 
> > 1.8.3.1
> > 
> > 
> > 
