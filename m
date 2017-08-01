Received: from eggs.gnu.org ([2001:4830:134:3::10]:41750)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1dcWlT-0002FJ-36
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 08:59:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1dcWlS-0002p1-96
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 08:59:11 -0400
References: <1501518125-29851-1-git-send-email-anton.nefedov@virtuozzo.com>
	<1501518125-29851-5-git-send-email-anton.nefedov@virtuozzo.com>
	<fd53908c-006c-4c8e-e7aa-388bd832e642@redhat.com>
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Message-ID: <f42a5f64-c965-39fa-45cc-a49f33ffcaff@virtuozzo.com>
Date: Tue, 1 Aug 2017 15:58:56 +0300
MIME-Version: 1.0
In-Reply-To: <fd53908c-006c-4c8e-e7aa-388bd832e642@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 04/13] block: support BDRV_REQ_ALLOCATE
 in passthrough drivers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, kwolf@redhat.com, mreitz@redhat.com


On 07/31/2017 10:11 PM, Eric Blake wrote:
> On 07/31/2017 11:21 AM, Anton Nefedov wrote:
>> Support the flag if the underlying BDS supports it
>>
>> Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
>> ---
>>   block/blkdebug.c   | 3 ++-
>>   block/raw-format.c | 3 ++-
>>   2 files changed, 4 insertions(+), 2 deletions(-)
> 
> What about blkverify, commit, and mirror?  Should they also pass through
> various flags?
> 

looks like commit is read-only, but blkverify and mirror probably
should, will try to fix that

/Anton
