Received: from eggs.gnu.org ([209.51.188.92]:45697)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gjQ2M-0001z3-QM
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 09:49:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gjQ2L-0003Iy-LE
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 09:49:54 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20190115141800.GB29056@stefanha-x1.localdomain>
References: <w51pnt57slp.fsf@maestria.local.igalia.com>
	<w51tvifqqlr.fsf@maestria.local.igalia.com>
	<20190111132416.GI5010@dhcp-200-186.str.redhat.com>
	<w51pnt3qo27.fsf@maestria.local.igalia.com>
	<20190114133553.GE7038@stefanha-x1.localdomain>
	<w51won7480o.fsf@maestria.local.igalia.com>
	<20190114161525.GA32304@stefanha-x1.localdomain>
	<w51zhs32ojb.fsf@maestria.local.igalia.com>
	<20190114163117.GA521@stefanha-x1.localdomain>
	<w51h8eb7ybn.fsf@maestria.local.igalia.com>
	<20190115141800.GB29056@stefanha-x1.localdomain>
Date: Tue, 15 Jan 2019 15:49:25 +0100
Message-ID: <w515zuq562y.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] throttle-groups: fix restart
 coroutine iothread race
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On Tue 15 Jan 2019 03:18:00 PM CET, Stefan Hajnoczi wrote:
>> So if my understanding is correct QEMU can be shut down when there
>> are iothreads waiting for a mutex. Is that something that we should
>> be worried about?
>
> Nothing joins the iothreads in vl.c:main().
>
> The assumption is that anything using iothreads will detach from them.
> For example, the vm runstate changes during shutdown so devices can
> disable the iothread code path (and this involves draining in-flight
> requests).
>
> My fix effectively does this by waiting for in-flight throttling
> restart coroutines.

Yeah, it's clear in the case of your fix. Thanks!

Berto
