Received: from eggs.gnu.org ([2001:4830:134:3::10]:44742)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dxudp-0007Vv-Mb
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 08:43:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dxudm-0007Kq-JB
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 08:43:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34548)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dxudm-0007KJ-Ca
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 08:43:38 -0400
Date: Fri, 29 Sep 2017 14:43:17 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170929144317.04a0955e.cohuck@redhat.com>
In-Reply-To: <20170927170027.8539-4-david@redhat.com>
References: <20170927170027.8539-1-david@redhat.com>
	<20170927170027.8539-4-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH RFC 3/3] s390x/tcg: make STFL store into
 the lowcore
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, thuth@redhat.com, Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <richard.henderson@linaro.org>
List-ID: <qemu-devel.nongnu.org>

On Wed, 27 Sep 2017 19:00:27 +0200
David Hildenbrand <david@redhat.com> wrote:

> Using virtual memory access is wrong and will soon include low-address
> protection checks, which is to be bypassed for STFL.
> 
> This was originally part of a bigger STFL(E) refactoring.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/helper.h      | 2 +-
>  target/s390x/misc_helper.c | 7 ++++++-
>  2 files changed, 7 insertions(+), 2 deletions(-)

Thanks, applied (with updated patch description).
