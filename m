Received: from eggs.gnu.org ([2001:4830:134:3::10]:57363)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1df6KQ-0004bx-Il
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 11:21:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1df6KL-0002NV-Ls
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 11:21:54 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <9e8e9540-8644-af56-b658-932bc4b0f514@redhat.com>
References: <20170807161529.3779-1-berto@igalia.com>
	<20170808100030.GB16801@stefanha-x1.localdomain>
	<9e8e9540-8644-af56-b658-932bc4b0f514@redhat.com>
Date: Tue, 08 Aug 2017 17:21:45 +0200
Message-ID: <w51k22ejd9y.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH for-2.10] throttle: Make LeakyBucket.avg
 and LeakyBucket.max integer types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>

On Tue 08 Aug 2017 05:11:27 PM CEST, Eric Blake wrote:
>> Why is this marked for-2.10?  Does it fix a bug?
>
> Theoretically, converting between int64_t and double loses precision
> on any values larger than 2^53.  In all practicality, though, if you
> expect throttling to be precise through 2^53 (approximately 16 orders
> of magnitude), you're crazy.

You cannot, THROTTLE_VALUE_MAX is set to 10^15, which is smaller than
2^50.

> So I'm also having a hard time seeing this as 2.10 material.

Right, as I said that was a wrong assumption from my side :) No need for
this in 2.10.

Berto
