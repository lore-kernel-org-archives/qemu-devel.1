Received: from eggs.gnu.org ([2001:4830:134:3::10]:43817)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eCPHP-00061S-ML
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 07:16:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eCPHM-0000dI-WC
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 07:16:27 -0500
Date: Wed, 8 Nov 2017 13:16:12 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20171108121612.GD30890@localhost.localdomain>
References: <20171107172638.29942-1-kwolf@redhat.com>
	<20171107173920.GK3213@redhat.com>
	<357d61df-9bad-dc5a-1878-2fce4b2a93cc@redhat.com>
	<20171108104907.GN12670@redhat.com>
	<20171108115127.GC30890@localhost.localdomain>
	<f5dc8522-86cd-c8fa-2dd7-d9e36c5c8245@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f5dc8522-86cd-c8fa-2dd7-d9e36c5c8245@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] block: Deprecate bdrv_set_read_only() and
 users
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Daniel P. Berrange" <berrange@redhat.com>, mreitz@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org, armbru@redhat.com

Am 08.11.2017 um 13:00 hat Paolo Bonzini geschrieben:
> On 08/11/2017 12:51, Kevin Wolf wrote:
> > Am 08.11.2017 um 11:49 hat Daniel P. Berrange geschrieben:
> >> On Wed, Nov 08, 2017 at 11:44:01AM +0100, Paolo Bonzini wrote:
> >>> I am not sure this counts as deprecation, but it should go in the
> >>> release notes as "future incompatible changes", and that section
> >>> probably should go in qemu-doc.texi itself.
> >>
> >> Yeah, adding a "Incompatible changes" appendix to the qemu-doc.texi
> >> would be useful, listing the planned change, and when it is actually
> >> made. That way apps adding support for a feature have an indication
> >> of any incompatiblities they might need to care about.
> > 
> > You mean a section containing future incompatible changes as well as
> > already implemented incompatible changes?
> > 
> > What would we do with the existing "Deprecated features" section? Would
> > it become a subsection of "Incompatible changes"? Or would we just
> > rename it and the subsections would stay on the same level and get
> > "deprecated" added to their title? Or a completely different structure?
> > 
> > I'm okay with adding a little documentation in this patch if I know what
> > it should look like, but if it turns into a major overhaul of the
> > documentation on incompatible changes, it's probably out of scope for
> > this patch.
> 
> For now I would just add a section to the changelog.  That ensures that
> we don't forget and end up doing nothing.

Okay, done. Thanks!

Kevin
