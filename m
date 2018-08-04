Received: from eggs.gnu.org ([2001:4830:134:3::10]:59037)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lbloch@janustech.com>) id 1flv7B-0006qe-3t
	for qemu-devel@nongnu.org; Sat, 04 Aug 2018 07:52:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lbloch@janustech.com>) id 1flv7A-00027z-Du
	for qemu-devel@nongnu.org; Sat, 04 Aug 2018 07:52:57 -0400
References: <20180729212744.23709-1-lbloch@janustech.com>
	<20180729212744.23709-4-lbloch@janustech.com>
	<w51ftzvlmfc.fsf@maestria.local.igalia.com>
From: Leonid Bloch <lbloch@janustech.com>
Message-ID: <af4dc507-0bfe-b5a8-5d4d-7ade7c673656@janustech.com>
Date: Sat, 4 Aug 2018 14:52:28 +0300
MIME-Version: 1.0
In-Reply-To: <w51ftzvlmfc.fsf@maestria.local.igalia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 3/6 for-3.0] qcow2: Options'
 documentation fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On 08/03/2018 02:27 PM, Alberto Garcia wrote:
> On Sun 29 Jul 2018 11:27:41 PM CEST, Leonid Bloch wrote:
>> Signed-off-by: Leonid Bloch <lbloch@janustech.com>
>> ---
>>   docs/qcow2-cache.txt |  9 ++++++---
>>   qapi/block-core.json |  6 +++---
>>   qemu-options.hx      | 15 +++++++++------
>>   3 files changed, 18 insertions(+), 12 deletions(-)
>>
>> diff --git a/docs/qcow2-cache.txt b/docs/qcow2-cache.txt
>> index 8a09a5cc5f..fd9a6911cc 100644
>> --- a/docs/qcow2-cache.txt
>> +++ b/docs/qcow2-cache.txt
>> @@ -112,9 +112,9 @@ command-line, or the 'blockdev-add' QMP command.
>>   
>>   There are three options available, and all of them take bytes:
>>   
>> -"l2-cache-size":         maximum size of the L2 table cache
>> -"refcount-cache-size":   maximum size of the refcount block cache
>> -"cache-size":            maximum size of both caches combined
>> +"l2-cache-size":         maximal size of the L2 table cache
>> +"refcount-cache-size":   maximal size of the refcount block cache
>> +"cache-size":            maximal size of both caches combined
> 
> Why is 'maximum' not clear in this context?

It seemed to me that it is grammatically incorrect, because maximum is a 
noun and maximal is an adjective. But after a quick check now I see that 
maximum can be used as an adjective as well, so indeed this change is 
not needed. Will update in the next version.

Thanks,
Leonid.

> 
> Otherwise the patch looks good to me.
> 
> Berto
> 
