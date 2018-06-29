Received: from eggs.gnu.org ([2001:4830:134:3::10]:57420)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fYqkT-0003In-O4
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 06:35:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fYqkQ-0007sg-L3
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 06:35:29 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56366 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fYqkQ-0007rH-GV
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 06:35:26 -0400
Date: Fri, 29 Jun 2018 11:35:21 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180629103521.GF2568@work-vm>
References: <1528445443-43406-1-git-send-email-wei.w.wang@intel.com>
	<1528445443-43406-6-git-send-email-wei.w.wang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1528445443-43406-6-git-send-email-wei.w.wang@intel.com>
Subject: Re: [Qemu-devel] [PATCH v8 5/6] migration: move migrate_postcopy()
 to include/migration/misc.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Wang <wei.w.wang@intel.com>
Cc: qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, mst@redhat.com, quintela@redhat.com, peterx@redhat.com, pbonzini@redhat.com, liliang.opensource@gmail.com, yang.zhang.wz@gmail.com, quan.xu0@gmail.com, nilal@redhat.com, riel@redhat.com

* Wei Wang (wei.w.wang@intel.com) wrote:
> The ram save state notifier callback, for example the free page
> optimization offerred by virtio-balloon, may need to check if
> postcopy is in use, so move migrate_postcopy() to the outside header.

Reasonable,


Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> Signed-off-by: Wei Wang <wei.w.wang@intel.com>
> CC: Dr. David Alan Gilbert <dgilbert@redhat.com>
> CC: Juan Quintela <quintela@redhat.com>
> CC: Michael S. Tsirkin <mst@redhat.com>
> CC: Peter Xu <peterx@redhat.com>
> ---
>  include/migration/misc.h | 1 +
>  migration/migration.h    | 2 --
>  2 files changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/include/migration/misc.h b/include/migration/misc.h
> index b970d7d..911aaf3 100644
> --- a/include/migration/misc.h
> +++ b/include/migration/misc.h
> @@ -109,6 +109,7 @@ bool migration_has_failed(MigrationState *);
>  /* ...and after the device transmission */
>  bool migration_in_postcopy_after_devices(MigrationState *);
>  void migration_global_dump(Monitor *mon);
> +bool migrate_postcopy(void);
>  
>  /* migration/block-dirty-bitmap.c */
>  void dirty_bitmap_mig_init(void);
> diff --git a/migration/migration.h b/migration/migration.h
> index 5a74740..fee5af8 100644
> --- a/migration/migration.h
> +++ b/migration/migration.h
> @@ -236,8 +236,6 @@ bool migration_is_blocked(Error **errp);
>  bool migration_in_postcopy(void);
>  MigrationState *migrate_get_current(void);
>  
> -bool migrate_postcopy(void);
> -
>  bool migrate_release_ram(void);
>  bool migrate_postcopy_ram(void);
>  bool migrate_zero_blocks(void);
> -- 
> 1.8.3.1
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
