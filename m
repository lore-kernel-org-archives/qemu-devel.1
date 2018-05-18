Received: from eggs.gnu.org ([2001:4830:134:3::10]:43565)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fJjcJ-0004sg-0J
	for qemu-devel@nongnu.org; Fri, 18 May 2018 13:56:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fJjcI-00083g-EY
	for qemu-devel@nongnu.org; Fri, 18 May 2018 13:56:35 -0400
References: <20180518132114.4070-1-kwolf@redhat.com>
	<20180518132114.4070-13-kwolf@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <509afafd-54ac-46ef-5609-a019c02bcfe0@redhat.com>
Date: Fri, 18 May 2018 13:56:28 -0400
MIME-Version: 1.0
In-Reply-To: <20180518132114.4070-13-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 12/40] job: Move defer_to_main_loop to
 Job
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



On 05/18/2018 09:20 AM, Kevin Wolf wrote:
> Move the defer_to_main_loop functionality from BlockJob to Job.
> 
> The code can be simplified because we can use job->aio_context in
> job_defer_to_main_loop_bh() now, instead of having to access the
> BlockDriverState.
> 
> Probably taking the data->aio_context lock in addition was already
> unnecessary in the old code because we didn't actually make use of
> anything protected by the old AioContext except getting the new
> AioContext, in case it changed between scheduling the BH and running it.
> But it's certainly unnecessary now that the BDS isn't accessed at all
> any more.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> Reviewed-by: Max Reitz <mreitz@redhat.com>

Reviewed-by: John Snow <jsnow@redhat.com>
