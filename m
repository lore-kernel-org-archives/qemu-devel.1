Received: from eggs.gnu.org ([2001:4830:134:3::10]:54976)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fIJP4-0005pP-Nq
	for qemu-devel@nongnu.org; Mon, 14 May 2018 15:45:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fIJP3-0002AQ-W0
	for qemu-devel@nongnu.org; Mon, 14 May 2018 15:45:02 -0400
References: <20180509162637.15575-1-kwolf@redhat.com>
	<20180509162637.15575-8-kwolf@redhat.com>
	<91b7384b-25f4-2141-8794-d1319aa19c2d@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <451d7e65-4a0a-f697-ffb4-ff50206d60f7@redhat.com>
Date: Mon, 14 May 2018 15:44:57 -0400
MIME-Version: 1.0
In-Reply-To: <91b7384b-25f4-2141-8794-d1319aa19c2d@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 07/42] blockjob: Remove
 block_job_pause/resume_all()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jcody@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org



On 05/11/2018 06:30 PM, Max Reitz wrote:
> On 2018-05-09 18:26, Kevin Wolf wrote:
>> Commit 81193349 removed the only use of block_job_pause/resume_all(),
>> which was in bdrv_drain_all(). The functions are now unused and can be
>> removed.
> 
> I have a strange liking for all-digit commit hash prefixes.
> 
>> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
>> ---
>>  include/block/blockjob_int.h | 14 --------------
>>  blockjob.c                   | 27 ---------------------------
>>  2 files changed, 41 deletions(-)
> 

And all deletion diffstats.

> Reviewed-by: Max Reitz <mreitz@redhat.com>
> 

Reviewed-by: John Snow <jsnow@redhat.com>
