Received: from eggs.gnu.org ([2001:4830:134:3::10]:36119)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dqGqY-00062n-F2
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 06:49:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dqGqT-0007ds-NP
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 06:49:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34454)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dqGqT-0007da-H8
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 06:49:09 -0400
Date: Fri, 8 Sep 2017 12:49:05 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170908124905.52a8de36.cohuck@redhat.com>
In-Reply-To: <22830b0b-d05d-22de-271c-f0aa9bca6b64@linux.vnet.ibm.com>
References: <20170905111645.18068-1-pasic@linux.vnet.ibm.com>
	<22830b0b-d05d-22de-271c-f0aa9bca6b64@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/5] add CCW indirect data access support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, qemu-devel@nongnu.org

On Fri, 8 Sep 2017 12:45:25 +0200
Halil Pasic <pasic@linux.vnet.ibm.com> wrote:

> The discussion seems to have settled down quite a bit. Since there weren't
> many complaints, I would like to opt for a v2 fixing the things pointed out
> during the review early next week (I was thinking Tuesday maybe some late birds
> are going to join in).
> 
> @Connie 
> ========
> 
> Does that sound reasonable or would you like more time for v1?

No, sounds good.

> 
> What do you think, would it make more sense to omit or to keep the testing
> stuff for v2 (I mean patch 5 and the kernel module in the cover letter)?

Can you maybe split this out? It makes it easier if you don't have to
go hunt in a cover letter.

> 
> You probably haven't found the time to look at have a glance at "s390x/css: drop
> data-check in interpretation" (http://patchwork.ozlabs.org/patch/810995/). We
> have said it would make some things more straight forward here, and I could
> drop that ugly TODO comment. I think it's quite straight-forward, and I would
> not mind having a decision on it before v2 or putting it as preparation into
> v2. What do you prefer?

It is marked for my attention. I don't know whether I find time to look
at it today, but probably early next week.
