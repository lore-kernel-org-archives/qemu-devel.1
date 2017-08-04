Received: from eggs.gnu.org ([2001:4830:134:3::10]:51439)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dddaR-0001H4-G9
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 10:29:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ddbHD-0003e5-No
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 08:04:23 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20170731095443.28211-2-el13635@mail.ntua.gr>
References: <20170731095443.28211-1-el13635@mail.ntua.gr>
	<20170731095443.28211-2-el13635@mail.ntua.gr>
Date: Fri, 04 Aug 2017 13:59:43 +0200
Message-ID: <w51r2wrv900.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v3 1/7] block: move ThrottleGroup
 membership to ThrottleGroupMember
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

On Mon 31 Jul 2017 11:54:37 AM CEST, Manos Pitsidianakis wrote:
> This commit eliminates the 1:1 relationship between BlockBackend and
> throttle group state.  Users will be able to create multiple throttle
> nodes, each with its own throttle group state, in the future.  The
> throttle group state cannot be per-BlockBackend anymore, it must be
> per-throttle node. This is done by gathering ThrottleGroup membership
> details from BlockBackendPublic into ThrottleGroupMember and refactoring
> existing code to use the structure.
>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Manos Pitsidianakis <el13635@mail.ntua.gr>

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
