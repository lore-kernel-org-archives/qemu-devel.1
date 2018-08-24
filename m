Received: from eggs.gnu.org ([2001:4830:134:3::10]:55001)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ft7yb-0004VX-S8
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 05:01:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ft7yY-000139-NY
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 05:01:53 -0400
Date: Fri, 24 Aug 2018 11:01:43 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180824110143.4ea959e2.cohuck@redhat.com>
In-Reply-To: <20180822144039.5796-2-pavel.zbitskiy@gmail.com>
References: <20180822144039.5796-1-pavel.zbitskiy@gmail.com>
	<20180822144039.5796-2-pavel.zbitskiy@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 1/3] target/s390x: use regular spaces in
 translate.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Zbitskiy <pavel.zbitskiy@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, david@redhat.com, richard.henderson@linaro.org, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>

On Wed, 22 Aug 2018 10:40:37 -0400
Pavel Zbitskiy <pavel.zbitskiy@gmail.com> wrote:

> In a few places translate.c contains non-breaking spaces (0xc2 0xa0)
> instead of regular ones (0x20):
> 
>   7c 7c c2 a0 63 63
>   7c 7c 20    63 63
>   |  |        c  c
> 
> This confuses some text editors.

Fun :)

> 
> Signed-off-by: Pavel Zbitskiy <pavel.zbitskiy@gmail.com>
> ---
>  target/s390x/translate.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Thanks, applied.
