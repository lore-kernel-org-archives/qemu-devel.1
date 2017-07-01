Received: from eggs.gnu.org ([2001:4830:134:3::10]:59289)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dRJOf-00060l-QX
	for qemu-devel@nongnu.org; Sat, 01 Jul 2017 10:29:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dRJOa-0000LN-Ta
	for qemu-devel@nongnu.org; Sat, 01 Jul 2017 10:29:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56200)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dRJOa-0000Kr-Mw
	for qemu-devel@nongnu.org; Sat, 01 Jul 2017 10:29:12 -0400
Date: Sat, 1 Jul 2017 11:29:09 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170701142909.GE12152@localhost.localdomain>
References: <20170613165313.20954-1-ehabkost@redhat.com>
	<87o9t8qy7d.fsf@dusky.pond.sub.org>
	<20170628174158.GG12152@localhost.localdomain>
	<87mv8r2sii.fsf@dusky.pond.sub.org>
	<20170629125706.GT12152@localhost.localdomain>
	<871sq1r9dh.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871sq1r9dh.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] [RFC 00/15] Error API: Flag errors in *errp even
 if errors are being ignored
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>

On Fri, Jun 30, 2017 at 01:40:58PM +0200, Markus Armbruster wrote:
[...]
> 
> I doubt the macros make the bug fixing materially easier, and I doubt
> they can reduce future bugs of this kind.  What they can do is letting
> us get rid of error_propagate() boilerplate with relative ease.
> 
> If we switch to returning success/failure (which also gets rid of the
> boilerplate), then the macros may still let us get rid of boilerplate
> more quickly, for some additional churn.  Worthwhile?  Depends on how
> long the return value change takes us.
> 
> I think the first order of business is to figure out whether we want to
> pursue returning success/failure.

About this, I'm unsure.  Returning error information in two separate
locations (the return value and *errp) makes it easier to introduce bugs
that are hard to detect.  Especially when the tree is an inconsistent
state where we mix -1/0, -errno/0, FALSE/TRUE, NULL/non-NULL and void
functions.

-- 
Eduardo
