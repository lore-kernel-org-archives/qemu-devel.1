Received: from eggs.gnu.org ([2001:4830:134:3::10]:53613)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dZb9P-00029m-3S
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 07:03:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dZb9L-0008Fs-PF
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 07:03:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45500)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dZb9L-0008FV-Ih
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 07:03:43 -0400
Date: Mon, 24 Jul 2017 13:03:35 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170724130335.3b3f6b47@gondolin>
In-Reply-To: <20170720123721.12366-1-david@redhat.com>
References: <20170720123721.12366-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 0/5] target/s390x: cpu model cleanups +
 improvements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, rth@twiddle.net, thuth@redhat.com, jjherne@linux.vnet.ibm.com, borntraeger@de.ibm.com

On Thu, 20 Jul 2017 14:37:16 +0200
David Hildenbrand <david@redhat.com> wrote:

> We want to reuse e.g. s390_get_feat_block() in tcg. Turns out, that
> set_bit_inv() doesn't work as expected on other architectures (if we
> want to expose the uint8_t[] based data to the VM later), so let's
> fix that.
> 
> Some other minor cleanups, including better baselining support if one
> of the MSA subfunctions part of a base model is missing.
> 
> v1 -> v2:
> - try to make the compiler not spit out warnings

It seems you were successful :)

> 
> David Hildenbrand (5):
>   target/s390x: drop BE_BIT()
>   target/s390x: indicate query subfunction in s390_fill_feat_block
>   target/s390x: introduce (test|set)_be_bit
>   s390x/kvm: better comment regarding zPCI feature availability
>   target/s390x: improve baselining if certain base features are missing
> 
>  target/s390x/cpu_features.c | 33 +++++++++++++++++++++++++++------
>  target/s390x/cpu_features.h |  9 ++++++++-
>  target/s390x/cpu_models.c   | 33 +++++++++++++++++++++++++++++++++
>  target/s390x/kvm.c          | 29 +++--------------------------
>  4 files changed, 71 insertions(+), 33 deletions(-)

I think this is still 2.10 material.

Thanks, queued to s390-next.
