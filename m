Received: from eggs.gnu.org ([209.51.188.92]:45434)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gwBVi-0006V0-HP
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 14:56:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gwBVS-0007mA-5K
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 14:56:48 -0500
References: <20190218233154.19303-1-jsnow@redhat.com>
	<3374bbeb-cc15-acbb-88d8-a057bbfe5482@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <6fa2dcc8-3cd4-527e-e085-49bfc364dcf8@redhat.com>
Date: Tue, 19 Feb 2019 14:56:32 -0500
MIME-Version: 1.0
In-Reply-To: <3374bbeb-cc15-acbb-88d8-a057bbfe5482@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5] blockdev: acquire aio_context for
 bitmap add/remove
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, pbonzini@redhat.com, vsementsov@virtuozzo.com, Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>



On 2/19/19 9:59 AM, Eric Blake wrote:
> On 2/18/19 5:31 PM, John Snow wrote:
>> When bitmaps are persistent, they may incur a disk read or write when bitmaps
>> are added or removed. For configurations like virtio-dataplane, failing to
>> acquire this lock will abort QEMU when disk IO occurs.
>>
>> We used to acquire aio_context as part of the bitmap lookup, so re-introduce
>> the lock for just the cases that have an IO penalty. Commit 2119882c removed
>> these locks, and I failed to notice this when we committed fd5ae4cc, so this
>> has been broken since persistent bitmaps were introduced.
>>
>> Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=1672010
>> Reported-By: Aihua Liang <aliang@redhat.com>
>> Signed-off-by: John Snow <jsnow@redhat.com>
>> ---
>> v5: I'm having a really bad day. This version actually has the semicolon.
>> ---
>>  blockdev.c | 26 ++++++++++++++++++++------
>>  1 file changed, 20 insertions(+), 6 deletions(-)
> 
> Reviewed-by: Eric Blake <eblake@redhat.com>
> 
> and yes, this time it builds.
> 

I am really very sorry for the noise on this simple series. Thank you
for the review and your patience.

--John
