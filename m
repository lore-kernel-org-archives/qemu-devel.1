Received: from eggs.gnu.org ([2001:4830:134:3::10]:50651)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gQ8cr-0000o7-6Y
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 05:23:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gQ8cn-0008JH-7Z
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 05:23:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48086)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1gQ8cn-0008Ik-2Y
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 05:23:49 -0500
Date: Fri, 23 Nov 2018 10:23:35 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20181123102334.GB2373@work-vm>
References: <20181122072028.22819-1-xiaoguangrong@tencent.com>
	<20181122072028.22819-2-xiaoguangrong@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181122072028.22819-2-xiaoguangrong@tencent.com>
Subject: Re: [Qemu-devel] [PATCH v3 1/5] bitops: introduce change_bit_atomic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: guangrong.xiao@gmail.com
Cc: pbonzini@redhat.com, mst@redhat.com, mtosatti@redhat.com, qemu-devel@nongnu.org, kvm@vger.kernel.org, peterx@redhat.com, wei.w.wang@intel.com, jiang.biao2@zte.com.cn, eblake@redhat.com, quintela@redhat.com, cota@braap.org, Xiao Guangrong <xiaoguangrong@tencent.com>

* guangrong.xiao@gmail.com (guangrong.xiao@gmail.com) wrote:
> From: Xiao Guangrong <xiaoguangrong@tencent.com>
> 
> It will be used by threaded workqueue
> 
> Signed-off-by: Xiao Guangrong <xiaoguangrong@tencent.com>

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  include/qemu/bitops.h | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/include/qemu/bitops.h b/include/qemu/bitops.h
> index 3f0926cf40..c522958852 100644
> --- a/include/qemu/bitops.h
> +++ b/include/qemu/bitops.h
> @@ -79,6 +79,19 @@ static inline void change_bit(long nr, unsigned long *addr)
>      *p ^= mask;
>  }
>  
> +/**
> + * change_bit_atomic - Toggle a bit in memory atomically
> + * @nr: Bit to change
> + * @addr: Address to start counting from
> + */
> +static inline void change_bit_atomic(long nr, unsigned long *addr)
> +{
> +    unsigned long mask = BIT_MASK(nr);
> +    unsigned long *p = addr + BIT_WORD(nr);
> +
> +    atomic_xor(p, mask);
> +}
> +
>  /**
>   * test_and_set_bit - Set a bit and return its old value
>   * @nr: Bit to set
> -- 
> 2.14.5
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
