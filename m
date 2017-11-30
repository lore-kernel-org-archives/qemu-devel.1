Received: from eggs.gnu.org ([2001:4830:134:3::10]:56599)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eKROW-0005iX-Fc
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 11:09:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eKROS-0007Xx-FY
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 11:09:00 -0500
References: <20171130134159.9697-1-eblake@redhat.com>
	<20171130134159.9697-2-eblake@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <ecbf4f53-8094-658d-75b7-a7cda8a1ca08@redhat.com>
Date: Thu, 30 Nov 2017 17:08:51 +0100
MIME-Version: 1.0
In-Reply-To: <20171130134159.9697-2-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/3] net: Drop unusual use of do { } while
 (0);
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Jason Wang <jasowang@redhat.com>

On 30.11.2017 14:41, Eric Blake wrote:
> For a couple of macros in pcnet.c, we have to provide a new scope
> to avoid compiler warnings about declarations in the middle of a
> switch statement that aren't in a sub-scope.  But use of
> 'do { ... } while (0);' merely to provide that new scope is arcane
> overkill, compared to just using '{ ... }'.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  hw/net/pcnet.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>
