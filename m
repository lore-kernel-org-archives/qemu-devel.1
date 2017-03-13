Received: from eggs.gnu.org ([2001:4830:134:3::10]:38000)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cnSmo-00041i-3q
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 12:25:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cnSml-0006D8-0E
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 12:25:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55712)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1cnSmk-0006Cy-Qo
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 12:25:26 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E3806199548
	for <qemu-devel@nongnu.org>; Mon, 13 Mar 2017 16:25:25 +0000 (UTC)
Date: Mon, 13 Mar 2017 16:25:21 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170313162520.GD5512@work-vm>
References: <20170313124434.1043-1-quintela@redhat.com>
	<20170313124434.1043-5-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170313124434.1043-5-quintela@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 04/16] migration: Don't create
 decompression threads if not enabled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, amit.shah@redhat.com

* Juan Quintela (quintela@redhat.com) wrote:
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> 
> --
> 
> I removed the [HACK] part because previous patch just check that
> compression pages are not received.
> 
> Signed-off-by: Juan Quintela <quintela@redhat.com>

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  migration/ram.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/migration/ram.c b/migration/ram.c
> index 65419c1..aa51dbd 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -2306,6 +2306,9 @@ void migrate_decompress_threads_create(void)
>  {
>      int i, thread_count;
>  
> +    if (!migrate_use_compression()) {
> +        return;
> +    }
>      thread_count = migrate_decompress_threads();
>      decompress_threads = g_new0(QemuThread, thread_count);
>      decomp_param = g_new0(DecompressParam, thread_count);
> @@ -2327,6 +2330,9 @@ void migrate_decompress_threads_join(void)
>  {
>      int i, thread_count;
>  
> +    if (!migrate_use_compression()) {
> +        return;
> +    }
>      thread_count = migrate_decompress_threads();
>      for (i = 0; i < thread_count; i++) {
>          qemu_mutex_lock(&decomp_param[i].mutex);
> -- 
> 2.9.3
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
