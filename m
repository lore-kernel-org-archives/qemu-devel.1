Received: from eggs.gnu.org ([2001:4830:134:3::10]:35305)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gQLYs-0008O4-QB
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 19:12:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gQLYo-0001uY-CC
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 19:12:38 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:49079)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gQLYo-0001ts-7u
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 19:12:34 -0500
Date: Fri, 23 Nov 2018 19:12:31 -0500
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20181124001231.GE17229@flamenco>
References: <20181122072028.22819-1-xiaoguangrong@tencent.com>
	<20181122072028.22819-3-xiaoguangrong@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181122072028.22819-3-xiaoguangrong@tencent.com>
Subject: Re: [Qemu-devel] [PATCH v3 2/5] util: introduce threaded workqueue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: guangrong.xiao@gmail.com
Cc: pbonzini@redhat.com, mst@redhat.com, mtosatti@redhat.com, qemu-devel@nongnu.org, kvm@vger.kernel.org, dgilbert@redhat.com, peterx@redhat.com, wei.w.wang@intel.com, jiang.biao2@zte.com.cn, eblake@redhat.com, quintela@redhat.com, Xiao Guangrong <xiaoguangrong@tencent.com>

On Thu, Nov 22, 2018 at 15:20:25 +0800, guangrong.xiao@gmail.com wrote:
> +   /*
> +     * the bit in these two bitmaps indicates the index of the ＠requests

This @ is not ASCII, is it?

> +     * respectively. If it's the same, the corresponding request is free
> +     * and owned by the user, i.e, where the user fills a request. Otherwise,
> +     * it is valid and owned by the thread, i.e, where the thread fetches
> +     * the request and write the result.
> +     */
> +
> +    /* after the user fills the request, the bit is flipped. */
> +    uint64_t request_fill_bitmap QEMU_ALIGNED(SMP_CACHE_BYTES);
> +    /* after handles the request, the thread flips the bit. */
> +    uint64_t request_done_bitmap QEMU_ALIGNED(SMP_CACHE_BYTES);

Use DECLARE_BITMAP, otherwise you'll get type errors as David
pointed out.

Thanks,

		Emilio
