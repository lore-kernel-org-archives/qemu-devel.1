Received: from eggs.gnu.org ([2001:4830:134:3::10]:44648)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lbloch@janustech.com>) id 1fniYs-0003F2-NO
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 06:53:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lbloch@janustech.com>) id 1fniYr-0004MI-Nv
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 06:52:58 -0400
References: <20180808221138.5770-1-lbloch@janustech.com>
	<20180808221138.5770-5-lbloch@janustech.com>
	<w51woszc2b1.fsf@maestria.local.igalia.com>
From: Leonid Bloch <lbloch@janustech.com>
Message-ID: <be69de56-51b2-de63-a4ae-c5345a8dcce4@janustech.com>
Date: Thu, 9 Aug 2018 13:52:34 +0300
MIME-Version: 1.0
In-Reply-To: <w51woszc2b1.fsf@maestria.local.igalia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 4/5] qcow2: Set the default
 cache-clean-interval to 10 minutes
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

On 8/9/18 12:33 PM, Alberto Garcia wrote:
> On Thu 09 Aug 2018 12:11:37 AM CEST, Leonid Bloch wrote:
>> The default cache-clean-interval is set to 10 minutes, in order to lower
>> the overhead of the qcow2 caches (before the default was 0, i.e.
>> disabled).
>>
>> Signed-off-by: Leonid Bloch <lbloch@janustech.com>
> 
>> --- a/qapi/block-core.json
>> +++ b/qapi/block-core.json
>> @@ -2830,7 +2830,8 @@
>>   #
>>   # @cache-clean-interval:  clean unused entries in the L2 and refcount
>>   #                         caches. The interval is in seconds. The default value
>> -#                         is 0 and it disables this feature (since 2.5)
>> +#                         is 600. Setting 0 disables this feature. (since 2.5)
>> +#
> 
> It should be "Setting it to 0 ...".

How about:

"... is 600 (0 disables this feature). (since 2.5)"?

... To avoid the extra line. That's why I skipped the "it to" as well. 
Alternatively, maybe we can skip the defaults altogether in this file, 
just as with all the other qcow2 options there?

Leonid.

> 
> With that corrected,
> 
> Reviewed-by: Alberto Garcia <berto@igalia.com>
> 
> Berto
> 
