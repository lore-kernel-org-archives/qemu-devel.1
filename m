Received: from eggs.gnu.org ([209.51.188.92]:57170)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ghFsF-0008Hh-SN
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 10:34:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ghFsE-0004rN-Gd
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 10:34:31 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20190109110144.18633-1-stefanha@redhat.com>
References: <20190109110144.18633-1-stefanha@redhat.com>
Date: Wed, 09 Jan 2019 16:34:10 +0100
Message-ID: <w51pnt57slp.fsf@maestria.local.igalia.com>
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
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>

On Wed 09 Jan 2019 12:01:44 PM CET, Stefan Hajnoczi wrote:
> The following QMP command leads to a crash when iothreads are used:
>
>   { 'execute': 'device_del', 'arguments': {'id': 'data'} }

How did you reproduce this? Do you have a test case?

Berto
