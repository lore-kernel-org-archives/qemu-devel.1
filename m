Received: from eggs.gnu.org ([209.51.188.92]:35996)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ghwik-0003Dm-D7
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 08:19:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ghwij-0000YO-Bd
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 08:19:34 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <w51pnt57slp.fsf@maestria.local.igalia.com>
References: <20190109110144.18633-1-stefanha@redhat.com>
	<w51pnt57slp.fsf@maestria.local.igalia.com>
Date: Fri, 11 Jan 2019 14:19:12 +0100
Message-ID: <w51tvifqqlr.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] throttle-groups: fix restart coroutine
 iothread race
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On Wed 09 Jan 2019 04:34:10 PM CET, Alberto Garcia wrote:
> On Wed 09 Jan 2019 12:01:44 PM CET, Stefan Hajnoczi wrote:
>> The following QMP command leads to a crash when iothreads are used:
>>
>>   { 'execute': 'device_del', 'arguments': {'id': 'data'} }
>
> How did you reproduce this? Do you have a test case?

Ok, I finally reproduced it, the patch looks good to me.

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
