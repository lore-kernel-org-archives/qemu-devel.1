Received: from eggs.gnu.org ([209.51.188.92]:34266)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ghHeq-0006VJ-9O
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 12:28:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ghHep-00018s-K4
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 12:28:48 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20190109150733.GF4867@localhost.localdomain>
References: <20190109142850.27727-1-berto@igalia.com>
	<20190109150733.GF4867@localhost.localdomain>
Date: Wed, 09 Jan 2019 18:28:41 +0100
Message-ID: <w51a7k9zqnq.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] block: Acquire the AioContext in
 guess_disk_lchs()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>, armbru@redhat.com

On Wed 09 Jan 2019 04:07:33 PM CET, Kevin Wolf wrote:
> This looks like the same thing that I talked about with Markus
> yesterday. He asked me where to put the acquire/release pair. My
> answer was that there is more than one way to do it, but I suspect
> that the realize functions of the devices may call the block layer
> more than once and putting the acquire/release there might be nicer.

Makes sense I guess, and it should be safe. I'll give it a try tomorrow
and send a new patch.

Berto
