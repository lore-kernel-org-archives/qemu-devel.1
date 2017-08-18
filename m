Received: from eggs.gnu.org ([2001:4830:134:3::10]:53308)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1didbX-0002PC-O2
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 05:30:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1didbR-0003o2-QD
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 05:30:11 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20170818090722.t4njxb6ubxvl2nsb@postretch>
References: <20170818031019.3723-1-el13635@mail.ntua.gr>
	<20170818031019.3723-6-el13635@mail.ntua.gr>
	<w51wp615loy.fsf@maestria.local.igalia.com>
	<20170818090722.t4njxb6ubxvl2nsb@postretch>
Date: Fri, 18 Aug 2017 11:30:02 +0200
Message-ID: <w51tw155ilh.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v5 5/6] block: add throttle block filter
 driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Manos Pitsidianakis <el13635@mail.ntua.gr>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-block <qemu-block@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>

On Fri 18 Aug 2017 11:07:22 AM CEST, Manos Pitsidianakis wrote:

>>> The driver can be used with the syntax
>>> -drive driver=throttle,file.filename=foo.qcow2, \
>>>         limits.iops-total=...,throttle-group=bar
>>
>>I had understood that we would get rid of the limits.* options in this
>>driver, or did I get it wrong?
>>
> I was going to send a patch after this was merged along with adding
> ThrottleGroups to the root container, to speed things up. Do you
> prefer to do this in this patch?

I'm not sure what's the benefit of adding a complete infrastructure that
you are going to remove immediately afterwards :-?

> The root container patch probably has to go to the 'remove legacy'
> series since adding it here means the name collision errors introduce
> error paths in block/block-backend.c that go away in that series, and
> that'd be a waste of effort.

Ok.

Berto
