Received: from eggs.gnu.org ([2001:4830:134:3::10]:57019)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbutsykin@virtuozzo.com>) id 1dvN9B-0001IT-C0
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 08:33:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbutsykin@virtuozzo.com>) id 1dvN98-0006MN-7O
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 08:33:33 -0400
References: <20170922093926.9723-1-pbutsykin@virtuozzo.com>
	<20170922095007.GI12725@redhat.com>
From: Pavel Butsykin <pbutsykin@virtuozzo.com>
Message-ID: <feec0aee-291a-236e-bbf0-78eaa9f1d159@virtuozzo.com>
Date: Fri, 22 Sep 2017 15:33:18 +0300
MIME-Version: 1.0
In-Reply-To: <20170922095007.GI12725@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 0/2] Truncate the tail of the image file
 in qcow2 shrinking
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, kwolf@redhat.com, mreitz@redhat.com, den@openvz.org, jsnow@redhat.com

On 22.09.2017 12:50, Daniel P. Berrange wrote:
> On Fri, Sep 22, 2017 at 12:39:24PM +0300, Pavel Butsykin wrote:
>> Now after shrinking the qcow2 image, at the end of the image file, there might
>> be a tail that probably will never be used. Although it will not bring any
>> tangible benefit, we can cut the tail if it is. Yes, it will not free up disk
>> space, but if the blocks were be allocated sequentially and the image is not
>> heavily fragmented then the virtual size of the image file will be commensurate
>> with the real size. It also doesn't look like a great plus.. Well, at least we
>> can discuss it.
> 
> If the block backend has discard support enabled, can't we get the tail
> to be discarded rather than merely truncated ?


It has already been implemented. (see 
https://lists.gnu.org/archive/html/qemu-devel/2017-09/msg04581.html)
Sorry, I just forgot to mention that this patch rebased on Max's block
branch (https://github.com/XanClic/qemu/commits/block). Actually the
truncation will always be done on the already discarded area. It can
be useful only if the block backend doesn't support discard or a file
system doesn't support sparse files.

> Regards,
> Daniel
> 
