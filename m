Received: from eggs.gnu.org ([2001:4830:134:3::10]:50125)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ddcxs-0005I2-HC
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 09:49:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ddbor-00032w-8M
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 08:36:38 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20170731095443.28211-4-el13635@mail.ntua.gr>
References: <20170731095443.28211-1-el13635@mail.ntua.gr>
	<20170731095443.28211-4-el13635@mail.ntua.gr>
Date: Fri, 04 Aug 2017 14:35:04 +0200
Message-ID: <w51lgmzv7d3.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v3 3/7] block: tidy ThrottleGroupMember
 initializations
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

On Mon 31 Jul 2017 11:54:39 AM CEST, Manos Pitsidianakis wrote:
> Move the CoMutex and CoQueue inits inside throttle_group_register_tgm()
> which is called whenever a ThrottleGroupMember is initialized. There's
> no need for them to be separate.
>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Manos Pitsidianakis <el13635@mail.ntua.gr>

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
