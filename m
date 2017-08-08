Received: from eggs.gnu.org ([2001:4830:134:3::10]:54063)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1df4Rw-0000K3-St
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 09:21:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1df4Rs-0007dr-0z
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 09:21:32 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20170731095443.28211-6-el13635@mail.ntua.gr>
References: <20170731095443.28211-1-el13635@mail.ntua.gr>
	<20170731095443.28211-6-el13635@mail.ntua.gr>
Date: Tue, 08 Aug 2017 15:13:36 +0200
Message-ID: <w51valyjj7j.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v3 5/7] block: add throttle block filter
 driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Manos Pitsidianakis <el13635@mail.ntua.gr>, qemu-devel <qemu-devel@nongnu.org>
Cc: Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, qemu-block <qemu-block@nongnu.org>

On Mon 31 Jul 2017 11:54:41 AM CEST, Manos Pitsidianakis wrote:
> block/throttle.c uses existing I/O throttle infrastructure inside a
> block filter driver. I/O operations are intercepted in the filter's
> read/write coroutines, and referred to block/throttle-groups.c
>
> The driver can be used with the syntax
> -drive driver=throttle,file.filename=foo.qcow2, \
>         limits.iops-total=...,throttle-group=bar

Sorry for not having noticed this earlier, but can't you define the
throttling group (and its limits) using -object throttle-group ... as
shown in the previous patch, and simply reference it here? Or would we
have two alternative ways of setting the throttling limits?

What happens if you have many -drive lines each one with a different set
of limits but with the same throttling group?

Berto
