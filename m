Received: from eggs.gnu.org ([2001:4830:134:3::10]:53149)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dXiEP-0004YV-DR
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 02:13:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dXiEO-0000Jj-5z
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 02:13:09 -0400
Date: Wed, 19 Jul 2017 08:12:59 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170719061259.GB4617@noname.redhat.com>
References: <1500385286-21142-1-git-send-email-armbru@redhat.com>
	<20170718160825.GW11927@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170718160825.GW11927@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.10 00/10] Correct two minor QMP
 interface design flaws
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org, eblake@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org, quintela@redhat.com, dgilbert@redhat.com

Am 18.07.2017 um 18:08 hat Daniel P. Berrange geschrieben:
> On Tue, Jul 18, 2017 at 03:41:16PM +0200, Markus Armbruster wrote:
> > blockdev-add and migrate-set-parameters overload empty strings to mean
> > something entirely different.  See my memo "qapi: Stop abusing
> > "special" values for something entirely different" for details.
> > 
> >     Message-ID: <87379zhrhn.fsf@dusky.pond.sub.org>
> >     https://lists.gnu.org/archive/html/qemu-devel/2017-07/msg04526.html
> > 
> > This series deprecates these usages of "" in favour of JSON null.
> > Because we're so close to the 2.10 freeze, the implementation is
> > intentionally stupid: rewrite null to "" at first opportunity.  The
> > proper way to do it would be rewriting "" to null, but that requires
> > fixing up code to work with null.  There are TODO comments for that.
> > I'm willing to take care of them in the next development cycle.
> 
> I tested the migrate-set-parameters QMP command with this applied and
> I can still pass "" as the tls-hostname.
> 
> When using query-migrate-parameters we still see "" too.
> 
> So from POV of avoiding regressions for existing usage, we look OK
> here.

Opportunity for a follow-up patch: Automate these tests.

Kevin
