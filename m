Received: from eggs.gnu.org ([2001:4830:134:3::10]:57324)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fIJbK-0001QG-TA
	for qemu-devel@nongnu.org; Mon, 14 May 2018 15:57:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fIJbK-00054d-7D
	for qemu-devel@nongnu.org; Mon, 14 May 2018 15:57:42 -0400
References: <20180509162637.15575-1-kwolf@redhat.com>
	<20180509162637.15575-9-kwolf@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <0b3bdf83-b87f-a0f9-7b16-e22d696e8def@redhat.com>
Date: Mon, 14 May 2018 15:57:36 -0400
MIME-Version: 1.0
In-Reply-To: <20180509162637.15575-9-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 08/42] job: Create Job,
 JobDriver and job_create()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, jcody@redhat.com, armbru@redhat.com, mreitz@redhat.com



On 05/09/2018 12:26 PM, Kevin Wolf wrote:
> This is the first step towards creating an infrastructure for generic
> background jobs that aren't tied to a block device. For now, Job only
> stores its ID and JobDriver, the rest stays in BlockJob.
> 
> The following patches will move over more parts of BlockJob to Job if
> they are meaningful outside the context of a block job.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>

I think I'll be reviewing this series in a manner that trusts that all
of the obvious cleanups get handled later, and only yelp if something
looks distinctly wrong.

Anything that simply doesn't get cleaned up is something we can fix
later, so unless it looks like it's painting us into a corner, it
probably doesn't need to be addressed right away.

Reviewed-by: John Snow <jsnow@redhat.com>
