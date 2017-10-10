Received: from eggs.gnu.org ([2001:4830:134:3::10]:34049)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1e1w1u-0007oO-JZ
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 11:01:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1e1w1l-0004tf-G9
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 11:01:10 -0400
References: <20171009172723.190282-1-vsementsov@virtuozzo.com>
	<20171009172723.190282-18-vsementsov@virtuozzo.com>
	<24bd15b7-8119-4bb4-85f4-b5187a0339e2@redhat.com>
	<b76d7f71-914c-c059-0f08-4dc606db9533@virtuozzo.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <6266e2aa-1a24-3e67-5652-3105ce2a7e7e@redhat.com>
Date: Tue, 10 Oct 2017 17:00:46 +0200
MIME-Version: 1.0
In-Reply-To: <b76d7f71-914c-c059-0f08-4dc606db9533@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 10/10] nbd: Minimal structured read for
 client
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, eblake@redhat.com, den@openvz.org

On 10/10/2017 16:55, Vladimir Sementsov-Ogievskiy wrote:
> Hmm, would it be simpler just pass a function pointer, which should be
> called on each loop iteration?
> So, we will return to one common func nbd_co_receive_reply, but with two
> additional parameters: func and opaque?

Function pointers typically result in having to pass the state around in
a structure, for all the callers.

An iterator also has to package the state in a structure, but it is only
done once.

So function pointers would be simpler in the beginning, but would not
scale as well.

Paolo
