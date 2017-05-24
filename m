Received: from eggs.gnu.org ([2001:4830:134:3::10]:44288)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dDX9k-0005uR-Ji
	for qemu-devel@nongnu.org; Wed, 24 May 2017 10:20:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dDX9e-0002gw-Ud
	for qemu-devel@nongnu.org; Wed, 24 May 2017 10:20:56 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <142326a3-eaa4-8333-9580-ae0063f8a876@redhat.com>
References: <cover.1495536228.git.berto@igalia.com>
	<142326a3-eaa4-8333-9580-ae0063f8a876@redhat.com>
Date: Wed, 24 May 2017 16:20:12 +0200
Message-ID: <w51shjutjz7.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 0/7] qcow2: Reduce the number of I/O ops
 when doing COW
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Denis V . Lunev" <den@openvz.org>, Anton Nefedov <anton.nefedov@virtuozzo.com>

On Tue 23 May 2017 04:36:52 PM CEST, Eric Blake wrote:

>> here's a patch series that rewrites the copy-on-write code in the
>> qcow2 driver to reduce the number of I/O operations.
>
> And it competes with Denis and Anton's patches:
> https://lists.gnu.org/archive/html/qemu-devel/2017-05/msg04547.html
>
> What plan of attack should we take on merging the best parts of these
> two series?

I took a look at that series and unless I overlooked something important
it seems that there's actually not that much overlap. Denis and Anton's
series deals with cluster preallocation and mine reduces the number of
I/O operations when there's a COW scenario. Most of my modifications are
in the peform_cow() function, but they barely touch that one.

I think we can review both separately, either of us can rebase our
series on top of the other, I don't expect big changes or conflicts.

Berto
