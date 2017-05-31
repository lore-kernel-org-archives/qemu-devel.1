Received: from eggs.gnu.org ([2001:4830:134:3::10]:39424)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbutsykin@virtuozzo.com>) id 1dG7bT-0005mF-3B
	for qemu-devel@nongnu.org; Wed, 31 May 2017 13:40:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbutsykin@virtuozzo.com>) id 1dG7bP-0007jY-RH
	for qemu-devel@nongnu.org; Wed, 31 May 2017 13:40:15 -0400
References: <20170531144331.30173-1-pbutsykin@virtuozzo.com>
	<5e241222-95e1-3f7e-7fce-76e7e9a06c8c@redhat.com>
	<a3ee5a6d-b16f-c4fd-b66e-da80d06f30a9@virtuozzo.com>
	<20170531161026.GG27432@redhat.com>
From: Pavel Butsykin <pbutsykin@virtuozzo.com>
Message-ID: <edb2b2f4-03bc-229f-ffad-b0cc4db0b672@virtuozzo.com>
Date: Wed, 31 May 2017 20:39:58 +0300
MIME-Version: 1.0
In-Reply-To: <20170531161026.GG27432@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/2] Add reduce image for qcow2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Richard W.M. Jones" <rjones@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org, kwolf@redhat.com, armbru@redhat.com, mreitz@redhat.com


On 31.05.2017 19:10, Richard W.M. Jones wrote:
> On Wed, May 31, 2017 at 06:54:33PM +0300, Pavel Butsykin wrote:
>> It is assumed that the user has already made a preparatory with the
>> image:
>> 1. freeing space at the end of the image
>> 2. reducing the last partition on the disk
>> 3. rebuilding fs
>> Only after these steps, the user can reduce the image by qemu-img.
> 
> It's tricky with GPT, as GPT puts a second copy of the header in the
> last few sectors of the disk.  I always advise people to use trim (or
> virt-sparsify) instead of trying to adjust virtual disk size.

virt-sparsify is a very useful utility, I use it too :) I agree that the
trim is much better if the goal is only to free up space on the host
disk. But there's another goal is to limit further growth of the image.

> 
> Nevertheless I don't think we should prevent shrinking qcow2 virtual
> size.  It's likely useful to someone.
> 
> Rich.
> 
