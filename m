Received: from eggs.gnu.org ([2001:4830:134:3::10]:39491)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1eFH1v-0004j8-0I
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 05:04:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1eFH1t-0006s7-SY
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 05:04:19 -0500
References: <1510654613-47868-1-git-send-email-anton.nefedov@virtuozzo.com>
	<20171116032622.GB14771@lemon>
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Message-ID: <1cce700e-2de3-65c8-71c9-bf395b9f39cf@virtuozzo.com>
Date: Thu, 16 Nov 2017 13:04:04 +0300
MIME-Version: 1.0
In-Reply-To: <20171116032622.GB14771@lemon>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/5] compressed block-stream
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, kwolf@redhat.com, mreitz@redhat.com, eblake@redhat.com, stefanha@redhat.com, den@virtuozzo.com

On 16/11/2017 6:26 AM, Fam Zheng wrote:
> On Tue, 11/14 13:16, Anton Nefedov wrote:
>> It might be useful to compress images during block-stream;
>> this way the user can merge compressed images of a backing chain and
>> the result will remain compressed.
> 
> I haven't looked at the patches yet so maybe the answer is obvious, but still:
> would the "compress" option be still necessary if what we have is
> blockdev-stream instead?
> 
> Fam
> 

Sorry, I can't see blockdev-stream available now. How that would be
different? Would it imply the blocks are pulled up to the top (active)
image?

Or did you mean block-commit? The option might be useful there as well,
and needs to be implemented separately

/Anton
