Received: from eggs.gnu.org ([2001:4830:134:3::10]:40274)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ebnZD-0002vH-3D
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 08:15:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ebnZ9-0005bG-7i
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 08:15:47 -0500
References: <1516188312-29612-1-git-send-email-pbonzini@redhat.com>
	<20180117125937.GB3860@localhost.localdomain>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <4eea3f98-4da1-5334-690d-b92f7f1b06fc@redhat.com>
Date: Wed, 17 Jan 2018 14:15:31 +0100
MIME-Version: 1.0
In-Reply-To: <20180117125937.GB3860@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 0/7] Call check and invalidate_cache
 from coroutine context
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com

On 17/01/2018 13:59, Kevin Wolf wrote:
> Am 17.01.2018 um 12:25 hat Paolo Bonzini geschrieben:
>> Check and invalidate_cache share some parts of the implementation
>> with the regular I/O path.  This is sometimes complicated because the
>> I/O path wants to use a CoMutex but that is not possible outside coroutine
>> context.  By moving things to coroutine context, we can remove special
>> cases.  In fact, invalidate_cache is already called from coroutine context
>> because incoming migration is placed in a coroutine.
>>
>> While at it, I'm including two patches from Stefan to rename the
>> bdrv_create callback to bdrv_co_create, because it is already called
>> from coroutine context.
> I'm using .bdrv_co_create for the QAPI type based function that will be
> used from QMP blockdev-create, so it would be good if we leave the
> legacy function with its old name or at least choose a different new
> name for it.

.bdrv_co_create_opts since it takes QemuOpts*?

Thanks,

Paolo
