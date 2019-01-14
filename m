Received: from eggs.gnu.org ([209.51.188.92]:57751)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gj54g-00042L-5v
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 11:26:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gj54f-0005TP-1z
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 11:26:54 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20190114161525.GA32304@stefanha-x1.localdomain>
References: <20190109110144.18633-1-stefanha@redhat.com>
	<w51pnt57slp.fsf@maestria.local.igalia.com>
	<w51tvifqqlr.fsf@maestria.local.igalia.com>
	<20190111132416.GI5010@dhcp-200-186.str.redhat.com>
	<w51pnt3qo27.fsf@maestria.local.igalia.com>
	<20190114133553.GE7038@stefanha-x1.localdomain>
	<w51won7480o.fsf@maestria.local.igalia.com>
	<20190114161525.GA32304@stefanha-x1.localdomain>
Date: Mon, 14 Jan 2019 17:26:48 +0100
Message-ID: <w51zhs32ojb.fsf@maestria.local.igalia.com>
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
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On Mon 14 Jan 2019 05:15:25 PM CET, Stefan Hajnoczi wrote:
>> > I've been able to reproduce this in an iotest, please see v2 of this
>> > series.
>> 
>> That iotest doesn't crash for me :-?
>
> Does my iotest pass for you?

Yes, it does. I'm trying to figure out why because if I run the QMP
commands by hand then it does crash.

Berto
