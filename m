Received: from eggs.gnu.org ([2001:4830:134:3::10]:52096)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1d2dOa-0006hZ-RZ
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 08:47:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1d2dOX-0000cl-Nr
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 08:47:12 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <1877dc76-87e0-650c-d76a-44e6e7754a2b@redhat.com>
References: <20170406150148.zwjpozqtale44jfh@perseus.local>
	<da7174ff-38c1-07fd-96b6-fa9280524002@redhat.com>
	<382b0707-233d-ab05-e054-3da43617460d@redhat.com>
	<1877dc76-87e0-650c-d76a-44e6e7754a2b@redhat.com>
Date: Mon, 24 Apr 2017 14:46:32 +0200
Message-ID: <w511ssim0rb.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] proposed qcow2 extension: cluster reservations
 [was: [RFC] Proposed qcow2 extension: subcluster allocation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>

On Sat 22 Apr 2017 07:56:57 PM CEST, Max Reitz wrote:
>> So, if you got this far in reading, the question becomes whether
>> having a mode where you can mark a cluster as
>> mapping-reserved-but-unallocated has enough use case to be worth
>> pursuing, knowing that it will burn an incompatible feature bit; or
>> if it should be rolled into the subcluster proposal, or whether it's
>> not a feature that anyone needs after all.
>
> I just forgot that just saying !ALLOCATED will be enough, regardless
> of the ZERO flag... Yeah, subclusters will give us this for free, and
> I think it's therefore reasonable to just require them if you want
> this feature (preallocation with a backing file).

I agree with Max here.

Berto
