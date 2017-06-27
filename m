Received: from eggs.gnu.org ([2001:4830:134:3::10]:43754)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dPplt-0001Av-V3
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 08:39:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dPplq-0006as-OE
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 08:39:10 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20170623124700.1389-3-el13635@mail.ntua.gr>
References: <20170623124700.1389-1-el13635@mail.ntua.gr>
	<20170623124700.1389-3-el13635@mail.ntua.gr>
Date: Tue, 27 Jun 2017 14:39:04 +0200
Message-ID: <w518tkdzjtj.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH RFC v3 2/8] block: Add aio_context field in
 ThrottleGroupMember
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Manos Pitsidianakis <el13635@mail.ntua.gr>, qemu-devel <qemu-devel@nongnu.org>
Cc: qemu-block <qemu-block@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>

On Fri 23 Jun 2017 02:46:54 PM CEST, Manos Pitsidianakis wrote:
> timer_cb() needs to know about the current Aio context of the throttle
> request that is woken up. In order to make ThrottleGroupMember backend
> agnostic, this information is stored in an aio_context field instead of
> accessing it from BlockBackend.
>
> Signed-off-by: Manos Pitsidianakis <el13635@mail.ntua.gr>

I agree with Stefan's comments, otherwise the patch looks good to me.

Berto
