Received: from eggs.gnu.org ([209.51.188.92]:38540)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gmKkn-00014d-4E
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 10:47:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gmKkm-0007sL-An
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 10:47:49 -0500
References: <cover.1548171741.git.berto@igalia.com>
	<6ad371df66eecffccce29a0bd14695f40edd6120.1548171741.git.berto@igalia.com>
	<735410dc-a63e-6a28-4526-2caa810a797d@redhat.com>
	<w518szbmmw9.fsf@maestria.local.igalia.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b3e3cb90-32a6-77b0-1c5b-8281181c8ae8@redhat.com>
Date: Wed, 23 Jan 2019 16:47:30 +0100
MIME-Version: 1.0
In-Reply-To: <w518szbmmw9.fsf@maestria.local.igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 3/3] virtio-scsi: Forbid devices with
 different iothreads sharing a blockdev
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

On 23/01/19 16:09, Alberto Garcia wrote:
> On Wed 23 Jan 2019 10:46:54 AM CET, Paolo Bonzini wrote:
>> On 22/01/19 16:53, Alberto Garcia wrote:
>>> This patch forbids attaching a disk to a SCSI device if its using a
>>> different AioContext. Test case included.
>>>
>>> Signed-off-by: Alberto Garcia <berto@igalia.com>
>>
>> Should this be handled in common code?  However, everything else looks
>> good.  Thanks!
> 
> You mean a common function with the code below?
> 
>>> +        ctx = blk_get_aio_context(sd->conf.blk);
>>> +        if (ctx != s->ctx && ctx != qemu_get_aio_context()) {
>>> +            error_setg(errp, "Cannot attach a blockdev that is using "
>>> +                       "a different iothread");
>>> +            return;
>>> +        }
> 
> Who else would be the user?

If it isn't, probably virtio-blk should be using too.

Paolo
