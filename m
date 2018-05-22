Received: from eggs.gnu.org ([2001:4830:134:3::10]:38907)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fL4mO-0004YG-NX
	for qemu-devel@nongnu.org; Tue, 22 May 2018 06:44:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fL4mN-0006v3-Tb
	for qemu-devel@nongnu.org; Tue, 22 May 2018 06:44:32 -0400
Date: Tue, 22 May 2018 12:44:24 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180522104424.GB6233@localhost.localdomain>
References: <20180518132114.4070-1-kwolf@redhat.com>
	<20180518132114.4070-38-kwolf@redhat.com>
	<34f3b470-614b-d836-c8ca-c6d4b81ecc1d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <34f3b470-614b-d836-c8ca-c6d4b81ecc1d@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 37/40] job: Add query-jobs QMP command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-block@nongnu.org, mreitz@redhat.com, jsnow@redhat.com, jcody@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org

Am 18.05.2018 um 20:22 hat Eric Blake geschrieben:
> On 05/18/2018 08:21 AM, Kevin Wolf wrote:
> > This adds a minimal query-jobs implementation that shouldn't pose many
> > design questions. It can later be extended to expose more information,
> > and especially job-specific information.
> > 
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > ---
> >   qapi/job.json      | 45 +++++++++++++++++++++++++++++++++++++++++++++
> >   include/qemu/job.h |  3 +++
> >   job-qmp.c          | 54 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
> >   job.c              |  2 +-
> >   4 files changed, 103 insertions(+), 1 deletion(-)
> > 
> 
> > +##
> > +# @JobInfo:
> > +#
> > +# Information about a job.
> > +#
> > +# @id:                  The job identifier
> 
> > +##
> > +{ 'struct': 'JobInfo',
> > +  'data': { 'id': 'str', 'type': 'JobType', 'status': 'JobStatus',
> > +            'current-progress': 'int', 'total-progress': 'int',
> > +            '*error': 'str' } }
> 
> Is it worth exposing whether a job is auto-finalize and auto-complete? Goes
> back to the issue of whether clients of the new job API would ever want/need
> to rely on the auto- features; while clients of the old blockjob API that
> get the auto- features by default will never be calling the new query-jobs
> command.

There are probably more fields that could be exposed. For most of them,
it's not obvious whether we want to expose them, so I went for the
minimal useful information here. We can always add more information to a
query command; but we can't take information away later if it turns out
that exposing it was a bad idea.

Kevin
