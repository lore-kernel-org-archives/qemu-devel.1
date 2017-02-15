Received: from eggs.gnu.org ([2001:4830:134:3::10]:43703)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cdzSP-00028C-BW
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 08:17:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cdzSK-0000WV-D0
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 08:17:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53380)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1cdzSK-0000W6-7p
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 08:17:12 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 527137E9F5
	for <qemu-devel@nongnu.org>; Wed, 15 Feb 2017 13:17:12 +0000 (UTC)
Date: Wed, 15 Feb 2017 13:17:08 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170215131707.GF2731@work-vm>
References: <1487006388-7966-1-git-send-email-quintela@redhat.com>
	<1487006388-7966-3-git-send-email-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1487006388-7966-3-git-send-email-quintela@redhat.com>
Subject: Re: [Qemu-devel] [PULL 02/12] migration: Don't create decompression
 threads if not enabled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org

* Juan Quintela (quintela@redhat.com) wrote:
> Signed-off-by: Juan Quintela <quintela@redhat.com>

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

This can go in separately.

> --
> 
> I removed the [HACK] part because previous patch just check that
> compression pages are not received.
> ---
>  migration/ram.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/migration/ram.c b/migration/ram.c
> index 5817f8c..4422ee8 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -2251,6 +2251,9 @@ void migrate_decompress_threads_create(void)
>  {
>      int i, thread_count;
> 
> +    if (!migrate_use_compression()) {
> +        return;
> +    }
>      thread_count = migrate_decompress_threads();
>      decompress_threads = g_new0(QemuThread, thread_count);
>      decomp_param = g_new0(DecompressParam, thread_count);
> @@ -2272,6 +2275,9 @@ void migrate_decompress_threads_join(void)
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
> 2.7.4
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
