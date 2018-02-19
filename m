Received: from eggs.gnu.org ([2001:4830:134:3::10]:45918)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1enq9U-0004G5-QM
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 13:27:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1enq9Q-00054F-CV
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 13:27:00 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <0fb270ca-5aae-0db3-93c2-43ebd6162027@redhat.com>
References: <20180219145459.8143-1-berto@igalia.com>
	<0fb270ca-5aae-0db3-93c2-43ebd6162027@redhat.com>
Date: Mon, 19 Feb 2018 19:26:51 +0100
Message-ID: <w51371whm38.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] docs: document how to use the
 l2-cache-entry-size parameter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, "Denis V . Lunev" <den@openvz.org>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On Mon 19 Feb 2018 05:44:23 PM CET, Eric Blake <eblake@redhat.com> wrote:
> On 02/19/2018 08:54 AM, Alberto Garcia wrote:
>> This patch updates docs/qcow2-cache.txt explaining how to use the new
>> l2-cache-entry-size parameter.
>> 
>> Here's a more detailed technical description of this feature:
>> 
>>     https://lists.gnu.org/archive/html/qemu-block/2017-09/msg00635.html
>> 
>> And here are some performance numbers:
>> 
>>     https://lists.gnu.org/archive/html/qemu-block/2017-12/msg00507.html
>> 
>> Signed-off-by: Alberto Garcia <berto@igalia.com>
>> ---
>>   docs/qcow2-cache.txt | 46 +++++++++++++++++++++++++++++++++++++++++++---
>>   1 file changed, 43 insertions(+), 3 deletions(-)
>> 
>
>> +Some things to take into account:
>> +
>> + - The L2 cache entry size has the same restrictions as the cluster
>> +   size (power of two, at least 512 bytes).
>
> Worth mentioning the upper limit of the cluster size?

I thought it would be unnecessary since the that's already mentioned
several times in the text ("you can change the size [...] and make it
smaller than the cluster size", "Using smaller cache entries"), and I
think it's pretty obvious if you actually read that section.

Berto
