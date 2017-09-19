Received: from eggs.gnu.org ([2001:4830:134:3::10]:48239)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1duEan-0002sy-EB
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 05:13:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1duEak-0007h7-AF
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 05:13:21 -0400
Date: Tue, 19 Sep 2017 10:13:04 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170919091304.GA22797@stefanha-x1.localdomain>
References: <20170918214649.17550-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170918214649.17550-1-eblake@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] nbd-client: Use correct macro
 parenthesization
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, "open list:Network Block Dev..." <qemu-block@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

On Mon, Sep 18, 2017 at 04:46:49PM -0500, Eric Blake wrote:
> If 'bs' is a complex expression, we were only casting the front half
> rather than the full expression.  Luckily, none of the callers were
> passing bad arguments, but it's better to be robust up front.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
> 
> I plan to take this through my NBD queue, unless it is picked up
> by qemu-trivial first...
> 
>  block/nbd-client.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
