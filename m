Received: from eggs.gnu.org ([2001:4830:134:3::10]:48688)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lbloch@janustech.com>) id 1fnMy0-00018A-0K
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 07:49:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lbloch@janustech.com>) id 1fnMxz-0000b8-5e
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 07:49:28 -0400
References: <20180808071051.30628-1-lbloch@janustech.com>
	<20180808071051.30628-5-lbloch@janustech.com>
	<w51in4lt6zv.fsf@maestria.local.igalia.com>
From: Leonid Bloch <lbloch@janustech.com>
Message-ID: <28c19ef6-4e22-7509-f4b9-f683385933f7@janustech.com>
Date: Wed, 8 Aug 2018 14:49:08 +0300
MIME-Version: 1.0
In-Reply-To: <w51in4lt6zv.fsf@maestria.local.igalia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 4/5] qcow2: Set the default
 cache-clean-interval to 30 seconds
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>

On 08/08/2018 02:47 PM, Alberto Garcia wrote:
> On Wed 08 Aug 2018 09:10:50 AM CEST, Leonid Bloch wrote:
>> The default cache-clean-interval is set to 30 seconds, in order to lower
>> the overhead of the qcow2 caches (before the default was 0, i.e.
>> disabled).
>>
>> Signed-off-by: Leonid Bloch <lbloch@janustech.com>
> 
> Reviewed-by: Alberto Garcia <berto@igalia.com>
> 
>> +#define DEFAULT_CACHE_CLEAN_INTERVAL 30  /* seconds */
> 
> I wonder if it shouldn't be a bit higher, though. Isn't 30 seconds too
> low for a default?

I also had this thought. What would you suggest?

Leonid.

> 
> Berto
> 
