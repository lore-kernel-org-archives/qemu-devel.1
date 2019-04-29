Received: from eggs.gnu.org ([209.51.188.92]:43422)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hL5IN-0007ZR-NE
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 08:22:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hL5IL-0000Yl-Go
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 08:22:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52274)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hL5IK-0000Xi-U6
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 08:22:05 -0400
Date: Mon, 29 Apr 2019 13:21:59 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20190429122159.GF2748@work-vm>
References: <20190426090730.2691-1-chen.zhang@intel.com>
	<20190426090730.2691-3-chen.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190426090730.2691-3-chen.zhang@intel.com>
Subject: Re: [Qemu-devel] [PATCH 2/3] migration/colo.h: Remove obsolete codes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Zhang Chen <chen.zhang@intel.com>
Cc: Laurent Vivier <laurent@vivier.eu>, Juan Quintela <quintela@redhat.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>, Markus Armbruster <armbru@redhat.com>, qemu-dev <qemu-devel@nongnu.org>, Zhang Chen <zhangckid@gmail.com>

* Zhang Chen (chen.zhang@intel.com) wrote:
> From: Zhang Chen <chen.zhang@intel.com>
> 
> Signed-off-by: Zhang Chen <chen.zhang@intel.com>

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  include/migration/colo.h | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/include/migration/colo.h b/include/migration/colo.h
> index ddebe0ad27..f6fbe23ec9 100644
> --- a/include/migration/colo.h
> +++ b/include/migration/colo.h
> @@ -22,8 +22,6 @@ enum colo_event {
>      COLO_EVENT_FAILOVER,
>  };
>  
> -void colo_info_init(void);
> -
>  void migrate_start_colo_process(MigrationState *s);
>  bool migration_in_colo_state(void);
>  
> -- 
> 2.17.GIT
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
