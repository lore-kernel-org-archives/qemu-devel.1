Received: from eggs.gnu.org ([2001:4830:134:3::10]:38562)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <pl@kamp.de>)
	id 1dAE9D-000095-Em
	for qemu-devel@nongnu.org; Mon, 15 May 2017 07:26:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pl@kamp.de>) id 1dAE98-0005IL-It
	for qemu-devel@nongnu.org; Mon, 15 May 2017 07:26:43 -0400
Received: from mx-v6.kamp.de ([2a02:248:0:51::16]:34137 helo=mx01.kamp.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pl@kamp.de>) id 1dAE98-0005HM-9v
	for qemu-devel@nongnu.org; Mon, 15 May 2017 07:26:38 -0400
References: <1494842563-6534-1-git-send-email-pl@kamp.de>
	<20170515105032.GD23262@lemon.lan>
From: Peter Lieven <pl@kamp.de>
Message-ID: <26b2441d-e80c-eeef-fba1-67b2529e9287@kamp.de>
Date: Mon, 15 May 2017 13:26:34 +0200
MIME-Version: 1.0
In-Reply-To: <20170515105032.GD23262@lemon.lan>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH] qemu-io: add drain/undrain cmd
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-block@nongnu.org, kwolf@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com

Am 15.05.2017 um 12:50 schrieb Fam Zheng:
> On Mon, 05/15 12:02, Peter Lieven wrote:
>> Hi Block developers,
>>
>> I would like to add a feature to Qemu to drain all traffic from a block so that
>> I can take external snaphosts without the risk to that in the middle of a write
>> operation. Its meant for cases where where QGA freeze/thaw is not available.
>>
>> For me its enough to have this through qemu-io, but Kevin asked me to check
>> if its not worth to have a stable API for it and present it via QMP/HMP.
>>
>> What are your thoughts?
> For debugging purpose or a "hacky" usage where you know what you are doing, it
> may be fine to have this. The only issue is it should be a separate flag, like
> BlockJob.user_paused.

How can I add, remove such a flag?

>
> What happens from guest perspective? In the case of virtio, the request queue is
> not handled and -ETIMEDOUT may happen. With IDE, I/O commands are still handled,
> the command is not effective (or rather the implementation is not complete).

That it only works with virtio is fine. However, the thing it does not work correctly
apply then also to all other users of the drained_begin/end functions, right?
As for the timeout I only plan to drain the device for about 1 second.

Thanks,
Peter
