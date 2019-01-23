Received: from eggs.gnu.org ([209.51.188.92]:56822)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gmK9V-00008H-0Q
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 10:09:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gmK9S-0000BN-9s
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 10:09:16 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <735410dc-a63e-6a28-4526-2caa810a797d@redhat.com>
References: <cover.1548171741.git.berto@igalia.com>
	<6ad371df66eecffccce29a0bd14695f40edd6120.1548171741.git.berto@igalia.com>
	<735410dc-a63e-6a28-4526-2caa810a797d@redhat.com>
Date: Wed, 23 Jan 2019 16:09:10 +0100
Message-ID: <w518szbmmw9.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
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
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

On Wed 23 Jan 2019 10:46:54 AM CET, Paolo Bonzini wrote:
> On 22/01/19 16:53, Alberto Garcia wrote:
>> This patch forbids attaching a disk to a SCSI device if its using a
>> different AioContext. Test case included.
>> 
>> Signed-off-by: Alberto Garcia <berto@igalia.com>
>
> Should this be handled in common code?  However, everything else looks
> good.  Thanks!

You mean a common function with the code below?

>> +        ctx = blk_get_aio_context(sd->conf.blk);
>> +        if (ctx != s->ctx && ctx != qemu_get_aio_context()) {
>> +            error_setg(errp, "Cannot attach a blockdev that is using "
>> +                       "a different iothread");
>> +            return;
>> +        }

Who else would be the user?

Berto
