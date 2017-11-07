Received: from eggs.gnu.org ([2001:4830:134:3::10]:41844)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eC1fN-0001E0-Nt
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 06:03:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eC1fI-0006Zm-5K
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 06:03:37 -0500
References: <20171107030912.23930-1-eblake@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b7e0530a-a776-94e8-9581-ea082cc36cf3@redhat.com>
Date: Tue, 7 Nov 2017 12:03:03 +0100
MIME-Version: 1.0
In-Reply-To: <20171107030912.23930-1-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/2] Optimize sparse reads over NBD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, vsementsov@virtuozzo.com

On 07/11/2017 04:09, Eric Blake wrote:
> When I first proposed the NBD extension of structured reads,
> it was in order to more efficiently read sparse files without
> sending lots of zeroes over the wire.  These two patches feel
> like a feature addition, and missed soft freeze, so I'm
> reluctant to include them in a 2.11 pull request; on the other
> hand, implementing structured replies without sparse reads is
> a rather incomplete feature addition even if it complies with
> the NBD spec.  Since structured replies is a new 2.11 feature,
> I could argue that it is a bug if the new feature does not go
> all the way to sparse reads.
> 
> I've posted this as two patches, but welcome opinions on whether
> it should be squashed into one.

I think I agree with pushing this to the next release.

Paolo

> Based-on: 20171107030236.23633-1-eblake@redhat.com
> ([PATCH 0/8] various NBD fixes for 2.11)
> 
> Eric Blake (2):
>   nbd/server: Implement sparse reads atop structured reply
>   nbd/server: Optimize final chunk of sparse read
> 
>  nbd/server.c     | 79 +++++++++++++++++++++++++++++++++++++++++++++++++++++---
>  nbd/trace-events |  1 +
>  2 files changed, 77 insertions(+), 3 deletions(-)
> 
