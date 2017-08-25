Received: from eggs.gnu.org ([2001:4830:134:3::10]:50512)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dl7Q9-0008H8-Ds
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 01:44:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dl7Q4-0007Pj-I2
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 01:44:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56528)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dl7Q4-0007PJ-CJ
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 01:44:36 -0400
Date: Fri, 25 Aug 2017 13:44:28 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170825054428.GG14174@pxdev.xzpeter.org>
References: <1503471071-2233-1-git-send-email-peterx@redhat.com>
	<1503471071-2233-6-git-send-email-peterx@redhat.com>
	<20170823174629.GH2648@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170823174629.GH2648@work-vm>
Subject: Re: [Qemu-devel] [RFC v2 5/8] hmp: support "without_bql"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>

On Wed, Aug 23, 2017 at 06:46:29PM +0100, Dr. David Alan Gilbert wrote:
> * Peter Xu (peterx@redhat.com) wrote:
> > Introducing new option "without_bql" for HMP commands.  It works just
> > like QMP "without-bql", but for HMP commands.
> > 
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> 
> It's going to be interesting when we have hmp commands that just call
> their qmp equivalent that we need to check for no mistakes.

But we don't have any QMP & HMP mapping between them, do we?  Then I
have no good idea on how we can do the check.

-- 
Peter Xu
