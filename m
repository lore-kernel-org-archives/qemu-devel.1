Received: from eggs.gnu.org ([2001:4830:134:3::10]:42339)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eqxTc-0005jr-Al
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 03:52:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eqxTX-0008Lh-Oa
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 03:52:40 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54732 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eqxTX-0008LW-JZ
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 03:52:35 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F2DBA402290A
	for <qemu-devel@nongnu.org>; Wed, 28 Feb 2018 08:52:34 +0000 (UTC)
Date: Wed, 28 Feb 2018 16:52:29 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180228085229.GD27381@xz-mi>
References: <20180216131625.9639-1-dgilbert@redhat.com>
	<20180216131625.9639-14-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180216131625.9639-14-dgilbert@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 13/29] migration/ram:
 ramblock_recv_bitmap_test_byte_offset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, maxime.coquelin@redhat.com, marcandre.lureau@redhat.com, imammedo@redhat.com, mst@redhat.com, quintela@redhat.com, aarcange@redhat.com

On Fri, Feb 16, 2018 at 01:16:09PM +0000, Dr. David Alan Gilbert (git) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> 
> Utility for testing the map when you already know the offset
> in the RAMBlock.
> 
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

> ---
>  migration/ram.c | 5 +++++
>  migration/ram.h | 1 +
>  2 files changed, 6 insertions(+)
> 
> diff --git a/migration/ram.c b/migration/ram.c
> index 8333d8e35e..8db5e80500 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -169,6 +169,11 @@ int ramblock_recv_bitmap_test(RAMBlock *rb, void *host_addr)
>                      rb->receivedmap);
>  }
>  
> +bool ramblock_recv_bitmap_test_byte_offset(RAMBlock *rb, uint64_t byte_offset)
> +{
> +    return test_bit(byte_offset >> TARGET_PAGE_BITS, rb->receivedmap);
> +}
> +
>  void ramblock_recv_bitmap_set(RAMBlock *rb, void *host_addr)
>  {
>      set_bit_atomic(ramblock_recv_bitmap_offset(host_addr, rb), rb->receivedmap);
> diff --git a/migration/ram.h b/migration/ram.h
> index f3a227b4fc..63a37c4683 100644
> --- a/migration/ram.h
> +++ b/migration/ram.h
> @@ -60,6 +60,7 @@ int ram_postcopy_incoming_init(MigrationIncomingState *mis);
>  void ram_handle_compressed(void *host, uint8_t ch, uint64_t size);
>  
>  int ramblock_recv_bitmap_test(RAMBlock *rb, void *host_addr);
> +bool ramblock_recv_bitmap_test_byte_offset(RAMBlock *rb, uint64_t byte_offset);
>  void ramblock_recv_bitmap_set(RAMBlock *rb, void *host_addr);
>  void ramblock_recv_bitmap_set_range(RAMBlock *rb, void *host_addr, size_t nr);
>  
> -- 
> 2.14.3
> 

-- 
Peter Xu
