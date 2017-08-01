Received: from eggs.gnu.org ([2001:4830:134:3::10]:42034)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1dcWma-00032k-LS
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 09:00:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1dcWmX-00048c-NK
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 09:00:18 -0400
References: <1501518125-29851-1-git-send-email-anton.nefedov@virtuozzo.com>
	<1501518125-29851-10-git-send-email-anton.nefedov@virtuozzo.com>
	<fca27768-2415-e70a-827d-9fb4016baf96@redhat.com>
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Message-ID: <9f4fdda8-97e6-0695-1f8c-0b80bcb6edc8@virtuozzo.com>
Date: Tue, 1 Aug 2017 15:59:56 +0300
MIME-Version: 1.0
In-Reply-To: <fca27768-2415-e70a-827d-9fb4016baf96@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 09/13] qcow2: move is_zero_sectors() up
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

On 07/31/2017 10:13 PM, Eric Blake wrote:
> On 07/31/2017 11:22 AM, Anton Nefedov wrote:
>> To be used in the following commit without a forward declaration.
>>
>> Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
>> ---
>>   block/qcow2.c | 39 +++++++++++++++++++--------------------
>>   1 file changed, 19 insertions(+), 20 deletions(-)
> 
> This conflicts with my byte-based block status work; do you want to
> rebase on top of my posts?
> 

sure! will send the v4 soon

/Anton
