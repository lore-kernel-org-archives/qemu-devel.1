Received: from eggs.gnu.org ([2001:4830:134:3::10]:41512)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fkCCR-0000O4-VZ
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 13:43:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fkCCR-0005Or-3P
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 13:43:15 -0400
References: <20180723222210.11077-1-jsnow@redhat.com>
	<153297036163.12997.1309407319525391577@sif>
From: John Snow <jsnow@redhat.com>
Message-ID: <a55c92c1-d36f-8e56-5699-e5394399d2ae@redhat.com>
Date: Mon, 30 Jul 2018 13:43:08 -0400
MIME-Version: 1.0
In-Reply-To: <153297036163.12997.1309407319525391577@sif>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-3.0 0/7] fix persistent bitmaps
 migration logic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, qemu-stable@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>



On 07/30/2018 01:06 PM, Michael Roth wrote:
> Quoting John Snow (2018-07-23 17:22:03)
>> This is an updated version of Vladimir's proposal for fixing the
>> handling around migration and persistent dirty bitmaps.
> 
> Are these still being considered for 3.0 rc3/rc4? 2.12.1 releases this week
> and I'm not sure how badly these are needed.
> 

Good question. I'd still LIKE them in 3.0, but further fixes are
actually still needed, and I'm working on this right now.

I think you'll find that you might have trouble applying them to 2.12.1
without a fairly long trail of prerequisites, so it might not be easily
plausible.

>>
>> Patches 1, 4, 6, and 7 update the testing for this feature.
>> Patch 2 touches up an error message.
>> Patch 3 removes dead code.
>> Patch 5 contains the real fix.
>>
>> v2:
>>  - Add a new patch 4 as a prerequisite for what's now patch 5
>>  - Rework the fix to be (hopefully) cleaner, see patch 5 notes
>>  - Adjust error message in patch 2 (Eric)
>>  - Adjust test logic slightly (patches 6, 7) to deal with changes
>>    in patch 5.
>>
>> John Snow (2):
>>   iotests: 169: actually test block migration
>>   dirty-bitmaps: clean-up bitmaps loading and migration logic
>>
>> Vladimir Sementsov-Ogievskiy (5):
>>   iotests: 169: drop deprecated 'autoload' parameter
>>   block/qcow2: improve error message in qcow2_inactivate
>>   block/qcow2: drop dirty_bitmaps_loaded state variable
>>   iotests: improve 169
>>   iotests: 169: add cases for source vm resuming
>>
>>  block.c                        |  4 ---
>>  block/dirty-bitmap.c           | 20 ------------
>>  block/qcow2-bitmap.c           | 16 +++++++++
>>  block/qcow2.c                  | 26 ++++-----------
>>  block/qcow2.h                  |  1 -
>>  include/block/dirty-bitmap.h   |  2 +-
>>  migration/block-dirty-bitmap.c | 11 ++++---
>>  tests/qemu-iotests/169         | 74 ++++++++++++++++++++++++++++++++++++++++--
>>  tests/qemu-iotests/169.out     |  4 +--
>>  9 files changed, 103 insertions(+), 55 deletions(-)
>>
>> -- 
>> 2.14.4
>>
>>
