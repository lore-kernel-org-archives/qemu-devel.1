Received: from eggs.gnu.org ([209.51.188.92]:59194)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gtdoe-00013U-5E
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 14:34:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gtdod-0005Ho-Bq
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 14:34:00 -0500
References: <20190212010248.11056-1-jsnow@redhat.com>
	<20190212010248.11056-6-jsnow@redhat.com>
	<ef434d29-2059-12b3-5c6c-3a6b455447eb@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <32bb68d4-a0aa-94c1-46ff-a66943dcb3fb@redhat.com>
Date: Tue, 12 Feb 2019 14:33:43 -0500
MIME-Version: 1.0
In-Reply-To: <ef434d29-2059-12b3-5c6c-3a6b455447eb@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 5/5] block/dirty-bitmaps: unify qmp_locked
 and user_locked calls
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Juan Quintela <quintela@redhat.com>, qemu-block@nongnu.org, Fam Zheng <fam@euphon.net>, vsementsov@virtuozzo.com, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>



On 2/12/19 2:27 PM, Eric Blake wrote:
> On 2/11/19 7:02 PM, John Snow wrote:
>> These mean the same thing now. Unify them and rename the merged call
>> bdrv_dirty_bitmap_busy to indicate semantically what we are describing,
>> as well as help disambiguate from the various _locked and _unlocked
>> versions of bitmap helpers that refer to mutex locks.
> 
> Yay, definitely improved naming.
> 

Glad you agree! Thanks to Vladimir for the suggestion.

>> ---
>>  block/dirty-bitmap.c           | 41 +++++++++++++++-------------------
>>  blockdev.c                     | 18 +++++++--------
>>  include/block/dirty-bitmap.h   |  5 ++---
>>  migration/block-dirty-bitmap.c |  6 ++---
>>  nbd/server.c                   |  6 ++---
>>  5 files changed, 35 insertions(+), 41 deletions(-)
>>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> 

Thanks again! I'll send a V2 with a few peeks and pokes of additional
test coverage and the deprecated texi update.

--js
