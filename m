Received: from eggs.gnu.org ([2001:4830:134:3::10]:50437)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fJ3K8-0003cl-TZ
	for qemu-devel@nongnu.org; Wed, 16 May 2018 16:47:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fJ3K8-0006ar-2z
	for qemu-devel@nongnu.org; Wed, 16 May 2018 16:47:00 -0400
Date: Wed, 16 May 2018 22:46:49 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180516204649.GG4435@localhost.localdomain>
References: <20180509162637.15575-1-kwolf@redhat.com>
	<20180509162637.15575-39-kwolf@redhat.com>
	<8b50aa3d-24eb-53cd-bc0b-14165ae73784@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8b50aa3d-24eb-53cd-bc0b-14165ae73784@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 38/42] job: Add JOB_STATUS_CHANGE QMP event
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-block@nongnu.org, mreitz@redhat.com, jsnow@redhat.com, armbru@redhat.com, jcody@redhat.com, qemu-devel@nongnu.org

Am 16.05.2018 um 21:26 hat Eric Blake geschrieben:
> On 05/09/2018 11:26 AM, Kevin Wolf wrote:
> > This adds a QMP event that is emitted whenever a job transitions from
> > one status to another. For the event, a new qapi/job.json schema file is
> > created which will contain all job-related definitions that aren't tied
> > to the block layer.
> > 
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > ---
> 
> > +++ b/qapi/job.json
> 
> > +##
> > +# @JOB_STATUS_CHANGE:
> > +#
> > +# Emitted when a job transitions to a different status.
> > +#
> > +# @id: The job identifier
> > +# @status: The new job status
> > +#
> > +# Since: 2.13
> > +##
> > +{ 'event': 'JOB_STATUS_CHANGE',
> > +  'data': { 'id': 'str',
> > +            'status': 'JobStatus' } }
> 
> Is it worth also trying to list the old state that the transition came from?
> But that's new compared to what block jobs are currently doing, so if we
> can't come up with a strong reason to add that, I'm okay.

If a management tool needs this information (I don't see why), it just
needs to keep track of the last state it had seen, no?

Kevin
