Received: from eggs.gnu.org ([2001:4830:134:3::10]:33494)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1f5wOe-0002Op-Uk
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 12:45:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1f5wOa-0008Cw-PA
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 12:45:29 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <d48c55a6-3405-3ab7-0bb9-96a2238874da@redhat.com>
References: <cover.1523376013.git.berto@igalia.com>
	<0f687957feb72e80c740403191a47e607c2463fe.1523376013.git.berto@igalia.com>
	<d48c55a6-3405-3ab7-0bb9-96a2238874da@redhat.com>
Date: Tue, 10 Apr 2018 18:45:21 +0200
Message-ID: <w51woxfhuxq.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 1/2] Fix error message about compressed
 clusters with OFLAG_COPIED
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

On Tue 10 Apr 2018 06:18:28 PM CEST, Eric Blake wrote:
> On 04/10/2018 11:05 AM, Alberto Garcia wrote:
>> Compressed clusters are not supposed to have the COPIED bit set.
>> "qemu-img check" detects that and prints an error message reporting
>> the number of the affected host cluster. This doesn't make much sense
>> because compressed clusters are not aligned to host clusters, so it
>> would be better to report the offset instead. Plus, the calculation is
>> wrong and it uses the raw L2 entry as if it was simply an offset.
>> 
>> This patch fixes the error message and reports the offset of the
>> compressed cluster.
>> 
>> Signed-off-by: Alberto Garcia <berto@igalia.com>
>> ---
>>  block/qcow2-refcount.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>> 
>
> Do we have iotests coverage of this?

I have one half-written, but I was thinking to put it in 214, so I'll
wait until Max's patch is merged.

Berto
