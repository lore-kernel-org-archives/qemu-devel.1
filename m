Received: from eggs.gnu.org ([2001:4830:134:3::10]:56586)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1exocL-0004mT-L9
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 02:50:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1exocK-0004CX-UH
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 02:50:01 -0400
References: <20171130164750.47320-1-vsementsov@virtuozzo.com>
	<e7053aee-e4d2-50ea-0387-03b11931f7b6@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <84efbcec-c1a6-c99e-1b2a-534a2d0432bd@virtuozzo.com>
Date: Mon, 19 Mar 2018 09:49:48 +0300
MIME-Version: 1.0
In-Reply-To: <e7053aee-e4d2-50ea-0387-03b11931f7b6@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH for-2.12 0/2] qcow2: add
 overlap check for bitmap directory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com

17.03.2018 01:21, John Snow wrote:
>
> On 11/30/2017 11:47 AM, Vladimir Sementsov-Ogievskiy wrote:
>> Add simple constant overlap check.
>>
>> Vladimir Sementsov-Ogievskiy (2):
>>    qcow2: add overlap check for bitmap directory
>>    qcow2: fix indentation after previous patch
>>
>>   block/qcow2.h          | 45 ++++++++++++++++++++++++---------------------
>>   block/qcow2-refcount.c | 12 ++++++++++++
>>   block/qcow2.c          | 22 ++++++++++++++--------
>>   3 files changed, 50 insertions(+), 29 deletions(-)
>>
> Vladimir, do we need this for 2.12 still?
> How about "fix bitmaps migration through shared storage"?

Ohh, my fault. Will look at them today.

-- 
Best regards,
Vladimir
