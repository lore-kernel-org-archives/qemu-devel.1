Received: from eggs.gnu.org ([209.51.188.92]:35491)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hBj1p-0003ey-J6
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 12:46:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hBj1o-0001YU-KF
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 12:46:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45110)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hBj1o-0001M8-Af
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 12:46:20 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3220C30821EC
	for <qemu-devel@nongnu.org>; Wed,  3 Apr 2019 16:46:18 +0000 (UTC)
Date: Wed, 3 Apr 2019 17:46:14 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20190403164613.GF2790@work-vm>
References: <20190403114958.3705-1-quintela@redhat.com>
	<20190403114958.3705-3-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190403114958.3705-3-quintela@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 2/8] migration: fix multifd_recv event
 typo
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Eric Blake <eblake@redhat.com>, Thomas Huth <thuth@redhat.com>

* Juan Quintela (quintela@redhat.com) wrote:
> It uses num in multifd_send().  Make it coherent.
> 
> Signed-off-by: Juan Quintela <quintela@redhat.com>

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  migration/trace-events | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/migration/trace-events b/migration/trace-events
> index de2e136e57..cd50a1e659 100644
> --- a/migration/trace-events
> +++ b/migration/trace-events
> @@ -80,7 +80,7 @@ get_queued_page_not_dirty(const char *block_name, uint64_t tmp_offset, unsigned
>  migration_bitmap_sync_start(void) ""
>  migration_bitmap_sync_end(uint64_t dirty_pages) "dirty_pages %" PRIu64
>  migration_throttle(void) ""
> -multifd_recv(uint8_t id, uint64_t packet_num, uint32_t used, uint32_t flags, uint32_t next_packet_size) "channel %d packet number %" PRIu64 " pages %d flags 0x%x next packet size %d"
> +multifd_recv(uint8_t id, uint64_t packet_num, uint32_t used, uint32_t flags, uint32_t next_packet_size) "channel %d packet_num %" PRIu64 " pages %d flags 0x%x next packet size %d"
>  multifd_recv_sync_main(long packet_num) "packet num %ld"
>  multifd_recv_sync_main_signal(uint8_t id) "channel %d"
>  multifd_recv_sync_main_wait(uint8_t id) "channel %d"
> -- 
> 2.20.1
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
