Received: from eggs.gnu.org ([209.51.188.92]:55516)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gyFFs-0001QL-Lr
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 07:21:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gyFFs-00051K-0d
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 07:21:08 -0500
Date: Mon, 25 Feb 2019 13:21:01 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190225132101.72a67e3b.cohuck@redhat.com>
In-Reply-To: <20190225115552.7534-3-david@redhat.com>
References: <20190225115552.7534-1-david@redhat.com>
	<20190225115552.7534-3-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 2/7] s390x/tcg: Simplify disassembler
 operands initialization
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, Thomas Huth <thuth@redhat.com>, Richard Henderson <rth@twiddle.net>

On Mon, 25 Feb 2019 12:55:47 +0100
David Hildenbrand <david@redhat.com> wrote:

> Let's simply initialization to 0.

"Let's simply zero-initialize the structure." ?

> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/translate.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
