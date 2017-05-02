Received: from eggs.gnu.org ([2001:4830:134:3::10]:54366)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d5Xg6-0005bl-2A
	for qemu-devel@nongnu.org; Tue, 02 May 2017 09:17:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d5Xg2-0007qg-QG
	for qemu-devel@nongnu.org; Tue, 02 May 2017 09:17:18 -0400
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:32921)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d5Xg2-0007qO-M8
	for qemu-devel@nongnu.org; Tue, 02 May 2017 09:17:14 -0400
Received: by mail-qk0-x243.google.com with SMTP id o85so21270336qkh.0
	for <qemu-devel@nongnu.org>; Tue, 02 May 2017 06:17:14 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170426183721.7482-1-dgilbert@redhat.com>
	<20170426183721.7482-3-dgilbert@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <88f22fc5-4dd6-f181-5d2e-40a6f17c07cd@amsat.org>
Date: Tue, 2 May 2017 10:17:10 -0300
MIME-Version: 1.0
In-Reply-To: <20170426183721.7482-3-dgilbert@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 2/2] migration: Extra tracing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>, qemu-devel@nongnu.org, borntraeger@de.ibm.com, quintela@redhat.com, lvivier@redhat.com, peterx@redhat.com

On 04/26/2017 03:37 PM, Dr. David Alan Gilbert (git) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>
> A couple more traces that would have made fixing that postcopy
> bug a bit easier.
>
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  migration/ram.c        | 2 ++
>  migration/trace-events | 2 ++
>  2 files changed, 4 insertions(+)
>
> diff --git a/migration/ram.c b/migration/ram.c
> index b4ed41c725..3ac41ccaba 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -812,6 +812,7 @@ static int ram_save_page(RAMState *rs, PageSearchStatus *pss, bool last_stage)
>      ram_addr_t offset = pss->page << TARGET_PAGE_BITS;
>
>      p = block->host + offset;
> +    trace_ram_save_page(block->idstr, (uint64_t)offset, p);
>
>      /* In doubt sent page as normal */
>      bytes_xmit = 0;
> @@ -2614,6 +2615,7 @@ static int ram_load(QEMUFile *f, void *opaque, int version_id)
>                  ret = -EINVAL;
>                  break;
>              }
> +            trace_ram_load_loop(block->idstr, (uint64_t)addr, flags, host);
>          }
>
>          switch (flags & ~RAM_SAVE_FLAG_CONTINUE) {
> diff --git a/migration/trace-events b/migration/trace-events
> index b8f01a218c..5b8ccf301c 100644
> --- a/migration/trace-events
> +++ b/migration/trace-events
> @@ -69,8 +69,10 @@ migration_bitmap_sync_start(void) ""
>  migration_bitmap_sync_end(uint64_t dirty_pages) "dirty_pages %" PRIu64
>  migration_throttle(void) ""
>  ram_discard_range(const char *rbname, uint64_t start, size_t len) "%s: start: %" PRIx64 " %zx"
> +ram_load_loop(const char *rbname, uint64_t addr, int flags, void *host) "%s: addr: %" PRIx64 " flags: %x host: %p"
>  ram_load_postcopy_loop(uint64_t addr, int flags) "@%" PRIx64 " %x"
>  ram_postcopy_send_discard_bitmap(void) ""
> +ram_save_page(const char *rbname, uint64_t offset, void *host) "%s: offset: %" PRIx64 " host: %p"
>  ram_save_queue_pages(const char *rbname, size_t start, size_t len) "%s: start: %zx len: %zx"
>
>  # migration/migration.c
>
