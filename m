Received: from eggs.gnu.org ([2001:4830:134:3::10]:38822)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eCQs8-0003PL-T2
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 08:58:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eCQs5-00087l-Rj
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 08:58:28 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <dd350838-9132-e787-10b1-4cb200076ec9@virtuozzo.com>
References: <dd350838-9132-e787-10b1-4cb200076ec9@virtuozzo.com>
Date: Wed, 08 Nov 2017 14:58:23 +0100
Message-ID: <w51lgjgzxc0.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [Qemu-block] segfault in parallel blockjobs
 (iotest 30)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anton Nefedov <anton.nefedov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org, mreitz@redhat.com

On Tue 07 Nov 2017 05:19:41 PM CET, Anton Nefedov wrote:

> One more drainage-related thing.
> We have recently encountered an issue with parallel block jobs and it's
> not quite clear how to fix it properly, so would appreciate your ideas.
>
> The small attached tweak makes iotest 30 (-qcow2 -nocache) fail 10/10
> times on my machine.

I just wanted to quickly confirm that I can reproduce this in my system
too, I just checked QEMU v2.8 (when this was introduced) and it was
affected as well. Somehow we didn't detect this back in the day :(

I'll take a look.

Berto
