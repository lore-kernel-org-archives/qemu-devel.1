Received: from eggs.gnu.org ([2001:4830:134:3::10]:57166)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fo5tS-0007sT-IW
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 07:47:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fo5tR-0003X3-Ot
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 07:47:46 -0400
Date: Fri, 10 Aug 2018 13:47:31 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180810114731.GE4367@localhost.localdomain>
References: <20180807043349.27196-1-jsnow@redhat.com>
	<20180807043349.27196-20-jsnow@redhat.com>
	<83f634a8-ddab-2eb1-419a-fd2e8a6b815f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <83f634a8-ddab-2eb1-419a-fd2e8a6b815f@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 19/21] qapi/block-commit: expose new job
 properties
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, Jeff Cody <jcody@redhat.com>, Max Reitz <mreitz@redhat.com>, jtc@redhat.com, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Am 07.08.2018 um 16:52 hat Eric Blake geschrieben:
> On 08/06/2018 11:33 PM, John Snow wrote:
> > Signed-off-by: John Snow <jsnow@redhat.com>
> > ---
> >   blockdev.c           | 8 ++++++++
> >   qapi/block-core.json | 3 ++-
> >   2 files changed, 10 insertions(+), 1 deletion(-)
> > 
> 
> > +++ b/qapi/block-core.json
> > @@ -1518,7 +1518,8 @@
> >   { 'command': 'block-commit',
> >     'data': { '*job-id': 'str', 'device': 'str', '*base': 'str', '*top': 'str',
> >               '*backing-file': 'str', '*speed': 'int',
> > -            '*filter-node-name': 'str' } }
> > +            '*filter-node-name': 'str',
> > +            '*auto-finalize': 'bool', '*auto-dismiss': 'bool' } }
> 
> Missing documentation, including a 'since 3.1' tag.

And the same for the other two commands.

Kevin
