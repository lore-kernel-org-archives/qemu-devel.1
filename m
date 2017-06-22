Received: from eggs.gnu.org ([2001:4830:134:3::10]:47346)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbutsykin@virtuozzo.com>) id 1dO4xQ-0002H8-J7
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 12:27:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbutsykin@virtuozzo.com>) id 1dO4xM-0004ZF-Mo
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 12:27:48 -0400
References: <20170613121639.17853-1-pbutsykin@virtuozzo.com>
	<20170613121639.17853-2-pbutsykin@virtuozzo.com>
	<b5367763-781e-0fdc-b9e7-fa6ee44ce66b@redhat.com>
	<e0966061-964c-95c5-20b2-904d651609dc@virtuozzo.com>
	<20170622144950.GB4353@noname.redhat.com>
From: Pavel Butsykin <pbutsykin@virtuozzo.com>
Message-ID: <20bfbb06-6813-5e1e-c487-63b465538d2c@virtuozzo.com>
Date: Thu, 22 Jun 2017 19:26:46 +0300
MIME-Version: 1.0
In-Reply-To: <20170622144950.GB4353@noname.redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 1/4] qemu-img: add --shrink flag for
 resize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org, eblake@redhat.com, armbru@redhat.com, den@openvz.org

On 22.06.2017 17:49, Kevin Wolf wrote:
> Am 22.06.2017 um 15:54 hat Pavel Butsykin geschrieben:
>> On 22.06.2017 01:17, Max Reitz wrote:
>>> On 2017-06-13 14:16, Pavel Butsykin wrote:
>>>> The flag as additional precaution of data loss. Perhaps in the future the
>>>> operation shrink without this flag will be banned, but while we need to
>>>> maintain compatibility.
>>>>
>>>> Signed-off-by: Pavel Butsykin <pbutsykin@virtuozzo.com>
> 
>>> The functional changes look good to me; even though I'd rather have it
>>> an error for qcow2 now (even if that means having to check the image
>>> format in img_resize(), and being inconsistent because you wouldn't need
>>> --shrink for raw, but for qcow2 you would). But, well, I'm not going to
>>> stop this series over that.
>>>
>>
>> Why shrink for qcow2 image is dangerous, but for raw is not dangerous? I
>> think we should provide the same behavior for all formats. When --shrink
>> option will become necessary, it also should be the same for all image
>> formats.
> 
> It is dangerous for both, but for raw we can't enforce the flag
> immediately without a deprecation period. With qcow2 we can (because it
> is new functionality), so we might as well enforce it from the start.
>

Ah, exactly. I like the offer to print the warning for raw and enforce
the flag for other formats.

> Kevin
> 
