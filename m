Received: from eggs.gnu.org ([2001:4830:134:3::10]:44068)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dVCOv-0007Oj-SJ
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 03:49:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dVCOv-0003vH-6r
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 03:49:37 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170711163748.17817-1-el13635@mail.ntua.gr>
Date: Wed, 12 Jul 2017 09:49:20 +0200
In-Reply-To: <20170711163748.17817-1-el13635@mail.ntua.gr> (Manos
	Pitsidianakis's message of "Tue, 11 Jul 2017 19:37:44 +0300")
Message-ID: <87tw2iaydb.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v4 0/4] block: Block driver callbacks fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Manos Pitsidianakis <el13635@mail.ntua.gr>
Cc: qemu-devel <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>, qemu-block <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

Manos Pitsidianakis <el13635@mail.ntua.gr> writes:

> This series makes implementing some of the bdrv_* callbacks easier for block
> filters by passing requests to bs->file if bs->drv doesn't implement it instead
> of failing, and adding default bdrv_co_get_block_status() implementations.
>
> This is based against Kevin Wolf's block branch, commit
> da4bd74d2450ab72a7c26bbabb10c6a287dd043e

Haven't seen BlockDriver member is_filter before.  Interesting.  It's
documentation

    /* set to true if the BlockDriver is a block filter */
    bool is_filter;

is seriously lacking.  What does it *mean* to be a block filter?  Which
block layer facilities are affected, and how?

Observation: driver "raw" is filter-like in the sense that all it does
is pass along method arguments and results.  Can't say whether that
makes it a filter in the sense of is_filter, because "the sense of
is_filter" is nebulous to me :)
