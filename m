Received: from eggs.gnu.org ([2001:4830:134:3::10]:46947)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1etXuu-0007h0-T2
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 07:11:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1etXur-0002BV-Mh
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 07:11:32 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46800 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1etXur-0002BO-IL
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 07:11:29 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4083876FB9
	for <qemu-devel@nongnu.org>; Wed,  7 Mar 2018 12:11:29 +0000 (UTC)
Date: Wed, 7 Mar 2018 12:11:26 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180307121126.GS20201@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180307110010.2205-1-quintela@redhat.com>
	<20180307110010.2205-19-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180307110010.2205-19-quintela@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v10 18/24] migration: Add multifd traces
 for start/end thread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, lvivier@redhat.com, dgilbert@redhat.com, peterx@redhat.com

On Wed, Mar 07, 2018 at 12:00:04PM +0100, Juan Quintela wrote:
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>  migration/ram.c        | 6 ++++++
>  migration/trace-events | 4 ++++
>  2 files changed, 10 insertions(+)
> 

> diff --git a/migration/trace-events b/migration/trace-events
> index 76075c26bc..db88fa699f 100644
> --- a/migration/trace-events
> +++ b/migration/trace-events
> @@ -79,6 +79,10 @@ ram_save_page(const char *rbname, uint64_t offset, void *host) "%s: offset: 0x%"
>  ram_save_queue_pages(const char *rbname, size_t start, size_t len) "%s: start: 0x%zx len: 0x%zx"
>  multifd_send_sync_main(void) ""
>  multifd_recv_sync_main(void) ""
> +multifd_send_thread_start(int id) "%d"
> +multifd_send_thread_end(int id) "%d"
> +multifd_recv_thread_start(int id) "%d"
> +multifd_recv_thread_end(int id) "%d"

Seems these should have been 'uint8_t' rather than 'int', avoiding the
change of type in later patches


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
