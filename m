Received: from eggs.gnu.org ([2001:4830:134:3::10]:40229)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dwmiv-00079W-2m
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 06:04:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dwmiq-0002YZ-Ue
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 06:04:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43412)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dwmiq-0002YD-P6
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 06:04:12 -0400
Date: Tue, 26 Sep 2017 12:04:05 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170926120405.2b925351.cohuck@redhat.com>
In-Reply-To: <20170922140338.6068-1-david@redhat.com>
References: <20170922140338.6068-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] s390x/kvm: fix and cleanup storing CPU
 status
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, thuth@redhat.com, Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>

On Fri, 22 Sep 2017 16:03:38 +0200
David Hildenbrand <david@redhat.com> wrote:

> env->psa is a 64bit value, while we copy 4 bytes into the save area,
> resulting always in 0 getting stored.
> 
> Let's try to reduce such errors by using a proper structure. While at
> it, use correct cpu->be conversion (and get_psw_mask()), as we will be
> reusing this code for TCG soon.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
> 
> v1 -> v2:
>  - dropped QEMU_PACKED
>  - Moved QEMU_BUILD_BUG_ON()
>  - Retested if it works now

Testing? What's going on here? :)

> 
>  target/s390x/kvm.c | 62 ++++++++++++++++++++++++++++++++++++------------------
>  1 file changed, 42 insertions(+), 20 deletions(-)

Thanks, applied.
